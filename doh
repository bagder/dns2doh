#!/usr/bin/perl

use Encode qw(encode);
use MIME::Base64 qw(encode_base64url decode_base64url);
use Socket qw(inet_pton AF_INET6 AF_INET);

sub help {
    print STDERR "Usage: doh [options] [host] [uri]\n",
        "Options:\n",
        " --A       encode a type A request (default)\n",
        " --AAAA    encode a type AAAA request\n",
        " --CNAME   encode a type CNAME request\n",
        " --NS      encode a type NS request\n",
        " --TXT     encode a type TXT request\n",
        " --TYPEnum (or --type=num)\n",
	"           encode a type <num> request (num in [1..65535])\n",
	"\n",
	"Notes:\n",
	" 1. ESNI data may appear as TXT records using prefix '_esni.'\n",
	"    or as TYPE65439 records using the host name without prefix.\n",
	" 2. Not all DOH servers accept queries which specify TYPE65439.\n",
	"\n";
    exit;
}

my %dnstype = (1 => "A",
               2 => "NS",
               5 => "CNAME",
	       16 => "TXT",
               28 => "AAAA");

my $host;
my $url;
my $type = 1; # default type is A
my $onlyq = 0; # set to 1 if only asking, not getting the answer
my $encode = 1; # default is base64 encode
while($ARGV[0]) {

    if($ARGV[0] eq "--A") {
        $type=1;
        shift @ARGV;
    }
    elsif($ARGV[0] eq "--AAAA") {
        $type=28;
        shift @ARGV;
    }
    elsif($ARGV[0] eq "--NS") {
        $type=2;
        shift @ARGV;
    }
    elsif($ARGV[0] eq "--CNAME") {
        $type=5;
        shift @ARGV;
    }
    elsif($ARGV[0] eq "--TXT") {
	$type=16;
	shift @ARGV;
    }
    elsif((($ARGV[0] =~ /^--TYPE([0-9]+)$/) ||
	   ($ARGV[0] =~ /^--type=([0-9]+)$/)) &&
	  (int($1) > 0) &&
	  (int($1) < 2**16)) {
	$type=int($1);
	shift @ARGV;
    }
    elsif(($ARGV[0] eq "--help") ||
          ($ARGV[0] eq "-h")) {
        help();
    }
    elsif(!$host) {
        $host = $ARGV[0];
        shift @ARGV;
    }
    elsif(!$url) {
        $url = $ARGV[0];
        shift @ARGV;        
    }
    else {
        help();
    }
}

if(!$host || !$url) {
    help();
}

sub hexdump {
    my ($raw, $title) = @_;
    my $i=0;

    if($title) {
        print "= $title\n";
    }
    my $s;
    for my $c (split(//, $raw)) {
        if(!($i%16)) {
            my $txt="\n";
            if($i) {
                $txt="  |$s|\n";
                $s="";
            }
            printf "%s%02x: ", $i?$txt:"", $i;
        }
        printf ("%02x ", ord($c));
        if((ord($c)>=32) && (ord($c)<127)) {
            $s .= $c;
        }
        else {
            $s .= '.';
        }
        $i++;
    }
    if($s) {
        my $left;
        if($i%16) {
            $left = ' ' x ((16-$i%16)*3);
        }
        print "$left  |$s|\n";
    }
    else {
        print "\n";
    }
}

sub QNAME {
    my ($h) = @_;
    my $raw;

    my @labels=split(/\./, $h);
    foreach my $l (@labels) {
        #print STDERR "Label: $l\n";
        $raw .= sprintf("%c", length($l));
        $raw .= $l;
    }
    $raw .= "\x00"; # end with a zero labeel
    return $raw;
}

my $qname = QNAME($host);
my $qnameptr =  sprintf("\xc0\x0c", $answers);
my $ancount = sprintf("\x00%c", $answers);
my $qdcount = sprintf("\x00%c", 1); # questions
my $qtype = sprintf("%c%c", $type >> 8, $type & 255);
my $ttl = pack 'N', $seconds;

my $header;

my $query_header = sprintf("\x00\x00". # ID
                           "\x01\x00". # |QR|   Opcode  |AA|TC|RD|RA|   Z    |   RCODE   |
                           $qdcount.   # QDCOUNT
                           "\x00\x00". # ANCOUNT
                           "\x00\x00". # NSCOUNT
                           "\x00\x00"); # ARCOUNT
my $question = sprintf("$qname".   # QNAME
                       "$qtype". # QTYPE
                       "\x00\x01");  # QCLASS

my $msg;

$header = $query_header;
$msg = "$header$question";

my $output = encode("iso-8859-1", "$msg");

open(CURL, "|curl -s --data-binary \@- -H 'Content-Type: application/dns-message' $url -o-");

print CURL $output;
close(CURL);


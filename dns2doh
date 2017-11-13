#!/usr/bin/perl

use Encode qw(encode);
use MIME::Base64 qw(encode_base64url);


if($ARGV[0] eq "--hex") {
    $showhex=1;
    shift @ARGV;
}

my $h = $ARGV[0];

# IPv4 only is fine to start with
my @dig=`dig +short $h`;

if(!$dig[0]) {
    # blank return: not found
    exit;
}

# dig[0] starts with names, then follows IP addresses
my $answers;
my @rdata;
foreach my $num (0 .. $#dig) {
    my $ipstr = $dig[$num];
    chomp $ipstr;

    if($ipstr =~ /[a-z]/i) {
        # skip lines with letters!
        next;
    }
    
    my $address = pack 'C4', split(/\./, $ipstr);
    push @rdata, $address;
    $answers++;
}

my $seconds = 55; # TODO: get the real

sub hexdump {
    my ($raw, $title) = @_;
    my $i=0;

    if($title) {
        print "= $title\n";
    }
    for my $c (split(//, $raw)) {
        printf "%s%02x: ", $i?"\n":"", $i if(!($i%16));
        printf ("%02x ", ord($c));
        $i++;
    }
    print "\n";
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

my $qname = QNAME($h);
my $qnameptr =  sprintf("\xc0\x0c", $answers);
my $ancount = sprintf("\x00%c", $answers);
my $qtype = sprintf("\x00%c", 1); # for now
my $ttl = pack 'N', $seconds;

my $header = sprintf("\x00\x00". # ID
                     "\x00\x01". # |QR|   Opcode  |AA|TC|RD|RA|   Z    |   RCODE   |
                     "\x00\x00". # QDCOUNT
                     $ancount. # ANCOUNT
                     "\x00\x00". # NSCOUNT
                     "\x00\x00"); # ARCOUNT
my $question = sprintf("$qname".   # QNAME
                       "$qtype". # QTYPE
                       "\x00\x01");  # QCLASS

foreach my $rd (@rdata) {
    my $len = length($rd);
    my $rdlen = pack 'n', $len;
    my $one .= sprintf("$qnameptr". # QNAME (pointer)
                       "$qtype".    # QTYPE
                       "\x00\x01".  # QCLASS
                       "$ttl".      # TTL
                       "$rdlen".    # RDLENGTH
                       "$rd");      # RDATA
    $resource .= $one;
}

my $output = encode("iso-8859-1", "$header$question$resource");

if($showhex) {
    hexdump($output, "ALL");
    hexdump($header, "Header");
    hexdump($question, "Question");
    hexdump($resource, "Resources");
}
else {
    my $encoded = encode_base64url($output, "");
    $encoded =~ s/[=]+\z//;

    print "$encoded\n";
}

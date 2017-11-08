#!/usr/bin/perl

use Encode qw(encode);
use MIME::Base64 qw(encode_base64url);

my $h = $ARGV[0];

# IPv4 only is fine to start with
my @dig=`dig +short $h`;

# dig[0] is the name, then follows IP addresses
my $answers = $#dig;

my @rdata;
foreach my $num (1 .. $#dig) {
    my $ipstr = $dig[$num];
    chomp $ipstr;
    
    my $address = pack 'C4', split(/\./, $ipstr);
    push @rdata, $address;
}

my $seconds = 55; # TODO: get the real

sub hexdump {
    my ($raw) = @_;
    my $len = length($raw);
    foreach my $i (0 .. ($len-1)) {
        printf ("%02x ", $raw[$i]);
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
my $ttl = pack 'N4', $seconds;

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

    $resource .= sprintf("$qnameptr". # QNAME (pointer)
                         "$qtype".   # QTYPE
                         "\x00\x01". # QCLASS
                         "$ttl".     # TTL
                         "$rd");     # RDATA
}

my $output = encode("iso-8859-1", "$header$question$resource");

#hexdump($output);

my $encoded = encode_base64url($output, "");
$encoded =~ s/[=]+\z//;

print "$encoded\n";

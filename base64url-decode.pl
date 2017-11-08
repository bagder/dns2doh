#!/usr/bin/perl

use MIME::Base64 qw(decode_base64url);

while(<STDIN>) {
    my $dec = decode_base64url($_);
    print $dec;
}


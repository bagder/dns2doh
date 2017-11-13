# dns2doh
Resolve with DNS and generate DOH response

## example

    $ ./dns2doh.pl daniel.haxx.se
    AAAAAQAAAAQAAAAABmRhbmllbARoYXh4AnNlAAABAAHADAABAAEAAAA3AASXZQIxwAwAAQABAAAANwAEl2VCMcAMAAEAAQAAADcABJdlgjHADAABAAEAAAA3AASXZcIx

    $ ./dns2doh.pl daniel.haxx.se | ./base64url-decode.pl | hd
    00000000  00 00 00 01 00 00 00 04  00 00 00 00 06 64 61 6e  |.............dan|
    00000010  69 65 6c 04 68 61 78 78  02 73 65 00 00 01 00 01  |iel.haxx.se.....|
    00000020  c0 0c 00 01 00 01 00 00  00 37 00 04 97 65 02 31  |.........7...e.1|
    00000030  c0 0c 00 01 00 01 00 00  00 37 00 04 97 65 42 31  |.........7...eB1|
    00000040  c0 0c 00 01 00 01 00 00  00 37 00 04 97 65 82 31  |.........7...e.1|
    00000050  c0 0c 00 01 00 01 00 00  00 37 00 04 97 65 c2 31  |.........7...e.1|
    00000060

    $ ./dns2doh.pl --hex daniel.haxx.se
    = ALL
    00: 00 00 00 01 00 00 00 04 00 00 00 00 06 64 61 6e 
    10: 69 65 6c 04 68 61 78 78 02 73 65 00 00 01 00 01 
    20: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 02 31 
    30: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 42 31 
    40: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 82 31 
    50: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 c2 31 
    = Header
    00: 00 00 00 01 00 00 00 04 00 00 00 00 
    = Question
    00: 06 64 61 6e 69 65 6c 04 68 61 78 78 02 73 65 00 
    10: 00 01 00 01 
    = Resources
    00: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 02 31 
    10: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 42 31 
    20: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 82 31 
    30: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 c2 31 

# FAQ

## I can't base64 decode it!

It uses the [base64url](https://tools.ietf.org/html/rfc4648#section-5) format,
which is like normal base64 but with two letters changed.

## Where the spec?

https://tools.ietf.org/html/draft-ietf-doh-dns-over-https-01

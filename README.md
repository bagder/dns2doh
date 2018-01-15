# dns2doh

Resolve with DNS and generate DOH response with the command line tool. Play
with the toy server.

Docs: https://bagder.github.io/dns2doh/

# FAQ

## I can't base64 decode it!

It uses the [base64url](https://tools.ietf.org/html/rfc4648#section-5) format,
which is like normal base64 but with two letters changed.

## Where's the spec?

DOH: https://tools.ietf.org/html/draft-ietf-doh-dns-over-https-02

DNS - RFC 1035: https://www.ietf.org/rfc/rfc1035.txt

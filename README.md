# dns2doh

dns2doh - resolves with DNS and generates a DoH response.

doh - resolves a host name over DoH.

Docs: https://bagder.github.io/dns2doh/

# FAQ

## I can't base64 decode it!

It uses the [base64url](https://tools.ietf.org/html/rfc4648#section-5) format,
which is like normal base64 but with two letters changed.

## Where's the spec?

DoH: [RFC 8484](https://tools.ietf.org/html/rfc8484)

DNS -[RFC 1035](https://www.ietf.org/rfc/rfc1035.txt)

# Server endpoint

I run a **toy server** end point at https://daniel.haxx.se. It is HTTPS only
and supports HTTP/2. Issue real-looking DOH requests to this URI:
`https://daniel.haxx.se/dns/?dns=[base64url]`.

For example, ask for the AAAA resources for the host `daniel.haxx.se`:

   `https://daniel.haxx.se/dns/?dns=AAAAAQAAAAAAAAAABmRhbmllbARoYXh4AnNlAAAcAAE`

Or the A resources for the host `www.mozilla.org`:

   `https://daniel.haxx.se/dns/?dns=AAAAAQAAAAAAAAAAA3d3dwdtb3ppbGxhA29yZwAAAQAB`

## Response

The server will respond with a "200 OK" and a base64url encoded reply
according to spec. The HTTP answer to a query for the AAAA resources for
`daniel.haxx.se` could look something like:

    HTTP/2 200 
    date: Wed, 15 Nov 2017 12:33:41 GMT
    content-type: application/dns-udpwireformat

    AAAAAQAAAAEAAAAABmRhbmllbARoYXh4AnNlAAABAAHADAABAAEAAAA3AASXZVYx

A failure to lookup the requested entry will result in a 404 response.

## Limitations

- It requires the query as a GET

- The server doesn't yet send back the *real* TTL values in the
responses. Only a made up number

- The server doesn't set a proper cache lifetime as a HTTP response header

## Debug helpers

The server also supports reading 'host' and 'type' as plain ascii strings
*instead* of the base64url encoded 'body'. This allows easy tests without
having to encode the request as a DNS packet:

   `https://daniel.haxx.se/dns/?host=daniel.haxx.se&type=AAAA`

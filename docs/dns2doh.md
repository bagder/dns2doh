# dns2doh

Resolve with DNS and generate DOH response

## Usage

Usage: dns2doh [options] [input]

### --A

Ask for a type A resource.

### --AAAA

Ask for a type AAAA resource.

### --decode

Decode the DOH input and output the type field and host name from the question
part of the DNS packet. The type is output as `A` or `AAAA` depending on the
field being 1 or 28.

### --encode

(default) Encode the host name input to proper DOH message and output it. This
is the default action if no option is given. Use `--A` (default) or `--AAAA`
to control which TYPE to use.

### --hex

Show hexdump of the input/output. For debugging the process.

### --onlyq

When encoding a host name, only put the question part in the package. Skip the answer.

### --help

Show usage message

# Examples

    $ ./dns2doh daniel.haxx.se
    AAAAAQAAAAQAAAAABmRhbmllbARoYXh4AnNlAAABAAHADAABAAEAAAA3AASXZQIxwAwAAQABAAAANwAEl2VCMcAMAAEAAQAAADcABJdlgjHADAABAAEAAAA3AASXZcIx

    $ ./dns2doh daniel.haxx.se | ./base64url-decode | hd
    00000000  00 00 00 01 00 00 00 04  00 00 00 00 06 64 61 6e  |.............dan|
    00000010  69 65 6c 04 68 61 78 78  02 73 65 00 00 01 00 01  |iel.haxx.se.....|
    00000020  c0 0c 00 01 00 01 00 00  00 37 00 04 97 65 02 31  |.........7...e.1|
    00000030  c0 0c 00 01 00 01 00 00  00 37 00 04 97 65 42 31  |.........7...eB1|
    00000040  c0 0c 00 01 00 01 00 00  00 37 00 04 97 65 82 31  |.........7...e.1|
    00000050  c0 0c 00 01 00 01 00 00  00 37 00 04 97 65 c2 31  |.........7...e.1|
    00000060

    $ ./dns2doh --AAAA daniel.haxx.se  | ./dns2doh --decode --hex
    = Incoming
    00: 00 00 00 01 00 00 00 04 00 00 00 00 06 64 61 6e   |.............dan|
    10: 69 65 6c 04 68 61 78 78 02 73 65 00 00 1c 00 01   |iel.haxx.se.....|
    20: c0 0c 00 1c 00 01 00 00 00 37 00 10 2a 04 4e 42   |.........7..*.NB|
    30: 00 00 00 00 00 00 00 00 00 00 05 61 c0 0c 00 1c   |...........a....|
    40: 00 01 00 00 00 37 00 10 2a 04 4e 42 02 00 00 00   |.....7..*.NB....|
    50: 00 00 00 00 00 00 05 61 c0 0c 00 1c 00 01 00 00   |.......a........|
    60: 00 37 00 10 2a 04 4e 42 04 00 00 00 00 00 00 00   |.7..*.NB........|
    70: 00 00 05 61 c0 0c 00 1c 00 01 00 00 00 37 00 10   |...a.........7..|
    80: 2a 04 4e 42 06 00 00 00 00 00 00 00 00 00 05 61   |*.NB...........a|
    AAAA daniel.haxx.se

    $ ./dns2doh --hex daniel.haxx.se
    = ALL
    00: 00 00 00 01 00 00 00 04 00 00 00 00 06 64 61 6e   |.............dan|
    10: 69 65 6c 04 68 61 78 78 02 73 65 00 00 01 00 01   |iel.haxx.se.....|
    20: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 02 31   |.........7...e.1|
    30: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 42 31   |.........7...eB1|
    40: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 82 31   |.........7...e.1|
    50: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 c2 31   |.........7...e.1|
    = Header
    00: 00 00 00 01 00 00 00 04 00 00 00 00               |............|
    = Question
    00: 06 64 61 6e 69 65 6c 04 68 61 78 78 02 73 65 00   |.daniel.haxx.se.|
    10: 00 01 00 01                                       |....|
    = Resources
    00: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 02 31   |.........7...e.1|
    10: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 42 31   |.........7...eB1|
    20: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 82 31   |.........7...e.1|
    30: c0 0c 00 01 00 01 00 00 00 37 00 04 97 65 c2 31   |.........7...e.1|

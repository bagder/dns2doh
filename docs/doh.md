# doh

Resolve a host with a given DOH server

## Usage

Usage: doh [options] [host name] [URL]

### --A

Ask for a type A resource. (default)

### --AAAA

Ask for a type AAAA resource.

### --NS

Ask for a type NS resource.

### --help

Show usage message

# Examples

    $ ./doh daniel.haxx.se https://dns.google.com/experimental | hd
    00000000  00 00 81 80 00 01 00 05  00 00 00 00 06 64 61 6e  |.............dan|
    00000010  69 65 6c 04 68 61 78 78  02 73 65 00 00 01 00 01  |iel.haxx.se.....|
    00000020  c0 0c 00 05 00 01 00 00  02 e5 00 27 09 64 75 61  |...........'.dua|
    00000030  6c 73 74 61 63 6b 02 6a  32 06 73 68 61 72 65 64  |lstack.j2.shared|
    00000040  06 67 6c 6f 62 61 6c 06  66 61 73 74 6c 79 03 6e  |.global.fastly.n|
    00000050  65 74 00 c0 2c 00 01 00  01 00 00 00 1d 00 04 97  |et..,...........|
    00000060  65 02 31 c0 2c 00 01 00  01 00 00 00 1d 00 04 97  |e.1.,...........|
    00000070  65 42 31 c0 2c 00 01 00  01 00 00 00 1d 00 04 97  |eB1.,...........|
    00000080  65 82 31 c0 2c 00 01 00  01 00 00 00 1d 00 04 97  |e.1.,...........|
    00000090  65 c2 31                                          |e.1|
    00000093

    $ ./doh --AAAA example.com  | hd
    00000000  00 00 81 80 00 01 00 01  00 00 00 00 07 65 78 61  |.............exa|
    00000010  6d 70 6c 65 03 63 6f 6d  00 00 1c 00 01 c0 0c 00  |mple.com........|
    00000020  1c 00 01 00 00 00 c4 00  10 26 06 28 00 02 20 00  |.........&.(.. .|
    00000030  01 02 48 18 93 25 c8 19  46                       |..H..%..F|

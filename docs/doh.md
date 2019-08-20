# doh

Resolve a host with a given DOH server

## Usage

Usage: doh [options] [host name] [URL]

### --A

Ask for a set of type A resource records. (default)

### --AAAA

Ask for a set of type AAAA resource records.

### --NS

Ask for a set of type NS resource records.

### --TXT

Ask for a set of type TXT resource records.

### --TYPEnum

Ask for a set of resource records of arbitrary numeric type **num**,
in range [1..65535].

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

    $ ./doh --AAAA example.com https://dns.cloudflare.com/.well-known/dns-query | hd
    00000000  00 00 81 80 00 01 00 01  00 00 00 00 07 65 78 61  |.............exa|
    00000010  6d 70 6c 65 03 63 6f 6d  00 00 1c 00 01 c0 0c 00  |mple.com........|
    00000020  1c 00 01 00 00 00 c4 00  10 26 06 28 00 02 20 00  |.........&.(.. .|
    00000030  01 02 48 18 93 25 c8 19  46                       |..H..%..F|

    $ ./doh --TXT _esni.only.esni.defo.ie \
	        https://dns.cloudflare.com/.well-known/dns-query | hd
	00000000  00 00 81 a0 00 01 00 01  00 00 00 01 05 5f 65 73  |............._es|
	00000010  6e 69 04 6f 6e 6c 79 04  65 73 6e 69 04 64 65 66  |ni.only.esni.def|
	00000020  6f 02 69 65 00 00 10 00  01 c0 0c 00 10 00 01 00  |o.ie............|
	00000030  00 06 f7 00 5d 5c 2f 77  46 38 4e 30 37 37 41 43  |....]\/wF8N077AC|
	00000040  51 41 48 51 41 67 4e 67  79 67 51 63 46 72 77 47  |QAHQAgNgygQcFrwG|
	00000050  6a 65 61 32 37 68 34 6c  49 38 54 77 4b 58 68 42  |jea27h4lI8TwKXhB|
	00000060  49 69 44 55 33 59 75 68  32 6a 62 75 55 46 32 30  |IiDU3Yuh2jbuUF20|
	00000070  63 41 41 68 4d 42 41 51  51 41 41 41 41 41 58 56  |cAAhMBAQQAAAAAXV|
	00000080  73 65 4f 41 41 41 41 41  42 64 57 7a 4e 51 41 41  |seOAAAAABdWzNQAA|
	00000090  41 3d 00 00 29 05 ac 00  00 00 00 00 63 00 0c 00  |A=..).......c...|
	000000a0  5f 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |_...............|
	000000b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

    $ ./doh --TYPE16 _esni.only.esni.defo.ie \
	        https://dns.cloudflare.com/.well-known/dns-query | hd
	00000000  00 00 81 a0 00 01 00 01  00 00 00 01 05 5f 65 73  |............._es|
	00000010  6e 69 04 6f 6e 6c 79 04  65 73 6e 69 04 64 65 66  |ni.only.esni.def|
	00000020  6f 02 69 65 00 00 10 00  01 c0 0c 00 10 00 01 00  |o.ie............|
	00000030  00 07 08 00 5d 5c 2f 77  46 38 4e 30 37 37 41 43  |....]\/wF8N077AC|
	00000040  51 41 48 51 41 67 4e 67  79 67 51 63 46 72 77 47  |QAHQAgNgygQcFrwG|
	00000050  6a 65 61 32 37 68 34 6c  49 38 54 77 4b 58 68 42  |jea27h4lI8TwKXhB|
	00000060  49 69 44 55 33 59 75 68  32 6a 62 75 55 46 32 30  |IiDU3Yuh2jbuUF20|
	00000070  63 41 41 68 4d 42 41 51  51 41 41 41 41 41 58 56  |cAAhMBAQQAAAAAXV|
	00000080  73 65 4f 41 41 41 41 41  42 64 57 7a 4e 51 41 41  |seOAAAAABdWzNQAA|
	00000090  41 3d 00 00 29 05 ac 00  00 00 00 00 63 00 0c 00  |A=..).......c...|
	000000a0  5f 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |_...............|
	000000b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|

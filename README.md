# dns2doh
Resolve with DNS and generate DOH response

# example

    $ ./dns2doh.pl daniel.haxx.se 
    AAAAAQAAAAQAAAAABmRhbmllbARoYXh4AnNlAAABAAHADAABAAEAAAA3AAAAAAAAAAAAAAAAl2XCMcAMAAEAAQAAADcAAAAAAAAAAAAAAACXZYIxwAwAAQABAAAANwAAAAAAAAAAAAAAAJdlQjHADAABAAEAAAA3AAAAAAAAAAAAAAAAl2UCMQ

    $ ./dns2doh.pl daniel.haxx.se | ./base64url-decode.pl | hd
    00000000  00 00 00 01 00 00 00 04  00 00 00 00 06 64 61 6e  |.............dan|
    00000010  69 65 6c 04 68 61 78 78  02 73 65 00 00 01 00 01  |iel.haxx.se.....|
    00000020  c0 0c 00 01 00 01 00 00  00 37 00 00 00 00 00 00  |.........7......|
    00000030  00 00 00 00 00 00 97 65  02 31 c0 0c 00 01 00 01  |.......e.1......|
    00000040  00 00 00 37 00 00 00 00  00 00 00 00 00 00 00 00  |...7............|
    00000050  97 65 42 31 c0 0c 00 01  00 01 00 00 00 37 00 00  |.eB1.........7..|
    00000060  00 00 00 00 00 00 00 00  00 00 97 65 82 31 c0 0c  |...........e.1..|
    00000070  00 01 00 01 00 00 00 37  00 00 00 00 00 00 00 00  |.......7........|
    00000080  00 00 00 00 97 65 c2 31                           |.....e.1|
    00000088


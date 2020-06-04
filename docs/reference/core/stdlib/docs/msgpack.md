# MsgPack

This module define functions to serialize and unserialize objects to and from [msgpack](http://msgpack.org) format.

Objects serialized with msgpack are usually smaller than their equivalent json representation.

The supported formats are shown in the table below.

| **Format name**

 | **First byte (in binary)**

 | **First byte (in hex)**

 |
| positive fixint

 | 0xxxxxxx

               | 0x00 - 0x7f

         |
| fixmap

          | 1000xxxx

               | 0x80 - 0x8f

         |
| fixarray

        | 1001xxxx

               | 0x90 - 0x9f

         |
| fixstr

          | 101xxxxx

               | 0xa0 - 0xbf

         |
| nil

             | 11000000

               | 0xc0

                |
| false

           | 11000010

               | 0xc2

                |
| true

            | 11000011

               | 0xc3

                |
| bin 8

           | 11000100

               | 0xc4

                |
| bin 16

          | 11000101

               | 0xc5

                |
| float 32

        | 11001010

               | 0xca

                |
| uint 8

          | 11001100

               | 0xcc

                |
| uint 16

         | 11001101

               | 0xcd

                |
| uint 32

         | 11001110

               | 0xce

                |
| int 8

           | 11010000

               | 0xd0

                |
| int 16

          | 11010001

               | 0xd1

                |
| int 32

          | 11010010

               | 0xd2

                |
| str 8

           | 11011001

               | 0xd9

                |
| str 16

          | 11011010

               | 0xda

                |
| array 16

        | 11011100

               | 0xdc

                |
| map 16

          | 11011110

               | 0xde

                |
| negative fixint

 | 111xxxxx

               | 0xe0 - 0xff

         |

---
#### `#!py3 pack()`

!!!abstract "`#!py3 pack(obj)`"

Returns a bytearray containing the msgpack representation of ```obj```.

Raises `MsgPackError` when ```obj``` contains non serializable objects.


---
#### `#!py3 unpack()`

!!!abstract "`#!py3 unpack(data, offs=0)`"

Returns an object represented in msgpack format inside the byte sequence ```data``` starting from offset ```offs```.

Not every valid msgpack representation can be converted to python objects by ```unpack```.
For example, 64-bit msgpack integers and msgpack ext types. In that case, `MsgUnpackError` is raised.

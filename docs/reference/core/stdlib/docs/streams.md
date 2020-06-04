# Streams

This module contains class definitions for streams.
A stream is an abstraction representing a channel to write and read sequences of bytes.
A stream is connected to something, being it a serial port or a socket or internal memory, from which it receives and to which it sends bytes.
Every stream instance implements the following methods:


* read: removes bytes from the stream


* write: puts bytes in the stream


* available: checks the presence of readable bytes in the stream

```streams``` implements the following streams:


* base class `streams.stream()`


* `streams.serial()`


* `streams.SocketStream()`


* `streams.FileStream()`


* `streams.ResourceStream()`

## The stream class


---
#### `#!py3 stream()`

!!!abstract "`#!py3 stream()`"

This is the base class for streams and all streams must derive from this class.


---
#### `#!py3 _readbuf()`

!!!abstract "`#!py3 _readbuf(buffer, size=1, ofs=0)`"

Reads bytes from the stream to ```buffer```. If the stream contains no readable bytes it blocks until some bytes arrives or the underlying connection is lost (e.g. the server closes the socket).
It directly access the driver linked to the stream issuing a native read command.
In most cases `_readbuf()` is called internally by other stream methods and should not be called directly.

```buffer``` is a byte sequence used to store the bytes just read. ```size``` is the number of bytes to be read and ```ofs``` is the position of ```buffer``` to start writing incoming bytes.
Bytes are stored in ```buffer``` up to ```buffer``` size or less.

Returns the number of bytes read or 0 when the underlying connection is lost.


---
#### `#!py3 write()`

!!!abstract "`#!py3 write(buffer)`"

Writes the content of buffer to the stream.

```buffer``` must be a byte sequence (bytes, bytearray or string).

Returns the number of bytes actually written to the stream (can be less than the elements in ```buffer```)


---
#### `#!py3 read()`

!!!abstract "`#!py3 read(size=1)`"

Reads at most ```size``` bytes from the stream and returns a bytearray with the actual bytes read.

```read``` blocks if no bytes are available in the stream.

If ```read``` returns an empty bytearray the underlying stream can be considered disconnected.


---
#### `#!py3 readline()`

!!!abstract "`#!py3 readline(sep="\\n", buffer=None, size=0, ofs=0)`"

Reads bytes from the stream until ```sep``` is encountered (an end-of-line byte (“\\n”) is default).

Returns the line as a bytearray with ```sep``` included.

If ```buffer``` is given (as a bytearray), ```buffer``` is used to store the line up to ```size``` bytes, starting at offset ```ofs```.

If ```readline``` returns an empty bytearray the underlying stream can be considered disconnected.

## The serial class


---
#### `#!py3 serial()`

!!!abstract "`#!py3 serial(drivername=SERIAL0, baud=115200, stopbits=STOPBIT_1, parity=PARITY_NONE, bitsize=BITSIZE_8, set_default=True, rxsize=0, txsize=0)`"

This class implements a stream that can be used to connect to a serial port.
It inhertis all of its methods from `stream()`.

Initialize the serial port driver identified by ```drivername``` and starts it up with a baud rate of ```baud```.
Also, if ```set_default``` is True, sets itself as the default stream used by `__builtins__.print()`.
This means that the serial stream will be the system default one.
Additional parameters can be passed such as:
\* ```parity``` : `PARITY_NONE` or `PARITY_ONE`
\* ```stopbits``` : `STOPBIT_1` , `STOPBIT_1_HALF`, `STOPBIT_2`
\* ```bitsize``` : `BITSIZE_8`
\* ```rxsize``` and ```txsize``` : the size in bytes of the receive and transmit buffers (0 selects the board default)

Not all of the additional parameters are always supported by the underlying device.

This is the code needed to print something on the default serial port:

```
# import the streams module
import streams

# create a serial stream linked to SERIAL0 port
streams.serial()

# SERIAL0 is automatically selected as the default system stream,
# therefore print will output everything to it
print("Hello World!")
```


---
#### `#!py3 available()`

!!!abstract "`#!py3 available()`"

Returns the number of characters that can be read without blocking.


---
#### `#!py3 close()`

!!!abstract "`#!py3 close()`"

Close the stream linked to the underlying serial port.

## The SocketStream class


---
#### `#!py3 SocketStream()`

!!!abstract "`#!py3 SocketStream(sock)`"

This class implements a stream that has a socket as a source of data.
It inhertis all of its methods from `stream()`.


---
#### `#!py3 write()`

!!!abstract "`#!py3 write(buffer)`"

Writes the content of buffer to the stream.

```buffer``` must be a byte sequence (bytes, bytearray or string).

Returns the number of bytes actually written to the stream (can be less than the elements in ```buffer```)


---
#### `#!py3 close()`

!!!abstract "`#!py3 close()`"

Close the underlying socket.

## The FileStream class


---
#### `#!py3 FileStream()`

!!!abstract "`#!py3 FileStream(name, mode="rb")`"

This class implements a stream that has a file as a source of data.
It inherits all of its methods from `stream()`.

It is just a stub at the moment. It is used by `ResourceStream()` only.


---
#### `#!py3 seek()`

!!!abstract "`#!py3 seek(offset, whence=SEEK_SET)`"

Move the current position to ```offset``` bytes with respect to ```whence```.

```whence``` can be:


* SEEK_SET: start of file


* SEEK_CUR: current position


* SEEK_END: end of file

## The ResourceStream class


---
#### `#!py3 ResourceStream()`

!!!abstract "`#!py3 ResourceStream(name)`"

This class implements a stream that has a flash saved resource as a source of data.
It inherits all of its methods from `FileStream()`.

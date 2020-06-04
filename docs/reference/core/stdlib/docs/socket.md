# Sockets

This module provides access to an almost complete BSD socket interface. However, some behaviour may be
dependent on the underlying network driver.

The following constants are defined:


* For socket families: AF_INET, AF_INET6, AF_CAN


* For socket types: SOCK_STREAM, SOCK_DGRAM, SOCK_RAW


* For socket options: SOL_SOCKET, SO_RCVTIMEO, SO_REUSEADDR

IPv4 addresses can be passed to functions and methods in the following forms:


* string, e.g. “192.168.1.10”


* tuple, e.g. (192,168,1,10)


* tuple of ip and port, e.g. (“192.168.1.10”,8080)


* tuple of ip and port, e.g. (192,168,1,10,8080)

if a port is required but not given, it is set to zero.


---
#### `#!py3 ip_to_tuple()`

!!!abstract "`#!py3 ip_to_tuple()`"

Return a tuple of four integers from a ip address of the form “x.y.z.w”.

## The socket class


---
#### `#!py3 socket()`

!!!abstract "`#!py3 socket(family=AF_INET, type=SOCK_STREAM, proto=IPPROTO_TCP, fileno=None)`"

This class represents a BSD socket.

Raise `__builtins__.IOError` exceptions if socket creation goes wrong.

Sockets can be used like this:

```
# import the socket module
import socket
# import a module to access a net driver (wifi, eth,...)
from wireless import wifi
# import the actual net driver
from driver.wifi.your_preferred_net_driver import your_preferred_net_driver

# init the driver
your_preferred_net_driver.init()

# link the wifi to an AP
wifi.link("Your Wifi SSID",WIFI_WPA2,"Your Wifi Password")

# create a tcp socket
sock = socket.socket(type=SOCK_STREAM)

# connect the socket to net address 192.168.1.10 on port 5555
sock.connect(("192.168.1.10",5555))

# send something on the socket!
sock.sendall("Hello World!")
```


---
#### `#!py3 fileno()`

!!!abstract "`#!py3 fileno()`"

Return an integer identifying the underlying socket number.


---
#### `#!py3 connect()`

!!!abstract "`#!py3 connect(address)`"

Tries to connect the underlying socket (tcp or udp) to ```address```.
A tcp socket must be connected to be used successfully. Udp sockets are connectionless and everytime a datagram
is sent, the receiver address must be specified (`sendto()`). However if an udp socket is connected to an address,
it can be used with methods like `recv()` and `send()` without specifying a receiver address.
When an udp socket is connected to ```address```, datagram packets coming from addresses different from ```address``` are ignored.


---
#### `#!py3 close()`

!!!abstract "`#!py3 close()`"

Closes the underlying socket. No more input/output operations are possible.


---
#### `#!py3 recv()`

!!!abstract "`#!py3 recv(bufsize, flags=0)`"

Reads at most ```bufsize``` bytes from the underlying socket. It blocks until ```bufsize``` bytes are received or an error occurs.

Returns a bytearray containing the received bytes.


---
#### `#!py3 recv_into()`

!!!abstract "`#!py3 recv_into(buffer, bufsize=-1, flags=0)`"

Reads at most ```bufsize``` bytes from the underlying socket into ```buffer```. It blocks until ```bufsize``` bytes are received or an error occurs.

Returns the number of received bytes.


---
#### `#!py3 recvfrom()`

!!!abstract "`#!py3 recvfrom(bufsize, flags=0)`"

Reads at most ```bufsize``` bytes from the underlying udp socket. It blocks until a datagram is received.

Returns a tuple (```data```, ```address```) where ```data``` is a bytearray containing the received bytes and ```address``` is the net address of the sender.


---
#### `#!py3 recvfrom_into()`

!!!abstract "`#!py3 recvfrom_into(buffer, bufsize=-1, flags=0)`"

Reads at most ```bufsize``` bytes from the underlying udp socket into ```buffer```. It blocks until a datagram is received. If ```bufsize``` is not given or is less than 0, ```bufsize``` is set to len(buffer).

Returns a tuple (```rd```, ```address```) where ```rd``` is the number of bytes received and ```address``` is the net address of the sender.


---
#### `#!py3 send()`

!!!abstract "`#!py3 send(buffer, flags=0)`"

Send data to the socket. The socket must be connected to a remote socket.

Returns the number of bytes sent. Applications are responsible for checking that all data has been sent; if only some of the data was transmitted, the application needs to attempt delivery of the remaining data.


---
#### `#!py3 sendall()`

!!!abstract "`#!py3 sendall(buffer, flags=0)`"

Send all data to the socket. The socket must be connected to a remote socket.

Unlike send(), this method continues to send data from bytes until either all data has been sent or an error occurs.
```None``` is returned on success. On error, an exception is raised, and there is no way to determine how much data, if any, was successfully sent.


---
#### `#!py3 sendto()`

!!!abstract "`#!py3 sendto(buffer, address, flags=0)`"

Send data to the socket. The socket should not be connected to a remote socket, since the destination socket is specified by address.
Return the number of bytes sent


---
#### `#!py3 settimeout()`

!!!abstract "`#!py3 settimeout(timeout)`"

Set a timeout on blocking socket operations. The ```timeout``` argument can be a nonnegative integer number expressing milliseconds, or ```None```.
If a non-zero value is given, subsequent socket operations will raise a timeout exception if the timeout period value has elapsed before the operation has completed.
If zero is given, the socket is put in non-blocking mode.
If None is given, the socket is put in blocking mode.


---
#### `#!py3 bind()`

!!!abstract "`#!py3 bind(address)`"

Binds the socket to ```address```. ```address``` can be:


* an integer representing a port number. In this case ip is set to the local one


* an ip address with a port

A tcp socket needs binding when it is used to accept incoming connection (e.g. a http server socket).
A udp socket needs to be bound before any input/output operation. After binding, the udp socket will receive
every packet incoming to ```address```.


---
#### `#!py3 listen()`

!!!abstract "`#!py3 listen(maxlog=2)`"

Enables listening on the underlying tcp socket. A tcp socket in listening state can be used as a server socket to accept incoming connection.
```maxlog``` specifies the maximum number of waiting connections.


---
#### `#!py3 accept()`

!!!abstract "`#!py3 accept()`"

Blocks until an incoming connection is made on the underlying tcp socket.

Returns a tuple (```sock```, ```address```) where ```sock``` is a socket stream that can be used to communicate with the client and
```address``` is the client address.

Here is an example of tcp server socket:

```
# import the socket module
import socket
# import a module to access a net driver (wifi, eth,...)
from wireless import wifi
# import the actual net driver
from driver.wifi.your_preferred_net_driver import your_preferred_net_driver

# init the driver
your_preferred_net_driver.init()

# link the wifi to an AP
wifi.link("Your Wifi SSID",WIFI_WPA2,"Your Wifi Password")

# create a tcp socket
sock = socket.socket(type=SOCK_STREAM)

# bind the socket to port 80
sock.bind(80)

# set the socket in listening mode
sock.listen()

while True:
    # accept incoming connections from clients
    client,addr = sock.accept()
    # send something to the client and close
    client.sendall("Hello!")
    client.close()
```

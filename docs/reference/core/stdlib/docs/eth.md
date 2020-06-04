# Ethernet

This module implements a generic ethernet interface.
To function correctly it needs an ethernet driver to be loaded, so that the module can use
the driver to access the underlying hardware.

The link between the eth module and the ethernet driver is established without the programmer
intervention by the driver itself.


---
#### `#!py3 gethostbyname()`

!!!abstract "`#!py3 gethostbyname(hostname)`"

Translate a host name to IPv4 address format. The IPv4 address is returned as a string, such as “192.168.0.5”.


---
#### `#!py3 select()`

!!!abstract "`#!py3 select(rlist, wlist, xlist, timeout=None)`"

This is equivalent to the Unix ```select``` system call.
The first three arguments are sequences of socket instances.


* ```rlist```: wait until ready for reading


* ```wlist```: wait until ready for writing


* ```xlist```: wait for an “exceptional condition” (not supported by every wifi driver)

Empty sequences are allowed. The optional ```timeout``` argument specifies a time-out as an integer number
in milliseconds.  When the ```timeout``` argument is omitted the function blocks until
at least one socket is ready.  A ```timeout``` value of zero specifies a
poll and never blocks.

The return value is a triple of lists of objects that are ready: subsets of the
first three arguments.  When the time-out is reached without a socket
becoming ready, three empty lists are returned.


---
#### `#!py3 link()`

!!!abstract "`#!py3 link()`"

Activate the Ethernet PHY and try to establish a link.

An exception can be raised if the link is not successful.


---
#### `#!py3 unlink()`

!!!abstract "`#!py3 unlink()`"

Disable the Ethernet PHY and disconnect from the currently linked network.


---
#### `#!py3 is_linked()`

!!!abstract "`#!py3 is_linked()`"

Return True if linked


---
#### `#!py3 set_link_info()`

!!!abstract "`#!py3 set_link_info(ip, mask, gw, dns)`"

Set desired eth interface parameters:


* ip, the static ipv4 address


* mask, the network mask


* gw, the default gateway


* dns, the default dns

If 0.0.0.0 is given, a default address will be used.


---
#### `#!py3 link_info()`

!!!abstract "`#!py3 link_info()`"

Return information on the currently established link.

The result is a tuple where the elements are, in order:


* The assigned IP as a string


* The network mask as a string


* The gateway IP as a string


* The DNS IP as a string


* The MAC address of the eth interface as a sequence of 6 bytes

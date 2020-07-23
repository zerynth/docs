# GSM

This module implements a generic gsm interface.
To function correctly it needs a gsm driver to be loaded, so that the module can use
the driver to access the underlying hardware.

The link between the gsm module and the gsm driver is established without the programmer
intervetion by the driver itself.

Once the gsm driver is connected to the GSM network, this module can be used to access functionalities at different levels:


* **Network level**: query the operators/carriers, select a carrier, retrieve the signal strength, retrieve info about the current cell


* **Device level**: retrieve info about IMEI and SIM card


* **Packet Switch Service level**: once attached to an APN, the standard socket interface is available. Secure sockets are available if the underlying driver supports them. Due to the nature of GSM networks (private networks behind a NATing APN), listening sockets are not implemented both for UDP and TCP.


* **SMS level**: receive, read and send SMS (not yet available)

The following constants are defined:


* `AUTH_NONE`, no authentication required with APN


* `AUTH_DETECT`, automatic authentication detection


* `AUTH_PAP`, use PAP authentication


* `AUTH_CHAP`, use CHAP authentication

###### gethostbyname

```#!py3 gethostbyname(hostname)```

Translate a host name to IPv4 address format. The IPv4 address is returned as a string, such as “192.168.0.5”.

###### attach

```#!py3 attach(apn, username = "", psw = "", auth = AUTH_NONE, timeout=120000)```

Try to establish a link with the chosen Access Point Name ```apn```.
```auth``` must be one of AUTH_NONE (default), AUTH_PAP, AUTH_CHAP, AUTH_DETECT.
```username``` and ```psw``` are optional, depending on the operator.
```timeout``` is the time in milliseconds to wait for network registration (connecting to the carrier and receiving GPRS support) and APN negotiation (enabling the packet switch service)

An exception can be raised if the connection is not successful.

###### detach

```#!py3 detach()```

Detach from APN.

###### mobile_info

```#!py3 mobile_info()```

Return information on the mobile device and SIM card.

The result is a tuple where the elements are, in order:


* The IMEI as a string


* The SIM card id as a string

###### link_info

```#!py3 link_info()```

Return information on the currently established APN link.

The result is a tuple where the elements are, in order:


* The assigned IP as a string


* The DNS IP as a string

Note that the returned IP, is in the private range and doesn’t match the IP seen by the other end of a socket.

###### network_info

```#!py3 network_info()```

Return information on the GSM network.

The result is a tuple where the elements are, in order:


* The service type as a string: GMS, UMTS, LTE


* The [MCC](http://mcc-mnc.com) as an integer, negative if not known


* the [MNC](http://mcc-mnc.com) as an integer, negative if not known


* The Base Station identifier as string


* The LAC (location area code) as a string


* The Cell Identity as a string


* The registration status to the mobile network: True or False


* The presence of a link to an APN: True or False

###### rssi

```#!py3 rssi()```

Return an integer representing the signal strength in dB.

###### operators

```#!py3 operators()```

Retrieve the list of available operators/carrier. If the result is `None`, it was not possible to retrieve the list of operators.

The result is a tuple where each items is a tuple of the following items:


* ```type```, being 1 if available and 2 if currently connected


* *long name*, a string with the full name of the operator


* *short name*, a string with the short name of the operator


* ```identifier```, the numeric identifier of the operator as a string

###### set_operator

```#!py3 set_operator(opname)```

Try to select the operator with long name ```opname```. It is suggested to retrieve the list of operators before trying to set one.

###### set_rat

```#!py3 set_rat(rat, bands=[])```

Try to set the Radio Access Technology to use. `rat` must be one of the constants:


* samp:GSM: for GSM radio


* samp:CAT_M1: for LTE Cat M1


* samp:CAT_NB1: for LTE NB IoT

The argument ```bands``` is used to select a subset of bands for the selected RAT.
For samp:GSM the available bands are in the set (0,1,2,3) corresponding in order to
900 MHz, 1800MHz, 850MHz and 1900MHz.
For LTE bands, the set of available bands can be looked up [here](https://en.wikipedia.org/wiki/LTE_frequency_bands) (use the Band column).

The underlying gsm driver may not support the RAT or the bands and can raise an exception or ignore unsupported bands.

###### select

```#!py3 select(rlist, wlist, xlist, timeout=None)```

This is equivalent to the Unix ```select``` system call.
The first three arguments are sequences of socket instances.


* ```rlist```: wait until ready for reading


* ```wlist```: wait until ready for writing


* ```xlist```: wait for an “exceptional condition” (not supported by every gsm driver)

Empty sequences are allowed. The optional ```timeout``` argument specifies a time-out as an integer number
in milliseconds.  When the ```timeout``` argument is omitted the function blocks until
at least one socket is ready.  A ```timeout``` value of zero specifies a
poll and never blocks.

The return value is a triple of lists of objects that are ready: subsets of the
first three arguments.  When the time-out is reached without a socket
becoming ready, three empty lists are returned.

###### list_sms

```#!py3 list_sms(unread=False, maxsms=10, offset=0)```

Return a tuple of received SMS. Each SMS is a tuple with:


* Text of the message


* Number of the sender


* Timestamp of the SMS (7 integer elements YYYY,MM,DD,hh,mm,ss,tz where tz represents the difference in minutes with GMT)


* SMS index

Parameter `unread` selects unread SMS only if set to True. `maxsms` defines the maximum number of SMS to return, while `offset` selects only
SMS with index greater than or equal to `offset`. If the device stores many SMS, it is suggested to read them in chunks by incrementing `offset`.

###### send_sms

```#!py3 send_sms(num, txt)```

Try to send the SMS with text `txt` to receiver `num`.

Return an integer representing the index of the SMS (but this may vary from driver to driver!).
If the returned integer is negative, it has not been possible to send the SMS. An exception is raised if
the underlying drivers fails while sending the SMS.

###### delete_sms

```#!py3 delete_sms(index)```

Delete the SMS identified by `index`. The value of `index` to use must be taken from the result of list_sms.

###### pending_sms

```#!py3 pending_sms()```

Return the number of SMS received since startup. It is not necessarily equal to the number of unread SMS.

###### get_smsc

```#!py3 get_smsc()```

Return a string representing the Short Message Service Center

###### set_smsc

```#!py3 set_smsc(smsc)```

Set the Short Message Service Center to the value of `smsc`
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc1NjQxMDMzNywtMzIyNTExMTk5XX0=
-->

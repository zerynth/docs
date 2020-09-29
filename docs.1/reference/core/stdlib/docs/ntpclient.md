# NTPClient Library

This library retrieve the current time from an NTP server.
A method to convert the timestamp from ntc to a human readable format is available in the examples.

## NTPClient class

##### class NTPClient

```#!py3 class NTPClient(conn_ifc, server="0.pool.ntp.org")```

Create an instance of the NTPClient class which allow communication with the NTP Server.

If no server is provided, a default one will be used.


Arguments:
    
* `conn_ifc` – a connection interface that must be initialized by the user.


* `server` – the server to be used.


###### NTPClient.get_time

```#!py3 get_time(unix_timestamp=False)```

Retrieve the current time from the NTP Server. amount of second passed since January 1st 1900 from the NTP Server.

Arguments:

* `unix_timestamp` – Unix flag. Set to `False` or `True` to get the current time as the amount of seconds passed since January 1st 1900 or Epoch (January 1st 1970) respectively. 

Return:

* The current time as integer.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTMyMDA5Njg4XX0=
-->
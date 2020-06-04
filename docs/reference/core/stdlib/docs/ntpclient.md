# NTPClient Library

This library retrieve the current time from an NTP server.
A method to convert the timestamp from ntc to a human readable format is available in the examples.

## NTPClient class


---
#### `#!py3 NTPClient()`

!!!abstract "`#!py3 NTPClient(conn_ifc, )`"

Create an instance of the NTPClient class which allow communication with the NTPServer.

If no server is provided, a default one will be used.


* ```Arguments```

    
    * ```conn_ifc``` – a connection interface that must be initialized by the user.


    * ```server``` – the server to be used.



---
#### `#!py3 get_time()`

!!!abstract "`#!py3 get_time()`"

Retrieve the amount of second passed since January 1st 1900 from the NTP Server.

Returns:

    The amount of second passed since January 1st 1900.

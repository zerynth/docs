# NMEA Module

This module implements a Zerynth driver and parser for a generic NMEA GNSS receiver.

The following functionalities are implemented:


* retrieve the current location fix if present
* retrieve the current UTC time

The driver supports reading NMEA sentences from a serial port only.

Location fixes are obtained by parsing NMEA sentences of type RMC and GGA, and optionally GSA. Obtaining a fix or UTC time are thread safe operations.


**`readline(serial, buffer, timeout=5000)`**

Wait for a full NMEA sentence from the specified *serial* interface and copy it to the specified *buffer* (bytearray), with optional *timeout* (in milliseconds).

Returns the length of the NMEA sentence or a negative error code:

* *-1*, if the line does not start with NMEA header (missing `'$'`)
* *-2*, if the line has incomplete NMEA sentence (missing  `'*'`)
* *-3*, if the line has invalid or mismatching NMEA checksum


**`parseline(buffer, length, tm, fix)`**

Parse the content of the specified line *buffer* (bytearray) up to *length* bytes and fill the two sequences *tm* and *fix* with date/time and fix data if available.

Returned value is *0* if the line does not have valid data, or a combination (sum) of:

* *4*, if the *tm* sequence (7 items) has been filled (from RMC sentence)
* *1*, *2* or *3*, if the *fix* sequence (9 items) has been filled (from RMC, GGA or GSA respectively)


**`class NMEA_Receiver()`**

This class is meant to be used as a base class to provide a uniform interface for GNSS receivers.

Instances of this class are fed with NMEA sentences using the `parse` method and can be queried for UTC time and location data. The parser can be disabled to clear acquired data and to prevent further updates until it is enabled again (to avoid stale data).


**`fix()`**

Return the current fix or *None* if not available. A fix is a tuple with the following elements:

* latitude in decimal format (-89.9999 - 89.9999)
* longitude in decimal format (-179.9999 - 179.9999)
* altitude in meters
* speed in Km/h
* course over ground as degrees from true north
* number of satellites for this fix
* horizontal dilution of precision (0.5 - 99.9)
* vertical dilution of precision (0.5 - 99.9)
* positional dilution of precision (0.5 - 99.9)
* UTC time as a tuple (yyyy,MM,dd,hh,mm,ss,microseconds)
`
**has_fix()`**

Return *True* if a fix is available.


**`utc()`**

Return the current UTC time or *None* if not available. A UTC time is a tuple of (yyyy,MM,dd,hh,mm,ss,microseconds).

UTC time can be wrong if no fix has ever been obtained.


**`has_utc()`**

Return *True* if a UTC time is available.


**`enable(state)`**

Enable or disable the NMEA parser. Also clear any acquired position fix or UTC data when disabled.


**`parse(buffer, count)`**

Parse *count* bytes from the specified *buffer* (bytearray) and updates the internal state from valid NMEA sentences found (when enabled).

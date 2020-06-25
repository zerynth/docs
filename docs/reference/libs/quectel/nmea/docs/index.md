# NMEA Module

This module implements a Zerynth driver and parser for a generic NMEA GNSS receiver.

The following functionalities are implemented:


* retrieve the current location fix if present


* retrieve the current UTC time

The driver supports reading NMEA sentences from a serial port only.

Location fixes are obtained by parsing NMEA sentences of type RMC and GGA, and optionally GSA. 
Obtaining a fix or UTC time are thread safe operations.

Contents:


* [NMEA Module](https://docs.zerynth.com/latest/official/lib.quectel.nmea/docs/official_lib.quectel.nmea_nmea.html)
<!--stackedit_data:
eyJoaXN0b3J5IjpbNDk1OTkzNjUzXX0=
-->
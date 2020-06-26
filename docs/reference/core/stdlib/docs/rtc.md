# Real-Time Clock

This module loads the Real-Time Clock (rtc) driver of the embedded device when available (the chip family should be equipped with a rtc and a driver should have been developed, look at the bottom of this page for info about supported chip families).

When imported, automatically sets the system rtc driver to the default one.


`init(drvname)`

Loads the rtc driver identified by ```drvname```

Returns the previous driver without disabling it.


`set_utc(seconds, microseconds=0)`


* ```Arguments```

    
    * ```seconds``` – integer Unix timestamp containing the total number of seconds from the 1st of January 1970 at UTC


    * ```microseconds``` – integer number representing the microseconds part of the timestamp to reach sub-second precision


Sets a Coordinated Universal Time (UTC) reference for the rtc.


`TimeInfo()`

Class containing useful time information to be filled by the `get_utc()` function.
List of attributes:


* `Timeinfo.tv_seconds`: Unix timestamp containing the total number of seconds from the 1st of January 1970 at UTC;


* `Timeinfo.tv_microseconds`: number of microseconds to complete the timestamp with sub-second precision;


* `Timeinfo.tm_year`: current year


* `Timeinfo.tm_month`: months since January (0-11)


* `Timeinfo.tm_mday`: day of the month (1-31)


* `Timeinfo.tm_hour`: hours since midnight (0-23)


* `Timeinfo.tm_min`: minutes after the hour (0-59)


* `Timeinfo.tm_sec`: seconds after the minute (0-59)


* `Timeinfo.tm_wday`: days since Sunday (0-6)


* `Timeinfo.tm_yday`: days since January 1 (0-365)


`get_utc(verbosity=2)`

When called with verbosity parameter set to `2`, returns a `TimeInfo()` object filled with info derived from the rtc.
Only `Timeinfo.tv_seconds` and `Timeinfo.tv_microseconds` are guaranteed to be filled correctly.
The availability of the other fields depend on the underlying driver implementation.

When called with verbosity parameter set to `1`, returns a tuple containing timestamp seconds and microseconds.

When called with verbosity parameter set to `0`, returns a single integer representing the Unix timestamp.

## Real-Time Clock for ESP32 devices

When synchronized, ESP32 will perform timekeeping using built-in timers:


* RTC clock is used to maintain accurate time when chip is in deep sleep mode


* FRC1 timer is used to provide time at microsecond accuracy when ESP32 is running.
<!--stackedit_data:
eyJoaXN0b3J5IjpbNDQwNjQ4ODY5XX0=
-->
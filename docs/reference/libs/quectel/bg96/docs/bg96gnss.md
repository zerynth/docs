# BG96_GNSS Module

This module implements the Zerynth driver for the Quectel BG96 GNSS functionality
on its dedicated UART port ([Product page](https://www.quectel.com/product/bg96gnss.htm)).

The following functionalities are implemented:

* retrieve the current location fix if present
* retrieve the current UTC time

The driver starts a background thread continuously tracking the last available location fix.
The frequency of fixes can be customized.
The driver support serial mode only.

Location fixes are obtained by parsing NMEA sentences of type RMC and GGA.
Obtaining a fix or UTC time are thread safe operations.


**`class BG96_GNSS(ifc, baud=9600)`**

Create an instance of the BG96_GNSS class.


**Arguments:**

    
* **ifc** – serial interface to use (for example `SERIAL1`, `SERIAL2`, etc…)
* **baud** – serial port baudrate


Example:

```py
from quectel.bg96gnss import bg96gnss

...

gnss = bg96gnss.BG96_GNSS(SERIAL1)
gnss.start()
mpl.init()
alt = mpl.get_alt()
pres = mpl.get_pres()
```


**`start()`**

Start the BG96 GNSS and the receiver thread.


**Arguments:** **use_uart** – 1 if BG96’s UART3 must be used, 0 otherwise

**Returns:** **True** if receiver thread has been started, *False* if already active.



**`stop()`**

Stop the BG96 GNSS and terminates the receiver thread.
It can be restarted by calling start.

**Returns:** **True** if receiver thread has been stopped, *False* if already inactive.



**`pause()`**

Pause the BG96 GNSS by putting it into standby mode. It can be restarted by calling resume.


**`resume()`**

Wake up the BG96_GNSS from standby mode.


**`set_rate(rate=1000)`**

Set the frequency for location fix (100-10000 milliseconds is the available range).

## NMEA

Additional methods from the base class `nmea.NMEA_Receiver`.


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


**`has_fix()`**

Return *True* if a fix is available.


**`utc()`**

Return the current UTC time or *None* if not available. A UTC time is a tuple of (yyyy,MM,dd,hh,mm,ss,microseconds).

UTC time can be wrong if no fix has ever been obtained.


**`has_utc()`**

Return *True* if a UTC time is available.

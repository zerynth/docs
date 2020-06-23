# TeseoLiv3F Module

This module implements the Zerynth driver for the STM Teseo Liv3F GNSS chip ([Product page](https://www.st.com/en/positioning/teseo-liv3f.html)).

The following functionalities are implemented:


* retrieve the current location fix if present
* retrieve the current UTC time

The driver starts a background thread continuously tracking the last available location fix. The frequency of fixes can be customized.
The driver support serial mode only.

Location fixes are obtained by parsing NMEA sentences of type RMC and GGA. Obtaining a fix or UTC time are thread safe operations.


**`class Teseo(ifc, mode=SERIAL, baud=9600, clock=400000, addr=0x00)`**

Creates an intance of TeseoLiv3F.


**Arguments:**

    
* **ifc** – interface used. One of SERIAL0, SERIAL1, …
* **mode** – one of SERIAL or I2C. Only SERIAL mode supported at the moment.
* **baud** – serial speed
* **clock** – I2C clock frequency (not supported)
* **addr** – I2C address (not supported)


Example:

```py
from teseoliv3f import TeseoLiv3F

...

gnss = TeseoLiv3F.TeseoLiv3F(SERIAL1)
gnss.start()
mpl.init()
alt = mpl.get_alt()
pres = mpl.get_pres()
```


**`start(rstpin=None, rstval=0)`**

Start the TeseoLiv3F.


**Arguments:**

    
* **rstpin** – if given, uses `rstpin` as the reset pin of Teseo Liv3F
* **rstval** – the value to move `rstpin` to



**`stop()`**

Stop the TeseoLiv3F by putting it into backup mode. It can be restarted only by setting the FORCE_ON pin to high. Refer to the Teseo Liv3F documentation for details [here](https://www.st.com/resource/en/datasheet/teseo-liv3f.pdf).


**`pause()`**

Stop the Teseo Liv3F by putting it into standby mode. It can be restarted by calling resume. Refer to the Teseo Liv3F documentation for details [here](https://www.st.com/resource/en/datasheet/teseo-liv3f.pdf).


**`resume()`**

Wake up the Teseo Liv3F from standby mode. Refer to the Teseo Liv3F documentation for details [here](https://www.st.com/resource/en/datasheet/teseo-liv3f.pdf).

**set_rate(rate=1000)`**

Set the frequency for location fix (100-10000 milliseconds is the available range).


**`fix()**`

Return the current fix or None if no fix is available.
A fix is a tuple with the following elements:


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

Return True if a fix is available.


**`utc()`**

Return the current UTC time or None if no UTC time is available.
A UTC time is a tuple of (yyyy,MM,dd,hh,mm,ss,microseconds).

UTC time can be wrong if no fix has ever been obtained.

**`has_utc()`**

Return True if a UTC time is available.

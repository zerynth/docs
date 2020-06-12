# DLH Module

This module contains the Zerynth driver for Amphenol DLH pressure sensors series. These calibrated and compensated sensors provide accurate, stable output over a wide temperature range. This series is intended for use with non-corrosive, non-ionic working fluids such as air, dry gases and the like.

## The driver implements SPI communication.

DLH Class

**`class DLH(spidrv, cs, d_or_g, clock=2000000)`**

Creates an instance of the DLH class.


**Arguments:**

    

 - **spidrv** – SPI Bus used ‘( SPI0, … )’   
 -  **cs** – GPIO to be used as Carrier Select   
 -  **d_or_g** – specifies DLH type D (differential)
   or G (absolute) sensor. can be one of `TYPE_D` or `TYPE_G` constants 
   - **clock** – spi clock to be used

Temperature and pressure values can be easily obtained from the sensor:

```
from amphenol.dlh import dlh

...

d = dlh.DLH(SPI0, D10, dlh.TYPE_D)

press, temp = d.get_values(unit=dlh.UNIT_PASCAL)
```



**`get_values(mode=MODE_SINGLE, unit=UNIT_INH20)`**

Return a 2-element tuple containing current pressure and temperature values.
The acquisition mode can be specified with one of:


* `MODE_SINGLE`


* `MODE_AVG2`


* `MODE_AVG4`


* `MODE_AVG8`


* `MODE_AVG16`

The unit of measure of pressure can be specified in:


* `UNIT_INH20`


* `UNIT_CMH20`


* `UNIT_PASCAL`
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE1Mzk4MjY5OCwtMTg0MjU1Mjg5Ml19
-->
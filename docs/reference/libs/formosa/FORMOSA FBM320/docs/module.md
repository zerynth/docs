# FBM320 Module

This module contains the Zerynth driver for FBM320 digital barometer. The FBM320 is a digital pressure sensor which consists of a MEMS piezoresistive pressure sensor and a signal conditioning ASIC. The ASIC include a 24bits sigma-delta ADC, OTP memory for calibration data, and serial interface circuits. The FBM320 features I2C and SPI digital interfaces, the present library enables I2C only.

## FBM320 class

_class_`FBM320`(_drvname_,  _addr=0x6D_,  _clk=400000_)

Creates an intance of the FBM320 class.

Parameters:

-   **drvname**  – I2C Bus used ‘( I2C0, ... )’
-   **addr**  – Slave address, default 0x6D If SDO pin is pulled low, I2C address is 6C. If SDO pin is pulled high, I2C address is 6D.
-   **clk**  – Clock speed, default 400kHz

Barometer values can be easily obtained from the sensor:
```python
from formosa.fbm320 import fbm320

...

fbm = fbm320.FBM320(I2C0)

temp, press, altitude = fbm.get_values()
```

`set_osr`(_osr_)

##Parameters:

**osr**  – is the oversampling rate to set. Values accepted: 1024, 2048, 4096 or 8192.

Set oversampling rate.

`get_temp`()

Return the temperature in degrees Celsius.

`get_press`()

Return the pressure in hPa.

`get_altitude`(_pressure_)

Parameters:

**pressure**  – pressure value in hPa.

Return the altitude in metres.

`get_values`()

Return the temperature (°C), pressure (hPa) and altitude (m) in a list [temperature, pressure, altitude].
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwNDQxMDMzOTVdfQ==
-->

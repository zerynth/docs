# MAG3110 Module

This module contains the Zerynth driver for MAG3110 digital sensor. It features a standard I2C serial interface output and smart embedded functions. The MAG3110 is capable of measuring magnetic fields with an output data rate (ODR) up to 80 Hz; these output data rates correspond to sample intervals from 12.5 ms to several seconds.

## MAG3110 class

###### class MAG3110

_class_`MAG3110`(_drvname_,  _addr=0x0E_,  _clk=400000_)

Creates an intance of the MAG3110 class.

Parameters:

-   **drvname**  – I2C Bus used ‘( I2C0, ... )’
-   **addr**  – Slave address, default 0x0E
-   **clk**  – Clock speed, default 400kHz

Magnetometer values can be easily obtained from the sensor:

```python
from nxp.mag3110 import mag3110

...

mag = mag3110.MAG3110(I2C0)

mag_values = mag.get_values()
```
###### set_measurement

`set_measurement`(_mode = 0_,  _osr = 32_,  _odr = 1_)

**Parameters**:

**mode**: is the measurement mode to set (default value = 0). Values accepted: 0 or 1.

| mode | Measurement mode        |
|------|-------------------------|
| 0    | Continuous measurements |
| 1    | Triggered measurements  |

**osr**: is oversampling rate to set (default value = 32). Values accepted: 16, 32, 64 or 128.

**odr**: is output data rate to set (default value = 1). Values range accepted: 0-7.

Set the measurement mode, the oversampling rate and output data rate.

###### set_mode

`set_mode`(_mode_)

**Parameters**:

**mode**: is the operation mode to set. Values accepted: 0 or 1.

| mode | Operating mode |
|------|----------------|
| 0    | Standby mode   |
| 1    | Active mode    |

Set the operating mode.

###### set_offset_on

`set_offset_on`()

Enable the correction of data values according to offset register values.

###### set_offet_off

`set_offset_off`()

Disable the correction of data values according to offset register values.

###### set_offset

`set_offset`(_axis_,  _offset_)

Parameters:

-   **axis**  – is the axis to set. Values accepted: “X”, “Y” or “Z”.
-   **offset**  – is the offset to set to the axis indicated. Values range accepted: [-10000, 10000].

Set offset to the axis specified.

###### is_data_ready

`is_data_ready`()

Return 1 if new data ready, otherwise 0.

###### trigger_measurement

`trigger_measurement`()

Set measurement in trigger mode.

###### get_values

`get_values`()

Return the X, Y and Z values of the magnetometer in a dictionary.

###### set_offset_temp

`set_offset_temp`(_value = 10_)

Parameters:

**value**  – is the value of temperature offset to set. Default value is 10.

Set the offset value of temperature.

###### get_temp

`get_temp`()

Return the temperature in degrees Celsius.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTI1NjYxMTg5NiwtMTY5NzU5MDgxMV19
-->
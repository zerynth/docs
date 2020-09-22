# MPU6050 Module

This module contains the Zerynth driver for MPU6050 digital motion sensor. The MPU6050 features three 16-bit analog-to-digital converters (ADCs) for digitizing the gyroscope outputs and three 16-bit ADCs for digitizing the accelerometer outputs. For precision tracking of both fast and slow motions, the parts feature a user-programmable gyroscope full-scale range of ±250, ±500, ±1000, and ±2000°/sec (dps) and a user-programmable accelerometer full-scale range of ±2g, ±4g, ±8g, and ±16g. Communication with all registers of the device is performed using I2C at 400kHz. Additional features include an embedded temperature sensor.

## MPU6050 class

_class_`MPU6050`(_drvname_,  _addr=0x68_,  _clk=400000_)

Creates an intance of the MPU6050 class.

Parameters:

-   **drvname**  – I2C Bus used ‘( I2C0, ... )’
-   **addr**  – Slave address, default 0x68
-   **clk**  – Clock speed, default 400kHz

Temperature, accelerometer and gyroscope value can be easily obtained from the sensor:

```python
from invensense.mpu6050 import mpu6050

...

mpu = mpu6050.mpu6050(I2C0)

temp, acc, gyro = mpu.get_values()
```

`set_dlpf_mode`(_dlpf_)

**Parameters**:

**dlpf**: is the DLPF mode to set. Values range accepted are 0-7 (see datasheet).

Set the DLPF mode.

`set_dhpf_mode`(_dhpf_)

**Parameters**:

**dhpf**: is the DHPF mode to set. Values accepted are 0, 1, 2, 3, 4 or 7.


| dhpf | DHPF mode    |
|------|--------------|
| 0    | Reset        |
| 1    | On @ 5 Hz    |
| 2    | On @ 2.5 Hz  |
| 3    | On @ 1.25 Hz |
| 4    | On @ 0.63 Hz |
| 7    | Hold         |


Set the DHPF mode.

`get_clock_source`()

Return the clock source the sensor is set to.

`set_clock_source`(_clksel_)

**Parameters**:

**clksel**: is the clock source to set. Values accepted are 0, 1, 2, 3, 4, 5 or 7.


| clksel | Clock source                                   |
|--------|------------------------------------------------|
| 0      | Internal 8MHz oscillator                       |
| 1      | PLL with X axis gyroscope reference            |
| 2      | PLL with Y axis gyroscope reference            |
| 3      | PLL with Z axis gyroscope reference            |
| 4      | PLL with external 32.768kHz reference          |
| 5      | PLL with external 19.2MHz reference            |
| 6      | Reserved                                       |
| 7      | Stops the clock and keeps the timing generator |


Set the clock source.

`get_temp`()

Return the temperature in degrees Celsius.

`set_accel_fullscale`(_full_scale_)

Parameters:

**full_scale**  – is the full-scale range to set the accelerometer to. Possible values are 2, 4, 8 or 16.

Set the full-scale range of the accelerometer.

`get_accel_fullscale`()

Return the full-scale value the accelerometer is set to. When something went wrong, it returns -1.

`get_accel_values`(_g = False_)

Parameters:

**g**  – is the format of accelerometer values. If g = False is m/s^2, otherwise is g. Default value is False.

Return the X, Y and Z accelerometer values in a dictionary.

`set_gyro_fullscale`(_full_scale_)

Parameters:

**full_scale**  – is the full-scale range to set the gyroscope to. Values accepted: 250, 500, 1000 or 2000.

Set the full-scale range of the gyroscope.

`get_gyro_fullscale`()

Return the full-scale value the gyroscope is set to. When something went wrong, it returns -1.

`get_gyro_values`()

Return the X, Y and Z gyroscope values in a dictionary.

`get_values`(_g = False_)

Parameters:

**g**  – is the format of accelerometer values. If g = False is m/s^2, otherwise is g. Default value is False.

Return the values of temperature, gyroscope and accelerometer in a list [temp, accel, gyro].

`is_motion_detected`()

Return 1 if a motion has been detected, otherwise 0.

`is_data_ready`()

Return 1 if data is ready, otherwise 0.

`setup_motion`()

Set the configuration for motion detection.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc0MzE0ODQ2OF19
-->
# MPU9250 Module

MPU-9250 features three 16-bit analog-to-digital converters (ADCs) for digitizing the gyroscope outputs, three 16-bit ADCs for digitizing the accelerometer outputs, and three 16-bit ADCs for digitizing the magnetometer outputs. For precision tracking of both fast and slow motions, the parts feature a user-programmable gyroscope full-scale range of ±250, ±500, ±1000, and ±2000°/sec (dps), a user-programmable accelerometer full-scale range of ±2g, ±4g, ±8g, and ±16g, and a magnetometer full-scale range of ±4800µT. Communication with all registers of the device is performed using I2C at 400kHz. Additional features include an embedded temperature sensor.

## MPU9250 class

```py
classMPU9250(drvname, addr, clk=400000)
```

Creates an intance of the MPU9250 class.

**Parameters:**

- **drvname**: I2C Bus used ‘( I2C0, ... )’
- **addr**: Slave address, default 0x69
- **clk**: Clock speed, default 400kHz
  
Temperature, accelerometer, gyroscope and magnetometer values can be easily obtained from the sensor:

```py
from invensense.mpu9250 import mpu9250

...

mpu = mpu9250.MPU9250(I2C0)

temp, acc, gyro, magneto = mpu.get_values()
```
```py
set_dlpf_mode(dlpf)
```
**Parameters:**

**dlpf**: is the DLPF mode to set. Values range accepted are 0-7 (see datasheet).

Set the DLPF mode.

```py
get_clock_source()
```

Return the clock source the sensor is set to.

```py
set_clock_source(clksel)
```

**Parameters:**

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

```py
get_temp()
```
Return the temperature in degrees Celsius.

```py
set_accel_fullscale(full_scale)
```

**Parameters:**	

**full_scale**: is the full-scale range to set the accelerometer to. Possible values are 2, 4, 8 or 16.

Set the full-scale range of the accelerometer.

```py
get_accel_fullscale()
```

Return the full-scale value the accelerometer is set to. When something went wrong, it returns -1.

```py
get_accel_values(g = False)
```

**Parameters:**	

**g**: is the format of accelerometer values. If g = False is m/s^2, otherwise is g. Default value is False.

Return the X, Y and Z accelerometer values in a dictionary.

```py
set_gyro_fullscale(full_scale)
```
**Parameters:**

**full_scale**: is the full-scale range to set the gyroscope to. Values accepted: 250, 500, 1000 or 2000.

Set the full-scale range of the gyroscope.

```py
get_gyro_fullscale()
```

Return the full-scale value the gyroscope is set to. When something went wrong, it returns -1.

```py
get_gyro_values()
```

Return the X, Y and Z gyroscope values in a dictionary.

```py
set_magneto_config(mfs = 0, mode = 0)
```

**Parameters:**

**mfs**: is the magneto scale (default value is 0).

| mfs | Magneto Scale     |
|-----|-------------------|
| 0   | 14 bit resolution |
| 1   | 16 bit resolution |

mode: is the magneto mode (default value is 0).

| mode | Magneto Mode                |
|------|-----------------------------|
| 0    | Continous data output 8Hz   |
| 1    | Continous data output 100Hz |

Set the magnetometer scale and mode.

```py
get_magneto_values()
```

Return the X, Y and Z magnetometer values in a dictionary.

```py
get_values(g = False)
```

**Parameters:**

**g**: is the format of accelerometer values. If g = False is m/s^2, otherwise is g. Default value is False.

Return the values of temperature, gyroscope, accelerometer and magnetometer in a list [temp, accel, gyro, magneto].

```py
is_data_ready()
```

Return 1 if data is ready, otherwise 0.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTgxMDE4MjA4MF19
-->
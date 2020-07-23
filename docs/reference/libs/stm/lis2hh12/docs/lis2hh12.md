# LIS2HH12 Module

This module contains the driver for STMicroelectronics LIS2HH12 3-axis accelerometer.

##### class LIS2HH12

```#!py3 class LIS2HH12()```

Class which provides a simple interface to LIS2HH12 features.
###### LIS2HH12.__init__

```#!py3 __init__(spidrv, pin_cs, clk=5000000, odr=ODR_100HZ, fs=FS_2G, sf=SF_SI)```

Creates an instance of LIS2HH12 class, using the specified SPI settings
and initial device configuration.


**Arguments:**

    
* **spidrv** – the *SPI* driver to use (SPI0, …)
* **pin_cs** – Chip select pin to access the NCV7240 chip
* **clk** – Clock speed, default 5 MHz
* **odr** – Device output data rate, default 100 Hz
* **sf** – Scaling factor, one of `SF_G` (unit=g) or `SF_SI` (unit=m/s^2 default)


###### LIS2HH12.acceleration

```#!py3 acceleration()```

Acceleration measured by the sensor.


**Returns:** By default will return a 3-tuple of X, Y, Z axis acceleration values in **m/s^2**. Will return values in **g** if constructor was provided `sf=SF_G` parameter.


###### LIS2HH12.temperature

```#!py3 temperature()```

Temperature measured by the sensor.

**Returns:** Die temperature in Celsius degrees.

###### LIS2HH12.whoami

```#!py3 whoami()```

Value of the *WHO_AM_I* register (0x41).

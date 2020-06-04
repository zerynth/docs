# LIS2HH12 Module

This module contains the driver for STMicroelectronics LIS2HH12 3-axis accelerometer.


---
#### `#!py3 LIS2HH12()`

!!!abstract "`#!py3 LIS2HH12()`"

Class which provides a simple interface to LIS2HH12 features.


### lis2hh12.\__init__(spidrv, pin_cs, clk=5000000, odr=ODR_100HZ, fs=FS_2G, sf=SF_SI)
Creates an instance of LIS2HH12 class, using the specified SPI settings
and initial device configuration.


* ```Arguments```

    
    * ```spidrv``` – the ```SPI``` driver to use (SPI0, …)


    * ```pin_cs``` – Chip select pin to access the NCV7240 chip


    * ```clk``` – Clock speed, default 5 MHz


    * ```odr``` – Device output data rate, default 100 Hz


    * ```fs``` – Device full-scale setting, default +/-2g


    * ```sf``` – Scaling factor, one of `SF_G` (unit=g) or `SF_SI` (unit=m/s^2 default)



---
#### `#!py3 acceleration()`

!!!abstract "`#!py3 acceleration()`"

Acceleration measured by the sensor.


* ```Returns```

    By default will return a 3-tuple of X, Y, Z axis acceleration         values in **m/s^2**. Will return values in ```g``` if constructor was provided         `sf=SF_G` parameter.



---
#### `#!py3 temperature()`

!!!abstract "`#!py3 temperature()`"

Temperature measured by the sensor.


* ```Returns```

    Die temperature in Celsius degrees.



---
#### `#!py3 whoami()`

!!!abstract "`#!py3 whoami()`"

Value of the ```WHO_AM_I``` register (0x41).

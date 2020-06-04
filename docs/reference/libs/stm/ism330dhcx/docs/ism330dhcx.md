# ISM330DHCX Module

This module contains the driver for STMicroelectronics ISM330DHCX 3-axis accelerometer and gyroscope.

In the ISM330DHCX, the sensing elements of the accelerometer and of the gyroscope are implemented on the same silicon die, thus guaranteeing superior stability and robustness. ([datasheet](https://www.st.com/resource/en/datasheet/ism330dhcx.pdf)).


---
#### `#!py3 ISM330DHCX()`

!!!abstract "`#!py3 ISM330DHCX(spidrv, pin_cs, clk=5000000)`"

Class which provides a simple interface to ISM330DHCX features.

Creates an instance of ISM330DHCX class, using the specified SPI settings
and initial device configuration


* ```Arguments```

    
    * ```spidrv``` – the ```SPI``` driver to use (SPI0, …)


    * ```pin_cs``` – Chip select pin to access the ISM330DHCX chip


    * ```clk``` – Clock speed, default 500 kHz


Example:

```
from stm.ism330dhcx import ism330dhcx

...

accgyro = ism330dhcx.ISM330DHCX(SPI0, D10)
acc = accgyro.get_acc_data()
gyro = accgyro.get_gyro_data()
```


---
#### `#!py3 reset()`

!!!abstract "`#!py3 reset()`"

Reset the device using the internal register flag.


---
#### `#!py3 enable_acc()`

!!!abstract "`#!py3 enable_acc(odr=ISM330DHCX_ODR_417Hz, fs=0)`"

Sets the device’s configuration registers for accelerometer.

**Parameters:**


* ```odr``` : sets the Output Data Rate of the device. Available values are:

| Value

 | Output Data Rate

 | Constant Name

 |
| ----- | ---------------- | ------------- |
| 0x00

  | OFF

              | ISM330DHCX_ODR_OFF

 |
| 0x01

  | 12.5 Hz

          | ISM330DHCX_ODR_12Hz5

 |
| 0x02

  | 26 Hz

            | ISM330DHCX_ODR_26Hz

  |
| 0x03

  | 52 Hz

            | ISM330DHCX_ODR_52Hz

  |
| 0x04

  | 104 Hz

           | ISM330DHCX_ODR_104Hz

 |
| 0x05

  | 208 Hz

           | ISM330DHCX_ODR_208Hz

 |
| 0x06

  | 417 Hz

           | ISM330DHCX_ODR_417Hz

 |
| 0x07

  | 833 Hz

           | ISM330DHCX_ODR_833Hz

 |
| 0x08

  | 1.667 KHz

        | ISM330DHCX_ODR_1667Hz

 |
| 0x09

  | 3.333 KHz

        | ISM330DHCX_ODR_3333Hz

 |
| 0x0A

  | 6.667 KHz

        | ISM330DHCX_ODR_6667Hz

 |
| 0x0B

  | 6.5 Hz

           | ISM330DHCX_ODR_6Hz5

   |

* ```fs``` : sets the Device Full Scale. Available values are:

| Value

 | Full Scale

       | Costant Name

          | in mg/LSB

 |
| ----- | ---------------- | --------------------- | --------- |
| 0x00

  | ±2g

              | ISM330DHCX_ACC_SENS_FS_2G

 | 0.061 mg/LSB

 |
| 0x01

  | ±4g

              | ISM330DHCX_ACC_SENS_FS_4G

 | 0.122 mg/LSB

 |
| 0x02

  | ±8g

              | ISM330DHCX_ACC_SENS_FS_8G

 | 0.244 mg/LSB

 |
| 0x03

  | ±16g

             | ISM330DHCX_ACC_SENS_FS_16G

 | 0.488 mg/LSB

 |
Returns True if configuration is successful, False otherwise.


---
#### `#!py3 disable_acc()`

!!!abstract "`#!py3 disable_acc()`"

Disables the accelerator sensor.

Returns True if configuration is successful, False otherwise.


---
#### `#!py3 enable_gyro()`

!!!abstract "`#!py3 enable_gyro(odr=ISM330DHCX_ODR_417Hz, fs=0)`"

Sets the device’s configuration registers for gyroscope.

**Parameters:**


* ```odr``` : sets the Output Data Rate of the device. Available values are:

| Value

 | Output Data Rate

 | Constant Name

              |
| ----- | ---------------- | -------------------------- |
| 0x00

  | OFF

              | ISM330DHCX_ODR_OFF

         |
| 0x01

  | 12.5 Hz

          | ISM330DHCX_ODR_12Hz5

       |
| 0x02

  | 26 Hz

            | ISM330DHCX_ODR_26Hz

        |
| 0x03

  | 52 Hz

            | ISM330DHCX_ODR_52Hz

        |
| 0x04

  | 104 Hz

           | ISM330DHCX_ODR_104Hz

       |
| 0x05

  | 208 Hz

           | ISM330DHCX_ODR_208Hz

       |
| 0x06

  | 417 Hz

           | ISM330DHCX_ODR_417Hz

       |
| 0x07

  | 833 Hz

           | ISM330DHCX_ODR_833Hz

       |
| 0x08

  | 1.667 KHz

        | ISM330DHCX_ODR_1667Hz

      |
| 0x09

  | 3.333 KHz

        | ISM330DHCX_ODR_3333Hz

      |
| 0x0A

  | 6.667 KHz

        | ISM330DHCX_ODR_6667Hz

      |

* ```fs``` : sets the Device Full Scale. Available values are:

| Value

 | Full Scale

       | Costant Name

               | in mdps/LSB

  |
| ----- | ---------------- | -------------------------- | ------------ |
| 0x00

  | ±125 dps

         | ISM330DHCX_GYRO_SENS_FS_125DPS

 | 4.375 mdps/LSB

 |
| 0x01

  | ±250 dps

         | ISM330DHCX_GYRO_SENS_FS_250DPS

 | 8.750 mdps/LSB

 |
| 0x02

  | ±500 dps

         | ISM330DHCX_GYRO_SENS_FS_500DPS

 | 17.500 mdps/LSB

 |
| 0x03

  | ±1000 dps

        | ISM330DHCX_GYRO_SENS_FS_1000DPS

 | 35.000 mdps/LSB

 |
| 0x04

  | ±2000 dps

        | ISM330DHCX_GYRO_SENS_FS_2000DPS

 | 70.000 mdps/LSB

 |
| 0x05

  | ±4000 dps

        | ISM330DHCX_GYRO_SENS_FS_4000DPS

 | 140.000 mdps/LSB

 |
Returns True if configuration is successful, False otherwise.


---
#### `#!py3 disable_gyro()`

!!!abstract "`#!py3 disable_gyro()`"

Disables the gyroscope sensor.

Returns True if configuration is successful, False otherwise.


---
#### `#!py3 whoami()`

!!!abstract "`#!py3 whoami()`"

Value of the ```ISM330DHCX_WHO_AM_I``` register (0x6B).


---
#### `#!py3 get_acc_data()`

!!!abstract "`#!py3 get_acc_data(ms2=True, raw=False)`"

Retrieves accelerometer data in one call.


* ```Arguments```

    
    * ```ms2``` – If ms2 flag is True, returns data converted in m/s^2; otherwise in mg (default True)


    * ```raw``` – If raw flag is True, returns raw register values (default False)


Returns acc_x, acc_y, acc_z


---
#### `#!py3 get_gyro_data()`

!!!abstract "`#!py3 get_gyro_data(dps=True, raw=False)`"

Retrieves gyroscope data in one call.


* ```Arguments```

    
    * ```dps``` – If dps flag is True, returns data converted in dps; otherwise in mdps (default True)


    * ```raw``` – If raw flag is True, returns raw register values (default False)


Returns gyro_x, gyro_y, gyro_z


---
#### `#!py3 get_temp()`

!!!abstract "`#!py3 get_temp()`"

Retrieves temperature in one call; if raw flag is enabled, returns raw register values.

Returns temp


---
#### `#!py3 get_fast()`

!!!abstract "`#!py3 get_fast()`"

Retrieves all data sensors in one call in fast way (c-code acquisition).


* Temperature in °C


* Acceleration in m/s^2


* Angular Velocity in dps (degrees per second)

Returns temp, acc_x, acc_y, acc_z, gyro_x, gyro_y, gyro_z


---
#### `#!py3 set_event_interrupt()`

!!!abstract "`#!py3 set_event_interrupt(pin_int, sensor, enable)`"

Enables the interrupt pins. When data from sensor selected will be ready, the related interrupt pin configured will be set to high.


* ```Arguments```

    
    * ```pin_int``` – ID of the interrupt pin to be enabled/disabled. Available values are 1 o 2.


    * ```sensor``` – Data Ready flag selector. Available values are “acc” or “gyro”.


    * ```enable``` – If enable flag is True, interrupt pin will be enabled, otherwise will be disabled.


Returns True if configuration is successful, False otherwise.

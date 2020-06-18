# FXOS8700CQ Module

This module contains the driver for NXP FXOS8700CQ accelerometer and magnetometer. The FXOS8700CQ provides direct I2C communication and the accelerometer can be set on 3 different full-scale range and 8 different over sample rate values  ([datasheet](http://www.nxp.com/assets/documents/data/en/data-sheets/FXOS8700CQ.pdf)).


**`class FXOS8700CQ(i2cdrv,addr=0x1E,clk=400000)`**

Creates an intance of a new FXOS8700CQ.


* ```Arguments```

    
    * ```i2cdrv``` – I2C Bus used ‘( I2C0, … )’


    * ```addr``` – Slave address, default 0x1E


    * ```clk``` – Clock speed, default 400kHz


Example:

```py
from nxp.fxos8700cq import fxos8700cq

...

fxos = fxos8700cq.FXOS8700CQ(I2C0)
fxos.start()
fxos.init()
acc = fxos.get_acc()
mag = fxos.get_mag()
```


**`init(mode=ACCMAG,odr=0,osr=0,range=RANGE4G)`**

Initialize the FXOS8700CQ setting the operating mode, the output data rate , the full-scale range and the oversample ratio.


* ```Arguments```

    
    * ```mode``` – select the operating mode (allowed values: ACCONLY for accelerometer only, MAGONLY for magnetometer only, ACCMAG for both active), default ACCMAG


    * ```odr``` – set the output data rate (from 0 to 7 - refer to page 44 of the FXOS8700CQ datasheet), default 0


    * ```osr``` – set the over sample ratio for magnetometer (from 0 to 7 - refer to page 97 of the FXOS8700CQ datasheet), default 0


    * ```range``` – accelerometer full-scale range (allowed values RANGE2G, RANGE4G, RANGE8G), default RANGE4G


| ODR

 | ACC/MAG Mode

 | Data Ready ACC/MAG

 | Hybrid Mode

 | Data Ready Hybrid

 |
| --- | ------------ | ------------------ | ----------- | ----------------- |
| 0

   | 800 Hz

       | 1.25 ms

            | 400 Hz

      | 2.5 ms

            |
| 1

   | 400 Hz

       | 2.5 ms

             | 200 Hz

      | 5 ms

              |
| 2

   | 200 Hz

       | 5 ms

               | 100 Hz

      | 10 ms

             |
| 3

   | 100 Hz

       | 10 ms

              | 50 Hz

       | 20 ms

             |
| 4

   | 50 Hz

        | 20 ms

              | 25 Hz

       | 80 ms

             |
| 5

   | 12.5 Hz

      | 80 ms

              | 6.25 Hz

     | 160 ms

            |
| 6

   | 6.25 Hz

      | 160 ms

             | 3.125 Hz

    | 320 ms

            |
| 7

   | 1.56 Hz

      | 640 ms

             | 0.7813

      | 1280 ms

           |
| ODR

 | OSR=0

        | OSR=1

              | OSR=2

       | OSR=3

             | OSR=4

 | OSR=5

 | OSR=6

 | OSR=7

 |
| --- | ------------ | ------------------ | ----------- | ----------------- | ----- | ----- | ----- | ----- |
| 1.56 Hz

 | 16

           | 16

                 | 32

          | 64

                | 128

   | 256

   | 512

   | 1024

  |
| 6.25 Hz

 | 4

            | 4

                  | 8

           | 16

                | 32

    | 64

    | 128

   | 256

   |
| 12.5 Hz

 | 2

            | 2

                  | 4

           | 8

                 | 16

    | 32

    | 64

    | 128

   |
| 50 Hz

   | 2

            | 2

                  | 2

           | 2

                 | 4

     | 8

     | 16

    | 32

    |
| 100 Hz

  | 2

            | 2

                  | 2

           | 2

                 | 2

     | 4

     | 8

     | 16

    |
| 200 Hz

  | 2

            | 2

                  | 2

           | 2

                 | 2

     | 2

     | 4

     | 8

     |
| 400 Hz

  | 2

            | 2

                  | 2

           | 2

                 | 2

     | 2

     | 2

     | 4

     |
| 800 Hz

  | 2

            | 2

                  | 2

           | 2

                 | 2

     | 2

     | 2

     | 2

     |

**`get_raw_acc()`**

Retrieves the current accelerometer data as a tuple of X, Y, Z, raw values

Returns [ax, ay, az]


---
#### `#!py3 get_raw_mag()`

!!!abstract "`#!py3 get_raw_mag()`"

Retrieves the current magnetometer data as a tuple of X, Y, Z, raw values

Returns [mx, my, mz]


---
#### `#!py3 get_raw_int_temp()`

!!!abstract "`#!py3 get_raw_int_temp()`"

Retrieves the current internal temperature data as raw values

Returns raw_t


---
#### `#!py3 get_acc()`

!!!abstract "`#!py3 get_acc(axis=None)`"

Retrieves the current accelerometer data in m/s^2 as a tuple of X, Y, Z values or single axis value if axis argument is provided.


* ```Arguments```

    
    * ```axis``` – select the axis (allowed values: “x” for x-axis, “y” for y-axis, “z” for z-axis); default None for all values


Returns [acc_x, acc_y, acc_z] or acc_x or acc_y or acc_z


---
#### `#!py3 get_mag()`

!!!abstract "`#!py3 get_mag(axis=None)`"

Retrieves the current magnetometer data in uT as a tuple of X, Y, Z values or single axis value if axis argument is provided.


* ```Arguments```

    
    * ```axis``` – select the axis (allowed values: “x” for x-axis, “y” for y-axis, “z” for z-axis); default None for all values


Returns [mag_x, mag_y, mag_z] or mag_x or mag_y or mag_z


---
#### `#!py3 get_int_temp()`

!!!abstract "`#!py3 get_int_temp(unit="C")`"

Retrieves the current device internal temperature value in Celtius, Kelvin or Fahrenheit degrees.


* ```Arguments```

    
    * ```unit``` – select the unit of measure for internal temperature (allowed values: “C” for Celtius degrees, “K” for Kelvin degrees, “F” Fahrenheit degrees); default “C”


Returns int_temp
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE1NzA0MzA1XX0=
-->
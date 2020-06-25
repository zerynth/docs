# HTU21D Module

This module contains the driver for MEAS HTU21D Relative Humidity and Temperature sensor. The HTU21D is capable of direct I2C communication and can be set on 4 different level of resolution in both temperature and humidity measurements ([datasheet](http://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FHPC199_6%7FA%7Fpdf%7FEnglish%7FENG_DS_HPC199_6_A.pdf%7FCAT-HSC0004)).


**`class HTU21D(i2cdrv,addr=0x40,clk=400000)`**

Creates an intance of a new HTU21D.


**Arguments:**

    
-	**i2cdrv** – I2C Bus used ‘( I2C0, … )’
-	**addr** – Slave address, default 0x40
-	**clk** – Clock speed, default 400kHz


Example:

```py
from meas.htu21d import htu21d

...

htu = htu21d.HTU21D(I2C0)
htu.start()
htu.init()
t,h = htu.get_temp_humid()
```


**`init(res=0)`**

Initialize the HTU21D setting the resolution of the sensor.


**Arguments:**

    
-	**res** – set the resolution (from 0 to 3) for temperature and humidity measurements according to the table below; default 0.


| res value

 | Humid Resolution

 | Temp Resolution

 | Meas. Time Humid

 | Meas. Time Temp

 |
| --------- | ---------------- | --------------- | ---------------- | --------------- |
| 0

         | 12 bits

          | 14 bits

         | 16 ms

            | 50 ms

           |
| 1

         | 8 bits

           | 12 bits

         | 3 ms

             | 13 ms

           |
| 2

         | 10 bits

          | 13 bits

         | 5 ms

             | 25 ms

           |
| 3

         | 11 bits

          | 11 bits

         | 8 ms

             | 7 ms

            |

**`get_raw_temp()`**

Retrieves the current temperature data from the sensor as raw value.

Returns raw_temp.


**`get_raw_humid()`**

Retrieves the current humidity data from the sensor as raw value.

Returns raw_humid.


**`get_temp()`**

Retrieves the current temperature data from the sensor as calibrate value in °C.

Returns temp.


**`get_humid()`**

Retrieves the current relative humidity data from the sensor as calibrate value in %RH.

Returns humid.


**`get_temp_humid()`**

Retrieves both temperature and humidity in one call.

Returns temp, humid.
<!--stackedit_data:
eyJoaXN0b3J5IjpbODkzNDU3OTddfQ==
-->

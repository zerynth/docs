# STTS751 Module

This module contains the driver for STMicroelectronics STTS751 temperature sensor.

Its highlight is that it outputs its measurement in a 9-bit to 12-bit (configurable) resolution. ([datasheet](https://www.st.com/resource/en/datasheet/stts751.pdf)).

##### class STTS751

```#!py3 class STTS751(drvsel, address=0x48, clk=400000)```

Creates an intance of a new STTS751.

**Arguments:**

    
* **drvsel** – I2C Bus used ( I2C0 )
* **address** – Slave address, default 0x48
* **clk** – Clock speed, default 400kHz


Example:

```py
from stm.stts751 import stts751

temp_sens = stts751.STTS751( I2C0 )
temp = temp_sens.get_temp()
```
###### STTS751.enable

```#!py3 enable(odr=ODR_AVAILABLE["ODR_125mHz"], resolution=STTS751_RES_12)```

Sets the device’s configuration registers.

**Parameters:**


* **odr** : sets the Output Data Rate of the device. Available values are:

| Value | Output Data Rate | Constant Name                 |
|-------|------------------|-------------------------------|
| 0x00  | 62,5 Mhz         | ODR_AVAILABLE[“ODR_62mHz5”]   |
| 0x01  | 125 MHz          | ODR_AVAILABLE[“ODR_125mHz”]   |
| 0x02  | 250 MHz          | ODR_AVAILABLE[“ODR_250mHz”]   |
| 0x03  | 500 MHz          | ODR_AVAILABLE[“ODR_500mHz”]   |
| 0x04  | 1 Hz             | ODR_AVAILABLE[“ODR_1Hz”]      |
| 0x05  | 2 Hz             | ODR_AVAILABLE[“ODR_2Hz”]      |
| 0x06  | 4 Hz             | ODR_AVAILABLE[“ODR_4Hz”]      |
| 0x07  | 8 Hz             | ODR_AVAILABLE[“ODR_8Hz”]      |
| 0x08  | 16 Hz            | ODR_AVAILABLE[“ODR_16Hz”]     |
| 0x09  | 32 Hz            | ODR_AVAILABLE[“ODR_32Hz”]     |
| 0x80  | OFF              | ODR_AVAILABLE[“ODR_OFF”]      |
| 0x90  | ONE SHOT         | ODR_AVAILABLE[“ODR_ONE_SHOT”] |

* **resolution** : sets the Resolution in bit of the conversion. Available values are:

| Value | N bit | Costant Name   | in °C/LSB     |
|-------|-------|----------------|---------------|
| 0x08  | 9     | STTS751_RES_9  | 0.5 °C/LSB    |
| 0x00  | 10    | STTS751_RES_10 | 0.25 °C/LSB   |
| 0x04  | 11    | STTS751_RES_11 | 0.125 °C/LSB  |
| 0x0c  | 12    | STTS751_RES_12 | 0.0625 °C/LSB |

Returns True if configuration is successful, False otherwise.

###### STTS751.disable

```#!py3 disable()```

Disables the sensor.

Returns True if configuration is successful, False otherwise.

###### STTS751.get_status

```#!py3 get_status()```

Retrieves the sensor flag status.

Returns a dictionary with following key/value pairs:

| Key    | Note                          |
|--------|-------------------------------|
| busy   | If True, Sensor is Busy       |
| t_low  | If True, Temp under threshold |
| t_high | If True, Temp over threshold  |
| therm  | If True, High internal Temp   |

###### STTS751.get_sensor_id

```#!py3 get_sensor_id()```

Retrieves product_id, manufacturer_id, revision_id in one call.

Returns product_id, manufacturer_id, revision_id.

###### STTS751.get_temp

```#!py3 get_temp(raw=False)```

Retrieves temperature in one call; if raw flag is enabled, returns raw register values.

Returns temp.

###### STTS751.set_low_temp_threshold

```#!py3 set_low_temp_threshold(level)```

Sets the low temperature threshold. When real temperature goes down the low temperature level, if interrupt is enabled, the sensor send an interrupt signal in its interrupt pin.

###### STTS751.set_high_temp_threshold

```#!py3 set_high_temp_threshold(level)```

Sets the high temperature threshold. When real temperature goes up the high temperature level, if interrupt is enabled, the sensor send an interrupt signal in its interrupt pin.

###### STTS751.set_event_interrupt

```#!py3 set_event_interrupt(enable)```

Enables the interrupt pin. Available values for ‘enable’ flag are ‘True’ or ‘False’.

###### STTS751.set_therm_limit

```#!py3 set_therm_limit(level)```

Sets the Thermal threshold. Whenever the temperature exceeds the value of the therm limit, the Addr/Therm output will be asserted (low)
Available ‘level’ values are from -127 to 127 range.

###### STTS751.set_therm_hysteresis_limit

```#!py3 set_therm_hysteresis_limit(level)```

Sets the Thermal hysteresis threshold. Once Therm output has asserted, it will not de-assert until the temperature has fallen below the respective therm limit minus the therm hysteresis value. Available ‘level’ values are from -127 to 127 range.

###### STTS751.set_timeout

```#!py3 set_timeout(enable)```

Enables the timeout for the sensor readings (from 25 to 35 ms). Available values for ‘enable’ flag are ‘True’ or ‘False’.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTUyMDc5NTQwXX0=
-->

# IIS3DWB Module

This module contains the driver for STMicroelectronics IIS3DWB 3-axis digital vibration sensor with low noise over an ultra-wide and flat frequency range.

In the IIS3DWB, the sensing elements of the accelerometer are implemented on the same silicon die, thus guaranteeing superior stability and robustness. ([datasheet](https://www.st.com/resource/en/datasheet/iis3dwb.pdf)).

##### class IIS3DWB

```#!py3 class IIS3DWB(spidrv, pin_cs, clk=5000000)```

Class which provides a simple interface to IIS3DWB features.

Creates an instance of IIS3DWB class, using the specified SPI settings
and initial device configuration.


**Arguments:**

    
* **spidrv** – the *SPI* driver to use (SPI0, …)
* **pin_cs** – Chip select pin to access the IIS3DWB chip
* **clk** – Clock speed, default 500 kHz


Example:

```py
from stm.iis3dwb import iis3dwb

...

vibro = iis3dwb.IIS3DWB(SPI0, D10)
acc = vibro.get_acc_data()
```

###### IIS3DWB.reset

```#!py3 reset()```

Reset the device using the internal register flag.

###### IIS3DWB.enable

```#!py3 enable(odr=IIS3DWB_ODR_26k7Hz, fs=0)```

Sets the device’s configuration registers for accelerometer.

**Parameters:**


* **odr**: sets the Output Data Rate of the device. Available values are:

| Value | Output Data Rate | Constant Name      |
|-------|------------------|--------------------|
| 0x00  | OFF              | IIS3DWB_ODR_OFF    |
| 0x05  | 26.7 KHz         | IIS3DWB_ODR_26k7Hz |

* **fs** : sets the Device Full Scale. Available values are:

| Value | Full Scale | Costant Name            | in mg/LSB    |
|-------|------------|-------------------------|--------------|
| 0x00  | ±2g        | IIS3DWB_ACC_SENS_FS_2G  | 0.061 mg/LSB |
| 0x01  | ±4g        | IIS3DWB_ACC_SENS_FS_4G  | 0.122 mg/LSB |
| 0x02  | ±8g        | IIS3DWB_ACC_SENS_FS_8G  | 0.244 mg/LSB |
| 0x03  | ±16g       | IIS3DWB_ACC_SENS_FS_16G | 0.488 mg/LSB |

Returns True if configuration is successful, False otherwise.

###### IIS3DWB.disable

```#!py3 disable()```

Disables the accelerator sensor.

Returns True if configuration is successful, False otherwise.

###### IIS3DWB.whoami

```#!py3 whoami()```

Value of the *IIS3DWB_WHO_AM_I* register (0x6B).

###### IIS3DWB.get_acc_data

```#!py3 get_acc_data(ms2=True, raw=False)```

Retrieves accelerometer data in one call.


**Arguments:**

    
* **ms2** – If ms2 flag is True, returns data converted in m/s^2; otherwise in mg (default True)
* **raw** – If raw flag is True, returns raw register values (default False)


Returns acc_x, acc_y, acc_z.

###### IIS3DWB.get_temp

```#!py3 get_temp()```

Retrieves temperature in one call; if raw flag is enabled, returns raw register values.

Returns temp.

###### IIS3DWB.get_fast

```#!py3 get_fast()```

Retrieves all data sensors in one call in fast way (c-code acquisition).


* Temperature in °C
* Acceleration in m/s^2

Returns temp, acc_x, acc_y, acc_z.

###### IIS3DWB.set_event_interrupt

```#!py3 set_event_interrupt(pin_int, enable)```

Enables the interrupt pins. When data from sensor will be ready, the related interrupt pin configured will be set to high.


**Arguments:**

    
* **pin_int** – ID of the interrupt pin to be enabled/disabled. Available values are 1 o 2.
* **enable** – If enable flag is True, interrupt pin will be enabled, otherwise will be disabled.


Returns True if configuration is successful, False otherwise.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc2NDUyODYyNV19
-->

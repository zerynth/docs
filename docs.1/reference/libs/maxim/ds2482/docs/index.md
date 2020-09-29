# Maxim DS2482

The DS2482 is an I2C-to-1-Wire bridge device that interfaces directly to standard (100kHz max) or fast (400kHz max) I2C masters to perform bi-directional protocol conversion between the I2C master and any downstream 1-Wire slave devices.

Internal, factory-trimmed timers relieve the system host processor from generating time-critical 1-Wire waveforms, supporting both standard and overdrive 1-Wire communication speeds. To optimize 1-Wire waveform generation, the DS2482 performs slew-rate control on rising and falling 1-Wire edges and provides additional programmable features to match drive characteristics that slave devices can generate.

Programmable, strong pullup features support 1-Wire power delivery to 1-Wire devices such as EEPROMs and sensors. The DS2482 combines these features with one (models 100 and 101) or eight (model 800) independent 1-Wire I/O channels.

The I2C slave address assignment is controlled by one (model 100), two (model 101), or three (model 800) binary address inputs, resolving potential conflicts with other I2C slave devices in the system. When not in use, the device can be put in sleep mode where power consumption is minimal; more information at Maxim dedicated pages related to model [DS2482-100](https://www.maximintegrated.com/en/products/interface/controllers-expanders/DS2482-100.html), [DS2482-101](https://www.maximintegrated.com/en/products/interface/controllers-expanders/DS2482-101.html), and [DS2482-800](https://www.maximintegrated.com/en/products/interface/controllers-expanders/DS2482-800.html).

## Technical Details


* Supply Voltage (Vcc): from 2.9 V to 5.5 V
* Operation Temperature (Top): from -40 °C to 85 °C
* SCL Clock Frequency (Fscl): from 0 Hz to 400 kHz
* Operating Current (Icc): 0.75 mA
* Read Sample Time: 14 us (stardard mode), 1.5 us (overdrive mode)

Here below, the Zerynth driver for the Maxim DS2482.


Contents:

-   [DS2482 Module - One Wire](/latest/reference/libs/maxim/ds2482/docs/ds2482/)
    -   [OneWireSensor class](/latest/reference/libs/maxim/ds2482/docs/ds2482/#onewiresensor-class)
<!--stackedit_data:
eyJoaXN0b3J5IjpbNTI1MDk5NTA5XX0=
-->
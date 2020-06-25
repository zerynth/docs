# Pin Mapping and Naming

Zerynth allows multi-board programming. To do this in a reliable and maintainable way it has been necessary to define a pin naming strategy that allows programming native multi-board scripts.

In Zerynth we decided to follow the widely accepted Arduino derived pin naming schema where **Digital pin** are named with `Dx` where *x*x is the number of the physical pin available on the board (not of the MCU pin!). Similarly, **Analog pins** are named with `Ax`.

In Zerynth, an *attribute* is added to the pin name for specifying the function we are going to use on that specific pin.

For example, for using the PWM on pin `D3`, we use the `D3.PWM` name while for capturing data with an ICU `D3.ICU` is used.

DIO is the default attribute for digital pins `Dx` while ADC is the default for analog pins `Ax`.

Moreover, `digitalWrite` and `digitalRead` functions don’t require any attribute specification and can be always used specifying the pin name only (`Dx` or `Ax`).

Let’s see some examples:
| Zerynth                               | Arduino/Wiring         | Note                    |
|---------------------------------------|------------------------|-------------------------|
| x=digitalRead(D1)                     | x=digitalRead(D1)      |                         |
| x=digitalRead(A1)                     | x=digitalRead(A1)      | Use Ax pin as Dx pin    |
| x=analogRead(A1)                      | x=analogRead(A1)       |                         |
| x=analogRead(D1.ADC)                  | x=analogRead(Ax)       | Use of ADC on Dx pin    |
| digitalWrite(D1,HIGH)                 | digitalWrite(D1,HIGH)  |                         |
| digitalWrite(A1,HIGH)                 | digitalWrite(A1,HIGH)  | Use of Ax pin as Dx pin |
| pwm.write(D1.PWM,period,duty)         | analogWrite(D1, value) |                         |
| pwm.write(A1.PWM,period,duty)         | analogWrite(D1, value) | Use of Ax as PWM pin    |
| x=icu.capture(D1.ICU,samples,time)    | —                      |                         |
| x=icu.capture(A1.ICU,samples,time)    | —                      |                         |
| can.init(D30.CANRX, D31.CANTX)        | —                      | Not yet released        |
| spi.init(D11.MOSI, D12.MISO, D13.SCK) | —                      | Not yet released        |
| i2c.init(D14.SDA,D15.SCL)             | —                      | Not yet released        |
In Zerynth names are always UPPERCASE. The following PIN names are included in the Zerynth built-ins:


* Pin Names:


    * `D0` to `D127` representing the names of digital pins.


    * `A0` to `A31` representing the names of analog pins.


    * `LED0` to `LED7` representing the names of the on-board installed LEDs.


    * `BTN0` to `BTN3` representing the names of the on-board installed buttons.


* Pin Attributes (Dx.YYY):


    * `MISO, MOSI, SCK` representing the attributes of SPI pins.


    * `SCL, SDA` representing the attributes of I2C pins.


    * `RX, TX` representing the attributes of Serial pins.


    * `DAC` representing the attributes of DAC pins.


    * `CANTX`, `CANRX` representing the attributes of CAN pins.


    * `PWM` representing the attributes of PWM pins.


    * `ICU` representing the attributes of ICU (input capture unit) pins.

This naming approach is required for allowing the Zerynth compiler to check for wrong uses of boards pin at scripts compiling time. This is necessary because despite the apparently uniformed Arduino-like pin naming not all the MCU based boards expose the same functionalities on their pins. E.i. on ST Nucleo F401RE pin `D0` can be used as PWM, ADC and serial RX while on Arduino DUE the `D0` is a serial RX only.

For example, the following script can be compiled for the ST Nucleo but will rise an error at compiling time if compiled for an Arduino DUE

```py
import pwm

pwm.write(D0.PWM, 100,50)

while True:
  print("running PWM on pin D0")
  sleep(200)
```

However, this pin naming is an advanced feature of the Zerynth suite and it is required only for specific uses and for functionalities directly related to board wiring and setups like the ICU and the PWM. In most frequent cases where Analog and Digital basic functionalities are used, the Zerynth defaults will automatically set the correct methods for the selected pin.

Moreover, all the Zerynth init functions (`can.init()`, `spi.init()`, `i2c.init()`) also allow fast configuration by using short-names like (`CAN0`, `I2C0`, `SPI0`, `SERIAL0`). For example, it is possible to open the serial port 0 with default parameters by calling `streams.serial()` or opening the serial port 1 by calling `streams.serial(SERIAL1)`

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTI2MzE4OTQ3NiwyNDUzMTY5NjksLTMxMD
E0ODcxOSwyMDc2MjI5ODU1LDIwODg1NjE2OTldfQ==
-->
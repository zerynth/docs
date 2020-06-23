<!-- _tmp112 -->
# TI TMP112

The TMP112 device is a digital temperature sensor ideal for NTC/PTC thermistor replacement where high accuracy is required. The device offers an accuracy of ±0.5°C without requiring calibration or external component signal conditioning.

IC temperature sensors are highly linear and do not require complex calculations or lookup tables to derive the temperature. The on-chip 12-bit ADC offers resolutions down to 0.0625°C.

The TMP112 device features SMBus, two-wire and I2C interface compatibility, and allows up to four devices on one bus. The device also features an SMBus alert function.

The TMP112 is ideal for extended temperature measurement in communication, computer, consumer, environmental, industrial, and instrumentation applications; more information at [Texas Instruments dedicated page](http://www.ti.com/product/TMP112).

## Technical Details


* Supply Voltage (Vcc): from 1.4 V to 3.6 V
* Operation Temperature (Top): from -40 °C to 125 °C
* Resolution: 12 Bits
* Low Quiescent Current: 10 uA active (max) and 1 uA shutdown (max)
* Accuracy without calibration:

    * 0.5 °C (max) from 0 °C to 65 °C
    * 1.0 °C (max) from -40 °C to 125 °C

Here below, the Zerynth driver for the Texas Instruments TMP112.

Contents:


* [TMP112 Module](https://docs.zerynth.com/latest/official/lib.texas.tmp112/docs/official_lib.texas.tmp112_tmp112.html)
    * [TMP112 class](https://docs.zerynth.com/latest/official/lib.texas.tmp112/docs/official_lib.texas.tmp112_tmp112.html)

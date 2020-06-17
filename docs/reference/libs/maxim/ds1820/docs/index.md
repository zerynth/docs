# Maxim DS1820

The DS18S20 digital thermometer provides 9-bit Celsius temperature measurements and has an alarm function with nonvolatile user-programmable upper and lower trigger points. The DS18S20 communicates over a 1-Wire bus that by definition requires only one data line (and ground) for communication with a central microprocessor. In addition, the DS18S20 can derive power directly from the data line (“parasite power”), eliminating the need for an external power supply.

Each DS18S20 has a unique 64-bit serial code, which allows multiple DS18S20s to function on the same 1-Wire bus. Thus, it is simple to use one microprocessor to control many DS18S20s distributed over a large area. Applications that can benefit from this feature include HVAC environmental controls, temperature monitoring systems inside buildings, equipment, or machinery; more information at [Maxim dedicated page](https://www.maximintegrated.com/en/products/analog/sensors-and-sensor-interface/DS18S20.html).

## Technical Details


* Supply Voltage (Vdd): from 3.0 V to 5.5 V


* Operation Temperature (Top): from -55 °C to 125 °C


* Active Current (Idd): from 1.0 mA to 1.5 mA


* Temperature Conversion Time: 750 ms

Here below, the Zerynth driver for the Maxim DS1820.


Contents:

-   [
* DS1820 Module](https://docs.zerynth.com/latest/official/lib.maxim.ds1820/docs/official_lib.maxim.ds1820_ds1820.html)
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjEyMTI4MzcwNywtNTM5OTM2OTIxXX0=
-->
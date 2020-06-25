# AMS TSL2561

The TSL2561 is a light-to-digital converter that transforms light intensity to a digital signal output capable of direct I²C interface. This device combines one broadband photodiode (visible plus infrared) and one infrared-responding photodiode on a single CMOS integrated circuit capable of providing a near-photopic response over an effective 20-bit dynamic range 
(16-bit resolution). 
Two integrating ADCs convert the photodiode currents to a digital output that represents the 
irradiance measured on each channel.

The TSL2561 is designed particularly for display panels (LCD, OLED, etc.) with the purpose of extending battery life and providing optimum viewing in several lighting conditions, but also for other applications. 
Some examples are street light control, security lighting, sunlight harvesting, machine vision, keyboard illumination control based upon ambient lighting conditions, and automotive instrumentation clusters.

More information at [AMS dedicated page](http://ams.com/eng/Products/Light-Sensors/Ambient-Light-Sensors/TSL2561/TSL2560-TSL2561-Datasheet).

## Technical Details


* Supply Voltage (Vdd): from 2.7 V to 3.6 V


* Operation Temperature (Top): from -30 °C to 70 °C


* Spectral Responsivity Channel0: Wavelength Range from ~300 nm to ~1100 nm


* Spectral Responsivity Channel1: Wavelength Range from ~600 nm to ~1000 nm


* Digital Output Current: from -1 mA to 20 mA


* Automatically Rejects 50/60-Hz Lighting Ripple


* Low Active Power (0.75 mW Typical) with Power Down Mode


* I²C interface

Here below, the Zerynth driver for the AMS TSL2561.

Contents:
-   [

* TSL2561 Module](https://docs.zerynth.com/latest/official/lib.ams.tsl2561/docs/official_lib.ams.tsl2561_tsl2561.html)
-   [Examples](https://docs.zerynth.com/latest/official/lib.ams.tsl2561/examples/examples.html)
    -   [ambient light](https://docs.zerynth.com/latest/official/lib.ams.tsl2561/examples/examples.html#ambient-light)

<!--stackedit_data:
eyJoaXN0b3J5IjpbMzU0ODE2MDAsMTAwNjU5MjM0OV19
-->
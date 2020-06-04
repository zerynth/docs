# NXP FXAS21002C

The FXAS21002C is a small, low-power, yaw, pitch, and roll angular rate gyroscope with 16 bit ADC resolution. The full-scale range is adjustable from ±250°/s to ±2000°/s. It features the I2C interfaces.

FXAS21002C is capable of measuring angular rates up to ±2000°/s, with output data rates (ODR) from 12.5 to 800 Hz. An integrated Low-Pass Filter (LPF) allows the host application to limit the digital signal bandwidth. The device may be configured to generate an interrupt when a user-programmable angular rate threshold is crossed on any one of the enabled axes.

More information at [NXP dedicated page](http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C)

## Technical Details


* Supply Voltage (Vdd): from 1.95 V to 3.6 V


* Operation Temperature (Top): from -40 °C to 85 °C


* Current Consumption: from 2.8 uA (Standby mode) mA to 2.7 mA (Active mode)


* Angular Rate Sensitivity: 0.0625°/s (in ±2000°/s FSR mode)


* Dynamically Selectable Range: ±250/±500/±1000/±2000°/s or ±500/±1000/±2000/±4000°/s setting the full-scale double features


* Output data rates (ODR) from 12.5 Hz to 800 Hz


* I²C interface

Here below, the Zerynth driver for the NXP FXAS21002C.

Contents:


* FXAS21002C Module

# NXP FXOS8700CQ

The NXP FXOS8700CQ is a small, low-power, 3-axis, linear accelerometer and 3-axis, magnetometer combined into a single package.

This component features an I2C interface and the 14-bit accelerometer and 16-bit magnetometer are combined with a high-performance ASIC to enable an eCompass solution capable of a typical orientation resolution of 0.1° and sub-5° compass heading accuracy for most applications.

FXOS8700CQ has dynamically selectable acceleration full-scale ranges of ±2 g/±4 g/±8 g and a fixed magnetic measurement range of ±1200 μT. Output data rates (ODR) from 1.563 Hz to 800 Hz are selectable by the user for each sensor. Interleaved magnetic and acceleration data is
available at ODR rates of up to 400 Hz.

More information at [NXP dedicated page](http://www.nxp.com/products/sensors/6-axis-sensors/digital-sensor-3d-accelerometer-2g-4g-8g-plus-3d-magnetometer:FXOS8700CQ)

## Technical Details


* Supply Voltage (Vdd): from 1.95 V to 3.6 V


* Operation Temperature (Top): from -40 °C to 85 °C


* Dynamically Selectable Acceleration Full-scale Range: ±2 g or ±4 g or ±8 g


* Accelerometer Sensitivity: 0.244 mg or 0.488 mg or 0.976 mg (according to the Full-scale Range)


* Magnetic Sensor Full-scale Range: ±1200 uT


* MAgnetometer Sensotivity: 0.1 uT


* Current Consumption: 240 uA @ 100 Hz with both sensors active


* I²C interface

Here below, the Zerynth driver for the NXP FXOS8700CQ.

Contents:


* FXOS8700CQ Module

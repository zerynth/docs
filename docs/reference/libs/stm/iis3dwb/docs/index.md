# IIS3DWB

The IIS3DWB is a system-in-package featuring a 3-axis digital vibration sensor with low noise over an ultra-wide and flat frequency range. The wide bandwidth, low noise, very stable and repeatable sensitivity, together with the capability of operating over an extended temperature range (up to +105 °C), make the device particularly suitable for vibration monitoring in industrial applications.

The high performance delivered at low power consumption together with the digital output and the embedded digital features like the FIFO and the interrupts are enabling features for battery-operated industrial wireless sensor nodes.

The IIS3DWB has a selectable full-scale acceleration range of ±2/±4/±8/±16 g and is capable of measuring accelerations with a bandwidth up to 6 kHz with an output data rate of 26.7 kHz.

A 3 kB first-in, first-out (FIFO) buffer is integrated in the device to avoid any data loss and to limit intervention of the host processor.

The IIS3DWB has a self-test capability which allows checking the functioning of the sensor in the final application.
More information at [STMicroelectronics dedicated page](https://www.st.com/en/mems-and-sensors/iis3dwb.html)

## Technical Details


* Wide supply voltage, 2.1 V to 3.6 V
* Ultra-low power consumption
* ±2g/±4g/±8g/±16g full-scale 3D Accelerometer
* Ultra-wide and flat frequency response range: from dc to 6 kHz (±3 dB point)
* Ultra-low noise density: down to 75 µg/√Hz in 3-axis mode / 60 µg/√Hz in single-axis mode
* I2C/SPI digital output interface
* 16-bit data output
* Extended temperature range from -40 to +105 °C

Below, Zerynth driver documentation for STM IIS3DWB chip.

Contents:


* [IIS3DWB Module](/latest/reference/libs/stm/iis3dwb/docs/iis3dwb/)
* [Example](/latest/reference/libs/stm/iis3dwb/docs/examples/)
     * [get data](/latest/reference/libs/stm/iis3dwb/docs/examples/#read-vibrometer-and-temperature-data-from-iis3dwb)

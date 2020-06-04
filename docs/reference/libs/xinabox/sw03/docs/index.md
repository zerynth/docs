# XinaBox SW03

The SW03 xChip is equipped with a weather sensor that is capable of measuring the temperature, atmospheric pressure and altitude. It is based on the [MPL3115A2](https://www.nxp.com/products/sensors/pressure-sensors/barometric-pressure-15-to-115-kpa/20-to-110-kpa-absolute-digital-pressure-sensor:MPL3115A2) manufactured by NXP Semiconductors.

The MPL3115A2 is a compact, piezoresistive, absolute pressure sensor with an I2C digital interface. MPL3115A2 has a wide operating range of 20 kPa to 110 kPa, a range that covers all surface elevations on earth. The MEMS is temperature compensated utilizing an on-chip temperature sensor. The pressure and temperature data is fed into a high resolution ADC to provide fully compensated and digitized outputs for pressure in Pascals and temperature in °C. The compensated pressure output can then be converted to altitude.

Please note, SW03 and all other xChips is currently only supported in Zerynth Studio with [XinaBox CW02](https://docs.zerynth.com/latest/official/board.zerynth.xinabox_esp32/docs/index.html). Review the [Quick Start](https://wiki.xinabox.cc/Quick-Start) guide for interfacing xChips.

## Technical Details

### MPL3115A2


* I2C interface


* Fully Compensated Internal


* Temperature Operating Range: -40°C to 85°C


* Absolute Pressure Operating Range: 20 kPa to 110 kPa


* Precision ADC resulting in 0.1 meter of effective resolution


* Direct reading

Contents:


* SW03 Module


    * SW03 class

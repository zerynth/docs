# XinaBox SW01

The SW01 xChip is equipped with a weather sensor that is capable of measuring the temperature, humidity and atmospheric pressure. It is based on the [BME280](https://www.bosch-sensortec.com/bst/products/all_products/bme280) manufactured by Bosch.

The humidity sensor provides an extremely fast responce time for fast context awareness application and high overall accuracy over a wide temperature range.

The pressure sensor is an absolute barometric pressure sensor with extremely high accuracy and resolution.

The integrated temperature sensor has been optimized for lowest noise and highest resolution. Its output is used for temperature compensation of the pressure and humidity sensors and can also be used for estimation of the ambient temperature.

Please note, SW01 and all other xChips is currently only supported in Zerynth Studio with [XinaBox CW02](/latest/reference/boards/xinabox_esp32/docs/). Review the [Quick Start](https://wiki.xinabox.cc/Quick-Start) guide for interfacing xChips.

## Technical Details

### BME280


* Operating Range:
    1. Temperature: -40 to 85°C
    2. Relative Humidity: 0 to 100%
    3. Pressure: 300 to 1100 hPa
* Humidity Sensor and Pressure Sensor can be Independently Enabled/ Disabled.
* 3 Power Modes:
    1. Sleep Mode.
    2. Normal Mode.
    3. Forced Mode.

Contents:


* [SW01 Module](/latest/reference/libs/xinabox/sw01/docs/sw01/)
    * [SW01 class](/latest/reference/libs/xinabox/sw01/docs/sw01/#sw01-class)
* [Examples](/latest/reference/libs/xinabox/sw01/docs/examples/)
    * [environmental data](/latest/reference/libs/xinabox/sw01/docs/examples/#environmental-data-measurement)

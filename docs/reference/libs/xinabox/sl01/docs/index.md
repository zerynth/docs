# XinaBox SL01

The SL01 xChip is a UV radiation and ambient light level sensor. It is based on the [VEML6075](https://www.vishay.com/ppg?84304) and [TSL4531](https://ams.com/tsl45315). VEML6075 on the SL01 is capable of measuring UVA and UVB radiation, in turn, providing an acccurate UV Index. TSL4531 is a light sensor that is capable of measuring the luminosity (Wide Dynamic Range — 3 lux to 220k lux) (visual brightness).

Please note, SL01 and all other xChips is currently only supported in Zerynth Studio with [XinaBox CW02](/latest/reference/boards/xinabox_esp32/docs/). Review the [Quick Start](https://wiki.xinabox.cc/Quick-Start) guide for interfacing xChips.

## Technical Details

### VEML6075


* Peak Sensitivity UVA, UVB(nm):365, 330


* Temperature range: -40°C to 85°C


* Three User-Selectable Integration Times (400 ms, 200 ms, and 100 ms)

### TSL4331


* Wide Dynamic Range — 3 lux to 220k lux


* Simple Direct Lux Output


* Temperature range: -40°C to 85°C


* Three User-Selectable Integration Times (400 ms, 200 ms, and 100 ms)

<!-- The text you write here will appear in the first doc page. (This is just a comment, will not be rendered) -->
Contents:


* [SL01 Module](/latest/reference/libs/xinabox/sl01/docs/sl01/)
    * [VEML6075 class](/latest/reference/libs/xinabox/sl01/docs/sl01/#veml6075-class)
    * [TSL4531 class](/latest/reference/libs/xinabox/sl01/docs/sl01/#tsl4531-class)
* [Examples](/latest/reference/libs/xinabox/sl01/docs/examples/)
    * [lux measurements](/latest/reference/libs/xinabox/sl01/docs/examples/#lux-measurement)
    * [uv measurements](/latest/reference/libs/xinabox/sl01/docs/examples/#uv-measurements)

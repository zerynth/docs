# XinaBox SL06

The SL06 xChip features advanced Gesture detection, Proximity detection, Digital Ambient Light Sense (ALS) and Colour Sense (RGBC). It is based on the popular [APDS9960](https://www.broadcom.com/products/optical-sensors/integrated-ambient-light-and-proximity-sensors/apds-9960) manufactured by Avago Technologies.

Please note, SL06 and all other xChips is currently only supported in Zerynth Studio with [XinaBox CW02](/latest/reference/boards/xinabox_esp32/docs/). Review the [Quick Start](https://wiki.xinabox.cc/Quick-Start) guide for interfacing xChips.

## Technical Details

### APDS-9960


* Ambient Light and RGB Color Sensing
    * Ambient Light and RGB Color Sensing
    * UV and IR blocking filters
    * Programmable gain and integration time
    * Very high sensitivity – Ideally suited for operation behind dark glass
* Proximity Sensing
    * Trimmed to provide consistent reading
    * Ambient light rejection
    * Offset compensation
    * Programmable driver for IR LED current
    * Saturation indicator bit
* Complex Gesture Sensing
    * Four separate diodes sensitive to different directions
    * Ambient light rejection
    * Offset compensation
    * Programmable driver for IR LED current
    * 32 dataset storage FIFO
    * Interrupt driven I2C-bus communication
* I2C-bus Fast Mode Compatible Interface
    * Data Rates up to 400 kHz

<!-- The text you write here will appear in the first doc page. (This is just a comment, will not be rendered) -->
Contents:


* [SL06 Module](/latest/reference/libs/xinabox/sl06/docs/sl06/)
    * [SL06 class](/latest/reference/libs/xinabox/sl06/docs/sl06/#sl06-class)
* [Examples](/latest/reference/libs/xinabox/sl06/docs/examples/)
    * [ambient light](/latest/reference/libs/xinabox/sl06/docs/examples/#ambient-light-detection)
    * [colour](/latest/reference/libs/xinabox/sl06/docs/examples/#colour-detection)
    * [gesture](/latest/reference/libs/xinabox/sl06/docs/examples/#gesture-detection)
    * [proximity](/latest/reference/libs/xinabox/sl06/docs/examples/#proximity-detection)

# XinaBox OC05

The OC05 xChip is an 8-channel servo motor driver. It is based on the popular [PCA9685](https://www.nxp.com/products/analog/interfaces/ic-bus/ic-led-controllers/16-channel-12-bit-pwm-fm-plus-ic-bus-led-controller:PCA9685) manufactured by NXP Semiconductor. It is supported by a BU33SD5 regulator to drive and accurately control up to 8 servo motors on a single module and act as system power supply. The module has 8 standard 2.54 mm (0.1”) servo headers, plus 1 standard 2.54 mm (0.1”) battery/BEC input header.

Please note, OC05 and all other xChips is currently only supported in Zerynth Studio with [XinaBox CW02](https://docs.zerynth.com/latest/official/board.zerynth.xinabox_esp32/docs/index.html). Review the [Quick Start](https://wiki.xinabox.cc/Quick-Start) guide for interfacing xChips.

## Technical Details

### PCA9685


* 8 PWM Drivers
* 1 MHz Fast-mode Plus compatible I2C-bus interface
* 4096-step (12-bit) linear programmable PWM output varying from fully off (default) to maximum PWM
* Internal power-on reset
* No output glitches on power-up
* Low standby current
* Support for 8 different I2C Addresses (Possible to connect up to 64 Servos)

### BU33SD5


* Input Power Supply Voltage Range: 3.5V to 6.0V
* Output Current Range: 0 to 500mA
* Operating Temperature Range: -40℃ to +105℃
* Output Voltage Accuracy: ±2.0%
* Circuit Current: 33µA
* Standby Current: 0μA

<!-- The text you write here will appear in the first doc page. (This is just a comment, will not be rendered) -->
Contents:


* [OC05 Module](https://docs.zerynth.com/latest/official/lib.xinabox.oc05/docs/official_lib.xinabox.oc05_oc05.html)
    * [OC05 class](https://docs.zerynth.com/latest/official/lib.xinabox.oc05/docs/official_lib.xinabox.oc05_oc05.html#oc05-class)
* [Examples](https://docs.zerynth.com/latest/official/lib.xinabox.oc05/examples/examples.html)
    * [servo control](https://docs.zerynth.com/latest/official/lib.xinabox.oc05/examples/examples.html#servo-control)

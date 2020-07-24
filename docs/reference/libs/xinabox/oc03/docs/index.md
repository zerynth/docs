# XinaBox OC03

The OC03 xChip is a low-voltage control relay module able to switch AC and DC loads. It is based on the [PCA9554A](http://www.ti.com/product/PCA9554A) and [TLP241A](https://toshiba.semicon-storage.com/eu/product/opto/photocoupler/detail.TLP241A.html).

The optically isolated relay is controlled by a PCA9554A IO expander, which provides an control interface to the switch. The PCA9554A has several selectable I2C addresses accessible via solder pads.

The TLP241A photorelay consist of a photo MOSFET optically coupled to an infrared light emitting diode which switches a AC or DC load. It provides an isolation voltage of 5000 Vrms, making it suitable for applications that require reinforced circuit insulation.

Please note, OC03 and all other xChips is currently only supported in Zerynth Studio with [XinaBox CW02](/latest/reference/boards/xinabox_esp32/docs/). Review the [Quick Start](https://wiki.xinabox.cc/Quick-Start) guide for interfacing xChips.

## Technical Details

### PCA9554A


* 400-kHz Fast I2C Bus
* Three Hardware Address Pins Allow up to Eight I2C Addresses
* Internal Power-On Reset
* No Glitch on Power Up
* Latched Outputs With High-Current Drive

### TLP241A


* Normally Open
* OFF-state output terminal voltage: 40 V (min)
* Trigger LED current: 3 mA (max)
* ON-state current: 2 A (max)
* ON-state resistance:
    1. 100 mΩ (max, t < 1 s)
    2. 150 mΩ (max, Continuous)
* Isolation voltage: 5000 Vrms (min)

Contents:


* [OC03 Module](/latest/reference/libs/xinabox/oc03/docs/oc03/)
    * [OC03 class](/latest/reference/libs/xinabox/oc03/docs/oc03/#oc03-class)
* [Examples](/latest/reference/libs/xinabox/oc03/docs/examples/)
    * [toggle output](/latest/reference/libs/xinabox/oc03/docs/examples/#toggle-relay-on-oc03)
    * [remote relay control weather monitor wolkabout](/latest/reference/libs/xinabox/oc03/docs/examples/#control-oc03-xchip-low-voltage-relay-remotely)

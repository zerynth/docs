# XinaBox SW10

This SW10 xChip is a temperature-to-digital converter using an on-chip band gap temperature sensor and Sigma-Delta A-to-D conversion technique with an over-temperature detection output. It is capable of measuring ambient temperature ranging from -55°C to +125°C. It is based on the [LM75](http://www.ti.com/product/LM75A) manufactured by Texas Instruments.

Please note, SW10 and all other xChips is currently only supported in Zerynth Studio with [XinaBox CW02](https://docs.zerynth.com/latest/official/board.zerynth.xinabox_esp32/docs/index.html). Review the [Quick Start](https://wiki.xinabox.cc/Quick-Start) guide for interfacing xChips.

## Technical Details

### LM75


* I2C-bus interface with up to 8 devices on the same bus
* Temperature range from -55°C to +125°C
* Frequency range 20 Hz to 400 kHz with bus fault time-out to prevent hanging up the bus
* Programmable temperature threshold and hysteresis set points
* Supply current of 1.0 µA in shutdown mode for power conservation
* Stand-alone operation as thermostat at power-up

<!-- The text you write here will appear in the first doc page. (This is just a comment, will not be rendered) -->
Contents:


* [SW10 Module](https://docs.zerynth.com/latest/official/lib.xinabox.sw10/docs/official_lib.xinabox.sw10_sw10.html)
    * [SW10 class](https://docs.zerynth.com/latest/official/lib.xinabox.sw10/docs/official_lib.xinabox.sw10_sw10.html#sw10-class)
* [Examples](https://docs.zerynth.com/latest/official/lib.xinabox.sw10/examples/examples.html)
    * [ambient temperature](https://docs.zerynth.com/latest/official/lib.xinabox.sw10/examples/examples.html#ambient-temperature)

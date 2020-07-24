# SOLOMON SSD1351

The SSD1351 is a CMOS OLED/PLED driver with 384 segments and 128 commons output, supporting up to 128RGB x 128 dot matrix display. This chip is designed for Common Cathode type OLED/PLED panel.

The SSD1351 has embedded Graphic Display Data RAM (GDDRAM). It supports with 8, 16, 18 bits 8080 / 6800 parallel interface, Serial Peripheral Interface. It has 256-step contrast and 262K color control, giving vivid color display on OLED panels.

More information at [Solomon dedicated page](http://www.solomon-systech.com/en/product/display-ic/oled-driver-controller/ssd1351/).

## Technical Details


* Supply Voltage (Vdd): from 2.4 V to 3.5 V
* Operation Temperature (Top): from -40 °C to 85 °C
* Resolution: 128 RGB x 128 dot matrix panel
* Segment maximum source current: 200uA
* Common maximum sink current: 70mA
* 256 step brightness current control for the each color component plus 16 step master current control
* SPI interface

Here below, the Zerynth driver for the SOLOMON SSD1351.

Contents:


* [SSD1351 Module](/latest/reference/libs/solomon/ssd1351/docs/ssd1351/)
* [Examples](/latest/reference/libs/solomon/ssd1351/docs/examples/)
    * [blinking image](/latest/reference/libs/solomon/ssd1351/docs/examples/#draw-a-blinking-image)
    * [print on oled display](/latest/reference/libs/solomon/ssd1351/docs/examples/#print-on-oled-display)

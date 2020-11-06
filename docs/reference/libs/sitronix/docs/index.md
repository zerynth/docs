# Sitronix ST7735

The ST7735 is a single-chip controller/driver for 262K-color, graphic type TFT-LCD. It consists of 396 source line and 162 gate line driving circuits. This chip is capable of connecting directly to an external microprocessor, and accepts Serial Peripheral Interface (SPI), 8-bit/9-bit/16-bit/18-bit parallel interface. Display data can be stored in the on-chip display data RAM of 132 x 162 x 18 bits. It can perform display data RAM read/write operation with no external operation clock to minimize power consumption. In addition, because of the integrated power supply circuits necessary to drive liquid crystal, it is possible to make a display system with fewer components. [Sitronix dedicated page](https://www.sitronix.com.tw/en/products/display-driver-ic/).

## Technical Details

Non-volatile (memory to store initial register setting
I/O Voltage (VDDI to DGND): 1.65V~VDD
Analog Voltage (VDD to AGND): 2.6V~3.3V
Source Outputs: 128/132 RGB channels
Gate Outputs: 160/162 channels
Line inversion, frame inversion
Full Color: 262K, RGB=(666)
Color Reduce: 8-color, RGB=(111)
Here below, the Zerynth driver for the Sitronix ST7735.

> Contents:
>
> - [ST7735 Module](/latest/reference/libs/sitronix/docs/st7735_module)
>    - [ST7735 class](/latest/reference/libs/sitronix/docs/st7735_module/#st7735-class)
> - [Examples](/latest/reference/libs/sitronix/docs/examples)
>   - [write on display](/latest/reference/libs/sitronix/docs/examples/#write-on-display)
>   - [logo on display](/latest/reference/libs/sitronix/docs/examples/#logo-on-display)

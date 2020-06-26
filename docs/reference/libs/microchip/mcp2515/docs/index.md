# Microchip MCP2515

Microchip Technology’s MCP2515 is a stand-alone Controller Area Network (CAN) that implements the CAN specification, Version 2.0B.

It is capable of transmitting and receiving both standard and extended data and remote frames. The MCP2515 has two acceptance masks and six acceptance filters that are used to filter out unwanted messages, thereby reducing the host MCU’s overhead.

The MCP2515 interfaces with microcontrollers (MCUs) via an industry standard Serial Peripheral Interface (SPI).

More Info in [Microchip dedicated page](http://www.microchip.com/wwwproducts/en/MCP2515).

## Technical Details


* Implements CAN V2.0B at 1 Mb/s
* 0 to 8-byte length in the data field
* Receive Buffers, Masks and Filters
* Standard and extended data and remote frames
* 5 mA active current (typical)
* Supply Voltage (Vdd): from 2.7 V to 5.5 V
* Temperature range: -40°C to +125°C

Here below, the Zerynth driver for the Microchip MCP2515.

Contents:

* [MCP2515 class](https://docs.zerynth.com/latest/official/lib.microchip.mcp2515/docs/official_lib.microchip.mcp2515_mcp2515.html)
* [Examples](https://docs.zerynth.com/latest/official/lib.microchip.mcp2515/examples/examples.html)
   * [can loopback](https://docs.zerynth.com/latest/official/lib.microchip.mcp2515/examples/examples.html#can-loopback)
   * [can communication](https://docs.zerynth.com/latest/official/lib.microchip.mcp2515/examples/examples.html#can-communication)


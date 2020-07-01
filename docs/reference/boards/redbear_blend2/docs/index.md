# RedBear Blend 2

The RedBear Blend 2 is a microcontroller board based on the Nordic [NRF52832 Cortex-M4F MCU](http://infocenter.nordicsemi.com/pdf/nRF52832_PS_v1.0.pdf).

It is a “full-size” Arduino compatible board which supports most shields. It has on board a Cortex-M3 MCU that supports DAPLink, slot for Apple MFi coprocessor and two Grove connectors.

<p style="text-align:center;"><img src="https://github.com/zerynth/docs/blob/test/docs/reference/boards/redbear_blend2/docs/img/RedBearBlend2.jpg?raw=true"></p>

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/redbear_blend2/docs/img/RedBearBlend2Pin.png?raw=true)

## Flash Layout

The internal flash of the NRF52832 is organized as a single bank of 512Kb, with pages of 4Kb each. The flash begins at address 0x00000.

## Board Summary


* Microcontroller: NRF52832
* Operating Voltage: 3.3V
* Digital I/O Pins (DIO): 23
* Analog Input Pins (ADC): 7
* Analog Outputs Pins (DAC): 0
* UARTs: 1
* SPIs: 2
* I2Cs: 2
* Flash Memory: 512 Kb
* SRAM: 64 Kb
* Clock Speed: 64 MHz
* Size (LxW mm): 69.0 x 53.0

## Power

The RedBear Blend 2 can be powered via the USB connector or with an external power supply. The power source is selected automatically. External (non-USB) power can come either from an AC-to-DC adapter (such as a wall-wart) or battery, and can be connected using a 2.1mm center-positive plug connected to the board’s power jack, or directly to the GND and VIN pins.

## Connect, Virtualize and Program

The RedBear Blend 2 has an on-board DAP Link circuitry that exposes three USB interfaces:


* A serial port over USB
* A mass storage device for drag-n-drop programming flash memory
* A DAP compliant debug channel

DAP Link should be supported natively by all platforms.
Once connected to a USB port, the RedBear Blend 2 board is recognized by Zerynth Studio. The board can be virtualized by clicking the related Studio button without requiring any other user intervention.

Follow these steps to uplink a Zerynth script on a virtualized RedBear Blend 2:

* **Select** the Blend 2 on the **Device Management Toolbar**;
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

After virtualization, the device is ready to be programmed and the  Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio and **reset** the device by pressing the Reset on-board button when asked.

!!! Important
    To exploit the BLE chip functionalities of the Blend 2, the [lib.nordic.nrf52_ble library]() must be installed and imported on the Zerynth script. Moreover, in the creation phase, a VM with BLE support must be selected.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTI5NDE4MDYyN119
-->

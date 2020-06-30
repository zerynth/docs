# RedBear Nano 2

The RedBear Nano 2 is a microcontroller board based on the Nordic [NRF52832 Cortex-M4F MCU](http://infocenter.nordicsemi.com/pdf/nRF52832_PS_v1.0.pdf).

It is a tiny board based on the MB-N2 module by RedBear with an U.FL connector for externak NFC antenna.

<p style="text-align:center;"><img src="https://github.com/zerynth/docs/blob/test/docs/reference/boards/redbear_nano2/docs/img/RedBearNano2.jpg?raw=true"></p>
<p style="text-align:center;"><img src="https://github.com/zerynth/docs/blob/test/docs/reference/boards/redbear_nano2/docs/img/RedBearNano2DapLink.jpg?raw=true"></p>

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/redbear_nano2/docs/img/RedBearNano2Pin.png?raw=true)

## Flash Layout

The internal flash of the NRF52832 is organized as a single bank of 512Kb, with pages of 4Kb each. The flash begins at address 0x00000.

## Board Summary


* Microcontroller: NRF52832
* Operating Voltage: 3.3V
* Digital I/O Pins (DIO): 12
* Analog Input Pins (ADC): 6
* Analog Outputs Pins (DAC): 0
* UARTs: 1
* SPIs: 1
* I2Cs: 1
* Flash Memory: 512 Kb
* SRAM: 64 Kb
* Clock Speed: 64 MHz
* Size (LxW mm): 18.0 x 21.0

## Power

The RedBear Nano 2 can be powered via the USB connector of the companion DAP Link adapter or with an external power supply.

## Connect, Virtualize and Program

The RedBear Nano 2 can be programmed through the companion DAP Link adapter that exposes three USB interfaces:


* A serial port over USB
* A mass storage device for drag-n-drop programming flash memory
* A DAP compliant debug channel

DAP Link should be supported natively by all platforms.
Once connected to a USB port, the RedBear Nano 2 + DAP Link board is recognized by Zerynth Studio. The board can be virtualized by clicking the related Studio button without requiring any other user intervention.

Follow these steps to uplink a Zerynth script on a virtualized RedBear Nano 2:

* ```Select``` the Nano 2 on the **Device Management Toolbar**;
* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;
* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;
* ```Virtualize``` the device by clicking the “Z” button for the third time.

After virtualization, the device is ready to be programmed and the  Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “upload” button of Zerynth Studio and ```reset``` the device by pressing the Reset on-board button when asked.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTM2NDg5NTc1NV19
-->

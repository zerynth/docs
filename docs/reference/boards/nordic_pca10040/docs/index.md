# Nordic nRF52 DK

The nRF52 DK is a versatile single board development kit for Bluetooth 5, NFC, ANT and 2.4 GHz proprietary applications on [nRF52832](https://www.nordicsemi.com/Products/Low-power-short-range-wireless/nRF52832) SoC.

It facilitates development exploiting all features of the nRF52832 SoC. It includes an NFC antenna that quickly enables utilization of the NFC-A tag peripheral on the nRF52832. All GPIOs are available via edge connectors and headers, and 4 buttons and 4 LEDs simplifies output and input from and to the SoC.

It comes with an on-board SEGGER J-Link debugger allowing programming and debugging both the on-board SoC and external SoCs through the debug out header.

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/nordic_pca10040/docs/img/nordic_nrf52_dk.jpg?raw=true)

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/nordic_pca10040/docs/img/nordic_nrf52_dk_pin_comm.jpg?raw=true)

Official reference for Nordic nRF52 DK can be found [here](https://www.nordicsemi.com/Software-and-Tools/Development-Kits/nRF52-DK).

## Flash Layout

The internal flash of the NRF52832 is organized as a single bank of 512Kb, with pages of 4Kb each. The flash begins at address 0x00000 where is stored the Zerynth Virtual Machine (bytecode starts at address 0x55000).

## Board Summary


* Microcontroller: NRF52832
* Operating Voltage: 3.3V
* Digital I/O Pins (DIO): 32
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

The Nordic nRF52 DK is equipped with on-board Li-Po button cell to power-up the device. nRF52 DK can, also, be powered via external power supply through related connector, external Li-Po battery, or via USB Micro B connector.

When powered from a battery alone, the power management IC switches off the internal regulator and supplies power to the system directly from the battery.

Power source (Debugger VDD, Li-Po, USB) is selected by on-board switch SW9.

## Connect, Register, Virtualize and Program

The Nordic nRF52 DK can be programmed through the on-board SEGGER J-Link debugger that exposes three USB interfaces:


* A serial port over USB
* A mass storage device for drag-n-drop programming flash memory
* A SEGGER J-Link debug channel

**Drivers are needed** (Linux, Mac or Windows) and can be downloaded from the official
[JLink software](https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack)
page.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access:
	* **Ubuntu** distribution –> dialout group
	* **Arch Linux** distribution –> uucp group

Once connected to a USB port, the Nordic nRF52 DK device is recognized by Zerynth Studio. The board can be virtualized by clicking the related Studio button without requiring any other user intervention.

Follow these steps to uplink a Zerynth script on a virtualized nRF52 DK:

* **Select** nRF52 DK on the **Device Management Toolbar** (disambiguate if necessary);
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process.

After virtualization, the device is ready to be programmed and the  Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio.

!!! important
    To exploit the BLE chip functionalities of nRF52 DK, the lib.nordic.nrf52_ble library must be installed and imported on the Zerynth script. Moreover, in the creation phase, a VM with BLE support must be selected.
<!--stackedit_data:
eyJoaXN0b3J5IjpbNjA3MTUyMTU2LC0yMTIwMDEwNjQwXX0=
-->

# Flip & Click Sam3X

The Flip & Click is a microcontroller device based on the Atmel [SAM3X8E ARM Cortex-M3 CPU](http://www.atmel.com/Images/Atmel-11057-32-bit-Cortex-M3-Microcontroller-SAM3X-SAM3A_Datasheet.pdf), produced by [MikroElektronika](http://www.mikroe.com/flip-n-click/)

This device has the predisposition in both sides for shields and expansion boards in general:


* In the front side (Blue side in MikroElektronica parlance), it features the Arduino Uno standard pinout with additional SPI pins;
* In the back side (White side in MikroE parlance) the device has four mikroBUS sockets to connect [MikroE Click Boards](https://shop.mikroe.com/click) showing one of the best features for a hardware development platform: **modularity**.

!!! note
	Clicks are bite-sized add-on boards with a standardized mikroBUS connector that make prototyping as elegant and enjoyable as it gets. Each one carries a single sensor, transceiver, display, encoder, connection port or any other sort of chip or module.

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/flipnclick_sam3x/docs/img/flipnclick.jpg?raw=true)

With more than 160 to choose from, and more coming out every week, it’s very simple to create a custom product by simply adding new functionality to the main device.

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/flipnclick_sam3x/docs/img/flipnclickpin.jpg?raw=true)

MikroElektronika Flip & Click official manual is available [here](http://download.mikroe.com/documents/starter-boards/other/flip-n-click/flip-n-click-manual-v100.pdf).

## Flash Layout

The internal flash of the Flip & Click Sam3X is organized into two banks of 256k each. Each bank is divided into 1024 pages of 256 bytes each. The first bank, starting at 0x80000, is used by the virtual machine runtime. The second bank is used to store bytecode and can be read and written from a Zerynth program using the internal flash module. The bytecode always starts at the address 0xC0000 (the starting address of the second bank) and ends depending on its size. The second bank extends up to address 0x100000. If internal flash has to be used in a Zerynth program, it is recommended to start using pages from the end of the bank towards the bytecode, to minimize the chance of clashes.

## Device Summary


* Microcontroller: AT91SAM3X8E
* Operating Voltage: 3.3V
* Input Voltage: 7-12V
* Digital I/O Pins (DIO): 49
* Analog Input Pins (ADC): 5
* UARTs: 4
* SPIs: 1
* I2Cs: 2
* Flash Memory: 512 KB
* SRAM: 96 KB
* Clock Speed: 84 MHz
* Slots for Clicks: 4

## Power

The Flip & Click can be powered via the USB connector or with an external power supply. The power source is selected automatically.
External (non-USB) power can come either from an AC-to-DC adapter (wall-wart) or battery. The adapter can be connected by plugging a 2.1 mm center-positive plug into the device’s power jack. Leads from a battery can be inserted in the Gnd and Vin pin headers of the POWER connector.

The device can operate on an external supply of 6 to 20 volts. If supplied with less than 7V, however, the 5V pin may supply less than five volts and the device may be unstable. If more than 12V are used, the voltage regulator may overheat and damage the device. The recommended range is 7 to 12 volts.

## Connect, Register, Virtualize and Program

The Flip & Click Programming port is connected to an ATmega16U2, which provides a virtual COM port to software on a connected computer, allowing for a seamless virtualization of the device.

!!! note
	Drivers for the FTDI can be downloaded [here](http://www.ftdichip.com/Drivers/VCP.htm) and are needed for **Windows and Mac platforms**.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access: **Ubuntu** distribution –> dialout group; **Arch Linux** distribution –> uucp group.

The 16U2 is also connected to the SAM3X hardware UART. Serial on pins RX0 and TX0 provides Serial-to-USB communication for programming the device through the ATmega16U2 microcontroller.

Once connected on a USB port, if drivers have been correctly installed, the Flip & Click device is recognized by Zerynth Studio. The next steps are:

* **Select** the Flip & Click on the **Device Management Toolbar**;
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

!!! note
	No user device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio.

Check this video for a live demo:

  <div stylSe="margin-top:10px;">
<iframe width="100%" height="481" src="https://www.youtube.com/embed/u2pEH5dSZbo?ecver=1" frameborder="0" gesture="media" allow="encrypted-media" allowfullscreen></iframe>
  </div>
  !!! note
	  No user intervention on the device is required for the uplink process.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Flip & Click device is available for bytecode only.

Flash Layout is shown in table below:

| Start address | Size       | Content         |
|---------------|------------|-----------------|
| 0x00080000    | 256Kb      | VM Slot         |
| 0x000C0000    | 125Kb      | Bytecode Slot 0 |
| 0x000E0000    | 128Kb-256b | Bytecode Slot 1 |
| 0x000FFF00    | 256b       | FOTA Record     |


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTQ0MTQzOTY1NV19
-->

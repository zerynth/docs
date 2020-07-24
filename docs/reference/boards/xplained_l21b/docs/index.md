# Xplained Pro Sam L21

The SAM L21 Xplained Pro evaluation kit is a hardware platform to evaluate the [ATSAML21J18B ARM Cortex-M0+ CPU](http://ww1.microchip.com/downloads/en/DeviceDoc/60001477A.pdf).
The device provides easy access to the features of the Atmel ATSAML21J18B and explains how to integrate the device in a custom design.
The Xplained Pro MCU series evaluation kits include an on-board Embedded Debugger, and no external tools are necessary to program or debug the ATSAML21J18B.

The Xplained Pro extension kits offers additional peripherals to extend the features of the device and ease the development of custom designs. It has 43 digital input/output pins, 19 analog inputs, 3 UARTs (hardware serial ports), a 48 MHz clock, 1 I2C, 2 SPI header, a reset button.

One of its most important features is the Atmel Embedded Debugger (EDBG), which provides a full debug interface without the need for additional hardware, significantly increasing the ease-of-use for software debugging. EDBG also supports a virtual COM port that can be used for device and bootloader programming.

<p style="text-align:center;"><img src="img/XplainedProSamL21.jpg"></p>

!!! note
	All the reported information are extracted from the official [Xplained Pro Sam L21 page](http://www.microchip.com/developmenttools/productdetails.aspx?partno=atsaml21-xpro-b&utm_source=MicroSolutions&utm_medium=Link&utm_term=FY18Q1&utm_content=DevTools&utm_campaign=Article), visit this page for more details and updates.

## Pin Mapping

![](img/xplained_l21b_pin_io.jpg)

Xplained Pro Sam L21 Official Schematic, Reference Design and Pin Mapping are available on the official [Atmel User Guide](http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-42405-SAML21-Xplained-Pro_User-Guide.pdf).

## Flash Layout

The internal flash of the Xplained Pro Sam L21 is organized as a single bank of 256k. Zerynth VM starts at first address of the flash memory.

## Device Summary


* Microcontroller: ATSAML21J18B
* Operating Voltage: 3.3V
* Digital I/O Pins (DIO): 43
* Analog Input Pins (ADC): 19
* UARTs: 3
* SPIs: 2
* I2Cs: 1
* Flash Memory: 256 KB
* SRAM: 32 KB
* Clock Speed: 48 MHz

## Power

The Xplained Pro Sam L21 can be powered via the USB connector or with an external power supply via “GND” and “5.0 IN” pins of the PWR header.

The device can operate on an external supply of 5V ±2% (±100mV) for USB host operation or from 4.3V to 5.5V if USB host operation is not required. Current recommended requirements, in external power supply mode, are:


* minimum 1A to be able to provide enough current for connected USB devices and the     device itself.
* maximum is 2A due to the input protection maximum current specification

The SAM L21 Xplained Pro has a backup battery for use with the SAM L21 backup module. The battery can be connected to the device by placing a jumper over pin 1-2 on the 3-pin VBAT SELECT header. By default the jumper is placed over pin 2-3 to select the board power supply. This configuration is selected to avoid draining the battery and can be used during development.

!!! note
	External power is required when 500mA from a USB connector is not enough to power the device with possible extension boards. A connected USB device in a USB host application might easily exceed this limit.

## Connect, Register, Virtualize and Program

The Xplained Pro Sam L21 debug port is connected to EDBG, which provides a virtual COM port to software on a connected computer. To recognize the device, all **Windows** (automatic driver software installation), **OSX** and **Linux** machines will recognize the device as a COM port automatically.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access: **Ubuntu** distribution –> dialout group; **Arch Linux** distribution –> uucp group.

    If the device is still not recognized or not working, the following udev rules may need to be added:

    ```bash
    # Check SUBSYSTEM
    SUBSYSTEMS=="hidraw", KERNEL=="hidraw*", MODE="0666", GROUP="dialout"

    # Xplained Pro SamL21 Device
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2111", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEMS=="tty", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2111", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
    ```

EDBG is also connected to the SAML21 hardware UART. Serial on pins RX0 and TX0 provides Serial-to-USB communication for programming the device through Atmel EDBG.

Once connected on a USB port the Xplained Pro Sam L21 device is recognized by Zerynth Studio. The next steps are:


* **Select** the Xplained Pro Sam L21 on the **Device Management Toolbar** (disambiguate if necessary);
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process.

After virtualization, the Xplained Pro Sam L21 is ready to be programmed and the Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio and **reset** the device by pressing the Reset on-board button when asked.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Xplained Pro Sam L21 device is available for bytecode only.

Flash Layout is shown in table below:

| Start address | Size | Content         |
|---------------|------|-----------------|
| 0x00002000    | 88Kb | VM Slot         |
| 0x00018000    | 80Kb | Bytecode Slot 0 |
| 0x0002C000    | 80Kb | Bytecode Slot 1 |


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTIxMTAxNTI5MF19
-->

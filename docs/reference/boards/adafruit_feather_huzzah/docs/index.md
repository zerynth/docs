# Adafruit Feather Huzzah

The Adafruit Feather Huzzah ESP8266 is an ‘all-in-one’ ESP8266 WiFi development board with built in USB and battery charging. The Feather Huzzah features 4MB of flash memory, Tensilica microcontroller (80MHz of system clock), around 50k of usable RAM and an Espressif ESP8266 chip Wi-fi Transceiver.

This device wired up a high-quality SiLabs CP2104 USB-Serial chip that can upload code at a blistering 921600 baud for fast development time. It also has auto-reset so no noodling with pins and reset button pressings.

To make it easy to use for portable projects, the Adafruit Feather Huzzah provides a connector for a 3.7/4.2 V Lithium polymer battery and built in battery charging circuit thought USB port. The Feather will automatically switch over to USB power when its available.

<img style="text-align: center;" src="https://raw.githubusercontent.com/zerynth/docs/test/docs/reference/boards/adafruit_feather_huzzah/docs/img/adafruit_feather_huzzah.png">


## Pin Mapping
![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/adafruit_feather_huzzah/docs/img/adafruit_feather_huzzah_pin_io.png?raw=true)

Official reference for Adafruit Feather Huzzah can be found [here](https://www.adafruit.com/product/2821).

## Flash Layout

The Adafruit Feather Huzzah device features a 4 MB (32 Mb) flash memory organized in sectors of 4k each. The flash memory address starts at 0x40200000 and can be read and written from a Zerynth program using the internal flash module.

!!! warning
	If flash memory must be used in a Zerynth program, it is recommended to begin using it from secure addresses towards the end the bytecode (start address of the bytecode can be found in the log console of Zerynth Studio during the ```uplink``` operation), leaving a minimum safe place to minimize the chance of clashes.

!!! note
	The internal flash of Adafruit Feather Huzzah can be organized in different ways. The standard VM is a non-FOTA VM with the VM code beginning at 0x0000, followed by the esp8266 ir0m image at 0x20000 and the esp_init_data at 0x3fc000. The VM is based on the Espressif RTOS SDK 1.4.1.

## Device Summary


* Microcontroller: Tensilica 32-bit RISC CPU Xtensa LX106


* Operating Voltage: 3.3V


* Input Voltage: 7-12V


* Digital I/O Pins (DIO): 12


* Analog Input Pins (ADC): 1


* UARTs: 2


* SPIs: 1


* I2Cs: 1


* Flash Memory: 4 MB


* SRAM: 64 KB


* Clock Speed: 80 Mhz


* Wi-Fi: IEEE 802.11 b/g/n:


    * Integrated TR switch, balun, LNA, power amplifier and matching network


    * WEP or WPA/WPA2 authentication, or open networks

## Power

Power to the Adafruit Feather Huzzah is supplied via the on-board USB Micro B connector or directly throught the connector for a 3.7/4.2 V battery. The power source is selected automatically.

The device can operate on an external supply of 2.5 to 6 volts. If using more than 6V, the voltage regulator may overheat and damage the device.

## Connect, Register, Virtualize and Program

The Adafruit Feather Huzzah exposes the serial port of the ESP8266 module via a CP2104 usb bridge which is also connected to the boot pins of the module, allowing for a seamless virtualization of the device.

!!! note
	Drivers for the bridge can be downloaded [here](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers) and are needed for **Windows and Mac platforms**.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access:                             **Ubuntu** distribution –> dialout group                                                      **Arch Linux** distribution –> uucp group

Once connected to a USB port the Feather Huzzah device can be seen as a Virtual Serial port and it is automatically recognized by Zerynth Studio. The next steps are:


* ```Select``` the Feather Huzzah on the **Device Management Toolbar** (Disambiguate operation may be required);


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process

After virtualization, the Feather Huzzah device is ready to be programmed and the  Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “upload” button of Zerynth Studio.

!!! note
	No user intervention on the device is required for the upload process.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Adafruit Feather Huzzah device is available for bytecode only.

Flash Layout is shown in table below:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x40200000    | 448Kb | VM Slot         |
| 0x40270000    | 256Kb | Bytecode Slot 0 |
| 0x402B0000    | 320Kb | Bytecode Slot 1 |

## Power Management

Power Management feature allows to optimize power consumption by putting the device in low consumption state. More information in Power Management - ESP8266 section.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTU5NTU0MDQ0Miw5MDQwNTM4NTIsLTEzNj
I5ODU4MTgsLTE4MTk0MzUzNjMsMjMxODA4NTQ4LDE1NzgxMzA5
OTAsLTIxNjg1MDkyMCwtMTQ2MTIwNzg4OCw1MzE4NDc5OCw2OD
E4NDYxOTRdfQ==
-->

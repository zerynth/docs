# Sparkfun ESP32 Thing

The Esp32 Thing device is one of the development board created by Sparkfun to evaluate the ESP-WROOM-32 module. It is based on the [ESP32 microcontroller](https://espressif.com/en/products/hardware/esp32/overview) that boasts Wifi, Bluetooth, Ethernet and Low Power support all in a single chip.

## Pin Mapping

Official reference for Sparkfun ESP32 Thing can be found [here](https://www.sparkfun.com/products/13907).

## Flash Layout

The internal flash of the ESP32 module is organized in a single flash area with pages of 4096 bytes each. The flash starts at address 0x00000, but many areas are reserved for Esp32 IDF SDK and Zerynth VM. There exist two different layouts based on the presence of BLE support.

In particular, for non-BLE VMs:
| Start address | Size  | Content                 |
|---------------|-------|-------------------------|
| 0x00009000    | 16Kb  | Esp32 NVS area          |
| 0x0000D000    | 8Kb   | Esp32 OTA data          |
| 0x0000F000    | 4Kb   | Esp32 PHY data          |
| 0x00010000    | 1Mb   | Zerynth VM              |
| 0x00110000    | 1Mb   | Zerynth VM (FOTA)       |
| 0x00210000    | 512Kb | Zerynth Bytecode        |
| 0x00290000    | 512Kb | Zerynth Bytecode (FOTA) |
| 0x00310000    | 512Kb | Free for user storage   |
| 0x00390000    | 448Kb | Reserved                |

For BLE VMs:
| Start address | Size   | Content                 |
|---------------|--------|-------------------------|
| 0x00009000    | 16Kb   | Esp32 NVS area          |
| 0x0000D000    | 8Kb    | Esp32 OTA data          |
| 0x0000F000    | 4Kb    | Esp32 PHY data          |
| 0x00010000    | 1216Kb | Zerynth VM              |
| 0x00140000    | 1216Kb | Zerynth VM (FOTA)       |
| 0x00270000    | 320Kb  | Zerynth Bytecode        |
| 0x002C0000    | 320Kb  | Zerynth Bytecode (FOTA) |
| 0x00310000    | 512Kb  | Free for user storage   |
| 0x00390000    | 448Kb  | Reserved                |

## Device Summary


* Microcontroller: Tensilica 32-bit Single-/Dual-core CPU Xtensa LX6


* Operating Voltage: 3.3V


* Input Voltage: 3.7-6V


* Digital I/O Pins (DIO): 28


* Analog Input Pins (ADC): 4


* UARTs: 3


* SPIs: 1


* I2Cs: 1


* Flash Memory: 4 MB


* SRAM: 520 KB


* Clock Speed: 240 Mhz


* Wi-Fi: IEEE 802.11 b/g/n/e/i:


    * Integrated TR switch, balun, LNA, power amplifier and matching network


    * WEP or WPA/WPA2 authentication, or open networks

## Power

Power to the Sparkfun ESP32 Thing is supplied via the on-board USB Micro B connector or directly throught the connector for a 3.7/4.2 V battery. The power source is selected automatically.

If both USB and the LiPo are plugged into the board, the onboard charge controller will charge the LiPo battery at a rate of up to 500mA.

!!! warning
	The ESP32’s operating voltage range is 2.2 to 3.6V. Under normal operation the ESP32 Thing will power the chip at 3.3V. The I/O pins are not 5V-tolerant!

In addition to USB and battery connectors, the VBAT, and VUSB pins are all broken out to both sides of the board. These pins can be used as an alternative supply input to the Thing.

The maximum, allowable voltage input to VUSB is 6V, and VBAT should not be connected to anything other than a LiPo battery. Alternatively, if you have a regulated voltage source between 2.2V and 3.6V, the “3V3” lines can be used to directly supply the ESP32 and its peripherals.

## Connect, Register, Virtualize and Program

The Sparkfun ESP32 Thing comes with a serial-to-usb chip on board that allows programming and opening the UART of the ESP32 module. The FTDI FT231x is also connected to the boot pins of the module, allowing for a seamless virtualization of the device.

!!! note
	Drivers for the FT231x Module can be downloaded [here](http://www.ftdichip.com/Drivers/VCP.htm) and are needed for **Windows and Mac platforms**. In Linux systems, the Sparkfun ESP32 Thing should work out of the box.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access:


* ```Ubuntu``` distribution –> dialout group


* **Arch Linux** distribution –> uucp group

Once connected on a USB port, if drivers have been correctly installed, the Sparkfun ESP32 Thing device is recognized by Zerynth Studio. The next steps are:


* ```Select``` the Sparkfun ESP32 Thing on the **Device Management Toolbar** (disambiguate if necessary);


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

```NOTE```: No user intervention on the device is required for registration and virtualization process

After virtualization, the Sparkfun ESP32 Thing is ready to be programmed and the  Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “upload” button of Zerynth Studio.

```NOTE```: No user intervention on the device is required for the uplink process.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Sparkfun ESP32 Thing device is available for bytecode and VM.

Flash Layout is shown in table below:

| Start address

 | Size

   | Content

                 |
| ------------- | ------ | ----------------------- |
| 0x00010000

    | 1Mb

    | Zerynth VM (slot 0)

     |
| 0x00110000

    | 1Mb

    | Zerynth VM (slot 1)

     |
| 0x00210000

    | 512Kb

  | Zerynth Bytecode (slot 0)

 |
| 0x00290000

    | 512Kb

  | Zerynth Bytecode (slot 1)

 |
For BLE VMs:

| Start address

 | Size

   | Content

                   |
| ------------- | ------ | ------------------------- |
| 0x00010000

    | 1216Kb

 | Zerynth VM (slot 0)

       |
| 0x00140000

    | 1216Kb

 | Zerynth VM (slot 1)

       |
| 0x00270000

    | 320Kb

  | Zerynth Bytecode (slot 0)

 |
| 0x002C0000

    | 320Kb

  | Zerynth Bytecode (slot 1)

 |
For Esp32 based devices, the FOTA process is implemented mostly by using the provided system calls in the IDF framework. The selection of the next VM to be run is therefore a duty of the Espressif bootloader; the bootloader however, does not provide a failsafe mechanism to revert to the previous VM in case the currently selected one fails to start. At the moment this lack of a safety feature can not be circumvented, unless by changing the bootloader. As soon as Espressif relases a new IDF with such feature, we will release updated VMs.

## Secure Firmware

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

This feature is strongly platform dependent; more information at Secure Firmware - ESP32 section.

## Missing features

Not all IDF features have been included in the Esp32 based VMs. In particular the following are missing but will be added in the near future:


* Touch detection support
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTYyNTI4MjcxN119
-->
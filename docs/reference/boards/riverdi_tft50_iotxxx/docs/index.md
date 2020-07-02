# Riverdi IoT Display

Riverdi IoT Display RiTFT-50-IOT-xxx is a complete HMI solution equipped with Bridgetek’s BT81x embedded video engine (EVE).

It aims to provide the best tool for fast development of touchscreen user interfaces. The [ESP32 microcontroller](https://espressif.com/en/products/hardware/esp32/overview) allows easy usage of Wi-Fi and Bluetooth, while the BT81x graphics controller simplifies the process of creating user interfaces. The module has a built-in USB bridge for programming the display directly from the PC.

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/riverdi_tft50_iotxxx/docs/img/riverdi_tft50_iotxxx.jpg?raw=true)

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/riverdi_tft50_iotxxx/docs/img/riverdi_tft50_iotxxx_pin_comm.jpg?raw=true)


## Flash Layout

The internal flash of the ESP32 module is organized in a single flash area with pages of 4096 bytes each. The flash starts at address 0x00000, but many areas are reserved for Esp32 IDF SDK and Zerynth VM. There exist two different layouts based on the presence of BLE suport.

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
* Input Voltage: 7-12V
* 5” TFT display 800×480 resolution driven by BT815 graphics controller
* Digital I/O Pins (DIO): 28
* Analog Input Pins (ADC): 8
* Analog Outputs Pins (DAC): 2
* UARTs: 2
* SPIs: 1
* I2Cs: 1
* Flash Memory: 4 MB
* SRAM: 520 KB
* Clock Speed: 240 Mhz
* Wi-Fi: IEEE 802.11 b/g/n/e/i:
    * Integrated TR switch, balun, LNA, power amplifier and matching network
    * WEP or WPA/WPA2 authentication, or open networks

## Power

Power to the Riverdi IoT Display is supplied via the on-board USB Micro B connector or directly with external power supply through related connector.

## Connect, Register, Virtualize and Program

The Riverdi IoT Display comes with a serial-to-usb chip on board that allows programming and opening the UART of the ESP32 module. The FT232H FTDI USB to UART chip is also connected to the boot pins of the module, allowing for a seamless virtualization of the device.

The FT232H FTDI USB to UART chip should be supported natively by all platforms. If serial port is not correctly seen, VCP (Virtual COM port) drivers can be downloaded from [here](https://www.ftdichip.com/Drivers/VCP.htm)

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access: **Ubuntu** distribution –> dialout group; **Arch Linux** distribution –> uucp group.

Once connected on a USB port, if drivers have been correctly installed, the Riverdi IoT Display is recognized by Zerynth Studio. The next steps are:

* **Select** the Riverdi IoT Display on the **Device Management Toolbar** (disambiguate if necessary);
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

!!! note
    No user intervention on the device is required for registration and virtualization process.

After virtualization, the Riverdi IoT Display is ready to be programmed and the Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio.

!!! note
	No user intervention on the device is required for registration and virtualization process.

!!! important
    To exploit the 5” TFT display 800×480 resolution driven by BT815 graphics controller, the lib.riverdi.displays library must be installed and imported on the Zerynth script.

!!! important
    To test a complete IoT Demo App, just create a new Zerynth project using the “clone from Github” feature with this Github repo [link](https://github.com/riverdi/RiTFT-50-IOT-XX).


## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Riverdi IoT Display is available for bytecode and VM.

Flash Layout is shown in table below:

| Start address | Size  | Content                   |
|---------------|-------|---------------------------|
| 0x00010000    | 1Mb   | Zerynth VM (slot 0)       |
| 0x00110000    | 1Mb   | Zerynth VM (slot 1)       |
| 0x00210000    | 512Kb | Zerynth Bytecode (slot 0) |
| 0x00290000    | 512Kb | Zerynth Bytecode (slot 1) |

For Esp32 based devices, the FOTA process is implemented mostly by using the provided system calls in the IDF framework. The selection of the next VM to be run is therefore a duty of the Espressif bootloader; the bootloader however, does not provide a failsafe mechanism to revert to the previous VM in case the currently selected one fails to start. At the moment this lack of a safety feature can not be circumvented, unless by changing the bootloader. As soon as Espressif relases a new IDF with such feature, we will release updated VMs.

## Secure Firmware

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

This feature is strongly platform dependent; more information at [Secure Firmware - ESP32 section](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_sfw.html#sfw-esp32).

## Zerynth secure socket

To be able to use zerynth secure socket on esp32 boards `native_mbedtls: true` must be used instead of `zerynth_ssl: true` in the `project.yml` file.

## Missing features

Not all IDF features have been included in the Esp32 based VMs. In particular the following are missing but will be added in the near future:


* Touch detection support
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExNDkzMzk2ODZdfQ==
-->

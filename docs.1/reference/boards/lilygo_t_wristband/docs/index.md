# Lilygo T-Wristband

The Lilygo T-Wristband is a smart programmable bracelet based on ESP32 microcontroller that boasts Wifi, Bluetooth, Ethernet and Low Power support all in a single chip.

T-Wristband has a built-in PCF8563 clock chip and a matching 13PIN FPC cable, built-in WiFi / Bluetooth ceramic antenna, and 55mA rechargeable lithium battery.

It is also equipped with MPU9250 sensor and 0.96-inch color OLED display with adjustable backlight, TTP223 touch key chip.

![](img/lilygo_twristband.png)

## Pin Mapping

![](img/pin_mapping.png)

Product Page for Lilygo T-Wristband can be found [here](http://www.lilygo.cn/claprod_view.aspx?TypeId=62&Id=1282&FId=t28:62:28).

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

- Microcontroller: Tensilica 32-bit Single-/Dual-core CPU Xtensa LX6
- Operating Voltage: 3.3V
- Input Voltage: 7-12V
- Digital I/O Pins (DIO): 10
- UARTs: 2
- SPIs: 2
- I2Cs: 2
- Flash Memory: 4 MB
- SRAM: 520 KB
- Clock Speed: 240 Mhz
- **Wi-Fi:** IEEE 802.11 b/g/n/e/i:
    - Integrated TR switch, balun, LNA, power amplifier and matching network
    - WEP or WPA/WPA2 authentication, or open networks
- **Onboard components:**
    - Sitronix ST7735 Oled Display
    - Accelerometer/Gyroscope/Magnetometer Sensor InvenSense MPU9250
    - Real Time Clock NXP PCF8563
    - TonTouch TTP223 touch key chip


## Power

Power to the Lilygo T-Wristband is supplied via the on-board Li-Po Battery. The battery can be charged by related charger usb cable or through the programmer board.

## Connect, Register, Virtualize and Program

The Lilygo T-Wristband has a programmer board with serial-to-usb chip on board that allows programming and opening the UART of the ESP32 module. Drivers may be needed depending on your system (Mac or Windows) and can be download from the official [Espressif documentation](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/establish-serial-connection.html) page. In Linux systems, the Lilygo T-Wristband should work out of the box.

!!! note
    **For Linux Platform:** to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access:
	**Ubuntu distribution** –> dialout group; **Arch Linux distribution** –> uucp group.

Once connected on a USB port, if drivers have been correctly installed, the Lilygo T-Wristband device is recognized by Zerynth Studio. The next steps are:

- **Select** the Lilygo T-Wristband on the **Device Management Toolbar** (disambiguate if necessary);
- **Register** the device by clicking the “Z” button from the Zerynth Studio;
- **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
- **Virtualize** the device by clicking the “Z” button for the third time.

!!!note
   No user intervention on the device is required for registration and virtualization process.

After virtualization, the Lilygo T-Wristband is ready to be programmed and the Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio.

!!!note
   No user intervention on the device is required for the uplink process.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Lilygo T-Wristband device is available for bytecode and VM.

Flash Layout is shown in table below:

| Start address | Size  | Content                   |
|---------------|-------|---------------------------|
| 0x00010000    | 1Mb   | Zerynth VM (slot 0)       |
| 0x00110000    | 1Mb   | Zerynth VM (slot 1)       |
| 0x00210000    | 512Kb | Zerynth Bytecode (slot 0) |
| 0x00290000    | 512Kb | Zerynth Bytecode (slot 1) |

For BLE VMs:

| Start address | Size   | Content                   |
|---------------|--------|---------------------------|
| 0x00010000    | 1216Kb | Zerynth VM (slot 0)       |
| 0x00140000    | 1216Kb | Zerynth VM (slot 1)       |
| 0x00270000    | 320Kb  | Zerynth Bytecode (slot 0) |
| 0x002C0000    | 320Kb  | Zerynth Bytecode (slot 1) |

For Esp32 based devices, the FOTA process is implemented mostly by using the provided system calls in the IDF framework. The selection of the next VM to be run is therefore a duty of the Espressif bootloader; the bootloader however, does not provide a failsafe mechanism to revert to the previous VM in case the currently selected one fails to start. At the moment this lack of a safety feature can not be circumvented, unless by changing the bootloader. As soon as Espressif relases a new IDF with such feature, we will release updated VMs.

## Secure Firmware

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

This feature is strongly platform dependent; more information at [Secure Firmware - ESP32 section](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_sfw.html#sfw-esp32).

## Zerynth Secure Socket

To be able to use Zerynth Secure Socket on esp32 boards ```NATIVE_MBEDTLS: true``` must be used instead of ```ZERYNTH_SSL: true``` in the ```project.yml``` file.

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExODA5MTU5NTFdfQ==
-->
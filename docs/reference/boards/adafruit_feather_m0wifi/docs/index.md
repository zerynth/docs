# Adafruit Feather M0 Wi-Fi

The Adafruit Feather M0 Wi-Fi is based on the Atmel (Microchip Technology) [ATSAMD21 microcontroller](http://www.microchip.com/wwwproducts/en/ATSAMD21G18) (Cortex-M0+ 32bit low power ARM MCU) and features on-board the [ATWINC1500 Wi-Fi module](http://www.microchip.com/wwwproducts/en/ATWINC1500), a low power network controller (2.4GHz IEEE® 802.11 b/g/n Wi-Fi), specifically designed for IoT projects and devices.

The design includes a Li-Po charging circuit that allows the Adafruit Feather M0 Wi-Fi to run on battery power or external 5V, charging the Li-Po battery while running on external power. Switching from one source to the other is done automatically.

All these features make this device the preferred choice for the emerging IoT battery-powered projects in a compact form factor.

!!! warning
	the Adafruit Feather M0 Wi-Fi runs at 3.3V. The maximum voltage that the I/O pins can tolerate is 3.3V. Applying voltages higher than 3.3V to any I/O pin could damage the device.

!!! note
	All the reported information are extracted from the official [Adafruit Feather M0 Wi-Fi page](https://www.adafruit.com/product/3010), visit this page for more details and updates.
<p style="text-align:center;"><img src="https://github.com/zerynth/docs/blob/test/docs/reference/boards/adafruit_feather_m0wifi/docs/img/Adafruit_Feather_M0WiFi.jpg?raw=true">

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/adafruit_feather_m0wifi/docs/img/Adafruit_Feather_M0WiFi_pin_io.png?raw=true)
Adafruit Feather M0 Wi-Fi Official Schematic, Reference Design and Pin Mapping are available on the official [Adafruit Feather M0 Wi-Fi reference page](https://learn.adafruit.com/adafruit-feather-m0-wifi-atwinc1500/).

## Flash Layout

The internal flash of the Adafruit Feather M0 Wi-Fi is organized as a single bank of 256k.

!!! note
	Zerynth VM preserves SAM-BA Bootloader located at Flash start.

## Device Summary


* Microcontroller: SAMD21 Cortex-M0+ 32bit low power ARM MCU


* Power Supply (USB/VIN): 5V


* Supported Battery: Li-Po single cell, 3.7V, 700mAh minimum


* Operating Voltage: 3.3V


* Digital I/O Pins (DIO): 14


* Analog Input Pins (ADC): 6


* UARTs: 2


* SPIs: 1


* I2Cs: 1


* Flash Memory: 256 KB


* SRAM: 32 KB


* Clock Speed: 48 MHz


* Size (LxW mm): 61.5 x 25.0

## Power

Power to the Adafruit Feather M0 Wi-Fi is supplied via the on-board USB Micro B connector or directly throught the connector for a 3.7/4.2 V battery. The power source is selected automatically.

The device can operate on an external supply of 2.5 to 6 volts. If using more than 6V, the voltage regulator may overheat and damage the device.

## Connect, Register, Virtualize and Program

Adafruit Feather M0 Wi-Fi should be recognized out of the box for Windows 8/10/+, Mac and Linux platforms; for Windows 7 platform, drivers must be installed and can be found [here](https://github.com/adafruit/Adafruit_Windows_Drivers/releases/download/2.0.0.0/adafruit_drivers_2.0.0.0.exe), otherwise this can be done by using the [Zadig utility](http://zadig.akeo.ie/) version 2.2 or greate.

!!! note
	Drivers must be installed for both ```Standard``` and **Virtualization Mode** of the Feather M0 Wi-Fi device.

!!! warning
	Remember, when using the Zadig utility, to select “Options > List all devices” to search for the Feather M0 Wi-Fi device. Select the Usb CDC driver for the standard mode and any other for the virtualization mode

Once connected on a USB port, if drivers have been correctly installed, the Adafruit Feather M0 Wi-Fi device is recognized by the Zerynth Studio and listed in the **Device Management Toolbar**.

Follow these steps to register and virtualize a Adafruit Feather M0 Wi-Fi:


* ```Put``` the Feather M0 Wi-Fi in **Virtualization Mode**:


    * Double click on the RST button;


* ```Select``` the Adafruit Feather M0 Wi-Fi Virtualizable on the **Device Management Toolbar**;


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

!!! note
	During these operations the Feather M0 Wi-Fi device must be in **Virtualization Mode**. if the device returns in standard mode, it is necessary to put it in Virtualization Mode again.

After virtualization, the Adafruit Feather M0 Wi-Fi is ready to be programmed and the  Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar”, ```click``` the dedicated “upload” button of Zerynth Studio and ```reset``` the device by pressing the RST on-board button when asked.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Adafruit Feather M0 Wi-Fi device is available for bytecode only.

Flash Layout is shown in table below:

| Start address | Size | Content         |
|---------------|------|-----------------|
| 0x00002000    | 94Kb | VM Slot         |
| 0x00019600    | 77Kb | Bytecode Slot 0 |
| 0x0002CB00    | 77Kb | Bytecode Slot 1 |

## Power Management and Secure Firmware

Power Management feature allows to optimize power consumption by putting the device in low consumption state.

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

Both these features are strongly platform dependent; more information at Power Management - Microchip SAMD21 section and Secure Firmware - Microchip SAMD21 section.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTYwNDQxMDkwNSwtMTk4MjU4OTQxLDE2Nj
ExMzMzMzNdfQ==
-->

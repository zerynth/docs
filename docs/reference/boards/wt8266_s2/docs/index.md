# Wireless Tag WT8266-DK V2

Wireless Tag WT8266-DK V2 provides specialized UART_WiFi functional test board to facilitate the customers to test the Wi-Fi module.
Thanks to WT8266-DK V2, the user can simulate serial devices to access WiFi network and realize data transmission, but also can simulate WT8266-DK V2 works as the main control chip to access data of other devices and control.

The WT8266-DK V2 device features 4MB of flash memory, 80MHz of system clock, around 50k of usable RAM and an on chip Wifi Transceiver.

## Pin Mapping

Official reference for Wireless Tag WT8266-DK V2 can be found [here](http://www.wireless-tag.com/index.php/product/dis/94.html).

## Flash Layout

The Wireless Tag WT8266-DK V2 device features a 4 MB (32 Mb) flash memory organized in sectors of 4k each. The flash memory address starts at 0x40200000 and can be read and written from a Zerynth program using the internal flash module.

!!! warning
	If flash memory must be used in a Zerynth program, it is recommended to begin using it from secure addresses towards the end the bytecode (start address of the bytecode can be found in the log console of Zerynth Studio during the **uplink** operation), leaving a minimum safe place to minimize the chance of clashes.

!!! note
	The internal flash of Wireless Tag WT8266-DK V2 can be organized in different ways. The standard VM is a non-FOTA VM with the VM code beginning at 0x0000, followed by the esp8266 ir0m image at 0x20000 and the esp_init_data at 0x3fc000. The VM is based on the Espressif RTOS SDK 1.4.1.

## Device Summary


* Microcontroller: Tensilica 32-bit RISC CPU Xtensa LX106
* Operating Voltage: 3.3V
* Input Voltage: 7-12V
* Digital I/O Pins (DIO): 11
* Analog Input Pins (ADC): 1
* UARTs: 1
* SPIs: 1
* I2Cs: 1
* Flash Memory: 4 MB
* SRAM: 64 KB
* Clock Speed: 80 Mhz
* Wi-Fi: IEEE 802.11 b/g/n:
    * Integrated TR switch, balun, LNA, power amplifier and matching network
    * WEP or WPA/WPA2 authentication, or open networks

## Power

Power to the WT8266-DK V2 is supplied via the on-board USB Micro B connector.

The device provides an USB-to-UART chip to link the USB port to the Tensilica chip and voltage regulator to adjust the onboard voltage to 3.3 V both fed via USB connector. The recommended range is 4.0 to 5.25 volts.

## Connect, Register, Virtualize and Program

The Wireless Tag WT8266-DK V2 exposes the serial port of the ESP8266 module via a CP2102 usb bridge which is also connected to the boot pins of the module, allowing for a seamless virtualization of the device.

!!! note
	Drivers for the bridge can be downloaded [here](https://www.silabs.com/products/mcu/Pages/USBtoUARTBridgeVCPDrivers.aspx) and are needed for **Windows and Mac platforms**.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access: **Ubuntu** distribution –> dialout group; **Arch Linux** distribution –> uucp group.

Once connected to a USB port the WT8266-DK V2 device can be seen as a Virtual Serial port and it is automatically recognized by Zerynth Studio. The next steps are:


* **Put** the WT8266-DK V2 in **Download Mode**:
    * Hold down BOTH buttons (Reset and Download);
    * Release only the Reset button, while holding down the Download button;
    * Wait for the onboard LED2 turning on while all other leds turn off;
    * Release the Download button; the device is now in Download Mode;
* **Select** the WT8266-DK V2 on the **Device Management Toolbar**;
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

!!! note
	During these operations the WT8266-DK V2 device must be in **Download Mode**. if the device returns in standard mode, it is necessary to put it in Download Mode again

After virtualization, the WT8266-DK V2 device is ready to be programmed and the  Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio and **reset** the device by pressing the Reset on-board button when asked.

!!! important
    To exploit the Wi-Fi chip functionalities of the WT8266-DK V2, the [lib.espressif.esp8266wifi library](https://docs.zerynth.com/latest/official/lib.espressif.esp8266wifi/docs/index.html#esp8266wifi) must be installed (some example code is provided).

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the WT8266-DK V2 device is available for bytecode only.

Flash Layout is shown in table below:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x40200000    | 448Kb | VM Slot         |
| 0x40270000    | 256Kb | Bytecode Slot 0 |
| 0x402B0000    | 320Kb | Bytecode Slot 1 |

## Power Management

!!! important
    FOTA Record (small segment of memory where the current and desired state of the firmware is store) for the WT8266-DK V2 is allocated in the RTC memory.

Power Management feature allows to optimize power consumption by putting the device in low consumption state. More information in [Power Management - ESP8266 section](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_pwr.html#pwr-esp8266).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTg5ODExMTg2OF19
-->

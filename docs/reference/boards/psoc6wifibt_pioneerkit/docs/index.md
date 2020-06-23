# PSoC6 WiFi-Bt Pioneer Kit

The PSoC 6 MCU is Cypress’ latest, ultra-low-power PSoC specifically designed for wearables and IoT products. It is a programmable embedded system-on-chip, integrating a 150-MHz Arm ®Cortex ® -M4 as the primary application processor, a 100-MHz CM0+ that supports low-power operations, up to 1 MB Flash and 288 KB SRAM, CapSense ® touch-sensing, and programmable analog and digital peripherals that allow higher flexibility, in-field tuning of the design, and faster time-to-market.

The PSoC 6 WiFi-BT Pioneer board features a [PSoC 6 MCU](https://www.cypress.com/products/32-bit-arm-cortex-m4-psoc-6), a 512-Mb NOR flash, an onboard programmer/debugger (KitProg2), a 2.4-GHz WLAN and Bluetooth functionality module (CYW4343W), a USB Type-C power delivery system (EZ-PDTM CCG3), a five-segment CapSense slider, two CapSense buttons, one CapSense proximity sensing header, an RGB LED, two user LEDs, USB host and device features, and one push button.

The board supports operating voltages from 1.8 V to 3.3 V for the PSoC 6 MCU. More info can be found [here](https://www.cypress.com/file/407731/download).

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/psoc6wifibt_pioneerkit/docs/img/psoc6wifibt_pioneerkit.png?raw=true)

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/psoc6wifibt_pioneerkit/docs/img/psoc6wifibt_pioneerkit_pin_io.png?raw=true)

Official reference for PSoC6 WiFi-Bt Pioneer Kit can be found [here](https://www.cypress.com/documentation/development-kitsboards/psoc-6-wifi-bt-pioneer-kit-cy8ckit-062-wifi-bt).

## Flash Layout

The internal flash of the PSoC6 WiFi-Bt Pioneer Kit is organized into a bank of 1 MB. The memory bank is divided into 2048 pages of 512 bytes each.

The flash memory starts at 0x10000000 address but up to 0x10002000 is reserved for the CM0+ microcontroller; Addresses from 0x10002000 to 0x10002200 are used by the Zerynth Virtual Machine runtime.

Addresses from 0x10002200 are used to store bytecode and can be read and written from a Zerynth program using the internal flash module. The bytecode always starts at the address 0x10002200 and ends depending on its size. If internal flash has to be used in a Zerynth program, it is recommended to start using pages after the end of the bytecode, to minimize the chance of clashes.

## Device Summary


* Main Microcontroller: ARM 32-bit Cortex™-M4 CPU Core


* Secondary Microcontroller: ARM 32-bit Cortex™-M0+ Core


* KitProg2 on-board debugger


* Operating Voltage: 3.3V


* Input Voltage: 5V


* Digital I/O Pins (DIO): 101


* Analog Input Pins (ADC): 8


* UARTs: 4


* SPIs: 4


* I2Cs: 4


* Flash Memory: 1 MB


* SRAM: 280 KB


* Clock Speed: 100MHz

## Power

Power supply can be provided by the host PC through the KitProg2 or USB Device USB ports.
Please, refer to the [official board documentation](https://www.cypress.com/documentation/development-kitsboards/psoc-6-wifi-bt-pioneer-kit-cy8ckit-062-wifi-bt) for more info.

But only the KitProg2 port can be used for programming purposes.

## Connect, Register, Virtualize and Program

Plug the device using the KitProg2 Port which allows to program the PSoC6 MCU using Cypress KitProg2 programmer.

!!! note
	to successfully program the device, KitProg2 should be put in CMSIS-DAP mode clicking on the MODE SELECT button (only LED4 is turned on within this mode), please refer to the [official KitProg2 documentation](https://www.cypress.com/file/225961/download) for more info

!!! note
	**For Windows Platform**:
install Cypress Programmer tool, which is available for download [here](https://www.cypress.com/products/psoc-programming-solutions)

!!! note
	**For Linux Platform**:
the following udev rules may need to be added:
```
# Match KP2 PID/VID
SUBSYSTEMS=="usb", ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="f148", ENV{CY_KP2_PID_VID}="f148:04b4"
# Match KP2 CMSIS-DAP
SUBSYSTEMS=="usb", ATTRS{interface}=="KitProg2 CMSIS-DAP", ENV{CY_KP2_PID_VID}=="f148:04b4", MODE="0666"
```

The KitProg2 is connected to the PSoC6 `SERIAL0`.

Once connected the PSoC6 WiFi-Bt Pioneer Kit device is recognized by Zerynth Studio and listed in the **Device Management Toolbar**. The next steps are:


* ```Select``` the PSoC6 WiFi-Bt Pioneer Kit on the **Device Management Toolbar** (disambiguate if necessary);


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process

After virtualization, the PSoC6 WiFi-Bt Pioneer Kit device is ready to be programmed and the  Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “uplink” button of Zerynth Studio.

## Missing features

Not all features have been included in the PSoC6 WiFi-Bt Pioneer Kit support. In particular the following are missing:


* Bluetooth support
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyMjA0MzQ2NDNdfQ==
-->
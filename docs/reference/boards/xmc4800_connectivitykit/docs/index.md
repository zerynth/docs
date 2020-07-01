# Infineon XMC4800 Connectivity Kit

Infineon XMC4800 connectivity Kit is equipped with the ARM Cortex-M4 based  [XMC4800 microcontroller (MCU)](https://www.infineon.com/dgdl/Infineon-ReferenceManual_XMC4700_XMC4800-UM-v01_03-EN.pdf?fileId=5546d462518ffd850151904eb90c0044)  from Infineon Technologies. These kits are designed to evaluate the capabilities of the XMC4800 MCU. The connectivity Kits feature an Ethernet-enabled communication option.

<p style="text-align;"><img src="https://github.com/zerynth/docs/blob/test/docs/reference/boards/xmc4800_connectivitykit/docs/img/xmc4800_connectivitykit.jpg?raw=true"></p>

_XMC4800 Connectivity Kit. Copyright Infineon_

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/xmc4800_connectivitykit/docs/img/xmc4800_connectivitykit_io.jpg?raw=true)

Official reference for Infineon XMC4800 connectivity Kit can be found  [here](https://www.infineon.com/cms/en/product/promopages/connectivitykit/).

## Flash Layout

The internal flash of the XMC4800 module is organized in a single flash area with 16 sectors. The flash starts at address 0xC000000.

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0xC000000     | 16Kb  | Zerynth VM      |
| 0xC004000     | 16Kb  | Zerynth VM      |
| 0xC008000     | 16Kb  | Zerynth VM      |
| 0xC00C000     | 16Kb  | Zerynth VM      |
| 0xC010000     | 16Kb  | Zerynth VM      |
| 0xC014000     | 16Kb  | Zerynth VM      |
| 0xC018000     | 16Kb  | Zerynth VM      |
| 0xC01C000     | 16Kb  | Zerynth VM      |
| 0xC020000     | 128Kb | Bytecode Bank 0 |
| 0xC040000     | 256Kb | Bytecode Bank 1 |
| 0xC080000     | 256Kb | Bytecode Bank 2 |
| 0xC0C0000     | 256Kb | Bytecode Bank 3 |
| 0xC100000     | 256Kb | Bytecode Bank 4 |
| 0xC140000     | 256Kb | Bytecode Bank 5 |
| 0xC180000     | 256Kb | Bytecode Bank 6 |
| 0xC1C0000     | 256Kb | Bytecode Bank 7 |

!!! note
	If flash memory must be used in a Zerynth program, it is recommended to begin using it from secure addresses towards the end the bytecode (start address of the bytecode can be found in the log console of Zerynth Studio during the uplink operation), leaving a minimum safe place to minimize the chance of clashes.

## Device Summary

-   XMC4800-F144 Microcontroller based on ARM® Cortex®-M4 @ 144MHz, 2MB Flash and 352KB RAM
-   On-Board Debugger
-   Power over USB
-   MikroBUS connector
-   ESD and reverse current protection
-   1 x user button and 2 x user LED
-   Arduino hardware compatible 3.3V pinout

## Power

Power to the XMC4800 is supplied via one of the two on-board USB Micro B connectors.

## Connect, Register, Virtualize and Program

The Infineon XMC4800 comes with a usb debugger chip on board that allows programming and opening the UART of the module.  **Drivers are needed**  (Linux, Mac or Windows) and can be downloaded from the official  [JLink software](https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack)  page.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access: **Ubuntu**  distribution –> dialout group; **Arch Linux**  distribution –> uucp group

Once connected on a USB port, if drivers have been correctly installed, the XMC4800 device is recognized by Zerynth Studio. The next steps are:

-   **Select**  the XMC4800 on the  **Device Management Toolbar**  (disambiguate if necessary);
-   **Register**  the device by clicking the “Z” button from the Zerynth Studio;
-   **Create**  a Virtual Machine for the device by clicking the “Z” button for the second time;
-   **Virtualize**  the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process

After virtualization, the DevKitC is ready to be programmed and the Zerynth scripts  **uploaded**. Just  **Select**  the virtualized device from the “Device Management Toolbar” and  **click**  the dedicated “upload” button of Zerynth Studio.

!!! note
	No user intervention on the device is required for the uplink process.

## Missing Features

Not all features have been included in the XMC4800 Connectivity Kit support. In particular the following are missing:

* CDC USB Serial Driver
* CAN
* Ethercat
<!--stackedit_data:
eyJoaXN0b3J5IjpbOTM0NTM1NjA3XX0=
-->

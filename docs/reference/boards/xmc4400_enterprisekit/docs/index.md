# Infineon XMC4400 Enterprise Kit

Infineon XMC4400 Enterprise Kit is equipped with the ARM Cortex-M4 based
[XMC4400 microcontroller (MCU)](https://studio.segger.com/packages/XMC4000/CMSIS/Documents/xmc4400_rm_v1.5_2014_04.pdf) from Infineon Technologies. These kits are
designed to evaluate the capabilities of the XMC4400 MCU.

<p style="text-align:center;"><img src="https://github.com/zerynth/docs/blob/test/docs/reference/boards/xmc4400_enterprisekit/docs/img/xmc4400_enterprisekit.jpg?raw=true"></p>

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/xmc4400_enterprisekit/docs/img/xmc4400_enterprisekit_io.jpg?raw=true)

Official reference for Infineon XMC4400 Enterprise Kit can be found
[here](https://www.infineon.com/dgdl/Board_Users_Manual_CPU_Board_XMC4400_General_Purpose_R1%200.pdf?fileId=db3a30433cd75ebf013cf698a0992d5e).

## Flash Layout

The internal flash of the XMC4400 module is organized in a single flash area
with 16 sectors. The flash starts at address 0xC000000.

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

!!! note
	If flash memory must be used in a Zerynth program, it is recommended
to begin using it from secure addresses towards the end the bytecode (start
address of the bytecode can be found in the log console of Zerynth Studio
during the uplink operation), leaving a minimum safe place to minimize the
chance of clashes.

## Device Summary


* XMC4400 Microcontroller based on ARM® Cortex®-M4, 512Kb Flash


* On-Board Debugger


* Power over USB


* ESD and reverse current protection


* 1 x user button and 3 x user LEDs of which an RGB one


* Real Time Clock crystal


* Battery holder for an RTC backup battery


* Ethernet PHY and RJ45 Jack


* 3 Satellite Connectors


* 1 potentiometer

## Power

Power to the XMC4400 is supplied via one of the two on-board USB Micro B connectors.
However there is a current limit that can be drawn from the host PC through USB. If the board is used to drive other satellite cards and the total system current reuired exceeds 500 mA, then the xmc4400 needs to be powered by a satellite cards, which can support external power supply.

## Connect, Register, Virtualize and Program

The Infineon XMC4400 comes with a usb debugger chip on board that allows
programming and opening the UART of the module.
**Drivers are needed** (Linux, Mac or Windows) and can be downloaded from the official
[JLink software](https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack)
page.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access: **Ubuntu** distribution –> dialout group; **Arch Linux** distribution –> uucp group

Once connected on a USB port, if drivers have been correctly installed, the
XMC4400 device is recognized by Zerynth Studio. The next steps are:


* ```Select``` the XMC4400 on the **Device Management Toolbar** (disambiguate if necessary);


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process

After virtualization, the DevKitC is ready to be programmed and the Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “upload” button of Zerynth Studio.

!!! note
	No user intervention on the device is required for the uplink process.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1NjA5MTY0NDAsMTA1MzYyMzczNF19
-->
# ST Microelectronics Nucleo F401RE

The STM32 Nucleo device provides an affordable and flexible way for users to try out new ideas and build prototypes with [STM32 microcontrollers](http://www.st.com/web/en/catalog/mmc/FM141/SC1169?sc=stm32).

The Arduino connectivity support and ST Morpho headers make it easy to expand the functionality of the STM32 Nucleo device with a wide choice of specialized shields and sensors. This device does not require any separate probe as it integrates the ST-LINK/V2-1 debugger/programmer.

<p style="text-align:center;"><img src="https://github.com/zerynth/docs/blob/test/docs/reference/boards/st_nucleof401re/docs/img/StNucleo.jpg?raw=true"></p>

!!! important
    ST Nucleo uploader requires a firmware upgrade to properly work with Zerynth and with other serial terminal. ST-Link firmware can be upgraded following the [ST official procedure](https://os.mbed.com/teams/ST/wiki/Nucleo-Firmware).

!!! warning
	Unlike other Arduino-like devices, the ST Nucleo device runs at 3.3V. The maximum voltage that the I/O pins can tolerate is 3.3V. Providing higher voltages, like 5V to an I/O pin, could damage the device.

!!! note
	All the reported information are extracted from the official [ST Nucelo F401RE reference page](http://www.st.com/web/catalog/tools/FM116/SC959/SS1532/LN1847/PF260000?icmp=nucleo-ipf_pron_pr-nucleo_feb2014&sc=nucleoF401RE-pr), visit this page for more details and updates.

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/st_nucleof401re/docs/img/ST_nucleof401re_pin_io.jpg?raw=true)

ST Nucleo Official Schematic, Reference Design and Pin Mapping are available on the official [ST Nucelo F401RE datasheet page](http://www.st.com/content/ccc/resource/technical/document/data_brief/c8/3c/30/f7/d6/08/4a/26/DM00105918.pdf/files/DM00105918.pdf/jcr:content/translations/en.DM00105918.pdf)

## Flash Layout

The internal flash of the ST Nucleo F401RE is organized into sectors of different size according to the following table:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x8000000     | 16Kb  | Virtual Machine |
| 0x8004000     | 16Kb  | Virtual Machine |
| 0x8008000     | 16Kb  | Virtual Machine |
| 0x800C000     | 16Kb  | Virtual Machine |
| 0x8010000     | 64Kb  | Virtual Machine |
| 0x8020000     | 128kb | Bytecode Bank 0 |
| 0x8040000     | 128kb | Bytecode Bank 1 |
| 0x8060000     | 128kb | Bytecode Bank 2 |

!!! warning
	If internal flash is used in a Zerynth program, it is suggested to begin using pages from the end of flash (bytecode bank 2) towards the virtual machine, to minimize the chance of clashes.
    Since writing to a sector entails erasing it first, the write operation can be slow even for small chunks of data, depending on the size of the choosen sector.

## Device Summary


* Microcontroller: STM32F401RET6 ARM®32-bit Cortex®-M4 CPU
* Operating Voltage: 3.3V
* Input Voltage: 7-12V
* Digital I/O Pins (DIO): 50
* Analog Input Pins (ADC): 16
* Analog Outputs Pins (DAC): 0
* UARTs: 3
* SPIs: 3
* I2Cs: 3
* CANs: 0
* Flash Memory: 512 KB
* SRAM: 96 KB
* Clock Speed: 84 MHz
* Size (LxW mm):82.5 x 70.0

## Power

On the ST Nucleo the power supply is provided either by the host PC through the USB cable, or by an external Source: VIN (7V-12V), E5V (5V) or +3V3 power supply pins on CN6 or CN7. In case VIN, E5V or +3V3 is used to power the Nucleo device, using an external power supply unit or an auxiliary equipment, this power source must comply with the standard EN-60950-1: 2006+A11/2009, and must be Safety Extra Low Voltage (SELV) with limited power capability.

The ST-LINK/V2-1 supports USB power management allowing to request more than 100 mA current to the host PC. All parts of the STM32 Nucleo device and shield can be powered from the ST-LINK USB connector CN1 (U5V or VBUS).

!!! note
	During the USB enumeration, the STM32 Nucleo device requires 300 mA of current to the Host PC. If the host is able to provide the required power, the targeted STM32 microcontroller is powered and the red LED 3 is turned ON, thus the STM32 Nucleo device and its shield can consume a maximum of 300 mA current, not more.

!!! warning
	When the device is power supplied by USB (U5V) a jumper must be connected between pin 1 and pin 2 of JP5. The jumper must be connected between pin 2 and pin 3 if external power sources are used.

## Connect, Register, Virtualize and Program

The ST Nucleo Programming port is connected to the ST-Link uploader creating a virtual COM port on a connected computer. To recognize the device, **Windows** machines requires drivers that can be downloaded from [the ST Nucleo download page](https://developer.mbed.org/teams/ST/wiki/ST-Link-Driver), while **MAC OSX** and **Linux** machines will recognize the device automatically.

The St-Link is also connected to the STM32 hardware UART0 also connected with pins RX0 and TX0 available on the Arduino headers.

Once connected on a USB port, if drivers have been correctly installed the ST Nucleo device is recognized by Zerynth Studio and listed in the **Device Management Toolbar**. The next steps are:

* **Select** the ST Nucleo on the **Device Management Toolbar**;
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process.

After virtualization, the ST Nucleo device is ready to be programmed and the  Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio and **reset** the device by pressing the Reset on-board button when asked.

!!! note
	If the reset is not performed within 5 seconds the upload procedure fails.

!!! warning
	Scripts uploading and serial console connection issues on St Nucleo devices have been reported. If the upload fails also with a correctly performed reset or if the device is not able to print on the console, disconnect the device from the USB port and plug it again on another USB socket.

If also this procedure fails, try to update the ST Nucleo firmware available at this [link](https://developer.mbed.org/teams/ST/wiki/Nucleo-Firmware)

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the ST Nucleo F401RE device is available for bytecode and VM.

Flash Layout is shown in table below:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x08000000    | 128Kb | VM Slot 0       |
| 0x08020000    | 128kb | Bytecode Slot 0 |
| 0x08040000    | 128kb | VM Slot 1       |
| 0x08060000    | 128kb | Bytecode Slot 1 |

!!! important
    FOTA Record (small segment of memory where the current and desired state of the firmware is store) for the ST Nucleo device is allocated in 16kb sector inside the VM Slot 0 at 0x08004000 address.

## Power Management and Secure Firmware

Power Management feature allows to optimize power consumption by putting the device in low consumption state.

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

Both these features are strongly platform dependent; more information at [Power Management - STM32F section](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_pwr.html#pwr-stm32f) and [Secure Firmware - STM32F section](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_sfw.html#sfw-stm32f).

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwMjQzMjI2MTFdfQ==
-->

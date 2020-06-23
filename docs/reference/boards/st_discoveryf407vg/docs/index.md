# ST Microelectronics Discovery F407VG

The [ST Discovery F407VG device](https://www.st.com/en/evaluation-tools/stm32f4discovery.html) leverages the capabilities of the STM32F407 high performance
microcontrollers, to allow users to easily develop applications.

It includes an ST-LINK embedded debug tool, one ST-MEMS digital accelerometer, a digital microphone, one audio DAC with integrated class D speaker driver, LEDs, push-buttons and an USB OTG micro-AB connector.

STM32F407xx family is based on the high-performance ARM®Cortex®-M4 32-bit RISC core.

The device needs a 5V power supply and features a [STM32F407VG MCU](https://www.st.com/content/st_com/en/products/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus/stm32-high-performance-mcus/stm32f4-series/stm32f407-417/stm32f407vg.html) running at 168 MHz with 192Kb of RAM, 1Mb of flash.

<p style="text-align:center;"><img src="https://github.com/zerynth/docs/blob/test/docs/reference/boards/st_discoveryf407vg/docs/img/st_discoveryf407vg.jpg?raw=true"></p>

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/st_discoveryf407vg/docs/img/st_discoveryf407vg_pin_io.jpg?raw=true)

ST Discovery F407VG official manual is available [here](https://www.st.com/content/ccc/resource/technical/document/user_manual/70/fe/4a/3f/e7/e1/4f/7d/DM00039084.pdf/files/DM00039084.pdf/jcr:content/translations/en.DM00039084.pdf)

## Flash Layout

The internal flash of the ST Discovery F407VG is organized into one bank of 1Mb with sectors of different size according to the following table:

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
| 0x8080000     | 128kb | Bytecode Bank 3 |
| 0x80A0000     | 128kb | Bytecode Bank 4 |
| 0x80C0000     | 128kb | Bytecode Bank 5 |
| 0x80E0000     | 128kb | Bytecode Bank 6 |

## Device Summary


* Microcontroller: ARM 32-bit Cortex™-M4 CPU Core


* Operating Voltage: 3.3V


* Input Voltage: 5V


* Digital I/O Pins (DIO): 80


* Analog Input Pins (ADC): 14


* UARTs: 7


* SPIs: 3


* I2Cs: 3


* Flash Memory: 1Mb


* SRAM: 128 KB + 64Kb CCM


* Clock Speed: 168MHz

## Power

The power supply is provided either by the host PC through the USB cable, or by an external 5V power supply.

The D1 and D2 diodes protect the 5V and 3V pins from external power supplies:


* 5V and 3V can be used as output power supplies when another application board is connected to pins P1 and P2; in this case, the 5V and 3V pins deliver a 5V or 3V power supply and power consumption must be lower than 100 mA.


* 5V can also be used as input power supplies e.g. when the USB connector is not connected to the PC. In this case, the STM32F4DISCOVERY board must be powered by a power supply unit or by auxiliary equipment complying with standard EN-60950-1: 2006+A11/2009, and must be Safety Extra Low Voltage (SELV) with limited power capability.

## Connect, Register, Virtualize and Program

The ST Discovery F407VG Programming port is connected to the ST-Link uploader creating a virtual COM port on a connected computer. To recognize the device, ```Windows``` machines requires drivers that can be downloaded from [the ST Nucleo download page](http://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-utilities/stsw-link009.html), while **MAC OSX** and ```Linux``` machines will recognize the device automatically.

The St-Link is also connected to the STM32 hardware UART0.

Once connected on a USB port, if drivers have been correctly installed the ST Discovery F407VG device is recognized by Zerynth Studio and listed in the **Device Management Toolbar**. The next steps are:


* ```Select``` the ST Discovery F407VG on the **Device Management Toolbar** (disambiguate if necessary);


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process

After virtualization, the ST Discovery F407VG device is ready to be programmed and the  Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “upload” button of Zerynth Studio and ```reset``` the device by pressing the Reset on-board button when asked.

!!! note
	If the reset is not performed within 5 seconds the upload procedure fails.

!!! warning
	Scripts uploading and serial console connection issues on St Discovery F407VG devices have been reported. If the upload fails also with a correctly performed reset or if the device is not able to print on the console, disconnect the device from the USB port and plug it again on another USB socket.

If also this procedure fails, try to update the ST Discovery firmware available at this [link](https://developer.mbed.org/teams/ST/wiki/Nucleo-Firmware)

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the ST Discovery F407VG device is available for bytecode and VM.

Flash Layout is shown in table below:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x08000000    | 128Kb | VM Slot 0       |
| 0x08020000    | 384kb | Bytecode Slot 0 |
| 0x08080000    | 128kb | VM Slot 1       |
| 0x080A0000    | 384kb | Bytecode Slot 1 |

## Power Management and Secure Firmware

Power Management feature allows to optimize power consumption by putting the device in low consumption state.

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

Both these features are strongly platform dependent; more information at Power Management - STM32F section and Secure Firmware - STM32F section.

## Missing features

Not all features have been included in the ST Discovery based VMs. In particular the following are missing but will be added in the near future:


* LIS302DL or LIS3DSH ST MEMS 3-axis accelerometer driver;


* MP45DT02 ST-MEMS audio sensor omni-directional digital microphone driver;


* CS43L22 audio DAC with integrated class D speaker driver;
<!--stackedit_data:
eyJoaXN0b3J5IjpbODIyMTk0NzYyLC0zODI0NDE3NTVdfQ==
-->
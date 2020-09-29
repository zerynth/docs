# MXChip IoT DevKit AZ3166

The MXChip IoT DevKit AZ3166 provides a smart hardware solution. It is compatible with several peripherals and sensors. AZ3166 could be used for the development of IoT and smart hardware prototype, making it continent to verify the software and function of users.

AZ3166 is [EMW3166](http://en.mxchip.com/product/wifi_product/40), a low power consumption Wi-Fi module developed by MXCHIP, With DAP Link emulator and 128×64 OLED and other resources such as LED light. The development kit has onboard a Temperature and Humidity sensor (HTS221), an Acceleromenter and Gyroscope sensor (LSM6DSL), an absolupe Pressure sensor (LPS22HB),  a Magnetometer sensor (LIS2MDL) and more.

EMW3166 integrates [STM32F412RG](http://www.st.com/resource/en/datasheet/stm32f412rg.pdf) (Cortex-M4) microcontroller of 256Kbytes SRAM and 1Mbytes on-chip flash with another 2Mbytes on-board SPI flash added. Various peripheral interfaces of analog and digital are available. The power supply voltage is 3.3V. The TCP/IP protocols and security encryption algorithm could be applied in various Wi-Fi applications. In addition, several particular firmware prepares for some typical applications easylink configuration and services for cloud interfacing.

<p style="text-align:center;"><img src="img/az3166.jpg"></p>

!!! note
	All the reported information are extracted from the official [MXChip IoT DevKit AZ3166 reference page](http://mxchip.com/az3166), visit this page for more details and updates.

## Pin Mapping

![](img/az3166_pin_io.jpg)

MXChip IoT DevKit AZ3166 Schematic are available on the official [MXChip official page](http://www.mxchip.com/public/microsoft/AZ3166-SCH.pdf).

## Flash Layout

The internal flash of the IoT DevKit AZ3166 is organized into sectors of different size according to the following table:

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

!!! warning
	If internal flash is used in a Zerynth program, it is suggested to begin using pages from the end of flash (bytecode bank 6) towards the virtual machine, to minimize the chance of clashes.

Since writing to a sector entails erasing it first, the write operation can be slow even for small chunks of data, depending on the size of the choosen sector.

## Device Summary

* Microcontroller: STM32F412RG ARM®32-bit Cortex®-M4 CPU
* Operating Voltage: 3.3V
* Input Voltage: 7-12V
* Digital I/O Pins (DIO): 31
* Analog Input Pins (ADC): 2
* UARTs: 2
* SPIs: 1
* I2Cs: 1
* Flash Memory: 1 MB
* SRAM: 256 KB
* Clock Speed: 100 MHz

## Power

Power to the MXChip IoT DevKit AZ3166 is supplied via the on-board USB Micro B connector.

The device can operate on an external supply voltage of 3.3 to 5.5 volts. If using more than 5.5V, the voltage regulator may overheat and damage the device.

## Connect, Register, Virtualize and Program

The IoT DevKit AZ3166 Programming port is connected to the ST-Link uploader creating a virtual COM port on a connected computer. To recognize the device, **Windows** machines requires drivers that can be downloaded from [the ST-Link download page](http://www.st.com/en/development-tools/stsw-link009.html), while **MAC OSX** and **Linux** machines will recognize the device automatically.

The St-Link is also connected to the STM32 hardware UART0.

Once connected on a USB port, if drivers have been correctly installed the IoT DevKit AZ3166 device is recognized by Zerynth Studio and listed in the **Device Management Toolbar**. The next steps are:

* **Select** the IoT DevKit AZ3166 on the **Device Management Toolbar** (disambiguate if necessary);
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process.

After virtualization, the IoT DevKit AZ3166 device is ready to be programmed and the  Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio and **reset** the device by pressing the Reset on-board button when asked.

!!! note
	If the reset is not performed within 5 seconds the upload procedure fails.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the IoT DevKit AZ3166 device is available for bytecode and VM.

Flash Layout is shown in table below:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x08000000    | 128Kb | VM Slot 0       |
| 0x08020000    | 384kb | Bytecode Slot 0 |
| 0x08080000    | 128kb | VM Slot 1       |
| 0x080A0000    | 384kb | Bytecode Slot 1 |

!!! important
    FOTA Record (small segment of memory where the current and desired state of the firmware is store) for the IoT DevKit AZ3166 device is allocated in 16kb sector inside the VM Slot 0 at 0x08004000 address.

## Power Management and Secure Firmware

Power Management feature allows to optimize power consumption by putting the device in low consumption state.

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

Both these features are strongly platform dependent; more information at [Power Management - STM32F section](/latest/reference/core/stdlib/docs/pwr/#power-management-for-stm32fxx-families) and [Secure Firmware - STM32F section](/latest/reference/core/stdlib/docs/sfw/#watchdogs-for-stm32fxx-families).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTk3OTEyMTgwN119
-->
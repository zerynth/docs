# Hexiwear

Hexiwear platform combines the style and usability found in high-end consumer devices, with the functionality and expandability of sophisticated engineering development platforms, making Hexiwear the ideal form factor for the IoT edge node and wearable markets.

Completely open-source and developed by MikroElektronika in partnership with NXP; the Hexiwear hardware includes the low power, high performance Kinetis K6x Microcontroller based on ARM Cortex-M4 core, the Kinetis KW40Z multimode radio SoC, supporting BLE in Hexiwear.

The Hardware features included 6 on-board sensors such as Optical Heart Rate Monitor, Accelerometer and Magnetometer, Gyroscope, Temperature, Humidity, light and Pressure sensors. Hexiwear also includes Color OLED Display, Rechargeable battery and External flash memory.

For this device, a docking station is also available; The Hexiwear Docking Station is an expansion board for Hexiwear that provides an interface for programming, debugging, and enhancing Hexiwear with additional functionalities by adding click boards.

!!! note
	All the reported information are extracted from the official [Hexiwear page](http://www.hexiwear.com/), visit this page for more details and updates.

## Pin Mapping

## Flash Layout

The Hexiwear device features a 1 MB flash memory organized in 2 blocks (512 KB each) consisting of 4 KB sectors. The flash memory address starts at 0x00000000 and can be read and written from a Zerynth program using the internal flash module.

!!! warning
	If flash memory must be used in a Zerynth program, it is recommended to begin using it from secure addresses towards the end the bytecode (start address of the bytecode can be found in the log console of Zerynth Studio during the ```uplink``` operation), leaving a minimum safe place to minimize the chance of clashes.

## Device Summary


* Microcontroller: NXP Kinetis K64F MCU


* Operating Voltage: 3.3V


* Digital I/O Pins (DIO): 76


* Analog Input Pins (ADC): 8


* UARTs: 6


* SPIs: 3


* I2Cs: 3


* Flash Memory: 1 MB


* SRAM: 256 KB


* Clock Speed: 120 MHz

## Power

The Hexiwear provides an on-board 5 to 3.3 V regulator and can be powered in three different ways:


* Throught an Embedded 19 mAh 2C Li-Po battery;


* Throught the USB Micro B connector on Hexiwear Docking Station (charging on-board battery features enabled);


* Throught the USB Micro B connector on Hexiwear (charging on-board battery features enabled);

## Connect, Virtualize and Program

The Hexiwear Docking Station has an on-board DAP Link circuitry that exposes three USB interfaces:


* A serial port over USB


* A mass storage device for drag-n-drop programming flash memory


* A DAP compliant debug channel

DAP Link should be supported natively by all platforms.
Once connected to a USB port, the Hexiwear Device is recognized by Zerynth Studio. The device can be virtualized by clicking the related Studio button without requiring any other user intervention.

!!! note
	Register, Virtualize and Program operations for Hexiwear are available only connecting the device on its Docking Station.

Once connected to a USB port the Hexiwear device can be seen as a Virtual Serial port and it is automatically recognized by Zerynth Studio. The next steps are:


* ```Select``` the Hexiwear on the **Device Management Toolbar** (Disambiguate operation may be required);


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

!!! note
	No user intervention on the device is required for registration and virtualization process

After virtualization, the device is ready to be programmed and the Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar”, ```click``` the dedicated “upload” button of Zerynth Studio and ```reset``` the device by pressing the Reset button on Hexiwear Docking Station when asked.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Hexiwear device is available for bytecode only.

Flash Layout is shown in table below:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x00000000    | 96Kb  | VM Slot         |
| 0x00018000    | 452Kb | Bytecode Slot 0 |
| 0x00089000    | 472Kb | Bytecode Slot 1 |
| 0x000FF000    | 4Kb   | FOTA Record     |

## Power Management and Secure Firmware

Power Management feature allows to optimize power consumption by putting the device in low consumption state.

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

Both these features are strongly platform dependent; more information at Power Management - NXP K64 section and Secure Firmware - NXP K64 section.
<!--stackedit_data:
eyJoaXN0b3J5IjpbNDE3ODQzMzAwXX0=
-->

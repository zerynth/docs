# Particle Electron

The Particle Electron is a GSM enabled development platform for creating connected devices with M2M in mind.
Particle Electron combines a powerful ARM Cortex M3 micro-controller with a 3G/2G gsm module from UBlox (U260 or G350).
Particle Electron uses the [STM32F205RG Cortex M3 microcontroller](http://www.st.com/content/ccc/resource/technical/document/datasheet/bc/21/42/43/b0/f3/4d/d3/CD00237391.pdf/files/CD00237391.pdf/jcr:content/translations/en.CD00237391.pdf).


<p style="text-align:center;"><img src="img/ParticleElectron.jpg"></p>

In addition to having 1Mb of internal flash memory for storing the firmware, the Electron also features 128k of Ram and 120 MHz of clock.

!!! note
	All the reported information are extracted from the official [Particle Electron reference page](http://docs.particle.io/electron/), visit this page for more details and updates.

## Pin Mapping

![](img/ParticleElectronPin.png)

Particle Electron Official Schematic, Reference Design & Pin Mapping are available on the [official Particle Electron datasheet page](https://docs.particle.io/datasheets/electron-datasheet/).

## Flash Layout

The internal flash of the Particle Electron is organized into sectors of different size according to the following table:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x8000000     | 16Kb  | BootLoader      |
| 0x8004000     | 16Kb  | DCT1            |
| 0x8008000     | 16Kb  | DCT2            |
| 0x800C000     | 16Kb  | EEPROM1         |
| 0x8010000     | 64Kb  | EEPROM2         |
| 0x8020000     | 128kb | Virtual Machine |
| 0x8040000     | 128kb | Bytecode Bank 0 |
| 0x8060000     | 128kb | Bytecode Bank 1 |
| 0x8080000     | 128kb | Bytecode Bank 2 |
| 0x80A0000     | 128kb | Bytecode Bank 3 |
| 0x80C0000     | 128kb | Bytecode Bank 4 |
| 0x80E0000     | 128kb | Bytecode Bank 5 |

!!! important
    To avoid deleting the Electron configuration it is suggested to not write to sectors between 0x8004000 and 0x8020000.

!!! warning
	If internal flash is used in a Zerynth program, it is recommended to start from pages at the end of flash (bytecode bank 5) towards the virtual machine, to minimize the chance of clashes. Since writing to a sector entails erasing it first, the write operation can be slow even for small chunks of data, depending on the size of the choosen sector.

## Device Summary


* Microcontroller: ARM 32-bit Cortex™-M3 CPU Core
* Operating Voltage: 3.3V
* Input Voltage: 3.6-6V
* Digital I/O Pins (DIO): 28
* Analog Input Pins (ADC): 14
* Analog Outputs Pins (DAC): 1
* UARTs: 5
* SPIs: 2
* I2Cs: 1
* CANs: 1
* Flash Memory: 1Mb
* SRAM: 128 KB
* Clock Speed: 120Mhz

## Power

The Electron is equipped with on device power management circuit powered by BQ24195 pm unit and MAX17043 fuel gauge. The Electron can be powered via the VIN (3.9V-12VDC) pin, the USB Micro B connector or a LiPo battery.

When powered from a LiPo battery alone, the power management IC switches off the internal regulator and supplies power to the system directly from the battery.

## Connect, Register, Virtualize and Program

On **Windows** machines the [Particle Electron USB Drivers](https://docs.particle.io/guide/getting-started/connect/electron/#installing-the-particle-driver) are required by the Zerynth Studio for accessing the serial port establishing a connection with the STM32 UART.

To install the drivers on **Windows** plug the Electron on an USB port, unzip the downloaded package, go to the **Windows Device Manager** and double-click on the Particle device under “Other Devices”. Click Update Driver, and select Browse for driver software on your computer. Navigate to the folder where the package has been unzipped and select it (Note that right now, the drivers are in a Spark folder and are named photon.cat).

!!! note
	It could be necessary to temporarily disable the digitally signed driver enforcement policy of Windows to allow Electron driver installation. There are good instructions on how to do that in [this guide](http://www.howtogeek.com/167723/how-to-disable-driver-signature-verification-on-64-bit-windows-8.1-so-that-you-can-install-unsigned-drivers/).

On **MAC OSX** and **Linux** USB drivers are not required.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access: **Ubuntu** distribution –> dialout group; **Arch Linux** distribution –> uucp group.

    If the device is still not recognized or not working, the following udev rules may need to be added:

    ```bash
    #Particle Electron
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2b04", ATTRS{idProduct}=="d00a", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEMS=="tty", ATTRS{idVendor}=="2b04", ATTRS{idProduct}=="d00a", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2b04", ATTRS{idProduct}=="c00a", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
    SUBSYSTEMS=="tty", ATTRS{idVendor}=="2b04", ATTRS{idProduct}=="c00a", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
    ```

Once connected on a USB port, if drivers have been correctly installed, the Electron can be seen as Virtual Serial port and it is automatically recognized by the Zerynth Studio and listed in the **Device Management Toolbar** as “Particle Electron DFU Mode” if the device is in DFU Mode, otherwise as “Particle Electron”.

To register and virtualize an Electron, it is necessary to put the Electron in DFU Mode (Device Firmware Upgrade) as reported in the official [Particle Electron Guide](http://docs.particle.io/electron).

!!! note
	On **Windows** machines it is necessary to install also the Particle Electron DFU drivers for virtualizing the device.

The official **Particle Core** DFU driver and the related installation procedure are reported [here](https://community.particle.io/t/tutorial-installing-dfu-driver-on-windows-24-feb-2015/3518) but they also work for the **Particle Electron**.

Follow these steps to register and virtualize a Particle Electron:


* **Put** the Electron in **DFU Mode** (Device Firmware Upgrade):
    * Hold down BOTH buttons (reset and setup);
    * Release only the reset button, while holding down the setup button;
    * Wait for the LED to start flashing flashing magenta, then yellow;
    * Release the setup button; the device is now in DFU Mode (yellow blinking led);
* **Select** the Electron on the **Device Management Toolbar**;
* **Register** the device by clicking the “Z” button from the Zerynth Studio;
* **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
* **Virtualize** the device by clicking the “Z” button for the third time.

!!! note
	During these operations the Electron device must be in **DFU Mode**. if the device returns in standard mode, it is necessary to put it in DFU Mode again.

After virtualization, the Particle Electron is ready to be programmed and the  Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio and **reset** the device by pressing the Reset on-board button when asked.

!!! important
    To exploit the GSM/GPRS chip functionalities of the Particle Electron, the [lib.ublox.g350 library](/latest/reference/libs/ublox/g350/docs/) must be installed (some example code is provided).

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the Particle Electron device is available for bytecode and VM.

Flash Layout is shown in table below:

| Start address | Size  | Content         |
|---------------|-------|-----------------|
| 0x08020000    | 128Kb | VM Slot 0       |
| 0x08040000    | 384kb | Bytecode Slot 0 |
| 0x080A0000    | 128kb | VM Slot 1       |
| 0x080C0000    | 256kb | Bytecode Slot 1 |

!!! important
    FOTA Record (small segment of memory where the current and desired state of the firmware is store) for the Particle Electron device is allocated in 16kb DCT1 (see Flash Layout) sector at 0x08006000 address.

## Power Management and Secure Firmware

Power Management feature allows to optimize power consumption by putting the device in low consumption state.

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

Both these features are strongly platform dependent; more information at [Power Management - STM32F](/latest/reference/core/stdlib/docs/pwr/#power-management-for-stm32fxx-families) section and [Secure Firmware - STM32F section](/latest/reference/core/stdlib/docs/sfw/#watchdogs-for-stm32fxx-families).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIwOTM4Mzk0OV19
-->
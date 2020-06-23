# Particle Core (Formerly Spark Core)

The Particle Core is a complete Wi-Fi enabled development platform for creating connected devices with ease. The Particle Core is small, low power, and does all the heavy WiFi lifting.
Particle Core v1.0 uses the [STM32F103CB Cortex M3 microcontroller](http://www.st.com/content/ccc/resource/technical/document/datasheet/33/d4/6f/1d/df/0b/4c/6d/CD00161566.pdf/files/CD00161566.pdf/jcr:content/translations/en.CD00161566.pdf).

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/particle_core/docs/img/ParticleCore.jpg?raw=true)

In addition to having 128KB of internal flash memory for storing the firmware, the Core also features an external SPI based flash memory chip - SST25VF016B.

This memory space (a total of 2MB) is used to store the factory reset firmware and a back up firmware. Part of the space is also available to the user who can use it to store log data, user parameters, etc.

!!! note
	All the reported information are extracted from the official [Particle Core reference page](http://docs.particle.io/core/), visit this page for more details and updates.

## Pin Mapping

![](https://github.com/zerynth/docs/blob/test/docs/reference/boards/particle_core/docs/img/Particle_core_pin_io.png?raw=true)

Particle Core Official Schematic, Reference Design & Pin Mapping are available on the [official Particle Core datasheet page](https://docs.particle.io/datasheets/core-datasheet/).

## Flash Layout

The internal flash of the Particle Core is organized into 128 pages of 1k each starting from address 0x08000000 up to 0x8020000. The memory below 0x08005000 is reserved for Particle bootloader. The Virtual Machine starts at 0x08005000.
The bytecode is stored in a variable position depending on the VM size.

!!! note
	The start address is shown during the uplinking operation in the log console of Zerynth Studio (romstart symbol).

## Device Summary


* Microcontroller: ARM 32-bit Cortex™-M3 CPU Core


* Operating Voltage: 3.3V


* Input Voltage: 3.6-6V


* Digital I/O Pins (DIO): 18


* Analog Input Pins (ADC): 8


* Analog Outputs Pins (DAC): 0


* UARTs: 1


* SPIs: 1


* I2Cs: 1


* CANs: 0


* Flash Memory: 128KB


* SRAM: 20 KB


* Clock Speed: 72Mhz


* Size (LxW mm): 37.33 X 20.32

## Power

The entire Particle Core, including all of the on device peripherals, runs at 3.3V DC. The Particle Core has internal voltage regulator that allows powering the device from the USB port or through an external power supply that can range from 3.6V to 6.0V DC. Ideal sources of power can be: 3.6V LiPo battery, 4AA battery pack, backup USB battery or an USB wall charger.

## Connect, Register, Virtualize and Program

On ```Windows``` machines the [Particle Core USB Drivers](https://s3.amazonaws.com/spark-website/Spark.zip) are required by the Zerynth Studio for accessing the Core serial port establishing a connection with the STM32 UART.

To install the drivers on ```Windows``` plug the Core on an USB port, unzip the downloaded package, go to the **Windows Device Manager** and double-click on the Particle device under “Other Devices”. Click Update Driver, and select Browse for driver software on your computer. Navigate to the folder where the package has been unzipped and select it (Note that right now, the drivers are in a Spark folder and are named spark_core).

!!! note
	It could be necessary to temporarily disable the digitally signed driver enforcement policy of Windows to allow Core driver installation. There are good instructions on how to do that in [this guide](http://www.howtogeek.com/167723/how-to-disable-driver-signature-verification-on-64-bit-windows-8.1-so-that-you-can-install-unsigned-drivers/).

On **MAC OSX** and ```Linux``` USB drivers are not required.

!!! note
	**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access: **Ubuntu** distribution –> dialout group; **Arch Linux** distribution –> uucp group

If the device is still not recognized or not working, the following udev rules may need to be added:

```
#Particle Core
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="607f", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEMS=="tty", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="607f", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="607d", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEMS=="tty", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="607d", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
```

Once connected on a USB port, if drivers have been correctly installed, the Core can be seen as Virtual Serial port and it is automatically recognized by the Zerynth Studio and listed in the **Device Management Toolbar** as “Particle Core DFU Mode” if the device is in DFU Mode, otherwise as “Particle Core”.

To register and virtualize the Core, it is necessary to put the Core in DFU Mode (Device Firmware Upgrade) as reported in the official [Particle Core Guide](http://docs.particle.io/core/modes/).

!!! note
	On ```Windows``` machines it is necessary to install also the Particle Core DFU drivers for virtualizing the device.

The official Particle Core DFU driver and the related installation procedure are reported [here](https://community.particle.io/t/tutorial-installing-dfu-driver-on-windows-24-feb-2015/3518).

Follow these steps to register and virtualize a Particle Core:


* ```Put``` the Core in **DFU Mode** (Device Firmware Upgrade):


    * Hold down BOTH buttons (reset and mode);


    * Release only the reset button, while holding down the mode button;


    * Wait for the LED to start flashing yellow;


    * Release the mode button; the device is now in DFU Mode (yellow blinking led);


* ```Select``` the Core on the **Device Management Toolbar**;


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

!!! note
	During these operations the Core device must be in **DFU Mode**. If the device returns in standard mode, it is necessary to put it in DFU Mode again

!!! warning
	Depending on the Particle Core bootloader version, it may be necessary to virtualize it twice. If after the first virtualization, the Particle Core starts blinking red (factory reset mode), wait for the factory reset to finish and repeat the operation sequence.

After virtualization, the Particle Core is ready to be programmed and the  Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “upload” button of Zerynth Studio and ```reset``` the device by pressing the Reset on-board button when asked.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTg1MjY3NjI5MiwtMTMzMTIzNDE5NV19
-->
# SODAQ ExpLoRer

The ExpLoRer is a development/evaluation tool based on the Atmel [SAMD21J18A ARM Cortex-M0+ CPU](https://cdn.sparkfun.com/datasheets/Dev/Arduino/Boards/Atmel-42181-SAM-D21_Datasheet.pdf). intended for the evaluation of Microchip wireless modules in a Research and Development laboratory environment. It is not a Finished Appliance. Manufacturers who integrate ExpLoRer in a Finished Appliance product must take responsibility to follow regulatory guidelines, for example for CE marking.

```NOTE```: All the reported information are extracted from the official [SODAQ ExpLoRer page](https://support.sodaq.com/Boards/ExpLoRer/) , visit this page for more details and updates.

## Pin Mapping

SODAQ ExpLoRer Official Schematic, Reference Design and Pin Mapping are available on the official [SODAQ ExpLoRer page](https://support.sodaq.com/sodaq-one/explorer).

## Flash Layout

The internal flash of the SODAQ ExpLoRer is organized as a single bank of 256k.

## Device Summary


* Microcontroller: SAMD21 Cortex-M0+ 32bit low power ARM MCU


* Operating Voltage: 3.3V


* I/O Pins: 20


* Analog Output Pin: 10-bit DAC


* DC Current per I/O pin: 7 mA


* LoRa: Microchip RN2483 module


* Bluetooth: Microchip RN4871 Module


* Cyptochip: ATECC508A


* Temperature sensor: MCP9700AT


* SPIs: 1


* I2Cs: 2


* UARTs: 1


* Flash Memory: 256 KB and 4 MB (External Flash)


* SRAM: 32 KB


* Clock Speed: 48 MHz

## Power

The SODAQ ExpLoRer can be powered via the USB connector or with a coin cell battery of 3.6V.

The ExpLoRer can run on a battery. By default the ExpLoRer is delivered with a coincell battery.
To charge the battery you need to connect an usb and/or solar panel.

The ExpLoRer can only run on one battery at the same time, move the jumper to connect the internal (coincell) or external battery. It will only charge the battery connected with this jumper.

Connect any 3.3v – 5.2v power to the solar connector, this source will charge to battery.

```NOTE```: Do not short circuit the Li-Ion coin cell or any of the pins of the ExpLoRer because of risk of heat, smoke, and fire.

## Connect, Register, Virtualize and Program

To recognize the device, all ```Windows``` (automatic driver software installation), ```OSX``` and ```Linux``` machines will recognize the device as a COM port automatically.

```NOTE```: **For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access:


* ```Ubuntu``` distribution –> dialout group


* **Arch Linux** distribution –> uucp group

If the device is still not recognized or not working, the following udev rules may need to be added:

```
# Check SUBSYSTEM
SUBSYSTEMS=="hidraw", KERNEL=="hidraw*", MODE="0666", GROUP="dialout"

# SODAQ ExpLoRer Device
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="824e", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEMS=="tty", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="824e", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
```

Once connected on a USB port the SODAQ ExpLoRer device is recognized by Zerynth Studio. The next steps are:


* ```Put``` the SODAQ ExpLoRer in **Virtualization Mode**;

    
        * Double click on the RST button;


* ```Select``` the SODAQ ExpLoRer Virtualizable on the **Device Management Toolbar**;


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

```NOTE```: During these operations the MKR1000 device must be in Virtualization Mode. if the device returns in standard mode, it is necessary to put it in DFU Mode again

After virtualization, the SODAQ ExpLoRer is ready to be programmed and the Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “upload” button of Zerynth Studio and ```reset``` the device by pressing the Reset on-board button when asked.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the SODAQ ExpLoRer device is available for bytecode only.

Flash Layout is shown in table below:

| Start address

 | Size

 | Content

 |
| ------------- | ---- | ------- |
| 0x00002000

    | 94Kb

 | VM Slot

 |
| 0x00019600

    | 77Kb

 | Bytecode Slot 0

 |
| 0x0002CB00

    | 77Kb

 | Bytecode Slot 1

 |
## Power Management and Secure Firmware

Power Management feature allows to optimize power consumption by putting the device in low consumption state.

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

Both these features are strongly platform dependent; more information at Power Management - Microchip SAMD21 section and Secure Firmware - Microchip SAMD21 section.

## Missing features

Not all features have been included in the SODAQ ExpLoRer support. In particular the following are missing:


* Bluetooth support;

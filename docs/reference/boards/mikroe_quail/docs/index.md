# MikroElektronika Quail

The Quail device is an STM32-powered development solution for building hardware prototypes with [MikroElektronika Click Boards](https://shop.mikroe.com/click).

Hardware-wise, Quail has 4 mikroBUS sockets for click board connectivity, along with 24 screw terminals for connecting additional electronics and two USB ports (one for programming, the other for external mass storage).

The device needs a 5V power supply and features a [STM32F427 MCU](http://www.st.com/content/ccc/resource/technical/document/datasheet/03/b4/b2/36/4c/72/49/29/DM00071990.pdf/files/DM00071990.pdf/jcr:content/translations/en.DM00071990.pdf) running at 168MHz with 192Kb of RAM, 2Mb of flash and additional 8Mb of spi flash.

!!! note
	Quail is produced by [MikroElektronika](http://www.mikroe.com/quail/), but the idea and design of the device was done by [MikroBUS.NET](https://mikrobusnet.org), a team of software and hardware professionals from France

## Pin Mapping

MikroElektronika Quail official manual is available [here](http://download.mikroe.com/documents/starter-boards/other/quail/quail-board-manual-v100.pdf)

## Flash Layout

The internal flash of the MikroElektronika Quail is organized into two banks of 1Mb each. Each bank has sectors of different size according to the following table:

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky" colspan="3">Bank 1</th>
    <th class="tg-0pky" colspan="3">Bank 2</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky">Start address</td>
    <td class="tg-0pky">Size</td>
    <td class="tg-0pky">Content</td>
    <td class="tg-0pky">Start address</td>
    <td class="tg-0pky">Size</td>
    <td class="tg-0pky">Content</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x8000000</td>
    <td class="tg-0pky">16Kb</td>
    <td class="tg-0pky">Virtual Machine</td>
    <td class="tg-0pky">0x8100000</td>
    <td class="tg-0pky">16Kb</td>
    <td class="tg-0pky">Bytecode Bank 7</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x8004000</td>
    <td class="tg-0pky">16Kb</td>
    <td class="tg-0pky">Virtual Machine</td>
    <td class="tg-0pky">0x8104000</td>
    <td class="tg-0pky">16Kb</td>
    <td class="tg-0pky">Bytecode Bank 8</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x8008000</td>
    <td class="tg-0pky">16Kb</td>
    <td class="tg-0pky">Virtual Machine</td>
    <td class="tg-0pky">0x8108000</td>
    <td class="tg-0pky">16Kb</td>
    <td class="tg-0pky">Bytecode Bank 9</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x800C000</td>
    <td class="tg-0pky">16Kb</td>
    <td class="tg-0pky">Virtual Machine</td>
    <td class="tg-0pky">0x810C000</td>
    <td class="tg-0pky">16Kb</td>
    <td class="tg-0pky">Bytecode Bank 10</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x8010000</td>
    <td class="tg-0pky">64Kb</td>
    <td class="tg-0pky">Virtual Machine</td>
    <td class="tg-0pky">0x8110000</td>
    <td class="tg-0pky">64Kb</td>
    <td class="tg-0pky">Bytecode Bank 11</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x8020000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 0</td>
    <td class="tg-0pky">0x8120000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 12</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x8040000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 1</td>
    <td class="tg-0pky">0x8140000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 13</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x8060000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 2</td>
    <td class="tg-0pky">0x8160000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 14</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x8080000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 3</td>
    <td class="tg-0pky">0x8180000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 15</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x80A0000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 4</td>
    <td class="tg-0pky">0x81A0000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 16</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x80C0000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 5</td>
    <td class="tg-0pky">0x81C0000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 17</td>
  </tr>
  <tr>
    <td class="tg-0pky">0x80E0000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 6</td>
    <td class="tg-0pky">0x81E0000</td>
    <td class="tg-0pky">128kb</td>
    <td class="tg-0pky">Bytecode Bank 18</td>
  </tr>
</tbody>
</table>

## Device Summary


* Microcontroller: ARM 32-bit Cortex™-M4 CPU Core


* Operating Voltage: 3.3V


* Input Voltage: 7-12V


* Digital I/O Pins (DIO): 66


* Analog Input Pins (ADC): 10


* UARTs: 5


* SPIs: 2


* I2Cs: 2


* Flash Memory: 2Mb


* SRAM: 192 KB + 64Kb CCM


* Clock Speed: 168Mhz


* Size (LxW mm): 97 x 72

## Power

The MikroElektronika Quail can be powered via the on-board USB Mini-B connector or with an external power supply. The power source is selected automatically.
External (non-USB) power can be inserted in the “Gnd” and “+20v” pin terminals of the device.

The device can operate on an external supply of 6 to 20 volts.
If supplied with less than 7V, however, the 5V pin may supply less than five volts and the device may be unstable. If more than 12V are used, the voltage regulator may overheat and damage the device. The recommended range is 7 to 12 volts.

## Connect, Register, Virtualize and Program

On ```Windows``` machines two set of drivers must be installed: the DFU drivers and the USB serial drivers. This can be done by using the [Zadig utility](http://zadig.akeo.ie/) version 2.2 or greater. Use the Zadig utility once with the Quail in DFU mode (see below) and once after the device has been virtualized.

!!! note
	Remember to select “Options > List all devices” to search for the Quail device.


* In DFU mode, the VID:PID you should see is 0483:DF11 and the Quail si recognized as “STM32 BOOTLOADER”.


* For the virtualized Quail the VID:PID is 0483:DF12.

!!! warningIn DFU mode any driver is ok, except Usb CDC; for the virtualized Quail the only valid driver is Usb CDC.

```NOTE```: It could be necessary to temporarily disable the digitally signed driver enforcement policy of Windows to allow the driver installation. There are good instructions on how to do that in [this guide](http://www.howtogeek.com/167723/how-to-disable-driver-signature-verification-on-64-bit-windows-8.1-so-that-you-can-install-unsigned-drivers/).

On **MAC OSX** and ```Linux``` USB drivers are not required.

```NOTE```: **For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access:


* ```Ubuntu``` distribution –> dialout group


* **Arch Linux** distribution –> uucp group

If the device is still not recognized or not working, the following udev rules may need to be added:

```
#MikroElektronica Quail Device
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEMS=="tty", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df12", MODE="0666", GROUP="users", ENV{ID_MM_DEVICE_IGNORE}="1"
```

Once connected to a USB port the Quail device can be seen as a Virtual Serial port or as a DFU device depending on its virtualized/virtualizable status and it is automatically recognized by Zerynth Studio. The next steps are:


* ```Put``` the Quail in **DFU Mode** (Device Firmware Upgrade):


    * Hold down BOTH on-board buttons (reset and boot);


    * Release only the reset button, while holding down the boot button;


    * After a second, release the boot button; the Quail is now in DFU mode;


* ```Select``` the Quail on the **Device Management Toolbar**;


* ```Register``` the device by clicking the “Z” button from the Zerynth Studio;


* ```Create``` a Virtual Machine for the device by clicking the “Z” button for the second time;


* ```Virtualize``` the device by clicking the “Z” button for the third time.

```NOTE```: During these operations the Quail device must be in ```DFU``` mode. if the device returns in standard mode, it is necessary to put it in DFU Mode again

After virtualization, the MikroElektronika Quail is ready to be programmed and the  Zerynth scripts ```uploaded```. Just ```Select``` the virtualized device from the “Device Management Toolbar” and ```click``` the dedicated “upload” button of Zerynth Studio and ```reset``` the device by pressing the Reset on-board button when asked.

## Firmware Over the Air update (FOTA)

The Firmware Over the Air feature allows to update the device firmware at runtime. Zerynth FOTA in the MikroElektronika Quail device is available for bytecode and VM.

Flash Layout is shown in table below:

| Start address

 | Size

   | Content

         |
| ------------- | ------ | --------------- |
| 0x08000000

    | 128Kb

  | VM Slot 0

       |
| 0x08020000

    | 384kb

  | Bytecode Slot 0

 |
| 0x08080000

    | 128kb

  | VM Slot 1

       |
| 0x080A0000

    | 384kb

  | Bytecode Slot 1

 |
## Power Management and Secure Firmware

Power Management feature allows to optimize power consumption by putting the device in low consumption state.

Secure Firmware feature allows to detect and recover from malfunctions and, when supported, to protect the running firmware (e.g. disabling the external access to flash or assigning protected RAM memory to critical parts of the system).

Both these features are strongly platform dependent; more information at Power Management - STM32F section and Secure Firmware - STM32F section.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTQxMTQ5OTE1LC0xODYzMjE5MDcxLDE1Nz
AwNDM5NDksLTEyNzk2MjEwMjIsMTEwMTA2MjYzNl19
-->
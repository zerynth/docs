## 4ZeroBox device

A machine-to-cloud interface that can be plugged into old and modern industrial machines.

<p align="center"
><img src="https://github.com/zerynth/testdoc/blob/vojislavgvozdic-patch-1/docs/images/4zerobox-400x339.png?raw=true"></p>

### Pin mapping
![enter image description here](https://github.com/zerynth/testdoc/blob/vojislavgvozdic-patch-1/docs/images/4zerobox_Pinmap.jpg?raw=true)

### Interrupts

It’s possible to use interrupts to register callback functions to be called when a certain pin change status from HIGH to LOW (pin _fall_) or from LOW to HIGH (pin _rise_).

Pins that can be used in this way are D16 (MikroBUS Slot1), D34 and D39 (MikroBUS Slot1 or J4). Refer to the [official Zerynth example](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/examples/examples.html#core-zerynth-stdlib-interrupts) to learn how to use them.

### Flash Layout

The internal flash of the ESP32 module is organized in a single flash area with pages of 4096 bytes each. The flash starts at address 0x00000, but many areas are reserved for Esp32 IDF SDK and Zerynth VM. There exist two different layouts based on the presence of BLE support.

In particular, for non-BLE VMs:

| Start address | Size  | Content                 |
|---------------|-------|-------------------------|
| 0x00009000    | 16Kb  | Esp32 NVS area          |
| 0x0000D000    | 8Kb   | Esp32 OTA data          |
| 0x0000F000    | 4Kb   | Esp32 PHY data          |
| 0x00010000    | 1Mb   | Zerynth VM              |
| 0x00110000    | 1Mb   | Zerynth VM (FOTA)       |
| 0x00210000    | 512Kb | Zerynth Bytecode        |
| 0x00290000    | 512Kb | Zerynth Bytecode (FOTA) |
| 0x00310000    | 512Kb | Free for user storage   |
| 0x00390000    | 448Kb | Reserved                |

For BLE VMs:

| Start address | Size   | Content                 |
|---------------|--------|-------------------------|
| 0x00009000    | 16Kb   | Esp32 NVS area          |
| 0x0000D000    | 8Kb    | Esp32 OTA data          |
| 0x0000F000    | 4Kb    | Esp32 PHY data          |
| 0x00010000    | 1216Kb | Zerynth VM              |
| 0x00140000    | 1216Kb | Zerynth VM (FOTA)       |
| 0x00270000    | 320Kb  | Zerynth Bytecode        |
| 0x002C0000    | 320Kb  | Zerynth Bytecode (FOTA) |
| 0x00310000    | 512Kb  | Free for user storage   |
| 0x00390000    | 448Kb  | Reserved                |

### Device Summary

-   Analog and digital ports for connection to industrial sensors and PLC.
-   Modular hardware with infinite configuration.
-   Multi-connectivity: GSM, Wi-Fi, Bluetooth, LoRa, Ethernet.
-   Can retain and store data locally when disconnected.
-   Secure hardware encryption and Blockchain-ready.
-   Python-programmable thanks to Zerynth technology.

### Power

When programming, power to the 4ZeroBox is supplied via the on-board USB Micro B connector, and the jumper JP1 must be set to U5V position.

When not programming, external power supply it’s possible from 24 VDC, setting the JP1 jumper to E5V position. There is also a JST connector for LiPo 3.7/4.2V batteries with charger circuit integrated.

**Note**

The jumper JP1 select from USB or external 24 VDC power supply, but the switch to battery is done automatically.

### Connect, Register, Virtualize and Program

The 4ZeroBox comes with a serial-to-usb chip on board that allows programming and opening the UART of the ESP32 module. The CH340 USB to UART chip is also connected to the boot pins of the module, allowing for a seamless virtualization of the device.

**Note**

**For Linux Platform**: to allow the access to serial ports the user needs read/write access to the serial device file. Adding the user to the group, that owns this file, gives the required read/write access:

-   **Ubuntu** distribution –> dialout group
-   **Arch Linux** distribution –> uucp group

Once connected on a USB port, if drivers have been correctly installed, the 4ZeroBox device is recognized by Zerynth Studio. The next steps are:

-   **Select** the 4ZeroBox on the **Device Management Toolbar**;
-   **Register** the device by clicking the “Z” button from the Zerynth Studio;
-   **Create** a Virtual Machine for the device by clicking the “Z” button for the second time;
-   **Virtualize** the device by clicking the “Z” button for the third time.

After virtualization, the 4ZeroBox is ready to be programmed and the Zerynth scripts **uploaded**. Just **Select** the virtualized device from the “Device Management Toolbar” and **click** the dedicated “upload” button of Zerynth Studio.

### Resources

For more infos about electrical connections, and how to use 4ZeroBox with sensors and other hardware, see the user  [manual.](https://www.zerynth.com/download/13894/)

Other useful documents are:

-   [Datasheet](https://www.zerynth.com/download/13895/)
-   [Quick Guide](https://www.zerynth.com/download/15283/)

### Firmware Over the Air update (FOTA)

FOTA updates are supported, including this library in a Zerynth project automatically set up all the needed informations and nothing else must be done for using them.

Please refer to [this section](https://www.zerynth.com/blog/docs/4zeroplatform/getting-started/#fota) for learning how to flash a new firmware remotely.

Flash Layout is shown in table below:

| Start address | Size  | Content                   |
|---------------|-------|---------------------------|
| 0x00010000    | 1Mb   | Zerynth VM (slot 0)       |
| 0x00110000    | 1Mb   | Zerynth VM (slot 1)       |
| 0x00210000    | 512Kb | Zerynth Bytecode (slot 0) |
| 0x00290000    | 512Kb | Zerynth Bytecode (slot 1) |

For BLE VMs:

| Start address | Size   | Content                   |
|---------------|--------|---------------------------|
| 0x00010000    | 1216Kb | Zerynth VM (slot 0)       |
| 0x00140000    | 1216Kb | Zerynth VM (slot 1)       |
| 0x00270000    | 320Kb  | Zerynth Bytecode (slot 0) |
| 0x002C0000    | 320Kb  | Zerynth Bytecode (slot 1) |

### Secure Firmware

The VM includes some safety measures to avoid malfunctioning. A hardware watchdog is present on the ESP32 microcontroller and must be set up and kicked in a loop to avoid board resets.

Check the examples included to see how to properly kick the watchdog.

### Missing features

Not all IDF features have been included in the Esp32 based VMs. In particular the following are missing but will be added in the near future:

-   Touch detection support

### 4ZeroBox library

This documentations refers to the Zerynth library used in programming a 4ZeroBox.

This module exports a `FourZeroBox` class containing all the available methods for controlling onboard devices of a 4ZeroBox (e.g. leds, relays, I2C, …).

**Warning**: this library is using the Zerynth _conditional compilation_ feature. This means that some of the methods documented below must be explicitly enabled in a separate configuration file called `project.yml`.

A default configuration file is included within the examples, structured like this:


```python
# project.yml
config:
    # fourzerobox defines
    # enable ethernet connection
    NETWORK_ETH: null
    # enable wifi connection
    NETWORK_WIFI: true
    # enable ADC 0-10v/4-20mA peripheral
    ADC_010_420: null
    # enable ADC resistive peripheral
    ADC_RESISTIVE: null
    # enable ADC current peripheral
    ADC_CURRENT: null
    # enable can peripheral
    CAN_ENABLE: null
    # enable RS485 peripheral
    RS485_ENABLE: null
    # enable RS232 peripheral
    RS232_ENABLE: null

    # fourzeroplatform defines
    # enable HW crypto
    ZERYNTH_HWCRYPTO_ATECCx08A: true
    # enable stored certificate
    CERT_STORED: true
    # enable provate key and certificate from resources
    CERT_SOURCE: null
    # enable DEBUG for fourzerobox
    DEBUG_FZB: null
    # enable DEBUG for fourzeromanager
    DEBUG_FZM: null
    # enable SD Card
    SDCARD_ENABLED: null
```

### Default sinks and relays status

At startup, every sink and relay is set to a default **LOW** state. Be sure to read the [4ZeroBox user manual](https://www.zerynth.com/download/13894/) to check available peripherals.

### FourZeroBox class

Class for controlling a 4ZeroBox.

Initialize it with:
```python
    from fourzerobox import FourZeroBox
    
    box = FourZeroBox()
```
### Available methods

**Constructor**

```
__init__(i2c_clk=400000, spi_clk=1000000)

```

Initialize the class specifying what features must be enabled and configuring the clock speed of I2C and SPI protocols.

**Parameters:**

-   **i2c_clk** – Clock for connected I2C devices, in Hz. (D=400000)
-   **spi_clk** – Clock for connected SPI devices, in Hz. (D=1000000)

**config_adc_010_420(ch, pga, sps)**

This method configure one of the four 0-10V/4-20mA ADC channels (chosen using the `ch` parameter).

**Parameters:**

-   **ch** – Chose the channel to be configured (can be 1, 2, 3, 4).
-   **pga** – Set the PGA Gain.
-   **sps** – Set the samples-per-second data rate.

**set_conversion_010_420(ch, y_min, y_max, offset=0, under_x=None, over_x=None)**

Set the conversion method to be applied for the data read from the 0-10V/4-20mA ADC. The conversion scale can be configured using the `y_min` and `y_max` parameters, and optionally it can also be set an `offset` and tresholds for the input data.

**Parameters:**

-   **ch** – Chose the channel to be configured (can be 1, 2, 3, 4).
-   **y_min** – Set the minimum value for the linear scale.
-   **y_max** – Set the maximum value for the linear scale.
-   **offset** – Optionally set an offset to be applied. (D=0)
-   **under_x** – Optionally set a minimum treshold. (D=None)
-   **over_x** – Optionally set a maximum treshold. (D=None)

**config_adc_resistive(ch, pga, sps)**

This method configure one of the four resistive ADC channels (chosen using the `ch` parameter).

**Parameters:**

-   **ch** – Chose the channel to be configured (can be 1, 2, 3, 4).
-   **pga** – Set the PGA Gain.
-   **sps** – Set the samples-per-second data rate.

**set_conversion_resistive(ch, v_min, ref_table, delta, offset=0, out_of_range=None)**

Set the conversion method to be applied for the data read from the resistive ADC. The conversion table can be configured using the `v_min`, `ref_table` and `delta` parameters. `out_of_range` is the value returned when the conversion exceed the bounds of the lookup table, defaults to None.

**Parameters:**

-   **ch** – Chose the channel to be configured (can be 1, 2, 3, 4).
-   **v_min** – Set the minimum value of the table.
-   **ref_table** – List of numbers representing the lookup table values to be used for scale.
-   **delta** – Step between two adjacent element of the table.
-   **offset** – Optionally set an offset to be applied. (D=0)
-   **out_of_range** – Value returned if a value can’t be found on the table. (D=None)

**config_adc_current(ch, pga, sps)**

This method configure one of the three current ADC channels.

**Parameters:**

-   **ch** – Chose the channel to be configured (can be 1, 2, 3).
-   **pga** – Set the PGA Gain.
-   **sps** – Set the samples-per-second data rate.

**set_conversion_current(ch, n_samples=400, ncoil=1, ratio=2000, voltage=220, offset=0)**

This method set the conversion parameters of a channel of the current ADC. It is possible to configure the numbr of samples that must be acquired, the number of coils done around the sensor, the ratio of the external sensor, and an offset.

**Parameters:**

-   **ch** – Chose the channel to be configured (can be 1, 2, 3).
-   **n_samples** – Set the number of samples to be read before conversion. (D=400)
-   **ncoil** – Set the number of coils around the sensor. (D=1)
-   **ratio** – Set the ratio current acquired by the sensor. (D=2000)
-   **voltage** – Set the voltage of the current. (D=220)
-   **offset** – Set an offset for the read data. (D=0)

**set_led(color)**

Set the LED status to a custom color.

**Parameters:**

-   **color** – Character representing a color, see the table below.

### Available colors

| Char |  Color  |
|:----:|:-------:|
| R    | Red     |
| G    | Green   |
| B    | Blue    |
| M    | Magenta |
| Y    | Yellow  |
| C    | Cyan    |
| W    | White   |

**clear_led()**

Clear LED status.

**pulse(color, duration)**

Turn on the LED with the chosen color, then turn it off after the specified amount of time.

**Parameters:**

-   **color** – Char representing a color. See `set_led` for a list.
-   **duration** – Amount of time in milliseconds.

**reverse_pulse(color, duration)**

Wait the specified amount of time, the turn the LED on with the selected color.

**Parameters:**

-   **color** – Char representing a color. See `set_led` for a list.
-   **duration** – Amount of time in milliseconds.

**error_sys()**

Set the LED status to a system error.

**error_connect()**

Set the LED status to a net connection error.

**error_cloud()**

Set the LED status to a cloud connection error.

**error_custom()**

Set the LED status to a custom error, specifying color, duration, and the numer of pulses.

**Parameters:**

-   **color** – Char representing a color. See `set_led` for a list.
-   **duration** – Amount of time in milliseconds for each pulse.
-   **n_pulses** – Number of performed pulses.

**shut_down()**

Turn off every external peripheral of the board. This includes the the three ADC, etc.

**power_on()**

Turn back on the external peripherals, such as ADCs.

**relay_on(n_rel)**

Switch the selected relay ON, COM contact is closed on NO contact.

**Parameters:**

-   **n_rel** – Relay to be turned on, possible values are 1 or 2.

**relay_off(n_rel)**

Switch the selected relay OFF, COM contact is closed on NC contact.

**Parameters:**

-   **n_rel** – Relay to be turned off, possible values are 1 or 2.

**sink_on(n_snk)**

Switch the selected sink ON, Sink channel is shorted to GND.

**Parameters:**

-   **n_snk** – Sink to be turned on, possible values are 1 or 2.

**sink_off(n_snk)**

Switch the selected sink OFF, Sink channel is shorted to GND.

**Parameters:**

-   **n_snk** – Sink to be turned off, possible values are 1 or 2.

**get_opto(n_opto)**

Get the value read from the selected opto.

**Parameters:**

-   **n_opto** – Opto to read data from. Possible values are 1 or 2.

**get_battery_status()**

If alimented by a battery, return the current status as string that can be one of “charged”, “charging”, or “discharging”.

**get_power_source()**

Get a string representing the alimentation source for the box. The returned string can be one of “external” or “battery”.

**read_010(ch, raw=False, electric_value=False)**

Read value from the 0-10V ADC. It is possible to get the raw data from the ADC, or the electric value of the read signal.

**Parameters:**

-   **ch** – Select the ADC channel to read from. Can be one of 1, 2, 3, 4.
-   **raw** – If set, the raw data of the ADC is returned. (D=False)
-   **electric_value** – If set, the electric value is returned. (D=False)

**read_420(ch, raw=False, electric_value=False)**

Read value from the 4-20mA ADC. It is possible to get the raw data from the ADC, or the electric value of the read signal, or by default it is converted with the rules defined using `set_conversion_010_420` method.

**Parameters:**

-   **ch** – Select the ADC channel to read from. Can be one of 1, 2, 3, 4.
-   **raw** – If set, the raw data of the ADC is returned. (D=False)
-   **electric_value** – If set, the electric value is returned. (D=False)

**read_resistive(ch, raw=False, electric_value=False)**

Read value from the resistive ADC. It is possible to get the raw data from the ADC, or the electric value of the read signal, or by default it is converted with the rules defined using `set_conversion_resistive` method.

**Parameters:**

-   **ch** – Select the ADC channel to read from. Can be one of 1, 2, 3, 4.
-   **raw** – If set, the raw data of the ADC is returned. (D=False)
-   **electric_value** – If set, the electric value is returned. (D=False)

**read_power(ch, raw=False, electric_value=False)**

Read value from the power ADC. It is possible to get the raw data from the ADC, or the electric value of the read signal, or by default it is converted with the rules defined using `set_conversion_current` method.

**Parameters:**

-   **ch** – Select the ADC channel to read from. Can be one of 1, 2, 3.
-   **raw** – If set, the raw data of the ADC is returned. (D=False)
-   **electric_value** – If set, the electric value is returned. (D=False)

**net_init(static_ip=None, static_mask=None, static_gateway=None, static_dns=None)**

Initialize network driver. Optionally a static ip address, subnet mask, gateway address, and a DNS server address can be configured, otherwise they are obtained using DHCP.

**Parameters:**

-   **static_ip** – Static IP address of the device. (D=None)
-   **static_mask** – Static subnet mask. (D=None)
-   **static_gateway** – Static gateway address. (D=None)
-   **static_dns** – Static DNS server address. (D=None)

**net_connect() – Ethernet**

Connect to the network using the Ethernet interface. This method is enabled at compilation time using the `NETWORK_ETH` flag.

**Warning**: use only one of `NETWORK_ETH`, `NETWORK_WIFI`.

**net_connect(ssid, password, keying=net.WIFI_WPA2) – Wi-Fi**

Connect to the network using the Wi-Fi interface. This method is enabled at compilation time using the `NETWORK_WIFI` flag.

**Warning**: use only one of `NETWORK_ETH`, `NETWORK_WIFI`.

**Parameters:**

-   **ssid** – SSID of the Wi-fi network to connect to.
-   **password** – Password of the Wi-Fi network.
-   **keying** – Encryption type. (D=net.WIFI_WPA2)

**get_rssi()**

Get RSSI of the current wireless connection.

**read_rs485(timeout=3000)**

Read from the RS485 peripheral (it must be enabled in the class constructor). After the timeout expires, None is returned.

**Parameters:**

-   **timeout** – Maximum timeout to wait for a message in milliseconds. (D=3000)

**write_rs485(msg)**

Write to the RS485 peripheral (it must be enabled in the class constructor).

**Parameters:**

-   **msg** – Message to be sent.

**read_rs232(timeout=3000)**

Read from the RS232 peripheral (it must be enabled in the class constructor). After the timeout expires, None is returned.

**Parameters:**

-   **timeout** – Maximum timeout to wait for a message in milliseconds. (D=3000)

**write_rs232(msg)**

Write to the RS232 peripheral (it must be enabled in the class constructor).

**Parameters:**

-   **msg** – Message to be sent.

**can_init(idmode, speed, clock)**

Initialize the CAN interface.

**Parameters:**

-   **idmode** – Set the RX buffer id mode (selectable from mcp2515.MCP_STDEXT, mcp2515.MCP_STD, mcp2515.MCP_EXT, or mcp2515.MCP_ANY.
-   **speed** – Set the speed of the CAN communication.
-   **clock** – Set the clock of the CAN Communication.

**set_can_mode(mode)**

Set CAN to the specified mode.

**Parameters:**

-   **mode** – The mode to be set. One of (“NORMAL”, “SLEEP”, “LOOPBACK”, “LISTENONLY”, “CONFIG”, “POWERUP”, “ONE_SHOT”).

**can_init_mask(num, data, ext)**

Init masks.

**Parameters:**

-   **num** – 0 to set mask 0 on RX buffer, 1 to set mask 1 on RX buffer
-   **data** – Data mask.
-   **ext** – 0 for standard ID, 1 for Extended ID.

**can_init_filter(num, data, ext)**

Init filters.

**Parameters:**

-   **num** – Number of filter to be set in RX buffer (from 0 to 5).
-   **data** – Data filter.
-   **ext** – 0 for standard ID, 1 for Extended ID.

**can_send(canid, data, ext=None)**

Sends CAN messages.

**Parameters:**

-   **canid** – ID of the CAN message (bytearray of 4 bytes).
-   **data** – Data to be sent (list of 8 bytes).
-   **ext** – 0 for standard ID, 1 for Extended ID (D=None, auto detected)

**can_receive()**

Receives CAN messages returning CAN id value and related data message.

**sd_init(mode)**

Initialize a SD card, using the SPI slot or the SD slot.

**Parameters:**

-   **mode** – One of “SD”, “SPI”.

**flash_load(start_address, tot_size, rjson=False)**

Load a file from the internal flash memory.

**Parameters:**

-   **start_address** – The address of the file beginning.
-   **tot_size** – The size of the file to be read.
-   **r_json** – If set, the file is parsed as a JSON and a dict return. (D=False)

**flash_write_buff(start_address, tot_size, buff, seek=None)**

Write a buffer in the internal flash memory, at the specified address.

**Parameters:**

-   **start_address** – Initial address of the memory to be written.
-   **tot_size** – Total size of the data to be written.
-   **buff** – Buffer of data to be written.
-   **seek** – Optional seek destionation to be done before writing. (D=None)

**flash_read_buff(start_address, tot_size)**

Return a buffer of data read at the specified start address.

**Parameters:**

-   **start_address** – Initial address to read from.
-   **tot_size** – Total size of data to be read.
<!--stackedit_data:
eyJoaXN0b3J5IjpbOTE5Nzk4Njk2LDY3OTQzMTU1NSw5Mzk3Mj
A2MzAsMTQzNzQ1MzcwOCwxMTQwODI1MjU4LC0xNzE4OTQxOSwx
NTgzNTg3MTIyLDEzMTIyODk2NzAsLTE5NjQzMzA4MTksLTIwMj
UyMzMyMzUsLTExNDYyMzc5NTJdfQ==
-->
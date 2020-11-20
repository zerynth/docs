# 4ZeroBox Module

This module contains the driver for enabling and handling all 4ZeroBox onboard features. The 4ZeroBox class permits an easier access to the internal peripherals and exposes all functionalities in simple function calls.

!!!Warning
	this library is using the Zerynth  _conditional compilation_  feature. This means that some of the methods documented below must be explicitly enabled in a separate configuration file called  project.yml  (or using the Zerynth Studio configuration browser).

Here Below a list of configurable defines for this library:

Example:

```python
# project.yml
config:
 # enable ethernet connection
 NETWORK_ETH: null
 # enable wifi connection
 NETWORK_WIFI: true
 # enable gsm connection
 NETWORK_GSM: true
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
 # enable SD Card
 SDCARD_ENABLED: null
 # enable DEBUG for fourzerobox
 DEBUG_FZB: null
```
## FourZeroBox Class 

##### class FourZeroBox

```py
_class_FourZeroBox(_i2c_clk=400000_,_spi_clk=1000000_)
```

Initialize the class specifying what features must be enabled and configuring the clock speed of I2C and SPI protocols.

Parameters:

-   **i2c_clk**  – Clock for connected I2C devices, in Hz. (D=400000)
-   **spi_clk**  – Clock for connected SPI devices, in Hz. (D=1000000)

##### FourZeroBox.config_adc_010_420

```py
config_adc_010_420(_ch_,_pga_,_sps_)
```

This method configure one of the four 0-10V/4-20mA ADC channels (chosen using the  ch  parameter).

Parameters:

-   **ch**  – Chose the channel to be configured (can be 1, 2, 3, 4).
-   **pga**  – Set the PGA Gain.
-   **sps**  – Set the samples-per-second data rate.

##### FourZeroBox.set_conversion_010_420

```py
set_conversion_010_420(_ch_,_y_min_,_y_max_,_offset=0_,_under_x=None_,_over_x=None_)
```

Set the conversion method to be applied for the data read from the 0-10V/4-20mA ADC. The conversion scale can be configured using the  y_min  and  y_max  parameters, and optionally it can also be set an  offset  and tresholds for the input data.

Parameters:

-   **ch**  – Chose the channel to be configured (can be 1, 2, 3, 4).
-   **y_min**  – Set the minimum value for the linear scale.
-   **y_max**  – Set the maximum value for the linear scale.
-   **offset**  – Optionally set an offset to be applied. (D=0)
-   **under_x**  – Optionally set a minimum treshold. (D=None)
-   **over_x**  – Optionally set a maximum treshold. (D=None)

##### FourZeroBox.read_010

```py
read_010(_ch_,_raw=False_,_electric_value=False_)
```

Read value from the 0-10V ADC. It is possible to get the raw data from the ADC, or the electric value of the read signal.

Parameters:

-   **ch**  – Select the ADC channel to read from. Can be one of 1, 2, 3, 4.
-   **raw**  – If set, the raw data of the ADC is returned. (D=False)
-   **electric_value**  – If set, the electric value is returned. (D=False)

##### FourZeroBox.read_420

```py
read_420(_ch_,_raw=False_,_electric_value=False_)
```

Read value from the 4-20mA ADC. It is possible to get the raw data from the ADC, or the electric value of the read signal, or by default it is converted with the rules defined using  set_conversion_010_420  method.

Parameters:

-   **ch**  – Select the ADC channel to read from. Can be one of 1, 2, 3, 4.
-   **raw**  – If set, the raw data of the ADC is returned. (D=False)
-   **electric_value**  – If set, the electric value is returned. (D=False)

##### FourZeroBox.config_adc_resistive

```py
config_adc_resistive(_ch_,_pga_,_sps_)
```

This method configure one of the four resistive ADC channels (chosen using the  ch  parameter).

Parameters:

-   **ch**  – Chose the channel to be configured (can be 1, 2, 3, 4).
-   **pga**  – Set the PGA Gain.
-   **sps**  – Set the samples-per-second data rate.

##### FourZeroBox.set_conversion_resistive

```py
set_conversion_resistive(_ch_,_v_min_,_ref_table_,_delta_,_offset=0_,_out_of_range=None_)
```

Set the conversion method to be applied for the data read from the resistive ADC. The conversion table can be configured using the  v_min,  ref_table  and  delta  parameters.  out_of_range  is the value returned when the conversion exceed the bounds of the lookup table, defaults to None.

Parameters:

-   **ch**  – Chose the channel to be configured (can be 1, 2, 3, 4).
-   **v_min**  – Set the minimum value of the table.
-   **ref_table**  – List of numbers representing the lookup table values to be used for scale.
-   **delta**  – Step between two adjacent element of the table.
-   **offset**  – Optionally set an offset to be applied. (D=0)
-   **out_of_range**  – Value returned if a value can’t be found on the table. (D=None)

##### FourZeroBox.read_resistive

```py
read_resistive(_ch_,_raw=False_,_electric_value=False_)
```

Read value from the resistive ADC. It is possible to get the raw data from the ADC, or the electric value of the read signal, or by default it is converted with the rules defined using  set_conversion_resistive  method.

Parameters:

-   **ch**  – Select the ADC channel to read from. Can be one of 1, 2, 3, 4.
-   **raw**  – If set, the raw data of the ADC is returned. (D=False)
-   **electric_value**  – If set, the electric value is returned. (D=False)

##### FourZeroBox.config_adc_current

```py
config_adc_current(_ch_,_pga_,_sps_)
```

This method configure one of the three current ADC channels.

Parameters:

-   **ch**  – Chose the channel to be configured (can be 1, 2, 3).
-   **pga**  – Set the PGA Gain.
-   **sps**  – Set the samples-per-second data rate.

##### FourZeroBox.set_conversion_current

```py
set_conversion_current(_ch_,_n_samples=400_,_ncoil=1_,_ratio=2000_,_voltage=220_,_offset=0_)
```

This method set the conversion parameters of a channel of the current ADC. It is possible to configure the numbr of samples that must be acquired, the number of coils done around the sensor, the ratio of the external sensor, and an offset.

Parameters:

-   **ch**  – Chose the channel to be configured (can be 1, 2, 3).
-   **n_samples**  – Set the number of samples to be read before conversion. (D=400)
-   **ncoil**  – Set the number of coils around the sensor. (D=1)
-   **ratio**  – Set the ratio current acquired by the sensor. (D=2000)
-   **voltage**  – Set the voltage of the current. (D=220)
-   **offset**  – Set an offset for the read data. (D=0)

##### FourZeroBox.read_power

```py
read_power(_ch_, _raw=False_,_electric_value=False_)
```

Read value from the power ADC. It is possible to get the raw data from the ADC, or the electric value of the read signal, or by default it is converted with the rules defined using  set_conversion_current  method.

**Param**: ch: Select the ADC channel to read from. Can be one of 1, 2, 3.
**Param:** raw: If set, the raw data of the ADC is returned. (D=False)
**Param:** electric_value: If set, the electric value is returned. (D=False)

##### FourZeroBox.set_led

```py
set_led(_color_)
```

Set the LED status to a custom color.

**Parameters:** **color**  – Character representing a color, see the table below.

| Char | Color   |
|------|---------|
| R    | Red     |
| G    | Green   |
| B    | Blue    |
| M    | Magenta |
| Y    | Yellow  |
| C    | Cyan    |
| W    | White   |

##### FourZeroBox.clear_led

```py
clear_led()
```

Clear LED status.

##### FourZeroBox.pulse

```py
pulse(_color_,_duration_)
```

Turn on the LED with the chosen color, then turn it off after the specified amount of time.

Parameters:

-   **color**  – Char representing a color. See  set_led  for a list.
-   **duration**  – Amount of time in milliseconds.

##### FourZeroBox.reverse_pulse

```py
reverse_pulse(_color_,_duration_)
```

Wait the specified amount of time, the turn the LED on with the selected color.

Parameters:

-   **color**  – Char representing a color. See  set_led  for a list.
-   **duration**  – Amount of time in milliseconds.

##### FourZeroBox.error_sys

```py
error_sys()
```

Set the LED status to a system error (Red at low frequency).

##### FourZeroBox.error_connect

```py
error_connect()
```

Set the LED status to a net connection error (Red at high frequency).

##### FourZeroBox.error_custom

```py
error_custom(_color_,_duration_,_n_pulses_)
```

Set the LED status to a custom error, specifying color, duration, and the numer of pulses.

Parameters:

-   **color**  – Char representing a color. See  set_led  for a list.
-   **duration**  – Amount of time in milliseconds for each pulse.
-   **n_pulses**  – Number of performed pulses.

##### FourZeroBox.shut_down

```py
shut_down()
```

Turn off every external peripheral of the board. This includes the the three ADC, etc.

##### FourZeroBox.power_on

```py
power_on()
```

Turn back on the external peripherals, such as ADCs.

##### FourZeroBox.relay_on

```py
relay_on(_n_rel_)
```

Switch the selected relay ON, COM contact is closed on NO contact.

Parameters:

**n_rel**  – Relay to be turned on, possible values are 1 or 2.

##### FourZeroBox.relay_off

```py
relay_off(_n_rel_)
```

Switch the selected relay OFF, COM contact is closed on NC contact.

Parameters:

**n_rel**  – Relay to be turned off, possible values are 1 or 2.

##### FourZeroBox.sink_on

```py
sink_on(_n_snk_)
```

Switch the selected sink ON, Sink channel is shorted to GND.

Parameters:

**n_snk**  – Sink to be turned on, possible values are 1 or 2.

##### FourZeroBox.sink_off

```py
sink_off(_n_snk_)
```

Switch the selected sink OFF, Sink channel is shorted to GND.

Parameters:

**n_snk**  – Sink to be turned off, possible values are 1 or 2.

##### FourZeroBox.get_opto

```py
get_opto(_n_opto_)
```

Get the value read from the selected opto.

Parameters:

**n_opto**  – Opto to read data from. Possible values are 1 or 2.

##### FourZeroBox.get_power_source

```py
get_power_source(_n_opto_)
```

Get a string representing the alimentation source for the box. The returned string can be one of “external” or “battery”.

##### FourZeroBox.net_init

```py
net_init(_static_ip=None_,_static_mask=None_,_static_gateway=None_,_static_dns=None_)
```

Initialize network driver. If static ip and static mask are set, DHCP is disabled and static ip, mask, gateway, and dns are used instead (ignored for gsm connectivity).

Parameters:

-   **static_ip**  – Static IP address of the device. (D=None)
-   **static_mask**  – Static subnet mask. (D=None)
-   **static_gateway**  – Static gateway address. (D=”0.0.0.0”)
-   **static_dns**  – Static DNS server address. (D=”8.8.8.8”)

##### FourZeroBox.net_connect-Ethrnet

```py
net_connect()
```

Connect to the network using the Ethernet interface. This method is enabled at compilation time using the  NETWORK_ETH  flag.

!!!Warning
	use only one of  NETWORK_ETH,  NETWORK_WIFI,  NETWORK_GSM.

##### FourZeroBox.net_connect-WiFi

```py
net_connect(ssid,password,keying=None)
```

Connect to the network using the Wi-Fi interface. This method is enabled at compilation time using the  NETWORK_WIFI  flag.

!!!Warning
	use only one of  NETWORK_ETH,  NETWORK_WIFI,  NETWORK_GSM.

Parameters:

-   **ssid**  – SSID of the Wi-fi network to connect to.
-   **password**  – Password of the Wi-Fi network.
-   **keying**  – Encryption type. (D=None)

##### FourZeroBox.net_connect-GSM

```py
net_connect(apn)
```

Connect to the network using the GSM/GPRS interface. This method is enabled at compilation time using the  NETWORK_GSM  flag.

!!!Warning
	use only one of  NETWORK_ETH,  NETWORK_WIFI,  NETWORK_GSM.

Parameters:

**apn**  – APN name of the SIM operator to connect to.

##### FourZeroBox.get_rssi

```py
get_rssi()
```

Get RSSI of the current wireless connection (works only for Wi-Fi and GSM).

##### FourZeroBox.read_rs485-timeout

```py
read_rs485(_timeout=3000_)
```

Read from the RS485 peripheral (it must be enabled in the class constructor). After the timeout expires, None is returned.

Parameters:

**timeout**  – Maximum timeout to wait for a message in milliseconds. (D=3000)

##### FourZeroBox.write_rs485-msg

```py
write_rs485(_msg_)
```

Write to the RS485 peripheral (it must be enabled in the class constructor).

Parameters:

**msg**  – Message to be sent.

##### FourZeroBox.read_rs232-timeout

```py
read_rs232(_timeout=3000_)
```

Read from the RS232 peripheral (it must be enabled in the class constructor). After the timeout expires, None is returned.

Parameters:

**timeout**  – Maximum timeout to wait for a message in milliseconds. (D=3000)

##### FourZeroBox.write_rs232-msg

```py
write_rs232(_msg_)
```

Write to the RS232 peripheral (it must be enabled in the class constructor).

Parameters:

**msg**  – Message to be sent.

##### FourZeroBox.can_init

```py
can_init(_idmode_,_speed_,_clock_)
```

Initialize the CAN interface.

Parameters:

-   **idmode**  – Set the RX buffer id mode (selectable from mcp2515.MCP_STDEXT, mcp2515.MCP_STD, mcp2515.MCP_EXT, or mcp2515.MCP_ANY).
-   **speed**  – Set the speed of the CAN communication.
-   **clock**  – Set the clock of the CAN Communication.

##### FourZeroBox.set_can_mode

```py
set_can_mode(_mode_)
```

Set CAN to the specified mode.

Parameters:

**mode**  – The mode to be set. One of (“NORMAL”, “SLEEP”, “LOOPBACK”, “LISTENONLY”, “CONFIG”, “POWERUP”, “ONE_SHOT”).

##### FourZeroBox.can_init_mask

```py
can_init_mask(_num_, _data_,_ext_)
```

Init CAN masks.

Parameters:

-   **num**  – 0 to set mask 0 on RX buffer, 1 to set mask 1 on RX buffer
-   **data**  – Data mask.
-   **ext**  – 0 for standard ID, 1 for Extended ID.

##### FourZeroBox.can_init_filter

```py
can_init_filter(_num_, _data_, _ext_)
```

Init filters.

Parameters: :param num: Number of filter to be set in RX buffer (from 0 to 5). :param data: Data filter. :param ext: 0 for standard ID, 1 for Extended ID.

##### FourZeroBox.can_send

```py
can_send(_canid_,_data_,_ ext=None_)
```

Sends CAN messages.

Parameters:

-   **canid**  – ID of the CAN message (bytearray of 4 bytes).
-   **data**  – Data to be sent (list of 8 bytes).
-   **ext**  – 0 for standard ID, 1 for Extended ID (D=None, auto detected)

##### FourZeroBox.can_receive

```py
can_receive()
```

Receives CAN messages returning CAN id value and related data message.

##### FourZeroBox.can_receive

```py
can_receive(_mode_)
```

Initialize a SD card, using the SPI slot or the SD slot.

Parameters:

**mode**  – One of “SD”, “SPI”.

##### FourZeroBox.flash_load

```py
flash_load(_start_address_, _tot_size_, _rjson=False_)
```

Load a file from the internal flash memory.

Parameters:

-   **start_address**  – The address of the file beginning.
-   **tot_size**  – The size of the file to be read.
-   **r_json**  – If set, the file is parsed as a JSON and a dict return. (D=False)

##### FourZeroBox.flash_write_buff

```py
flash_write_buff(_start_address_,_tot_size_,_buff_,_seek=None_)
```

Write a buffer in the internal flash memory, at the specified address.

Parameters:

-   **start_address**  – Initial address of the memory to be written.
-   **tot_size**  – Total size of the data to be written.
-   **buff**  – Buffer of data to be written.
-   **seek**  – Optional seek destionation to be done before writing. (D=None)

##### FourZeroBox.flash_read_buff

```py
flash_read_buff(_start_address_, _tot_size_)
```

Return a buffer of data read at the specified start address.

Parameters:

-   **start_address**  – Initial address to read from.
-   **tot_size**  – Total size of data to be read.

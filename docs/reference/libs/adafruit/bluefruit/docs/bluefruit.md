# Bluefruit Module

This module implements the driver for the Adafruit Bluefruit LE SPI products family, based on Bluefruit firmware v0.6.7 or higher ([link](https://www.adafruit.com/products/2746)).

Data between the mcu and the Bluefruit hardware is exchanged by SPI or serial communication. However, this module has support for SPI only.

**`init(spidrv,nss,irqpin)`**

Manually initializes the Bluefruit peripheral by activating the following communication setup:


* *spidrv* is the SPI peripheral to use (usually SPI0 for devices with an Arduino compatible layout)


* *nss* is the chip select pin (usually D8)


* *irqpin* is the pin used by the Bluefruit hardware to signal incoming messages (usually D7)

The SPI driver is started and the Bluefruit initialization sequence is sent.


---
#### `#!py3 hard_reset()`

!!!abstract "`#!py3 hard_reset()`"

Performs a factory reset. Returns True on success.



**`hard_reset()`**

Performs a software reset. Returns True on success.



reset()

If *name* is None, returns the current Bluefruit device name. Otherwise changes the current name to *name*.
Returns True on success.



**`gap_name(name=None)`**

Setup advertising data. Please refer to [this resource](https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=302735&_ga=1.4683440.245686596.1452259520) for a list of possible values accepted by the BLE standard.

*data* is an iterable containing blocks of data in the following format:


* byte 1: length of the block (n)


* byte 2: type of the block


* byte 3 to n: value of the block

Usually *data* is made of a flag block, followed by blocks advertising BLE services.

For example the sequence [0x02, 0x01, 0x06, 0x05, 0x02, 0x0d, 0x18, 0x0a, 0x18] is an encoding of the following info:


* 0x02: length of block 1


* 0x01: type of the block (“Flag”)


* 0x06: value of the block


* 0x05: length of block 2


* 0x02: type of block (“List of 16-bit Service UUID”)


* 0x180d, 0x180a: two 16 bit uuids. The first one is for a “Heart rate” service, the second for “Device Info” service.

Refer to [this](https://www.bluetooth.org/en-us/specification/assigned-numbers/generic-access-profile) for a list of block types.

Returns True on success.


**`gap_is_connected()`**

Returns 1 if Bluefruit hardware is connected to a client, 0 if not connected. Returns None on failure.


gatt(cfg=None)


If *cfg* is None returns the current [GATT](https://learn.adafruit.com/introduction-to-bluetooth-low-energy/gatt) configuration.

Otherwise BLuefruit configuration is cleared first and then changed to *cfg*.

The format of *cfg* is a list of lists:

```
cfg = [
    [0,0x180D],                     # Service with UUID 0x180D = Heart Rate
      [1,0x2a37,(0x00,0x40),0x10],  # Characteristic of last defined service
      [2,0x2a38,3,0x02]             # another characteristic
]
```

In the main list, a service is identified by a two elements list where the first element is an id (can be set to zero)
and the second element is the UUID of the service. If the UUID of the service is more than 32 bit, it can be passed as a tuple of bytes or as a bytearray.

Every list of 4 elements identifies a characteristic of the previously defined service. Characteristics are made of:


* a handle at position 0: can be set to zero


* a characteristic UUID: can be 16, 32 or 128 bits


* a default value for the characteristic: can be a string, an integer or an iterable of bytes.


* a permission flag: refer to [this](https://learn.adafruit.com/introducing-the-adafruit-bluefruit-spi-breakout/ble-gatt) for reference

Returns the configuration activated on the device or None on failure. After a configuration is successfully set, the return value contains handles modified to the actual ones choosen by the device.


---
#### `#!py3 gatt_set()`

!!!abstract "`#!py3 gatt_set(handle, value)`"

Sets the ```value``` of a characteristic given its ```handle``` (as returned after a successfull configuration). Value can be an integer, a string or an iterable of bytes.
Returns False on failure.


---
#### `#!py3 gatt_get()`

!!!abstract "`#!py3 gatt_get(handle)`"

Returns the value of the characteristic identified by ```handle``` (as returned after a successfull configuration).

Returns None on failure.


---
#### `#!py3 addr()`

!!!abstract "`#!py3 addr()`"

Returns the 48bit mac address of the device as an hex string. Returns None on failure.


---
#### `#!py3 peer_addr()`

!!!abstract "`#!py3 peer_addr()`"

Returns the 48bit mac address of the client connected device as an hex string. Returns None on failure.


---
#### `#!py3 addr()`

!!!abstract "`#!py3 addr()`"

Returns the RSSI level id dBm. Returns None on failure.


---
#### `#!py3 tx_power()`

!!!abstract "`#!py3 tx_power(dbm=None)`"

If ```dbm``` is None, returns the current transmission power level. Otherwise sets the power level to ```dbm``` (in the range -40 to 4).

Returns None on failure.

## BLEStream class


---
#### `#!py3 BLEStream()`

!!!abstract "`#!py3 BLEStream(fifosize=1024)`"

This class implements a serial stream on the Bluefruit peripheral. The internal implementation uses
a fifo buffer of ```fifosize``` bytes.

The BLEStream is not automatically set as the global serial stream.

Read and write methods are the same of any stream with the difference that they raise IOError if the BLEStream is
not connected (namely, the Bluefruit peripheral is not paired with a BLE client).

Also, due to the features of the Bluefruit firmware, read methods use a polling mechanism to check for incoming data.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTg1NzU4OTczLDMwNTkwNTUwMF19
-->
# SpiSD

This module handles operations on Standard Capacity and High Capacity SD Cards (SDSC, SDHC) through Spi protocol.
The following operations are allowed:


* read/write single block, with block address specified through SDSC or SDHC convention;


* read/write multiple blocks, with block address specified through SDSC or SDHC convention;


* generic read/write data, with block address specified through SDHC convention for both SDCS and SDHC cards;


* read cid register.

Block size is set by default to 512 bytes.

Address conventions:


* SDSC convention allows to select a block through its first byte location in byte address (example: for a block size of 512 bytes, second block will be addressed 0x200);


* SDHC convention allows to select a block through its block address (example: 2nd block address (starting from 0th block) is simply 0x2)

## SpiSD class


`SpiSD(drvname, cs, clock=1000000)`

Initialize an SD card specifying its:


* MCU SPI circuitry ```drvname``` (one of SPI0, SPI1, … check pinmap for details);


* chip select pin ```cs```;


* clock ```clock```, default at 1MHz

The instance attribute ```hc``` is set to 1 if the card is recognized as an SDHC, to 0 otherwise.


`single_block_read(addr)`

Read a single block at address ```addr```, following SDSC or SDHC address convention depending on used card.


`multiple_blocks_read(addr, n)`

Read n blocks starting from address ```addr```, following SDSC or SDHC address convention depending on used card.


`read_data(addr, n)`

Read n blocks starting from address ```addr```, SDHC address convention is used.


`single_block_write(addr, data)`

Write a single block at address ```addr```, following SDSC or SDHC address convention depending on used card.
```data``` must be a 512-byte long bytearray.


`multiple_blocks_write(addr, data)`

Write ```data``` starting from address ```addr```, following SDSC or SDHC address convention depending on used card.

Two formats allowed for ```data```:


* bytearray with a len multiple of 512 bytes.


* list of 512-byte long bytearrays, where each bytearray inside data list contains data for a single block:

```
block_1 = bytearray(0x200)
block_2 = bytearray(0x200)
...
[ block_1 , block_2 , ... ]
```


`write_data(addr, data)`

Write ```data``` starting from address ```addr```, SDHC address convention is used.

```data``` format is defined as in `multiple_blocks_write()` .


`read_cid()`

Read 16-byte long cid register value.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIwMjYxNjc4NzFdfQ==
-->
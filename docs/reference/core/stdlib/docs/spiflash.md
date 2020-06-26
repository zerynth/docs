# SpiFlash

This modules handles operations on a generic Spi Flash Memory.
The following operations are allowed:


* read/write data;


* check if flash is busy;


* enable write operations;


* erase sector;


* erase chip.

## SpiFlash class


`SpiFlash(drvname, cs, clock=1000000)`

Initialize an external Flash memory specifying its:


* MCU SPI circuitry ```drvname``` (one of SPI0, SPI1, … check pinmap for details);


* chip select pin ```cs```;


* clock ```clock```, default at 1MHz.


`write_enable()`

Enable write operations.
Automatically called by `write_data()`, `erase_sector()`, `chip_erase()` methods.


`is_write_busy()`

Returns 1 or 0 depending on whether the Flash is busy or not.


`write_data(addr, data)`

Write data ```data``` starting from address ```addr```.
```data``` can be a bytearray or a list of integers less than 256.

`erase_sector()` MUST be called before writing data in a sector.

Writing is also allowed via bracket notation. The following is valid syntax:

```
my_flash[addr] = data
```


`erase_sector(addr)`

Erase a whole sector passing the ```addr``` address of any byte contained in it.
All sector bytes set to 0xff.


`read_data(addr, n=1)`"

Read ```n``` bytes of data starting from address ```addr```.

Reading is also allowed via bracket notation. The following is valid syntax:

```
my_data = my_flash[addr:addr+n]
```


`chip_erase()`

Erase the whole memory.
All memory bytes set to 0xff.


`chip_id(n)`

Returns the bytes representation of the flash chip unique identifier.
The length in bytes of the chip id must be passed as argument ```n```.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMzQ1MDYyMDE2XX0=
-->
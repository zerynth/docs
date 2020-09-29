# QSpiFlash class


### class QSpiFlash()
Initialize a a QspiFlash peripheral (external flash memory handled by qspi).
This peripheral is available only for stm32l4 family chip and for Polaris device the auto_init is implemented (pins and memory data already configured).

To initialize a custom external memory qspi flash several params must be passed to the init method:


* **```Arguments```**

    
    * ```d0``` – D0 pin of the Qspi peripheral


    * ```d1``` – D1 pin of the Qspi peripheral


    * ```d2``` – D2 pin of the Qspi peripheral


    * ```d3``` – D3 pin of the Qspi peripheral


    * ```clk``` – CLK pin of the Qspi peripheral


    * ```cs``` – CS pin of the Qspi peripheral


    * ```flash_size``` – Flash size of the qspi flash


    * ```block_size``` – Block size of the qspi flash


    * ```subblock_size``` – Sub-block size of the qspi flash


    * ```sector_size``` – Sector size of the qspi flash


    * ```page_size``` – Page size of the qspi flash


    * ```dummy_cycles_read``` – Dummy cycles simple read


    * ```dummy_cycles_read_dual``` – Dummy cycles Dual flash read


    * ```dummy_cycles_read_quad``` – Dummy cicles Quad Flash read


    * ```dummy_cycles_2read``` – Dummy cycles 2read


    * ```dummy_cycles_4read``` – Dummy Cycles 4read


    * ```alt_bytes_pe_mode``` – Alternate Bytes for PE mode


    * ```alt_bytes_no_pe_mode``` – Alternate Bytes for NO PE mode


    * ```sr_wip``` – Write in progress of the flash mamory status register


    * ```sr_wel``` – Write enable latch of the flash mamory status register


    * ```sr_bp``` – Block protect of the flash mamory status register


    * ```sr_srwd``` – Write disable of the flash mamory status register


    * ```sr1_qe``` – Quad enable of the flash mamory status register1


    * ```sr1_sus``` – Suspend status of the flash mamory status register1


###### get_geometry

```#!py3 get_geometry()```

Return a tuple holding flash geometry:


* ```flash_size```, Flash size of the qspi flash


* ```block_size```, Block size of the qspi flash


* ```subblock_size```, Sub-block size of the qspi flash


* ```sector_size```, Sector size of the qspi flash


* ```page_size```, Page size of the qspi flash

###### write_data

```#!py3 write_data(addr, data)```

Write data ```data``` starting from address ```addr```.
```data``` can be a bytearray or a list of integers less than 256.

`erase_sector()` MUST be called before writing data in a sector.

Writing is also allowed via bracket notation. The following is valid syntax:

```python
my_flash[addr] = data
```

###### erase_sector

```#!py3 erase_sector(addr)```

Erase a whole sector passing the ```addr``` address of any byte contained in it.
All sector bytes set to 0xff.

###### erase_block

```#!py3 erase_block(addr)```

Erase a memory block passing the ```addr``` address of any byte contained in it.
All block bytes set to 0xff.

###### read_data

```#!py3 read_data(addr, n=1)```

Read ```n``` bytes of data starting from address ```addr```.

Reading is also allowed via bracket notation. The following is valid syntax:

```
my_data = my_flash[addr:addr+n]
```


**
`chip_erase()`**
Erase the whole memory.
All memory bytes set to 0xff.

###### done

```#!py3 done()```
Close the QspiFlash peripheral.

###### wakeup

```#!py3 wakeup()```
Wake Up the QspiFlash peripheral from sleep mode.

###### sleep

```#!py3 sleep()```
Put the QspiFlash peripheral in sleep mode.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE2OTQ2OTcyM119
-->
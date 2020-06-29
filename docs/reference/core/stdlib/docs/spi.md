# SPI

This module loads the Serial Peripheral Interface (spi).

The connection between a spi peripheral (sensor, actuator, etc..) and the microcontroller is made
via  four wires with different functions as in the following schema:

```
      MCU                                    Peripheral
 _____________                                ________
|             |                              |        |
|             |______________________________|        |
|             |             SCLK             |        |
|             |______________________________|        |
|             |             MOSI             |        |
|             |______________________________|        |
|             |             MISO             |        |
|             |______________________________|        |
|_____________|              CS              |________|
```

One of the connected components is in charge of deciding the parameters of the connection and is the one starting
and stopping data transfers. Such component is aptly called ```Master``` whereas all the other connected components (the spi interface
is engineered to connect a master to more tha one slave) are called ```Slaves```.

The master decides the speed of the connection by sending a clock signal on the SCLK wire, transmits data to the slave
by encoding bits on the MOSI wire (Master Out Slave In), and receives data by reading bits on the MISO wire (Master In Slave Out).

Since many slaves can be connected to a single master, the wire CS (Chip Select, but also called SS, Slave Select) is used
to signal a particular slave that the connection is going to start and the transmitted data is addressed at it. One CS wire is needed
for ever connected slave.

The master also decides some low level details of the communication, namely the bit width and the polarity/phase.
The bit width is simply the number of bits to be sent per frame. The polarity and phase of the clock are somewhat more
difficult to understand also because the naming of the polarity and phase setting often differs between chip producers.

Refer to the following clock schema:


```
          _________            _________            _________
         |         |          |         |          |         |
  LOW    |         |          |         |          |         |  SCLK0
 ________|         |__________|         |__________|         |___


 ________           __________           __________           ___
         |         |          |         |          |         |
  HIGH   |         |          |         |          |         |  SCLK1
         |_________|          |_________|          |_________|

         1         2          1         2          1         2

MISO0     <--------------------><-------------------><------------------->


MISO1               <--------------------><-------------------><------------------->
```

The master needs to set the SCLK polarity, namely the idle status of the SCLK line. If polarity is low,
it means the SCLK signal starts LOW (SCLK0 in the schema), whereas if polarity is high the SCLK signal starts
HIGH (SCLK1 in the schema). Often the polarity of a peripheral is reported as CPOL in the data sheets, with CPOL=0 low polarity
and CPOL=1 high polarity.
Once the polarity is decided, signals in the MISO and MOSI lines can be transmitted in two different ways: with bits
starting at the first transition of SCLK (such as MISO0) or at the second transition of SCLK (such as MISO1). This setting is called phase,
and it is often reported as CPHA in the datasheet, with CPHA=0 meaning first transition and CPHA=1 meaning second transiton.

Finally, MISO and MOSI lines are synchronous, i.e. data is transmitted in a full duplex manner: the slave can send data
to the master while it is receiving data from the master. Therefore, spi operations can be divided in:


* write: the master sends data over MOSI and ignores what the slave sends over MISO


* read: the master reads data from MISO and writes nothing on MOSI


* skip: the master activates SCLK but neither reads or writes


* exchange: the master sends data over MOSI and at the same time receives data from MISO

## The Spi class


**`Spi(nss, drvname=SPI0, clock=12000000, bits=SPI_8_BITS, mode=SPI_MODE_LOW_FIRST)`**

This is the base class implementing spi master functionalities. Spi slave is not yet supported.

Spi is initialized by passing the driver name ```drvname```, in the form of SPI0, SPI1, etc… depending on the
board capabilities. Refer to the board pinout to locate the actual pins belonging to the driver.

```clock``` in Hz is also needed, together with the bit width (can be SPI_8_BITS or SPI_16_BITS), and the polarity/phase mode.
Combining polarity and phase yields four possible modes:


* SPI_MODE_LOW_FIRST: polarity low, phase on the first transition  (CPOL=0,CPHA=0)


* SPI_MODE_LOW_SECOND: polarity low, phase on second transition    (CPOL=0,CPHA=1)


* SPI_MODE_HIGH_FIRST: polarity high, phase on the first transition  (CPOL=1,CPHA=0)


* SPI_MODE_HIGH_SECOND: polarity high, phase on second transition    (CPOL=1,CPHA=1)

The ```nss``` argument is the pin name used as CS.

Different Spi instances for the same ```drvname``` coordinates themselves in selecting and unselecting slaves, as long as
a correct usage pattern is enforced:

```py
import spi

s0 = spi.Spi(D0)
s1 = spi.Spi(D1,clock=8000000)


s0.select()  # starts the spi bus, unselect the slave at D1, select the slave at D0
# do all s0 communications
s0.unselect() # unselect all the slaves

s1.select()  # stop the spi bus,starts the spi bus with s1 configuration, unselect the slave at D0,  select the slave at D1
# do all s1 communications
s1.unselect() # unselect all the slaves

# done must be called manually when the instance is no more needed
s0.done()
s1.done()
```


**`write(data)`**

```data``` is written to MOSI, bits on MISO are ignored.


**`read(n)`**

Returns a sequence of ```n``` bytes read from MISO. MOSI is ignored.


**`skip(n)`**

Ignores the next ```n``` bytes transmitted over MISO.


**`exchange(data)`**

```data``` is written to MOSI, and a sequence of bytes read from MISO is returned.


**`select()`**

The slave is selected, all the other slaves are unselected.
A slave must be selected before starting a transmission.
If necessary the spi bus is configured and started.


**`unselect()`**

All slaves are unselected.


**`lock()`**

Locks the driver. It is useful when the same spi bus is used by multiple Spi instances and/or multiple threads to avoid interferences.


**`unlock()`**

Unlocks the driver. It is useful when the same spi bus is used by multiple Spi instances and/or multiple threads to avoid interferences.


**`done()`**

Stops the spi driver
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTA0NjU0MzU1MywtMTMzNTIyNDc1OF19
-->
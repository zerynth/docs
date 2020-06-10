# Hardware Abstraction Layer

The Zerynth VM uses a common API to drive the underlying microcontroller peripherals. Such API is called VHAL and abstracts common peripherals operations so that peripheral access and management is identical across different microcontrollers.

## Pin Mapping

The VHAL introduces a distinction between **physical pins** and **virtual pins**. Physical pins are the actual pins available on the board and are defined in the file *port.c* for every supported board. A physical pin usually maps to a microcontroller register and offset, needed to drive the pin.

A virtual pin is just a name which refers to a particular configuration of a physical pin.

Therefore different virtual pins can map to the same physical pin. For example, imagine a board where the first physical pin (P0) can be used as a general purpose input output (GPIO) or as the clock line (SCL) of the first instance of the I2C bus. Such physical pin is always controlled by same microcontroller register, but in the first case it is configured as a GPIO and the corresponding virtual pin name will be D0, while in the second case it is configured as I2C clock and the virtual pin name will be SCL0.

The internal representation of virtual pins is a 16 bit integer where the high byte represents the name of the peripheral (the “class” of the pin), while the low byte is the row number in the table of physical pins for that peripheral.

All these levels of indirection are hidden by the VHAL using macros to access the relevant information about pins. All VHAL functions requiring pin names expect virtual pin names.

The following scheme summarizes the available virtual pin info:


Where *Pin Name* is a C Macro corresponding to *Pin Value*. For each string in *Pin Class* there exists a C macro with PINCLASS_](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id9) 
prepended, corresponding to the high byte of *Pin Value* (i.e. PINCLASS_DIGITAL is 0x00, PINCLASS_ANALOG is 0x01, etc…).

For each pin class, there exists a table containing configuration data. Such data can be accessed by the following macros:


**`PIN_CLASS_ID(vpin)`**

Returns a byte representing the index of the physical pin corresponding to vpin


**`PIN_CLASS_DATA0(vpin)`**
Returns a byte representing the first byte of info about vpin


**`PIN_CLASS_DATA1(vpin)`**
Returns a byte representing the second byte of info about vpin


**`PIN_CLASS_DATA2(vpin)`**
Returns a byte representing the third byte of info about vpin

The meaning of the three bytes of info depends on the actual porting; usually they contain configuration values to correctly setup the peripheral.

## Peripherals Mapping

Each microcontroller peripheral is mapped to a peripheral index in the board porting files. For each peripheral there exists a table mapping multiple peripheral instances of the same type to different indexes. The following example will clarify the mapping.

Imagine a microcontroller with four different USART peripherals named USART1 to USART4. In the board porting each USART is mapped to a peripheral index by creating such table:

| Index | Value |
|--------|------|
| 0     | 3     |
| 1     | 1     |
| 2     | 4     |
| 3     | 2     |

When a VHAL function is called, expecting a peripheral index for a serial peripheral, the table is used to map the passed index (e.g. 0) to the corresponding mcu peripheral (e.g. USART3). Each board porting defines this kind of tables for each supported peripheral.

The following macros can be used to query the peripheral tables:


**`GET_PERIPHERAL_ID(name,prph_idx)`**

Returns the microcontroller peripheral index given the *name* of the peripheral and the vhal index *prph_idx*. Referring to the previous table, *prph_idx* corresponds to values in the *Index* column, while the return value correspondes to the *Value* column. The parameter *name* is a string identifying the peripheral: “serial”, “spi”, “i2c”, “adc”, “pwm”, “icu”, “htm”.


**`PERIPHERAL_NUM(name)`**
Returns the number of microcontroller peripherals given the peripheral *name*.

## GPIO

A GPIO pin is a generic pin that can be used as input to read its digital status (low or high) or as output to set its digital status (low or high). On many microcontrollers it is possible to configure a GPIO to also generate an interrupt on status change.

### Macros

The following macros are used to set the pin mode of operation.


**`PINMODE_INPUT_PULLNONE`**

Used to configure a pin as input with no pull up/down circuitry (floating mode)


**`PINMODE_INPUT_PULLUP`**

Used to configure a pin as input with pull up circuitry


**`PINMODE_INPUT_ANALOG`**

Used to configure a pin as analog input by connecting it to an analog to digital converter


**`PINMODE_INPUT_PULLDOWN`**

Used to configure a pin as input with pull down circuitry


**`PINMODE_OUTPUT_PUSHPULL`**

Used to configure a pin as output. The pin will be able to both sink and source current.


**`PINMODE_OUTPUT_OPENDRAIN`**

Used to configure a pin as output. The pin will be able to only sink current. This means the pin output can only be set to low.


**`PINMODE_OUTPUT_HIGHDRIVE`**

Used to configure a pin as output. The pin will be able to only sink and source a higher current. Refer to each microcontroller datasheet for details.

**`PINMODE_EXT_FALLING`**

Used to configure a pin as input. An interrupt will be generated when the status of the pin goes from high to low.


**`PINMODE_EXT_RISING`**

Used to configure a pin as input. An interrupt will be generated when the status of the pin goes from low to high.


**`PINMODE_EXT_BOTH`**

Used to configure a pin as input. An interrupt will be generated when the status of the pin goes from low to high or from high to low.

#### GPIO Functions


**`int vhalPinSetMode(int vpin,int mode)`**

Set the digital mode of *vpin* to *mode*. Valid values for *mode* are the digital input and output PINMODE macros. Return 0 in case of success.


**`int vhalPinRead(int vpin)`**

Read the digital value of *vpin*. Return 0 if ```vpin``` is low, non-zero if ```vpin``` is high.


**`int vhalPinWrite(int vpin, int value)`**

Set the digital value of ```vpin``` to ```value```. If ```value``` is zero, ```vpin``` is set to low, otherwise is set to high. Return 0 in case of success.


**`int  vhalPinToggle(int vpin)`**

Invert the digital value of ```vpin```. If ```vpin``` is high it is set to low, if ```vpin``` is low it is set to high. Return 0 in case of success.


**`void* PinGetPort(int vpin)`**

Get the pointer to a gpio microcontroller register corresponding to ```vpin```. The return value must be used in functions like `vhalPinFastSet()` and `vhalPinFastClear()`.


**`int PinGetPad(int vpin)`**

Get the offset into a gpio microcontroller register corresponding to ```vpin```. The return value must be used in functions like `vhalPinFastSet()` and `vhalPinFastClear()`.


**`void vhalPinFastSet(void *port,int pad)`**

Bypass the virtual pin indirection by operating on the microcontroller register ```port``` with offset ```pad```. Set the corresponding pin to high.


**`void vhalPinFastClear(void *port,int pad)`**

Bypass the virtual pin indirection by operating on the microcontroller register ```port``` with offset ```pad```. Set the corresponding pin to low.


**`int vhalPinFastRead(void *port,int pad_)`**

Bypass the virtual pin indirection by operating on the microcontroller register ```port``` with offset ```pad```. Return 0 if the in is low, non-zero if it is high.


**`int vhalPinSetToPeripheral(int vpin, int prph, uint32_t prms)`**

Transfer the control of ```vpin``` to a peripheral identified by ```prph```. The configuration parameters for ```vpin``` are passed via ```prms``` in a format depending on the microcontroller porting.
Return 0 in case of success. The parameter ```prph``` is ignored in the current version of the VHAL.



**`int vhalPinAttachInterrupt(int vpin,int mode,extCbkFn fn, uint32_t timeout)`**


Attach callback ```fn``` to ```vpin```. ```fn``` is called from an ISR when there is a status change identified by ```mode```. ```mode``` can be one of the PINMODE_EXT macros. Return a non negative integer identifying the slot ```fn``` has been attached to.
If ```fn``` is NULL the currently attached function is removed and the interrupt disabled.

**`typedef void(*extCbkFn)(int slot,int dir)`**

The type of ```fn``` in `vhalPinAttachInterrupt()`. ```slot``` is the slot the callback has been attached to. ```dir``` is 0 if the callback has been called on a falling edge, non-zero on a rising edge.

if ```timeout``` is provided, ```fn``` is called only the status of the pin remains stable for at least ```timeout``` units of time, effectively implementing debouncing.

## ADC

Analog to digital converters are peripherals that convert voltage on a pin to a number representing its magnitude. ADCs can be very complex devices with very advanced functions.
The VHAL aims at supporting the following features when available:


1. Single pin, single sample conversion


2. Single pin, multiple samples conversion


3. Multiple pin conversion


4. Continuous conversion


5. Conversion triggers

The current version of VHAL supports features from 1 to 3.

To enable ADC functions the macro VHAL_ADC must be defined.

### Macros


### ADC_CAPTURE_SINGLE()
Select non continuous conversion mode


### ADC_CAPTURE_CONTINUOUS()
Select continuous conversion mode

### Types


### (\*adcCbkFn)(uint32_t* adc*, vhalAdcCaptureInfo* \```nfo```)
The type of the ADC callback for continuous mode. Not used in current version of VHAL.


### vhalAdcCaptureInfo()
A structure containing the parameters needed to configure the ADC for the conversion:

```
typedef struct _vhal_adc_capture {
  uint32_t samples;
  uint16_t *pins;
  uint8_t npins;
  uint8_t sample_size;
  uint8_t capture_mode;
  uint8_t trigger_mode;
  uint16_t trigger_vpin;
  void *buffer;
  void *half_buffer;
  int (*callback)(uint32_t, struct _vhal_adc_capture *);
} vhalAdcCaptureInfo;
```


* ```samples``` is the number of samples to capture


* ```pins``` is an array of virtual pin names to capture from


* ```npins``` is the length of ```pins```


* ```sample_size``` will hold the size of a single sample


* ```capture_mode``` is one of the ADC_CAPTURE macros


* ```trigger_mode``` select the trigger type. Not yet used.


* ```trigger_vpin``` is the virtual pin to be used as gpio trigger. Not yet used.


* ```buffer``` is a pointer to a location of memory where captured samples will be stored.


* ```half_buffer``` is a pointer to the free half of ```buffer``` in continuous mode. Not yet used.


* ```callback``` is a function called in continuous mode when one half of the buffer is filled. Not yet used.


### vhalAdcConf()
A structure used to initialize the ADC.

```
typedef struct _vhal_adc_conf {
  uint32_t samples_per_second;
  uint32_t resolution;
} vhalAdcConf;
```

#### Functions


### vhalInitADC(void\** data*)
Must be called before any function starting with ```vhalAdc```.


### vhalAdcInit(uint32_t* adc*, vhalAdcConf* \```conf```)
Initialize the ADC identified by the peripheral index ```adc``` with values in ```conf```. Return 0 on success, negative values in case of failure.


### vhalAdcGetPeripheralForPin(int* vpin*)
Return the ADC peripheral index associated with ```vpin```.


### vhalAdcPrepareCapture(uint32_t* adc*, vhalAdcCaptureInfo* \```info```)
Must be called before `vhalAdcRead()` to configure the conversion. Return 0 on success.
The member ```sample_size``` of ```info``` is set to the actual sample size.


### vhalAdcRead(uint32_t* adc*, vhalAdcCaptureInfo* \```info```)
Must be called after `vhalAdcPrepareCapture()` has configured the conversion. Return 0 on success. The member ```buffer``` of ```info``` must be set to te correct size according to ```samples``` and ```sample_size```.
The function suspends the current thread until the end of the conversion.
The samples are stored in the order they are converted in info->buffer.


### vhalAdcDone(uint32_t* adc*)
Disable the ADC identified by the peripheral index ```adc```.

## DAC

Digital to Analog converters are peripherals that convert a number to a voltage on a pin. DACs can be very complex devices with very advanced functions.
The VHAL aims at supporting the following features when available:


1. Single pin, software triggered conversion


2. Single pin, timed triggered conversion


3. Multiple pin conversion

To enable DAC functions the macro VHAL_DAC must be defined.


### vhalInitDAC(void\** data*)
Must be called before any function starting with ```vhalDac```.


### vhalDacInit(uint32_t* vpin*)
Initialize the DAC identified by the virtual pin ```vpin```. Return 0 on success, negative values in case of failure.


### vhalDacWrite(uint32_t* vpin*, uint16_t* \```data```, uint32_t* len*, uint32_t* timestep*)
Return 0 on success. Starts sending data samples in ```data``` to DAC identified by ```vpin``` up to ```len``` samples, each one sent after a dealy of ```timestep```.
The function suspends the current thread until the last sample is sent.


### vhalDacDone(uint32_t* vpin*)
Disable the DAC identified by the virtual pin ```vpin```.

## PWM

PWM peripherals are able to generate square waves on pins. Square waves are configurable in terms of total duration (period) and duration of high state (pulse).

To enable PWM functions the macro VHAL_PWM must be defined.


### vhalInitPWM(void\** data*)
Must be called before any function starting with ```vhalPwm```.


### vhalPwmStart(int* vpin*, uint32_t* period*, uint32_t* pulse*, uint32_t* npulses*)
Generate a square wave of period ```period``` and pulse ```pulse``` on ```vpin```. Timings must be expressed using `TIME_U` and both ```period``` and ```pulse``` must be expressed in the same time unit.

If ```npulses``` is positive, the function blocks the current thread until a number of square waves equal to ```npulses``` is generated; afterwards, pwm is disabled and the function returns.

If ```npulses``` is zero or less, pwm is activated and the function returns immediately.

If ```period``` is 0 or ```pulse``` is 0 or ```period``` is less than ```pulse``` pwm is deactivated regardless of ```npulses```

Return 0 on success. On failure return a negative integer.

## ICU

The Input Capture Unit of a microcontroller measures the timings of a square wave on a pin.

Imagine to have this signal on a digital pin:

```
HIGH  _______            ________________     _________
     |       |          |                |   |         |
     |       |          |                |   |         |
_____|       |__________|                |___|         |____  LOW

     <------><----------><---------------><-><--------->
        T0        T1             T2        T3     T4
```

The ICU is able to return the duration of T0, T1, T2, etc… in microseconds.

To enable ICU functions the macro VHAL_ICU must be defined.

### Macros


### ICU_TRIGGER_LOW()
Set ICU trigger to the first transition from high to low


### ICU_TRIGGER_HIGH()
Set ICU trigger to the first transition from low to high


### ICU_TRIGGER_BOTH()
Set ICU trigger to the first transition


### ICU_INPUT_PULLUP()
Set pin used by ICU as input with pullup


### ICU_INPUT_PULLDOWN()
Set pin used by ICU as input with pulldown


### ICU_CFG(trigger, filter, input)
Return a uint32_t encoding the information about icu triggering (one of the ICU_TRIGGER macros) and icu pin configuration (one of the ICU_INPUT macros). The parameter ```filter``` is not used at the moment and must be set to 0.


### ICU_CFG_GET_TRIGGER(cfg)
Extract the trigger value from a ```cfg``` generated by `ICU_CFG`


### ICU_CFG_GET_INPUT(cfg)
Extracts the input mode value from a ```cfg``` generated by `ICU_CFG`

### Functions


### vhalInitICU(void\** data*)
Must be called before any function starting with ```vhalIcu```.


### vhalIcuStart(int* vpin*, uint32_t* cfg*, uint32_t* time_window*, uint32_t* \```buffer```, uint32_t* \```bufsize```, uint32_t* \```firstbit```)
Start capturing on ```vpin```. The capture will start with pin mode and trigger parameters specified in ```cfg``` by means of the `ICU_CFG` macro. Once the capture starts, it will continue until one of the following conditions verifies:


* a time equal to ```time_window``` has passed from the last captured value


* a number of values equal to the integer pointed by ```bufsize``` has been captured

The function blocks the current thread until the end of the capture. On returning:


* ```bufsize``` will point to the number of captured values


* ```buffer``` will contain such values expressed in microseconds


* ```firstbit``` will point to ICU_TRIGGER_LOW if the first transition was from high to low, or to ICU_TRIGGER_HIGH if the first transition was from low to high.

Return 0 on success. On failure, a negative value.

## HTM

Hardware Timers can be used to keep track of time with a greater precision with respect to the RTOS software timers.

To enable HTM functions the macro VHAL_HTM must be defined.


### (\*htmFn)(uint32_t* tm*, void* \```args```)
Type of a hardware timer callback function.


### vhalInitHTM(void\** data*)
Must be called before any function starting with ```vhalHtm```.


### vhalHtmGetFreeTimer(void)
Return the peripheral index of the first available hardware timer. Return value is negative in case of error.


### vhalHtmOneShot(uint32_t* tm*, uint32_t* delay*, htmFn* fn*, void* \```args```, uint32_t* blocking*)
Given the peripheral index ```tm```, configure such timer to generate an interrupt after a time represented by ```delay``` (with `TIME_U`). On interrupt generation, ```fn``` is executed with arguments ```args```.

If ```blocking``` is non-zero, the function blocks the current thread until ```fn``` is called.
If ```blocking``` is zero, the function immediately returns.

If ```delay``` is zero, the timer is deactivated.

Return 0 on success.


### vhalHtmRecurrent(uint32_t* tm*, uint32_t* delay*, htmFn* fn*, void* \```args```)
Given the peripheral index ```tm```, configure such timer to generate an interrupt after a time represented by ```delay``` (with `TIME_U`). On interrupt generation, ```fn``` is executed with arguments ```args``` and the timer is reconfigured to generate another interrupt after the same ```delay```.

If ```delay``` is zero, the timer is deactivated and ```fn``` stops to be executed periodically.

Return 0 on success.


### vhalSleepMicros(uint32_t* tm*, uint32_t* micros*)
Given the peripheral index ```tm```, suspends the current thread for ```micros``` microseconds.

Return 0 on success.

## SERIAL

Serial communication interfaces in microcontrollers come in many flavours: USART, UART and Serial over USB. All this peripherals are grouped together in Zerynth and controlled with the same API.

### Macros


### SERIAL_PARITY_NONE()
Select no parity


### SERIAL_PARITY_EVEN()
Select even parity


### SERIAL_PARITY_ODD()
Select odd parity


### SERIAL_STOP_ONE()
Select 1 stop bit


### SERIAL_STOP_ONEHALF()
Select 1.5 stop bit


### SERIAL_STOP_TWO()
Select 2 stop bits


### SERIAL_BITS_8()
Select 8 bits of data


### SERIAL_BITS_7()
Select 7 bits of data


### SERIAL_CFG(parity, stop, bits, hw, other)
Return a uint32_t representing the serial port configuration. ```hw``` and ```other``` are not yet used and must be set to 0.


### SERIAL_CFG_PARITY(cfg)
Return parity configuration encoded in ```cfg```


### SERIAL_CFG_STOP(cfg)
Return stop bits configuration encoded in ```cfg```


### SERIAL_CFG_BITS(cfg)
Return data bits configuration encoded in ```cfg```

### Functions


### vhalSerialInit(uint32_t* ser*, uint32_t* baud*, uint32_t* cfg*, uint16_t* rxpin*, uint16_t* txpin*)
Initialize the serial peripheral indentified by the peripheral index ```ser```. Baudrate is set to ```baud``` and configuration parameters are taken from ```cfg``` encoded with `SERIAL_CFG`. ```rxpin``` and ```txpin``` are configured accordingly.

Return 0 on success.


### vhalSerialRead(uint32_t* ser*, uint8_t* \```buf```, uint32_t* len*)
Read ```len``` bytes from ```ser``` into ```buf``` blocking the current thread until all bytes are read.

Return the actual number of bytes read.


### vhalSerialWrite(uint32_t* ser*, uint8_t* \```buf```, uint32_t* len*)
Write ```len``` bytes from ```buf``` to ```ser```. Depending on the implementation, the function may return before all bytes are actually written to ```ser```.

Return the number of bytes written to ```ser``` or to an internal buffer.


### vhalSerialAvailable(uint32_t* ser*)
Return the number of bytes available to the next `vhalSerialRead()` call.


### vhalSerialDone(uint32_t* ser*)
Deactivate ```ser```.

## I2C

I2C is a multimaster and multislave bus used to exchange data between microcontrollers and peripherals. Many microcontrollers can be configured both as I2C masters or I2C slaves; in the current version, the VHAL supports only master mode.


### vhalI2CConf()
The following structure is used to configure the I2C bus:

```
typedef struct _vhal_i2c_conf {
  uint32_t clock;
  uint16_t addr;
  uint16_t sda;
  uint16_t scl;
  uint16_t mode;
} vhalI2CConf;
```

The meaning of vhalI2CConf members is:


* ```clock```: number of Hz the I2C bus will be clocked to. Use up to 100k for slow mode, up to 400k for fast mode. Other modes are not supported yet.


* ```addr```: the peripheral address to communicate with.


* ```sda```: the virtual pin that will be configured as SDA (data line).


* ```scl```: the virtual pin that will be configured as SCL (clock line).


* ```mode```: not used yet.


### vhalInitI2C(void* \```data```)
Must be called before any function starting with ```vhalI2C```.


### vhalI2CInit(uint32_t* i2c*, vhalI2CConf* \```conf```)
Initialize the I2C bus corresponding to the ```i2c``` peripheral index with configuration parameters taken from ```conf```.

Return 0 on success.


### vhalI2CDone(uint32_t* i2c*)
Deactivates ```i2c```.


### vhalI2CLock(uint32_t* i2c*)
Lock the I2C bus. To be used when multiple threads share the same bus.


### vhalI2CUnlock(uint32_t* i2c*)
Unlock the I2C bus. To be used when multiple threads share the same bus.


### vhalI2CRead(uint32_t* i2c*, uint8_t\** buf*, uint32_t* len*, uint32_t* timeout*)
Start reading from ```i2c``` (from configured ```addr```). Execution ends as soon as one of the following conditions verifies:


* after a message of ```len``` bytes has been read and transferred to ```buf```


* an error occurs on the bus


* the bus is inactive for a time equal to ```timeout```

Return 0 on success.


### vhalI2CTransmit(uint32_t* i2c*, uint8_t\** tx*, uint32_t* txlen*, uint8_t* \```rx```, uint32_t* rxlen*, uint32_t* timeout*)
Execute a two steps communication. First, ```txlen``` bytes from ```tx``` are written to the bus; second, ```rxlen``` bytes are read from the bus to ```rx```.

Execution ends as soon as one of the following conditions verifies:


* both write and read steps are executed without errors


* an error occurs on the bus


* the bus is inactive for a time equal to ```timeout```

Return 0 on success.


### vhalI2CWrite(uint32_t* i2c*, uint8_t\** tx*, uint32_t* txlen*, uint32_t* timeout*)
Implemented as a macro calling *vhalI2CTransmit(i2c,tx,txlen,NULL,0,timeout)*.


### vhalI2CSetAddr(uint32_t* i2c*, uint16_t* addr*)
Change the peripheral address associated with ```i2c``` in `vhalI2CInit()` to ```addr```.

## SPI

Serial Peripheral Interface is one of the most used communication standards in embedded systems. Many microcontroller allow the SPI bus to be configured as master or as slave; the current version of VHAL supports master mode only.


### vhalSpiConf()
The following structure is used to configure the SPI bus:

```
typedef struct _vhal_spi_conf {
  uint32_t clock;
  uint16_t miso;
  uint16_t mosi;
  uint16_t sclk;
  uint16_t nss;
  uint8_t mode;
  uint8_t bits;
  uint8_t master;
  uint8_t msbfirst;
} vhalSpiConf;
```

The meaning of vhalSpiConf members is:


* ```clock```: the number of Hz the SPI bus will be clocked to.


* ```miso```, ```mosi```, ```sclk```, ```nss```: virtual pins representing the four wires used by the bus. ```nss``` is also called *slave select* or *chip select* in datasheets.


* ```mode```: configuration parameters for polarity and phase


* ```bits```: number of data bits


* ```master```: not used yet


* ```msbfirst```: if non-zero, data is transferred with the most significant bits first.

### Macros


### SPI_MODE_LOW_FIRST()
Low polarity (idle low), phase zero (bits captured on the first clock edge)


### SPI_MODE_LOW_SECOND()
Low polarity (idle low), phase one (bits captured on the second clock edge)


### SPI_MODE_HIGH_FIRST()
High polarity (idle high), phase zero (bits captured on the first clock edge)


### SPI_MODE_HIGH_SECOND()
High polarity (idle high), phase one (bits captured on the second clock edge)


### SPI_BITS_8()
Data is transferred 8 bits at time


### SPI_BITS_16()
Data is transferred 16 bits at time


### SPI_BITS_32()
Data is transferred 32 bits at time

### Functions


### vhalInitSPI(void* \```data```)
Must be called before any function starting with ```vhalSpi```.


### vhalSpiInit(uint32_t* spi*, vhalSpiConf* \```conf```)
Initialize the SPI bus identified by the peripheral index ```spi``` with configuration parameters taken from ```conf```.

Return 0 on success.


### vhalSpiLock(uint32_t* spi*)
Lock the SPI bus. To be used when multiple threads share the same bus.


### vhalSpiUnlock(uint32_t* spi*)
Unlock the SPI bus. To be used when multiple threads share the same bus.


### vhalSpiSelect(uint32_t* spi*)
Select the SPI peripheral connected to ```nss```.


### vhalSpiUnselect(uint32_t* spi*)
Unselect the SPI peripheral connected to ```nss```.


### vhalSpiExchange(uint32_t* spi*, void* \```tosend```, void* \```toread```, uint32_t* blocks*)
Start a SPI communication on ```spi```, exchanging a number of data frames equal to ```blocks```. Size of data frame is configured with SPI_BITS macros.

Data is exchanged synchronously; bytes in ```tosend``` are written to MOSI while bytes incoming on MISO are stored in ```toread```. If ```toread``` is NULL, incoming bytes are ignored (pure write). If ```tosend``` is NULL, nothing is written (pure read). If both ```toread``` and ```tosend``` are NULL, bytes on the bus are skipped.

Return 0 on success.


### vhalSpiDone(uint32_t* spi*)
Deactivate ```spi```.

### Macros


### QSPI_MODE_LOW_FIRST()
Low polarity (idle low), phase zero (bits captured on the first clock edge)


### QSPI_MODE_LOW_SECOND()
Low polarity (idle low), phase one (bits captured on the second clock edge)


### QSPI_MODE_HIGH_FIRST()
High polarity (idle high), phase zero (bits captured on the first clock edge)


### QSPI_MODE_HIGH_SECOND()
High polarity (idle high), phase one (bits captured on the second clock edge)

## NFO

Nfo functions retrieve the unique identifier of a microcontroller.


### vhalNfoGetUIDStr(void)
Return the unique identifier represented as a hex string.


### vhalNfoGetUID(uint8_t* \```buf```)
Return the unique identifier as bytes in ```buf```


### vhalNfoGetUIDLen(void)
Return the length in bytes of the unique identifier. The length of the corresponding hex string is exactly two times.

## FLASH

Microcontrollers usually have a non volatile storage memory  (flash memory) to hold code. These memories are usually organized in sectors or blocks, each of which can be erased and written indipendently of others.


### vhalFlashErase(void* \```addr```, uint32_t* size*)
Erase sector starting at ```addr``` for ```size``` bytes. If ```size``` is greater than the sector length, following sectors are erased.

Return 0 on success.


### vhalFlashWrite(void* \```addr```, uint8_t* \```data```, uint32_t* len*)
Write ```data``` starting at ```addr``` for ```len``` bytes. In many architectures, for vhalFlashWrite to work, the sectors must be erased first.

Return written bytes number.


### vhalFlashAlignToSector(void* \```addr```)
If ```addr``` points to the start of a sector, return ```addr```. Otherwise the start of the next sector is returned.

Return NULL on error.

## RNG

Random Number Generators are often implemented in hardware. When such MCU feature is missing, the VHAL provides a software implementation.


### vhalRngSeed(uint32_t* seed*)
Initialize the RNG with a seed. Must be called before using `vhalRngGenerate()`


### vhalRngGenerate(void)
Return a random 32 bits number.

## RTC

A Real-Time Clock (RTC) might be available on-board to keep passing time with great accuracy.


### vhalRTCInit(int* rtc*)
Initialize the RTC identified by the peripheral index ```rtc```.
Return 0 on success.


### vhalRTCGetUTC(int* rtc*, vhalRTCTimeInfo\** vhal_time_info*)
Fill ```vhal_time_info``` structure with time information retrieved from the RTC.

```
typedef struct _timeinfo {
    uint32_t tv_seconds;
    uint32_t tv_microseconds;

    uint32_t tm_sec;
    uint32_t tm_min;
    uint32_t tm_hour;
    uint32_t tm_mday;
    uint32_t tm_mon;
    uint32_t tm_year;
    uint32_t tm_wday;
    uint32_t tm_yday;
    uint32_t tm_isdst;
} vhalRTCTimeInfo;
```

Return 0 on success.


### vhalRTCSetUTC(int* rtc*, uint32_t* sec*, uint32_t* usec*)
Set an UTC reference for RTC identified by the peripheral index ```rtc``` passing reference Unix timestamp seconds and microseconds to obtain sub-second precision.
Return 0 on success.

## Interrupts

In most microcontrollers function to be called in response to an interrupt are stored in an interrupt table. Single interrupts can be enabled, disabled or given a priority (if supported).
To change the function called on interrupt, refer to `vosInstallHandler()`.


### vhalIrqEnablePrio(uint32_t* irqn*, uint32_t* prio*)
Enables the interrupt ```irqn``` assignign a priority of ```prio```. Priority must be passed with the PORT_PRIO_MASK macro defined in the microcontroller porting files.


### vhalIrqDisable(uint32_t* irqn*)
Disable interrupt ```irqn```


### vhalIrqEnable(uint32_t* irqn*)
Enable interrupt ```irqn``` assigning a default priority. Implemented as a macro.

## Error Codes

VHAL functions usually return an error code. The following list of macros contains most of the possible error codes. Some undocumented error codes are still returned in the current version.

Error code are non positive integers. They have been encoded in such a way that negating the error code results in the corresponding virtual machine exception number.


### VHAL_OK()
Evaluates to 0. Returned on success.


### VHAL_GENERIC_ERROR()
Generic peripheral error. Corresponds to PeripheralError exception.


### VHAL_INVALID_PIN()
A virtual pin not supporting a specific peripheral is passed. Corresponds to InvalidPin exception.


### VHAL_HARDWARE_STATUS_ERROR()
An hardware error condition happened during peripheral operations. Corresponds to InvalidHardwareStatus exception.


### VHAL_TIMEOUT_ERROR()
The peripheral operation reached a timeout condition. Corresponds to TimeoutError exception.


### VHAL_HARDWARE_INITIALIZATION_ERROR()
A peripheral error happened during initialization. Corresponds to HardwareInitializationError exception.

<!--stackedit_data:
eyJoaXN0b3J5IjpbOTAyODUyNzA1LC04NDUyNDU3NTksOTM0MT
A5MTExLDE3OTM2NTcwOTYsLTE3NzY2NjY2NzUsLTUxNjg3MTc0
MSwtMjEzMTgwOTUwMiwtMTQwNzg1NTY0MSwtMTU5NDg3NzU5My
wtMTYxNzY3OTcxMCwtMTY5MTk0MjE3NV19
-->
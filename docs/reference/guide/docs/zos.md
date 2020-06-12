# Virtual Machine

The core of Zerynth is the Zerynth Virtual Machine. Zerynth VM has been developed from scratch with the goal of bringing Python to the embedded world with support for multi-thread and cross board compatibility. More info on [Zerynth VM](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/vm.html#zerynthvm) section.

Contents:


* [The Zerynth Virtual Machine](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/vm.html)
    * [Zerynth and Python](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/vm.html#zerynth-and-python)
* [Operative System Abstraction Layer](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html)
    * [Types](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#types)
    * [Variables](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#variables)
    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#macros)
	    * [Time Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#time-macros)
	    * [Priority Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#priority-macros)
	    * [Thread Status](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#thread-status)
    * [Return values](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#return-values)
    * [System and Thread functions](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#system-and-thread-functions)
    * [Semaphores](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#semaphores)
    * [Mailboxes](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#mailboxes)
    * [System Timers](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#system-timers)
    * [Events](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vosal_h.html#events)
* [Hardware Abstraction Layer](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html)
    * [Pin Mapping](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#pin-mapping)
    * [Peripherals Mapping](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#peripherals-mapping)
	    * [GPIO](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#gpio)
    * [ADC](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#adc)
	    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id1)
	    * [Types](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#types)
    * [DAC](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#dac)
    * [PWM](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#pwm)
    * [ICU](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#icu)
	    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id2)
	    * [Functions](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id3)
    * [HTM](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#htm)
    * [SERIAL](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#serial)
	    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id4)
	    * [Functions](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id5)
    * [I2C](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#i2c)
    * [SPI](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#spi)
	    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id6)
	    * [Functions](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id7)
	    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#id8)
    * [NFO](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#nfo)
    * FLASH
    * RNG
    * RTC
    * Interrupts
    * Error Codes
* VM Interface
    * PObject
	    * Macros
	    * Functions
    * Numbers
	    * Functions
    * Bool & None
    * Sequences
	    * Macros
	    * Functions
    * Dictionaries and Sets
	    * Macros
	    * Functions
    * Exceptions

<!--stackedit_data:
eyJoaXN0b3J5IjpbNDkxODQ1MzA0LDE4OTg3MDE0MDIsLTk2Mz
M5MDMwXX0=
-->
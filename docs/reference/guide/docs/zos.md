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
 

    * Macros


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
         -    [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#macros)

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


    * NFO


    * [FLASH](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#flash)


    * [RNG](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#rng)


    * [RTC](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#rtc)


    * [Interrupts](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#interrupts)


    * [Error Codes](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___common_vhal_h.html#error-codes)


* [VM Interface](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html)


    * [PObject](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#pobject)
	    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#macros)
	    * [Functions](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#functions)


    * [Numbers](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#numbers)
	    * [Functions](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#id1)


    * [Bool & None](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#bool-none)


    * [Sequences](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#sequences)
	    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#id2)
	    * [Functions](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#id3)


    * [Dictionaries and Sets](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#dictionaries-and-sets)
	    * [Macros](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#id4)
	    * [Function](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#id5)
	


     * [Exceptions](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib___lang_lang_h.html#exceptions)

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzNjYzNDY5MTIsMzM5MTk3OTEyLDE4OT
g3MDE0MDIsLTk2MzM5MDMwXX0=
-->
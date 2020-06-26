# Secure Firmware

This module enables access to secure firmware functionalities specific to the target microcontroller.
It can be safely imported in every program, however its functions will raise UnsupportedError if the target VM is not enabled
for secure firmware features (**a premium VM with the OTA feature enabled is needed**).

There are many ways of securing the firmware running on a microcontroller:


* disable access to the flash memory wher the firmware resides with external means (e.g. JTAG probes)


* reserve some memory areas to critical parts of the system (e.g. VM running in mcu Trust Zones)


* detect device tampering and take action accordingly (e.g. erase firmware)


* detect and recover from firmware malfunctions (e.g. watchdogs)

Of the above features, only watchdogs are implemented in all architectures; the rest of features are strongly platform dependent.
This module allow access to the microcontroller watchdogs and will enable access to anti-tampering features soon.

## Bytecode integrity check

All secure firmware VMs execute an integrity check of the loaded bytecode and fail if one of the following two conditions is met:


* The calculated hash of the bytecode is not equal to the bytecode fingerprint


* The VM version is not the one the bytecode was compiled for

## Watchdogs

A Watchdog is usually implemented as a countdown timer that resets the microcontroller if it is not refreshed by firmware in a specified timeout period.
The action of refreshing the watchdog timer is often called “kicking” or “feeding” the watchdog. A windowed watchdog is a specially configured watchdog that resets the microcontroller
both on a normal timeout or on a kick that happens before a specified time from last refresh.

Visually:

```
Normal Watchdog time window
|----------------------------------------------|  --> a reset happens!
0                                              timeout
     A kick here restarts the watchdog

Windowed Watchodog
|............|---------------------------------|  --> a reset happens!
0            t1                                timeout
  A kick here           A kick here
  reset the mcu!        restarts the watchdog
```

Each microcontroller family has its own watchdog peculiarities, described in the following sections:


* STM32F families


* NXP K64 families


* Microchip SAMD21


* Espressif ESP32

This module provides the following functions for watchdog usage:


`watchdog(time0, timeout)`

Enable the watchdog. If `time0` is zero, the watchdog is configured in normal mode; if it is greater than zero, the watchdog is configured in windowed mode (if supported) in such a way that a kick in the first `time0` milliseconds resets the device.
`timeout` configures the number of milliseconds the whole watchdog window lasts. Once started, the watchdog CAN’T be stopped!


`kick()`

Refresh the watchdog, resetting its time window.


`watchdog_triggered()`

Return `True` if the microcontroller has been reset by the watchdog, `False` otherwise.

## Watchdogs for STM32Fxx families

For STM32 microcontrollers the watchdog is implemented using the IWDG. The maximum timeout is 32768 milliseconds and there is no support for windowed mode (an exception is raised if `time0` is greater than zero in `watchdog()`).
The watchdog is disabled in low power modes.

## Watchdogs for NXP K64 families

For K64 microcontrollers the watchdog is implemented using WDOG. The WDOG is clocked by the low power oscillator with a frequency of 1kHz.T The maximum timeout is around 74 hours and windowed mode is supported.
The watchdog is disabled in low power modes.

## Watchdogs for Microchip SAMD21

For SAMD21 microcontrollers the watchdog is implemented using WDT. The WDT is clocked by the ultra low power oscillator with a frequency of 1kHz. In normal mode the maximum timeout is 16 seconds. In windowed mode `timeout` can reach 32 seconds and `time0` 16 seconds; this is because windowed mode works with two timers, the first for `time0` and the second for `timeout`.
The timeout granularity of WDT is quite coarse, allowing only 12 different timeout values, expressed in WDT clock cycles:


* 8 cycles, 8 milliseconds


* 16 cycles, 16 milliseconds

…


* 16384 cycles, 16384 milliseconds

The `watchdog()` function will select the nearest allowed time rounding up with respect to the specified time.

## Watchdogs for ESP32 devices

Starting from version r2.2.0, the watchdog for ESP32 devices is implemented using the RTC watchdog. The maximum timeout is 2^31 milliseconds and there is no support for windowed mode (an exception is raised if time0 is greater than zero in watchdog()).

The RTC watchod is enabled by the bootloader and set to 30 seconds by default. This allows to recover from a faulty firmware that does not have time to configure
the watchdog at startup. However, when using a secure firmware VM it is mandatory to configure the watchdog in the first 30 seconds of execution.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1OTk0NTQ3MjRdfQ==
-->
# Hardware Timers

This module implements the interface to the hardware timers of the board, allowing a greater precision in time measuring or time constrained tasks.

Currently, only the sleep_micros function is implemented


---
#### `#!py3 sleep_micros()`

!!!abstract "`#!py3 sleep_micros(n)`"

Suspend the current thread for ```n``` microseconds by using the functionalities of an high precision
hardware timer. Currently, sleep_micros is not thread safe, and can’t be called simultaneously by more than one thread.

The actual amount of microseconds between the call and return of sleep_micros is usually greater than ```n``` due to the overhead of calling,
returning and thread switching.

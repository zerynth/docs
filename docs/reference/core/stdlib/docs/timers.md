# Software Timers

This module contain the `timer()` to handle time and timed events


---
#### `#!py3 now()`

!!!abstract "`#!py3 now()`"

Return the number of milliseconds since the start of the program.


---
#### `#!py3 timer()`

!!!abstract "`#!py3 timer()`"

Creates a new timer.


---
#### `#!py3 one_shot()`

!!!abstract "`#!py3 one_shot(delay, fun, arg=None)`"

Activates the timer in one shot mode. Function *fun(arg)* is executed only once after ```delay``` milliseconds.


---
#### `#!py3 interval()`

!!!abstract "`#!py3 interval(period, fun, arg=None)`"

Activates the timer in interval mode. Function *fun(arg)* is executed every ```period``` milliseconds.


---
#### `#!py3 clear()`

!!!abstract "`#!py3 clear()`"

Disable the timer.


---
#### `#!py3 destroy()`

!!!abstract "`#!py3 destroy()`"

Disable the timer and kills it.


---
#### `#!py3 start()`

!!!abstract "`#!py3 start()`"

Start the timer. A started timer begins counting the number of passing milliseconds. Such number can be read by calling
timer.get().


---
#### `#!py3 reset()`

!!!abstract "`#!py3 reset()`"

Reset the timer. A reset timer restarts counting the number of passing milliseconds from zero.

Returns the number of milliseconds passed since the start or the last reset.


---
#### `#!py3 get()`

!!!abstract "`#!py3 get()`"

Return the number of milliseconds passed since the start or the last reset.

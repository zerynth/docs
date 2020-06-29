# Software Timers

This module contain the `timer()` to handle time and timed events


**`now()`**

Return the number of milliseconds since the start of the program.


**`timer()`**

Creates a new timer.


**`one_shot(delay, fun, arg=None)`**

Activates the timer in one shot mode. Function *fun(arg)* is executed only once after ```delay``` milliseconds.


**`interval(period, fun, arg=None)`**

Activates the timer in interval mode. Function *fun(arg)* is executed every ```period``` milliseconds.


**`clear()`**

Disable the timer.


**`destroy()`**

Disable the timer and kills it.


**`start()`**

Start the timer. A started timer begins counting the number of passing milliseconds. Such number can be read by calling
timer.get().


**`reset()`**

Reset the timer. A reset timer restarts counting the number of passing milliseconds from zero.

Returns the number of milliseconds passed since the start or the last reset.


**`get()`**

Return the number of milliseconds passed since the start or the last reset.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjA5NzQ2MjMxNyw0MTAzMjI3OTFdfQ==
-->
# Software Timers

This module contain the `timer()` to handle time and timed events

###### now

```#!py3 now()```

Return the number of milliseconds since the start of the program.

###### timer

```#!py3 timer()```

Creates a new timer.

###### one_shot

```#!py3 one_shot(delay, fun, arg=None)```

Activates the timer in one shot mode. Function *fun(arg)* is executed only once after ```delay``` milliseconds.

###### interval

```#!py3 interval(period, fun, arg=None)```

Activates the timer in interval mode. Function *fun(arg)* is executed every ```period``` milliseconds.

###### clear

```#!py3 clear()```

Disable the timer.

###### destroy

```#!py3 destroy()```

Disable the timer and kills it.

###### start

```#!py3 start()```

Start the timer. A started timer begins counting the number of passing milliseconds. Such number can be read by calling
timer.get().

###### reset

```#!py3 reset()```

Reset the timer. A reset timer restarts counting the number of passing milliseconds from zero.

Returns the number of milliseconds passed since the start or the last reset.

###### get

```#!py3 get()```

Return the number of milliseconds passed since the start or the last reset.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk2ODQxNDMxMF19
-->
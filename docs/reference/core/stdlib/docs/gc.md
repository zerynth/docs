# Garbage Collector

This module allows the interaction with the garbage collector from Zerynth programs.

###### info

```#!py3 info()```

Returns a tuple of integers:


1. Total memory in bytes


2. Free memory in bytes


3. Memory fragmentation percentage


4. Number of allocated blocks


5. Number of free blocks


6. GC Period: milliseconds between forced collections


7. Milliseconds since last collection

###### collect

```#!py3 collect()```

Starts a collection

###### enable

```#!py3 enable(period=500)```

Activates the garbage collector with a GC Period of ```period``` milliseconds

###### disable

```#!py3 disable()```

Disable garbage collector
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTYxNzcyODk3OSwxMzE1NTY3MDIxXX0=
-->

# Garbage Collector

This module allows the interaction with the garbage collector from Zerynth programs.


---
#### `#!py3 info()`

!!!abstract "`#!py3 info()`"

Returns a tuple of integers:


1. Total memory in bytes


2. Free memory in bytes


3. Memory fragmentation percentage


4. Number of allocated blocks


5. Number of free blocks


6. GC Period: milliseconds between forced collections


7. Milliseconds since last collection


---
#### `#!py3 collect()`

!!!abstract "`#!py3 collect()`"

Starts a collection


---
#### `#!py3 enable()`

!!!abstract "`#!py3 enable(period=500)`"

Activates the garbage collector with a GC Period of ```period``` milliseconds


---
#### `#!py3 disable()`

!!!abstract "`#!py3 disable()`"

Disable garbage collector

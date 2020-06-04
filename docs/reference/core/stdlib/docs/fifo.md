# Fifo

This module implements no thread-safe fifo queues.
A fifo queue behaves in such a way that the first element inserted in the queue is also the first element to be removed (first in, first out).

## Fifo class


---
#### `#!py3 Fifo()`

!!!abstract "`#!py3 Fifo(size=16, only_bytes=False)`"

Create a Fifo instance with ```size``` “places” for items.
If ```only_bytes``` is True, the Fifo will use a bytearray to store bytes; if False it will use a list.


---
#### `#!py3 is_full()`

!!!abstract "`#!py3 is_full()`"

Return True if the fifo is full


---
#### `#!py3 is_empty()`

!!!abstract "`#!py3 is_empty()`"

Return True if the fifo is empty


---
#### `#!py3 put()`

!!!abstract "`#!py3 put(obj)`"

Insert ```obj``` into the fifo queue. Raise ```FifoFullError``` if the fifo is full.


---
#### `#!py3 get()`

!!!abstract "`#!py3 get()`"

Get an object out of the fifo queue. Raise ```FifoEmptyError``` if the fifo is empty.


---
#### `#!py3 peek()`

!!!abstract "`#!py3 peek()`"

Return the object at the head of the fifo queu without removing it. Raise ```FifoEmptyError``` if the fifo is empty.


---
#### `#!py3 put_all()`

!!!abstract "`#!py3 put_all(objs)`"

Put every item of ```objs``` into the fifo queue.


---
#### `#!py3 elements()`

!!!abstract "`#!py3 elements()`"

Return the number of items in the queue.


---
#### `#!py3 clear()`

!!!abstract "`#!py3 clear()`"

Clear the fifo by removing all elements

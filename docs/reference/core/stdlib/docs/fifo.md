# Fifo

This module implements no thread-safe fifo queues.
A fifo queue behaves in such a way that the first element inserted in the queue is also the first element to be removed (first in, first out).

## Fifo class


**`Fifo(size=16, only_bytes=False)`**

Create a Fifo instance with ```size``` “places” for items.
If ```only_bytes``` is True, the Fifo will use a bytearray to store bytes; if False it will use a list.


**`is_full()`**

Return True if the fifo is full


**`is_empty()`**

Return True if the fifo is empty


**`put(obj)`**

Insert ```obj``` into the fifo queue. Raise ```FifoFullError``` if the fifo is full.


**`get()`**

Get an object out of the fifo queue. Raise ```FifoEmptyError``` if the fifo is empty.


**`peek()`**

Return the object at the head of the fifo queu without removing it. Raise ```FifoEmptyError``` if the fifo is empty.


**`put_all(objs)`**

Put every item of ```objs``` into the fifo queue.


**`elements()`**

Return the number of items in the queue.


**`clear()`**

Clear the fifo by removing all elements
<!--stackedit_data:
eyJoaXN0b3J5IjpbNTc1NzU5NzE5LC0xNzc3OTg5NjU3XX0=
-->
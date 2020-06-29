# Queue

The queue module implements multi-producer, multi-consumer queues. It is especially useful in threaded programming when information must be exchanged safely between multiple threads. The Queue class in this module implements all the required locking semantics.

## Queue class


**`Queue(maxsize=0)`**

Constructor for a FIFO queue.  ```maxsize``` is an integer that sets the upperbound
limit on the number of items that can be placed in the queue.  Insertion will
block once this size has been reached, until queue items are consumed.  If
```maxsize``` is less than or equal to zero, the queue size is infinite.


**`qsize()`**

Return the approximate size of the queue.  Note, qsize() > 0 doesn’t
guarantee that a subsequent get() will not block, nor will qsize() < maxsize
guarantee that put() will not block.


**`full()`**

Return `True` if the queue is full, `False` otherwise.  If full()
returns `True` it doesn’t guarantee that a subsequent call to get()
will not block.  Similarly, if full() returns `False` it doesn’t
guarantee that a subsequent call to put() will not block.


**`empty()`**

Return `True` if the queue is empty, `False` otherwise.  If empty()
returns `True` it doesn’t guarantee that a subsequent call to put()
will not block.  Similarly, if empty() returns `False` it doesn’t
guarantee that a subsequent call to get() will not block.


**`put(obj, block=True, timeout=-1)`**

Insert ```obj``` into the queue. If the queue is full, and ```block``` is True, block until a free slot becomes available. If ```block``` is False, raise QueueFull.
If ```timeout``` is greater than zero, waits for the specified amount of milliseconds before raising QueueFull exception.


**`get()`**

Remove and return an object out of the queue. If the queue is empty, block until an item is available.


**`peek()`**

Return the object at the head of the queue without removing it. If the queue is empty, wait until an item is available.


**`clear()`**

Clear the queue by removing all elements.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTg2MzYzOTI3OSw2MTE0MDI3MDVdfQ==
-->
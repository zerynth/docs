# Queue

The queue module implements multi-producer, multi-consumer queues. It is especially useful in threaded programming when information must be exchanged safely between multiple threads. The Queue class in this module implements all the required locking semantics.

## Queue class


---
#### `#!py3 Queue()`

!!!abstract "`#!py3 Queue(maxsize=0)`"

Constructor for a FIFO queue.  ```maxsize``` is an integer that sets the upperbound
limit on the number of items that can be placed in the queue.  Insertion will
block once this size has been reached, until queue items are consumed.  If
```maxsize``` is less than or equal to zero, the queue size is infinite.


---
#### `#!py3 qsize()`

!!!abstract "`#!py3 qsize()`"

Return the approximate size of the queue.  Note, qsize() > 0 doesn’t
guarantee that a subsequent get() will not block, nor will qsize() < maxsize
guarantee that put() will not block.


---
#### `#!py3 full()`

!!!abstract "`#!py3 full()`"

Return `True` if the queue is full, `False` otherwise.  If full()
returns `True` it doesn’t guarantee that a subsequent call to get()
will not block.  Similarly, if full() returns `False` it doesn’t
guarantee that a subsequent call to put() will not block.


---
#### `#!py3 empty()`

!!!abstract "`#!py3 empty()`"

Return `True` if the queue is empty, `False` otherwise.  If empty()
returns `True` it doesn’t guarantee that a subsequent call to put()
will not block.  Similarly, if empty() returns `False` it doesn’t
guarantee that a subsequent call to get() will not block.


---
#### `#!py3 put()`

!!!abstract "`#!py3 put(obj, block=True, timeout=-1)`"

Insert ```obj``` into the queue. If the queue is full, and ```block``` is True, block until a free slot becomes available. If ```block``` is False, raise QueueFull.
If ```timeout``` is greater than zero, waits for the specified amount of milliseconds before raising QueueFull exception.


---
#### `#!py3 get()`

!!!abstract "`#!py3 get()`"

Remove and return an object out of the queue. If the queue is empty, block until an item is available.


---
#### `#!py3 peek()`

!!!abstract "`#!py3 peek()`"

Return the object at the head of the queue without removing it. If the queue is empty, wait until an item is available.


---
#### `#!py3 clear()`

!!!abstract "`#!py3 clear()`"

Clear the queue by removing all elements.

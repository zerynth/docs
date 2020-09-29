# Bignum

This module provides function and classes to operate on arbitrary precision integers.
It is based on the very perfomant library [TomMath](https://github.com/libtom/libtommath) slightly
modified to be compatible with Zerynth memory manager.

## The Bignum class



`BigNum(val=0)`

This class represents a big integer number with arbitrary precision. A big number instance can be initialized with
a value ```val```. ```val``` can be a standard integer or a string representing the number. The string is accepted if it is in base 16
prefixed with  ‘0x’ or in base 10. Signed number are accepted. At the moment, bytearray or bytes representation are not supported.

BigNum instances are compatible with streams and, if printed, are automatically converted to the base 10 string format.

BigNum instances are easy to use:

``` python
from bignum import bignum as bg
import streams

streams.serial()

big = bg.BigNum("1234567890987654321")
one = bg.BigNum(1)

while True:
    print(big)
    big.iadd(one)
    sleep(1000)
```

###### add

```#!py3 add(b)```

Return a new big number instance equal to the addition of the current instance and ```b```.

###### iadd

```#!py3 iadd(b)```

Add to the current instance the big number ```b```. Return `None`

###### sub

```#!py3 sub(b)```

Return a new big number instance equal to the difference of the current instance and ```b```.

###### isub

```#!py3 isub(b)```

Subtracts to the current instance the big number ```b```. Return `None`

###### mul

```#!py3 mul(b)```

Return a new big number instance equal to the multiplication of the current instance and ```b```.

###### imul

```#!py3 imul(b)```

Multiply the current instance for the big number ```b```. Return `None`

###### div

```#!py3 div(b)```

Return a new big number instance equal to the division of the current instance by ```b```.

###### idiv

```#!py3 idiv(b)```

Divides the current instance for the big number ```b```. Return `None`

###### mod

```#!py3 mod(b)```

Return a new big number instance equal to the remainder of the division of the current instance by ```b```.

###### imod

```#!py3 imod(b)```

Set the current instance to the remainder of the division by ```b```. Return `None`

###### divmod

```#!py3 divmod(b)```

Return a tuple (q,r) of new big number instances representing the quotient ```q``` and the remainder ```r``` of the division of the current instance by ```b```.

..method:: eq(b)

Return True if the current instance is equal to the big number ```b```, False otherwise.

..method:: lt(b)

Return True if the current instance is less than the big number ```b```, False otherwise.

..method:: gt(b)

Return True if the current instance is greater than the big number ```b```, False otherwise.

..method:: lte(b)

Return True if the current instance is less than or equal to the big number ```b```, False otherwise.

..method:: gte(b)

Return True if the current instance is greater than or equal to the big number ```b```, False otherwise.

..method:: sign()

Return 1 if the current instance is a positive number, -1 if the current instance is a negative number, 0 if it is equal to zero.

###### to_base

```#!py3 to_base(base)```

Return a string representation of the big number in base ```base```. Allowed values for ```base``` are in the range 2..64.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE2NjE5NzUwMThdfQ==
-->
# RLP

This module implements the RLP encoding scheme for the Ethereum protocol.


---
#### `#!py3 encode()`

!!!abstract "`#!py3 encode(obj)`"


* ```Arguments```

    
    * ```obj``` – the object to encode

    Return the RLP representation of ```obj```.
    Only lists, tuples, strings, bytes/bytearrays and integers are allowed as types for ```obj```.

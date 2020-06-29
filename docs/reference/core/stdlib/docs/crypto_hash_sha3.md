<!-- module: sha3 -->
# SHA3 secure hash

This module implements the interface to NIST’s secure hash algorithm, known as SHA-3.
It is used in the same way as all crypto hash modules: an instance of the SHA3 class is
created, then feed this object with arbitrary strings/bytes using the update() method, and at any point you can ask it for the digest of the
concatenation of the strings fed to it so far.

The class supports 4 variants of SHA3, selectable in the constructor with one of the following constants:


* `SHA224`


* `SHA256`


* `SHA284`


* `SHA512`

## The module is based on the C library [cifra](https://github.com/ctz/cifra).

## The SHA3 class


`class SHA3(hashtype=SHA256)`
This class allows the generation of SHA3 hashes. It is thread safe. By default, it calculates the SHA256 variant
of SHA3. This behaviour can be changed by passing a different value for ```hashtype```


**`update(data)`**
Update the sha object with the string ```data```. Repeated calls are equivalent to a single call with the concatenation of all
the arguments: m.update(a); m.update(b) is equivalent to m.update(a+b).


**`digest()`**
Return the digest of the strings passed to the update method so far. This is a byte object with length depending on
the SHA3 variant.


**`hexdigest()`**
Like digest except the digest is returned as a string containing only hexadecimal digits.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE3OTQxNDQ1MCwtMTc2NDg5NTM3NF19
-->
<!-- module: sha2 -->
# SHA2 secure hash

This module implements the interface to NIST’s secure hash algorithm, known as SHA-2.
It is used in the same way as all crypto hash modules: an instance of the SHA2 class is
created, then feed this object with arbitrary strings/bytes using the update() method, and at any point you can ask it for the digest of the
concatenation of the strings fed to it so far.

The class supports 4 variants of SHA2, selectable in the constructor with one of the following constants:


* `SHA224`


* `SHA256`


* `SHA284`


* `SHA512`

## The module is based on the C library [cifra](https://github.com/ctz/cifra).

## The SHA2 class

##### class SHA2

```#!py3 class SHA2(hashtype=SHA256)```

This class allows the generation of SHA2 hashes. It is thread safe. By default, it calculates the SHA256 variant
of SHA2. This behaviour can be changed by passing a different value for ```hashtype```

###### SHA2.update

```#!py3 update(data)```
Update the sha object with the string ```data```. Repeated calls are equivalent to a single call with the concatenation of all
the arguments: m.update(a); m.update(b) is equivalent to m.update(a+b).

###### SHA2.digest

```#!py3 digest()```
Return the digest of the strings passed to the update method so far. This is a byte object with length depending on
the SHA2 variant.

###### SHA2.hexdigest

```#!py3 hexdigest()```
Like digest except the digest is returned as a string containing only hexadecimal digits.

<!--stackedit_data:
eyJoaXN0b3J5IjpbOTQ1ODAzOTI3XX0=
-->
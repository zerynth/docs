<!-- module: sha1 -->
# SHA1 secure hash

This module implements the interface to NIST’s secure hash algorithm, known as SHA-1. SHA-1 is an improved version of
the original SHA hash algorithm. It is used in the same way as all crypto hash modules: an instance of the SHA class is
created, then feed this object with arbitrary strings/bytes using the update() method, and at any point you can ask it for the digest of the
concatenation of the strings fed to it so far.

The module is based on the C library [cifra](https://github.com/ctz/cifra).

## The SHA1 class

##### class SHA1

```#!py3 class SHA1()```

This class allows the generation of SHA1 hashes. It is thread safe.

###### SHA1.update

```#!py3 update(data)```

Update the sha object with the string ```data```. Repeated calls are equivalent to a single call with the concatenation of all
the arguments: m.update(a); m.update(b) is equivalent to m.update(a+b).

###### SHA1.digest

```#!py3 digest()```

Return the digest of the strings passed to the update method so far. This is a 20-byte bytes object.

###### SHA1.hexdigest

```#!py3 hexdigest()```

Like digest except the digest is returned as a string of length 40, containing only hexadecimal digits.

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE5OTE0ODEyNV19
-->
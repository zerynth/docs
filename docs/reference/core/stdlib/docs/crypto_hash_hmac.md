# HMAC

This module implements the HMAC algorithm as described by [RFC 2104](https://tools.ietf.org/html/rfc2104.html).

The module is based on the C library [cifra](https://github.com/ctz/cifra).

###### HMAC

```#!py3 HMAC(key, hashfn)```

Return a new hmac object. ```key``` is a bytes or bytearray or string object giving the secret key. ```hashfn``` is an
instance of a hash function to use in hmac generation. It supports any class in the `crypto.hash` module.

###### update

```#!py3 update(data)```

Update the hmac object with the string ```data```. Repeated calls are equivalent to a single call with the concatenation of all
the arguments: m.update(a); m.update(b) is equivalent to m.update(a+b).

###### digest

```#!py3 digest()```

Return the digest of the strings passed to the update method so far. The size depends on ```hashfn```.

###### hexdigest

```#!py3 hexdigest()```

Like digest except the digest is returned as a string containing only hexadecimal digits.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjIxMjg0ODk4LC0zOTg4NjAzODJdfQ==
-->

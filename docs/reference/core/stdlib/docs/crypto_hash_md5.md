<!-- module: md5 -->
# MD5 secure hash

This module implements the interface to MD5 secure hash algorithm.
It is used in the same way as all crypto hash modules: an instance of the MD5 class is
created, then feed this object with arbitrary strings/bytes using the update() method, and at any point you can ask it for the digest of the
concatenation of the strings fed to it so far.

## The MD5 class


### class MD5()
This class allows the generation of MD5 hashes. It is thread safe.


### update(data)
Update the md5 object with the string ```data```. Repeated calls are equivalent to a single call with the concatenation of all
the arguments: m.update(a); m.update(b) is equivalent to m.update(a+b).


### digest()
Return the digest of the strings passed to the update method so far. This is a 16-byte bytes object.


### hexdigest()
Like digest except the digest is returned as a string of length 32, containing only hexadecimal digits.

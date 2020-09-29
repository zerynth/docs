# Elliptic Curve Cryptography

This module offer cryptographic primitives based on Elliptic Curves. In particular it provides key generation and validation, signing, and verifying, for the following curves:


* secp160r1


* secp192r1 (NISTP192)


* secp224r1 (NISTP224)


* secp256r1 (NISTP256)


* secp256k1 (used by Bitcoin)

For an awesome introduction to ECC check [here](https://www.johannes-bauer.com/compsci/ecc/).
For an online ECC calculator check [here](http://extranet.cryptomathic.com/ecc/index)

The module is based on [MicroECC](https://github.com/kmackay/micro-ecc) patched with functions to enable public key recovery (mainly for blockchain applications).

The module defines the following constants defining curves:


* `SECP160R1`


* `SECP192R1`


* `SECP224R1`


* `SECP256R1`


* `SECP256K1`

###### make_keys

```#!py3 make_keys(curve)```

Return a tuple of two elements. The first element is a byte object
containing the uncompressed representation of the generated public key. The
second element is a byte object containing the representation of the
generated public key. ```curve``` specifies the curve to use

This function uses the random number generator provided by the
VM. For real world usage and enhanced security the random number generator
must be of cryptographic quality (generally implemented in hardware).

###### check_public_key

```#!py3 check_public_key(curve, pbkey)```

Return `True` if ```pbkey``` (in uncompressed format) is a valid public
key for ```curve```.

###### derive_public_key

```#!py3 derive_public_key(curve, pvkey)```

Return a byte object containing the uncompressed representation of the
public key matching ```pvkey``` for curve ```curve```.

Raise `ValueError` if derivation is not possible.

###### compress_key

```#!py3 compress_key(curve, key)```

Return a compressed representation of ```key```.

###### decompress_key

```#!py3 decompress_key(curve, key)```

Return a uncompressed representation of ```key```.

###### verify

```#!py3 verify(curve, message, signature, pbkey)```

Return `True` if ```signature``` is a valid signature for message
```message``` given ```curve``` and a public key ```pbkey```.

###### sign

```#!py3 sign(curve, message, pvkey, deterministic = False, recoverable = False)```

Return the signature of ```message``` with ```pvkey``` for curve ```curve```. Usually
the message to sign is not the entire message but a hash of it. The
```deterministic``` parameter, if given, creates a deterministic signature
according to [RFC6979](https://tools.ietf.org/html/rfc6979) . If given, the ```deterministic``` parameter must be an
instance of a hash class from module `crypto.hash`. Deterministic signatures are not dependent on a good
random number generator for their security and can therefore be used in hardware without such capabilities. If ```recoverable``` is given and True, the returned object is a tuple such that the first element is the recovery id and the second element is the signature. The recovery id is a parameter that can be used to derive the public key from a just a valid signature. For more info refer to [this paper](https://www.secg.org/sec1-v2.pdf).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTM0OTA0MTUxMl19
-->
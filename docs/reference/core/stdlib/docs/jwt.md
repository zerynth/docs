# JSON Web Tokens

This module allows handling [JSON Web Tokens](https://tools.ietf.org/html/rfc7519) from Zerynth programs.


### encode(payload, key)
Encode a JWT for target `payload` signed with `key`.

Currently only ES256 encoding algorithm using prime256v1 curve is supported.

`key` must be an ECDSA private key in hex format.
If a private key is, for example, stored as a pem file, the needed hex string can be extracted from the OCTET STRING field associated value obtained from

```
openssl asn1parse -in my_private.pem
```

command (since pem is a base64 encoded, plus header, [DER](https://tools.ietf.org/html/rfc5915)).

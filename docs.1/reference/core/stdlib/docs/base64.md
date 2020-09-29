# Base64

This module provides functions for encoding binary data to printable
ASCII characters and decoding such encodings back to binary data.
It provides some of the encoding and decoding functions for the encodings specified in
[**RFC 3548**](https://tools.ietf.org/html/rfc3548.html), which defines the Base64 algorithm.

The [**RFC 3548**](https://tools.ietf.org/html/rfc3548.html) encodings are suitable for encoding binary data so that it can
safely sent by email, used as parts of URLs, or included as part of an HTTP
POST request.

###### standard_b64encode

```#!py3 standard_b64encode()```

###### standard_b64encode

```#!py3 standard_b64encode(s)```

Encode ```s``` (either bytes, bytearray or string) using the standard Base64 alphabet and return the encoded object as bytes.

###### standard_b64decode

```#!py3 standard_b64decode()```

###### standard_b64decode

```#!py3 standard_b64decode(s)```

Decode ```s``` (either bytes, bytearray or string) using the standard Base64 alphabet and return the decoded object as bytes.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzMjEzMTAxNjZdfQ==
-->
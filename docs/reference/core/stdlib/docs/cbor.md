# CBOR

This module define functions to serialize and deserialize objects to and from [CBOR](http://cbor.io) format.
The serialization and deserialization of objects is performed using a wrapped version of the awesome and lighting fast [libcbor](http://libcbor.org/)

###### loads

```#!py3 loads(data)```

Returns a Python object represented by the byte sequence ```data```.
For CBOR specific structures such as ```tags``` and ```undefined``` values,
the function returns instances of the `Tag()` and `Undefined()` classes.

Raises `ValueError` when ```data``` contains bad or unsupported CBOR.

###### dumps

```#!py3 dumps(obj)```

Returns a bytes object containing the CBOR representation of ```obj```.
If a Python object is not serializable to CBOR, it is serialized to `Undefined()`.
The function always produces definite major types (bytestrings, string, arrays and maps).
To generate CBOR specific structures such as ```tags``` and ```undefined``` values, pass as argument instances
of the `Tag()` and `Undefined()` classes.

Raises `RuntimeError` when ```obj``` can’t be serialized.

## Tag class

###### Tag

```#!py3 Tag(tag, value)```

Create a Tag instance. Tag instances have two attributes, `tag` and `value` that can be manually changed if needed.
`tag` must be an integer while `value` can be any CBOR serializable python object.
An instance of this class is returned during deserialization if a tag is found.

## Undefined class

###### Undefined

```#!py3 Undefined()```

Create an Undefined instance. Since Python has no undefined values, this class is used to both serialize and deserialize this kind of data.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwMjYyMTI0NTMsMjg3NTU0ODQzXX0=
-->

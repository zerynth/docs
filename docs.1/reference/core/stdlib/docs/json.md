# JSON

This module define functions to serialize and deserialize objects to and from [JSON](http://json.org) format.
The deserialization of objects is performed using a wrapped version of the awesome and lighting fast [JSMN library](http://zserge.com/jsmn.html)

###### dumps

```#!py3 dumps(obj)```

Returns a bytearray containing the JSON representation of ```obj```.

Raises `JSONError` when ```obj``` contains non serializable objects.

###### loads

```#!py3 loads(data)```

Returns the object represented in JSON format inside the byte sequence ```data```.

Raises `JSONError` when ```data``` contains bad JSON.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTQwMzY3NzUzNl19
-->
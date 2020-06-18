# Mozilla WebThing library.

# Thing class


**`class Thing`**

A Thing is an object exposing some REST API containing properties, actionsand events.


**`__init__(thing_id,name,description=None,base_url="/",timestamp_fn=None)`**

-	**thing_id** is the unique id for a Thing.
-	**name** is pretty name for human interfaces.
-	**description** is a human readable description of this Thing.
-	**base_url** is the base path, configurable for advanced purposes.
-	**timestamp_fn** is a function to call for retrieving a timestamp string to be used in events generation.

Store a webserver instance for using it later when an action is created. ..  method:: add_property(prop_id, label, prop_type, getter, setter=None, unit=None, description=None)

Add a new property to this thing.


prop_id is a string for identifying uniquely a property

label is a pretty name for this property


* ```prop_type``` can be one of [“integer”, “number”, “boolean”].


* ```getter``` is a function that must return current status of this property


* ```setter``` is a function that must accept new status as a parameter and set it


* ```unit``` is a pretty name for the measure unit of this property


* ```description``` is a human readable description of this property


### add_action(act_id, label, callback, input_type=None, description=None)
Add a new action to this thing.


* ```act_id``` is a string for identifying uniquely an action


* ```label``` is a pretty name for this action


* ```input_type``` can be one of [“integer”, “number”, “boolean”].


* ```callback``` is a function that must accept a parameter of input_type and use it


* ```description``` is a human readable description of this action


### register_event(evt_id, description)
Register a new event type to this Thing.


* ```evt_id``` is a string for identifying uniquely this event type.


* ```description``` is a human readable description for this event.


### signal_event(evt_id, inp_data=None)
Log a new event of type evt_id.


* ```evt_id``` is a string for choosing a registered event type.


* ```inp_data``` is an optional argument for this event type.


### as_dict()
Return a dict representing this Thing.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc4MzIzNTUyMiwtMTMwNDIwODc2MF19
-->
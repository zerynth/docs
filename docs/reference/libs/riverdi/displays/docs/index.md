<!-- _lib.riverdi.displays -->
# Riverdi Displays

Riverdi Display Modules are high-quality cost-effective displays for use in consumer or industrial applications.
Its displays are usually powered by graphics controllers.

This library includes modules to be imported to automatically set the right configuration for a chosen display powered by a graphics controller supported by Zerynth.

For example to start programming a Riverdi display `mydisplay` with controller `mycontroller` from producer `myproducer`, the following lines are sufficient:

```py
from riverdi.displays.mycontroller import mydisplay
from myproducer.mycontroller import mycontroller
```

Below a list of supported controllers and available displays:


* Bridgetek BT81x (bridgetek.bt81x)


> 
>     * Riverdi Capacitive 5” (ctp50)


>     * Riverdi Capacitive 7” (ctp70)


>     * Riverdi Resistive 5” (rtp50)


>     * Riverdi Resistive 7” (rtp70)
<!--stackedit_data:
eyJoaXN0b3J5IjpbODI5MTc2OTc0XX0=
-->
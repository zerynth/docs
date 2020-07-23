# Modem

This module provides uniform access to Polaris on-board modem, which may vary on different board variants.

###### init

```#!py3 init()```

Initializes the correct Modem library for the current Polaris target board variant and returns the module object.


**Returns:** `quectel.m95.M95` for *Polaris 2G*, `quectel.ug96.UG96` for *Polaris 3G*, `quectel.bg96.BG96` for *Polaris NB-IoT*.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTY5MTU0NjE0Ml19
-->

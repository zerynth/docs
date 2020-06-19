# Cloud Service

This module provides easy access to the Fortebit Cloud features.

**`getAccessToken(imei,uid)`**

Generates the board’s own access token for Fortebit IoT cloud services.


**Arguments:**
   
*	**imei** – The modem IMEI number (as a 15 characters string)
*	**uid** – The MCU unique identifier (as a 3 integers sequence)



**`isRegistered(device,email)`**

Check if the specified IoT device is registered to the Polaris Cloud services.

**Arguments:**
   
*	**device** – a connected instance of `fortebit.iot.Device`
*	**email** – the device owner’s email address



**`register(device,email)`**

Perform device registration to Polaris Cloud services.

**Arguments:**
   
*	**device** – a connected instance of `fortebit.iot.Device`
*	**email** – the device owner’s email address
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1MzI1OTcxN119
-->

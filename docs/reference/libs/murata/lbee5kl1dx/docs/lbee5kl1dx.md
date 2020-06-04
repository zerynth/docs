# LBEE5KL1DX Module

This module implements the lbee5kl1dx wifi driver. At the moment some functionalities are missing:


* soft ap


* wifi direct

It can be used with Cypress PSoC6 WiFi-BT Pioneer Kit.
`lbee5kl1dx` communication is based on the SDIO standard.

TLS support is available by means of Zeynth mbedTLS integration.
To enable it and allow the creation of TLS sockets using the Zerynth `ssl` module, place `ZERYNTH_SSL: true` inside your project `project.yml` file.


---
#### `#!py3 init()`

!!!abstract "`#!py3 init(country)`"


* ```Arguments```

    
    * ```contry``` – two-letter country code


Tries to init the lbee5kl1dx driver.


* **Raises PeripheralError**

    in case of failed initialization



---
#### `#!py3 auto_init()`

!!!abstract "`#!py3 auto_init(country="US")`"


* ```Arguments```

    
    * ```contry``` – two-letter country code


Tries to automatically init the lbee5kl1dx driver by looking at the device type.


* **Raises PeripheralError**

    in case of failed initialization

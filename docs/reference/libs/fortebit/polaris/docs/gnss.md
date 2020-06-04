# GNSS

This module provides uniform access to Polaris on-board GNSS receiver, which may vary on different board variants.


---
#### `#!py3 GNSS()`

!!!abstract "`#!py3 GNSS()`"

Creates an instance of the correct GNSS receiver class for the current Polaris target board variant.


* ```Returns```

    `quectel.l76.L76` for *Polaris 3G* and *Polaris 2G*, `quectel.bg96.BG96_GNSS` for *Polaris NB-IoT*

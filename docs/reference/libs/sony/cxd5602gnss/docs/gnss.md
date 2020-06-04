# Sony CXD5602 GNSS Module

This module implements the Zerynth driver for the Sony CXD5602 GNSS.
It allows configuring and retrieving data from the GNSS module mounted on the Sony Spresense board.


---
#### `#!py3 init()`

!!!abstract "`#!py3 init(start_mode=STMOD_HOT, sat_set=SAT_GPS|SAT_GLONASS, cycle=1000)`"


* ```Arguments```

    
    * ```start_mode``` – start mode


    * ```sat_set``` – set of GNSS satellites


    * ```cycle``` – positioning data evaluation cycle, must be multiple of 1000


Initializes and starts the GNSS system.
`start_mode` can be one of (with `TTFF` meaning `Time To First Fix`):


* `STMOD_COLD`: cold Start;


* `STMOD_WARM`: warm Start;


* `STMOD_WARM_ACC2`: warm Start, better accuracy, less `TTFF` than `WARM`;


* `STMOD_HOT`: hot Start;


* `STMOD_HOT_ACC`: hot Start, better accuracy, less `TTFF` than `HOT`;


* `STMOD_HOT_ACC2`: hot Start, better accuracy, less `TTFF` than `ACC`;


* `STMOD_HOT_ACC3`: optimized hot start, better `TTFF` than `HOT`;

For more details on the start mode to choose refer to the [official documentation](https://developer.sony.com/develop/spresense/developer-tools/get-started-using-nuttx/nuttx-developer-guide#_gnss).

`sat_set` is a bitmap containing the set of satellites to derive positioning data from.
Supported satellites are:


* `SAT_GPS`: GPS


* `SAT_GLONASS`: Glonass


* `SAT_SBAS`: SBAS


* `SAT_QZ_L1CA`: L1CA


* `SAT_IMES`: IMES


* `SAT_QZ_L1S`: L1S


* `SAT_BEIDOU`: BeiDou


* `SAT_GALILEO`: Galileo


* **Raise UnsupportedError**

    when cycle is not a multiple of 1000



* **Raise IOError**

    when initialization fails



---
#### `#!py3 deinit()`

!!!abstract "`#!py3 deinit()`"

Stops and de-initializes the GNSS system.


* **Raise IOError**

    when de-initialization fails



---
#### `#!py3 wait()`

!!!abstract "`#!py3 wait()`"

Waits for updated GNSS data to become available.


* **Raise IOError**

    when the operation fails



---
#### `#!py3 read()`

!!!abstract "`#!py3 read(read_filter=FILTER_RECEIVER_POSITION | FILTER_RECEIVER_DATETIME)`"


* ```Arguments```

    
    * ```read_filter``` – bitmap to filter data to be read to save RAM


Reads GNSS data.
To be called after `wait()` to be sure of reading updated data.

Returns a `GNSSData()` object filled according to selected filters.
Available filters are:


* `FILTER_TIMESTAMP`: fills `GNSSData.timestamp`


* `FILTER_RECEIVER_SATS`: fills `GNSSData.receiver.sats`


* `FILTER_RECEIVER_POSITION`: fills `GNSSData.receiver.position`, except for `GNSSData.receiver.position.precision`


* `FILTER_RECEIVER_POSITION_PRECISION`: fills `GNSSData.receiver.position`, including `GNSSData.receiver.position.precision`


* `FILTER_RECEIVER_DATETIME`: fills `GNSSData.receiver.datetime`


* `FILTER_RECEIVER`: fills `GNSSData.receiver`


* `FILTER_SATS_DATA`: fills `GNSSData.sats`


* **Raise IOError**

    when read fails, for example if `read()` is called immediately after         `init()` without waiting proper initialization time calling `wait()` function.



---
#### `#!py3 GNSSData()`

!!!abstract "`#!py3 GNSSData()`"

Class to store GNSS data retrieved by `read()` calls.

**N.B.** Each attribute might be filled depending on selected read filter.

List of attributes:


* `GNSSData.timestamp`: integer timestamp


* `GNSSData.receiver`: `Receiver()` instance


* `GNSSData.sats`: tuple of `SatelliteData()` instances


---
#### `#!py3 Receiver()`

!!!abstract "`#!py3 Receiver()`"

Class to store Receiver info retrieved by `read()` calls.

**N.B.** Each attribute might be filled depending on selected read filter.

List of attributes:


* `Receiver.sats`: `ReceiverSats()` instance


* `Receiver.position`: `ReceiverPosition()` instance


* `Receiver.datetime`: `ReceiverDatetime()` instance


---
#### `#!py3 ReceiverSats()`

!!!abstract "`#!py3 ReceiverSats()`"

Class to store Receiver Satellites info retrieved by `read()` calls.

**N.B.** Each attribute might be filled depending on selected read filter.

List of attributes:


* `ReceiverSats.numsv`: number of visible satellites


* `ReceiverSats.numsv_tracking`: number of tracking satellites


* `ReceiverSats.numsv_calcpos`: number of satellites to calculate the position


* `ReceiverSats.numsv_calcvel`: number of satellites to calculate the velocity


* `ReceiverSats.svtype`: used sv system, bitfield.                                 `bit0:GPS`, `bit1:GLONASS`, `bit2:SBAS`,                                 `bit3:QZSS_L1CA`, `bit4:IMES`,                                 `bit5:QZSS_L1SAIF`, `bit6:Beidu`,                                 `bit7:Galileo`


* `ReceiverSats.pos_svtype`: used sv system to calculate position, bitfield


* `ReceiverSats.vel_svtype`: used sv system to calculate velocity, bitfield


---
#### `#!py3 ReceiverPosition()`

!!!abstract "`#!py3 ReceiverPosition()`"

Class to store Receiver Position info retrieved by `read()` calls.

**N.B.** Each attribute might be filled depending on selected read filter.

List of attributes:


* `ReceiverPosition.type`: position type. `0:Invalid`, `1:GNSS`,                                `2:IMES`, `3:user set`, `4:previous`


* `ReceiverPosition.dgps`: `0:SGPS`, `1:DGPS`


* `ReceiverPosition.pos_fixmode`: `1:Invalid`, `2:2D`, `3:3D`


* `ReceiverPosition.vel_fixmode`: `1:Invalid`, `2:2D VZ`, `3:2D Offset`,                                `4:3D`, `5:1D`, `6:PRED`


* `ReceiverPosition.assist`: bit field `[7..5] Reserved` `[4] AEP Velocity`                                `[3] AEP Position` `[2] CEP Velocity`                                `[1] CEP Position`, `[0] user set`


* `ReceiverPosition.pos_dataexist`: `0:none`, `1:exist`


* `ReceiverPosition.possource`: position source. `0:Invalid`, `1:GNSS`,                                `2:IMES`, `3:user set`, `4:previous`


* `ReceiverPosition.tcxo_offset`: TCXO offset `[Hz]`


* `ReceiverPosition.latitude`: latitude `[degree]`


* `ReceiverPosition.longitude`: longitude `[degree]`


* `ReceiverPosition.altitude`: altitude `[m]`


* `ReceiverPosition.geoid`: geoid height `[m]`


* `ReceiverPosition.velocity`: velocity `[m/s]`


* `ReceiverPosition.direction`: direction `[degree]`


* `ReceiverPosition.precision`: `ReceiverPositionPrecision()` instance


---
#### `#!py3 ReceiverPositionPrecision()`

!!!abstract "`#!py3 ReceiverPositionPrecision()`"


* `ReceiverPositionPrecision.pos_dop`: `DOP()` instance


* `ReceiverPositionPrecision.vel_idx`: `DOP()` instance


* `ReceiverPositionPrecision.pos_accuracy`: `Variance()` instance


---
#### `#!py3 DOP()`

!!!abstract "`#!py3 DOP()`"

Class to store Dilution of Precision.


* `Dop.pdop`: position DOP


* `Dop.hdop`: horizontal DOP


* `Dop.vdop`: vertical DOP


* `Dop.tdop`: time DOP


* `Dop.ewdop`: East-West DOP


* `Dop.nsdop`: North-South DOP


* `Dop.majdop`: Stdev of semi-major axis


* `Dop.mindop`: Stdev of semi-minor axis


* `Dop.oridop`: orientation of semi-major axis `[deg]`


---
#### `#!py3 Variance()`

!!!abstract "`#!py3 Variance()`"

Class to store Variance.


* `Variance.hvar`: horizontal variance


* `Variance.vvar`: vertical variance

## Utils


---
#### `#!py3 double_to_dmf()`

!!!abstract "`#!py3 double_to_dmf(x)`"


* ```Arguments```

    
    * ```x``` – double to convert


Converts from double format to degree-minute-frac format.

Returns a tuple of four elements: `(sign, degree, minute, frac)`.

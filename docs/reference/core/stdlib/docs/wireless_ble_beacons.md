# BLE Beacons

This module implements utility functions to implement and scan iBeacons and Eddystone beacons.

Refer to BLE examples for usage.

## Module Functions


`eddy_encode_tlm(battery, temperature, count, time)`

Return a bytearray representing an encoded Eddystone payload of type tlm (not encrypted).

According to the specifications:


* `battery` is the battery charge in mV


* `temperature` is the beacon temperature in degrees. If None is give, temperature is set to -128


* `count` is the pdu count, the number of advertised packets


* `time` is the time in seconds since beacon power up


`eddy_encode_uid(namespace, instance, txpower)`

Return a bytearray representing an encoded Eddystone payload of type uid (not encrypted).

According to the specifications:


* `namespace` is a sequence of bytes of maximum length 10 (if less, it is zero padded to the right) representing the namespace of the uid


* `instance` is a sequence of bytes of maximum lengtth 6 (if less, it is zero padded to the right) representing the instance of the uid


* `txpower` is the power calibration measurement of the beacon (used to calculate distances)

`eddy_encode_url(url, txpower)`

Return a bytearray representing an encoded Eddystone payload of type url (not encrypted).

According to the specifications:


* `url` is a string representing an URL to be encoded in the Eddystone format


* `txpower` is the power calibration measurement of the beacon (used to calculate distances)


`eddy_decode_type(packet)`

Given `packet` as a bytes or bytearray return the type of the Eddystone packet or raises `ValueError` if it is not an Eddystone packet.

Return values are:


* `EDDY_LTM` for ltm packets


* `EDDY_UID` for uid packets


* `EDDY_URL` for url packets


`eddy_decode(packet)`

Given `packet` as a bytes or bytearray return a tuple with the packet decoded fields or raises `ValueError` in case `packet` is not Eddystone.

Return values are:


* a tuple with namespace, instance and txpower for uid packets


* a tuple with url and txpower for url packets


* a tuple with battery, temperature, count and time for tlm packets


`ibeacon_encode(uuid, major, minor, txpower, manufacturer=0x4c00)`

Return a bytearray representing an encoded iBeacon payload.

According to the specifications:


* `uuid` is a 16 bytes unique identifier


* `major` is the major version as integer


* `minor` is the minor version as integer


* `txpower` is the power calibration measurement of the beacon (used to calculate distances)


* `manufacturer` is set to Apple, but can be changed if needed


`ibeacon_decode(packet)`

Given `packet` as a bytes or bytearray return a tuple with the packet decoded fields or raises `ValueError` in case `packet` is not iBeacon.

Return value is a tuple with uuid, major, minor and txpower
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIxMjczMTI5ODNdfQ==
-->
# Device Configuration Zones

This module define the `DCZ()` class to simplify the management of provisioned device resources.

In the lifecycle of an IoT device is of the utter importance to have a strategy for the management of firmware independent resources such as certificates, private keys, configuration files, etc… These resources must be written into the device memory when the device is mass programmed and they usually change when the devices is first provisioned (i.e. when the device needs to store WiFi credentials). The management of these resources must be as safe as possible both in terms of robustness to error (i.e. corruption of memory) and security (i.e. credentials must always be stored at least in some encrypted fashion).

The Device Configuration Zones provided by Zerynth are regions of storage with the following properties:


* versioning: each resource can be replicated in up to 8 versioned slots in order to make the firmware always able to revert to the previous configuration, or recover from memory corruption
* encryption: an encryption mechanism is provided by the VM in order to store some sensitive data in an encryted way
* error checking: each DCZ and each DCZ resource is augmented with a checksum to immediately spot corruption or tampering of data
* serialization: resources included in a DCZ can be serialized and deserialized transparently with modules in the standard library (i.e. json and cbor) or by custom modules

The DCZ module works best when used with the Zerynth toolchain related commands, but can also be used standalone.

Device Confguration Zones are implemented as flash regions starting at specific addresses and containing:


* a checksum of the entire zone
* the size in bytes of the region
* the version number of the region
* the number of resources in the region
* the number of DCZ regions (replication number)
* a list of entries with the name, location, address and format of each provisioned resource

Up to 8 DCZ can be handled by this module. DCZs are stored like these:

```py
|    DCZ 0 @ 0x310000       |            |    DCZ 1 @ 0x311000       |
-----------------------------            -----------------------------
| Checksum     : 0xABCD1234 |            | Checksum     : 0xABCD1234 |
| Size         : 80         |            | Size         : 80         |
| Version      : 0          |            | Version      : 0          |
| Resources    : 1          |            | Resources    : 1          |
| Replication  : 2          |            | Replication  : 2          |
| --------------------------|            | --------------------------|
| Entry        : 0          |            | Entry        : 0          |
| Name         : cert       |            | Name         : cert       |
| Address      : 0x320000   |            | Address      : 0x330000   |
| checksum     : 0x2345BCDE |            | checksum     : 0x2345BCDE |
| format       : bin        |            | format       : bin        |
| size         : 1024       |            | size         : 1024       |
| --------------------------|            | --------------------------|
```

The above configuration has a replication factor of 2 (all resources are replicated twice), both the DCZs have the same version and contain an entry to a resource named “cert” (most probably a certificate). The certificate managed by DCZ 0 can be found at address 0x320000 while the certificate copy managed by DCZ 1 can be found at 0x330000.

If during the lifecyle of the device the certificate must be changed or renewed, the new version of the resource can be saved increasing its version number, reaching a state like this:

```py
|    DCZ 0 @ 0x310000       |            |    DCZ 1 @ 0x311000       |
-----------------------------            -----------------------------
| Checksum     : 0xABCD1234 |            | Checksum     : 0xFFFF0000 |
| Size         : 80         |            | Size         : 80         |
| Version      : 0          |            | Version      : 1          |
| Resources    : 1          |            | Resources    : 1          |
| Replication  : 2          |            | Replication  : 2          |
| --------------------------|  =======>  | --------------------------|
| Entry        : 0          |            | Entry        : 0          |
| Name         : cert       |            | Name         : cert       |
| Address      : 0x320000   |            | Address      : 0x330000   |
| checksum     : 0x2345BCDE |            | checksum     : 0xAAAABBBB |
| format       : bin        |            | format       : bin        |
| size         : 1024       |            | size         : 1120       |
| --------------------------|            | --------------------------|
```

The DCZs now store two different resources named “cert” but with different version number, size and checksum. If something goes wrong during certificate renewal, the device can always go back to the previous version of the DCZ and try again.

Increasing versions of resources are stored modulo the replication factor. In the case above, all odd numbered versions
will be handled by DCZ 1 while even numbered versions will be handled by DCZ 0.

At provisioning time, resources can be tagged as encrypted in the DCZ entries. Such resources are stored as a plaintext and are automatically encrypted by the VM the first time the DCZ module is initialized (usually at end of line testing). This is not the best possible security measure, but is a good alternative with respect to storing resources in the clear when a suitable secure storage hardware is not present.

DCZ module makes no assumption on the flash layout of the device, therefore when deciding addresses for DCZs and resources
the following criteria should be taken into consideration:


* choose addresses that are not in VM or bytecode areas
* choose addresses in such a way to accomodate the size of the resources in a non overlapping way (the size of a DCZ is 16 bytes plus 64 for each indexed resource)
* flash memories are often segmented in sectors that must be completely erased before writing to them. Organize resource and DCZs addresses in such a way that they do not share the same sector! Failing to do so will delete resources or DCZs when modifying the ones sharing the sector. The sector size may vary, consult the device flash layout map to choose correctly

## DCZ class

##### class DCZ

```#!py3 class DCZ(mapping, serializers={})```

Create an instance of the DCZ class providing the following arguments:


* `mapping`, a list of addresses where the various DCZ versions start (in ascending order of version). A max of 8 addresses can be given.
* `serializers`, a dict mapping format names to serialization/deserialization modules.

Format names are strings of at most 4 bytes, while serialization modules must provide a `.loads(bytes)` and `.dumps(obj)` to be used.

To use json and cbor:

```py
import json
import cbor
from dcz import dcz

dc = dcz.DCZ([0x310000,0x311000],{"json":json,"cbor":cbor})
```

After creation, the DCZ instance contain a `latest_version` field containing the highest available version of the stored DCZs.

!!! note
	All methods expecting an optional version number will operate the `latest_version` if no version is given, otherwise they will operate on the DCZ slot correspondent to the given version modulo the replication number.

###### DCZ.finalize

```#!py3 finalize()```

This method scans all the DCZs and all the resources. For each DCZ it calculates the checksum and checks it against the one in the DCZ. If they do not match the DCZ is marked as invalid. For each resource of valid DCZs that is marked as requiring encryption, the resource is read (in binary format), encrypted, stored back to its address and marked as encrypted.

This method is suggested to be run at end of line testing for each device that requires encrypted resources.

###### DCZ.load_resource

```#!py3 load_resource(resource, version=None, check=False, deserialize=True, decrypt=True)```

This is the method of choice to retrieve resources. It scans the DCZ identified by `version` and all its entries to find the one with the same name
specified by the parameter `resource`. If the `check` parameter is `True`, the `DCZChecksumError` is raised if the entry checksum in the DCZ is not the same as the calculated checksum of the resource data.

When `deserialize` is `True` an attempt to deserialize the resource data is made by passing it to the `.loads` method of the appropriate deserializer. The deserializer module is choosen by matching the resource format with the key of the `dcz.serializers`. If no deserializers can be found, `DCZMissingSerializerError` is raised. If deserialization is successful, the deserialized resource is returned. When `deserialize` is `False`, the binary representation of the resource is returned.

If no resource with name `resource` can be found, `DCZNoResourceError` is raised.


*`save_resource(resource, version=None, format="bin", serialize=True)`**

This is method is used to update resources.

It scans the DCZ identified by `version` and all its entries to find the one with the same name specified by the parameter `resource`. If `version` is not present, the DCZ matching the modulo operation with the replication number is selected and promoted to the new version.

When `serialize` is `True` an attempt to serialize the resource data is made by passing it to the `.dumps` method of the appropriate serializer. The serializer module is choosen by matching the `format` with the key of the `dcz.serializers`. If no serializers can be found, `DCZMissingSerializerError` is raised. If serialization is successful, the serialized resource is saved and the DCZ updated accordingly. When a resource is marked for encryption, the resource is automatically encrypted and stored.

If no resource with name `resource` can be found, `DCZNoResourceError` is raised.

Return a tuple with the resource address and the DCZ address

###### DCZ.get_header

```#!py3 get_header(version=None)```

Return a list containing the DCZ header:


* size
* version
* number of indexed resources
* checksum
* replication number

###### DCZ.get_entry

```#!py3 get_entry(i, version=None)```

Return the **ith** entry in the DCZ indentified by `version`

An entry is a list with:


* the name of the resource
* the list of all possible addresses of the resource
* the size of the resource
* the format of the resource
* the checksum of the resource
* a flag to 1 if encryption is required
* a flag to 1 if encryption has been performed
* the index of the entry in the DCZ
* the index of the DCZ

###### DCZ.load_entry

```#!py3 load_entry(entry)```

Return the raw binary data of the resource in `entry` as present on the flash (without decryption). An `entry` retrieved with [:method:`get_entry`](https://docs.zerynth.com/latest/official/lib.zerynth.dcz/docs/official_lib.zerynth.dcz_dcz.html#id1) must be given in order to identify the resource.

This method is exposed for custom usage of DCZ, but [:method:`load_resource`](https://docs.zerynth.com/latest/official/lib.zerynth.dcz/docs/official_lib.zerynth.dcz_dcz.html#id3) is recommended.

###### DCZ.save_entry

```#!py3 save_entry(entry, bin, new_version=None)```

Save data in `bin` as is (no encryption step) to the resource pointed by `entry` and update the corresponding DCZ. If `new_version` is given the corresponding DCZ will be updated and its version number set to `new_version`. If not given, the corresponding DCZ will be the one identified by `entry`.

Return the saved resource address and the address of the modified DCZ.

###### DCZ.search_entry

```#!py3 search_entry(resource, version=None)```

Search for a resource named `resource` in all DCZ and return a tuple with:


* resource address
* resource size
* resource format
* resource checksum
* encryption status

If no resource exists, `DCZNoResourceError` is raised.

###### DCZ.check_dcz

```#!py3 check_dcz(version=None)```

Return True if the DCZ identified by `version` is valid. It reads the DCZ from memory, calculates the checksum and check it against the stored one.

###### DCZ.is_valid_dcz

```#!py3 is_valid_dcz(version=None)```

Return True if the DCZ identified by `version` is valid. It looks up validity from the checks done after init.

###### DCZ.dump

```#!py3 dump(version=None, entries=False)```

Print information about DCZs. If `version` is not given, all DCZs are printed, otherwise only the specific `version`. If `entries` is given, additional information about each entry is given.

###### DCZ.versions

```#!py3 versions()```

Return the list of DCZ versions.

###### DCZ.resources

```#!py3 resources()```

Return the list of resource names.

###### DCZ.next_version

```#!py3 next_version()```

Return the next version greater than all current versions.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1MTY1MzA2MTddfQ==
-->

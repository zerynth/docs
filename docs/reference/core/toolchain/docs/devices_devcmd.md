# Devices

In the ZTC a device is a peripheral that can execute Zerynth bytecode. In order to do so a device must be prepared and customized with certain attributes.
The main attributes of a device are:


* `alias`, a unique name given by the user to the device in order to identify it in ZTC commands


* `uid`, a unique id provided by the operative system identifying the device at hardware level


* `target`, specifies what kind of virtual machine can be run by the device


* `name`, a human readable name describing the device. Automatically set by the ZTC


* `chipid`, the unique identifier of the microcontroller present on the device


* `remote_id`, the unique identifier of the device in the pool of user registered device


* `classname`, a Python class name identifying the class containing commands to configure the device

When a new device is connected, some steps must be taken in order to make it able to run Zerynth code:


1. The device must be discovered, namely its hardware parameters must be collected (`uid`).


2. Once discovered an `alias` must be assigned. Depending on the type of device `target` and `classname` can be assigned in the same step.


3. The device must be registered in order to create virtual machines for it (`chipid` and `remote_id` are obtained in this step)


4. The device must be :ref:`virtualized <ztc-cmd-device-virtualize>, namely a suited virtual machine must be loaded on the device microcontroller

Sometimes the device automatic recognition is not enough to gather all the device parameters or to allow the usage of JTAG/SWD probes. In such cases additional commands have been introduced in order to manually specify the additional parameters. A separate database of devices with advanced configurations is maintained.

List of device commands:


* discover


* alias put


* register


* register by uid


* register raw


* virtualize


* virtualize raw


* supported


* open


* open raw


* db list


* db put


* db remove

The list of supported devices is available here

## Discover

Device discovery is performed by interrogating the operative system database for USB connected peripherals. Each peripheral returned by the system has at least the following “raw” attributes:


* `vid`, the USB vendor id


* `pid`, the USB product id


* `sid`, the unique identifier assigned by the operative system, used to discriminate between multiple connected devices with the same `vid:pid`


* `port`, the virtual serial port used to communicate with the device, if present


* `disk`, the mount point of the device, if present


* `uid`, a unique identifier assigned by the ZTC


* `desc`, the device description provided by the operative system (can differ between different platforms)

Raw peripheral data can be obtained by running:

```py
ztc device discover
```

!!! note
	In Linux peripheral data is obtained by calling into libudev functions. In Windows the WMI interface is used. In Mac calls to ioreg are used.

Raw peripheral data are not so useful apart from checking the effective presence of a device. To obtain more useful data the option `-- matchdb` must be provided. Such option adds another step of device discovery on top of raw peripheral data that is matched against the list of supported devices and the list of already known devices.

A `--matchdb` discovery returns a different set of more high level information:


* `name`, the name of the device taken from the ZTC supported device list


* `alias`, the device alias (if set)


* `target`, the device target, specifying what kind of microcontroller and pcb routing is to be expected on the device


* `uid`, the device uid, same as raw peripheral data


* `chipid`, the unique identifier of the device microcontrolloer (if known)


* `remote_id`, the unique identifier of the device in the Zerynth backend (if set)


* `classname`, the Python class in charge of managing the device

All the above information is needed to make a device usable in the ZTC. The information provided helps in distinguishing different devices with different behaviours. A device without an `alias` is a device that is not yet usable, therefore an alias must be set. A device without `chipid` and `remote_id` is a device that has not been :ref:`registered <ztc-cmd-device-register> yet and can not be virtualized yet.

To complicate the matter, there are additional cases that can be spotted during discovery:


1. A physical device can match multiple entries in the ZTC supported device list. This happens because often many different devices are built with the same serial USB chip and therefore they all appear as the same hardware to the operative system. Such device are called “ambiguous” because the ZTC can not discriminate their `target`. For example, both the Mikroelektronika Flip&Click development board and the Arduino Due, share the same microcontroller and the same USB to serial converter and they both appear as a raw peripheral with the same `vid:pid`. The only way for the ZTC to differentiate between them is to ask the user to set the device `target`. For ambiguous devices the `target` can be set while setting the `alias`. Once the `target` is set, the device is disambiguated and subsequent discovery will return only one device with the right `target`.


2. A physical device can appear in two or more different configurations depending on its status. For example, the Particle Photon board has two different modes: the DFU modes in which the device can be flashed (and therefore virtualized) and a “normal” mode in which the device executes the firmware (and hence the Zerynth bytecode). The device appears as a different raw peripherals in the two modes with different `vid:pid`. In such cases the two different devices will have the same `target` and, once registered, the same `chipid` and `remote_id`. They will appear to the Zerynth backend as a single device (same `remote_id`), but the ZTC device list will have two different devices with different `alias` and different `classname`. The `classname` for such devices can be set while setting the alias. In the case of the Particle Photon, the `classname` will be “PhotonDFU” for DFU mode and “Photon” for normal mode. PhotonDFU is the `alter_ego` of Photon in ZTC terminology.


3. Some development boards do not have USB circuitry and can be programmed only through a JTAG or an external usb-to-serial converter. Such devices can not be discovered. To use them, the programmer device (JTAG or usb-to-serial) must be configured by setting `alias` and `target` to the ones the development device.

Finally, the ```discover``` command can be run in continuous mode by specifying the option `--loop`. With `--loop` the command keeps printing the set of discovered devices each time it changes (i.e. a new device is plugged or a connected device is unplugged). In some operative system the continuous discovery is implemented by polling the operative system device database for changes. The polling time can be set with option `--looptime milliseconds`, by default it is 2000 milliseconds.

## Device configuration

Before usage a device must be configured. The configuration consists in linking a physical device identified by its `uid` to a logical device identified by its `alias` and `target` attributes. Additional attributes can be optionally set.
The configuration command is:

```py
ztc device alias put uid alias target
```

where `uid` is the device hardware identifier (as reported by the discovery algorithm), `alias` is the user defined device name (no spaces allowed) and `target` is one of the supported the supported devices target. A `target` specifies what kind of microcontroller, pin routing and additional perpherals can be found on the device. For example, the `target` for NodeMCU2 development board id `nodemcu2` and informs the ZTC about the fact that the configured device is a NodeMCU2 implying an esp8266 microcontroller, a certain pin routing and an onboard FTDI controller.

There is no need to write the whole `uid` in the command, just a few initial character suffice, as the list of known uids is scanned and compared to the given partial `uid` (may fail if the given partial `uid` matches more than one uid).

Additional options can be given to set other device attributes:


* `--name name` set the human readable device name to `name` (enclose in double quotes if the name contains spaces)


* `--chipid chipid` used by external tools to set the device `chipid` manually


* `--remote_id remote_id` used by external tools to set device `remote_id` manually


* `--classname classname` used to set the device `classname` in case of ambiguity.

Aliases can be also removed from the known device list with the command:

```py
ztc device alias del alias
```

## Device Registration

To obtain a virtual machine a device must be registered first. The registration process consists in flashing a registration firmware on the device, obtaining the microcontroller unique identifier and communicating it to the Zerynth backend.
The process is almost completely automated, it may simply require the user to put the device is a mode compatible with burning firmware.

Device registration is performed by issuing the command:

```py
ztc device register alias
```

where `alias` is the device alias previously set (or just the initial part of it).

The result of a correct registration is a device with the registration firmware on it, the device `chipid` and the device `remote_id`. Such attributes are automatically added to the device entry in the known device list.

The option `--skip_burn` avoid flashing the device with the registering firmware (it must be made manually!); it can be helpful in contexts where the device is not recognized correctly.

!!! note
	Devices with multiple modes can be registered one at a time only!

## Device Registration by UID

If the microcontroller unique identifier is already known (i.e. obtained with a JTAG probe), the device can be registered skipping the registration firmware flashing phase.

Device registration is performed by issuing the command:

```py
ztc device register_by_uid chipid target
```

where `chipid` is the microcontroller unique identifier  and `target` is the type of the device being registered. A list of available targets can be obtained  with the ref:supported <ztc-cmd-device-supported>.

Upon successful registration the device is assigned an UID by the backend.

## Device Raw Registration

Sometimes it is useful to manually provide the device parameters for registration. The parameters that can be provided are:


* `port`, the serial port exposed by the device


* `disk`, the mass storage path provided by the device


* `probe`, the type of JTAG/SWD probe to use during registering

The above parameters must be specified using the `--spec` option followed by the pair parameter name and value separated by a colon (see the example below).

Device registration is performed by issuing the command:

```py
ztc device register_raw target --spec port:the_port --spec disk:the_disk --spec probe:the_probe
```

It is necessary to provide at least one device parameter and the registration will be attempted gibing priority to the probe parameter. Registration by probe is very fast (and recommended for production scenarios) beacuse the registration firmware is not required.

## Virtualization

Device virtualization consists in flashing a Zerynth virtual machine on a registered device. One or more virtual machines for a device can be obtained with specific ZTC commands.
Virtualization is started by:

```py
ztc device virtualize alias vmuid
```

where `alias` is the device alias and `vmuid` is the unique identifier of the chosen vm. `vmuid` can be typed partially, ZTC will try to match it against known identifiers. `vmuid` is obtained during virtual machine creation.

The virtualization process is automated, no user interaction is required.

## Raw Virtualization

Device virtualization consists in flashing a Zerynth virtual machine on a registered device. One or more virtual machines for a device can be obtained with specific ZTC commands.

Sometimes it is useful to manually provide the device parameters for virtualization. The parameters that can be provided are the same of the register_raw command.

Virtualization is started by:

```py
ztc device virtualize vmuid --spec port:the_port --spec disk:the_disk --spec  probe:the_probe
```

where `vmuid` is the unique identifier of the chosen vm. `vmuid` can be typed partially, ZTC will try to match it against known identifiers. `vmuid` is obtained during virtual machine creation.

The virtualization by probe has priority over the other device parameters and is recommended for production scenarios.

## Serial Console

Each virtual machine provides a default serial port where the output of the program is printed. Such port can be opened in full duplex mode allowing bidirectional communication between the device and the terminal.

The command:

```py
ztc device open alias
```

tries to open the default serial port with the correct parameters for the device. Output from the device is printed to stdout while stdin is redirected to the serial port. Adding the option `--echo` to the command echoes back the characters from stdin to stdout.

## Serial Console (raw)

Each virtual machine provides a default serial port where the output of the program is printed. Such port can be opened in full duplex mode allowing bidirectional communication between the device and the terminal.

it is sometime useful to directly specify the serial port on the command line.

The command:

```py
ztc device open port
```

tries to open `port` with the correct parameters for the device. Output from the device is printed to stdout while stdin is redirected to the serial port. Adding the option `--echo` to the command echoes back the characters from stdin to stdout.

## Supported Devices

Different versions of the ZTC may have a different set of supported devices. To find the device supported by the current installation type:

```py
ztc device supported
```

and a table of `target` names and paths to device support packages will be printed.

## Erase of the device flash memory

Erase completely the flash memory of the device (all data stored will be deleted).

This operation is performed by issuing the command:

```py
ztc device erase_flash alias
```

where `alias` is the device alias previously set (or just the initial part of it).

## Execute a device custom action

Some devices provide custom actions to be executed (e.g., burn proprietary bootloaders, put the device in a specific mode).
These actions are performed by issuing the command:

```py
ztc device custom_action alias action
```

where `alias` is the device alias previously set (or just the initial part of it) and `action` is the selected action.

## Configured Devices

Manual device configurations can be saved in a local database in order to avoid retyping device parameters every time.
The command:

```py
ztc device db list
```

prints the list of configured devices with relevant parameters. By providing the oprion `--filter-target` the list for a specific target can be retrieved.

## Add Configured Devices

Manual device configurations can be saved in a local database in order to avoid retyping device parameters every time.
The relevant parameter for a device are:


* `target`, the device type


* `name`, the device name. It must be unique and human readable


* `port`, the device serial port (may change upon device reset!)


* `disk`, the mass storage path of the device (if exposed)


* `probe`, the JTAG/SWD probe used for device programming


* `chipid`, the device microcontroller unique identifier


* `remote_id`, the device UID assigned by the backend after registation

If the device `name` is not present in the database, a new device is created; otherwise the existing device is updated with the provided parameters. To unset a parameter pass the “null” value (as a string). If a parameter is not given it is not modified in the database. A parameter is set tonull if not specified upon device creation.

The command:

```py
ztc device db put target device_name --spec port:the_port --spec disk:the_disk --spec probe:the_probe --spec chipid:the_chipid --spec remote_uid:the_remote_uid
```

inserts or modifies the configured device `device_name` in the database. The given parameters are updated as well. For the probe parameter, the list of available probes can be obtained with the probe list command.

## Remove Configured Devices

The command:

```py
ztc device db remove device_name
```

removes the device `device_name` from the configured devices.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTQ0OTE0NTI0NiwzMjcyMjk3MzBdfQ==
-->
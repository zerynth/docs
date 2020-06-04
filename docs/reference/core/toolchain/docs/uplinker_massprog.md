# Device Configuration and Mass Programming

In the lifecycle of an IoT device particular attention must be given to the initial programming and provisioning.
Zerynth provides some firmware modules and toolchain commands to ease the task.

In particular the toolchain is capable of accepting a description of the resources needed by the device and automatically
store them in the device flash memory together with the VM and the firmware. To do so, a Zerynth project must be accompained
by a `dcz.yml` file with all the information on the needed resources and the ways to generate them.

To automate the task of mass programming, it is also possible to write a `massprog.yml` file containing the information
about the kind of device to mass program, its vm parameters and more. In this way it is not necessary to manually register-virtualize-uplink
all the devices and the whole task is performed by a single command.

## Device Configuration Zones

If a valid `dcz.yml` file is present in the project folder, every time an uplink command is performed, the file is read
and the described resources are generated and stored in the device flash before any uplinking. The device must support some means of
programming with jtag probes or custom uploaders for this process to work correctly.

The `dcz.yml` file is composed of various sections:

```
# Zerynth Device Configuration Map
#
# this file declares a set of resources to be loaded on the device
# in a way that is indipendent from the firmware in order to facilitate
# mass programming and mass provisioning.
#
# It is in Yaml format, and the various sections/options are documented below


# this field must be true to enable this configuration!
# if not present or false, the configuration is skipped
# and no resource is transferred in the device
active: true


############################
# Provisioning Section
#
# in the "provisioning" section, the various resources
# with their location and their generation method are listed
#
# For each resource the following fields are mandatory:
#
# - name: an ascii string specifying the resource name (max 16 bytes)
# - type: the type of the resource [file, prvkey, pubkey, cert]
# - args: a list of arguments needed to load or generate the resource
# - mapping: a list of addresses where the resource must be copied
#
# When using DCZ (see next section), an optional parameter "format" can be given.
# It must be an ascii string of at most 4 bytes, by default it is set to "bin"
#
# uncomment the following section to enable provisioning
provisioning:
    # the provisioning method (used to generate device credentials)
    method: aws_iot_key_cert
    # the list of resources
    resources:
        # the device CA certificate: obtained from the ones provided by Amazon
        - name: cacert
          type: cacert
          mapping: [0x326000,0x327000]
        # the device certificate: will be created by calling into AWS API
        - name: clicert
          type: clicert
          mapping: [0x320000,0x321000]
        # the device private key: will be created by calling into AWS API and will be encrypted
        - name: prvkey
          type: prvkey
          mapping: [0x322000,0x323000]
          encrypt: True
        # the endpoint where to connect to. Obtained by calling into AWS API
        - name: endpoint
          type: endpoint
          mapping: [0x324000,0x325000]
          format: json
        # some device info useful to have in the firmware (for this to work, aws.thing_prefix must be given!)
        - name: devinfo
          type: devinfo
          mapping: [0x328000,0x329000]
          format: json
        # an encrypted resource where wifi credentials can be stored
        - name: wificred
          type: file
          args: files/wificred.json
          mapping: [0x330000, 0x331000]
          format: json
          encrypt: True


############################
# DCZ Section
#
# in the "dcz" section the provisioned resources (or a subset of them)
# can be included in the Device Configuration Zone. The DCZ is a versionable index
# of the available resources that can be easily accessed and updated
# with the dcz Zerynth module.
#
# DCZ supports up to 8 replication zones for safety. If a resource is included in a DCZ
# with replication n, it must be placed in exactly n different locations for versioning
#
# uncomment the section below to enable dcz
dcz:
    # locations of the DCZs (replication 2)
    mapping: [0x310000,0x311000]
    # list of resource names to be included
    resources:
        - endpoint
        - clicert
        - prvkey
        - cacert
        - devinfo
        - wificred

############################
# AWS Section
#
# in the "aws" section, the various credentials and options
# for aws iot services are spcified
aws:
    # specify the access key id of the IAM user that can create certificate and things
    aws_access_key_id: "your-access-key"
    # the IAM user credentials
    aws_secret_access_key: "your-secret-key"
    # the region where certificates will be created
    region_name: "your-region"
    # specify the Amazon CA certificate to use [verisign, ecc, rsa]
    endpoint_type: verisign
    # activation of certificate upon creation
    activate_cert: true
    # the thing prefix for the thing name (optional: if not given, no thing is created)
    thing_prefix: "MyThing"
    # the thing policy to attach to the certificate (optional if not given no policy is attached to cert)
    thing_policy: test_policy
```

The flexibility provided by `dcz.yml` is very high. The `provisioning` section contains a list of resources of different types. Resource types and the provisioning `method` specify how the resouce is generated. The following types of resources are available:


* `file`, specifies an existing file identified by the path in the `args` field


* `cacert`, specifies a CA certificate.


* `clicert`, specifies a device certificate.


* `prvkey`, specifies a device private key.


* `pubkey`, specifies a device public key.


* `endpoint`, specifies the list of endpoints the device can connect to.


* `devinfo`, specifies some device properties needed to correctly connect to the cloud service.

Resources are created in a different way depending on `provisioning.method`:


* `manual` method treats all resource types as files loaded from the path given in `args`.


* `aws_iot_key_cert` method generates device credentials by calling the appropriate AWS API endpoint (via boto3). In particular, both the private key and the
device certificate are requested, while the CA certificate is loaded from file shipping with the erynth toolchain. Device info and endpoints are again generated
through API calls and saved in json format. Optionally a Thing is also automatically created and the policy/certificate are attached to it.


* `aws_iot_csr_cert` method generates device credentials from a CSR signed with an openssl generated private key. [Not yet implemented]


* `gcp_jwt` method generates device credentials for GCP based on JWT tokens. [Not yet implemented]

Resources also have a `name` (max 16 characters) and a `mapping`, a list of addresses on the device flash where the resource will be saved. Addresses can be more than one since resources can be replicated and versioned for a safer device lifecycle. Optionally resources can have a format (default “bin”) and can be ecnrypted.
Encrypted resources are stored in clear and are encrypted by the device using the DCZ module when the firmware first run (typically during end of line testing). This method does not replace gold standard security approaches like the use of dedicated crypto elements, but can protect sensitive data from simple attacks.
The encryption is device dependent and a ciphertext can only be decrypted by the device that produced it.

The optional `dcz` section provides information to be used together with the DCZ module.

## Mass Programming

When producing small to medium batches of IoT devices, it is useful to have an automatic mean of provisioning and flashing. This feature is provided
by the mass programming command documented below. A mass programming configuration file is needed to describe the device parameters:

```
############################
# Mass Programming Section
#
# in the "config" section, all the options necessary
# to avoid human intervention are specified.

config:
    # the name of the target micro/board (i.e. esp32_devkitc)
    target: esp32_devkitc
    # options relative to the device itself (port, baudrate, probe, etc...)
    dev:
        # the serial port of the device
        port: /dev/ttyUSB0
        # the baud rate of the port (defaults to 115200)
        baud: 1500000
        # the programming probe
        probe: null
    # specify the method for device registration [jtag, target_custom]
    register: target_custom
    # specify the parameters for VM to be mass programmed
    vm:
        # the specific rtos of the VM
        rtos: "esp32-rtos"
        # vm version
        version: "r2.2.0"
        # vm patch
        patch: "base"
        # list of vm features
        feats: []
        # set vm to shareable [if set to True, the final user of the device will be able to uplink firmware to the device
        and obtain a copy of the VM: useful for demo boards and kits]
        shareable: False
        # if set to true, the VM will not accept any new firmware from the uplink command [Not yet implemented]
        locked: False
    # path of the project to compile
    project: awesome/zerynth/project
```

## Massprog command

The command:

```
ztc massprog start path
```

will start a register-virtualize-uplink process in a single command using information contained in the `massprog.yml` file present at `path`.
If the project specified in `massprog.yml` contains a `dcz.yml` file, resources will be provisioned and flashed to the device together with the VM and the firmware.

The ```massprog``` may take the additional `--clean` option that forces a firmware compilation and link.

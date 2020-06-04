# Virtual Machines

Virtual machines are the core of Zerynth. From the point of view of the ZTC, a virtual machine is a binary blob to be flashed on a device
in order to enable Zerynth code execution. Virtual machines are tied to the unique identifier of the device microcontroller, therefore for each microcontroller a specific virtual machine must be created.

Virtual machines can be managed with the following commands:


* create


* list


* available


* bin

It is also possible to create custom Virtual Machines for proprietary PCBs based on some Zerytnh supported microcontroller. The customizable parameters pertain to the GPIO routing (custom pinmap) and the selection of available peripherals. More custom parameters will be added in the future.

For the customization process please refer to the dedicated section

## Create a Virtual Machine

Virtual machine can be created with custom features for a specific device. Creation consists in requesting a virtual machine unique identifier (`vmuid`) to the Zerynth backend for a registered device.

The command:

```
ztc vm create alias version rtos patch
```

executes a REST call to the Zerynth backend asking for the creation of a virtual machine for the registered device with alias `alias`. The created virtual machine will run on the RTOS specified by `rtos` using the virtual machine release version `version` at patch `patch`.

It is also possible to specify the additional option `--feat feature` to customize the virtual machine with `feature`. Some features are available for pro accounts only. Multiple features can be specified repeating the option.

If virtual machine creation ends succesfully, the virtual machine binary is also downloaded and added to the local virtual machine storage. The `vmuid` is printed as a result.

## List Virtual Machines

The list of created virtual machines can be retrieved with the command:

```
ztc vm list
```

The retrieved list contains at most 50 virtual machines.

Additional options can be provided to filter the returned virtual machine set:


* `--from n`, skip the first `n` virtual machines

## Virtual Machine parameters

For each device target a different set of virtual machines can be created that takes into consideration the features of the hardware. Not every device can run every virtual machine. The list of available virtual machines for a specific target can be retrieved by:

```
ztc vm available target
```

For the device target, a list of possible virtual machine configurations is returned with the following attributes:


* virtual machine version


* RTOS


* additional features


* free/pro only

## Virtual Machine Binary File

The binary file(s) of an existing virtual machine can be obtained with the command:

```
ztc vm bin uid
```

where `uid` is the unique identifier of the virtual machine

Additional options can be provided:


* `--path path` to specify the destination `path`

## Registering Binary File

The binary file(s) of a a registering bootloader can be obtained with the command:

```
ztc vm reg target
```

where `target` is the name of the device to register.

Additional options can be provided:


* `--path path` to specify the destination `path`

# Custom Virtual Machines

Some Zerynth VMs are customizable. The process of customization can be handled entirely via ZTC commands. In order to create a custom VMs the following steps are needed:


1. List the supported customizable microcontrollers with the vm custom original command


2. Choose a short name for the custom VM and create it starting from one of the available microcontrollers listed in step 1


3. The newly created custom VM configuration can be found under the Zerynth folder in the cvm/short_name directory


4. Before being usable, the custom VM template specifying the role of each pin must be compiled with the dedicated command


5. The compilation step takes as input a Yaml template file (short_name.yml) and generates the binary file (port.bin) needed for VM customization


6. Once compiled, the new VM will behave as a normal VM and the standard Zerynth flow of device registration, VM creation and virtualization will be available for the choosen short_name. The only difference is that the port.bin file will be transparently flashed during the virtualization phase.


7. As an add-on, a new device type is create together with the VM in order to allow automatic discovery of the custom device for seamless integration in Zerynth Studio and other third party IDEs. As detailed below, some parameters of the device (e.g. usb VID:PID) can be defined in the custom VM template


8. Each time the VM template is changed, it must be recompiled and the VM revirtualized in order for the changes to take effect

It is also possible to export custom VMs to file or to Github in order to easily distribute custom VMs.

## Create Custom VM

The command:

```
ztc vm custom create target short_name
```

clones the configuration files for the `target` customizable VM into a custom VM instance named `short_name`.
The command creates a directory cvm/short_name under the Zerynth folder containing the following items:


* `short_name.yml`: the Yaml template file specifying the VM custom parameters. Upon creation, it is initialized with the parameters for one of the existing devices based on the selected microcontroller


* `device.json`: a json document containing info about the device that will host the VM. Such document is generated starting from parameters contained in the Yanml template.


* `short_name.py`: a Python module that is used by the ZTC to automatically discover the custom device.


* `port` and `svg` folders: configuration files needed for correct bytecode generation and management for the custom VM. The only possible customization is adding a `short_name.svg` under the `svg` folder in order to provide a visual representation of the custom device pinmap in Zerynth Studio.


* `register.vm`: the registration bootloader to allow registering the custom device.

The custom VMs are entirely local and not saved on Zerynth servers. For this reason it is suggested to export the custom VM files and store them somewhere safe. Moreover, the choosen short name is never saved on Zerynth server and each custom device will be registered as a device of type `target`. The link between `target` and `short_name` is done on the development machine.

## Compile Custom VM Template

The command:

```
ztc vm custom compile short_name
```

compiles the `short_name.yml` template file of a custom VM to binary form.
The format of the template file is documented in the Yaml file itself.

Upon successful compilation, the custom VM is made available to all other VM related commands (registration, virtualization,…).

## Remove Custom VM

The command:

```
ztc vm custom remove short_name
```

deletes the custom VM identified by `short_name` from the system.

## Export Custom VMs

The command:

```
ztc vm custom export short_name destination
```

exports the custom VM identified by `short_name` to `destination`. If `destination` is a folder, a file `short_name.tar.xz` will be generated in the folder packing together all the needed custom VM files. Such archive can be shared with other users completely enabling them to use the custom device and custom VM with their ZTC. If `destination` is a Github url, the custom VM files are pushed to the repository (provided that Github credentials are known to the ZTC).

## Import Custom VMs

The command:

```
ztc vm custom import source
```

imports a custom VM from `source`. If `source` is a tar.xz file generated by the export command, it is unpacked and installed in the current Zerynth instance. If `source` is a Github repository, it is cloned and installed.

## List customizable VMs

The command:

```
ztc vm custom original
```

lists the VMs that are customizable. Not all VMs support customization. The output of the command contains the list of `target` names to be used in the create command.

## List custom VMs

The command:

```
ztc vm custom list
```

prints the list of custom VMs available on the current Zerynth instance.

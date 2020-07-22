# Zerynth Toolchain

The Zerynth Toolchain (ZTC) is a command line tool that allows managing all the aspects of the typical Zerynth workflow.

Such workflow extends across different areas of the Zerynth programming experience:


* Managing projects


* Discovering, managing and virtualizing devices with virtual machines


* Compiling projects into executable bytecode


* Uplinking bytecode to virtualized devices


* Adding  packages (e.g. libraries, drivers, device classes…) to the current installation


* Turn projects into libraries and publish them to the community repository

The workflow is made possible by the Zerynth backend that provides a set of REST API called by the ZTC.
Therefore, most ZTC commands require an authentication token to act on the Zerynth backend on behalf of the user. Such token can be obtained by specific commands.

A typical workflow consists in:


* Creating a project


* Choosing a target device


* Preparing the device to execute Zerynth code by loading a virtual machine on it, a process called “virtualization”


* Adding Python files (and optionally other files) to the project


* Compiling the project for the target device obtaining executable bytecode


* Uplinking the bytecode to the virtualized device


* Inspecting the output of the device via serial monitor

Contents:

-   [Synopsis](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/ztc/ "Synopsis")
-   [Account related commands](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/user_usercmd/ "Account related commands")
-   [Projects](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/projects_projectcmd/ "Projects")
-   [Devices](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/devices_devcmd/ "Devices")
-   [Compiler](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/compiler_compilercmd/ "Compiler")
-   [Uplink](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/uplinker_uplinker/ "Uplink")
-   [Device Configuration and Mass Programming](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/uplinker_massprog/ "Device Configuration and Mass Programming")
-   [Virtual Machines](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/virtualmachines_vmcmd/ "Virtual Machines")
-   [Packages](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/packages_packagecmd/ "Packages")
-   [Connected Devices](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/things_thingcmd/ "Connected Devices")
-   [Amazon Web Services](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/aws_awscmd/ "Amazon Web Services")
-   [Miscellanea](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/misc_misccmd/ "Miscellanea")
-   [Provisioning](https://newtestdocs.zerynth.com/latest/reference/core/toolchain/docs/provisioning_provisioningcmd/ "Provisioning")
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTU3MDUxOTczNV19
-->
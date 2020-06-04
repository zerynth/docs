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


* Synopsis


    * Global options


    * Command List


    * Output conventions


    * Directories


* Account related commands


    * Login


    * Reset Password


    * Logout


    * Get/Set Profile Info


* Projects


    * Create a project


    * Initialize a Git Repository


    * Check repository status


    * Fetch repository


    * Commit


    * Push to remote


    * Pull from remote


    * Switch/Create branch


    * Clone a project


    * Clone a project


    * List remote projects


    * Build Documentation


    * Configure


* Devices


    * Discover


    * Device configuration


    * Device Registration


    * Device Registration by UID


    * Device Raw Registration


    * Virtualization


    * Raw Virtualization


    * Serial Console


    * Serial Console (raw)


    * Supported Devices


    * Erase of the device flash memory


    * Execute a device custom action


    * Configured Devices


    * Add Configured Devices


    * Remove Configured Devices


* Compiler


* Uplink


* Uplink (raw)


* Uplink by probe


* Link


    * FOTA updates


* Device Configuration and Mass Programming


    * Device Configuration Zones


    * Mass Programming


    * Massprog command


* Virtual Machines


    * Create a Virtual Machine


    * List Virtual Machines


    * Virtual Machine parameters


    * Virtual Machine Binary File


    * Registering Binary File


* Custom Virtual Machines


    * Create Custom VM


    * Compile Custom VM Template


    * Remove Custom VM


    * Export Custom VMs


    * Import Custom VMs


    * List customizable VMs


    * List custom VMs


* Packages


    * Available versions


    * Available packages


    * Trigger Update


    * Install community packages


    * Github Authorization


    * Publishing a community library


    * Installed packages


* Connected Devices


    * Create a connected device


    * Retrieves device info


    * Configure a device


    * Connected devices list


    * Create a group of devices


    * Group configuration


    * Group configuration


    * Create a device template


    * Upload a template


    * Retrieve template list


    * Prepare a FOTA update


    * Start a FOTA update


    * Stop a FOTA update


    * Check a FOTA update


* Amazon Web Services


    * AWS IoT Platform


* Miscellanea


    * Linter


    * Info


    * Clean


* Provisioning


    * Uplink Configurator Firmware to the device


    * Scan for a Crypto Element Address


    * Read Crypto Element Configuration


    * Retrieve Public Key


    * Write Crypto Element Configuration


    * Get Certificate Signing Request


    * Locked


    * Serial Number


    * Store Public


    * Store Certificate

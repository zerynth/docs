# Getting started

[](https://www.zerynth.com/blog/docs/4zeroplatform/getting-started/# "Print this article")

This is a step-by-step tutorial that guides the user in the usage of the 4ZeroPlatform Web-App interface from the the registration of a new account to the configuration of your device.

![](img/4zeroplatform-home-1.png)

From the sidebar menù you can always easly navigate to each main section of the platform:

-   **4ZeroPlatform Configurator**: the tool that guides the user during the installation of all the required softwares, drivers, libraries and tools needed for programming the 4ZeroBox (only Desktop version for all platforms – Windows, Mac, Linux).
-   **4ZeroManager**: the device management service for organizing, monitoring, and remotely updating connected devices at scale. The 4ZeroManager includes a web interface for the control of connected devices and for the customization of data forwarding.
-   **4ZeroPlatform Apps**: the list of custom apps to allow dedicated data processing services, data visualization in dashboards, automatic alarming and reporting.

### 4ZeroPlatform Configurator

There are some RPC available by default that can be called without any further configuration after this library is imported.

#### Gathering required software

**Download it here:**

-   [4ZeroPlatform Configurator for Windows](https://www.zerynth.com/download/15307/)
-   [4ZeroPlatform Configurator for Linux](https://www.zerynth.com/download/15308/)
-   [4ZeroPlatform Configurator for Mac](https://www.zerynth.com/download/15309/)

Extract the downloaded archive and run the executable file named “4ZeroPlatformConfigurator”.

#### Creating an account

Open the 4ZeroPlatform Configurator, if that’s your first time, you will need an user account for the 4ZeroPlatform. Click on `Register` and compile the form:

![](img/register.png)

After that, you will be redirected to the login page, where you can enter the email address and the password of the account you just created:

![](img/login.png)

#### Setup your local machine

Before starting to interact with your 4ZeroBox and discover all 4ZeroPlatform functionalities, you need to install the official developing tool for programming the 4ZeroBox.

![](img/configurator-home.jpg)

Zerynth is an ecosystem of software tools to program microcontrollers in Python and connect them to the Cloud. With Zerynth you can program your 4ZeroBox in Python or hybrid C/Python language and t is available for all 64-bit platforms (Windows, Mac, Linux).

Zerynth main features are:

-   Python and C blended together for efficient development;
-   Tiny Footprint: Zerynth requires just 60k-80kB of Flash and 3-5kB of RAM dedicated to the Zerynth Virtual Machine;
-   Real-Time: Zerynth integrates the RTOS of your choice with multithreading support;
-   Connectivity: Zerynth allows an easy integration with top Cloud services and Firmware Over-The-Air updates.

!!! warning
    The 4ZeroPlatform Configurator depends on **the latest version** of Zerynth Studio, the IDE provided by Zerynth. You can download from [here](https://www.zerynth.com/zerynth-studio/) and install Zerynth following the [Installation guide](https://docs.zerynth.com/latest/official/core.zerynth.docs/installationguide/docs/index.html).

Once Installed Zerynth Studio, following page will apprear:

![](img/install_studio.png)

In sequence, both operation must be excecuted before proceeding to program the 4ZeroBox:

-   **Driver Installation**: 4ZeroBox comes with a serial-to-usb chip on board that allows programming and opening the UART of the ESP32 module. The CH340 USB to UART chip is also connected to the boot pins of the module, allowing for a seamless virtualization of the device. Drivers for the CH340 Module are needed for Windows and Mac OS platforms;
-   **Zerynth Studio Configuration**: This operation installs all packages needed to auto-recognize the 4ZeroBox inside the Zerynth Studio (device, libraries, etc.) with examples ready to publish data in the 4Zeroplatform.

!!! important
    To install the driver, press the button related to your OS, start the download, extract the archive and run the executable file inside it:
    -   CH341SER/SETUP.EXE for Windows
    -   CH341SER_MAC/CH34x_Install_V1.4.pkg for Mac OS

!!! note:
    **Linux users**: while devices drivers are already included in the kernel, the read/write access to the serial port must be granted to your user. You must add your user to the group `dialout`, or `uucp` depending on your distribution.

This command should do the trick: `bash -c 'sudo usermod -a -G $(grep -o "^\(uucp\|dialout\)" /etc/group) ${USER}'`

Remember to logout and log back in to apply the group changes.

After Driver installation, click on **Configure Zerynth Studio** to apply new libraries and examples to it.

![](img/studio_patch_ongoing.png)

![](img/studio_patch_complete.png)

!!! important
    Configuration of Zerynth Studio must be done every time there is a new release or new patch of it.

**Configure your device**

Before connecting your 4ZeroBox you have to check jumper and switch position on-board to enable the programming status.

![](img/4zerobox-programming.png)

As shown in the figure, to enable the programming via USB you have to set:

-   Jumper **JP1** in **U5V** position: JP1 is the power supply selector; with E5V External Power Supply is selected otherwise with U5V USB Power Supply is selected;
-   Switch **SW2** position **11** high: position 11 of the switch SW2 connects the mail serial port of the microcontroller to the USB-to-Serial chip to enable serial comunication.

It’s time to register your device! Plug your 4ZeroBox to your computer using an USB cable and click on **Add new device** section. If drivers are correctly installed and Zerynth Studio correctly configured, clicking the **Configure new device** button the device configuration procedure will start as shown in figure below.

![](img/device_configuration.png)

At the end, the device will be ready to be programmed:

![](img/device_configured.png)

You can now add a new device if you have or click on **Launch Zerynth Studio** to open the IDE and program your 4ZeroBox, it will be listed in the available devices, select it!

![](img/studio_first_open.png)

If you click on the console icon, a serial terminal monitor will show up, printing a line with _“Hello 4ZeroBox”_ message every second:

![](img/studio_console.png)

On the left column, you can click on the _light bulb_ icon to open available examples. Searching for **toi** in the bar shows a couple of code samples:

![](img/studio_examples.png)

Double-click on the example provided within the **fourzeromanager** library clone it (more informations about cloning an example and uplinking it can be found [here](https://docs.zerynth.com/latest/official/core.zerynth.docs/gettingstarted/docs/index.html#clone-an-example-and-start-with-zerynth-python-scripts)) and edit the line 129 with a valid Wi-Fi configuration to be like that:

```py
try:
    fzbox.net_connect("Your WiFi name", "your-wifi-password")
except Exception as e:
    mcu.reset()
```

you’ll be able to send your first data online.

!!! note
    These data are random for now – to connect a real sensor and send data refer to the 4ZeroBox documentation: [4ZeroBox](https://www.zerynth.com/blog/docs/4zeroplatform/4zerobox/). Also, the full 4ZeroManager library for connecting, registering new RPCs, and sending data is available here: [4ZeroManager](https://www.zerynth.com/blog/docs/4zeroplatform/4zeromanager/).

!!! important 
    To devolop new applications for the 4ZeroBox, a **project.yml** file must be present inside the project folder (can be copied from the examples available in TOI libraries). In project.yml file, peripherals and functionalities can be enabled or disabled according to what your application need making your script optimized and saving resources. More info [here](https://www.zerynth.com/blog/docs/4zeroplatform/4zerobox/#library)

!!! warning
    Remember that to make more safe each application, a recovery mechanism from unexpected behavior based on microcontroller watchdog is enabled for all available Zerynth Virtual Machines of the 4ZeroBox. More info on Zerynth Secure Firmware can be found [here](/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_sfw.html#secure-firmware)

### 4ZeroManager

4ZeroManager is a cloud-base device management service for organizing, monitoring, and remotely updating connected devices at scale.

As last step, re-opening the 4ZeroPlatform Configurator, you can find a **4ZeroManager** section:

![](img/my_devices.png)

Here, you will be able to have an overview of all your registered devices. Clicking on the name of one of them, you can see details and settings of this specific device.

#### Consoles

There are two MQTT consoles showing data received respectively from the _data_ topic, and from the _RPC_ (Remote Procedure Call) topic.

![](img/device_details_1.png)

#### RPC – Remote Procedure Call

A RPC is a method activated by remote. There are some already defined in the _fourzeromanager_ library and that are always available:

-   _Reset device_ to force a full reset
-   _Manifest RPCs_ to see available RPCs
-   _FOTA_ to start a remote update.

From the custom RPC section you can call your RPC registered in the Zerynth firmware.

[![](img/device_details_2.png)](img/device_details_2.png "device_details_2")

#### FOTA – Firmware over the Air

One of the default RPC is the FOTA update. This means that you can flash a new firmware on your device, without having it connected to your computer – it just needs to be online!

Clicking the FOTA button will ask you for a folder containing a valid Zerynth project, select it and wait some seconds – the device will reboot using the new firmware.

![](img/device_details_2.png)

!!! important
    FOTA functionalities are available only on desktop version of the 4ZeroPlatform Configurator.

#### Webhooks and MQTT Endpoints

Setting an URL in the _Webhook_ section will make it possible to send data received from the device to any valid HTTP endpoint.

The token is something similar to a password, you can choose one or click on **Generate** to set a random one. Check this token on your server to be sure the data you are receiving are from us!
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1MTA1MjM0NV19
-->
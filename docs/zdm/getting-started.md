::: {.module}
zerynthzdm
:::

Getting started {#lib.zerynth.zdm}
===============

The Zerynth Device Manager (ZDM) Library contains many different
commands that allows you to connect your devices to the ZDM. You can use
ZDM lib to send data from your devices and to let them receive your
remote commands (jobs).

To learn how to be able to use it and call ZDM methods, see the [ZDM
getting started
doc](https://www.zerynth.com/blog/docs/the-tools/zdm/getting-started/).

The Device class
================

::: {.Device(device_id, .job_list=None, .fota_callback=None)}
Creates a Device instance with uid `device_id`{.interpreted-text
role="samp"}. All other parameters are optional and have default values.

-   `endpoint`{.interpreted-text role="samp"} is the endpoint of the
    zdm.
-   `port`{.interpreted-text role="samp"} is the port of the zdm.
-   `job_list`{.interpreted-text role="samp"} is the dictionary that
    defines the device\'s available jobs
-   `fota_callback`{.interpreted-text role="samp"}, is a function
    accepting one ore more arguments that will be called at different
    steps of the FOTA process.

the `fota_callback`{.interpreted-text role="samp"} can return a boolean
value. If the return value is True, the FOTA process continues,
otherwise it is stopped.
:::

::: {.method}
set\_password(password)

Set the device password to `password`{.interpreted-text role="samp"}.
You can generate a password using the ZDM, creating a key for your
device
:::

::: {.method}
connect()

Connect your device to the ZDM. You must set device\'s password first.
It also enable your device to receive incoming messages.
:::

::: {.method}
publish(data, tag=None)

Publish a message to the ZDM.

-   `data`{.interpreted-text role="samp"} is the message payload,
    represented by a dictionary
-   `tag`{.interpreted-text role="samp"}, is a label for the device\'s
    data into your workspace. More than one device can publish message
    to the same tag
:::

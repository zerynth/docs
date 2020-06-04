# Eseye AnyNet AWS

[Eseye](https://www.eseye.com/) is a leading global provider of M2M cellular connectivity for
the Internet of Things (IoT) specialized in simplifying complex global device deployments for enterprises.
Their [AnyNet Secure](http://anynetsecure.com/) SIM identifies, catalogues and connects IoT devices to AWS IoT cloud, while reducing costs and risks of IoT deployments.

To easily interact with AnyNet Secure SIM exploiting its AWS IoT readiness, an MCU-based [AT](https://en.wikipedia.org/wiki/Hayes_command_set) modem has been developed.
The AWS AT modem exposes an MQTT client, connected to AWS IoT, controllable through simple AT custom commands over a serial interface.

The modem can be found on the [AnyNet 2G Click Board](https://www.mikroe.com/anynet-2g-click) as a result of the partnership between [MikroElektronica](https://www.mikroe.com/) and [Eseye](https://www.eseye.com/).

```NOTE```: When using [AnyNet 2G Click Board](https://www.mikroe.com/anynet-2g-click) be sure to have sufficient power supply and a sufficiently good antenna according to 2G network signal strength for the zone of usage.

Here below, the Zerynth Library to communicate to the modem through an intuitive Python interface.

Contents:


* Eseye AnyNet AWS Library

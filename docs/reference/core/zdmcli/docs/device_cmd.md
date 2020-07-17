# Device
A Device is the smallest entity you can find in the ZDM. 
It is represented by the physical IOT device connected with the ZDM via MQTT.

## Create
Create a new device.

```bash
zdm device create NAME
```

Where:

* `NAME` is the name you want to give to your device

Options:

*  `--fleet-id ID`: is the fleet id where the device is associated


## Get
Get a single device.

```bash
zdm device get ID
```

Where:

* `ID` is the id of the device

## List
List all the device.

```bash
zdm device all
```

## Update
Update a device.

```bash
zdm device update ID
```

Where:

* `ID` is the id of the device

Options:

*  `--fleet-id TEXT` new fleet id
*  `--name TEXT`     new  device name


## Provision
The command generates a configuration file (zdevice.json) that contains the credentials and the endpoint
to be used to provision a new device.

```sh
zdm device provision [OPTIONS] DEVICE_ID
```

Where:

* `DEVICE_ID` is the id of the device

Options:

 * `--endpoint_mode [secure|insecure]` Choose endpoint security. Default `secure`.
 * `--credentials [device_token|cloud_token]` Choose device credentials. Default `device_token`.
 * `-o, --output TEXT`              Path to save zdevice.json. Default current directory.


## 


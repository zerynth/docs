# Device
A Device is the smallest entity you can find in the ZDM. 
It is represented by the physical IOT device connected with the ZDM via MQTT.

## Create
Create a new device with a `NAME`.

```bash
zdm device create  [OPTIONS]  NAME
```

Options:

*  `--fleet-id ID`: is the fleet id where the device is associated


## Get
Get a single device by `ID`.

```bash
zdm device get ID
```


## List
List all the device.

```bash
zdm device all
```

## Update
Update a device bu `ID`

```bash
zdm device update   [OPTIONS] ID
```


Options:

*  `--fleet-id TEXT` new fleet id
*  `--name TEXT`     new  device name


## Credentials
The command generates a configuration file (zdevice.json) that contains the credentials and the endpoint
to be used to provision the device with `DEVICE_ID`. 

```sh
zdm device credentials [OPTIONS] DEVICE_ID
```


Options:

 * `--endpoint_mode [secure|insecure]` Choose endpoint security. Default `secure`.
 * `--credentials [device_token|cloud_token]` Choose device credentials. Default `device_token`.
 * `-o, --output TEXT`              Path to save zdevice.json. Default current directory.



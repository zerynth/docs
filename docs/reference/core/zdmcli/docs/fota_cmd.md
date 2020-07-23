# Fota
The ZDM allows you to enable FOTA (over the air firmware updates) on your devices.

## Prepare the FOTA

The command compiles and uploads the firmware for a device into ZDM.

```bash
zdm fota prepare [Firmware project path] [DeviceId] [Version]
```

```version``` is a string identifying the version of the firmware (e.g., "1.0").

## Start a FOTA

Once you’ve uploaded your firmware, you can send the FOTA command to a device that will download it from the ZDM and uplink it.

If the FOTA operation is finished, you can see if the device has accepted or refused it using the ```zdm fota check dev-uid``` command.

To start a fota, type the command: 

```bash
zdm fota schedule fw_version device_id
```

where ```fw_version``` is the firmware version associated to the device's workspace uid and ```device_id``` is the device you want to send the command to.

## Check FOTA status

To check the status of a FOTA you started, to know if the device finished the task or if an error occurred, type the following command:

```bash
zdm fota check device_uid
```

where ```device_uid``` is the uid of the device you want to check.


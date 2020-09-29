# Fota
The ZDM allows you to enable FOTA (over the air firmware updates) on your devices.

## Prepare the FOTA

The command compiles and uploads the firmware for a device into ZDM.

```bash
zdm fota prepare PROJECT-PATH DEVICEID VERSION
```

```VERSION``` is a string identifying the version of the firmware (e.g., "1.0").

## Start a FOTA

Once you’ve uploaded your firmware, you can send the FOTA command to a device that will download it from the ZDM and uplink it.

If the FOTA operation is finished, you can see if the device has accepted or refused it using the ```zdm fota check dev-uid``` command.

To start a fota, type the command: 

```bash
zdm fota schedule FW_VERSION DEVICE_ID
```

where ```FW_VERSION``` is the firmware version associated to the device's workspace uid and ```DEVICE_ID``` is the device you want to send the command to.

## Check FOTA status

To check the status of a FOTA you started, to know if the device finished the task or if an error occurred, type the following command:

```bash
zdm fota check DEVICE_UID
```

where ```DEVICE_UID``` is the uid of the device you want to check.

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTkyNTA5MjQ0N119
-->
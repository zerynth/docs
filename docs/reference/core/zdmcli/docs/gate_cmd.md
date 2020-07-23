# Gate
Using the ZDM you’re able to send out your device’s data through gates.
You can activate a webhook to receive all the data sent on a specific tag in a workspace or
you can create a export gate to receive your data periodically.
ZDM allows you also to visualize data on Ubidots through a Webhook.

## Export gates

### Export gate creation
To create a new export gate use the command:

```bash
zdm gate export create NAME TYPE FREQUENCY WORKSPACE_ID EMAIL [OPTIONS]
```

where ```NAME``` is the name that you want to give to your new webhook, ```TYPE``` is your export type (json, csv), ```FREQUENCY``` is the export frequency [daily, weekly] ````WORKSPACE_ID``` is the uid of the workspace you want to receive data from and ```EMAIL``` is the email to receive the link to download the export

You also have the possibility to add filters on data using the following options:

* ```--tag``` To specify a tag to filter data (you can specify more than one) 
* ```--fleet``` To specify a fleet to filter data (you can specify more than one) 
* ```--export-name``` To specify the export’s name 
* ```–day``` To specify the day (if frequency is weekly) [0 Sunday... 6 Saturday]

### List export gates

To see a list of your export gates use the command:

```bash
zdm gate export all WORKSPACE_ID [OPTIONS]
```

where ```WORKSPACE_ID``` is the uid of the workspace

You also have the possibility to add filters on gates using the following options:

* ```--status active|disabled``` to filter on gate’s status

### Update export

To update an export gate use the command:

```bash
zdm gate export update GATE_ID [OPTIONS]
```

you can change gate’s configuration using the following options: 

* ```--name``` to change the gate name 
* ```--cron``` to change the gate period (cron string hour day) 
* ```--dump_type``` to change the dump format (json, csv) 
* ```--email``` to change the notifications email 
* ```--tag``` (multiple option) to replace webhook tag array

## Webhook gates

### Webhook creation

To create a new webhook use the command:

```bash
zdm gate webhook create NAME URL TOKEN PERIOD WORKSPACE_ID [OPTIONS]
```

where ```NAME``` is the name that you want to give to your new webhook, ```URL``` is your webhook url, ```TOKEn``` is the authentication token for your webhook (if needed) and ```WORKSPACE_ID``` is the uid of the workspace you want to receive data from

You also have the possibility to add filters on data using the following options:

* ```--tag``` To specify a tag to filter data (you can specify more than one) 
* ```--fleet``` To specify a fleet to filter data (you can specify more than one) 
* ```--token``` Token used as value of the Authorization Bearer fot the webhook endpoint.

### List export gates

To see a list of your webhooks use the command:

```bash
zdm gate webhook all WORKSPACE_ID [OPTIONS]
```

where ```WORKSPACE_ID``` is the uid of the workspace

You also have the possibility to add filters on gates using the following options:

* ```--status active|disabled``` to filter on gate’s status

### Update webhook

To update a webhook use the command:

```bash
zdm gate webhook update GATE_ID [OPTIONS]
```

you can change gate’s configuration using the following options: 

* ```--name``` to change the webhook name 
* ```--period``` to change the webhook period 
* ```--url``` to change the webhook url 
* ```--tag``` (multiple option) to replace webhook tag array 
* ```--fleet``` (multiple option) to replace webhook fleets array

## Alarm gates

### Create alarm gate

To create a new alarm gate (notifications about opened and closed conditions by devices) use the command:

```bash
zdm gate alarm create NAME WORKSPACE_ID THRESHOLD EMAIL TAG(S)
```

where ```NAME``` is the name of the gate, ```WORKSPACE_ID``` is the uid of the workspace in which you want to monitor condition, ```THRESHOLD``` is a int representing the minimum duration of a condition to be notified, ```EMAIL``` is the email where you want to receive notifications, ```TAG(S)``` is a list of tags to filter on conditions labels

### Update alarm gate

To update an alarm gate use the command:

```bash
zdm gate alarm update GATE_ID [OPTIONS]
```

you can change gate’s configuration using the following options:

* ```--name``` to change the gate’s name 
* ```--tag``` (multiple option) to replace gate’s tag array 
* ```--threshold``` to change the gate’s threshold

### List export gates

To see a list of your alarm gates use the command:

```bash
zdm gate alarm all WORKSPACE_ID [OPTIONS]
```
where ```WORKSPACE_ID``` is the uid of the workspace

You also have the possibility to add filters on gates using the following options:

* ```--status active|disabled``` to filter on gate’s status

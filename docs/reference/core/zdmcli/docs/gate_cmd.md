# Gate
Using the ZDM you’re able to send out your device’s data through gates.
You can activate a webhook to receive all the data sent on a specific tag in a workspace or
you can create a export gate to receive your data periodically.
ZDM allows you also to visualize data on Ubidots through a Webhook.


## Webhook
A webhook permits to send data to an external HTTP endpoint.
 

### Create
Create a new webhook gate.

```sh 
zdm gate webhook create NAME URL PERIOD WORKSPACE_ID
```


Where:

* `NAME` is the name of the webhook
* `URL` is the HTTPS url endpoint of the webhook
* `PERIOD` is the time period in seconds for which the zdm performs the webhook. 
* `WORKSPACE_ID` is the id of the workspace

Options:
* `--tag TEXT`             filter the data sent by tag
*  `--fleet TEXT`          filter the data sent by a fleet id
*  `--token TEXT`          token used in the webhook post.


### List
List all the webhook gate.

```sh
zdm gate webhook all WORKSPACE_ID
```

Where:

* `WORKSPACE_ID` is the workspace id

Options:

 * `--status [active|disabled]`  Filter webhook by its status.

### Update
Update a  webhook gate.

```sh
 gate webhook update  GATE_ID
```

## Export 


## Alert
# ZDM Web Interface

Go to [https://zdm.zerynth.com](https://zdm.zerynth.com/) and login using your Zerynth account, you will reach the ZDM Home Page.


## Home Page

[ ![](img/homePage.png) ](img/homePage.png)

From here you can get an overview of your workspaces, search for them and add new ones.

Each registered user has the “Default Workspace” endowed with the “Default Fleet” that can be used for starting with the ZDM. You can easily add more workspaces and fleets if needed. The Default workspace can’t be deleted.

Keep your project well organized! We suggest using a new workspace for each new project.

## Add new Workspace

If you want to create a new workspace, click on the “New Workspace” button, choose the name and optionally add a description and fleets.

If you don’t create any fleets, a "Default" one will be automatically added so that you will be ready to add new devices.

[ ![](img/newWorkspace.png) ](img/newWorkspace.png)

## Workspace

To open a workspace just click on it in the Home Page.
The workspace page allows you to manage Devices, Fleets, Data, Gates, Conditions, Alerts and some other features.

[ ![](img/workspaceView.png) ](img/workspaceView.png)

###Workspace configuration

In the "Configuration" tab of a workspace it's possible to generate and manage API tokens for the workspace.
You can use enabled API tokens to make HTTP requests to the ZDM. To create a new API token click on the "New Token" button,
then copy and save the generated key. You can enable and disable your tokens using the switch in the API tokens table.

In this page you also have the possibility to delete the workspace.

!!!Important
    You can delete only workspaces with no devices inside.

[ ![](img/workspaceConfig.png) ](img/workspaceConfig.png)

## Devices

"Devices" tab allows you to create and manage your ZDM devices.

Devices can be filtered by fleets and ordered by creation date. 

The devices table gives you some information like name, id, fleet and devices activity and state.
You can also use this table to delete your unused devices.

To add a new device you need to execute a two-step operation:


1.   **Create a device**

    To create a device, click on the button "Add Device" and choose a name and a fleet.
    [ ![](img/newDevice1.png) ](img/newDevice1.png)


2.   **Generate device's credentials**
    
    To connect the device to the ZDM, configure the device's security (Credentials type and Endpoint type).
    [ ![](img/newDevice2.png) ](img/newDevice2.png)

You can now connect your device to the ZDM using the zdevice.json file, download it and move it inside your project's directory, then uplink your firmware to your device.


###Device page

You can open the device page by clicking on a device name.
On the top of the page you will see device's information and its status and the tags it publishes data to.

Use this page to perform operations such as Fota update, rename the device, send jobs to the device,  generate new device credentials.

[ ![](img/devicePage.png) ](img/devicePage.png)


**Last hour activity and data console**

At the bottom of the device page the "Last hour activity" chart and the Data Console allow you to monitor the device activity.

By clicking in the left checkboxes you can navigate the published data, they will be presented on the bottom in the “Data inspector”.


###FOTA

The FOTA (Firmware Over The Air) update procedure can be used to update a device's formware remotely.

!!! important
	 In order to perform the FOTA of a device you need to virtualize it with a “Fota Enabled” virtual machine.

The first step to start a FOTA update on your devices is to prepare and upload a firmware to the ZDM cloud.

To upload your firmware, open the Zerynth Studio (**Note:** Zerynth studio v. 2.6.0 or higher is required). Open the project you want to compile and use for the FOTA and click on the Zerynth Device Manager Icon on the left vertical menu.

[ ![](img/zstudio1.png) ](img/zstudio1.png)

Now click on the ZDM FOTA Prepare button.

[ ![](img/zstudio2.png) ](img/zstudio2.png)

Select the ZDM device you want to update and indicate a unique firmware version identifier (you can’t reuse a version identifier previously used), click prepare.

[ ![](img/zstudio3.png) ](img/zstudio3.png)

When the firmware preparation and upload process will be completed Zerynth Studio will prompt you to another window. If you want to go ahead with the FOTA procedure click Open ZDM GUI.

You will be redirected to the ZDM selected device page.

Just click FOTA, select the firmware you just uploaded and click Start.

[ ![](img/fota.png) ](img/fota.png)

The FOTA procedure will be scheduled on your device. Refresh the device Status form and you will see the status of the FOTA procedure.

###Jobs
To send a job to one or many devices you can use the devices table or the single device page.
In the devices page, select one or more devices and click on the "Jobs" button. you will see the list of the jobs that the selected devices have in common.
To send a job to a device from the device page, click on the "Jobs" button at the top right.

[ ![](img/jobs.png) ](img/jobs.png)

You will have to select the job you want the device(s) to execute, with the possibility to add arguments as a json object.


!!! note
	If the selected devices do not have common Jobs, or if you select devices without custom Jobs defined in the firmware you will get the: “No Jobs found” message.

## Fleets

On the fleets page you can view a list of your fleets with the possibility to add new fleets or to delete them if there are not devices associated.

[ ![](img/fleetsPage.png) ](img/fleetsPage.png)


## Data management

"Data" tab allows you to see real time data published by all the devices of the workspace, ordered by descend timestamp by default. 
The data page auto-refresh every 10 seconds, but you can also pause it or change the refresh interval using the input at the bottom.
As for the device page, the data inspector allows you to view data in a JSON-like format.

[ ![](img/dataConsole.png) ](img/dataConsole.png)

It is possible to download you devices data clicking on the "Download data" button, that allows you to configure your download preferences including format and time range.

[ ![](img/dataDownload.png) ](img/dataDownload.png)


## Gates

Gates are the interfaces of the ZDM used to send your devices data to the extern.
There are 3 different kinds of gates:

* Webhooks
* Export gates
* Ubidots gates

Clicking on the "Gate" tab, you will see a list of your gates with the possibility to filter them by type.

[ ![](img/gatesList.png) ](img/gatesList.png)

To create a new Gate, click on the "New Gate" button and choose the gate type.

###Webhooks

A Webhook Gate sends periodically you devices data through a POST HTTP request. It requires a name, the URL to make the request to
and the time interval (in seconds).
You can also add optional fields as "Fleets" and "Tags" to filter on data, or a token if needed.

[ ![](img/newWebhook.png) ](img/newWebhook.png)


###Ubidots Gates

Ubidots Gates can be used to send your devices data to your Ubidots dashboard in real time.
To create a Ubidots Gate you need to specify a name, your ubidots account type, your ubidots device label,
the time interval (in seconds) between requests and your Ubidots API token.
You can also add optional tags and fleets to filter data.

[ ![](img/newUbidots.png) ](img/newUbidots.png)


###Export Gates

Export Gates can be used to periodically create export of your data and receive via email a link to download them.
To add a new Export Gate, you have to type a name, your e-mail address, the export format and frequency.
It's possible to add optional data filters for tags and fleets.

[ ![](img/newExportGate.png) ](img/newExportGate.png)



##Alerts

Clicking on the "Alerts" tab you will see a two-section page:

* A table containing all the alerts you have created
* The condition console

[ ![](img/alertsPage.png) ](img/alertsPage.png)

In this page you can see real time conditions sent by your devices and handle alerts.
If you create an alert, you will be notified when devices open and close conditions on specific tags declared at the moment of the alert creation.
To create a new alert, click on the "New Alert" button.

[ ![](img/newAlert.png) ](img/newAlert.png)

To create an alert, you have to specify a name, the conditions tags you want to be notified, the threshold a condition have to reach to be notified and the notifications configuration.


##Traffic monitoring

You can see details about ZDM usage and traffic consumption simply by clicking on the user avatar at the top right, then on "usage".

You will see the percentage of the traffic consumed and your data storage details (data retention, the oldest data date).

In the table below, there's a list of consumption details grouped by workspace.


[ ![](img/traffic.png) ](img/traffic.png)

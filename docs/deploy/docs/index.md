# Zerynth Device Manager
Zerynth Device Manager (ZDM) is a device and data management service that speeds up the development of scalable, secure and reliable IoT solutions.

Main features:

-   Devices onboarding and provisioning: enabled with gold-standard security practices;
    
-   Devices lifecycle control: allowing complex tasks like remote procedure call and over the air updates (FOTA) through REST APIs;
    
-   Data Management: storage, aggregation, plotting and feeding of data to the final IoT Application;
    
-   Easy integration with third parties services and frontends.
    

Each Zerynth user has access to the ZDM SaaS instance hosted on Zerynth servers. The ZDM can also be hosted on-premises, using container technology, on top cloud providers (such as Azure, AWS, IBM, Google), or on your server.

  

The Zerynth Device Manager is a device and data manager for IoT applications. Zerynth Device Manager helps you register, organize, monitor, and remotely manage IoT devices at scale. ZDM allows managing devices and also collects and aggregates the data they produce.

ZDM is device and OS independent, allowing the connection of microcontroller-based devices programmed in Zerynth but also microprocessor-based devices, like the Raspberry Pi and any other PC application.

This device produced data is collected, aggregated, and stored by the ZDM, allowing IoT application frontend to retrieve the data by means of RESTfull API or using the ZDM Gates.

![](https://raw.githubusercontent.com/zerynth/docs/test/docs/images/zdm-diagram.jpg)

The Zerynth Device Managers is based on the following key concepts;

-   A Device is the smallest entity you can find in the ZDM. It is represented by the physical IoT device connected with the ZDM via MQTT.
    
-   A workspace is the entity that groups and isolates devices and their produced data. You can imagine the workspace as the main folder of your project.
    
-   A fleet is a group of devices belonging to a workspace. You can use fleets to group devices with similar features and applications. Fleets allow sending bulk device commands, FOTA updates and Jobs;
    
-   A Tag is a data label used for querying and aggregating data. Each device can publish data on multiple tags and the ZDM will take care of aggregate and align them;
    
-   A Gate is an interface between the ZDM and an external service like your project frontend application. Gates are typically used to stream data out from the ZDM. In the beta version a Gate can stream data from one tag only, multiple tags gates will be added soon.
    
-   A Job is a command sent by the ZDM to a device. Jobs are used to activate device firmware functions like: reset, send status, and FOTA updates.
    

## How to access the ZDM

ZDM can be accessed via the web user interface available at [https://zdm.zerynth.com](https://zdm.zerynth.com/) or using the ZDM CLI (command line interface) that is integrated into the Zerynth SDK (download from [https://www.zerynth.com/zsdk/](https://www.zerynth.com/zsdk/)).

To use the ZDM service you need a Zerynth account, if you do not have it yet you can register to zerynth from [https://backend.zerynth.com/v1/sso](https://backend.zerynth.com/v1/sso)

  
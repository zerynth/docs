# Fleet
In the ZDM a fleet is a set of devices. 
When you log in for the first time, a ‘default’ workspace containing a ‘default’ fleet will be created. 

The main attributes of a fleet are:

* ```uid```, a unique id provided by the ZDM after the fleet creation command
* ```name```, a name given by the user to the fleet in order to identify it

List of fleet commands:

* Create
* List fleets
* Get a single fleet

## Fleet Creation
To create a new fleet of devices inside a workspace use the command:

```bash
zdm fleet create NAME WORKSPACE_UID
```
where ```NAME``` is the name you want to give to your new fleet and ```WORKSPACE_ID``` is the uid of the workspace that will contain the fleet.

## List Fleets
If you want to list all your fleets, you can use this command to have information about the associated workspace, and the list of devices inside:

```bash
zdm fleet all
```

## Get fleet

To get a single fleet information, you can use this command to see its name, the uid of the workspace that contains it and the list of devices inside:

```bash
zdm fleet get UID
```

where ```UID``` is the fleet uid

<!--stackedit_data:
eyJoaXN0b3J5IjpbNTAwMTg3NzUwXX0=
-->
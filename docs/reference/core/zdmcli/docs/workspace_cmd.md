# Workspace
A workspace is the entity that groups devices and their produced data. 
You can imagine the workspace as the main folder of your project.


## Create
Create a new workspace.

```bash
zdm workspace create NAME
```

Where:

* `NAME` is the name you want to give to your workspace

Options:

*  `--description TEXT`: Short description of the workspace


## Get
Get a single workspace.

```bash
zdm workspace get ID
```

Where:

* `ID` is the id of the workspace (e.g. `wks-000111aaabbc`)

## List
List all the workspace.

```bash
zdm workspace all
```


## Data 
Manage the data of a workspace.



### List
List the data published on a workspace on a given tag.

```bash
zdm workspace data all ID TAG
```

Where:

* `ID` is the id of the workspace 
* `TAG` is the tag of the published data

Options:

* `--device-id ID`   filter data by device id
*  `--start DATE`    start date filter (RFC3339)
*  `--end DATE`     end date filter (RFC3339

### Tags
Get the list of data tags of a workspace

```bash
zdm workspace data tags ID
```
Where:

* `ID` is the id of the workspace 

### Export
Export the data of a workspace. 
An export create a link where the data can be downloaded.

#### Create
Create an export for downloading the data. 

```sh
zdm workspace data export create NAME TYPE WORKSPACE_ID START END
```
Where:

* `NAME` is the name of the export
* `WORKSPACE_ID` is the id of the workspace 
* `START` is start date of the data in RFC339 format
* `END` is end data of the data in RFC339 format 

Options:

* `--tag TEXT`   filter data by a tag
* `--fleet TEXT`   filter data by a fleet id

#### Get
 Get the information of an export.

 ```bash
zdm workspace data export get EXPORT_ID
 ```

Where:

* `EXPORT_ID` is the id of the export


## Conditions 
Retrieve the conditions of a workspace associated to a tag.


### List
List all the conditions  of a workspace.

```bash
zdm workspace condition all ID TAG
```

Where:

* `ID` is the id of the workspace 
* `TAG` is the tag of the condition.

Options:

* `--device-id ID`   filter conditions by device id
* `--threshold TEXT`   filter conditions that are opened (or closed) greater than threshold secs (Default `0`)
* `--status [open|closed]`    filter conditions by its status (Default `open`)


# Workspace
A workspace is the entity that groups devices and their produced data. 
You can imagine the workspace as the main folder of your project.


## Create
Create a new workspace with a `NAME`.

```bash
zdm workspace create [OPTIONS] NAME
```


Options:

*  `--description TEXT`: Short description of the workspace


## Get
Get a single workspace by `ID`.

```bash
zdm workspace get ID
```


## List
List all the workspace.

```bash
zdm workspace all
```


## Data 
Manage the data of a workspace.



### List
List the data published on a workspace with `ID` on a given `TAG`.

```bash
zdm workspace data all [OPTIONS] ID TAG
```


Options:

* `--device-id ID`   filter data by device id
*  `--start DATE`    start date filter (RFC3339)
*  `--end DATE`     end date filter (RFC3339

### Tags
List the data tags of a workspace with `ID`.

```bash
zdm workspace data tags ID
```



### Export
Export the data of a workspace. 
An export create a link where the data can be downloaded.

#### Create
Create an export with `NAME` for downloading the data.
The export is of a given `TYPE` on a `WORKSPACE_ID` between a `START`date (RFC339 format) 
and `END`  date  (RFC339 format). 

```sh
zdm workspace data export create [OPTIONS]  NAME TYPE WORKSPACE_ID START END
```

Options:

* `--tag TEXT`   filter data by a tag
* `--fleet TEXT`   filter data by a fleet id

#### Get
Get the information of an export given the `EXPORT_ID`.

 ```bash
zdm workspace data export get EXPORT_ID
 ```


## Conditions 
Retrieve the conditions of a workspace associated to a tag.


### List
List all the conditions  of a workspace `ID` on a given condition `TAG`.

```bash
zdm workspace condition [OPTIONS] all ID TAG
```


Options:

* `--device-id ID`   filter conditions by device id
* `--threshold TEXT`   filter conditions that are opened (or closed) greater than threshold secs (Default `0`)
* `--status [open|closed]`    filter conditions by its status (Default `open`)

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk4NTczMzU3NF19
-->
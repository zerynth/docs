# Projects

A Zerynth project consists of a directory containing source code files, documentation files and other assets as needed.
The project directory must also contain a `.zproject` file containing information about the project. `.zproject` creation and management is completely handled by the ZTC.

The following project commands are available:


* create


* git_init and related repository management commands


* list remote projects


* make_doc

## Create a project

A project can be created by issuing the following command:

```
ztc project create title path
```

where `title` is a string (preferably enclosed in double quotes) representing the title of the project and `path` is the path to the directory that will hold the project files. If such directory does not exist, it is created. If a project already exists at `path`, the command fails.

An empty project consists of three files:


* `main.py`, the empty template for the entry point of the program.


* `readme.md`, a description file initially filled with project title and description in markdown format.


* `.zproject`, a project info file used by the ZTC.

Projects can also be stored remotely on the Zerynth backend as git repositories. In order to do so, during project creation, an attempt is made to create a new project entity on the backend and prepare it to receive git operations. If such attempt fails, the project is still usable locally and can be remotely added later.

The ```create``` can also accept the following options:


* `--from from` where `from` is a path. If the option is given, all files and directories stored at `from` will be recursively copied in the new project directory. If the project directory at `path` already exists, its contents will be deleted before copying from `from`.


* `--description desc` where `desc` is a string (preferably enclosed in double quotes) that will be written in `readme.md`

## Initialize a Git Repository

Projects can be stored as private remote git repositories on the Zerynth backend. In order to do so it is necessary to initialize a project as a git repository with the command:

```
ztc project git_init path
```

where `path` is the project directory.

If the project is not already registered in the backend, the remote creation is performed first and a bare remote repository is setup.
Subsequently, if the project directory already contains a git repository, such repository is configured by adding a new remote called `zerynth`. Otherwise a fresh git repository is initialized.

Zerynth remote repositories require authentication by basic HTTP authentication mechanism. The HTTPS url of the git repository is modified by adding the user token as username and `x-oath-basic` as password. If the token expires or is invalidated, the ```git_init``` command can be repeated to update the remote with a fresh token.

## Check repository status

The command:

```
ztc project git_status path
```

Returns information about the current status of the repository at `path`. In particular the current branch and tag, together with the list of modified files not yet committed.
It also returns the status of the repository HEAD with respect to the selected remote. The default remote is `zerynth` and can be changed with the option `--remote`.

## Fetch repository

The command:

```
ztc project git_fetch path
```

is equivalent to the `git fetch` command executed at `path'. The default remote is :samp:\`zerynth` and can be changed with the option `--remote`.

## Commit

The command:

```
ztc project git_commit path -m message
```

is equivalent to the command sequence `git add .` and `git commit -m "message"` executed at `path`.

## Push to remote

The command:

```
ztc project git_push path --remote remote
```

is equivalent to the command `git push origin remote` executed at `path`.

## Pull from remote

The command:

```
ztc project git_pull path --remote remote
```

is equivalent to the command `git pull` executed at `path` for remote `remote`.

## Switch/Create branch

The command:

```
ztc project git_branch path branch  --remote remote
```

behave differently if the `branch` already exists locally. In this case the command checks out the branch. If `branch` does not exist, it is created locally and pushed to the `remote`.

## Clone a project

The command:

```
ztc project git_clone project path
```

retrieves a project repository saved to the Zerynth backend and clones it to `path`. The parameter `project` is the project uid assigned dring project creation. It can be retrieved with the list command.

## Clone a project

The command:

```
ztc project git_clone project path
```

retrieves a project repository saved to the Zerynth backend and clones it to `path`. The parameter `project` is the project uid assigned dring project creation. It can be retrieved with the list command.

## List remote projects

The command:

```
ztc project list
```

retrieves the list of projects saved to the Zerynth backend. Each project is identified by an `uid`.
The max number of results is 50, the option `--from n` can be used to specify the starting index of the list to be retrieved.

## Build Documentation

A project can be documented in reStructuredText format and the corresponding HTML documentation can be generated by [Sphinx](http://www.sphinx-doc.org/en/1.5/). The process is automated by the following command:

```
ztc project make_doc path
```

where `path` is the path to the project directory.

If the command has never been run before on the project, some documentation accessory files are created. In particular:


* `docs` directory inside the project


* `docs/index.rst`, the main documentation file


* `docs/docs.json`, a configuration file to specify the structure of the documentation. When automatically created, it contains the following fields:


    * `title`, the title of the documentation


    * `version`, not used at the moment


    * `copyright`, not used at the moment


    * `text`, used for nested json files, see below


    * `files`, a list of tuples. The second element of the tuple is the file to be scanned for documentation: the first element of the tuple is the title of the corresponding generated documentation. The file types accepted are .py, .rst and .json. File paths are specified relative to the project directory.

All files specified in `docs.json` are processed:


* Python files are scanned for docstrings that are extracted to generate the corresponding .rst file inside `docs`.


* rst files are included in the documentation as is


* json files must have the same structure of `docs/docs.json` and generate a rst file containing the specified title, the field `text` (if given) as a preamble and a table of contents generated from the contents of the `files` field.

By default the documentation is generated in a temporary directory, but it can also be generated in a user specified directory by adding the option `--to doc_path` to the command. The option `--open` can be added to fire up the system browser and show the built documentation at the end of the command.

!!! note
	a `docs/__toc.rst` file is always generated containing the table of contents for the project documentation. It MUST be included in `docs/index.rst` in order to correctly build the documentation.

## Configure

The command:

```
ztc project config path -D ZERYNTH_SSL 1 -X ZERYNTH_SSL_ECDSA
```

configures some project variables that turn on and off advanced features for the project at `path`. In particular the `-D` option adds a new variable with its corresponding value to the project configuration, whereas the `-X` option remove a variable. Both options can be repeated multiple times.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzMDU0Mzg3NTddfQ==
-->
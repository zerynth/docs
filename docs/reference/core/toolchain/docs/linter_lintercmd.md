# Linter

The Zerynth Linter permits to check Python code against some of the style conventions.

In z-linter command is present a `--help` option to show to the users a brief description of the related command and its syntax including arguments and option informations.

The command return several log messages grouped in 4 main levels (info, warning, error, fatal) to inform the users about the results of the operation.
The action that can be executed on Zerynth Linter is:


* pep8: to check Python script with pep8 style convention

## Linter Command - pep8

This command is used to check a Python source code against Python Enhancement Proposals 8 (pep8)
coding convention from the command line with this syntax:

```py
Syntax:   ./ztc linter pep8 data --file --json
Example:  ./ztc linter pep8 script.py --file --json
```

This command take as input the following arguments:

    
    * ```data``` (str) –> data to check in raw string format or in path file format (```required```)


    * ```file``` (bool) –> select data source: if true is from a file, else is from string (```optional```, default=False)


    * ```json``` (bool) –> flag for output format: if true is in json format (```optional```; default=False)

```Errors```:

    
    * Missing required input data
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5NjkwMTg2MzddfQ==
-->
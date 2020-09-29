# Synopsis

The ZTC is launched by typing ```ztc``` in a console.

!!! note
	In Windows and Mac installations, the `PATH` environmental variable is automatically updated in such a way that ```ztc``` is globally available for the user. In Linux installations, due to the many different shells, the `PATH` must be set manually to the following path: `<installation-dir>/ztc/linux64`.

```ztc``` takes commands and options as arguments:

```py
ztc [g_options] [command] [l_options]
```


* [g_options] are global options that alter the behaviour of all subcommands


* [command] is a specific command for the available list of commands


* [l_options] are options specific to the command and are documented in each command section

## Global options

The following global options are accepted by ```ztc```


* `--help` shows the global options and avaialable commands. `--help` can also be used as a local option showing the help relative to the given command.


* `--colors / --no-colors` enables/disables colored output. Default is enabled. ```ztc``` automatically detect if it is launched in a terminal capable of colored output and disables colors if not supported.


* `--traceback / --no-traceback` enables/disables the full output for exceptions. The ZTC is written in Python and in case of unexpected errors can output the full Python traceback for debugging purposes.


* `--user-agent agent` set the user-agent http header used in REST calls. It is used to monitor the integration of the ZTC in different tools. In general the `agent` value should be the name of the tool integrating the ZTC. The value `ztc` and `ide` are reserved for command line usage of the ZTC or usage through Zerynth Studio, respectively.


* `-J` enables the JSON output for commands. It is generally used by external tools using the ZTC to get easily machine readable output. If the `-J` is not given, the output of commands is more human readable.


* `--pretty` is used in conjuction with `-J` and produces nicely formatted JSON output.

<!-- _ztc-cmd-list -->
## Command List

The ZTC contains many different commands and each one may take subcommand as additional parameters. Commands are best listed by grouping them by functionality as follows.


* Account related commands


* Project related commands


* Device related commands


* Virtual Machine related commands


* Compile command


* Uplink command


* Package related commands


* Namespace related commands


* Other commands

## Output conventions

All commands can produce tagged and untagged messages. Tagged messages are prefixed by `[type]` where `type` can be one of:


* `info`: informative message, printed to `stdout`


* `warning`: warning message, printed to `stderr`


* `error`: error message, printed to `stderr`. Signals a non fatal error condition without stopping the execution


* `fatal`: error message, printed to `stderr`. Signals a fatal error condition stopping the execution and setting an error return value. It can optionally be followed by a Python traceback in case of unexpected Exception.

Untagged messages are not colored and not prefixed. The result of a command  generally consists of one or more untagged messages. If the `-J` option is given without `--pretty`, almost every command output is a single untagged line.

## Directories

The ZTC is organized on disk in a set of directories stored under `~/zerynth2` for Linux and Mac or under `C:Usersusernamezerynth2` for Windows. The following directory tree is created:

```py
zerynth2
|
|--cfg    # configuration files, device database, clone of online package database
|
|--sys    # system packages, platform dependent
|
|--vms    # virtual machines storage
|
\--dist   # all installed ZTC versions
    |
    |--r2.0.0  # ZTC version r2.0.0
    |--r2.0.1  # ZTC version r2.0.1
    |
    .
    .
```

Every successful ZTC installation or update is kept in a separate directory (`dist/version`) so that in case of corrupted installation, the previous working ZTC can be used.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTY3OTY4ODUzOF19
-->
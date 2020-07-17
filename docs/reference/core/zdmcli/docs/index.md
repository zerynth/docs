# The ZDM Command Line Interface 

The Zerynth Device Manager Command Line Interface (ZDM CLI) permit to interact with the ZDM via a command line interface.
This section is a guide for the most used of the ZDM CLI commands.

## Installation

The ZDM CLI is installed together the Zerynth Sdk.

!!! Important
	This guide assumes you are using the Zerynth >= r2.6.0. Download it [here](https://www.zerynth.com/zsdk/) or update to the latest version!


In order to use the ZDM CLI

1.  Download and install Zerynth Studio [here](https://www.zerynth.com/zsdk/).
2.  Add the `zdm` command to the os path.
    
    *   On **Linux**: open the terminal and launch the following command:
        
        ```bash
        ~/.zerynth2/sys/cli/zpm setpaths
        ```
    
    * On **Windows**: open the command prompt as _administrator_ and launch the following command:
        ```bash
        %userprofile%\zerynth2\sys\cli\zpm setpaths
        ```
    
    * On **Mac**: open the terminal and launch the following command:
      ```bash
      ~/.zerynth2/sys/cli/zpm setpaths
      ```

!!! Important
	Make sure to close and reopen the terminal after the command presented on step 2

##  Use the ZDM command line
The list of available commands, either launch `zdm` or `zdm --help`.

```
zdm [OPTIONS] COMMAND [ARGS]...

  Zerynth Device Manger (ZDM) command line interface

Options:
  -v                            Verbose.
  --colors / --no-colors        To enable/disable colors.
  --traceback / --no-traceback  To enable/disable exception traceback printing
                                on criticals.

  --user_agent TEXT             To insert custom user agent.
  --pretty                      To display pretty json output.
  -J                            To display the output in json format.
  --help                        Show this message and exit.

Commands:
  device     Manage the devices
  fleet      Manage the fleets
  fota       Manage the FOTA update
  gate       Manage the gates
  job        Manage the jobs
  login      Obtain an authentication token
  logout     Delete the current session
  workspace  Manage the workspaces


```


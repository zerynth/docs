# Miscellanea

Non specific commands are grouped in this section.

## Linter

Not documented yet.

## Info

The ```info``` command  displays information about the status of the ZTC.

It takes the following options (one at a time):


* `--version` display the current version of the ZTC.


* `--fullversion` display the current version of the ZTC together with current update.


* `--devices` display the list of supported devices currently installed.


* `--tools` display the list of available ZTC tools. A ZTC tool is a third party program used to accomplish a particular task. For example the gcc compiler for various architecture is a ZTC tool.


* `--modules` display the list of installed Zerynth libraries that can be imported in a Zerynth program.


* `--examples` display the list of installed examples gathered from all the installed libraries.


* `--vms target` display the list of virtual machines in the current installation for the specified `target`


* `--messages` display the list of unread system messages

## Clean

The ```clean``` command behave differently based on the following options:


* `--tmp` if given clears the temporary folder.


* `--inst version` can be repeated multiple times and removes a previous installed `version` of Zerynth


* `--db` if given forgets all devices (clears all devices from database).

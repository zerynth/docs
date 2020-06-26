# Firmware Over the Air update (FOTA)

This module enables access to VM functionalities for updating firmware and/or VM at runtime.
It can be safely imported in every program, however its functions will raise UnsupportedError if the target VM is not enabled
for FOTA features (**a premium VM with the OTA feature enabled is needed**).

In Zerynth FOTA can be performed for bytecode only or for bytecode and VM if the target device supports a multiple VM layout.
In order to support FOTA updates, the flash memory of the target device is divided in segments that can hold either a VM or bytecode.
Moreover a small segment of persistent memory (not necessary flash) must be allocated to store the current and desired state of the firmware (FOTA record).

The following layouts show different flash organization for FOTA support:

```
  Support for FOTA update of bytecode only
|------------------------------------------------------------------------------|
|                  |                           |                           |   |
|       VM         |      Bytecode Slot 0      |      Bytecode Slot 1      |   | <-- FOTA Record
|                  |                           |                           |   |
|------------------------------------------------------------------------------|

  Support for FOTA update of bytecode and VM
|------------------------------------------------------------------------------|
|              |                      |             |                      |   |
|    VM 0      |    Bytecode Slot 0   |   VM 1      |    Bytecode Slot 1   |   | <-- FOTA Record
|              |                      |             |                      |   |
|------------------------------------------------------------------------------|
```

## FOTA process for bytecode only

The FOTA process consists of the following steps:


* check the FOTA record structure to ensure that the current VM+Bytecode slot configuration is functioning correctly (`get_record()`)


* identify the available slot for the new bytecode (`find_bytecode_slot()`)


* erase the bytecode slot to make room for new bytecode (`erase_slot()`)


* write the binary representation of the new bytecode to the slot (`write_slot()`)


* optionally check that the new bytecode has been written correctly (`checksum_slot()`)


* modify the FOTA record with the new desired configuration (`attempt()`)


* restart the VM in the new configuration (`restart()`)


* the new bytecode should check that everything is ok and confirm the configuration (`accept()`). In case the new bytecode is faulty, a simple restart will bring the system back in the previously working configuration.

## FOTA process for bytecode and VM

For some target devices it is possible to change both the bytecode and the VM in a single FOTA process.

The FOTA process in this case consists of the following steps:


* check the FOTA record structure to ensure that the current VM+Bytecode slot configuration is functioning correctly (`get_record()`)


* identify the available slot for the new bytecode (`find_bytecode_slot()`) and for the new VM (`find_vm_slot()`)


* erase the bytecode slot and vm slot to make room for new firmware (`erase_slot()`)


* write the binary representation of the new bytecode and vm to the slots (`write_slot()`)


* optionally check that the new bytecode and vm have been written correctly (`checksum_slot()`)


* modify the FOTA record with the new desired configuration (`attempt()`)


* restart the VM in the new configuration (`restart()`)


* the previous VM will start and behave as a bootloader passing control to the new VM


* the new bytecode should check that everything is ok and confirm the configuration (`accept()`). In case the new bytecode is faulty, a simple restart will bring the system back in the previously working configuration.

## FOTA functions


`get_record()`

Return the FOTA record (fota) as a tuple of integers following this scheme:


* fota[0] is 0 if the FOTA record is not valid


* fota[1] is the index of the FOTA VM


* fota[2] is the slot of the current VM (as an index starting from 0)


* fota[3] is the slot of the last working VM (as an index starting from 0)


* fota[4] is the slot of the current bytecode (as an index starting from 0)


* fota[5] is the slot of the last working bytecode (as an index starting from 0)


* fota[6] is the flash address of the current bytecode


* fota[7] is the flash address of the current VM


* fota[8] is the OTA chunk


`set_record(newfota)`

Set the FOTA record (fota) to the values in newfota according to this scheme:


* fota[2] = newfota[0], sets the current VM for next restart


* fota[3] = newfota[1], sets the last working VM


* fota[4] = newfota[2], set the current bytecode for the next restart


* fota[5] = newfota[3], set the last working bytecode

All other fota elements are managed by the VM and cannot be changed


`find_bytecode_slot()`

Return the address of next available bytecode slot.


`find_vm_slot()`

Return the address of the next available vm slot. If the result of the function is equal to fota[7], the current VM does not support VM updates.


`erase_slot(addr, size)`

Erase the slot (either bytecode or VM) starting at `addr` for at least `size` bytes. Since flash memories are often organized in sectors, the erased size can be larger than the requested size.


`write_slot(addr, block)`

Write `block` (bytes, bytearray or string) at `addr` where `addr` is an address contained in a bytecode or VM slot. This function does not keep count of the written blocks, it is up to the programmer to update the address correctly.


`close_slot(addr)`

This function must be called once at the end of the operations (write, erase, …) on a specific `addr` where `addr` is an address contained in a bytecode or VM slot.


`checksum_slot(addr, size)`

Return the MD5 checksum (as a bytes object) of the slot starting at `addr` and extending for `size` bytes.


`restart()`

Reset the microcontroller and restart the system


`accept()`

Modify the FOTA record to make the current configuration the last working configuration. Must be called by the new bytecode in order to end the FOTA process correctly.


`attempt(bcslot, vmslot)`

Modify the FOTA record to make `bcslot` and `vmslot` (expressed as indexes starting from 0), the test configuration to be tried on restart.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTg2NTU0NTQwMF19
-->
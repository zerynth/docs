# VM

This module enables inspecting the running VM and controlling some runtime options.


**`info()`**

Return info about the running Virtual Machine. The result is a tuple with 9 elements:


* Virtual Machine unique identifier (string)


* Target device (string)


* Virtual Machine version (string)


* The RAM address where C memory starts


* The Unix timestamp at which the bytecode was compiled


* A 32bit integer customizable at compilation time (not yet supported, set at zero)


* The bytecode version


* The bytecode options (not yet supported, set at 0)


* The bytecode size


**`set_option(opt, value)`**

Set the VM Option `opt` to `value`. The following constants are avaiable for `opt`:


* `VM_OPT_RESET_ON_EXCEPTION` : if `value` is 0, uncaught Python exception do not cause a microcontroller reset


* `VM_OPT_TRACE_ON_EXCEPTION` : if `value` is 0, uncaught Python exception are not printed to console


* `VM_OPT_RESET_ON_HARDFAULT` : if `value` is 0, microcontroller Hard Fault do not cause a microcontroller reset


* `VM_OPT_TRACE_ON_HARDFAULT` : if `value` is 0, microcontroller Hard Fault dumps are not printed to console

The functionalities for Hard Fault are not consistent across different microcontrollers due to different behaviours/capabilities of the underlying SDK.


**`get_option(opt)`**

Retrieve the value of `opt`. Refer to `set_option()` for a description of `opt`.


**`encrypt(bin, nonce=0)`**

Return an encrypted copy of `bin`. The encrypted data is secured with a key which is unique per device and can only be
decrypted by the same device that performed the encryption. To increase the key space, an integer `nonce` can be given
that must be passed also for decryption.

Raise `ValueError` if len(bin)<8


**`decrypt(bin, nonce=0)`**

Return a decrypted copy of `bin`. To increase the key space, an integer `nonce` can be given
that must be the same one given for encryption.

Raise `ValueError` if len(bin)<8
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTExNzkzMzI3NywtMTUyOTM3NzY5OV19
-->
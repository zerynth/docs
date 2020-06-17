# ATECCx08A library

This module exports classes for Microchip ATECCx08A chip family and some utilities functions.

Furthermore an interface to allow the use of chip-related functionalities from other Zerynth hybrid C/Python libraries is made available.

## Auxiliary methods


**`crc16(data:bytes)`**

Compute the CRC16 checksum for some bytes.
The CRC is calculated using 0x8005 as polynomial and starting with the registry set as 0x00.


* ```Arguments```

    
    * ```data``` (```bytes```) – bytes to be checksummed.



* ```Returns```

    2 bytes, representing the computed checksum.



* **Return type**

    bytes


## ATECC508A class


**`class ATECC508A(i2c.I2C)`**

Class for controlling the ATECC508A chip.

Members:

* device_awake : Boolean. If True the device is running a multiple commands sequence.

**`__init__(drvname,addr=DEFAULT_ADDR,clk=100000)`**

Connect to a device and start I2C protocol.


**`Arguments:`**

    
**drvname** – Interface for I2C communication (e.g. I2C0)

**addr** (*int [0-255]*) – Address of the I2C chip. (Default value = 0x60 for ATECC508A)


clk(int) – Clock rate of the I2C communication in kHz. (Default value = 100000).


### Internal methods


---
#### `#!py3 _send_cmd()`

!!!abstract "`#!py3 _send_cmd(self, opcode, param1, param2: bytes, data=bytes())`"

Send a command packet to the device.

Output packet structure:

    [ 0x03 ][ length ][ opcode ][ p1 ][ p2 ][ …data… ][ crc ]


    * 0x03 is a constant defined in WORD_ADDRS at the beginning of this module.


    * length includes every bytes except the first 0x03 byte.


    * p1 is byte of length 1. (mandatory)


    * p2 is bytes of length 2. (mandatory)


    * data is optional and can have arbitraty length.


    * crc is a 2 byte checksum (calculated using `ecc508a.crc16()`).


* ```Arguments```

    
    * ```opcode``` (```int```) – The code representing the selected command.
    Check OPCODES at the beginning of this module.


    * ```param1``` (```int```) – The first mandatory parameter. 1 byte long.


    * ```param2``` (```bytes```) – The second mandatory parameter. 2 bytes long.


    * ```data``` (```bytes```) – Other optional data. (Default value = bytes())



---
#### `#!py3 _read_result()`

!!!abstract "`#!py3 _read_result()`"

Read, verify checksum, and extract data of a packet from the device.

Input packet structure:

    [ length ][ …data… ][ crc ]


* ```Returns```

    the extracted data bytes.



* **Return type**

    bytes


Note:

    Length includes itself (1 byte), data (n bytes), and crc16 (2 bytes).

### Public methods


---
#### `#!py3 start_cmd_sequence()`

!!!abstract "`#!py3 start_cmd_sequence()`"

Call this function before a command sequence to wake up device from idle mode.

This is done by keeping SDA low for more than 60 microseconds.

Note:

    At this moment a 0x00 byte is written as a normal I2C transaction, ignoring
    the exception raised.
    This workaround won’t work at higher clock rates (more than ~100 kHz)!


---
#### `#!py3 end_cmd_sequence()`

!!!abstract "`#!py3 end_cmd_sequence()`"

Call this function at the end of a command sequence to put the device in idle mode.

This must be done in order to avoid hitting the watchdog timeout (~1 second) which will
put the device in idle mode no matter what.


---
#### `#!py3 send_and_read()`

!!!abstract "`#!py3 send_and_read(\*args)`"

Send a command and return the result data.

Note:

    If `start_cmd_sequence()` was not invoked before this method, the device
    is automatically woke up and put again in idle mode after the command execution.
    (Default value = 50)


* ```Arguments```

    
    * **\```args``` – All arguments are passed to `_send_cmd()` method.



### Commands

The functions names are the lowercase command name followed by _cmd.
Parameters are command specific.

A command usually return some bytes as the result of the command execution, or a status
code.


---
#### `#!py3 checkmac_cmd()`

!!!abstract "`#!py3 checkmac_cmd(tempkey_as_message_source: bool, tempkey_as_first_block: bool, source_flag: int, key_id: bytes, challenge: bytes, response: bytes, other_data: bytes)`"

Verify a MAC calculated on another CryptoAuthentication device.


* ```Arguments```

    
    * ```tempkey_as_message_source``` (```bool```) – If False the second 32 bytes of the SHA message
    are taken from challenge parameter, otherwise they are taken from TempKey.


    * ```tempkey_as_first_block``` (```bool```) – If False Slot<KeyID> in first SHA block is used,
    otherwise TempKey is.


    * ```source_flag``` (```int```) – Single bit. If tempkey_as_message_source or
    tempkey_as_first_block are set to True, then the value of this bit must match
    the value in TempKey.SourceFlag or the command will return an error.
    The flag is the fourth bit returned by info_cmd(‘State’).


    * ```key_id``` (```bytes```) – Internal key used to generate the response. All except last four
    bits are ignored.


    * ```challenge``` (```bytes```) – 32 bytes, challenge sent to client.
    If tempkey_as_message_source is True, this parameter will be ignored.


    * ```response``` (```bytes```) – 32 bytes, response generated by the client.


    * ```other_data``` (```bytes```) – 13 bytes, remaining constant data needed for response
    calculation.



* ```Returns```

    True if response matches the computed digest, False otherwise.



* **Return type**

    bool



---
#### `#!py3 read_counter_cmd()`

!!!abstract "`#!py3 read_counter_cmd(key_id)`"

Read one of the two monotonic counters.


* ```Arguments```

    
    * ```key_id``` (```int```) – The specified counter. Can be 0 or 1.



* ```Returns```

    4 bytes representing the current value of the counter, or 1 byte representing
    a status code.



* **Return type**

    bytes



---
#### `#!py3 inc_counter_cmd()`

!!!abstract "`#!py3 inc_counter_cmd(key_id)`"

Increment one of the two monotonic counters.

The maximum value that the counter may have is 2,097,151.
Any attempt to count beyond this value will result in an error code.


* ```Arguments```

    
    * ```key_id``` (```int```) – The specified counter. Can be 0 or 1.



* ```Returns```

    4 bytes representing the current value of the counter, or 1 byte representing
    a status code.



* **Return type**

    bytes



---
#### `#!py3 derivekey_cmd()`

!!!abstract "`#!py3 derivekey_cmd(source_flag: int, target_key: bytes, mac=bytes())`"

The device combines the current value of a key with the nonce stored in TempKey using
SHA-256 and places the result into the target key slot.

Prior to execution of this command, `nonce_cmd()` must have been run to
create a valid nonce in TempKey.

For full documentation check datasheet at pages 63-64.


* ```Arguments```

    
    * ```source_flag``` (```int```) – Single bit (1 or 0). The value of this bit must match the value
    in TempKey.SourceFlag or the command will return an error.
    The flag is the fourth bit returned by `info_cmd()`.


    * ```target_key``` (```bytes```) – 2 bytes. Key slot to be written.


    * ```mac``` (```bytes```) – MAC used to validate the operation. (Default value = bytes())



* ```Returns```

    True if the operation completed successfully.



* **Return type**

    bool



---
#### `#!py3 ecdh_cmd()`

!!!abstract "`#!py3 ecdh_cmd(key_id: bytes, x_comp: bytes, y_comp: bytes)`"

Generate an ECDH master secret using stored private key and input public key.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – The private key to be used in the ECDH calculation.


    * ```x_comp``` (```bytes```) – The X component of the public key to be used for ECDH calculation.


    * ```y_comp``` (```bytes```) – The Y component of the public key to be used for ECDH calculation.



* ```Returns```

    If any error occured, the error code.
    If specified by SlotConfig.ReadKey<3>, the shared secret.
    Otherwise the success code 0x00.



* **Return type**

    bytes



---
#### `#!py3 gendig_cmd()`

!!!abstract "`#!py3 gendig_cmd(self, zone: int, key_id: bytes, other_data=bytes())`"

Generate a data digest from a random or input seed and a key.

See datasheet page 66-69 for full usage details.


* ```Arguments```

    
    * ```zone``` (```int```) – Possible values are numbers between 0 and 5 (included).

    If 0x00 (Config), then use key_id to specify any of the four 256-bit blocks
    of the Configuration zone. If key_id has a value greater than three, the
    command will return an error.

    If 0x01 (OTP), use key_id to specify either the first or second 256-bit block
    of the OTP zone.

    If 0x02 (Data), then key_id specifies a slot in the Data zone or a transport
    key in the hardware array.

    If 0x03 (Shared Nonce), then key_id specifies the location of the input value
    in the message generation.

    If 0x04 (Counter), then key_id specifies the monotonic counter ID to be
    included in the message generation.

    If 0x05 (Key Config), then key_id specifies the slot for which the
    configuration information is to be included in the message generation.



    * ```key_id``` (```bytes```) – Identification number of the key to be used, selection of which OTP
    block or message order for Shared Nonce mode.


    * ```other_data``` (```bytes```) – 4 bytes of data for SHA calculation when using a NoMac
    key, 32 bytes for “Shared Nonce” mode, otherwise ignored.
    (Default value = bytes())



* ```Returns```

    True if the operation completed successfully.



* **Return type**

    bool



---
#### `#!py3 gen_private_key()`

!!!abstract "`#!py3 gen_private_key(self, key_slot: int, create_digest=False, other_data=bytes(3))`"

Generate an ECC private key.


* ```Arguments```

    
    * ```key_slot``` (```bytes```) – Specifies the slot where the private ECC key is generated.


    * ```create_digest``` (```bool```) – If True the device creates a PubKey digest based on the
    private key in KeyID and places it in TempKey (ignored if create_digest is
    False).


    * ```other_data``` (```bytes```) – 3 bytes, used in the creation of the message used as input for
    the digest algorithm.



* ```Returns```

    64 bytes representing public key X and Y coordinates or 1 byte representing
    a status code if an error occured.



* **Return type**

    bytes



---
#### `#!py3 gen_public_key()`

!!!abstract "`#!py3 gen_public_key(self, key_slot: int, create_digest=False, other_data=bytes(3))`"

Generate the ECC public key starting from a private key.


* ```Arguments```

    
    * ```key_slot``` (```int```) – Specifies the slot where the private ECC key is.


    * ```create_digest``` (```bool```) – If True the device creates a PubKey digest based on the
    private key in KeyID and places it in TempKey (ignored if create_digest is
    False).


    * ```other_data``` (```bytes```) – 3 bytes, used in the creation of the message used as input for
    the digest algorithm.



* ```Returns```

    64 bytes representing public key X and Y coordinates or 1 byte representing
    a status code if an error occured.



* **Return type**

    bytes



---
#### `#!py3 gen_digest_cmd()`

!!!abstract "`#!py3 gen_digest_cmd(self, key_id: bytes, other_data: bytes)`"

Generate a digest and store it in TempKey, using key_id as public key.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – Specifies the slot where the public ECC key is.


    * ```other_data``` (```bytes```) – 3 bytes, used in the creation of the message used as input for
    the digest algorithm.



* ```Returns```

    64 bytes representing public key X and Y coordinates or 1 byte representing
    a status code if an error occured.



* **Return type**

    bytes



---
#### `#!py3 hmac_cmd()`

!!!abstract "`#!py3 hmac_cmd(self, source_flag: int, key_id: bytes, include_sn: bool)`"

Calculate response from key and other internal data using HMAC/SHA-256.


* ```Arguments```

    
    * ```source_flag``` (```int```) – Single bit. The value of this bit must match the value in
    TempKey.SourceFlag (1 = True, 0 = False) or the command will return an error.
    The flag is the fourth bit returned by info_cmd(‘State’).


    * ```key_id``` (```bytes```) – Specifies the slot where the key is.
    Note that while only last four bits are used to select a slot, all the two
    bytes will be included in the digest message.


    * ```include_sn``` (```bool```) – If True, 48 bits from Configuration Zone are included in the
    digest message.



* ```Returns```

    32 bytes, the computed HMAC digest.



* **Return type**

    bytes



---
#### `#!py3 info_cmd()`

!!!abstract "`#!py3 info_cmd(self, mode: str, param=bytes(2))`"

Return device state information.
The information read can be static or dynamic.


* ```Arguments```

    
    * ```zone``` (```str```) – Zone to read byte from. The value is case insensitive and can be one of
    Revision, KeyValid, State, GPIO.


    * ```param``` (```bytes```) – Second parameter (Default value = bytes(2))



* ```Returns```

    4 bytes read from the device or 1 byte status code



* **Return type**

    bytes



---
#### `#!py3 lock_config_zone_cmd()`

!!!abstract "`#!py3 lock_config_zone_cmd(self, checksum: bytes=None)`"

Prevent further modifications to the Config zone of the device.


* ```Arguments```

    
    * ```checksum``` (```bytes```) – 2 bytes representing a CRC summary of the zone.
    If set the checksum is verified from the device prior locking.
    (Default value = None)



* ```Returns```

    Single byte 0 if the operation completed successfully.



* **Return type**

    bytes



---
#### `#!py3 lock_data_zone_cmd()`

!!!abstract "`#!py3 lock_data_zone_cmd(checksum: bytes = None)`"

Prevent further modifications to the Data and OTP zones of the device.


* ```Arguments```

    
    * ```checksum``` (```bytes```) – 2 bytes representing a CRC summary of the zone.
    If set the checksum is verified from the device prior locking.
    (Default value = None)



* ```Returns```

    Single byte 0 if the operation completed successfully.



* **Return type**

    bytes



---
#### `#!py3 lock_single_slot_cmd()`

!!!abstract "`#!py3 lock_single_slot_cmd(self, slot_number: int)`"

Prevent further modifications to a single slot of the device.


* ```Arguments```

    
    * ```slot_number``` (```int```) – Slot ID to be locked, valid values are the numbers in range 0-15
    (included).



* ```Returns```

    Single byte 0 if the operation completed successfully.



* **Return type**

    bytes



---
#### `#!py3 mac_cmd()`

!!!abstract "`#!py3 mac_cmd(self, key_id: bytes, use_tempkey: bool, include_sn: bool, source_flag: int = 0, challenge: bytes = bytes())`"

Compute a SHA-256 digest from key and other internal data using SHA-256.

The normal command flow to use this command is as follows:

1. Run Nonce command to load input challenge and optionally combine it with a
generated random number. The result of this operation is a nonce stored internally
on the device.

2. Optionally, run GenDig command to combine one or more stored EEPROM locations
in the device with the nonce. The result is stored internally in the device.
This capability permits two or more keys to be used as part of the response
generation.

3. Run this MAC command to combine the output of step one (and step two if desired)
with an EEPROM key to generate an output response (i.e. digest).

```NOTE```: source_flag MUST be specified if use_tempkey is True or a challenge
is used.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – 2 bytes. Specifies the slot where the key is.
    Note that while only last four bits are used to select a slot, all the two
    bytes will be included in the digest message.


    * ```use_tempkey``` (```bool```) – If False the first 32 bytes of the SHA message are loaded from
    one of the data slots. Otherwise the first 32 bytes are filled with TempKey
    (and source_flag must be used).


    * ```include_sn``` (```bool```) – If True, 48 bits from Configuration Zone are included in the
    digest message.


    * ```source_flag``` (```int```) – Single bit. The value of this bit must match the value
    in TempKey.SourceFlag (1 = True, 0 = False) or the command will return an error.
    The flag is the fourth bit returned by info_cmd(‘State’).
    (Default value = 0)


    * ```challenge``` (```bytes```) – 32 bytes. If specified, it will be used in the input
    of the algorithm. (Default value = bytes())



* ```Returns```

    32 bytes, the computed SHA-256 digest.



* **Return type**

    bytes



---
#### `#!py3 nonce_cmd()`

!!!abstract "`#!py3 nonce_cmd(self, use_tempkey: bool, num_in: bytes, force_no_eeprom_update: bool = False)`"

Generate a 32-byte random number and an internally stored Nonce.

The body used to create the nonce is stored internally in TempKey.


* ```Arguments```

    
    * ```use_tempkey``` (```bool```) – TempKey is used instead of the RNG in the hash calculation input
    (message). TempKey is also returned by this command.
    TempKey must be valid prior to execution of this command and the values of the
    remaining TempKey flags remain unchanged.


    * ```num_in``` (```bytes```) – 20 bytes, the input parameter.


    * ```force_no_eeprom_update``` (```bool```) – If True, the EEPROM is not updated before the RNG
    generation (the existing EEPROM is used, not recommended).
    (Default value = False)



* ```Returns```

    TempKey (32 bytes) if use_tempkey is True. Otherwise the RNG output.



* **Return type**

    bytes



---
#### `#!py3 nonce_passthrough_cmd()`

!!!abstract "`#!py3 nonce_passthrough_cmd(self, num_in: bytes)`"

Pass-through mode of the Nonce command.

TempKey is loaded with NumIn. No SHA-256 calculation is performed, and
TempKey.SourceFlag is set to Input.
(No data is returned to the system in this mode).


* ```Arguments```

    
    * ```num_in``` (```bytes```) – 32 bytes, input parameter.



* ```Returns```

    Single byte 0 if the operation completed successfully.



* **Return type**

    bytes



---
#### `#!py3 privwrite_cmd()`

!!!abstract "`#!py3 privwrite_cmd(self, encrypt_input: bool, key_id: bytes, value: bytes, mac: bytes)`"

Write an ECC private key into a slot in the Data zone.

For best security, PrivWrite should not be used, and private keys should be internally
generated from the RNG using gen_private_key command.

The slot indicated by this command must be configured via KeyConfig.Private to contain
an ECC private key, and SlotConfig.IsSecret must be set to one.

See datasheet page 80 for full details.


* ```Arguments```

    
    * ```encrypt_input``` (```bool```) – If True, the input data is encrypt using TempKey.
    Otherwise, the input data is not encrypted - this is valid only when Data zone
    is unlocked.


    * ```key_id``` (```bytes```) – 2 bytes, slot id to be written.


    * ```value``` (```bytes```) – 36 bytes integer. Information to be written to the slot, first 4
    bytes should be zero.


    * ```mac``` (```bytes```) – 32 bytes. Message Authentication Code to validate EEPROM Write
    operation.



* ```Returns```

    Single byte 0 if the operation completed successfully.



* **Return type**

    bytes



---
#### `#!py3 random_cmd()`

!!!abstract "`#!py3 random_cmd(self, force_no_eeprom_update=False)`"

Generate a random number.
The number is generated using a seed stored in the EEPROM and a hardware RNG.


* ```Arguments```

    
    * ```force_no_eeprom_update``` (```bool```) – If True, the EEPROM is not updated before the RNG
    generation (the existing EEPROM is used, not recommended).
    (Default value = False)



* ```Returns```

    32 bytes, output of RNG.
    Prior to the configuration zone being locked, the RNG produces a value of
    0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00 to facilitate testing.



* **Return type**

    bytes



---
#### `#!py3 read_cmd()`

!!!abstract "`#!py3 read_cmd(self, zone: str, address: bytes, read_32_bytes: bool)`"

Read bytes from the device.

This command can read bytes from an address of one of the memory zones

See datasheet page 10 for zones details.


* ```Arguments```

    
    * ```zone``` (```str```) – Select the source zone. Must be one of Config, OTP or Data.


    * ```address``` (```bytes```) – 2 bytes address of the first word to be read.
    See datasheet page 58 for correct formats.


    * ```read_32_bytes``` (```bool```) – If True, 32 bytes are read and returned. Otherwise
    4 bytes are read and returned.



* ```Returns```

    A single word (4 bytes) or a 8-words block (32 bytes), depending on
    the read_32_bytes parameter.

    The bytes can be encrypted depending on the zone and the device status.

    See datasheet page 81 for usage details.




* **Return type**

    bytes



---
#### `#!py3 sha_start_cmd()`

!!!abstract "`#!py3 sha_start_cmd(self)`"

Start a SHA-256 digest computation.
This command must be run before sha_end_cmd().


* ```Returns```

    Single byte 0 if the operation completed correctly.



* **Return type**

    bytes



---
#### `#!py3 sha_hmacstart_cmd()`

!!!abstract "`#!py3 sha_hmacstart_cmd(self, key_id: bytes)`"

Start a HMAC digest computation.

This command must be run before `sha_hmacend_cmd()`.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – Id of the HMAC key.



* ```Returns```

    Single byte 0 if the operation completed correctly.



* **Return type**

    bytes



---
#### `#!py3 sha_update_cmd()`

!!!abstract "`#!py3 sha_update_cmd(self, message: bytes)`"

Add 64 bytes in the message parameter to the SHA context.

This command must be run after `sha_start_cmd()` or                `sha_hmacstart_cmd()`.


* ```Arguments```

    
    * ```message``` (```bytes```) – 64 bytes, to be added in the SHA context.



* ```Returns```

    Single byte 0 if the operation completed correctly.



* **Return type**

    bytes



---
#### `#!py3 sha_public_cmd()`

!!!abstract "`#!py3 sha_public_cmd(self, key_id: bytes)`"

Add 64 bytes of a public key stored in one of the Data zone slots to the SHA context.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – The slot id of the public key.



* ```Returns```

    Single byte 0 if the operation completed successfully, or an error if the slot
    contains anything other than a public key.



* **Return type**

    bytes



---
#### `#!py3 sha_end_cmd()`

!!!abstract "`#!py3 sha_end_cmd(message: bytes)`"

Complete the SHA-256 computation and load the digest into TempKey and the output buffer.

Up to 63 message bytes are accepted (Length must be 0 through 63 inclusive.)

This command must be run after sha_start_cmd() and eventually after some
sha_update_cmd().


* ```Arguments```

    
    * ```message``` (```bytes```) – 0-63 bytes to be added in the SHA context before the final computation.



* ```Returns```

    32 bytes representing the SHA256 digest.



* **Return type**

    bytes



---
#### `#!py3 sha_hmacend_cmd()`

!!!abstract "`#!py3 sha_hmacend_cmd(message: bytes)`"

Complete the HMAC computation and load the digest into TempKey and the output buffer.
Up to 63 message bytes are accepted (length must be 0 through 63 inclusive).

This command must be run after sha_hmacstart_cmd() and eventually after some
sha_update_cmd().


* ```Arguments```

    
    * ```message``` (```bytes```) – 0-63 bytes to be added in the SHA context before the final computation.



* ```Returns```

    32 bytes representing the SHA256 digest.



* **Return type**

    bytes



---
#### `#!py3 sign_cmd()`

!!!abstract "`#!py3 sign_cmd(key_id: bytes, include_sn: bool, use_tempkey: bool, is_verify_invalidate: bool = False)`"

ECDSA signature calculation from an internal private key.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – Internal private key used to generate the signature.


    * ```include_sn``` (```bool```) – If True, 48 bits from Configuration Zone are included in the
    digest message.


    * ```use_tempkey``` (```bool```) – If True, the message to be signed is in TempKey.
    Otherwise the message is internally generated (see datasheet page 86).


    * ```is_verify_invalidate``` (```bool```) – This flag must be set to True if the command is
    being used by verify(invalidate) (Default value = False).



* ```Returns```

    64 bytes representing the signature composed of R and S, or an error code.



* **Return type**

    bytes



---
#### `#!py3 updateextra_cmd()`

!!!abstract "`#!py3 updateextra_cmd(update_byte: int, new_value: int)`"

Update bytes 84 or 85 within the Configuration zone after the Configuration zone
has been locked.


* ```Arguments```

    
    * ```update_byte``` (```int```) – Select the byte to be updated, can be one of 84 or 85.


    * ```new_value``` (```int```) – New value to be written in the selected byte.


    * ```update_byte``` – int:


    * ```new_value``` – int:



* ```Returns```

    0 if the operation succeded, or an error status code.



* **Return type**

    bytes



---
#### `#!py3 updateextra_decr_cmd()`

!!!abstract "`#!py3 updateextra_decr_cmd(key_id)`"

Decrement the limited use counter associated with the key in slot after the
Configuration zone has been locked.

If the slot indicated by the “NewValue” param does not contain a key for which limited
use is implemented or enabled, then the command returns without taking any action.

If the indicated slot contains a limited use key, which does not have any uses
remaining, then the command returns an error.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – 2 bytes, the slot id of the key to be decremented.



* ```Returns```

    0 if the operation succeded, or an error status code.



* **Return type**

    bytes



---
#### `#!py3 verify_external_cmd()`

!!!abstract "`#!py3 verify_external_cmd(curve_type: int, r_comp: bytes, s_comp: bytes, x_comp: bytes, y_comp: bytes)`"

Takes an ECDSA <R,S> signature and verifies that it is correctly generated from a given
message and public key.
In this mode the public key is an external input.
Prior to this command being run, the message should be written to TempKey using the
Nonce command.


* ```Arguments```

    
    * ```curve_type``` (```int```) – Curve type to be used to verify the signature:


        * 0b100 = P256 NIST ECC key


        * 0b111 = Not an ECC key

    The value in this field is encoded identically to the KeyType field in the
    KeyConfig words within the Configuration zone.



    * ```r_comp``` (```bytes```) – 32 bytes, the R component of the ECDSA signature to be verified.


    * ```s_comp``` (```bytes```) – 32 bytes, the S component of the ECDSA signature to be verified.


    * ```x_comp``` (```bytes```) – 32 bytes, the X component of the public key to be used.


    * ```y_comp``` (```bytes```) – 32 bytes, the X component of the public key to be used.



* ```Returns```

    0 if the signature match. 1 if the signature doesn’t match.
    An error status code if an error occured.



* **Return type**

    bytes



---
#### `#!py3 verify_stored_cmd()`

!!!abstract "`#!py3 verify_stored_cmd(key_id: bytes, r_comp: bytes, s_comp: bytes)`"

Takes an ECDSA <R,S> signature and verifies that it is correctly generated from a given
message and public key.

In this mode the public key to be used is found in the KeyID EEPROM slot.

The contents of TempKey should contain the SHA-256 digest of the message.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – 2 bytes, the slot id containing the public key to be used.
    The key type is determined by KeyConfig.KeyType.


    * ```r_comp``` (```bytes```) – 32 bytes, the R component of the ECDSA signature to be verified.


    * ```s_comp``` (```bytes```) – 32 bytes, the S component of the ECDSA signature to be verified.



* ```Returns```

    0 if the signature match. 1 if the signature doesn’t match. An error status
    code if something went wrong.



* **Return type**

    bytes



---
#### `#!py3 verify_validate_cmd()`

!!!abstract "`#!py3 verify_validate_cmd(key_id: bytes, r_comp: bytes, s_comp: bytes, other_data: bytes, invalidate: bool = False)`"

The Validate and Invalidate modes are used to validate or invalidate the public key
stored in the EEPROM.
The contents of TempKey should contain a digest of the PublicKey at key_id.
It must have been generated using genkey_cmd over the key_id slot.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – Slot id of the key to be (in)validated.
    The parent key to be used to perform the (in)validation is stored in
    SlotConfig.ReadKey.SlotConfig<ParentKey>.KeyType determines the curve to be used.


    * ```r_comp``` (```bytes```) – 32 bytes, the R component of the ECDSA signature to be verified.


    * ```s_comp``` (```bytes```) – 32 bytes, the S component of the ECDSA signature to be verified.


    * ```other_data``` (```bytes```) – 19 bytes, the bytes used to generate the message for the
    validation.


    * ```invalidate``` (```bool```) – If True set the mode to Invalidate instead of Validate.
    (Default value = False)



* ```Returns```

    0 if the signature match. 1 if the signature doesn’t match. An error status
    code if something went wrong.



* **Return type**

    bytes



---
#### `#!py3 verify_invalidate_cmd()`

!!!abstract "`#!py3 verify_invalidate_cmd(key_id: bytes, r_comp: bytes, s_comp: bytes, other_data: bytes)`"

Shortcut for `verify_validate_cmd()` using invalidate mode.


---
#### `#!py3 verify_validate_external_cmd()`

!!!abstract "`#!py3 verify_validate_external_cmd(key_id: bytes, r_comp: bytes, s_comp: bytes)`"

The ValidateExternal mode is used to validate the public key stored in the EEPROM at
key_id when X.509 format certificates are to be used. The digest of the message must
be TempKey. TempKey must have been generated using the sha_public_cmd(), and the
key for that computation must be the same as key_id.


* ```Arguments```

    
    * ```key_id``` (```bytes```) – The slot containing the public key to be validated which must have
    been specified by a previous sha_public_cmd().


    * ```r_comp``` (```bytes```) – 32 bytes, the R component of the ECDSA signature to be verified.


    * ```s_comp``` (```bytes```) – 32 bytes, the S component of the ECDSA signature to be verified.



* ```Returns```

    0 if the signature match. 1 if the signature doesn’t match. An error status
    code if something went wrong.



* **Return type**

    bytes



---
#### `#!py3 write_cmd()`

!!!abstract "`#!py3 write_cmd(zone: str, address: bytes, value: bytes, is_input_encrypted: bool, mac: bytes = bytes())`"

Writes either one four byte word or an 8-word block of 32 bytes to one of the EEPROM
zones on the device. Depending upon the value of the WriteConfig byte for this slot,
the data may be required to be encrypted by the system prior to being sent to the
device.


* ```Arguments```

    
    * ```zone``` (```str```) – Select the source zone. Must be one of Config, OTP or Data.


    * ```address``` (```bytes```) – 2 bytes address of the first word to be written.
    See datasheet page 58 for correct formats.


    * ```value``` (```bytes```) – 4 or 32 bytes to be written in the specified address.
    May be encrypted (set is_input_encrypted to True).


    * ```is_input_encrypted``` (```bool```) – Must be set to True if the input is encrypted.
    See datasheet page 91 for details.


    * ```mac``` (```bytes```) – Message authentication code to validate address and data.
    (Default value = bytes())



---
#### `#!py3 is_locked()`

!!!abstract "`#!py3 is_locked(zone: str)`"

Check if selected zone has been locked.


* ```Arguments```

    
    * ```zone``` (```str```) – Select the zone to check. Must be one of Config or Data.



* ```Returns```

    True if selected zone is locked.



* **Return type**

    bool



---
#### `#!py3 serial_number()`

!!!abstract "`#!py3 serial_number()`"

Retrieve secure element’s 72-bit serial number.


* ```Returns```

    Serial number.



* **Return type**

    bytes


## ATECC608A class


---
#### `#!py3 ATECC608A()`

!!!abstract "`#!py3 ATECC608A(i2c.I2C)`"

Class for controlling the ATECC608A chip.

This class inherits all ATECC508A methods.

## Zerynth HWCrypto Interface

<!-- _lib.microchip.ateccx08a.hwcryptointerface -->

---
#### `#!py3 hwcrypto_init()`

!!!abstract "`#!py3 hwcrypto_init(i2c_drv, key_slot, i2c_addr=0x60, dev_type=DEV_ATECC508A)`"

```NOTE```: this function is available only when `ZERYNTH_HWCRYPTO_ATECCx08A` is set in project.yml file


* ```Arguments```

    
    * ```i2c_drv``` – Interface for I2C communication. (e.g. `I2C0`)


    * ```key_slot``` – Chosen private key slot number (can be used to sign, compute public, …)


    * ```i2c_addr``` – Address of the I2C chip. (Default value = `0x60`)


    * ```dev_type``` – Crypto chip type (Default = `DEV_ATECC508A`, can also be `DEV_ATECC108A` or `DEV_ATECC608A`)


Init and enable the use of the crypto chip from other Zerynth libraries through Zerynth HWCrypto C interface.
C interface based on [Microchip Cryptoauth Lib](https://github.com/MicrochipTech/cryptoauthlib).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5MzQ2NDUzODEsLTE5MzMwNjEzNzFdfQ
==
-->
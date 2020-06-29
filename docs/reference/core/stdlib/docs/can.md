# CAN

This module loads the Controller Area Network (CAN) driver.

A Controller Area Network (CAN bus) is a robust vehicle bus standard designed to allow microcontrollers and devices to communicate with each other’s applications without a host computer.
It is a message-based protocol, designed originally for multiplex electrical wiring within automobiles to save on copper, but can also be used in many other contexts.
For each device the data in a frame is transmitted sequentially but in such a way that if more than one device transmits at the same time the highest priority device is able to continue while the others back off.
Frames are received by all devices, including by the transmitting device.

## The Can class

**`Can(drvname, baud, options=0, sample_point=75.0, prop=0, phase1=0, phase2=0, sjw=1)`**

This class implements CAN controller functionalities.

Can is initialized by passing the driver name ```drvname```, in the form of CAN0, CAN1, etc… depending on the
board capabilities. Refer to the board pinout to locate the actual pins belonging to the driver.

The bus speed must be also specified in the ```baud``` argument. Optional timing parameters can specify
either the bit sample point ```sample_point```, as a percentage of the bit time, or standard CAN parameters
as propagation segment ```prop```, phase segment 1 ```phase1``` and phase segment 2 ```phase2```.

When the sample point is used, the bit timing arguments must be zero and they are calculated automatically.
The synchronization jump width ```sjw``` can be specified in any case.


* **```Arguments```**

    
    * ```drvname``` – peripheral driver identifier (one of CAN0, CAN1, etc…)


    * ```baud``` – bus speed, in bits per second (up to 1000000)


    * ```sample_point``` – bit sample point, in percent (0 to 100.0)


    * ```prop``` – propagation segment, in time quanta (1 to 8)


    * ```phase1``` – phase segment 1, in time quanta (1 to 8)


    * ```phase2``` – phase segment 2, in time quanta (1 to 8)


    * ```sjw``` – synchronization jump width, in time quanta (1 to 4)


    * ```options``` – a combination of the following option flags:


        * `OPTION_NO_RETRY` to prevent automatic retransmission (one-shot mode)


        * `OPTION_NO_AUTO_OFF` to prevent automatic recovery from Bus-Off errors


        * `OPTION_KEEP_ORDER` to maintain the chronological order of messages


        * `OPTION_LISTEN_ONLY` to silently listen to the bus (Ack is sent internally), receive-only mode, no transmission possible


        * `OPTION_LOOPBACK` to activate internal loopback test mode (can be combined with listen-only)



**`add_filter(id, mask)`**

Add a message acceptance filter for this CAN controller. A received message is accepted if:

**`(received_id ^ id) & mask == 0`**

The returned value is a number that uniquely identifies the filter and can be used to remove the filter at a later time.


* **```Arguments```**

    
    * ```id``` – contains the message identifier (11-bit for standard frames, 29-bit for extended frames),             plus the ID Extension (IDE) flag `FRAME_EXT_FLAG` and the Remote Transmission Request (RTR) flag `FRAME_RTR_FLAG`.


    * ```mask``` – is a bit mask where each bit is 1 if the received message id must match the corresponding bit in the message id             or 0 if the corresponding bit in the message id is ignored. To match a single id you can use `FRAME_STD_MASK`             for standard frames or `FRAME_EXT_MASK` combined with `FRAME_EXT_FLAG` for extended frames.



* ```Returns```

    the index of the filter added.


`del_filter(filter)`

Remove a previously added message acceptance filter.


* ```Arguments```

    
    * ```filter``` – the index of the filter to remove.



`transmit(id, dlc, data=None, timeout=-1)`

Send a message to the CAN bus output mailboxes.


* **```Arguments```**

    
    * ```id``` – contains the message identifier (11-bit for standard frames, 29-bit for extended frames),             plus the ID Extension (IDE) flag `FRAME_EXT_FLAG` and the Remote Transmission Request (RTR) flag `FRAME_RTR_FLAG`.


    * ```dlc``` – is the Data Length Code (DLC) used in a Data Frame or a Remote Frame. For Data Frames it is             the number of data bytes included in the message.


    * ```data``` – is a byte array that contains the message data (up to 8 bytes for classic CAN),             not used for Remote Frames (RTR bit set).


    * ```timeout``` – the maximum time to wait for queuing the message or -1 to wait indefinitely



**`receive(data=None, timeout=-1)`**

Receive a message from the CAN bus input mailboxes.

If a ```data``` bytearray is provided it is used to store received data, otherwise a new buffer is created.


* **```Arguments```**

    
    * ```data``` – a bytes or bytearray object to receive message data or ```None```


    * ```timeout``` – the maximum time to wait for a message or -1 to wait indefinitely



* **```Returns```**

    a tuple of the form (id,dlc,data), where:


    * id contains the message identifier (11-bit for standard frames, 29-bit for extended frames),                 plus the ID Extension (IDE) flag `FRAME_EXT_FLAG` and the Remote Transmission Request (RTR) flag `FRAME_RTR_FLAG`.


    * dlc is the Data Length Code (DLC) used in a Data Frame or a Remote Frame. For Data Frames it is                 the number of data bytes included in the message.


    * data is a byte array that contains the message data (up to 8 bytes for classic CAN),                 not used for Remote Frames (RTR bit set).




**`get_errors()`**

Get the accumulated error information.


* **```Returns```**

    a tuple of the form (flags,rx_count,tx_count), where:


    * flags contains the error flags, a combinations of:

    > 
    >     * `ERROR_WARNING` in Error-Active mode, when the error counter is over the warning threshold (usually >= 96)


    >     * `ERROR_PASSIVE` in Error-Passive mode (error counter >= 128)


    >     * `ERROR_BUSOFF` in Bus-Off mode (error counter > 255)


    >     * `ERROR_STUFF` if Bit-Stuffing errors have been detected (more than 5 bits at the same level)


    >     * `ERROR_FORM` if Form errors have been detected (Dominant bits detected during Recessive spaces)


    >     * `ERROR_ACK` if no Ack bit is detected for a transmitted message


    >     * `ERROR_RECESSIVE` if error detected when trasmitting Recessive bits


    >     * `ERROR_DOMINANT` if error detected when trasmitting Dominant bits


    >     * `ERROR_CRC` if CRC mismatch have been detected


    >     * `ERROR_RX_OVERRUN` if the receive queue is full when receiving a new message


    >     * `ERROR_TX_ARBLOST` if transmitted message lost abitration due to higher priority message on the bus


    >     * `ERROR_TX_ERROR` if some error has been detected during transmission


    * rx_count is the current value of the Receive error counter.


    * tx_count is the current value of the Transmit error counter.




**`abort_receive()`**

Abort any pending `receive()` calls, that will raise a ```TimeoutError```, and prevent further messages
to be received, raising ```ConnectionAbortedError```, until resumed.


**`abort_transmit()`**

Abort any pending `transmit()` calls, that will raise a ```TimeoutError```, and prevent further messages
to be transmitted, raising ```ConnectionAbortedError```, until resumed.


**`resume_receive()`**

Resume receiving messages from the bus.


**`resume_transmit()`**

Resume transmitting messages to the bus.


`done()`

Close this CAN driver instance and release used resources. Any pending function call or subsequent calls
will raise an ```IOError``` exception.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTU3NDIyMDI1NCwxMzM1ODcwNDM0LDI4Nz
M5MzkyNl19
-->
# Examples

The following are a list of examples for lib.microchip.mcp2515

## CAN Loopback Example


This example sends/receives an echo message over mcp2515 in loopback mode. 
This example will test the functionality of the protocol controller, and connections to it.
No CAN Bus is required.


```main.py```

```python
################################################################################
# CAN Loopback Example
#
# Created: 2018-03-05 11:25:41.189984
#
################################################################################

from microchip.mcp2515 import mcp2515
import streams

streams.serial()
print("start...")
try:
	# This setup is referred to CAN SPI click mounted on flip n click device slot A 
    can = mcp2515.MCP2515(SPI0, D17, D16, clk=10000000)
    print("...done")
    print("init...")
    can.init(mcp2515.MCP_ANY, "500KBPS", "16MHZ")
    can.set_mode("LOOPBACK")
    print("...done")
    print("ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print(e)
    sleep(1000) 

canid = bytearray([0x00, 0x00, 0x01, 0x00])
data = [0x98, 0xBB, 0x40, 0xAC, 0x58, 0x33, 0x12, 0x3E]
# interrupt pin
pinMode(D21, INPUT)

while True:
    try:
        if not digitalRead(D21):
            id_rx, msg_rx = can.recv()
            if id_rx[3] & 0x80 == 0x80:
                print("Ext ID:", [e for e in id_rx], "DLC:", len(msg_rx))
            else:
                print("Std ID:", [e for e in id_rx], "DLC:", len(msg_rx))

            if id_rx[3] & 0x40 == 0x40:
                print("remote request frame")
            else:
                print("Data:", [x for x in msg_rx])
        
        sleep(500)

        print("sending msg...")
        can.send(canid, data)
        print("...done")
    except Exception as e:
        print(e)
        sleep(1000)



```
## CAN Communication Example


In this example CAN Receiver and Transmitter are implemented.
2 devices connected in CAN Bus needed for this example.


```main.py```

```python
################################################################################
# CAN Communication Example
#
# Created: 2018-03-05 11:25:41.189984
#
################################################################################

from microchip.mcp2515 import mcp2515
import streams

streams.serial()
print("start...")
try:
    # This setup is referred to CAN SPI click mounted on flip n click device slot A 
    can = mcp2515.MCP2515(SPI0, D17, D16, clk=10000000)
    print("...done")
    print("init...")
    can.init(mcp2515.MCP_ANY, "500KBPS", "16MHZ")
    can.set_mode("NORMAL")
    print("...done")
    print("ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print(e)
    sleep(1000) 

##################################################
# Copy and Paste transmitter.py/receiver.py here #
# To obtain the Transmitter/receiver code to be  #
# uploaded                                       #
##################################################
```

# Examples

The following are a list of examples for lib.zerynth.infrared.

## IR send Raw

Simple example showing how to send IR Raw packets stored as sequances of pulses (State 1, State 0) expressed in microseconds.





```main.py```

```python
################################################################################
# IR send Raw Data
#
# Created by Zerynth Team 2015 CC
# Authors: D. Mazzei, G. Baldi,  
###############################################################################

import streams
from infrared import infrared

s=streams.serial()

#Ir Remotes Raw data can be found on various websites like https://www.remotecentral.com/index.html
#The IRSender.sendRaw method takes as input a list of times in microseconds where the first time is for the state 1 phase (IR LED firing) the second time is for state 0 (IR LED OFF) and so on.
SamsungON=[4500, 4500, 590, 1690, 590, 1690, 590, 1690, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 1690, 590, 1690, 590, 1690, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 1690, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 1690, 590, 590, 590, 1690, 590, 1690, 590, 1690, 590, 1690, 590, 1690, 590, 1690, 590, 4500, 4500, 590, 1690, 590, 1690, 590, 1690, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 590, 1690, 590, 1690, 590, 1690, 590, 590, 590, 590, 590, 590, 590, 590]

#Create a IR packet sender passing it the pin where the IR LED is connected to specifying the PWM feature 
sender = infrared.IRSender(D6.PWM)                
i=0

while True:
    print("Sending Samsung TV ON/OFF", i)
    sender.sendRaw(SamsungON)
    sleep(2000)
    i+=1
```
## IR Capture, Decode and Send


Basics example showing how to capture IR packet and decode them. The IR capture is performed through an IR demodulator connected to a pin empowered with ICU feature.
Once decoded, captured packet can be printed on the console or sent through an IR LED connected to a pin empowered with PWM feature.

At the current stage the Zerynth Infrared library decode only Samsung and NEC protocols. Other protocols will be added soon. However, any captured packet can be stored and sent as raw packet without requiring a specific protocol decoder.




```main.py```

```python
################################################################################
# IR Capture, Decode and Send
#
# Created by Zerynth Team 2015 CC
# Authors: D. Mazzei, G. Baldi,  
###############################################################################

import streams
from infrared import infrared

s=streams.serial()

#create an instance of the IR receiver class passing it the pin where the IR demodulator is connected specifiying the ICU feature
receiver = infrared.IRReceiver(D2.ICU)

#Create a IR packet sender specifying the pin where the IR LED is connected specifying the PWM feature 
sender = infrared.IRSender(D6.PWM)                

while True:
    print("Capturing...")
    packet=receiver.captureAndDecode()
    packet.printPacket(s)
    print("Wait 3 secs before sending the captured packet")
    sleep(3000)
    for i in range(3):
        print("Sending...", i)
        sender.send(packet)
        sleep(1500)
    
        
        
```

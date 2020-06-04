# Examples

The following are a list of examples for lib.nordic.nrf52_ble

## BLE Alerts


An implementationof an Alert Notification device to show how services and characteristics can be easily created.



```main.py```

```python
################################################################################
# BLE Alerts
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
# import a BLE driver: in this example we use NRF52
from nordic.nrf52_ble import nrf52_ble as bledrv
# then import the BLE modue
from wireless import ble


streams.serial()


notifications_enabled = True
connected = False

# Let's define some callbacks
def value_cb(status,val):
    # check incoming commands and enable/disable notifications
    global notifications_enabled
    print("Value changed to",val[0],val[1])
    if val[0]==0:
        print("Notifications enabled")
        notifications_enabled = True
    elif val[0]==2:
        notifications_enabled = False
        print("Notifications disabled")
    else:
        print("Notifications unchanged")
        
def connection_cb(address):
    global connected
    print("Connected to",ble.btos(address))
    connected = True

def disconnection_cb(address):
    global connected
    print("Disconnected from",ble.btos(address))
    # let's start advertising again
    ble.start_advertising()
    connected = False



try:
    # initialize BLE driver
    bledrv.init()

    # Set GAP name and no security
    ble.gap("ZNotifier",security=(ble.SECURITY_MODE_1,ble.SECURITY_LEVEL_1))

    # add some GAP callbacks
    ble.add_callback(ble.EVT_CONNECTED,connection_cb)
    ble.add_callback(ble.EVT_DISCONNECTED,disconnection_cb)
    
    # Create a GATT Service: let's try an Alert Notification Service
    # (here are the specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.service.alert_notification.xml)
    s = ble.Service(0x1811)

    # The Alert Notification service has multiple characteristics. Let's add them one by one
    
    # Create a GATT Characteristic for counting new alerts.
    # specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.supported_new_alert_category.xml
    cn = ble.Characteristic(0x2A47, ble.NOTIFY | ble.READ,16,"New Alerts",ble.BYTES)
    # Add the GATT Characteristic to the Service
    s.add_characteristic(cn)
    

    # Create anothr GATT Characteristic for enabling/disabling alerts
    # specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.alert_notification_control_point.xml
    cc = ble.Characteristic(0x2A44, ble.WRITE ,2,"Alerts control",ble.BYTES)
    # Add the GATT Characteristic to the Service
    s.add_characteristic(cc)
    # Add a callback to be notified of changes
    cc.set_callback(value_cb)
    
    # Add the Service. You can create additional services and add them one by one
    ble.add_service(s)

    # Setup advertising to 50ms
    ble.advertising(50)

    # Start the BLE stack
    ble.start()

    # Now start advertising
    ble.start_advertising()

except Exception as e:
    print(e)

# loop forever
while True:
    print(".")
    if random(0,100)<50 and notifications_enabled and connected:
        value = bytearray(cn.get_value())
        value[0]=0  # simple alert type
        if value[1]<255:
            value[1]=value[1]+1   # add a notification
        print("Adding a new notification, total of",value[1])
        # the remaining 14 bytes can be some text 
        value[2:10] = "Zerynth!"
        # set the new value. If ble notifications are enabled, the connected device will receive the change
        cn.set_value(value)
    sleep(5000)



```
## BLE Alerts with Security 1


An implementationof an Alert Notification device to show how services and characteristics can be easily created. It also features secure connections with bonding.




```main.py```

```python
################################################################################
# BLE Alerts with security
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
# import a BLE driver: in this example we use NRF52
from nordic.nrf52_ble import nrf52_ble as bledrv
# then import the BLE modue
from wireless import ble


streams.serial()


notifications_enabled = True
connected = False

# Let's define some callbacks
def value_cb(status,val):
    # check incoming commands and enable/disable notifications
    global notifications_enabled
    print("Value changed to",val[0],val[1])
    if val[0]==0:
        print("Notifications enabled")
        notifications_enabled = True
    elif val[0]==2:
        notifications_enabled = False
        print("Notifications disabled")
    else:
        print("Notifications unchanged")
        
def connection_cb(address):
    global connected
    print("Connected to",ble.btos(address))
    connected = True

def disconnection_cb(address):
    global connected
    print("Disconnected from",ble.btos(address))
    # let's start advertising again
    ble.start_advertising()
    connected = False

# Let's define some security callbacks
def show_key_cb(passkey):
    print("ENTER THIS PIN ON THE MASTER:",passkey)


try:
    # initialize BLE driver
    bledrv.init()

    # Set GAP name and LEVEL 2 security
    # !!! If security is not set, no secure connection will be possible
    ble.gap("ZNotifier",security=(ble.SECURITY_MODE_1,ble.SECURITY_LEVEL_2))

    # add some GAP callbacks
    ble.add_callback(ble.EVT_CONNECTED,connection_cb)
    ble.add_callback(ble.EVT_DISCONNECTED,disconnection_cb)
    
    # Create a GATT Service: let's try an Alert Notification Service
    # (here are the specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.service.alert_notification.xml)
    s = ble.Service(0x1811)

    # The Alert Notification service has multiple characteristics. Let's add them one by one
    
    # Create a GATT Characteristic for counting new alerts.
    # specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.supported_new_alert_category.xml
    cn = ble.Characteristic(0x2A47, ble.NOTIFY | ble.READ,16,"New Alerts",ble.BYTES)
    # Add the GATT Characteristic to the Service
    s.add_characteristic(cn)
    

    # Create anothr GATT Characteristic for enabling/disabling alerts
    # specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.alert_notification_control_point.xml
    cc = ble.Characteristic(0x2A44, ble.WRITE ,2,"Alerts control",ble.BYTES)
    # Add the GATT Characteristic to the Service
    s.add_characteristic(cc)
    # Add a callback to be notified of changes
    cc.set_callback(value_cb)
    
    # Add the Service. You can create additional services and add them one by one
    ble.add_service(s)

    # Configure security. BLE security is very flexible.
    # In this case we declare that the device has only an output capability (CAP_DISPLAY_ONLY),
    # that we require a bonding (storage of the keys after pairing)
    # and that we want both secure connection and main in the middle protection.
    # Since we have CAP_DISPLAY_ONLY, we also declare a passkey that will be shown to the user
    # to be entered on the master (i.e. the smartphone) to finalize the bonding.
    ble.security(
        capabilities=ble.CAP_DISPLAY_ONLY,
        bonding=ble.AUTH_BOND,
        scheme=ble.AUTH_SC|ble.AUTH_MITM,
        key_size=16,
        passkey=225575)
    # To do so, we need a callback to display the passkey when needed
    ble.add_callback(ble.EVT_SHOW_PASSKEY,show_key_cb)

    # Setup advertising to 50ms
    ble.advertising(50)

    # Start the BLE stack
    ble.start()

    # Now start advertising
    ble.start_advertising()

except Exception as e:
    print(e)

# loop forever
while True:
    print(".")
    if random(0,100)<50 and notifications_enabled and connected:
        value = bytearray(cn.get_value())
        value[0]=0  # simple alert type
        if value[1]<255:
            value[1]=value[1]+1   # add a notification
        print("Adding a new notification, total of",value[1])
        # the remaining 14 bytes can be some text 
        value[2:10] = "Zerynth!"
        # set the new value. If ble notifications are enabled, the connected device will receive the change
        cn.set_value(value)
    sleep(5000)



```
## BLE Alerts with Security 2


An implementationof an Alert Notification device to show how services and characteristics can be easily created. It also features secure connections with bonding using confirmation capabilities of the device.





```main.py```

```python
################################################################################
# BLE Alerts with Security 2
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
# import a BLE driver: in this example we use NRF52
from nordic.nrf52_ble import nrf52_ble as bledrv
# then import the BLE modue
from wireless import ble


streams.serial()


notifications_enabled = True
connected = False

# Let's define some callbacks
def value_cb(status,val):
    # check incoming commands and enable/disable notifications
    global notifications_enabled
    print("Value changed to",val[0],val[1])
    if val[0]==0:
        print("Notifications enabled")
        notifications_enabled = True
    elif val[0]==2:
        notifications_enabled = False
        print("Notifications disabled")
    else:
        print("Notifications unchanged")
        
def connection_cb(address):
    global connected
    print("Connected to",ble.btos(address))
    connected = True

def disconnection_cb(address):
    global connected
    print("Disconnected from",ble.btos(address))
    # let's start advertising again
    ble.start_advertising()
    connected = False

# Let's define some security callbacks
def match_key_cb(passkey):
    print("MASTER KEY IS:",passkey,"CAN WE PROCEED? PRESS BUTTON FOR YES")
    pinMode(BTN0,INPUT)
    for i in range(5):
        if digitalRead(BTN0)!=0:
            ble.confirm_passkey(1)
            print("Confirmed!")
            return
        sleep(1000)
    ble.confirm_passkey(0)
    print("Not confirmed!")
    


try:
    # initialize BLE driver
    bledrv.init()

    # Set GAP name and LEVEL 2 security
    # !!! If security is not set, no secure connection will be possible
    ble.gap("ZNotifier",security=(ble.SECURITY_MODE_1,ble.SECURITY_LEVEL_2))

    # add some GAP callbacks
    ble.add_callback(ble.EVT_CONNECTED,connection_cb)
    ble.add_callback(ble.EVT_DISCONNECTED,disconnection_cb)
    
    # Create a GATT Service: let's try an Alert Notification Service
    # (here are the specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.service.alert_notification.xml)
    s = ble.Service(0x1811)

    # The Alert Notification service has multiple characteristics. Let's add them one by one
    
    # Create a GATT Characteristic for counting new alerts.
    # specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.supported_new_alert_category.xml
    cn = ble.Characteristic(0x2A47, ble.NOTIFY | ble.READ,16,"New Alerts",ble.BYTES)
    # Add the GATT Characteristic to the Service
    s.add_characteristic(cn)
    

    # Create anothr GATT Characteristic for enabling/disabling alerts
    # specs: https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.characteristic.alert_notification_control_point.xml
    cc = ble.Characteristic(0x2A44, ble.WRITE ,2,"Alerts control",ble.BYTES)
    # Add the GATT Characteristic to the Service
    s.add_characteristic(cc)
    # Add a callback to be notified of changes
    cc.set_callback(value_cb)
    
    # Add the Service. You can create additional services and add them one by one
    ble.add_service(s)

    # Configure security. BLE security is very flexible.
    # In this case we declare that the device has only an output capability with yes o or no input (CAP_DISPLAY_YES_NO),
    # that we require a bonding (storage of the keys after pairing)
    # and that we want both secure connection and main in the middle protection.
    ble.security(
        capabilities=ble.CAP_DISPLAY_YES_NO,
        bonding=ble.AUTH_BOND,
        scheme=ble.AUTH_SC|ble.AUTH_MITM,
        key_size=16)
    # To do so, we need a callback to accept the passkey when needed
    ble.add_callback(ble.EVT_MATCH_PASSKEY,match_key_cb)

    # Setup advertising to 50ms
    ble.advertising(50)

    # Start the BLE stack
    ble.start()

    # Now start advertising
    ble.start_advertising()

except Exception as e:
    print(e)

# Uncomment the following lines to delte bonded devices!
for bond in ble.bonded():
    print("Removing bonded:",ble.btos(bond))
    ble.remove_bonded(bond)

# loop forever
while True:
    print(".")
    if random(0,100)<50 and notifications_enabled and connected:
        value = bytearray(cn.get_value())
        value[0]=0  # simple alert type
        if value[1]<255:
            value[1]=value[1]+1   # add a notification
        print("Adding a new notification, total of",value[1])
        # the remaining 14 bytes can be some text 
        value[2:10] = "Zerynth!"
        # set the new value. If ble notifications are enabled, the connected device will receive the change
        cn.set_value(value)
    sleep(5000)



```
## BLE Battery Service


A minimal example implementing a Battery Level Service on a NRF52 chip.


```main.py```

```python
################################################################################
# BLE Battery Service 
#
# Created by Zerynth Team 2016 CC
# Author: G. Baldi
###############################################################################

import streams
# import a BLE driver: in this example we use NRF52
from nordic.nrf52_ble import nrf52_ble as bledrv
# then import the BLE modue
from wireless import ble

streams.serial()

# initialize NRF52 driver
bledrv.init()

# Set GAP name
ble.gap("Zerynth")

# Create a GATT Service: let's try a Battery Service (uuid is 0x180F)
s = ble.Service(0x180F)

# Create a GATT Characteristic: (uuid for Battery Level is 0x2A19, and it is an 8-bit number)
c = ble.Characteristic(0x2A19,ble.NOTIFY | ble.READ,1,"Battery Level",ble.NUMBER)

# Add the GATT Characteristic to the Service
s.add_characteristic(c)

# Add the Service
ble.add_service(s)

# Start the BLE stack
ble.start()

# Begin advertising
ble.start_advertising()


while True:
    print(".")
    sleep(1000)
    # Let's update the Characteristic Value
    c.set_value(random(0,100))
```
## BLE Scanner


A simple example implementing a BLE packet scanner.



```main.py```

```python
################################################################################
# BLE Scanner
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
# import a BLE driver: in this example we use NRF52
from nordic.nrf52_ble import nrf52_ble as bledrv
# then import the BLE modue
from wireless import ble


streams.serial()


# Let's define some callbacks and constants

# How long to scan for in milliseconds
scan_time=30000

def scan_report_cb(data):
    print("Detected packet from",ble.btos(data[4]),"containing",ble.btos(data[3]))
    print("         packet is of type",ble.btos(data[0]),"while address is of type",ble.btos(data[1]))
    print("         remote device has RSSI of",ble.btos(data[2]))

def scan_start_cb(data):
    print("Scan started")

def scan_stop_cb(data):
    print("Scan stopped")
    #let's start it up again
    ble.start_scanning(scan_time)

try:
    # initialize BLE driver
    bledrv.init()

    # Set GAP name and no security
    ble.gap("Zerynth",security=(ble.SECURITY_MODE_1,ble.SECURITY_LEVEL_1))

    ble.add_callback(ble.EVT_SCAN_REPORT,scan_report_cb)
    ble.add_callback(ble.EVT_SCAN_STARTED,scan_start_cb)
    ble.add_callback(ble.EVT_SCAN_STOPPED,scan_stop_cb)

    #set scanning parameters: every 100ms for 50ms and no duplicates
    ble.scanning(100,50,duplicates=0)

    # Start the BLE stack
    ble.start()

    # Now start scanning for 30 seconds
    ble.start_scanning(scan_time)

except Exception as e:
    print(e)

# loop forever
while True:
    print(".")
    sleep(10000)


```

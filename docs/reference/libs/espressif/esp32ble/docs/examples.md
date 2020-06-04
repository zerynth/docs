# Examples

The following are a list of examples for lib.espressif.esp32ble

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
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
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
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
# then import the BLE modue
from wireless import ble


streams.serial()


# Let's define some callbacks and constants

# How long to scan for in milliseconds
scan_time=30000

def scan_report_cb(data):
    print("Detected packet from",ble.btos(data[4]),"containing",ble.btos(data[3]))
    print("         packet is of type",data[0],"while address is of type",data[1])
    print("         remote device has RSSI of",data[2])

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
## Eddystone Beacon


An implementation of a simple Eddystone Beacon advertising some predefined packets.



```main.py```

```python
################################################################################
# Eddystone Beacon
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
import timers
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
# then import the BLE module and beacons
from wireless import ble
from wireless import ble_beacons as bb

streams.serial()

adv_content = 0
battery_level = 40
temperature = 23.2
pdu_count = 0
uptime = timers.timer()
uptime.start()

# create payloads to cycle through
payloads = [
    bb.eddy_encode_uid("Zerynth","Python",-69),                                 # UID Eddystone payload
    bb.eddy_encode_url("https://www.zerynth.com",-69),                          # URL Eddystone payload
    bb.eddy_encode_tlm(battery_level,temperature,pdu_count,uptime.get()/1000)  # TLM Eddystone payload
]

# this callback will be called at the end of an advertising cycle.
# it is used to switch to the next content
def adv_stop_cb(data):
    global pdu_count,adv_content
    print("Advertising stopped")
    adv_content = (adv_content+1)%3
    if adv_content == 0:
        # advertise UID
        interval = 100
        timeout = 10000
    elif adv_content == 1:
        # advertise URL
        interval = 100
        timeout = 15000
    else:
        # advertise TLM
        interval = 100
        timeout = 150
        pdu_count+=1
        payloads[2] = bb.eddy_encode_tlm(battery_level,temperature,pdu_count,uptime.get()/1000)  # TLM Eddystone payload
    
    payload = payloads[adv_content]
    ble.advertising(interval,timeout=timeout,payload=payload,mode=ble.ADV_UNCN_UND)
    ble.start_advertising()
    print("Advertising restarted with",ble.btos(payload))


try:
    # initialize BLE driver
    bledrv.init()

    # Set GAP name and no security
    ble.gap("Zerynth",security=(ble.SECURITY_MODE_1,ble.SECURITY_LEVEL_1))
    ble.add_callback(ble.EVT_ADV_STOPPED,adv_stop_cb)
    
    # set advertising options: advertise every second with custom payload in non connectable undirected mode
    # after 10 seconds, stop and change payload
    ble.advertising(100,timeout=10000,payload=payloads[adv_content],mode=ble.ADV_UNCN_UND)

    # Start the BLE stack
    ble.start()

    # Now start scanning for 30 seconds
    ble.start_advertising()

except Exception as e:
    print(e)

# loop forever
while True:
    print(".")
    sleep(10000)



```
## iBeacon


An Apple beacon advertising its own uuid.



```main.py```

```python
################################################################################
# iBeacon
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
import timers
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
# then import the BLE module and beacons
from wireless import ble
from wireless import ble_beacons as bb

streams.serial()
try:
    # initialize BLE driver
    bledrv.init()

    # Set GAP name and no security
    ble.gap("Zerynth",security=(ble.SECURITY_MODE_1,ble.SECURITY_LEVEL_1))
    
    # set advertising options: advertise every second with custom payload in non connectable undirected mode
    ble.advertising(20,payload=bb.ibeacon_encode("fb0b57a2-8228-44cd-913a-94a122ba1206",10,3,-69),mode=ble.ADV_UNCN_UND)

    # Start the BLE stack
    ble.start()

    # Now start advertising
    ble.start_advertising()

except Exception as e:
    print(e)

# loop forever
while True:
    print(".")
    sleep(10000)



```


```main.py```

```python
################################################################################
# Eddystone Reader
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
# then import the BLE modue
from wireless import ble
from wireless import ble_beacons as bb


streams.serial()


# Let's define some callbacks

def scan_report_cb(data):
    pdata = data[3]
    rssi = data[2]
    try:
        etype = bb.eddy_decode_type(pdata)
        if etype==bb.EDDY_URL:
            url, tx = bb.eddy_decode(pdata)
            print("Eddy URL found with",url,tx,rssi)
        elif etype==bb.EDDY_UID:
            namespace, instance, tx = bb.eddy_decode(pdata)
            print("Eddy UID found with",[hex(x) for x in namespace],[hex(x) for x in instance],tx,rssi)
        elif etype==bb.EDDY_LTM:
            battery,temperature, count, uptime = bb.eddy_decode(pdata)
            print("Eddy LTM found with",battery,temperature,count,uptime,rssi)
        # print("iBeacon found with",[hex(x) for x in uuid],major,minor,tx,rssi)
    except Exception as e:
        print("::")


def scan_stop_cb(data):
    print("Scan stopped")
    #let's start it up again
    ble.start_scanning(3000)

try:
    # initialize BLE driver
    bledrv.init()

    # Set GAP name and no security
    ble.gap("Zerynth",security=(ble.SECURITY_MODE_1,ble.SECURITY_LEVEL_1))

    ble.add_callback(ble.EVT_SCAN_REPORT,scan_report_cb)
    ble.add_callback(ble.EVT_SCAN_STOPPED,scan_stop_cb)

    #set scanning parameters: every 100ms for 100ms and no duplicates
    ble.scanning(100,100,duplicates=0)

    # Start the BLE stack
    ble.start()

    # Now start scanning for 3 seconds
    ble.start_scanning(3000)

except Exception as e:
    print(e)

# loop forever
while True:
    print(".")
    sleep(10000)



```
## iBeacon Reader


A simple firmware to scan for iBeacons.



```main.py```

```python
################################################################################
# iBeacon Reader
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
# then import the BLE modue
from wireless import ble
from wireless import ble_beacons as bb


streams.serial()


# Let's define some callbacks


def scan_report_cb(data):
    pdata = data[3]
    rssi = data[2]
    try:
        uuid, major, minor, tx = bb.ibeacon_decode(pdata)
        print("iBeacon found with",[hex(x) for x in uuid],major,minor,tx,rssi)
    except Exception as e:
        print("::")


def scan_stop_cb(data):
    print("Scan stopped")
    #let's start it up again
    ble.start_scanning(3000)

try:
    # initialize BLE driver
    bledrv.init()

    # Set GAP name and no security
    ble.gap("Zerynth",security=(ble.SECURITY_MODE_1,ble.SECURITY_LEVEL_1))

    ble.add_callback(ble.EVT_SCAN_REPORT,scan_report_cb)
    ble.add_callback(ble.EVT_SCAN_STOPPED,scan_stop_cb)

    #set scanning parameters: every 100ms for 100ms and no duplicates
    ble.scanning(100,100,duplicates=0)

    # Start the BLE stack
    ble.start()

    # Now start scanning for 3 seconds
    ble.start_scanning(3000)

except Exception as e:
    print(e)

# loop forever
while True:
    print(".")
    sleep(10000)


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
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
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
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
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
## BLE Wifi


A BLE scanner sending packet data to a tcp socket ovr a Wifi connection.



```main.py```

```python
################################################################################
# BLE Wifi
#
# Created by Zerynth Team 2019 CC
# Author: G. Baldi
###############################################################################

import streams
#import the ESP32 BLE driver: a BLE capable VM is also needed!
from espressif.esp32ble import esp32ble as bledrv
# then import the BLE modue
from wireless import ble
#  import wifi modules 
from espressif.esp32net import esp32wifi as wifi_driver
from wireless import wifi
import socket
import gc

streams.serial()


# Let's define some callbacks and constants

# How long to scan for in milliseconds
scan_time=30000
# tcp socket
ss=None

def scan_report_cb(data):
    try:
        print("Detected packet from",ble.btos(data[4]),"containing",ble.btos(data[3]))
        print("         packet is of type",data[0],"while address is of type",data[1])
        print("         remote device has RSSI of",data[2])
        # send to socket
        ss.sendall(ble.btos(data[3]))
        ss.sendall("\n")
    except Exception as e:
        print("send",e)
    
def scan_start_cb(data):
    print("Scan started")

def scan_stop_cb(data):
    print("Scan stopped")
    #let's start it up again
    ble.start_scanning(scan_time)

try:
    # initialize wifi
    wifi_driver.auto_init()

    for i in range(10):
        try:
            print('connecting to wifi...')
            # place here your wifi configuration
            wifi.link("SSID",wifi.WIFI_WPA2,"password")
            break
        except Exception as e:
            print(e)
    
        
    
    # let's open a socket to forward the BLE packets
    print("Opening socket...")
    ss=socket.socket()
    # you can run "nc -l -p 8082" on your machine
    # and change the ip below
    ss.connect(("192.168.71.52",8082))
    

    print("Starting BLE...")
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
    print(".",gc.info())
    sleep(10000)
    ss.sendall("::\n")

```

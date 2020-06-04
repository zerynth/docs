# Examples

The following are a list of examples for lib.espressif.esp32net

## Wifi Connect


Simple wifi driver initialization and connection to a wifi network


```main.py```

```python
################################################################################
# Wifi Network Connection Example
#
# Created: 2016-07-27 11:00:55.020628
#
################################################################################

import streams

# import the wifi interface
from wireless import wifi

# import wifi support
from espressif.esp32net import esp32wifi as wifi_driver

streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected device
wifi_driver.auto_init()

# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-name",wifi.WIFI_WPA2,"password")
    print("Link Established")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

```
## Soft AP Mode


Simple wifi driver initialization in Access Point Mode


```main.py```

```python
################################################################################
# Wifi SoftAP Example
#
# Created: 2016-07-27 11:00:55.020628
#
################################################################################

import streams

# import the wifi interface
from wireless import wifi

# import wifi support
from espressif.esp32net import esp32wifi as wifi_driver

streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected device
wifi_driver.auto_init()

# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Creating Access Point...")
try:
    wifi.softap_init("ESP32",wifi.WIFI_WPA2,"ZerynthEsp32")
    print("Access Point started!")
    while True:
        info = wifi.softap_get_info()
        mac = ":".join([hex(x,"") for x in info[3]])
        print(info[0],info[1],info[2],mac)
        sleep(3000)

except Exception as e:
    print("ooops, something :(", e)
    while True:
        sleep(1000)

```
## Sniffer


A simple example showing the capabilities of the wifi sniffer



```main.py```

```python
################################################################################
# Wifi Sniffer
#
# Created at 2019-05-08 15:19:21.114503
#
################################################################################

import streams
from espressif.esp32net import esp32wifi as wifi_driver


try:
    streams.serial()
    #let's init the driver
    wifi_driver.auto_init()
except Exception as e:
    print("ooops, something wrong with the driver", e)
    while True:
        sleep(1000)

try:

    while True:
        # loop over all channels
        for channel in  [1,2,3,4,5,6,7,8,9,10,11,12,13]:
            print("Sniffing channel",channel)
            print("================")
            # start the sniffer for management and data packets
            # on the current channel
            # filtering packets going in and out of DS, and also packets with no direction
            # keep a buffer of 128 packets
            # but don't store the payloads (max_payloads=0)
            wifi_driver.start_sniffer(
                packet_types=[wifi_driver.WIFI_PKT_DATA,wifi_driver.WIFI_PKT_MGMT],
                channels = [channel],
                direction = wifi_driver.WIFI_DIR_TO_DS_FROM_NULL | wifi_driver.WIFI_DIR_TO_NULL_FROM_DS | wifi_driver.WIFI_DIR_TO_NULL_FROM_NULL,
                pkt_buffer=128,
                max_payloads=0)

            # The sniffer is sniffing :)
            # let's loop for 10 seconds on each channel
            seconds = 0
            while seconds<10:
                sleep(1000)
                seconds+=1
                pkts = wifi_driver.sniff()
                for pkt in pkts:
                    print(pkt[:-1])  # print everything except the payload
                # let's also check some sniffing stats 
                print("Stats",wifi_driver.get_sniffer_stats())

            # This is not necessary, we can go back to the loop and call start_sniffer again
            # but let's call stop nonetheless
            wifi_driver.stop_sniffer()

except Exception as e:
    print(e)

```
## Advanced Sniffer


An advanced example that shows how to sniff probe requests to identify stations in the room and their position.



```main.py```

```python
################################################################################
# Advanced Wifi Sniffer
#
# Created at 2019-05-08 15:19:21.114503
#
################################################################################


import streams
from espressif.esp32net import esp32wifi as wifi_driver


try:
    streams.serial()
    wifi_driver.auto_init()
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

try:
    # configure the sniffer for probe requests
    # on all channels
    # stay on each channel for 4 seconds
    # 32 probes buffer
    # also save payloads (up to a total of 8Kb)
    # they can be analyzed to gather more  information on identities
    wifi_driver.start_sniffer(
        packet_types=[wifi_driver.WIFI_PKT_MGMT],
        channels = [1,2,3,4,5,6,7,8,9,10,11,12,13],
        mgmt_subtypes=[wifi_driver.WIFI_PKT_MGMT_PROBE_REQ],
        direction = wifi_driver.WIFI_DIR_TO_NULL_FROM_NULL,
        pkt_buffer=32,
        max_payloads=8192,
        hop_time=4000)


    identities = {}
    while True:
        seconds = 0
        # gather probe request packet for 60 seconds
        while seconds<60:
            sleep(1000)
            seconds+=1
            pkts = wifi_driver.sniff()
            for pkt in pkts:
                payload = pkt[-1]
                # being a to_ds 0, from_ds 0 packet, address 2 is the source mac
                # identifying the wifi station
                source = pkt[8]  # source mac of the station probing the network
                # get also the rssi value
                rssi = pkt[11]
                # print the packet without payload
                print(pkt[:-1])
                if source not in identities:
                    # add the current rssi to the new source
                    identities[source]=rssi
                else:
                    # average the previous rssi with the new one
                    # Note: don't do this if you have moving stations, like smartphones on people :)
                    identities[source]=(identities[source]+rssi)//2


        # 60 seconds finished, display a summary
        print("Identities summary")
        print("=========================================")
        print("Mac               |  rssi  |  distance  | ")
        print("=========================================")
        for mac, rssis in identities.items():
            # calculate distance using rssi: http://tdmts.net/2017/02/04/using-wifi-rssi-to-estimate-distance-to-an-access-point/
            d = 10** ((-84 - rssis) / (10 * 4))
            print(mac,"   ",rssis,"    %2.2f"%d)
        print("=========================================")



except Exception as e:
    print(e)

```

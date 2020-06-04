# Examples

The following are a list of examples for lib.nxp.hexiwear

## Basic example of use for Hexiwear Library


Example of use for Hexiwear supported library with all its peripherals enabled.




```main.py```

```python
################################################################################
# Basic example of use for Hexiwear Library
#
# Created: 2017-03-30 07:55:48.081359
#
################################################################################

import streams
from nxp.hexiwear import hexiwear
import threading
import zLogo

streams.serial()

def pressed_up():
    print("Up Button Pressed")
    hexi.vibration(100)
    hexi.enable_bt_upd_sensors()

def pressed_down():
    print("Down Button Pressed")
    hexi.vibration(100)
    hexi.disable_bt_upd_sensors()

def toggle_ble():
    try:
        print("Left Button Pressed")
        hexi.vibration(100)
        hexi.bt_driver.toggle_adv_mode()
    except Exception as e:
        print("error on left_pressed", e)

def toggle_touch():
    try:
        print("Right Button Pressed")
        hexi.vibration(100)
        hexi.bt_driver.toggle_tsi_group()
    except Exception as e:
        print("error on right_pressed", e)
    
def print_paircode():
    # print the pair code in the serial monitor
    print("Your Pair Code:",hexi.bt_driver.passkey)

# used to check the bluetooth status
pinMode(LED2, OUTPUT)

try:
    print("init")
    hexi = hexiwear.HEXIWEAR()
    print("start")
    hexi.fill_screen(0xFFFF,False)
    # attach toggle_ble function to left button (enabled/disabled ble)
    hexi.attach_button_left(toggle_ble)
    # attach toggle_touch function to right button (toggle active button - left/right pair)
    hexi.attach_button_right(toggle_touch)
    # attach pressed_up function to up button - enabled ble update sensor value thread
    hexi.attach_button_up(pressed_up)
    # attach pressed_up function to down button - disabled ble update sensor value thread
    hexi.attach_button_down(pressed_down)
    # attach print_paircode function to bluetooth pairing request
    hexi.attach_passkey(print_paircode)
    print("Ready!")
    print("------------------------------------------------------------------------------")
except Exception as e:
    print(e)
    
    
def read_bt_status():
    while True:
        bt_on, bt_touch, bt_link = hexi.bluetooth_info()
        digitalWrite(LED2, 0 if bt_on==1 else 1)
        sleep(1000)

thread(read_bt_status)

hexi.draw_image(zLogo.zz, 38, 10, 20, 20)
hexi.draw_text("Start!", 0, 60, 96, 20, align=3, color=0xFFFF, background=0x0000, encode=False)

while True:
    try:
        bl, chg = hexi.get_battery_level(chg_state=True)
        print("Battery Level:", bl, "% - Charging:", chg)
        al = hexi.get_ambient_light()
        print("Ambient Light:", al)
        acc = hexi.get_accelerometer_data()
        print("Accelerometer Data [xyz]", acc, "m/s^2")
        magn = hexi.get_magnetometer_data()
        print("Magnetometer Data [xyz]", magn, "uT")
        magn = hexi.get_gyroscope_data()
        print("Gyroscope Data [xyz]", magn, "dps")
        temp = hexi.get_temperature()
        print("Temperature", temp, "*C")
        humid = hexi.get_humidity()
        print("Humidity", humid, "RH%")
        press = hexi.get_pressure()
        print("Pressure", press, "Pa")
        hr = hexi.get_heart_rate()
        print("Heart Rate", hr, "bpm")
        print("------------------------------------------------------------------------------")
        sleep(3000)
    except Exception as e:
        print(e)
        sleep(3000)
```
## Basic example of use for kw40z on hexiwear device


Interact with ble chip on hexiwear device to set on/off the bluetooth feature and to test the 
bluetooth pairing




```main.py```

```python
################################################################################
# Basic example for interacting with bluetooth low energy chip on hexiwear
#
# Created: 2017-03-29 12:50:52.955862
#
################################################################################

from nxp.hexiwear.kw40z import kw40z
import streams
import threading

streams.serial()

def pressed_up():
    print("Up Button Pressed")

def pressed_down():
    print("Down Button Pressed")

def toggle_ble():
    try:
        print("Left Button Pressed")
        bt_driver.toggle_adv_mode()
    except Exception as e:
        print("error on left_pressed", e)

def toggle_touch():
    try:
        print("Right Button Pressed")
        bt_driver.toggle_tsi_group()
    except Exception as e:
        print("error on right_pressed", e)
    
def print_paircode():
    print("Your Pair Code:",bt_driver.passkey)

# used to check the bluetooth status
pinMode(LED1, OUTPUT)

def check_status():
    print("Device Settings")
    bt_on, bt_touch, bt_link = bt_driver.info()
    print("Bluetooth State: ", ("On" if bt_on == 1 else "Off"))
    digitalWrite(LED1, 0 if bt_on==1 else 1)
    print("Capacitive Button Active: ", ("Left" if bt_touch == 0 else "Right"))
    print("Link State: ", ("Connected" if bt_link == 1 else "Disconnected"))
    while True:
        bt_on_new, bt_touch_new, bt_link_new = bt_driver.info()
        if bt_on_new != bt_on:
            print("Bluetooth State: ", ("On" if bt_on_new == 1 else "Off"))
            digitalWrite(LED1, 0 if bt_on_new==1 else 1)
            bt_on = bt_on_new
        if bt_touch_new != bt_touch:
            print("Capacitive Button Active: ", ("Left" if bt_touch_new == 0 else "Right"))
            bt_touch = bt_touch_new
        if bt_link_new != bt_link:
            print("Link State: ", ("Connected" if bt_link_new == 1 else "Disconnected"))
            bt_link = bt_link_new
        sleep(500)
        
try:
    print("init...")
    # Setup ble chip 
    # This setup is referred to kw40z mounted on Hexiwear device
    # The original Hexiwear default application binary file must be pre-loaded inside the kw40z 
    # The application binary file for kw40z can be found here:
    # Link: https://github.com/MikroElektronika/HEXIWEAR/blob/master/SW/binaries/HEXIWEAR_KW40.bin
    bt_driver = kw40z.KW40Z_HEXI_APP(SERIAL1)
    print("start")
    bt_driver.start()
    # wait for starting the ble chip
    sleep(1000)
    # start thread for check ble status
    thread(check_status)
    # attach callback function to left and right button
    bt_driver.attach_button_left(toggle_ble)
    bt_driver.attach_button_right(toggle_touch)
    bt_driver.attach_button_up(pressed_up)
    bt_driver.attach_button_down(pressed_down)
    bt_driver.attach_passkey(print_paircode)
except Exception as e:
    print("error1:", e)
    
while True:
    try:
        print(".")
        sleep(5000)
    except Exception as e:
        print("error2", e)
        sleep(1000)

```
## Sensor Data Exchange via Bluetooth


Expose Hexiwear data sensors via bluetoooth readable through any smartphone/tablet/pc bluetooth terminal.




```main.py```

```python
################################################################################
# Send Battery Level via Bluetooth
#
# Created: 2017-03-29 14:45:18.159845
#
################################################################################

from nxp.hexiwear.kw40z import kw40z
import streams
import threading

streams.serial()

def toggle_ble():
    try:
        print("Left Button Pressed")
        bt_driver.toggle_adv_mode()
    except Exception as e:
        print("error on left_pressed", e)
    
def print_paircode():
    print("Your Pair Code:",bt_driver.passkey)

pinMode(LED1, OUTPUT)

def check_status():
    print("Device Settings")
    bt_on, bt_touch, bt_link = bt_driver.info()
    print("Bluetooth State: ", ("On" if bt_on == 1 else "Off"))
    digitalWrite(LED1, 0 if bt_on==1 else 1)
    print("Capacitive Button Active: ", ("Left" if bt_touch == 0 else "Right"))
    print("Link State: ", ("Connected" if bt_link == 1 else "Disconnected"))
    while True:
        bt_on_new, bt_touch_new, bt_link_new = bt_driver.info()
        if bt_on_new != bt_on:
            print("Bluetooth State: ", ("On" if bt_on_new == 1 else "Off"))
            digitalWrite(LED1, 0 if bt_on_new==1 else 1)
            bt_on = bt_on_new
        if bt_touch_new != bt_touch:
            print("Capacitive Button Active: ", ("Left" if bt_touch_new == 0 else "Right"))
            bt_touch = bt_touch_new
        if bt_link_new != bt_link:
            print("Link State: ", ("Connected" if bt_link_new == 1 else "Disconnected"))
            bt_link = bt_link_new
        sleep(500)
        
try:
    # Setup ble chip 
    # This setup is referred to kw40z mounted on Hexiwear device
    # The original Hexiwear default application binary file must be pre-loaded inside the kw40z 
    # The application binary file for kw40z can be found here:
    # Link: https://github.com/MikroElektronika/HEXIWEAR/blob/master/SW/binaries/HEXIWEAR_KW40.bin
    print("init...")
    bt_driver = kw40z.KW40Z_HEXI_APP(SERIAL1)
    print("start")
    bt_driver.start()
    # wait for starting the ble chip
    sleep(1000)
    # start thread for check ble status
    thread(check_status)
    # attach callback function to left and right button
    bt_driver.attach_button_left(toggle_ble)
    bt_driver.attach_passkey(print_paircode)
except Exception as e:
    print("error1:", e)
    
level = 0
while True:
    try:
        print(".")
        bt_driver.upd_sensors(battery=level)
        level += 1
        if level > 100:
            level = 0
        sleep(5000)
    except Exception as e:
        print("error2", e)
        sleep(1000)

```

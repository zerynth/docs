# Examples

The following are a list of examples for lib.bridgetek.bt81x.

## Display Zerynth Logo 


Display Zerynth Logo.



```main.py```

```python
import streams
from riverdi.displays.bt81x import ctp50
from bridgetek.bt81x import bt81x

streams.serial()

# choose one logo to be loaded on flash
new_resource('zerynth_logo.bin')
# new_resource('zerynth_logo.png')

LOGO_W = 642
LOGO_H = 144
linestride = LOGO_W * 2 # with ARGB1555 and ARGB4 formats, 2 bytes per pixel

layout = (bt81x.ARGB1555, linestride) # choose this layout for zerynth_logo.bin
# layout = (bt81x.ARGB4, linestride)  # choose this layout for zerynth_logo.png

zerynth_logo = bt81x.Bitmap(1, 0, layout,
                    (bt81x.BILINEAR, bt81x.BORDER, bt81x.BORDER, LOGO_W, LOGO_H))

bt81x.init(SPI0, D4, D33, D34)

bt81x.inflate(0, 'zerynth_logo.bin')
# bt81x.load_image(0, 0, 'zerynth_logo.png')

bt81x.dl_start()
bt81x.clear_color(rgb=(0xff, 0xff, 0xff))
bt81x.clear(1, 1, 0)

zerynth_logo.prepare_draw()
zerynth_logo.draw(((bt81x.display_conf.width - LOGO_W)//2, (bt81x.display_conf.height - LOGO_H)//2), vertex_fmt=0)

bt81x.display()
bt81x.swap_and_empty()

```
## Display Networks


Scan for networks and display them on the LCD as clickable buttons.



```main.py```

```python
# display networks

import streams
from wireless import wifi

from espressif.esp32net import esp32wifi as wifi_driver 

from riverdi.displays.bt81x import ctp50
from bridgetek.bt81x import bt81x

streams.serial()
wifi_driver.auto_init()

TAG_BASE = 1
BTN_WIDTH = bt81x.display_conf.width
BTN_HEIGHT = bt81x.display_conf.height // 8
MAX_NET = 7

# different colors for pressed and non-pressed buttons
palette_default = bt81x.Palette((0xff, 0xff, 0xff), (0, 0, 0xff))
palette_pressed = bt81x.Palette((0xff, 0xff, 0xff), (0xff, 0, 0))
btn = bt81x.Button(0, 0, BTN_WIDTH, BTN_HEIGHT, 31, 0, "", palette=palette_default)

def draw_networks(networks, pressed=None):
    bt81x.dl_start()
    bt81x.clear(1, 1, 1)

    for i, ssid_sec in enumerate(networks):
        if i == MAX_NET:
            # do not display more networks than MAX_NET
            break
        btn.palette = palette_pressed if i==pressed else palette_default
        btn.text = ("%s::%s") % (ssid_sec[0], ssid_sec[1])
        btn.y = i*BTN_HEIGHT
        bt81x.track(0, btn.y, BTN_WIDTH, BTN_HEIGHT, TAG_BASE + i)
        bt81x.tag(TAG_BASE + i)
        bt81x.add_button(btn)

    bt81x.display()
    bt81x.swap_and_empty()

def pressed(tag, tracked, tp):
    print("PRESSED!", tag)
    draw_networks(networks, pressed=tag-1)

bt81x.init(SPI0, D4, D33, D34)

# uncomment these lines to calibrate resistive displays
# bt81x.dl_start()
# bt81x.calibrate()
# bt81x.swap_and_empty()

wifi_sec=("Open","WEP","WPA","WPA2")
print("> scanning")
# scan and keep network name and security
networks = [(scanned[0], wifi_sec[scanned[1]]) for scanned in wifi.scan(15000)]
print("> scan results...")

draw_networks(networks)
# register 'pressed' callback for touch events on every tagged object
bt81x.touch_loop(((-1, pressed), ))

```
## Display Widgets 


Select a widget to display, pressing on a key.

    1. spinner clock
    2. spinner orbiting
    3. spinner circle
    4. spinner line
    5. auto-updating clock



```main.py```

```python
import streams
import threading
import rtc

from riverdi.displays.bt81x import ctp50
from bridgetek.bt81x import bt81x

def updating_clock():
    tt = rtc.get_utc()
    bt81x.add_clock(bt81x.display_conf.width//2, (bt81x.display_conf.height*5)//7, bt81x.display_conf.height//6, 
        0, tt.tm_hour, tt.tm_min, tt.tm_sec, 0)

    # simulate a touch event to refresh the clock widget, sleep is needed to not let other threads starve
    sleep(400)
    widget_choice_evt.set()

def demo_spinner(style):
    bt81x.spinner(bt81x.display_conf.width//2, (bt81x.display_conf.height*5)//7, style, 0)

# the widgets tuple contains tuples with:
#   - widget description
#   - widget draw function
#   - widget draw function arguments
widgets = (
    ("spinner clock", demo_spinner, bt81x.SPINNER_CLOCK),
    ("spinner orbiting", demo_spinner, bt81x.SPINNER_ORBITING),
    ("spinner circle", demo_spinner, bt81x.SPINNER_CIRCLE),
    ("spinner line", demo_spinner, bt81x.SPINNER_LINE),
    ("auto-updating clock", updating_clock, ),
)

widget_choice = None
widget_choice_evt = threading.Event()
widget_selection_keys = "123456789"
widget_selection_keys = widget_selection_keys[:len(widgets)]

def widget_choice_cbk(_widget_choice, _):
    global widget_choice
    widget_choice = _widget_choice - __ORD('0')
    widget_choice_evt.set()

palette_default = bt81x.Palette((0xff, 0xff, 0xff), foreground=(0x3c, 0x82, 0x82))
txt = bt81x.Text(0, 0, 31, bt81x.OPT_CENTERX | bt81x.OPT_CENTERY, "", palette=palette_default)

streams.serial() # open serial channel to display debug messages

print('> Init chip')
bt81x.init(SPI0, D4, D33, D34)
bt81x.touch_loop(((-1, widget_choice_cbk), )) # listen to touch events and make widget_choice_cbk process them

def widget_selection():
    bt81x.dl_start()
    bt81x.clear(1, 1, 1)

    txt.font = 31
    txt.text = "Choose a widget"
    txt.x = bt81x.display_conf.width//2
    txt.y = (bt81x.display_conf.height*2)//11
    bt81x.add_text(txt)

    bt81x.track(bt81x.display_conf.width//5, (bt81x.display_conf.height*3)//11, 500, 100, 0)
    bt81x.add_keys(bt81x.display_conf.width//5, (bt81x.display_conf.height*3)//11, 500, 100, 31, 0, widget_selection_keys)

    if widget_choice:
        print('> displaying', widgets[widget_choice-1][0])
        widgets[widget_choice-1][1](*widgets[widget_choice-1][2:])

    bt81x.display()
    bt81x.swap_and_empty()

    widget_choice_evt.wait()
    widget_choice_evt.clear()

# uncomment these lines to calibrate resistive displays
# bt81x.dl_start()
# bt81x.calibrate()
# bt81x.swap_and_empty()

while True:
    widget_selection()
```

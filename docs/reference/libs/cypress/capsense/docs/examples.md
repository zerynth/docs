# Examples

The following are a list of examples for lib.cypress.capsense

## Capsense Events


Touch any button or the slider on your PSOC6 board and get notified.


```main.py```

```python
################################################################################
# Capsense Events
# 
# Created by Zerynth Team 2019 CC
# Authors: L.Rizzello, G. Baldi
################################################################################

import streams
from cypress.capsense import capsense

def hello():
    print("hello!!!")

def bye():
    print("bye...")

def notify_leave(start_pos, end_pos):
    print("slider leave!", start_pos, end_pos)

def notify_enter(start_pos):
    print("slider enter:", start_pos)

def led_toggle(cur_pos):
    pinToggle(LED0)

streams.serial()

print('> init capsense')
capsense.init()

capsense.on_btn(hello)
capsense.on_btn(bye, event=capsense.BTN0_FALL)
capsense.on_btn(hello, event=capsense.BTN1_RISE)
capsense.on_btn(bye, event=capsense.BTN1_FALL)
capsense.on_slider(notify_leave, event=capsense.SLIDER_LEAVE)
capsense.on_slider(notify_enter, event=capsense.SLIDER_ENTER)
capsense.on_slider(led_toggle, event=capsense.SLIDER_LVLCHNG)


```

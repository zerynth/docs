# Examples

The following are a list of examples for lib.vishay.vcnl4200

## Read distance from VCNL4200


Basic example to read the current values of distance and ambient light from
sensor.



```main.py```

```python
################################################################################
# Read distance and ambient light from VCNL4200
#
# Created: 2019-09-03 16:53
################################################################################

import streams
from vishay.vcnl4200 import vcnl4200

streams.serial()

# Initialize sensor object on I2C0
sensor = vcnl4200.VCNL4200(I2C0)

# Read data and print it in loop
while True:
    distance = sensor.get_distance()
    light = sensor.get_ambient_light()
    print('Distance:', distance, 'Light:', light)
    sleep(100)

```

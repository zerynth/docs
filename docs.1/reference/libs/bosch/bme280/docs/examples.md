# Examples

The following are a list of examples for lib.bosch.bme280.

## Read humidity, temperature and pressure values from BME280


Basic example to read the current values of relative humidity, temperature and atmoshperic pressure from Bosch sensor BME280.


```main.py```

```python
################################################################################
# Temperature, Humidity and Pressure Example
#
# Created: 2019-01-18 08:47:18.498321
#
################################################################################

import streams
from bosch.bme280 import bme280

streams.serial()

try:
    # Setup sensor 
    print("start...")
    bme = bme280.BME280(I2C0)
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)
    
try:
    while True:
        temp, hum, pres = bme.get_values()
        print("Temperature:", temp, "C")
        print("Humidity:", hum, "%")
        print("Pressure:", pres, "Pa")
        print("--------------------------------------------------------")
        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk3MTE5NjUxMF19
-->
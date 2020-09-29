# Examples

The following are a list of examples for lib.meas.htu21d.

## Read Humidity and Temperature values from HTU21D


Basic example to read the current values of temperature and relative humidity from HTU21D sensor.




```main.py```

```python
################################################################################
# Humidity and Temperature Example
#
# Created: 2017-03-17 11:45:14.498321
#
################################################################################

import streams
from meas.htu21d import htu21d

streams.serial()

try:
    # Setup sensor 
    # This setup is referred to htu21d mounted on hexiwear device 
    htu = htu21d.HTU21D(I2C0)
    print("start...")
    htu.start()
    print("init...")
    htu.init()
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)
    
try:
    while True:
        raw_temp = htu.get_raw_temp() # Read raw temperature
        print("Raw Temperature: ", raw_temp)
        raw_humid = htu.get_raw_humid() # Read raw humidity
        print("Raw Humidity: ", raw_humid)
        temp = htu.get_temp() # Read temperature in °C
        print("Temperature: ", temp, "C")
        humid = htu.get_humid() # Read relative humidity
        print("Humidity: ", humid, "%")
        t,h = htu.get_temp_humid() # Read both temperature and humidity
        print("Temperature - Humidity: ", t," C -", h, " %")
        print("--------------------------------------------------------")
        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTUxNjIxMTg1OF19
-->
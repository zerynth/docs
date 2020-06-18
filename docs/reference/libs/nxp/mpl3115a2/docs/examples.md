# Examples

The following are a list of examples for lib.nxp.mpl3115a2.

## Read Pressure from MPL3115A2


Basic example to read the pressure from MPL3115A2 sensor.




```main.py```

```python
################################################################################
# Pressure Example
#
# Created: 2017-03-22 11:02:42.526582
#
################################################################################

import streams
from nxp.mpl3115a2 import mpl3115a2

streams.serial()

try:
    # Setup sensor 
    # This setup is referred to mpl3115a2 mounted on hexiwear device 
    mpl = mpl3115a2.MPL3115A2(I2C1)
    print("start...")
    mpl.start()
    print("init...")
    mpl.init()
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)
    
try:
    while True:
        raw_alt = mpl.get_raw_alt() # Read raw altitude
        print("Raw Altitude: ", raw_alt)
        raw_pres = mpl.get_raw_pres() # Read raw pressure
        print("Raw Pressure: ", raw_pres)
        raw_temp = mpl.get_raw_temp() # Read raw temperature
        print("Raw Temperature: ", raw_temp)
        alt = mpl.get_alt() # Read altitude
        print("Altitude: ", alt, "m")
        pres = mpl.get_pres() # Read pressure
        print("Pressure: ", pres, "Pa")
        temp = mpl.get_temp() # Read trmperature
        print("Temperature: ", temp, "C")
        print("--------------------------------------------------------")
        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExMDUyMzc3MzVdfQ==
-->
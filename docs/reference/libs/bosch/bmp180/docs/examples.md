# Examples

The following are a list of examples for lib.bosch.bmp180.

## Temperature, Pressure, Altitude


Get Temperature, Pressure, and Altitude throught the BMP180 sensor features.


```main.py```

```python
################################################################################
# Get Temperature, Pressure, and Altitude Example
#
# Created: 2017-02-28 16:44:15.135468
#
################################################################################

from bosch.bmp180 import bmp180
import streams

streams.serial()

# Setup sensor 
# This setup is referred to bmp180 mounted on 10DOF Click in slot A of a Flip n Click device 

bmp = bmp180.BMP180(I2C0)
print("start...")
bmp.start()
print("init...")
bmp.init()
print("Ready!")
print("--------------------------------------------------------")

while True:
    rt = bmp.get_raw_temp() # Read raw temperature
    print("Raw Temperature: ", rt)
    rp = bmp.get_raw_pres() # Read raw pressure
    print("Raw Pressure: ", rp)
    temp = bmp.get_temp() # Read temperature
    print("Temperature: ", temp, "C")
    pres = bmp.get_pres() # Read pressure
    print("Pressure: ", pres, "Pa")
    temp, pres = bmp.get_temp_pres() # Read both (temperature and pressure)
    print("Temp: ", temp, "C and Pres:", pres, "Pa")
    altitude = bmp.get_altitude() # Read altitude
    print("Altitude: ", altitude, "m")
    slp = bmp.get_sea_level_pres(altitude_m=altitude) # Read pressure at level sea
    print("Pressure at level sea: ", slp, "Pa")
    print("--------------------------------------------------------")
    sleep(5000)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTk2Mjg2MDIzNl19
-->
# Examples

The following are a list of examples for lib.nxp.fxas21002c

## Read Gyroscope Data from FXAS21002C


Basic example to read the angular velocity from FXAS21002C gyroscope




```main.py```

```python
################################################################################
# Gyroscope Example
#
# Created: 2017-03-23 15:45:48.789211
#
################################################################################

import streams
from nxp.fxas21002c import fxas21002c

streams.serial()

try:
    # Setup sensor 
    # This setup is referred to fxas21002c mounted on hexiwear device 
    fxas = fxas21002c.FXAS21002C(I2C1)
    print("start...")
    fxas.start()
    print("init...")
    fxas.init()
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)
    
try:
    while True:
        raw_gyro = fxas.get_raw_gyro() # Read raw gyroscope data
        print("Raw Acceleration: ", raw_gyro)
        raw_temp = fxas.get_raw_int_temp() # Read raw internal trmperature
        print("Raw Internal Temperature: ", raw_temp)
        gyro = fxas.get_gyro() # Read gyroscope data in dps (degrees per second)
        print("Gyroscope Data: ", gyro, "dps")
        gyro_x = fxas.get_gyro('x') # Read gyroscope data on x axis in dps
        gyro_y = fxas.get_gyro('y') # Read gyroscope data on y axis in dps
        gyro_z = fxas.get_gyro('z') # Read gyroscope data on z axis in dps
        print("Gyroscope Data: x -->",gyro_x, "dps")
        print("Gyroscope Data: y -->",gyro_y, "dps")
        print("Gyroscope Data: z -->",gyro_z, "dps")
        temp_c = fxas.get_int_temp('C') # Read internal termperature in C
        temp_k = fxas.get_int_temp('K') # Read internal termperature in K
        temp_f = fxas.get_int_temp('F') # Read internal termperature in F
        print("Internal Temperature: Celtius -->", temp_c, "C")
        print("Internal Temperature: Kelvin -->", temp_k, "K")
        print("Internal Temperature: Fahrenheit -->", temp_f, "F")
        print("--------------------------------------------------------")
        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```

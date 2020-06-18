# Examples

The following are a list of examples for lib.nxp.fxos8700cq.

## Read Accelerometer and Magnetometer data from FXOS8700CQ


Basic example to read the accelerometer and magnetometer data from FXOS8700CQ sensor.




```main.py```

```python
################################################################################
# Accelerometer and Magnetometer Example
#
# Created: 2017-03-30 09:42:08.655652
#
################################################################################

import streams
from nxp.fxos8700cq import fxos8700cq

streams.serial()

try:
    # Setup sensor 
    # This setup is referred to fxos8700cq mounted on hexiwear device 
    fxos = fxos8700cq.FXOS8700CQ(I2C1)
    print("start...")
    fxos.start()
    print("init...")
    fxos.init()
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)
    
try:
    while True:
        raw_acc = fxos.get_raw_acc() # Read raw accelerometer data
        print("Raw Acceleration: ", raw_acc)
        raw_mag = fxos.get_raw_mag() # Read raw magnetometer data
        print("Raw Magnetometer Data: ", raw_mag)
        raw_temp = fxos.get_raw_int_temp() # Read raw trmperature
        print("Raw Temperature: ", raw_temp)
        acc = fxos.get_acc() # Read accelerometer data in m/s^2
        print("Acceleration: ", acc, "m/s^2")
        mag_x = fxos.get_mag('x') # Read magnetometer data on x axis in uT
        mag_y = fxos.get_mag('y') # Read magnetometer data on y axis in uT
        mag_z = fxos.get_mag('z') # Read magnetometer data on z axis in uT
        print("Magnetometer Data: x -->",mag_x, "uT")
        print("Magnetometer Data: y -->",mag_y, "uT")
        print("Magnetometer Data: z -->",mag_z, "uT")
        temp_c = fxos.get_int_temp('C') # Read termperature in C
        temp_k = fxos.get_int_temp('K') # Read termperature in K
        temp_f = fxos.get_int_temp('F') # Read termperature in F
        print("Temperature: Celtius -->", temp_c, "C")
        print("Temperature: Kelvin -->", temp_k, "K")
        print("Temperature: Fahrenheit -->", temp_f, "F")
        print("--------------------------------------------------------")
        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzNzE1MDQ4OV19
-->
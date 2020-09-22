# Examples

-   [get values](https://oldtestdocs.zerynth.com/latest/official/lib.invensense.mpu6050/examples/examples.html#lib-invensense-mpu6050-get-values)
-   [get motion](https://oldtestdocs.zerynth.com/latest/official/lib.invensense.mpu6050/examples/examples.html#lib-invensense-mpu6050-get-motion)

## get values

```python
Read temperature, accelerometer and gyroscope value from MPU6050
==========================================================

Basic example to read the current values from Invensense sensor MPU6050.
```

```python
################################################################################
# Motion Sensor Example
#
# Created: 2020-08-07
# Author: S. Torneo
#
################################################################################

import streams
from invensense.mpu6050 import mpu6050

streams.serial()

try:
    # Setup sensor 
    print("start...")
    mpu = mpu6050.MPU6050(I2C0)
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)

try:
    while True:
        if (mpu.is_data_ready()):
            temp, acc, gyro = mpu.get_values()
            print("Temperature: ", temp, "C")
            print("Accelerometer: ", acc)
            print("Gyroscope: ", gyro)
            print("--------------------------------------------------------")
        sleep(2000)
except Exception as e:
    print("Error2: ",e)
```

## get motion

```python
Detect motion from MPU6050
==========================================================

Basic example to detect motion from Invensense sensor MPU6050.
```
```python
################################################################################
# Motion Detection Example
#
# Created: 2020-08-25
# Author: S. Torneo
#
################################################################################

import streams
from invensense.mpu6050 import mpu6050

streams.serial()

try:
    # Setup sensor 
    print("start...")
    mpu = mpu6050.MPU6050(I2C0)
    print("Ready!")
    print("--------------------------------------------------------")
    mpu.setup_motion()
except Exception as e:
    print("Error: ",e)
    
try:
    while True:
        if (mpu.is_motion_detected()):
            print("Motion captured")
        sleep(200)
except Exception as e:
    print("Error2: ",e)
 
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjExODc2MTQwN119
-->
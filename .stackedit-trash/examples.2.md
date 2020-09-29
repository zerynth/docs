# Examples

- [get values]((/latest/reference/libs/invensense/mpu9250/docs/examples/#get-values))

```py
Read temperature, accelerometer, gyroscope and magnetometer values from MPU9250
==========================================================

Basic example to read the current values from Invensense sensor MPU9250.
################################################################################
# Invensense-MPU9250 Example
#
# Created: 2020-09-23
# Author: S. Torneo
#
################################################################################

import streams
from invensense.mpu9250 import mpu9250

streams.serial()

try:
    # Setup sensor 
    print("start...")
    mpu = mpu9250.MPU9250(I2C0)
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)


try:
    while True:
        if (mpu.is_data_ready()):
            temp, acc, gyro, magneto = mpu.get_values()
            print("Temperature: ", temp, "C")
            print("Accelerometer: ", acc)
            print("Gyroscope: ", gyro)
            print("Magnetometer: ", magneto)
            print("--------------------------------------------------------")
        sleep(2000)
except Exception as e:
    print("Error2: ",e)

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbNjU3MDQ1NzU1XX0=
-->
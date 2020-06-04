# Examples

The following are a list of examples for lib.stm.ism330dhcx

## Read Accelerometer, Gyroscope and Temperature data from ISM330DHCX


Basic example to read the current values of acceleration, angular velocity, and temperature from STM sensor ISM330DHCX.


```main.py```

```python
################################################################################
# Get Data Example
#
# Created: 2020-03-31 16:23:12.973495
#
################################################################################

import streams

from stm.ism330dhcx import ism330dhcx

streams.serial()

try:
    # Setup sensor 
    print("start...")
    accgyro = ism330dhcx.ISM330DHCX(SPI0, D86)
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)

try:
    while True:
        raw_acc = accgyro.get_acc_data(raw=True)
        print("Raw Acc:", raw_acc)
        acc = accgyro.get_acc_data()
        str = "Acc: %.2f," %acc[0]
        str = str + " %.2f," %acc[1]
        str = str + " %.2f," %acc[2]
        print(str)

        raw_gyro = accgyro.get_gyro_data(raw=True)
        print("Raw Gyro:", raw_gyro)
        gyro = accgyro.get_gyro_data()
        # print("Gyro:", gyro)
        str = "Gyro: %.2f," %(gyro[0] / 1000.0)
        str = str + " %.2f," %(gyro[1] / 1000.0)
        str = str + " %.2f," %(gyro[2] / 1000.0)
        print(str)
        
        raw_temp = accgyro.get_temp_data(raw=True)
        print("Raw Temperature:", raw_temp)
        temp = accgyro.get_temp_data()
        print("Temperature:", temp)
        print("--------------------------------------------------------")
        print("========================================================")
        
        print("Fast Read:")
        data = accgyro.get_fast()
        print("TEMP: ", data[0])
        
        str = "Acc: %.2f," %data[1]
        str = str + " %.2f," %data[2]
        str = str + " %.2f," %data[3]
        print(str)
        
        str = "Gyro: %.2f," %(data[4])
        str = str + " %.2f," %(data[5])
        str = str + " %.2f," %(data[6])
        print(str)

        print("========================================================")
        print("--------------------------------------------------------")

        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```

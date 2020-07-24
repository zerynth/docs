# Examples

The following are a list of examples for lib.stm.iis3dwb.

## Read Vibrometer and Temperature data from IIS3DWB


Basic example to read the current values of acceleration, and temperature from STM sensor IIS3DWB.


```main.py```

```python
################################################################################
# Get Data Example
#
# Created: 2020-03-31 16:23:12.973495
#
################################################################################

import streams

from stm.iis3dwb import iis3dwb

streams.serial()

try:
    # Setup sensor 
    print("start...")
    vibro = iis3dwb.IIS3DWB(SPI0, D86)
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)

try:
    while True:
        raw_acc = vibro.get_acc_data(raw=True)
        print("Raw Acc:", raw_acc)
        acc = vibro.get_acc_data()
        str = "Acc: %.2f," %acc[0]
        str = str + " %.2f," %acc[1]
        str = str + " %.2f," %acc[2]
        print(str)
        
        raw_temp = vibro.get_temp_data(raw=True)
        print("Raw Temperature:", raw_temp)
        temp = vibro.get_temp_data()
        print("TEMP:", temp)
        print("--------------------------------------------------------")
        print("========================================================")
        
        print("Fast Read:")
        data = vibro.get_fast()
        print("TEMP: ", data[0])
        
        str = "Acc: %.2f," %data[1]
        str = str + " %.2f," %data[2]
        str = str + " %.2f," %data[3]
        print(str)

        print("========================================================")
        print("--------------------------------------------------------")

        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```

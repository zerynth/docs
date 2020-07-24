# Examples

The following are a list of examples for lib.stm.stts751.

## Read temperature values from STTS751


Basic example to read the current values of temperature from STM sensor STTS751.


```main.py```

```python
################################################################################
# Temperature Example
#
# Created: 2020-03-20 11:47:18.498321
#
################################################################################

import streams
from stm.stts751 import stts751

streams.serial()

try:
    # Setup sensor 
    print("start...")
    stts = stts751.STTS751(I2C0)
    print("Ready!")
    product_id, manufacturer_id, revision_id = stts.get_sensor_id()
    print("Product ID     ", product_id)
    print("Manufacturer ID", manufacturer_id)
    print("Revision ID    ", revision_id)
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)
    
try:
    while True:
        raw_temp = stts.get_temp(raw=True)
        print("Raw Temperature:", raw_temp)
        temp = stts.get_temp()
        print("Temperature:", temp)
        print("--------------------------------------------------------")
        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```

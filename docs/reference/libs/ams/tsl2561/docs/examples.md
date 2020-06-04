# Examples

The following are a list of examples for lib.ams.tsl2561

## Read Ambient Light from TSL2561


Basic example to read the illuminance from TSL2561 sensor




```main.py```

```python
################################################################################
# Illuminance Example
#
# Created: 2017-03-16 17:03:14.563172
#
################################################################################

import streams
from ams.tsl2561 import tsl2561

streams.serial()

try:
    # Setup sensor 
    # This setup is referred to tsl2561 mounted on on hexiwear device
    # Address pin of the sensor connected to gnd
    tsl = tsl2561.TSL2561(I2C0, addr=tsl2561.TSL_I2C_ADDRESS["LOW"])
    print("start...")
    tsl.start()
    print("init...")
    tsl.init()
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)
    
try:
    while True:
        raw_ir = tsl.get_raw_infrared() # Read raw infrared
        print("Raw Infrared: ", raw_ir)
        raw_fs = tsl.get_raw_fullspectrum() # Read raw fullspectrum
        print("Raw FullSpectrum: ", raw_fs)
        raw_vis = tsl.get_raw_visible() # Read raw visible
        print("Raw Visible: ", raw_vis)
        lux = tsl.get_lux() # Read Lux
        print("Illuminance: ", lux, "Lux")
        print("--------------------------------------------------------")
        sleep(5000)
except Exception as e:
    print("Error2: ",e)
```

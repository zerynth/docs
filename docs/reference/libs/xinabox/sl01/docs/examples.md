# Examples

The following are a list of examples for lib.xinabox.sl01

## LUX Measurement


This example reads the ambient light level from TSL4531 as LUX and prints it out on the serial console.


```main.py```

```python
##############################################
#   This is an example for SL01 UV and light
#	sensor.
#
#   Ambient light level is measured and
# 	printed out on the console.
##############################################

import streams
from xinabox.sl01 import sl01

streams.serial()

# SL01 instance
SL01_T = sl01.TSL4531(I2C0)

# configure and start TSL4531
SL01_T.init()

while True:
	lux=SL01_T.getLUX()	#return ambient light level as lux
	print('Light level: ', lux, ' LUX')

	sleep(2000)
```
## UV Measurements


This example reads the UVA, UVB and UV Index from VEML6075 and prints it out on the serial console.



```main.py```

```python
##############################################
#   This is an example for SL01 UV and light
#	sensor.
#
#   UV data is read and printed out on the 
# 	console.
##############################################

import streams
from xinabox.sl01 import sl01

streams.serial()

# SL01 instance
SL01_V = sl01.VEML6075(I2C0)

# configure and start SL01
SL01_V.init()

while True:
    uva=SL01_V.getUVA()		# return uva intensity 
    uvb=SL01_V.getUVB()		# return uvb intensity
    uvi=SL01_V.getUVIndex()	# return uv index
    
    print('UVA Intensity: ', uva, ' uW/m^2\n\n')
    print('UVB Intensity: ', uvb, ' uW/m^2\n\n')
    print('UV Index     : ', uvi, '\n\n')
    
    sleep(2000)

```

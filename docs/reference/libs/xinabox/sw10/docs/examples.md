# Examples

The following are a list of examples for lib.xinabox.sw10

## Ambient Temperature Measurement


This example measures ambient temperature and prints it out on the serial console.


```main.py```

```python
##############################################
#   This is an example for SW10 temperature
#	sensor.
#
#   Ambient temperature is measured and
# 	printed out on the console.
##############################################

import streams
from xinabox.sw10 import sw10

streams.serial()

# SW10 instance
SW10 = sw10.SW10(I2C0)

# configure SW10
SW10.init()

while True:
    tempC = SW10.getTempC()		# return temp in celcius
    tempF = SW10.getTempF()		# return temp in fahrenheit
    
    # print to console
    print('Temperature: ',tempC,' C')
    print('Temperature: ',tempF,' F')
    
    sleep(2000)
```

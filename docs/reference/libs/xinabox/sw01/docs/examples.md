# Examples

The following are a list of examples for lib.xinabox.sw01.

## Environmental Data Measurement


This example measures ambient temperature, humidity and atmoshperic pressure and prints it out on the serial console.



```main.py```

```python
##############################################
#   This is an example for the SW01
#	weather sensor
#
#   Ambient temperature, humidity and pressure
#	is measured and printed out on the console.
##############################################
import streams

from xinabox.sw01 import sw01

streams.serial()

# SW01 instance
SW01 = sw01.SW01(I2C0)

while True:
    tempC = SW01.getTempC()		# return temp in degree celcius
    tempF = SW01.getTempF()		# return temp in degree fahrenheit
    
    hum = SW01.getHumidity()	# return humidity in percentage

    pres = SW01.getPressure()	# return pressure in hectopascal
    
    print('Temperature: ', tempC, ' C')	
    print('Temperature: ', tempF, ' F')

    print('Humidity   :', hum, ' %')

    print('Pressure   :', pres, ' hpa')
    
    sleep(1000)

```

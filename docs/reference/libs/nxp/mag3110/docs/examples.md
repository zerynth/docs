# Examples

-   [get values](https://oldtestdocs.zerynth.com/latest/official/lib.nxp.mag3110/examples/examples.html#lib-nxp-mag3110-get-values)
-   [triggered measurement](https://oldtestdocs.zerynth.com/latest/official/lib.nxp.mag3110/examples/examples.html#lib-nxp-mag3110-triggered-measurement)

## get values

Read magnetometer values from MAG3110
==========================================================

Basic example to read the current values of magnetometer from NXP sensor MAG3110.

################################################################################
# Magnetometer Sensor Example
#
# Created: 2020-08-24
# Author: S. Torneo
#
################################################################################

import streams
from nxp.mag3110 import mag3110

streams.serial()

try:
    # Setup sensor 
    print("start...")
    mag = mag3110.MAG3110(I2C0)
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)

try:
    while True:
        # check if magnetometer values are ready
        if (mag.is_data_ready()):
            # get magnetometer values
            values = mag.get_values()
            print("Magnetometer:", values)
        # get temperature value
        temp = mag.get_temp()
        print("Temperature: ", temp, "C")
        print("--------------------------------------------------------")
        sleep(1000)
except Exception as e:
    print("Error2: ",e)

## triggered measurement

Read magnetometer values from MAG3110 with triggered measurement
==========================================================

Basic example to read the current values of magnetometer from NXP sensor MAG3110.

################################################################################
# Magnetometer Sensor Example with Triggered Measurement
# This saves power but may affect the accuracy of the data.
#
# Created: 2020-08-26
# Author: S. Torneo
#
################################################################################

import streams
from nxp.mag3110 import mag3110
import timers

streams.serial()

try:
    # Setup sensor 
    print("start...")
    mag = mag3110.MAG3110(I2C0)
    # set triggered measurement mode
    mag.set_measurement(mode=1)
    print("Ready!")
    print("--------------------------------------------------------")
except Exception as e:
    print("Error: ",e)

# create a new timer
t=timers.timer()
# start the timer
t.start()

try:
    while True:
        # Trigger a measurement every 2 seconds
        if (t.get() >= 2000):
            mag.trigger_measurement()
            t.reset()
        # check if magnetometer values are ready
        if (mag.is_data_ready()):
            # get magnetometer values
            values = mag.get_values()
            print("Magnetometer:", values)
        # get temperature value
        temp = mag.get_temp()
        print("Temperature: ", temp, "C")
        print("--------------------------------------------------------")
        sleep(1000)
except Exception as e:
    print("Error2: ",e)
<!--stackedit_data:
eyJoaXN0b3J5IjpbNDIzMzQ3NjUzXX0=
-->
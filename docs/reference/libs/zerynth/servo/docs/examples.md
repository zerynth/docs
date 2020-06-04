# Examples

The following are a list of examples for lib.zerynth.servo

## Servo basics


Basic example of use of the servo library.
It is possible to control a servo motor by setting the position as pulse width (microseconds) or in degrees.






```main.py```

```python
################################################################################
# Servo Motor Basics
#
# Created by Zerynth Team 2015 CC
# Authors: D. Mazzei, G. Baldi,  
###############################################################################

from servo import servo
import streams

s=streams.serial()

# create a servo motor attaching it to the pin D11. D11.PWM notation must be used. 
# min max are left to defaults 500-2500. they need to be properly set to the servo specifications
# control signal period is left to default 20ms
MyServo=servo.Servo(D11.PWM)
  
    
while True:
    print("Servo ON")
    MyServo.attach()
    sleep(3000)
    
    print("Servo controlled in pulse width")
    for i in range (500,2500,10):
        MyServo.moveToPulseWidth(i)
        print(MyServo.getCurrentPulseWidth())
        # Very important: servo default control signal period is 20ms, don't update the controlling PWM faster than that!
        sleep (100) 
    
    print("Servo controlled in degrees")
    for i in range(0,180,1):
        # Very important: degree accuracy depends by the min max pulse width setup. Refer to the servo specifications for proper configuration
        MyServo.moveToDegree(i)
        print(MyServo.getCurrentDegree())
        sleep(100)
    
    print("servo OFF")
    MyServo.detach()
    sleep(3000)
```
## Servo Motor Animation


Example of use of the Animator library for controlling a servo motor.
The libreary allows definign an animation composed of points to be reached at certain times.
The animator calls the servo moveToDegree fucntion in parallel to the program workflow execution withouth requiring any time monitoring routine






```main.py```

```python
################################################################################
# Servo Motor Animation 
#
# Created by Zerynth Team 2015 CC
# Authors: D. Mazzei, G. Baldi,  
###############################################################################


from servo import servo
# WARNING! for this example to work the community floyd.animator must be installed!
from community.floyd.animator import animator
import streams

s=streams.serial()

# creates a list of points to be reached by the servo motor using tuples (position, millisecond)
# The first tuple has to be set with time=0: (desired_pos,0). This is the value from which the animation will start
# In this case servo motor positions in degrees are scheduled
pointList= [(0,0),(180,10000),(90,3000),(0,5000),(180,5000)] 

print("scheduled positions at times (ms):",pointList)

# create a servo motor attaching it to the pin D11. Specification of the PWM feature using the Zerynth pin mapping signature is required. 
# min max defaults in this case are selected for working with Hitech servomotors
MyServo=servo.Servo(D11.PWM,500,2500)

# create an animator that runs at 10Hz passing data to  MyServo.moveToDegree
# don't set too high frequency, 10-30 Hz are fine. The Servo is controlled with a period of 20ms, frequancy higher than 45Hz will block the motor! 
anim=animator.Animator(25,MyServo.moveToDegree)

# start the animations using the defined point list
anim.animate(pointList)
    
while True:
#just print the animator position and interpolated value
    print(anim.currentPosition())
    sleep(500)
```

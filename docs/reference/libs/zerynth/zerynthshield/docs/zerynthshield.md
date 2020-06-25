# Zerynth Shield Library

This module contains class definitions and instances for Zerynth Shield’s sensors. Furthermore it takes care of multi-device pin compatibility providing generic names for every useful pin on the shield. Every sensor of the Zerynth Shield is instanced as a child class of the Digital or the Analog Sensor class (as defined in Smart Sensors Library).
Moreover, few peculiar methods are added. The class inherits the whole set of sampling methods included in the Digital or Analog Sensor Library (startSampling, doEverySample, addCheck,…)

Pin names:


* zerynthshield.temperature_pin
* zerynthshield.light_pin
* zerynthshield.microphone_pin
* zerynthshield.iremitter_pin
* zerynthshield.irreceiver_pin
* zerynthshield.touch_pin
* zerynthshield.buzzer_pin
* zerynthshield.led_pin

Sensors:


* light (analogSensors): it is an instance of the analogSensor class configured for the Zerynth Shield light sensor
* microphone (analogSensors): it is an instance of the analogSensor class configured for the Zerynth Shield microphone
* temperature (analogSensors): it is an instance of the analogSensor class configured for the Zerynth Shield temperature sensor
* touch (digitalSensors): it is an instance of the digitalSensor class configured for the Zerynth Shield touch sensor

For example, sampling the temperature in Celsius can be done with:

```py
zerynthshield.temperature.setNormFunc(zerynthshield.toCelsius)
zerynthshield.temperature.startSampling(1000,None,"norm")
```

The smartsensors lib allows the definition of a function to be called periodically. See the smartsensors lib documentation for more details.

An Arduino-like style is also supported:

```py
while True:
    zerynthshield.temperature.getCelsius()
    sleep(1000)
```

## TouchSensor class


**`class TouchSensor`**

This class provides simple methods for the detection of single and double touch on the Zerynth Shield integrated capacitive touch sensor.

An instance of the class is available by calling the zerynthshield.touch attribute.


**`onSingleTouch(min_time, max_time, to_do, long_fn = None)`**

Sets a to_do function to be executed when a touch occurs and lasts more than min_time and less than max_time (expressed in milliseconds), if max_time limit is exceeded long_fn is called.

**Arguments:**

    
* min_time (int): minimum touch time
* max_time (int): maximum touch time after that the touch is not considered anymore as a single touch but as a long touch
* to_do (function): function to be executed when a single-touch occurs
* long_fn (function, optional): function to be executed when a long touch occurs


**`onDoubleTouch(min_time, max_time, to_do, long_fn = None)`**

Sets a first_action function to be executed when a touch occurs and lasts more than min_time and less than max_time (expressed in milliseconds), if max_time limit is
exceeded long_fn is executed.

When first_action constrains are respected, if a second touch occurs at most after max_interval milliseconds and the length of the touch is between min_time and max_time, then second_action function is called.

**Arguments:**

    
* min_time (int): minimum touch time
* max_time (int): maximum touch time after that the touch is not considered anymore as a single touch but as a long touch
* max_interval (int): the maximum time span between touches to consider a double touch event instead of two separated single touches.
* first_action (function): function to be executed when a single-touch occurs
* second_action (function, optional): function to be executed when a double touch occurs
* long_fn (function, optional): function to be executed when a long touch occurs

## LightSensor class


**`class LightSensor`**

This class provides a default getFloat() normalization method for the photoresistor integrated in the Zerynth Shield.

An instance of the class is available by calling the zerynthshield.light attribute.


**`getFloat()`**

Returns samples normalized between 0 and 1.

## TemperatureSensor class


**`class TemperatureSensor`**

This class provides two default normalization method for the temperature sensor: getFloat() and getCelsius().

An instance of the class is available by calling the zerynthshield.temperature attribute.


**`getCelsius()`**

Returns samples directly converted in celsius degrees.


**`getFloat()`**

Returns samples normalized between 0 and 1.

## MicrophoneSensor class


**`class MicrophoneSensor`**

This class provides a default getFloat() normalization method for the microphone.

An instance of the class is available by calling zerynthshield.microphone attribute.

zerynthshield.microphone.skipEval (see Sensor class) is set to true because of the high sampling frequencies that may be needed by the sensor.


**`getFloat()`**

Returns samples normalized between 0 and 1.

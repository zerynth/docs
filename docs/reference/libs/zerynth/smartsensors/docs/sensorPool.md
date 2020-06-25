<!-- module: poolSensor -->
# Pool Sensor Library

This module contains class definitions for pool of sensors. SensorPool class takes for its initialization the list of sensors (from Generic Sensor class or Analog/Digital subclasses) Every SensorPool instance redefines the `startSampling()` and `stopSampling()` functions seen in Generic Sensor class for list of sensors instead of single sensor.

## SensorPool class



**`class SensorPool(sensors)`**

This is the class for handling pool of sensors passed as a list.

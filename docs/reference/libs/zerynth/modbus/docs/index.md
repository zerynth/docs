# Zerynth Modbus

<!-- The text you write here will appear in the first doc page. (This is just a comment, will not be rendered) -->
Modbus is a serial communication protocol published by Modicon in 1979 for use with its PLCs.

There are two different devices involved:


* **Master**: the device requesting the informations;
* **Slave**: the device supplying the informations.

In a standard network there is one Master and up to 247 slaves, each with a unique Slave Address (identifier) from 1 to 247.

The protocol has become a standard in industry and today it’s the most commonly available means of connecting industrial electronic devices.

This library allows to communicate with slave modbus devices both via TCP and via serial line. The modbus specification can be (freely) found at [http://modbus.org/](http://modbus.org/).

To work via RTU, a device class that implements read, write and close methods is needed. Both examples of RTU and TCP communication are provided, as well as an implementation of a device class for the rs485.

Contents:


* [MODBUS Library](/latest/reference/libs/zerynth/modbus/docs/modbus/)
    * [ModbusTCP class](/latest/reference/libs/zerynth/modbus/docs/modbus/#modbustcp-class)
    * [ModbusSerial class](/latest/reference/libs/zerynth/modbus/docs/modbus/#modbusserial-class)
* [Examples](/latest/reference/libs/zerynth/modbus/docs/examples/)
    * [ModbusTcp](https://docs.zerynth.com/latest/official/lib.zerynth.modbus/examples/examples.html#modbustcp)
    * [ModbusSerial](https://docs.zerynth.com/latest/official/lib.zerynth.modbus/examples/examples.html#modbusserial)

# Zerynth Lightweight MQTT

MQTT is a machine-to-machine (M2M) connectivity protocol usable for “Internet of Things” solutions.

It is designed as an extremely lightweight publish/subscribe messaging transport and is useful for connections with remote locations where a small code footprint is required and/or network bandwidth is at a premium.

It is ideal for mobile applications because of its small size, low power usage, minimised data packets, and efficient distribution of information to one or many receivers; more information at [MQTT dedicated page](http://mqtt.org/)

This publish/subscribe messaging pattern requires a message broker. The broker is responsible for distributing messages to interested clients based on the topic of a message.

So a client must connect to a broker in order to:


* ```publish``` messages specifying a topic so that other clients that have subscribed to that topic will be able to receive those messages;


* receive messages ```subscribing``` to a specific topic.

To clarify this behaviour imagine a home network of temperature sensors and controllers where each temperature sensor publishes sampled data on ‘home/nameOfRoom’ channel and the home temperature controller subscribes to all channels to achieve a smart heating.

Here below, the Zerynth Lightweight Library for MQTT connectivity protocol and some examples to better understand how to use it.

Contents:


* Lightweight MQTT Library


    * Client class

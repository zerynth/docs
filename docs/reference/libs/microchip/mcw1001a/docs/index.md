# Microchip MCW1001A

MCW1001A is a companion chip to the MRF24WB0 802.11 module. It provides simple socket based method of sending and receiving data from the MRF24WB0 802.11 module.

The MCW1001A has an on-board TCP/IP stack and 802.11 connection manager to simplify the connection between a wireless network and the TCP/IP stack management.

After the initial configuration is set, the MCW1001A can access the MRF24WB0 802.11 module to connect to a network and send/receive serial data over a simple UART interface from the Host controller; more information at [Microchip dedicated page](http://www.microchip.com/wwwproducts/en/MCW1001A)

## Technical Details


* Supply Voltage (Vdd): from 3.0 V to 5.5 V


* Operation Temperature (Top): from -40 °C to 125 °C


* Supply Current (Idd): from 1.3 mA to 1.5 mA (Fosc 32 MHz)


* UART Interface: up to 230 Kbaud

Here below, the Zerynth driver for the Microchip MCW1001A.

Contents:


* MCW1001A Module

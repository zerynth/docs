# STM SPWF01SA

The SPWF01SA is an intelligent Wi-Fi module representing a plug-and-play and standalone 802.11 b/g/n solution for easy integration of wireless Internet connectivity features into existing or new products.

Configured around a single-chip 802.11 transceiver with integrated PA and comprehensive power management subsystem, and an STM32 microcontroller with an extensive GPIO suite, the module also incorporates timing clocks and voltage regulators.

The SW package also includes an AT command layer interface for user-friendly access to the stack functionalities via the UART serial port.

After the initial configuration is set, the SPWF01SA can be connected to a network and send/receive serial data over the UART interface from the Host controller; more information at [STM dedicated page](http://www.st.com/en/wireless-connectivity/spwf01sa.html).

## Technical Details


* Supply Voltage (Vdd): from 3.1 V to 3.6 V
* Operation Temperature (Top): from -40 °C to 85 °C
* Advanced low-power modes: 243 mA typical @ 10 dBm (TX traffic)
* 2.4 GHz IEEE 802.11 b/g/n transceiver
* Simple AT command set host interface through UART

Here below, the Zerynth driver for the STM SPWF01SA.

Contents:


* [SPWF01SA Module](https://docs.zerynth.com/latest/official/lib.stm.spwf01sa/docs/official_lib.stm.spwf01sa_spwf01sa.html)
* [Examples](https://docs.zerynth.com/latest/official/lib.stm.spwf01sa/examples/examples.html)
     * [find and set baud](https://docs.zerynth.com/latest/official/lib.stm.spwf01sa/examples/examples.html#find-and-set-baud)
     * [connect](https://docs.zerynth.com/latest/official/lib.stm.spwf01sa/examples/examples.html#connect)

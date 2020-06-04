# Worldsemi WS2812 RGB LEDs

The Worldsemi WS2812 Integrated Light Source — or NeoPixel in Adafruit parlance — is the latest advance in the quest for a simple, scalable and affordable full-color LED. RGB LEDs are integrated alongside a driver chip into a tiny surface-mount package piloted through a single-wire control protocol.

They can be used individually, chained into longer strings or assembled into still more interesting form-factors; some product example can be found at [Adafruit dedicated page](https://www.adafruit.com/categories/168).

## Technical Details (for single WS2812 RGB LED)


* Power Supply Voltage (Vdd): from 4.5 V to 5.5 V


* Input Voltage (Vi): from -0.5V to Vdd+0.5 V


* Operation Temperature: from -25 °C to 80 °C


* Data Transmission Rate: 400 Kbps (duty ratio 50%)

**LED Characteristic Parameter**

| Emitting Color

 | Wavelenght (nm)

 | Current (mA)

 | Voltage (V)

 |
| -------------- | --------------- | ------------ | ----------- |
| Red

            | 620-630

         | 20

           | 1.8-2.2

     |
| Green

          | 515-530

         | 20

           | 3.0-3.2

     |
| Blue

           | 465-475

         | 20

           | 3.2-3.4

     |
Here below, the Zerynth driver for the Worldsemi WS2812 led strips and some examples to better understand how to use them.

Contents:


* WS2812 RGB Led Module


    * LedStrip class

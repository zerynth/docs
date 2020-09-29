
# BT81x

Bridgetek BT81x series of Embedded Video Engines (EVE) utilizes an object oriented methodology for creating hi-quality human machine interfaces (HMIs). With support for display, audio, and touch, this new technology allows engineers to quickly and efficiently design HMIs and deliver robust solutions, hi-resolution displays with lower bill of material costs.

Product page:


* [BT81x](https://brtchip.com/bt81x)

## Technical Details


* BT81x functionality includes graphic control, audio control, and touch control interface
* Support multiple widgets for simplified design implementation
* Support Adaptive Scalable Texture Compression (ASTC) format to save considerable memory space for larger fonts and graphics images
* Support external QSPI NOR flash to fetch graphic elements (image, font, widget etc)
* Support 4-wire resistive touch screen (BT816)
* Support capacitive touch screen with up to 5 touches detection (BT815)
* Hardware engine can recognize touch tags and track touch movement. Provides notification for up to 255 touch tags.
* Programmable interrupt controller provides interrupts to host MCU
* Built-in 12MHz crystal oscillator with PLL providing programmable system clock up to 72MHz
* Video RGB parallel output; configurable to support PCLK up to 60MHz and R/G/B output of 1 to 8 bits
* Programmable timing to adjust HSYNC and VSYNC timing, enabling interface to numerous displays
* Support for LCD display with resolution up to SVGA (800×600) and formats with data enable (DE) mode or VSYNC/HSYNC mode
* Support landscape and portrait orientations
* Display enable control output to LCD panel
* Integrated 1MByte graphics RAM, no frame buffer RAM required
* Support playback of motion-JPEG encoded AVI videos
* Built-in sound synthesizer
* Audio wave playback for mono 8-bit linear PCM, 4-bit ADPCM and µ-Law coding format at sampling frequencies from 8 kHz to 48 kHz. Built-in digital filter reduces the system design complexity of external filtering
* PWM output for display backlight dimming control
* Supports I/O voltage from 1.8V to 3.3V
* Built-in Power-on-reset circuit
* -40°C to 85°C extended operating temperature range
* Available in a compact Pb-free, VQFN-package, RoHS compliant
Below, Zerynth driver documentation for Bridgetek BT81x Embedded Video Engines.

Contents:

 * [BT81x library](/latest/reference/libs/bridgetek/bt81x/docs/bt81x/)
    * [Co-Processor Commands](/latest/reference/libs/bridgetek/bt81x/docs/bt81x/#co-processor-commands)
 * [Examples](/latest/reference/libs/bridgetek/bt81x/docs/examples/)
	 * [DisplayZerynthLogo](/latest/reference/libs/bridgetek/bt81x/docs/examples/#display-zerynth-logo)
	 * [DisplayNetworks](/latest/reference/libs/bridgetek/bt81x/docs/examples/#display-networks)
	 * [DisplayWidgets](/latest/reference/libs/bridgetek/bt81x/docs/examples/#display-networks)

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyNTMyNjc1NzhdfQ==
-->
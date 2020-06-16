# Polaris Board

This module provides easy access to the Polaris board features and meaningful names for MCU pins and peripherals.

**`class main`**

Namespace for the **Main** connector signals and related peripherals:


* `PIN_VIN` - analog input for main supply voltage
* `PIN_IGNITION` - digital input for ignition detection (active high)
* `PIN_SOS` - digital input for emergency button (active low)
* `PIN_AIN1`, `PIN_RANGE_IN1` - analog input 1 and range selection pin
* `PIN_AIN2`, `PIN_RANGE_IN2` - analog input 2 and range selection pin
* `PIN_AIN3`, `PIN_RANGE_IN3` - analog input 3 and range selection pin
* `PIN_AIN4`, `PIN_RANGE_IN4` - analog input 4 and range selection pin
* `PIN_IOEXP_IN1` - control input 1 for I/O Expander
* `PIN_IOEXP_IN2` - control input 2 for I/O Expander
* `ADC_VIN` - ADC channel (using `PIN_VIN`)
* `ADC_IN1` - ADC channel (using `PIN_AIN1`)
* `ADC_IN2` - ADC channel (using `PIN_AIN2`)
* `ADC_IN3` - ADC channel (using `PIN_AIN3`)
* `ADC_IN4` - ADC channel (using `PIN_AIN4`)
* `PWM_IOEXP_IN1` - PWM control input 1 for I/O Expander
* `PWM_IOEXP_IN2` - PWM control input 2 for I/O Expander
 
**`class mikrobus`**

Namespace for the **mikroBUS** expansion interface signals and related peripherals:


* `PIN_MISO`, `PIN_MOSI`, `PIN_SCK`, `PIN_CS` - expansion SPI interface
* `PIN_SDA`, `PIN_SCL` - expansion I2C interface
* `PIN_TX`, `PIN_RX` - expansion UART pins
* `PIN_RST`, `PIN_INT` - general purpose I/O pins (usually reset and interrupt)
* `PIN_PWM` - PWM capable pin
* `PIN_AN` - analog input pin
* `SERIAL` - serial driver (using `PIN_RX`,\`\`PIN_TX\`\`)
* `SPI` - SPI driver (using `PIN_MISO`, `PIN_MOSI`, `PIN_SCK`)
* `I2C` - I2C driver (using `PIN_SDA`, `PIN_SCL`)
* `PWM` - PWM channel (using `PIN_PWM`)
* `ADC` - ADC channel (using `PIN_AN`)


**`class extbus`**

Namespace for the **Ext-A** expansion interface signals and related peripherals:

* `PIN_GPIO1`, `PIN_GPIO2` - general purpose I/O pins
* `PIN_TX`, `PIN_RX` - expansion UART pins
* `PIN_PWM` - PWM capable pin
* `PIN_AN1` - analog input pin
* `PIN_DAC1`, `PIN_DAC1` - analog pins
* `SERIAL` - serial driver (using `PIN_RX`,\`\`PIN_TX\`\`)
* `PWM` - PWM channel (using `PIN_PWM`)
* `ADC` - ADC channel (using `PIN_AN1`)


**class internal**

Namespace for on-board devices signals and peripherals:


* `PIN_LED_RED`, `PIN_LED_GREEN` - LED control pins (active low)
* `PIN_POWER_DIS` - main power control pin (shutdown)
* `PIN_5V_EN` - control pin for 5V regulator
* `PIN_BATT_EN` - backup battery status pin
* `PIN_IOEXP_CS` - I/O Expander chip-select pin
* `PIN_CAN_STANDBY` - control pin for CAN transceiver stand-by mode (low for normal operation)
* `PIN_ACCEL_CS`, `PIN_ACCEL_INT` - accelerometer chip-select and interrupt pins
* `PIN_CHARGE_PROG`, `PIN_CHARGE_STAT` - backup battery charger control and status pins
* `PIN_BATT_ADC` - analog input for backup battery voltage
* `SPI` - on-board SPI driver (for accelerometer and I/O Expander)
* `ADC_BATT` - ADC channel (using `PIN_BATT_ADC`)


**`class gnss`**

Namespace for GNSS module signals and related peripherals:


* `PIN_STANDBY`, `PIN_RESET` - module control pins
* `PIN_TX`, `PIN_RX` - module UART pins
* `PIN_ANTON` - control pin (used only in the NB-IoT variant with BG96)
* `SERIAL` - serial driver (using `PIN_RX`,\`\`PIN_TX\`\`)


**`class gsm`**

Namespace for Modem signals and related peripherals:


* `PIN_TX`, `PIN_RX` - modem UART pins
* `PIN_POWER`, `PIN_KILL`, `PIN_WAKE` - modem control pins
* `PIN_STATUS`, `PIN_RING` - modem status pins
* `SERIAL` - serial driver (using `PIN_RX`,\`\`PIN_TX\`\`)

**`init()`**

Performs required initialization of Polaris pins and common functionalities.
It should be called at the start of your application.

**`sBatteryBackup()`**

Returns a boolean value to indicate whether the board is powered from the backup battery source.

**`setBatteryCharger(enable)`**



Enables or disables the backup battery charger (5V required).


Note: Do not enable the charger when the main power supply is not present.



**`getChargerStatus()`**

Returns the battery charger status (not charging, charging or fully charged).


**Returns:** One of these values: `CHARGE_NONE` = 0, `CHARGE_BUSY` = 1, `CHARGE_COMPLETE` = 2.

**`getIgnitionStatus()`**

Reads the ignition status from digital input pin IGN/DIO5 (active high).

**Returns:** An integer value to indicate whether the ignition switch is on/off: `IGNITION_ON` = 1 or `IGNITION_OFF` = 0.



**`getEmergencyStatus()`**

Reads the emergency button status from digital input pin SOS/DIO6 (active low).


**Returns:** An integer value to indicate whether the emergency button is switched on/off: `SOS_ON` = 1 or `SOS_OFF` = 0.



**`shutdown()`**

Disables the main regulator or backup battery source, effectively power-cycling the board.


**`readMainVoltage()`**

Returns the analog measure of the main supply voltage.


**`readMainVoltage()`**

Returns the analog measure of the backup battery voltage.


**`readAnalogInputVoltage(pin_num,range=HIGH)`**

Returns the voltage measure of an analog input pin on the **Main** connector.


**Arguments:**

*	**pin_num** – Index of the analog pin (0-3 = corresponds to AIO1-4)
*	**range** – Full-scale range: *HIGH* (0-36V) or *LOW* (0-5V)



**`ledRedOff()`**

Switch the red LED off.


**`ledRedOn()`**

Switch the red LED on.

**`ledGreenOff()`**

Switch the green LED off.

**`ledGreenOn()`**

Switch the green LED on.
<!--stackedit_data:
eyJkaXNjdXNzaW9ucyI6eyJ5N0o2NmJyOGdRM00zSDJwIjp7In
N0YXJ0Ijo0ODk3LCJlbmQiOjQ5MjAsInRleHQiOiIqKmByZWFk
TWFpblZvbHRhZ2UoKWAqKiJ9fSwiY29tbWVudHMiOnsiTXNOTV
pTMWV2S056aEx1UCI6eyJkaXNjdXNzaW9uSWQiOiJ5N0o2NmJy
OGdRM00zSDJwIiwic3ViIjoiZ2g6NjYzNTQ4NTQiLCJ0ZXh0Ij
oiRnVuY3Rpb24gbmFtZSBpcyB0aGUgc2FtZSBhcyBwcmV2aW91
cyBhbmQgc2hvdWxkIGJlIGNoZWNrZWQuIFxuKiByZWFkQmFja3
VwVm9sdGFnZSgpIiwiY3JlYXRlZCI6MTU5MjMxODk5NDQ2M319
LCJoaXN0b3J5IjpbMTM4OTM5MDczMiw3Njk5ODQ4NTZdfQ==
-->
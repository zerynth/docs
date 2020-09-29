# Maxim DS1307

The DS1307 real-time clock (RTC) is a low-power, full binary-coded decimal (BCD) clock/calendar controllable via I2C protocol.

The clock/calendar provides seconds, minutes, hours, day, date, month, and year information. The end of the month date is automatically adjusted for months with fewer than 31 days, including corrections for leap year. The clock operates in either the 24-hour or 12-hour format with AM/PM indicator.

The DS1307 has a built-in power-sense circuit that detects power failures and automatically switches to the backup supply. Timekeeping operation continues while the part operates from the backup supply; more information at [Maxim dedicated page](https://www.maximintegrated.com/en/products/digital/real-time-clocks/DS1307.html)

## Technical Details


* Supply Voltage (Vcc): from 4.5 V to 5.5 V
* Operation Temperature (Top): from 0 °C to 70 °C
* SCL Clock Frequency (Fscl): from 0 Hz to 100 kHz
* Active Supply Current (Icca): 1.5 mA (Fosc = 100 kHz)

Here below, the Zerynth driver for the Maxim DS1307.

Contents:

-   [DS1307 Module](/latest/reference/libs/maxim/ds1307/docs/ds1307/)
    -   [DS1307 class](/latest/reference/libs/maxim/ds1307/docs/ds1307/#ds1307-class)
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEyODMzODI1NTddfQ==
-->
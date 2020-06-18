# HEXIWEAR Module

This module contains the driver for enabling and handling all Hexiwear onboard sensors and features.
The HEXIWEAR class permits an easier access to the internal peripherals and exposes all functionalities in simple function calls ([wiki](https://docs.mikroe.com/Hexiwear)).


**`HEXIWEAR(battery_en=True,oled_en=True,amb_light_en=True,heart_rate_en=True,temp_humid_en=True,gyro_en=True,acc_magn_en=True,pressure_en=True,bt_driver_en=True)`**

Creates an instance of a new HEXIWEAR.


**Arguments:**

    
-	**battery_en(bool)** – Flag for enabling the battery level reading feature; default True
-	**oled_en(bool)** – Flag for enabling the onboard color oled display; default True
-	**amb_light_en(bool)** – Flag for enabling the ambient light sensor; default True
-	**heart_rate_en(bool)** – Flag for enabling the heart rate sensor; default True
-	**temp_humid_en(bool)** – Flag for enabling the temperature and humidity sensor; default True
-	**gyro_en(bool)** – Flag for enabling the onboard gyroscope; default True
-	**acc_magn_en(bool)** – Flag for enabling the onboard accelerometer and magnetometer; default True
-	**pressure_en(bool)** – Flag for enabling the pressure sensor; default True
-	**bt_driver_en(bool)** – Flag for enabling driver for bluetooth features; default True


Example:

```py
from nxp.hexiwear import hexiwear

...


hexi = hexiwear.HEXIWEAR()
t = hexi.get_temperature()
h = hexi.get_humidity()
...
gyro = hexi.get_gyroscope_data()
```


**`get_battery_level(chg_state)`**

If battery level reading feature is enabled; retrieves the current battery level in percentage and the charging battery status if *chg=True* is provided.


* ```Arguments```

    
    * **chg_state(bool)** – flag for enabling the battery charging status reading; default False


Returns battery_level or battery_level, charging_status or None


get_pressure()

If pressure sensor is enabled; retrieves the current pressure data from the onboard sensor as calibrate value in Pa.

Returns pressure or None


---
#### `#!py3 get_temperature()`

!!!abstract "`#!py3 get_temperature()`"

If temperature and humidity sensor is enabled; retrieves the current temperature data from the onboard sensor as calibrate value in °C.

Returns temperature or None


---
#### `#!py3 get_humidity()`

!!!abstract "`#!py3 get_humidity()`"

If temperature and humidity sensor is enabled; retrieves the current humidity data from the onboard sensor as calibrate value in %RH.

Returns humidity or None


---
#### `#!py3 get_accelerometer_data()`

!!!abstract "`#!py3 get_accelerometer_data()`"

If accelerometer and magnetometer are enabled; retrieves the current accelerometer data from the onboard sensor in m/s^2 as a tuple of X, Y, Z values.

Returns [acc_x, acc_y, acc_z] or None


---
#### `#!py3 get_magnetometer_data()`

!!!abstract "`#!py3 get_magnetometer_data()`"

If accelerometer and magnetometer are enabled; retrieves the current magnetometer data from the onboard sensor in uT as a tuple of X, Y, Z values.

Returns [magn_x, magn_y, magn_z] or None


---
#### `#!py3 get_gyroscope_data()`

!!!abstract "`#!py3 get_gyroscope_data()`"

If gyroscope is enabled; retrieves the current gyroscope data from the onboard sensor in degrees per second as a tuple of X, Y, Z values.

Returns [gyro_x, gyro_y, gyro_z] or None


---
#### `#!py3 get_ambient_light()`

!!!abstract "`#!py3 get_ambient_light()`"

If ambient light sensor is enabled; Converts the raw sensor values to the standard SI lux equivalent.

Returns lux or None


---
#### `#!py3 get_heart_rate()`

!!!abstract "`#!py3 get_heart_rate()`"

If heart rate sensor is enabled; retrieves the current heart rate from the onboard sensor as value in bpm (beat per minute).

Returns heart_rate or None


---
#### `#!py3 get_altitude()`

!!!abstract "`#!py3 get_altitude()`"

If pressure sensor is enabled; calculates, from measured pressure, the current altitude data as value in meters.

Returns altitude or None


---
#### `#!py3 attach_button_up()`

!!!abstract "`#!py3 attach_button_up(callback)`"

If bluetooth driver is enabled; sets the callback function to be executed when Capacitive Button Up on Hexiwear device is pressed.


---
#### `#!py3 attach_button_down()`

!!!abstract "`#!py3 attach_button_down(callback)`"

If bluetooth driver is enabled; sets the callback function to be executed when Capacitive Button Down on Hexiwear device is pressed.


---
#### `#!py3 attach_button_left()`

!!!abstract "`#!py3 attach_button_left(callback)`"

If bluetooth driver is enabled; sets the callback function to be executed when Capacitive Button Left on Hexiwear device is pressed.


---
#### `#!py3 attach_button_right()`

!!!abstract "`#!py3 attach_button_right(callback)`"

If bluetooth driver is enabled; sets the callback function to be executed when Capacitive Button Right on Hexiwear device is pressed.


---
#### `#!py3 attach_passkey()`

!!!abstract "`#!py3 attach_passkey(callback)`"

If bluetooth driver is enabled; sets the callback function to be executed when KW40Z receives a bluetooth pairing request.

```NOTE```: When the KW40Z receives this kind of request it generates a pairing code stored in the passkey KW40Z class attribute of bt_driver internal instance.


---
#### `#!py3 bluetooth_on()`

!!!abstract "`#!py3 bluetooth_on()`"

If bluetooth driver is enabled; turns on the bluetooth features.


---
#### `#!py3 bluetooth_off()`

!!!abstract "`#!py3 bluetooth_off()`"

If bluetooth driver is enabled; turns off the bluetooth features.


---
#### `#!py3 right_capacitive_buttons_active()`

!!!abstract "`#!py3 right_capacitive_buttons_active()`"

If bluetooth driver is enabled; turns active the right pair of capacitive buttons.


---
#### `#!py3 right_capacitive_buttons_active()`

!!!abstract "`#!py3 right_capacitive_buttons_active()`"

If bluetooth driver is enabled; turns active the left pair of capacitive buttons.


---
#### `#!py3 bluetooth_info()`

!!!abstract "`#!py3 bluetooth_info()`"

If bluetooth driver is enabled; retrieves the bluetooth chip informations regarding the status, which capacitive touch buttons are active, and the “connection with other devices” status.


* Bluetooth Status (```bool```): 1 Bluetooth is on, 0 Bluetooth is off;


* Capacitive Touch Buttons (```bool```): 1 active right pair, 0 acive left pair;


* Link Status (```bool```): 1 device is connected, 0 device is disconnected.

Returns bt_on, bt_touch, bt_link


---
#### `#!py3 enable_bt_upd_sensors()`

!!!abstract "`#!py3 enable_bt_upd_sensors()`"

If bluetooth driver is enabled; enables the automatic update of all sensor values in the KW40Z bluetooth chip to be readable through any smartphone/tablet/pc bluetooth terminal (once every 5 seconds).


---
#### `#!py3 disable_bt_upd_sensors()`

!!!abstract "`#!py3 disable_bt_upd_sensors()`"

If bluetooth driver is enabled; disables the automatic update of all sensor values in the KW40Z bluetooth chip.


---
#### `#!py3 display_on()`

!!!abstract "`#!py3 display_on()`"

If color oled display is enabled; turns on the onboard display.


---
#### `#!py3 display_off()`

!!!abstract "`#!py3 display_off()`"

If color oled display is enabled; turns off the onboard display.


---
#### `#!py3 clear_display()`

!!!abstract "`#!py3 clear_display()`"

If color oled display is enabled; clears the onboard display.


---
#### `#!py3 fill_screen()`

!!!abstract "`#!py3 fill_screen(color, encode=True)`"

If color oled display is enabled; fills the entire display with color code provided as argument.


* ```Arguments```

    
    * ```color``` – hex color code for the screen


    * **encode(bool)** – flag for enabling the color encoding; default True


```NOTE```: The onboard color oled is a 65K color display, so if a stadard hex color code (24 bit) is provided
it is necessary to encode it into a 16 bit format.

If a 16 bit color code is provided, the encode flag must be set to False.


---
#### `#!py3 fill_rect()`

!!!abstract "`#!py3 fill_rect(x, y, w, h, color, encode=True)`"

If color oled display is enabled; draws a rectangular area in the screen colored with the color code provided as argument.


* ```Arguments```

    
    * ```x``` – x-coordinate for left high corner of the rectangular area


    * ```y``` – y-coordinate for left high corner of the rectangular area


    * ```w``` – width of the rectangular area


    * ```h``` – height of the rectangular area


    * ```color``` – hex color code for the rectangular area


    * **encode(bool)** – flag for enabling the color encoding; default True


```NOTE```: The onboard color oled is a 65K color display, so if a stadard hex color code (24 bit) is provided
it is necessary to encode it into a 16 bit format.

If a 16 bit color code is provided, the encode flag must be set to False.


---
#### `#!py3 draw_image()`

!!!abstract "`#!py3 draw_image(image, x, y, w, h)`"

If color oled display is enabled; draws a rectangular area in the screen colored with the color code provided as argument.


* ```Arguments```

    
    * ```image``` – image to draw in the oled display converted to hex array format and passed as bytearray


    * ```x``` – x-coordinate for left high corner of the image


    * ```y``` – y-coordinate for left high corner of the image


    * ```w``` – width of the image


    * ```h``` – height of the image


```NOTE```: To obtain a converted image in hex array format, you can go and use this [online tool](http://www.digole.com/tools/PicturetoC_Hex_converter.php).

After uploading your image, you can resize it setting the width and height fields; you can also choose the code format (HEX:0x recommended) and the color format
(65K color for this display).

Clicking on the “Get C string” button, the tool converts your image with your settings to a hex string that you can copy and paste inside a bytearray in your project and privide to this function.


---
#### `#!py3 draw_pixel()`

!!!abstract "`#!py3 draw_pixel(x, y, color, encode=True)`"

If color oled display is enabled; draws a single pixel in the screen colored with the color code provided as argument.


* ```Arguments```

    
    * ```x``` – pixel x-coordinate


    * ```y``` – pixel y-coordinate


    * ```color``` – hex color code for the pixel


    * **encode(bool)** – flag for enabling the color encoding; default True


```NOTE```: The onboard color oled is a 65K color display, so if a stadard hex color code (24 bit) is provided
it is necessary to encode it into a 16 bit format.

If a 16 bit color code is provided, the encode flag must be set to False.


---
#### `#!py3 draw_text()`

!!!abstract "`#!py3 draw_text(text, x=None, y=None, w=None, h=None, color=None, align=None, background=None, encode=True)`"

If color oled display is enabled; prints a string inside a text box in the screen.


* ```Arguments```

    
    * ```text``` – string to be written in the display


    * ```x``` – x-coordinate for left high corner of the text box; default None


    * ```y``` – y-coordinate for left high corner of the text box; default None


    * ```w``` – width of the text box; default None


    * ```h``` – height of the text box; default None


    * ```color``` – hex color code for the font; default None


    * ```align``` – alignment of the text inside the text box (1 for left alignment, 2 for right alignment, 3 for center alignment); default None


    * ```background``` – hex color code for the background; default None


    * **encode(bool)** – flag for enabling the color encoding of the font and background color; default True


```NOTE```: The onboard color oled is a 65K color display, so if a stadard hex color code (24 bit) is provided
it is necessary to encode it into a 16 bit format.

If a 16 bit color code is provided, the encode flag must be set to False.

```NOTE```: If only text argument is provided, an automatic text box is created with the following values:


* x = 0


* y = 0


* w = min text width according to the font


* h = max char height according to the font


* color = 0xFFFF


* align = 3 (centered horizontally)


* background = 0x4471


---
#### `#!py3 vibration()`

!!!abstract "`#!py3 vibration(ms)`"

Turns on the vibration motor for ```ms``` milliseconds.


* ```Arguments```

    
    * ```ms``` – motor vibration duration



---
#### `#!py3 leds_on()`

!!!abstract "`#!py3 leds_on()`"

Turns on the rgb onboard led (white light).


---
#### `#!py3 leds_off()`

!!!abstract "`#!py3 leds_off()`"

Turns off the rgb onboard led.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTU2ODU4XX0=
-->
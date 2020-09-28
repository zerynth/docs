# ST7735 Module

This module exposes all functionalities of Sitronix ST7735 Display driver ([datasheet](https://datasheetspdf.com/pdf-file/694957/SitronixTechnology/ST7735/1)).

## ST7735 class

```py
classST7735(drv, cs, dc, bl=None, rst=None, clock=27000000)
```

Creates an intance of a new ST7735.

**Parameters:**		

**drv**: SPI Bus used ‘( SPI0, ... )’

**cs**: Chip Select

**dc**: Data Control Pin

**bl**: Backlight Pin

**rst**: Reset Pin

**clock**: Clock speed, default 100kHz

Example:

```py
from sitronix.st7735 import st7735

...

display = st7735.ST7735(SPI0, D5, D23, bl=D27, rst=D26)
display.clear()
display.fill_screen([255,0,0])
display.fill_rect(10, 20, 20, 100, [255,255,0])
display.draw_pixel(50, 50, [255,255,255])
display.draw_line(30, 20, 100, [0,0,255])
display.draw_text("Hello Zerynth")
```

```py
on()
```

Turns on the display.

```py
off()
```

Turns off the display.

```py
reset()
```

Reset the display.

```py
set_rotation(rotation = 1)
```

**Parameters:**

**rotation**: is the rotation value to set (default = 1). Values accepted: 0, 1, 2 or 3.

Set the direction of frame memory.

```py
set_backlight(state)
```

**Parameters:**

**state**: is the state of backlight. Values accepted: 0 or 1.

Set the backlight.

```py
invert(value)
```

**Parameters:**
	
**value**: is the value of display inversion mode. Values accepted: 0 or 1.

Set the display inversion mode.

```py
clear()
```

Clears the display.

```py
fill_screen(color)
```

**Parameters:**

**color**: is a list composed by RGB color.

Fills the entire display with RGB color provided as argument.

```py
fill_rect(x, y, w, h, color)
```

**Parameters:**

**x**: x-coordinate for left high corner of the rectangular area.

**y**: y-coordinate for left high corner of the rectangular area.

**w**: width of the rectangular area.

**h**: height of the rectangular area.

**color**: is a list composed by RGB color for the rectangular area.

Draws a rectangular area in the screen colored with the RGB color provided as argument.

```py
draw_pixel(x, y, color)
```

**Parameters:**	

**x**: pixel x-coordinate.

**y**: pixel y-coordinate.

**color**: is a list composed by RGB color.

Draws a single pixel in the screen colored with the RGB color provided as argument.

```py
draw_line(x, y, lenght, color)
```

**Parameters:**

**x**: pixel x-coordinate.

**y**: pixel y-coordinate.

**lenght**: is the lenght of line.

**color**: is a list composed by RGB color.

Draws a line in the screen colored with the RGB color provided as argument.

```py
draw_img(image, x=0, y=0, w=80, h=80)
```

**Parameters:**	

**image**: image to draw in the display converted to hex array format and passed as bytearray.

**x**: x-coordinate for left high corner of the image (default value is 0).

**y**: y-coordinate for left high corner of the image (default value is 0).

**w**: width of the image (default value is 80).

**h**: height of the image (default value is 80).

Draws the image passed in bytearray format as argument.

!!! note
    To obtain a converted image in hex array format, you can go and use this [online tool](http://www.digole.com/tools/PicturetoC_Hex_converter.php).
    After uploading your image, you can resize it setting the width and height fields; you can also choose the code format (HEX:0x recommended) and the color format (65K color recommended).
    Clicking on the “Get C string” button, the tool converts your image with your settings to a hex string that you can copy and paste inside a bytearray in your project and privide to this function.

```py
draw_text(text, x=0, y=0, w=None, h=None, font_text=None, font_color=None, align=3, background=None)
```

**Parameters:**

**text**: string to be written in the display.

**x**: x-coordinate for left high corner of the text box (default value is 0).

**y**: y-coordinate for left high corner of the text box (default value is 0).

**w**: width of the text box (default value is None).

**h**: height of the text box (default value is None).

**font_text**: is text font (default value is None). You can pass a font like showing in “write on display” example.

**font_color**: is a list of RGB color for the font color (default value is None).

**align**: alignment of the text inside the text box (default value is 3).

| align | Alignment |
|-------|-----------|
| 0     | None      |
| 1     | Left      |
| 2     | Right     |
| 3     | Center    |

**background**: is a list composed by RGB color (default value is None).

Prints a string inside a text box in the screen.


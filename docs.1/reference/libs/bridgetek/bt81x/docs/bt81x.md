# BT81x library

This module exports classes and functions to handle Bridgetek BT81x family of Embedded Video Engines.

##### class DisplayConf

```#!py3 class DisplayConf(width,height,hcycle,hoffset,hsync0,hsync1,vcycle, voffset,vsync0,vsync1,pclk,swizzle,pclkpol,cspread,dither,description)```

Class to store a display configuration.
List of attributes:


* `DisplayConf.width` display width in pixels
* `DisplayConf.height` display height in pixels
* `DisplayConf.hcycle` number of total PCLK cycles per horizontal line scan
*  `DisplayConf.hoffset` number of PCLK cycle before pixels are scanned out
* `DisplayConf.hsync0` how many PCLK cycles for HSYNC0 during start of line
* `DisplayConf.hsync1` how many PCLK cycles for HSYNC1 during start of line
* `DisplayConf.vcycle` how many lines in one frame
* `DisplayConf.voffset` how many lines taken after the start of a new frame
* `DisplayConf.vsync0` how many lines of signal VSYNC0 takes at start of a new frame
* `DisplayConf.vsync1`  how many lines of signal VSYNC1 takes at start of a new frame
* `DisplayConf.pclk` main clock divider for PCLK, if 0 there is no PCLK output
* `DisplayConf.swizzle` controls the arrangement of output RGB pins to support different LCD panels
* `DisplayConf.pclkpol` `0` for PCLK polarity on the rising edge, 1 for falling edge
* `DisplayConf.cspread` controls the transition of RGB signals with PCLK active clock edge
* `DisplayConf.dither` `1` or `0` to respectively enable or disable dither
* `DisplayConf.description` a string describing the display

`display_conf` module global variable is automatically set with a `DisplayConf()` instance when importing a display module from a display vendor:

```python
from riverdi.displays.bt81x import ctp50
from bridgetek.bt81x import bt81x
```

###### DisplayConf.init

```#!py3 init(spi,cs,pd,int,dc=None,spi_speed=3000000)```


**Parameters:**

 - **spi** – spi driver (`SPI0`, `SPI1`, `...`)
 - **cs** – chip select pin
 -  **pd** – pd pin
 -   **int** – interrupt pin
 -  **dc** – display configuration as a `DisplayConf()` instance
 - **spi_speed** – spi speed in Hertz

Initializes the chip.

When `dc` parameter is not specified `display_conf` global variable is used.

##### class Palette

```#!py3 class Palette(font,foreground,background)```

Class to store a color palette for font, foreground and background.
List of attributes:


* **font** tuple of rgb values `(r,g,b)`
* **foreground** tuple of rgb values `(r,g,b)`
* **background** tuple of rgb values `(r,g,b)`

##### class Text

```#!py3 class Text(x,y,font,options,text,palette=None)```

Class to store a text element configuration.
List of attributes:


* **x**- coordinate top-left, in pixels
* **y** - coordinate top-left, in pixels
* **font**  to use `0-31`
* **options** one of `OPT_CENTERX`, `OPT_CENTERY`, `OPT_CENTER`, `OPT_RIGHTX`, `OPT_FORMAT`, `OPT_FILL`
* **text** string
* **palette** `Palette()` object instance to set colors

##### class Button

```#!py3 class Button(x,y,width,height,font,options,text,palette=None)```

Class to store a text element configuration. Inherits all `Text()` attributes and adds:


* `width` button width in pixels
* `height` button height in pixels

## Co-Processor Commands

List of available options for the `options` command parameter:


* `OPT_3D` 3D effect
* `OPT_CENTER` horizontally and vertically centered style
* `OPT_CENTERX` horizontally-centered style
* `OPT_CENTERY` vertically-centered style
* `OPT_FILL` breaks the text at spaces into multiple lines
* `OPT_FLASH` fetch the data from flash memory
* `OPT_FLAT` no 3D effect
* `OPT_FORMAT` flag of string formatting
* `OPT_FULLSCREEN` zoom the media to fill as much of the screen as possible
* `OPT_MEDIAFIFO` source data from the defined media FIFO
* `OPT_MONO` decodes the source JPEG image to L8 format, i.e., monochrome
* `OPT_NOBACK` no background drawn
* `OPT_NODL` no display list commands generated
* `OPT_NOHANDS` no hands
* `OPT_NOHM` no hour and minute hands
* `OPT_NOPOINTER` no pointer
* `OPT_NOSECS` no second hands
* `OPT_NOTEAR` sync video updates to the display blanking interval, avoiding horizontal ```tearing``` artifacts
* `OPT_NOTICKS` no ticks
* `OPT_OVERLAY` append the video bitmap to an existing display list
* `OPT_RGB565` decodes the source image to RGB565 format
* `OPT_RIGHTX` right justified style
* `OPT_SIGNED` the number is treated as a 32 bit signed integer
* `OPT_SOUND` decode the audio data

Options can be combined using a bitwise OR.

###### dl_start

```#!py3 dl_start()```

Starts a new display list.

###### set_font_color

```#!py3 set_font_color(r,g,b)```


**Arguments:**
  

 - **r** – red `0-255`
 - **g** – green `0-255`
 - **b** – blue `0-255`

Sets current font color.


set_foreground(r, g, b)


**Arguments:**

 - **r** – red `0-255` 
 - **g** – green `0-255` 
 - **b** – blue `0-255`

Sets current foreground color.

###### set_background

```#!py3 set_background(r,g,b)```


**Arguments:**

    

 - **r** – red `0-255`
 - **g** – green `0-255`
 - **b** – blue `0-255`

Sets current background color.

**Parameters:**

 - **txt** – `Text` object instance

Adds a text element to the screen.

A call to `set_font_color()` is performed if the `Text.palette` attribute is set.

###### add_button

```#!py3 add_button(btn)```


**Arguments:**

    

 - **btn** – `Button` object instance

Adds a button element to the screen.

Calls to `set_background()`, `set_foreground()` and `set_font_color()` are performed if the `Text.palette.font` attribute is set.

###### add_keys

```#!py3 add_keys(x,y,w,h,font,options,s)```


**Arguments:**

 - **x** – x-coordinate top-left, in pixels
 - **y** – y-coordinate top-left, in pixels
 - **w** – width of the keys
 - **h** – height of the keys
 - **font** – font used in key label `0-31`
 - **options** – one of `OPT_3D` (default), `OPT_FLAT`, `OPT_CENTER` or an ASCII code
 - **s** – key labels, one character per key.

Adds a row of keys to the screen. If an ASCII code is specified as option, that key is drawn as *pressed* (in background color with any 3D effect removed).

The `TAG` value is set to the ASCII value of each key, so that key presses can be detected with a callback on that value.

###### add_clock

```#!py3 add_clock(x,y,r,options,h,m,s,ms)```


**Arguments:**
    

 - **x** – x-coordinate top-left, in pixels 
 - **y** – y-coordinate top-left, in pixels 
 - **r** – clock radius
 - **options** – one of `OPT_3D` (default), `OPT_FLAT`, `OPT_NOBACK`, `OPT_NOTICKS`, `OPT_NOSECS`, `OPT_NOHANDS`, `OPT_NOHM`
 - **h** – hour
 - **m** – minutes
 - **s** – seconds
 - **ms** – milliseconds


Adds a clock to the screen.

###### clear

```#!py3 clear(color,stencil,tag)```


**Arguments:**

 - **color** – clear color `0-1` 
 - **stencil** – clear stencil `0-1` 
 - **tag** – clear tag `0-1`

Clears buffers to default values.

###### clear_color

```#!py3 clear_color(rgb=None,a=None)```


**Arguments:**

**rgb** – tuple for red, green and blue values (`0-255`, `0-255`, `0-255`)
**a** – alpha `0-255`


Sets the default color when colors are cleared. The initial value is `((0, 0, 0), 0)`.

###### clear_tag

```#!py3 clear_tag(default_tag)```


**Arguments:**

    

 - **default_tag** – default tag

Sets the default tag when tag buffer is cleared. The initial value is `0`.

###### spinner

```#!py3 spinner(x,y,style,scale)```


**Arguments:**

 - **x** – x-coordinate top-left, in pixels
 - **y** – y-coordinate top-left, in pixels
 - **style** – spinner style, one of `SPINNER_CIRCLE`, `SPINNER_LINE`, `SPINNER_CLOCK`, `SPINNER_ORBITING`

Draws a spinner with a chosen style.

###### calibrate

```#!py3 calibrate()```

Starts the calibration procedure (needed by Resistive Displays).

###### inflate

```#!py3 inflate(ram_ptr,resource)```


**Arguments:**

    

 - **ram_ptr** – address in RAM_G to inflate the resource to
 -  **resource** – name of the resource to inflate

Inflates a Zerynth resource to RAM_G (General purpose graphics RAM, bt81x main memory) for later use. The resource should be a valid bt81x image (zlib-compressed).

**Raises:**

-   **PeripheralError**  – if an error occurs while loading
-   **TimeoutError**  – if the process takes longer than set timeout ([`set_timeout()`](https://docs.zerynth.com/latest/official/lib.bridgetek.bt81x/docs/official_lib.bridgetek.bt81x_bt81x.html#bt81x.set_timeout "bt81x.set_timeout"))


###### load_image

```#!py3 load_image(ram_ptr,options,resource)```


**Arguments:**

    

 - **ram_ptr** – address in RAM_G to load the resource to
 - **options** – load options
 - **resource** – name of the resource to inflate

Inflates a Zerynth resource consisting of a PNG image to RAM_G (General purpose graphics RAM, bt81x main memory) for later use.

Raises:

-   **PeripheralError**  – if an error occurs while loading
-   **TimeoutError**  – if the process takes longer than set timeout ([`set_timeout()`](https://docs.zerynth.com/latest/official/lib.bridgetek.bt81x/docs/official_lib.bridgetek.bt81x_bt81x.html#bt81x.set_timeout "bt81x.set_timeout"))

###### vertex_format

```#!py3 vertex_format(fmt)```


**Arguments:**

    

 - **fmt** – format frac value, one of `0`, `1`, `2`, `3`, `4`

Selects a vertex format for subsequent draw operations.

Vertex format are useful to specify pixel coordinates beyond the `0-511` range.

###### Bitmap

```#!py3 Bitmap(handle,source,layout,size)```


**Arguments:**

 - **handle** – a user-defined handle to refer to the bitmap
 - **source** – bitmap source in RAM_G
 - **layout** – a tuple of `(bitmap_format, linestride)`
 - **size** – a tuple of `(filtering_mode, x_wrap_mode, y_wrap_mode, bitmap_width, bitmap_height)`

Class to store a bitmap element and to allow subsequent bitmap draw operations.

`linestride` value represents the amount of memory used for each line of bitmap pixels.
It depends on selected format and can be usually calculated with the following formula:

```
linestride = width * byte/pixel
```

Allowed values for `bitmap_format` and number of bits/pixel for that format:


* `L1` `1`
* `L2` `2`
* `L4` `4`
* `L8` `8`
* `ARGB2` `8`
* `RGB332` `8`
* `ARGB4` `16`
* `ARGB1555` `16`
* `RGB565` `16`
* `PALETTED8` `8`
* `PALETTED4444` `8`
* `PALETTED565` `8`
* `BARGRAPH`
* `TEXT8X8`

Allowed values for `filtering_mode` are:


* `NEAREST`
* `BILINEAR`

Allowed values for `x_wrap_mode` and `y_wrap_mode` are:


* `BORDER`
* `REPEAT`

###### prepare_draw

```#!py3 prepare_draw()```

To be called before `draw()`.

###### draw

```#!py3 draw(vertex, vertex_fmt=None)```

Draws prepared image on screen.
Can be called multiple times after a single `prepare_draw()`.

If `vertex` tuple has 2 elements the vertex format is set according to `vertex_fmt` parameter (`vertex_format()`)         and `vertex` elements are assumed to be the image `x` and `y` top-left coordinates.

If `vertex` tuple has 4 elements `vertex_fmt` parameter is ignored and         `vertex` elements are assumed to be the image `x` and `y` top-left coordinates, image handle and cell.

###### end

```#!py3 end()```

Ends drawing a graphics primitive.

###### display

```#!py3 display()```

Ends a display list.

###### swap_and_empty

```#!py3 swap_and_empty()```


Swaps current display list and waits until all commands are executed.

**Raises:**

-   **PeripheralError**  – if an error occurs while loading
-   **TimeoutError**  – if the process takes longer than set timeout ([`set_timeout()`](https://docs.zerynth.com/latest/official/lib.bridgetek.bt81x/docs/official_lib.bridgetek.bt81x_bt81x.html#bt81x.set_timeout "bt81x.set_timeout"))


###### set_timeout

```#!py3 set_timeout(timeout_millis)```

**Arguments:**

    

 - **timeout_millis** – timeout in milliseconds

Sets a timeout for Co-Processor commands. Default timeout value is `4000`.

###### tag

```#!py3 tag(n)```


**Arguments:**

    

 - **n** – tag value `1-255`

Attaches the tag value to all the following graphics objects drawn on the screen, unless `tag_mask()` is used to disable it. When the graphics objects attached with the tag value are touched, if calls to `track()` and `touch_loop()` have been previously issued, a callback function is called.

The initial tag value is specified by function `clear_tag()` and takes effect calling function `clear()`.

###### tag_mask

```#!py3 tag_mask(mask)```


**Arguments:**

    

 - **mask** – mask value `0-1`

If called with value `0` the default value of the tag buffer is used for current display list.

###### tag_mask

```#!py3 tag_mask(mask)```

**Arguments:**

    

 - **mask** – mask value `0-1`

If called with value `0` the default value of the tag buffer is used for current display list.

###### touch_loop

```#!py3 touch_loop(cbks)```


**Arguments:**

    

 - **cbks** – tuple of tuples of callback and tag value for the callback to be activated on `((tag_value1, cbk1), (tag_value2, cbk2), ...)`
 - **touch_points** – number of multiple touch points (to be supported by used display)

Starts the touch loop to call set callbacks when touches are detected.
Each callback function is called passing tag value, tracked value and touch point.

If a tag value of `-1` is specified for a certain callback, that callback is called for every detected tag value.
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjA0NzYzNTA4NF19
-->
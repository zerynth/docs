# MODBUS Library

To talk with a slave device an object of type ModbusTCP or ModbusSerial must be        initialized, depending on what kind of communication is needed.

If serial communication is used, a device object that implements write, read and close methods is needed:

Example:

```
import gpio
import streams
import mcu
import sfw
from semtech.sx1503 import sx1503

RS485EN  = D40
LED_R    = D47
LED_G    = D54
LED_B    = D55
pinmap = {                      # now add pins definition for the expander
    LED_R   : 7,                       # LED R mapped to pin 7 on sx1503
    LED_G   : 14,                      # LED G mapped to pin 14 on sx1503
    LED_B   : 15,                      # LED B mapped to pin 15 on sx1503
    RS485EN : 0,                       # RS485 pin trasmit/recieve
}

class RS485():
    def __init__(self, watchdog_time):
    sfw.watchdog(0, watchdog_time)
    port_expander = sx1503.SX1503(I2C0, 400000)
    gpio.add_expander(1, port_expander, pinmap)
    gpio.mode(LED_R, OUTPUT)
    gpio.mode(LED_G, OUTPUT)
    gpio.mode(LED_B, OUTPUT)
    gpio.mode(RS485EN, OUTPUT)
    gpio.low(LED_G)
    gpio.low(LED_R)
    gpio.high(LED_B)
    gpio.low(RS485EN)
    self.port = streams.serial(drvname=SERIAL1, baud=9600, set_default=False)

    def read(self):
        gpio.low(RS485EN)
        bc = self.port.available()
        sfw.kick()
        return self.port.read(bc)

    def write(self, packet):
        gpio.high(RS485EN)
        self.port.write(packet)
        gpio.low(RS485EN)
        sfw.kick()

    def close(self):
        self.port.close()
```

When a connection with a slave device has been established, coils and registers can be accessed with the methods in each class.

## ModbusTCP class


---
#### `#!py3 ModbusTCP()`

!!!abstract "`#!py3 ModbusTCP(identifier)`"

Create an instance of the ModbusTCP class which allow modbus communication with slave device using TCP.


* ```Arguments```

    
    * ```identifier``` – The slave device identifier, used in the header of every packet.



---
#### `#!py3 read_coils()`

!!!abstract "`#!py3 read_coils(address, n)`"


* ```Arguments```

    
    * ```address``` – The starting address


    * ```n``` – the number of coils to read from address


Read the status of ```n``` coils, starting from ```address```.

Returns:

    a python list containing the values of the coils.


---
#### `#!py3 read_input()`

!!!abstract "`#!py3 read_input(address, n)`"


* ```Arguments```

    
    * ```address``` – The starting address


    * ```n``` – the number of input register to read, starting from ```address```


Returns:

    a python list containing the values of the input registers


---
#### `#!py3 read_holding()`

!!!abstract "`#!py3 read_holding(address, n)`"


* ```Arguments```

    
    * ```address``` – The starting address


    * ```n``` – the number of holding register to read, starting from ```address```


Returns:

    a python list containing the values of the holding registers


---
#### `#!py3 read_discrete()`

!!!abstract "`#!py3 read_discrete(address, n)`"


* ```Arguments```

    
    * ```address``` – The starting address


    * ```n``` – the number of discrete register to read, starting from ```address```


Returns:

    a python list containing the values of the discrete registers


---
#### `#!py3 write_coil()`

!!!abstract "`#!py3 write_coil(address, n)`"


* ```Arguments```

    
    * ```address``` – the address of the coil


    * ```value``` – the new value


Returns:

    1 if the write has been successfull. Otherwhise an exception will be thrown


---
#### `#!py3 write_register()`

!!!abstract "`#!py3 write_register(address, n)`"


* ```Arguments```

    
    * ```address``` – the address of the register


    * ```value``` – the new value


Returns:

    1 if the write has been successfull. Otherwhise an exception will be thrown


---
#### `#!py3 write_multiple_coils()`

!!!abstract "`#!py3 write_multiple_coils(address, n, values)`"


* ```Arguments```

    
    * ```address``` – the address of the first coil


    * ```n``` – the number of coils


    * ```value``` – a python list containing the new values


Returns:

    the number of coils written


---
#### `#!py3 write_multiple_registers()`

!!!abstract "`#!py3 write_multiple_registers(address, n, values)`"


* ```Arguments```

    
    * ```address``` – the address of the first holding register


    * ```n``` – the number of registers


    * ```value``` – a python list containing the new values


Returns:

    the number of holding registers written


---
#### `#!py3 connect()`

!!!abstract "`#!py3 connect(address, )`"


* ```Arguments```

    
    * ```address``` – the ip address of the slave device


    * ```port``` – port on which the slave device is listening to



---
#### `#!py3 close()`

!!!abstract "`#!py3 close()`"

close the connection with the slave device

## ModbusSerial class


---
#### `#!py3 ModbusSerial()`

!!!abstract "`#!py3 ModbusSerial(identifier, serial_device)`"

Create an instance of the ModbusSerial class which allow modbus communication with slave device using RTU.


* ```Arguments```

    
    * ```identifier``` – The slave device identifier


    * ```serial_device``` – an object representing the device. It must implement read, write and close methods to         communicate with the serial port. See ```rs485``` in the example folder.


    * ```receive_sleep``` – timeout on the receiving function;



---
#### `#!py3 read_coils()`

!!!abstract "`#!py3 read_coils(address, n)`"


* ```Arguments```

    
    * ```address``` – The starting address


    * ```n``` – the number of coils to read from address


Read the status of ```n``` coils, starting from ```address```.

Returns:

    a python list containing the values of the coils.


---
#### `#!py3 read_input()`

!!!abstract "`#!py3 read_input(address, n)`"


* ```Arguments```

    
    * ```address``` – The starting address


    * ```n``` – the number of input register to read, starting from ```address```


Returns:

    a python list containing the values of the input registers


---
#### `#!py3 read_holding()`

!!!abstract "`#!py3 read_holding(address, n)`"


* ```Arguments```

    
    * ```address``` – The starting address


    * ```n``` – the number of holding register to read, starting from ```address```


Returns:

    a python list containing the values of the holding registers


---
#### `#!py3 read_discrete()`

!!!abstract "`#!py3 read_discrete(address, n)`"


* ```Arguments```

    
    * ```address``` – The starting address


    * ```n``` – the number of discrete register to read, starting from ```address```


Returns:

    a python list containing the values of the discrete registers


---
#### `#!py3 write_coil()`

!!!abstract "`#!py3 write_coil(address, n)`"


* ```Arguments```

    
    * ```address``` – the address of the coil


    * ```value``` – the new value


Returns:

    1 if the write has been successfull. Otherwhise an exception will be thrown


---
#### `#!py3 write_register()`

!!!abstract "`#!py3 write_register(address, n)`"


* ```Arguments```

    
    * ```address``` – the address of the register


    * ```value``` – the new value


Returns:

    1 if the write has been successfull. Otherwhise an exception will be thrown


---
#### `#!py3 write_multiple_coils()`

!!!abstract "`#!py3 write_multiple_coils(address, n, values)`"


* ```Arguments```

    
    * ```address``` – the address of the first coil


    * ```n``` – the number of coils


    * ```value``` – a python list containing the new values


Returns:

    the number of coils written


---
#### `#!py3 write_multiple_registers()`

!!!abstract "`#!py3 write_multiple_registers(address, n, values)`"


* ```Arguments```

    
    * ```address``` – the address of the first holding register


    * ```n``` – the number of registers


    * ```value``` – a python list containing the new values


Returns:

    the number of holding registers written


---
#### `#!py3 close()`

!!!abstract "`#!py3 close()`"

Close the serial port by calling the close function implemented by the device class.

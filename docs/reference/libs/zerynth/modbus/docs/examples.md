# Examples

The following are a list of examples for lib.zerynth.modbus.

## ModbusTcp

```main.py```

```python
################################################################################
# Modbus communications via tcp.
#
# Created: 2019-03-21
# Author: L. Marsicano
################################################################################

import streams

# Needed for internet connectivity.
# This is dependent on your device.
from wireless import wifi 
from espressif.esp32net import esp32wifi as wifi_driver
from modbus import modbus

wifi_driver.auto_init()
streams.serial()

try:
    try:
        wifi.link("SSID", 3, "password")
    except Exception as e:
        print("Exception while trying to connect to the network ", e)
            
    master = modbus.ModbusTCP(1)

    try:
        master.connect("ip-address")
        print("Connected.")
    except Exception as e:
        print("Couldn't connect to the slave device ", e)

    result = master.write_coil(2, 0xff00)
    print("Written coil 2: ", result)

    result = master.write_register(55, 745)
    print("Written discrete register: ", result)

    result = master.write_multiple_coils(10, 10, [1, 0, 1, 1, 0, 0, 1, 1, 1, 0])
    print("Written ", result, " coils")

    result = master.write_multiple_registers(20, 10, [55, 555, 123, 42, 352, 546, 754, 34, 643, 23])
    print("Written ", result, " registers")

    coils = master.read_coils(20, 19)
    print("Coils 20-38 status: ", coils)

    discrete = master.read_discrete(20, 15)
    print("Discrete inputs 20-34 values: ", discrete)

    holding = master.read_holding(20, 10)
    print("Holding registers 20-29 values: ", holding)

    inputs = master.read_input(20, 10)
    print("Input registers 20-29 values: ", inputs)

    master.close()
    print("Closed.")
	
except Exception as e:
	print("Error ", e)

```
## ModbusSerial

```main.py```

```python
################################################################################
# Modbus communications via serial line.
#
# Created: 2019-03-21
# Author: L. Marsicano
################################################################################

import rs485
from modbus import modbus
import streams

try:
    device = rs485.RS485(100000)
    # Wait for the serial port to open. This may not be necessary
    sleep(10000)
    master = modbus.ModbusSerial(1, serial_device = device)

    result = master.write_register(5, 745)
    print("Written discrete register: ", result)

    result = master.write_multiple_registers(2, 4, [55, 555, 123, 42])
    print("Written ", result, " registers")

    discrete = master.read_discrete(2, 4)
    print("Discrete inputs values: ", discrete)

    holding = master.read_holding(3, 2)
    print("Holding registers values: ", holding)

    master.close()
    print("Closed.")
	
except Exception as e:
	print("Exception ", e)

```

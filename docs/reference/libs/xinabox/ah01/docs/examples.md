# Examples

The following are a list of examples for lib.xinabox.ah01

## Ping example


The simplest example to be tried for starting with the Zerynth ATECCx08A library and the ATECC508A crypto element.

Simply read the Revision bytes of the chip, checking if they are the expected ones.



```main.py```

```python
""" Simplest example of usage for the ATECCx08A library with ATECC508A crypto element.

    This module can be used an easy check device correct functioning.

"""

import streams
from xinabox.ah01 import ah01

PORT = I2C0
CLOCK = 100000

streams.serial()
crypto = ah01.ATECC508A(PORT, clk=CLOCK)


def bytes_hex(data):
    """ Return hex string representation of bytes/bytearray object. """
    res = "0x"
    for byte in data:
        res += "%02X" % byte

    return res


def info_cmd_test():
    """ Send an info command and check the result, which is a chip constant. """
    expected = bytes([0x00, 0x00, 0x50, 0x00])
    response = crypto.info_cmd('REVISION')

    if response == expected:
        print("Success. Device replied correctly.")
    else:
        print("Response from device not matching:")
        print(bytes_hex(response))


while True:
    try:
        info_cmd_test()
    except Exception as err:
        print(err)
    sleep(1000)

```

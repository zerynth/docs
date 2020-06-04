# Examples

The following are a list of examples for lib.stm.teseoliv3f

## Fix


A simple example showing how to handle Teseo-liv3F serial messages and fix GPS position.



```main.py```

```python
# TeseoLiv3F
# Created at 2019-03-26 09:45:18.145367

import streams
from stm.teseoliv3f import teseoliv3f


streams.serial()
try:
    gnss = teseoliv3f.TeseoLiv3F(SERIAL4)
    print("Starting...")
    gnss.start(D59)
    gnss.set_rate(1000)
    while True:
        #print(".")
        utc = gnss.utc()
        print("UTC",utc)
        if gnss.has_fix():
            fix = gnss.fix()
            if fix:
                for x in fix:
                    print("Fix",x)
            print("Pausing")
            gnss.pause()
            sleep(10000)
            print("Resuming")
            gnss.resume()
        sleep(1000)
except Exception as e:
    print("EXC!")
    print(e)

```

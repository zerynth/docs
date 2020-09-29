# Examples

The following are a list of examples for lib.liveintersect.iot.



```main.py```

```python
from espressif.esp32net import esp32wifi as wifi_driver
from wireless import wifi

import streams

import helper
import ssl

from liveintersect.iot import iot

new_resource('asset.config.json')

streams.serial()

print("Initializing wifi_driver")
wifi_driver.auto_init()
print("Establishing wifi_connection")
wifi.link("SSID", wifi.WIFI_WPA2, "PWD")

cacert = __lookup(SSL_CACERT_COMODO_RSA_CERTIFICATION_AUTHORITY)
ctx = ssl.create_ssl_context(cacert=cacert,options=ssl.CERT_REQUIRED|ssl.SERVER_AUTH)

print("> Connected")

try:
    asset_config = helper.load_asset_conf()
    my_asset = iot.Asset(asset_config["baseUrl"], asset_config["apiKey"], asset_config["srNo"], asset_config["assetName"],assetTypeCode=asset_config["assetTypeCode"],ssl_ctx=ctx)
    my_asset.register_asset()
    print(helper.get_asset_info(my_asset))
    while(True):
        iot.post_metric(my_asset,"T1", random(0,60))
        iot.post_attribute(my_asset,"latitude", random(0,60))
        sleep(10000)
except Exception as e:
    print(e)

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTIzODM2NzAwNF19
-->
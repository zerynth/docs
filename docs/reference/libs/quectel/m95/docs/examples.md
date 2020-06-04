# Examples

The following are a list of examples for lib.quectel.m95

## Secure Socket


A simple example showing how to connect with TLS sockets thanks to UG96 (configured with secure ciphersuites only).



```main.py```

```python
################################################################################
# Zerynth Secure Sockets
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
import json
# import the gsm interface
from wireless import gsm
# import the http module
import requests
import ssl

from quectel.ug96 import ug96 as ug96


streams.serial()

try:
    print("Initializing UG96...")
    # init the ug96
    # pins and serial port must be set according to your setup
    ug96.init(SERIAL3,D12,D13,D67,D60,D37,D38,0)


    # change APN name as needed
    print("Establishing Link...")
    gsm.attach("YOUR-APN-HERE")

    # let's try to connect to https://www.howsmyssl.com/a/check to get some info
    # on the SSL/TLS connection

    # retrieve the CA certificate used to sign the howsmyssl.com certificate
    cacert = __lookup(SSL_CACERT_DST_ROOT_CA_X3)

    # create a SSL context to require server certificate verification
    ctx = ssl.create_ssl_context(cacert=cacert,options=ssl.CERT_REQUIRED|ssl.SERVER_AUTH)
    # NOTE: if the underlying SSL driver does not support certificate validation
    #       uncomment the following line!
    # ctx = None


    for i in range(3):
        try:
            print("Trying to connect...")
            url="https://www.howsmyssl.com/a/check"
            # url resolution and http protocol handling are hidden inside the requests module
            user_agent = {"User-Agent": "curl/7.53.1", "Accept": "*/*" }
            # pass the ssl context together with the request
            response = requests.get(url,headers=user_agent,ctx=ctx)
            # if we get here, there has been no exception, exit the loop
            break
        except Exception as e:
            print(e)


    try:
        # check status and print the result
        if response.status==200:
            print("Success!!")
            print("-------------")
            # it's time to parse the json response
            js = json.loads(response.content)
            # super easy!
            for k,v in js.items():
                if k=="given_cipher_suites":
                    print("Supported Ciphers")
                    for cipher in v:
                        print(cipher)
                    print("-----")
                else:
                    print(k,"::",v)
            print("-------------")
    except Exception as e:
        print("ooops, something very wrong! :(",e)
except Exception as e:
    print("oops, exception!",e)

```
## UDP Socket


A simple project showing how to use UDP sockets with UG96



```main.py```

```python
################################################################################
# Zerynth UDP Socket
#
# Created by Zerynth Team 2015 CC
# Authors: G. Baldi, D. Mazzei
################################################################################

import streams
import socket
# import the gsm interface
from wireless import gsm
from quectel.ug96 import ug96 as ug96

# For this example to work, you need an UDP server somewhere on the public
# internet. You can run this example (https://gist.github.com/Manouchehri/67b53ecdc767919dddf3ec4ea8098b20)
# on your cloud instance on the port you prefer for the sake of this test

streams.serial()

# specify here the IP and port of your UDP server
server_ip = "0.0.0.0"
server_port = 7778

try:
    print("Initializing UG96...")
    # init the ug96
    # pins and serial port must be set according to your setup
    ug96.init(SERIAL3,D12,D13,D67,D60,D37,D38,0)


    # use the wifi interface to link to the Access Point
    # change network name, security and password as needed
    print("Establishing Link...")
    gsm.attach("your-apn-name")


    print("Trying UDP socket in connect mode")
    # Let's open an udp socket with connect.
    # the socket will then be used with send and recv methods
    # without specifying the receiver address.
    # The socket will be able to send only to the address
    # specified in the connect method
    sock= socket.socket(type=socket.SOCK_DGRAM,proto=socket.IPPROTO_UDP)
    sock.connect((server_ip,server_port))
    for i in range(5):
        sock.send("Hello\n")
        sleep(1000)

    sock.close()

    print("Trying UDP socket in bind mode")
    # Let's open an udp socket and configure with bind.
    # the socket will then be used with sendto and recvfrom methods
    # specifying the receiver address.
    # The socket will be able to send to any ip address
    sock= socket.socket(type=socket.SOCK_DGRAM,proto=socket.IPPROTO_UDP)
    # open the udp socket on port 5678 on the public facing ip
    # Note: you won't necessarily see the same origin port on the
    # UDP server since GSM networks are usually behind a NAT
    sock.bind(("0.0.0.0",5678))
    for i in range(5):
        sock.sendto("Hello\n",(server_ip,server_port))
        sleep(1000)

except Exception as e:
    print("oops, exception!",e)

while True:
    print(".")
    sleep(1000)



```

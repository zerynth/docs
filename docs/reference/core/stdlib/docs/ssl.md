# Secure Socket Layer

This module provides access to an almost complete Secure Socket Layer interface. However, some behaviour may be
dependent on the underlying network driver.

SSL/TLS  (TLS from now on) provides encryption and peer authentication facilities for network sockets, both client-side and server-side.
The properties enforced by TLS on data transmission are:


* ```confidentiality```: it means the transmitted data is readable only to the two end points of the TLS, it is unreadable garbage for everyon else intercepting the such data during transmission


* ```integrity```: it means each end point receives exactly what has been sent by the other end point, no data tampering is possible


* ```authentication```: it means each end point can have guarantees on the identity of the other end point

In order to achieve such capabilities, TLS exploits the properties of different cryptographic primitives.
Confidentiality is obtained by exchanging a symmetric key (a secret known only by he two end points for the duration of the connection) by means of asymmetric key cryptography (usually Diffie-Hellman or RSA key exchange). Such symmetric key will be used to encrypt every transmitted message.
Integrity is guaranteed by appending to transmitted messages a signed digest (called HMAC) that can be generated only by someone knowing the symmetric key.

Authentication is more complex and configurable. Indeed authentication in TLS can be:


* skipped: the two end points are not interested in the authentication property, therefore they do not require the other end to authenticate at the beginning of the connection


* one-way: the client can require the server to show some credentials (called certificate) that guarantees its identity. The client can close the connection if the verification of the server certificate fails.


* two-way: both server and client ask each other a proof of identity by exchanging and verifying certificates.

A certificate consists of a public key together with some more data (such as the server domain, the expiration date, etc…) and to guarantee the certificate is not tampered,
it is signed with the private key of a certification authority (CA). The CA public key must be known and it is contained in a set of CA certificates common to both end points.

The mechanism of certificate verification consists of an exchange of asymmetrically crypted messages that proves the identity of the server (and of the client if requested).

No TLS connection is secure without athentication! Therefore, at least a CA certificate must be given to the client in order to authenticate the server and certificate verification must be enabled (it is disabled by default).

Since there are many certification authorities, shipping all CA certificates inside a microcontroller is not feasible. Zerynth provides the useful `__lookup` macro that can be used to retrieve a single CA certificate
and store it directly in the firmware:

```
cacert0 = __lookup(SSL_CACERT_COMODO_TRUSTED_SERVICES_ROOT)
cacert1 = __lookup(SSL_CACERT_DIGICERT_TRUSTED_ROOT_G4)

# cacert0 will be set to "Comodo Trusted Services" CA certificate
# cacert1 will be set to "DigiCert Trusted Root G4" CA certificate
```

To check the TLS feature available in a particular network driver, refer to the following example (based on ESP32):

```
import json
# import the wifi interface
from wireless import wifi
# import the http module
import requests
# import ssl module
import ssl

# the wifi module needs a networking driver to be loaded
# in order to control the board hardware.
from espressif.esp32net import esp32wifi as wifi_driver


streams.serial()

# init the wifi driver!
# The driver automatically registers itself to the wifi interface
# with the correct configuration for the selected board
wifi_driver.auto_init()


# use the wifi interface to link to the Access Point
# change network name, security and password as needed
print("Establishing Link...")
try:
    # FOR THIS EXAMPLE TO WORK, "Network-Name" AND "Wifi-Password" MUST BE SET
    # TO MATCH YOUR ACTUAL NETWORK CONFIGURATION
    wifi.link("Network-Name",wifi.WIFI_WPA2,"Wifi-Password")
except Exception as e:
    print("ooops, something wrong while linking :(", e)
    while True:
        sleep(1000)

# let's try to connect to https://www.howsmyssl.com/a/check to get some info
# on the SSL/TLS connection

# retrieve the CA certificate used to sign the howsmyssl.com certificate
cacert = __lookup(SSL_CACERT_DST_ROOT_CA_X3)

# create a SSL context to require server certificate verification
ctx = ssl.create_ssl_context(cacert=cacert,options=ssl.CERT_REQUIRED|ssl.SERVER_AUTH)

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
```

The following CA certificates are available with the __lookup primitive:


* *GlobalSign Root CA* : `SSL_CACERT_GLOBALSIGN_ROOT_CA`


* *GlobalSign Root CA - R2* : `SSL_CACERT_GLOBALSIGN_ROOT_CA___R2`


* *Verisign Class 3 Public Primary Certification Authority - G3* : `SSL_CACERT_VERISIGN_CLASS_3_PUBLIC_PRIMARY_CERTIFICATION_AUTHORITY___G3`


* *Entrust.net Premium 2048 Secure Server CA* : `SSL_CACERT_ENTRUST.NET_PREMIUM_2048_SECURE_SERVER_CA`


* *Baltimore CyberTrust Root* : `SSL_CACERT_BALTIMORE_CYBERTRUST_ROOT`


* *AddTrust Low-Value Services Root* : `SSL_CACERT_ADDTRUST_LOW_VALUE_SERVICES_ROOT`


* *AddTrust External Root* : `SSL_CACERT_ADDTRUST_EXTERNAL_ROOT`


* *AddTrust Public Services Root* : `SSL_CACERT_ADDTRUST_PUBLIC_SERVICES_ROOT`


* *AddTrust Qualified Certificates Root* : `SSL_CACERT_ADDTRUST_QUALIFIED_CERTIFICATES_ROOT`


* *Entrust Root Certification Authority* : `SSL_CACERT_ENTRUST_ROOT_CERTIFICATION_AUTHORITY`


* *RSA Security 2048 v3* : `SSL_CACERT_RSA_SECURITY_2048_V3`


* *GeoTrust Global CA* : `SSL_CACERT_GEOTRUST_GLOBAL_CA`


* *GeoTrust Global CA 2* : `SSL_CACERT_GEOTRUST_GLOBAL_CA_2`


* *GeoTrust Universal CA* : `SSL_CACERT_GEOTRUST_UNIVERSAL_CA`


* *GeoTrust Universal CA 2* : `SSL_CACERT_GEOTRUST_UNIVERSAL_CA_2`


* *Visa eCommerce Root* : `SSL_CACERT_VISA_ECOMMERCE_ROOT`


* *Certum Root CA* : `SSL_CACERT_CERTUM_ROOT_CA`


* *Comodo AAA Services root* : `SSL_CACERT_COMODO_AAA_SERVICES_ROOT`


* *Comodo Secure Services root* : `SSL_CACERT_COMODO_SECURE_SERVICES_ROOT`


* *Comodo Trusted Services root* : `SSL_CACERT_COMODO_TRUSTED_SERVICES_ROOT`


* *QuoVadis Root CA* : `SSL_CACERT_QUOVADIS_ROOT_CA`


* *QuoVadis Root CA 2* : `SSL_CACERT_QUOVADIS_ROOT_CA_2`


* *QuoVadis Root CA 3* : `SSL_CACERT_QUOVADIS_ROOT_CA_3`


* *Security Communication Root CA* : `SSL_CACERT_SECURITY_COMMUNICATION_ROOT_CA`


* *Sonera Class 2 Root CA* : `SSL_CACERT_SONERA_CLASS_2_ROOT_CA`


* *UTN USERFirst Hardware Root CA* : `SSL_CACERT_UTN_USERFIRST_HARDWARE_ROOT_CA`


* *Camerfirma Chambers of Commerce Root* : `SSL_CACERT_CAMERFIRMA_CHAMBERS_OF_COMMERCE_ROOT`


* *Camerfirma Global Chambersign Root* : `SSL_CACERT_CAMERFIRMA_GLOBAL_CHAMBERSIGN_ROOT`


* *XRamp Global CA Root* : `SSL_CACERT_XRAMP_GLOBAL_CA_ROOT`


* *Go Daddy Class 2 CA* : `SSL_CACERT_GO_DADDY_CLASS_2_CA`


* *Starfield Class 2 CA* : `SSL_CACERT_STARFIELD_CLASS_2_CA`


* *StartCom Certification Authority* : `SSL_CACERT_STARTCOM_CERTIFICATION_AUTHORITY`


* *Taiwan GRCA* : `SSL_CACERT_TAIWAN_GRCA`


* *Swisscom Root CA 1* : `SSL_CACERT_SWISSCOM_ROOT_CA_1`


* *DigiCert Assured ID Root CA* : `SSL_CACERT_DIGICERT_ASSURED_ID_ROOT_CA`


* *DigiCert Global Root CA* : `SSL_CACERT_DIGICERT_GLOBAL_ROOT_CA`


* *DigiCert High Assurance EV Root CA* : `SSL_CACERT_DIGICERT_HIGH_ASSURANCE_EV_ROOT_CA`


* *Certplus Class 2 Primary CA* : `SSL_CACERT_CERTPLUS_CLASS_2_PRIMARY_CA`


* *DST Root CA X3* : `SSL_CACERT_DST_ROOT_CA_X3`


* *DST ACES CA X6* : `SSL_CACERT_DST_ACES_CA_X6`


* *SwissSign Gold CA - G2* : `SSL_CACERT_SWISSSIGN_GOLD_CA___G2`


* *SwissSign Silver CA - G2* : `SSL_CACERT_SWISSSIGN_SILVER_CA___G2`


* *GeoTrust Primary Certification Authority* : `SSL_CACERT_GEOTRUST_PRIMARY_CERTIFICATION_AUTHORITY`


* *thawte Primary Root CA* : `SSL_CACERT_THAWTE_PRIMARY_ROOT_CA`


* *VeriSign Class 3 Public Primary Certification Authority - G5* : `SSL_CACERT_VERISIGN_CLASS_3_PUBLIC_PRIMARY_CERTIFICATION_AUTHORITY___G5`


* *SecureTrust CA* : `SSL_CACERT_SECURETRUST_CA`


* *Secure Global CA* : `SSL_CACERT_SECURE_GLOBAL_CA`


* *COMODO Certification Authority* : `SSL_CACERT_COMODO_CERTIFICATION_AUTHORITY`


* *Network Solutions Certificate Authority* : `SSL_CACERT_NETWORK_SOLUTIONS_CERTIFICATE_AUTHORITY`


* *WellsSecure Public Root Certificate Authority* : `SSL_CACERT_WELLSSECURE_PUBLIC_ROOT_CERTIFICATE_AUTHORITY`


* *COMODO ECC Certification Authority* : `SSL_CACERT_COMODO_ECC_CERTIFICATION_AUTHORITY`


* *Security Communication EV RootCA1* : `SSL_CACERT_SECURITY_COMMUNICATION_EV_ROOTCA1`


* *OISTE WISeKey Global Root GA CA* : `SSL_CACERT_OISTE_WISEKEY_GLOBAL_ROOT_GA_CA`


* *Microsec e-Szigno Root CA* : `SSL_CACERT_MICROSEC_E_SZIGNO_ROOT_CA`


* ```Certigna``` : `SSL_CACERT_CERTIGNA`


* *Deutsche Telekom Root CA 2* : `SSL_CACERT_DEUTSCHE_TELEKOM_ROOT_CA_2`


* *Cybertrust Global Root* : `SSL_CACERT_CYBERTRUST_GLOBAL_ROOT`


* *ePKI Root Certification Authority* : `SSL_CACERT_EPKI_ROOT_CERTIFICATION_AUTHORITY`


* *Buypass Class 2 CA 1* : `SSL_CACERT_BUYPASS_CLASS_2_CA_1`


* *certSIGN ROOT CA* : `SSL_CACERT_CERTSIGN_ROOT_CA`


* *CNNIC ROOT* : `SSL_CACERT_CNNIC_ROOT`


* *ApplicationCA - Japanese Government* : `SSL_CACERT_APPLICATIONCA___JAPANESE_GOVERNMENT`


* *GeoTrust Primary Certification Authority - G3* : `SSL_CACERT_GEOTRUST_PRIMARY_CERTIFICATION_AUTHORITY___G3`


* *thawte Primary Root CA - G2* : `SSL_CACERT_THAWTE_PRIMARY_ROOT_CA___G2`


* *thawte Primary Root CA - G3* : `SSL_CACERT_THAWTE_PRIMARY_ROOT_CA___G3`


* *GeoTrust Primary Certification Authority - G2* : `SSL_CACERT_GEOTRUST_PRIMARY_CERTIFICATION_AUTHORITY___G2`


* *VeriSign Universal Root Certification Authority* : `SSL_CACERT_VERISIGN_UNIVERSAL_ROOT_CERTIFICATION_AUTHORITY`


* *VeriSign Class 3 Public Primary Certification Authority - G4* : `SSL_CACERT_VERISIGN_CLASS_3_PUBLIC_PRIMARY_CERTIFICATION_AUTHORITY___G4`


* *NetLock Arany (Class Gold) Főtanúsítvány* : `SSL_CACERT_NETLOCK_ARANY_(CLASS_GOLD)_FŐTANÚSÍTVÁNY`


* *Staat der Nederlanden Root CA - G2* : `SSL_CACERT_STAAT_DER_NEDERLANDEN_ROOT_CA___G2`


* *Hongkong Post Root CA 1* : `SSL_CACERT_HONGKONG_POST_ROOT_CA_1`


* *SecureSign RootCA11* : `SSL_CACERT_SECURESIGN_ROOTCA11`


* *ACEDICOM Root* : `SSL_CACERT_ACEDICOM_ROOT`


* *Microsec e-Szigno Root CA 2009* : `SSL_CACERT_MICROSEC_E_SZIGNO_ROOT_CA_2009`


* *GlobalSign Root CA - R3* : `SSL_CACERT_GLOBALSIGN_ROOT_CA___R3`


* *Autoridad de Certificacion Firmaprofesional CIF A62634068* : `SSL_CACERT_AUTORIDAD_DE_CERTIFICACION_FIRMAPROFESIONAL_CIF_A62634068`


* *Izenpe.com* : `SSL_CACERT_IZENPE.COM`


* *Chambers of Commerce Root - 2008* : `SSL_CACERT_CHAMBERS_OF_COMMERCE_ROOT___2008`


* *Global Chambersign Root - 2008* : `SSL_CACERT_GLOBAL_CHAMBERSIGN_ROOT___2008`


* *Go Daddy Root Certificate Authority - G2* : `SSL_CACERT_GO_DADDY_ROOT_CERTIFICATE_AUTHORITY___G2`


* *Starfield Root Certificate Authority - G2* : `SSL_CACERT_STARFIELD_ROOT_CERTIFICATE_AUTHORITY___G2`


* *Starfield Services Root Certificate Authority - G2* : `SSL_CACERT_STARFIELD_SERVICES_ROOT_CERTIFICATE_AUTHORITY___G2`


* *AffirmTrust Commercial* : `SSL_CACERT_AFFIRMTRUST_COMMERCIAL`


* *AffirmTrust Networking* : `SSL_CACERT_AFFIRMTRUST_NETWORKING`


* *AffirmTrust Premium* : `SSL_CACERT_AFFIRMTRUST_PREMIUM`


* *AffirmTrust Premium ECC* : `SSL_CACERT_AFFIRMTRUST_PREMIUM_ECC`


* *Certum Trusted Network CA* : `SSL_CACERT_CERTUM_TRUSTED_NETWORK_CA`


* *Certinomis - Autorité Racine* : `SSL_CACERT_CERTINOMIS___AUTORITÉ_RACINE`


* *Root CA Generalitat Valenciana* : `SSL_CACERT_ROOT_CA_GENERALITAT_VALENCIANA`


* *TWCA Root Certification Authority* : `SSL_CACERT_TWCA_ROOT_CERTIFICATION_AUTHORITY`


* *Security Communication RootCA2* : `SSL_CACERT_SECURITY_COMMUNICATION_ROOTCA2`


* *Hellenic Academic and Research Institutions RootCA 2011* : `SSL_CACERT_HELLENIC_ACADEMIC_AND_RESEARCH_INSTITUTIONS_ROOTCA_2011`


* *Actalis Authentication Root CA* : `SSL_CACERT_ACTALIS_AUTHENTICATION_ROOT_CA`


* *Trustis FPS Root CA* : `SSL_CACERT_TRUSTIS_FPS_ROOT_CA`


* *StartCom Certification Authority* : `SSL_CACERT_STARTCOM_CERTIFICATION_AUTHORITY`


* *StartCom Certification Authority G2* : `SSL_CACERT_STARTCOM_CERTIFICATION_AUTHORITY_G2`


* *Buypass Class 2 Root CA* : `SSL_CACERT_BUYPASS_CLASS_2_ROOT_CA`


* *Buypass Class 3 Root CA* : `SSL_CACERT_BUYPASS_CLASS_3_ROOT_CA`


* *T-TeleSec GlobalRoot Class 3* : `SSL_CACERT_T_TELESEC_GLOBALROOT_CLASS_3`


* *EE Certification Centre Root CA* : `SSL_CACERT_EE_CERTIFICATION_CENTRE_ROOT_CA`


* *TURKTRUST Certificate Services Provider Root 2007* : `SSL_CACERT_TURKTRUST_CERTIFICATE_SERVICES_PROVIDER_ROOT_2007`


* *D-TRUST Root Class 3 CA 2 2009* : `SSL_CACERT_D_TRUST_ROOT_CLASS_3_CA_2_2009`


* *D-TRUST Root Class 3 CA 2 EV 2009* : `SSL_CACERT_D_TRUST_ROOT_CLASS_3_CA_2_EV_2009`


* ```PSCProcert``` : `SSL_CACERT_PSCPROCERT`


* *China Internet Network Information Center EV Certificates Root* : `SSL_CACERT_CHINA_INTERNET_NETWORK_INFORMATION_CENTER_EV_CERTIFICATES_ROOT`


* *Swisscom Root CA 2* : `SSL_CACERT_SWISSCOM_ROOT_CA_2`


* *Swisscom Root EV CA 2* : `SSL_CACERT_SWISSCOM_ROOT_EV_CA_2`


* *CA Disig Root R1* : `SSL_CACERT_CA_DISIG_ROOT_R1`


* *CA Disig Root R2* : `SSL_CACERT_CA_DISIG_ROOT_R2`


* ```ACCVRAIZ1``` : `SSL_CACERT_ACCVRAIZ1`


* *TWCA Global Root CA* : `SSL_CACERT_TWCA_GLOBAL_ROOT_CA`


* *TeliaSonera Root CA v1* : `SSL_CACERT_TELIASONERA_ROOT_CA_V1`


* *E-Tugra Certification Authority* : `SSL_CACERT_E_TUGRA_CERTIFICATION_AUTHORITY`


* *T-TeleSec GlobalRoot Class 2* : `SSL_CACERT_T_TELESEC_GLOBALROOT_CLASS_2`


* *Atos TrustedRoot 2011* : `SSL_CACERT_ATOS_TRUSTEDROOT_2011`


* *QuoVadis Root CA 1 G3* : `SSL_CACERT_QUOVADIS_ROOT_CA_1_G3`


* *QuoVadis Root CA 2 G3* : `SSL_CACERT_QUOVADIS_ROOT_CA_2_G3`


* *QuoVadis Root CA 3 G3* : `SSL_CACERT_QUOVADIS_ROOT_CA_3_G3`


* *DigiCert Assured ID Root G2* : `SSL_CACERT_DIGICERT_ASSURED_ID_ROOT_G2`


* *DigiCert Assured ID Root G3* : `SSL_CACERT_DIGICERT_ASSURED_ID_ROOT_G3`


* *DigiCert Global Root G2* : `SSL_CACERT_DIGICERT_GLOBAL_ROOT_G2`


* *DigiCert Global Root G3* : `SSL_CACERT_DIGICERT_GLOBAL_ROOT_G3`


* *DigiCert Trusted Root G4* : `SSL_CACERT_DIGICERT_TRUSTED_ROOT_G4`


* ```WoSign``` : `SSL_CACERT_WOSIGN`


* *WoSign China* : `SSL_CACERT_WOSIGN_CHINA`


* *COMODO RSA Certification Authority* : `SSL_CACERT_COMODO_RSA_CERTIFICATION_AUTHORITY`


* *USERTrust RSA Certification Authority* : `SSL_CACERT_USERTRUST_RSA_CERTIFICATION_AUTHORITY`


* *USERTrust ECC Certification Authority* : `SSL_CACERT_USERTRUST_ECC_CERTIFICATION_AUTHORITY`


* *GlobalSign ECC Root CA - R4* : `SSL_CACERT_GLOBALSIGN_ECC_ROOT_CA___R4`


* *GlobalSign ECC Root CA - R5* : `SSL_CACERT_GLOBALSIGN_ECC_ROOT_CA___R5`


* *Staat der Nederlanden Root CA - G3* : `SSL_CACERT_STAAT_DER_NEDERLANDEN_ROOT_CA___G3`


* *Staat der Nederlanden EV Root CA* : `SSL_CACERT_STAAT_DER_NEDERLANDEN_EV_ROOT_CA`


* *IdenTrust Commercial Root CA 1* : `SSL_CACERT_IDENTRUST_COMMERCIAL_ROOT_CA_1`


* *IdenTrust Public Sector Root CA 1* : `SSL_CACERT_IDENTRUST_PUBLIC_SECTOR_ROOT_CA_1`


* *Entrust Root Certification Authority - G2* : `SSL_CACERT_ENTRUST_ROOT_CERTIFICATION_AUTHORITY___G2`


* *Entrust Root Certification Authority - EC1* : `SSL_CACERT_ENTRUST_ROOT_CERTIFICATION_AUTHORITY___EC1`


* *CFCA EV ROOT* : `SSL_CACERT_CFCA_EV_ROOT`


* *TÜRKTRUST Elektronik Sertifika Hizmet Sağlayıcısı H5* : `SSL_CACERT_TÜRKTRUST_ELEKTRONIK_SERTIFIKA_HIZMET_SAĞLAYICISI_H5`


* *TÜRKTRUST Elektronik Sertifika Hizmet Sağlayıcısı H6* : `SSL_CACERT_TÜRKTRUST_ELEKTRONIK_SERTIFIKA_HIZMET_SAĞLAYICISI_H6`


* *Certinomis - Root CA* : `SSL_CACERT_CERTINOMIS___ROOT_CA`


* *OISTE WISeKey Global Root GB CA* : `SSL_CACERT_OISTE_WISEKEY_GLOBAL_ROOT_GB_CA`


* *Certification Authority of WoSign G2* : `SSL_CACERT_CERTIFICATION_AUTHORITY_OF_WOSIGN_G2`


* *CA WoSign ECC Root* : `SSL_CACERT_CA_WOSIGN_ECC_ROOT`


* *SZAFIR ROOT CA2* : `SSL_CACERT_SZAFIR_ROOT_CA2`


* *Certum Trusted Network CA 2* : `SSL_CACERT_CERTUM_TRUSTED_NETWORK_CA_2`


* *Hellenic Academic and Research Institutions RootCA 2015* : `SSL_CACERT_HELLENIC_ACADEMIC_AND_RESEARCH_INSTITUTIONS_ROOTCA_2015`


* *Hellenic Academic and Research Institutions ECC RootCA 2015* : `SSL_CACERT_HELLENIC_ACADEMIC_AND_RESEARCH_INSTITUTIONS_ECC_ROOTCA_2015`


* *Certplus Root CA G1* : `SSL_CACERT_CERTPLUS_ROOT_CA_G1`


* *Certplus Root CA G2* : `SSL_CACERT_CERTPLUS_ROOT_CA_G2`


* *OpenTrust Root CA G1* : `SSL_CACERT_OPENTRUST_ROOT_CA_G1`


* *OpenTrust Root CA G2* : `SSL_CACERT_OPENTRUST_ROOT_CA_G2`


* *OpenTrust Root CA G3* : `SSL_CACERT_OPENTRUST_ROOT_CA_G3`

## The sslsocket class


`sslsocket(family=AF_INET, type=SOCK_STREAM, proto=IPPROTO_TCP, ctx=())`

This class represents a secure socket based on SSL/TLS protocol. It inherits from socket.socket

Raise `IOError` exceptions if socket creation goes wrong.

The parameter ```ctx``` is the SSL context to use for the socket. See 
:function:`create_ssl_context`
```

 for details.

Sockets can be used like this:

```
# import the ssl module
import ssl
# import a module to access a net driver (wifi, eth,...)
from wireless import wifi
# import the actual net driver
from driver.wifi.your_preferred_net_driver import your_preferred_net_driver

# init the driver
your_preferred_net_driver.init()

# link the wifi to an AP
wifi.link("Your Wifi SSID",WIFI_WPA2,"Your Wifi Password")

# create a tcp socket
sock = ssl.sslsocket(type=SOCK_STREAM)

# connect the socket to net address 192.168.1.10 on port 443
sock.connect(("192.168.1.10",443))

# send something on the socket!
sock.sendall("Hello World!")
```

<!-- _stdlib.ssl.create_ssl_context -->

---
#### `#!py3 create_ssl_context()`

!!!abstract "`#!py3 create_ssl_context(cacert="", clicert="", pkey="", hostname="", options=ssl.CERT_NONE|ssl.SERVER_AUTH)`"

This function generates an SSL context with the following data:


* ```cacert``` is the CA certificate that will be used to authenticate the other end of the TLS connection


* 

```
**
```

clicert\* is the certificate that the server expects to receive from the client in a two-way TLS authentication


* ```pkey``` is the private key matching ```clicert```. It can be an empty string to use a hardware stored private key. To enable the use of hardware keys a hardware cryptographic interface must be started. For example, with an `ATECC508A` (ATECCx08A interface):

```
from microchip.ateccx08a import ateccx08a
# ...
ateccx08a.hwcrypto_init(I2C0, 0) # select private key stored in slot 0
```

(in this case `ZERYNTH_HWCRYPTO_ATECCx08A` must be also set to true in `project.yml`)


* ```hostname``` is the hostname expected to match the certificate sent by the server. If not given, the hostname check is skipped


* ```options``` is an integer obtained by or’ing together one or more of the following options:

> 
>     * `ssl.CERT_NONE`: no certificate verification is performed (default)


>     * `ssl.CERT_OPTIONAL`: certificate verification is performed only if the other end of the connection sends one, otherwise the certificate is not requested and verification skipped


>     * `ssl.CERT_REQUIRED`: certificate verification is mandatory. If verification fails, `ConnectionAborted` is raised during TLS handshake.


>     * `ssl.SERVER_AUTH`: indicates that the context may be used to authenticate servers therefore, it will be used to create client-side sockets (default).


>     * `ssl.CLIENT_AUTH`: indicates that the context may be used to authenticate clients therefore, it will be used to create server-side sockets.

Returns a tuple to be passed as parameter during secure socket creation.

```NOTE```: ```cacert```, ```clicert``` and ```pkey``` can be bytes, bytearray, strings or instances of classes that have a ```size``` and ```read``` method, allowing to pass as parameters open files or resources.

```NOTE```: ```cacert```, ```clicert``` and ```pkey``` must be in PEM format and null-terminated (they must end with a 0 byte).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTIzODQ1NzQxN119
-->
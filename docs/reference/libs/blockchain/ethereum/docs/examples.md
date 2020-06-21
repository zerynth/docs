# Examples

The following are a list of examples for lib.blockchain.ethereum.

## Simple Transaction


Transfer value from an address to another through an Ethereum transaction.

In this example the Ropsten test network is used, so no real value is actually being transferred, but it acts exactly the same way that it would be in the real Ethereum network.


## Preparation

### Creating an address and get some Ether in it (MetaMask)

- Install the MetaMask browser extension from https://metamask.io/
- Choose the Ropsten test network from top-right corner (instead of the main network)
- Request your first Ether from https://faucet.metamask.io/, since we are using the test network, they have no real money value.
- Export and note your Ethereum private key from MetaMask pressing the three lines menu button, Details, Export private key (you will be promped for the password you created when you installed MetaMask).


### Registering to a RPC node (Infura)

- In order to interact with the Ethereum blockchain, a RPC node exposing API is needed. In this example we'll be using https://infura.io that offer this service for free. Register to their website and note your API key (e.g.
  607c53ff4845226fa6c4b060fd1db12d).


### Configuring the example

- Edit the `config.py` file and change your Wi-Fi informations.
- In the same file insert your Ethereum address and private key.
  This is the address that your microcontroller will be using to send some currency.
- You can also customize the receiver address (e.g. you can return some Ether to the faucet address that you can copy from https://faucet.metamask.io/) and the amount of Wei to be sent (note that 1e18 Wei = 1 Ether).



## Running the example
- After completing the previous part, you should be able to run the code and make your first transaction.
- You can use https://ropsten.etherscan.io to real time monitor your address or transactions status.



```main.py```

```python
import streams

# Ethereum modules
from blockchain.ethereum import ethereum
from blockchain.ethereum import rpc

# WiFi drivers
from espressif.esp32net import esp32wifi as net_driver # for ESP-32
# from broadcom.bcm43362 import bcm43362 as net_driver # for Particle Photon
from wireless import wifi

# SSL module for https
import ssl

# Configuration file
import config


# The SSL context is needed to validate https certificates
SSL_CTX = ssl.create_ssl_context(
    cacert=config.CA_CERT,
    options=ssl.CERT_REQUIRED|ssl.SERVER_AUTH
)


try:
    streams.serial()

    # Connect to WiFi network
    net_driver.auto_init()
    print("Connecting to wifi")
    wifi.link(config.WIFI_SSID, wifi.WIFI_WPA2, config.WIFI_PASSWORD)
    print("Connected!")
    print("Asking ethereum...")

    # Init the RPC node
    eth = rpc.RPC(config.RPC_URL, ssl_ctx=SSL_CTX)

    # Get our current balance
    balance = eth.getBalance(config.ADDRESS)
    print("Balance:", balance)
    if not balance:
        print(eth.last_error)
        raise Exception

    # Get network informations
    print("Gas Price:", eth.getGasPrice())
    nt = eth.getTransactionCount(config.ADDRESS)
    print("TCount:", nt)
    print("Chain:", eth.getChainId())

    # Prepare a transaction object
    tx = ethereum.Transaction()
    tx.set_value(config.WEI_AMOUNT, ethereum.WEI)
    tx.set_gas_price("0x430e23411")
    tx.set_gas_limit("0x33450")
    tx.set_nonce(nt)
    tx.set_receiver(config.RECEIVER_ADDRESS)
    tx.set_chain(ethereum.ROPSTEN)

    # Sign the transaction with the private key
    tx.sign(config.PRIVATE_KEY)

    # Print hex RLP representation
    print(tx.to_rlp(True))

    # Print hashes
    print(tx.hash(False).hexdigest())
    print(tx.hash(True).hexdigest())

    # Print full info
    print(tx)

    # Send the transaction
    tx_hash = eth.sendTransaction(tx.to_rlp(True))
    print("SENT!")
    print("Monitor your transaction at:\nhttps://ropsten.etherscan.io/tx/%s" % tx_hash)

except Exception as e:
    print(e)

while True:
    print(".")
    sleep(10000)

```
## # Smart contract example


This example shows how to call some smart contract functions, get the return value, or transfer Ether to a payable function.

In this example the Ropsten test network is used, so no real value is  actually being transferred, but it acts exactly the same way that it would be in the real Ethereum network.



## Game rules

This smart contract act as shooter for a virtual 20-faces dice.

A player can ask the shooter to roll the dice paying any amount (with a minimum 5 Wei) using the `bet` function.

After rolling the dice, if the sum of the number is greater or equal to 14, the player wins the jackpot. In any case his bet becomes part of the jackpot itself.

**Note:** the smart contract source code it's included in this example folder. A live version of the contract can be found on the Ropsten network at this address: [0xf7a270b24d2859002c0f414b0a0c97e4c794f5cc](https://ropsten.etherscan.io/address/0xf7a270b24d2859002c0f414b0a0c97e4c794f5cc).



## Preparation

### Creating an address and get some Ether in it (MetaMask)

- Install the MetaMask browser extension from https://metamask.io/
- Choose the Ropsten test network from top-right corner (instead of the main network)
- Request your first Ether from https://faucet.metamask.io/, since we are using the test network, they have no real money value.
- Export and note your Ethereum private key from MetaMask pressing the three lines menu button, Details, Export private key (you will be prompted for the password you created when you installed MetaMask).


### Registering to a RPC node (Infura)

- In order to interact with the Ethereum blockchain, a RPC node exposing API is needed. In this example we'll be using https://infura.io that offer this service for free. Register to their website and note your API key (e.g.
  607c53ff4845226fa6c4b060fd1db12d).


### Configuring the example

- Edit the `config.py` file and change your Wi-Fi informations.
- In the same file insert your Ethereum address and private key.
  This is the address that your microcontroller will be using to call the smart  contract.


## Running the example
- After completing the previous part, you should be able to run the code and make your first bet.
- You can use https://ropsten.etherscan.io to real time monitor your address or transactions status. After your bet has been mined, check your balance to see if you won or just lost some Ether.



```main.py```

```python
import streams

# Ethereum modules
from blockchain.ethereum import ethereum
from blockchain.ethereum import rpc

# WiFi drivers
from espressif.esp32net import esp32wifi as net_driver # for ESP-32
# from broadcom.bcm43362 import bcm43362 as net_driver # for Particle Photon
from wireless import wifi

# SSL module for https
import ssl

# Configuration file
import config


# The SSL context is needed to validate https certificates
SSL_CTX = ssl.create_ssl_context(
    cacert=config.CA_CERT,
    options=ssl.CERT_REQUIRED|ssl.SERVER_AUTH
)

# Use serial monitor
streams.serial()


def init_wifi():
    # Connect to WiFi network
    net_driver.auto_init()
    print("Connecting to wifi")
    wifi.link(config.WIFI_SSID, wifi.WIFI_WPA2, config.WIFI_PASSWORD)
    print("Connected!")


def send_bet():
    nt = eth.getTransactionCount(config.ADDRESS)
    tx = ethereum.Transaction()
    tx.set_value(config.BET_AMOUNT, ethereum.WEI)
    tx.set_gas_price(config.GAS_PRICE)
    tx.set_gas_limit("0x33450")
    tx.set_nonce(nt)
    tx.set_receiver(config.CONTRACT_ADDRESS)
    tx.set_chain(ethereum.ROPSTEN)
    tx.sign(config.PRIVATE_KEY)
    tx_hash = eth.sendTransaction(tx.to_rlp(True))
    return tx_hash


def print_balance():
    # Get our current balance from the net
    balance = eth.getBalance(config.ADDRESS)
    print("Current balance: ", balance)
    if not balance:
        print(eth.last_error)
        raise Exception


# Main
try:
    init_wifi()

    # Init the RPC node
    eth = rpc.RPC(config.RPC_URL, ssl_ctx=SSL_CTX)

    # Init smart contract object
    game = ethereum.Contract(
        eth,
        config.CONTRACT_ADDRESS,
        config.PRIVATE_KEY,
        config.ADDRESS,
        chain=ethereum.ROPSTEN
    )
    for name in config.CONTRACT_METHODS:
        method = config.CONTRACT_METHODS[name]
        game.register_function(
            name,
            config.GAS_PRICE,
            method["gas_limit"],
            args_type=method["args"]
        )

    # Run the game
    print_balance()
    jackpot = game.call('getJackpot', rv=(256, str))
    print('Current jackpot: %s' % jackpot)
    print('Betting %s Wei...' % config.BET_AMOUNT)
    nonce = eth.getTransactionCount(config.ADDRESS)
    tx_hash = game.tx('bet', nonce, value=(config.BET_AMOUNT, ethereum.WEI))
    print('Your bet has been placed, and the transaction is now being mined.')
    print('Monitor your balance at https://ropsten.etherscan.io/address/%s#internaltx to see if you won!' % config.ADDRESS)
    print('Reset your device to play again.')


except Exception as e:
    print(e)

while True:
    print(".")
    sleep(10000)

```
<!--stackedit_data:
eyJoaXN0b3J5IjpbODQ4MjkwMzE5XX0=
-->

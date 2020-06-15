# RPC

This module allows calling the JSON-RPC endpoints of a geth node.

```python
from blockchain.ethereum import rpc

...

address = "0x84db76Ea20C2f55F94A87440fBE825fBE5476da1"

# setup node address
eth = rpc.RPC("ethereum.zerynth.com:8545")

# retrieve balance
print("Balance:",eth.getBalance(address))
print("Gas Price:",eth.getGasPrice())
nonce = eth.getTransactionCount(address)
print("Transaction Count:",nonce)
print("Chain:",eth.getChainId())
```

# RPC class


**`class RPC(host)`**

Initialize a RPC instance with the get node at ```host```.
```host``` must also contain the port and the protocol (i.e. `https://mynode.com:8545`)


**`call(method,params=(),retry=10)`**

**Parameters:**
    

 - **method** – the endpoint to call
 -  **params**– the list of parameters for the endpoint
 -  **retry** – the number of call retries before failing

Call endpoint *method* with params *params*. Return the `result` field of the endpoint json response or None in case of error. Error reason can be retrieved in `self.last_error`.


**`getBalance(address, block_number="latest")`**


**Params address:** Ethereum address


**Params block_number:** the point in the blockchain up to which balance is calculated


Return the current balance for address *address*. Previous balances can be retrieved by specifying a different *block_number*.

**`getGasPrice()`**

Return the current gas price estimated by the Ethereum node. Return 0 on error.


**`getChainId()`**

Return the Ethereum network id.

**`getTransactionCount(address,block_number="latest")`**

**Parameters:**

 - **address** – Ethereum address
 - **block_number** – the point in the blockchain up to which the transaction count is calculated

Return the current transaction count for address *address*. The returned value can be used as nonce for the next transaction. Transaction counts at specific points in time can be retrieved by specifying a different *block_number*.


**`sendTransaction(tx,retry=10)`**

Parameters:

 - **tx** – the hexadecimal hash of a signed transaction
 -  **retry** – the number of retries

Send the raw transaction to the get node in order to broadcast it to all nodes in the network. If correct, it will be eventually added to a mined block.


**`simpleCall(tx,block_number,retry=10)`**


* ```Arguments```

    
    * ```tx``` – the hexadecimal hash of a signed transaction


    * ```block_number``` – the point in the blockchain up to which make the call


    * ```retry``` – the number of retries


Executes a new message call immediately without creating a transaction on the block chain.
<!--stackedit_data:
eyJoaXN0b3J5IjpbNTM3NzA0Mjk0LC0zNTk0MTcyMDMsNTI4NT
E1OTldfQ==
-->
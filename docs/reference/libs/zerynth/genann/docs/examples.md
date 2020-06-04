# Examples

The following are a list of examples for lib.zerynth.genann

## Hello XOR


Solve the XOR problem with a pre-trained ANN



```main.py```

```python
# Hello XOR with GENANN
# Created at 2018-10-07 15:04:55.068270

import streams
from genann import genann

streams.serial()

try:
    # create an ANN object
    ann = genann.ANN()
    
    # set the layers: 2 inputs, 1 output, 1 hidden layer of 2 neurons
    ann.create(2,1,1,2)
    
    # set the weights of a pretrained XOR model (https://github.com/codeplea/genann/blob/master/example/xor.ann)
    ann.set_weights([-1.777,-5.734,-6.029,-4.460,-3.261,-3.172,2.444,-6.581,5.826])
    
    # define the inputs
    input_set = [ 
        [0.0, 0.0],    # 0 xor 0 = 1
        [0.0, 1.0],    # 0 xor 1 = 0 
        [1.0, 0.0],    # 1 xor 0 = 0 
        [1.0, 1.0]     # 1 xor 1 = 1
        ]
        
    # run the network for each input set
    for i in input_set:
        print("Running XOR on",i)
        out = ann.run(i)
        print("Result",out)
    # Enjoy AI on a microcontroller! :)
except Exception as e:
    print(e)

```

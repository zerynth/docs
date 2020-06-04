# Genann

Genann is a minimal, well-tested library for training and using feedforward artificial neural networks (ANN) in C. Its primary focus is on being simple, fast, reliable, and hackable. It achieves this by providing only the necessary functions and little extra.

This module is a Python wrapper around the genann library hosted [here](https://github.com/codeplea/genann) . It allows the execution of feedforward neural networks directly on the microcontroller. The training functions are not yet available.

## ANN Class


---
#### `#!py3 ANN()`

!!!abstract "`#!py3 ANN()`"

This class is an implementations of the interface with the gennann C library.
Each istance of this class implements a separate neural network. The class is not thread safe,
multiple network must be protected by locks when executed.


---
#### `#!py3 create()`

!!!abstract "`#!py3 create(inputs, outputs, nlayers, nhidden)`"

This method initializes a neural network with `inputs` inputs, `outputs` outputs and a number of hidden layers
set by `nlayers` (that can be also 0). Each hidden layer, if present, contains exactly `nhidden` neurons.


---
#### `#!py3 run()`

!!!abstract "`#!py3 run(inputs)`"

This method executes the neural network using as input the array of float `inputs`.
It returns an array of float representing the output layer.


---
#### `#!py3 set_weights()`

!!!abstract "`#!py3 set_weights(weights)`"

This method initializes the weights of the ANN. It can be used to load a pre-trained set of weights or to
initializes the weights before training. Weights are represented by an array of floats `weights`.

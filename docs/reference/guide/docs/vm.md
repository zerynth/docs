# The Zerynth Virtual Machine

The Zerynth Virtual Machine can run Python scripts that are board independent allowing a high reusability of code. Zerynth supports all the most used high-level features of Python like modules, classes, multithreading, callbacks, timers and exceptions, plus some hardware-related features like interrupts, PWM, digital I/O, etc.

The Zerynth VM is natively multithread and realtime. Indeed it is built on top of a RTOS ([`CHIBIOS]( <http://www.chibios.org/dokuwiki/doku.php)>`_ or [`FreeRTOS]( <https://www.freertos.org/)>`_), by wrapping its functionalities in a operative system abstraction layer (VOSAL). This means that the VM is agnostic of the underlying RTOS: porting activities are ongoing to have many VMs based on different RTOS.

The inner workings of the Zerynth VM are complex but can be reduced to a few components:

  

  * **Bytecode Interpreter**: the Zerynth Compiler turns Python scripts to a set of bytecode objects, each one containing not only a sequence of instructions, but also enough information for memory management and error checking. Each bytecode instruction, called *opcode*, is exactly one byte in length with optional arguments going from 0 to 4 bytes. The bytecode interpreter simply scans the bytecode an opcode at time, executes the opcode in the current thread and continues to the next opcode until a stop is encountered. Zerynth bytecode closely resembles Python but introduces some embedded specific opcodes.
    * **Global Interpreter Lock**: the GIL is an object shared by all Python threads; it coordinates the sequence of opcode execution between threads so that each opcode can be considered "atomic". This means that while thread-one is executing opcode "x", thread-one has the right to do so until the execution of "x" reaches the end. No other thread can stop it without comproimising the interpreter integrity. When a Python thread goes to sleep, or its time quantum ends, the GIL is released so that another thread can take control of the bytecode interpreter.
    * **Garbage Collector**: objects in Python have life cycle. They are created and used by the programmer and must be removed when they are not needed anymore. While in low level languages the responsibility of freeing unused memory rests on the programmer, in Python it's the garbage collector (gc) duty. When necessary, a complete scan of the created object is performed in order to search the ones that can be removed safely. The VM gc algorithm is a mark-and-sweep-stop-the-world variant.
    * **Interrupt Thread**: it is a very high priority thread that is woken up when an interrupt configured to run a Python function is fired. Python bytecode is executed outside of the ISR routine, but inside the Interrupt Thread. This way the Python function can allocate memory as a normal function. However, since the interrupt thread has the highest priority it is important to spend the least time possible inside it.
    * **VOSAL**: it is the Zerynth VM operative system abstration layer. It contains functions provided by the underlying RTOS to create threads, semaphores and other multi-threading related objects. The VOSAL is linked into the VM, but many of its functions can be called from hybrid C/Python code. Check the [:ref:`Programming Guide](https://docs.zerynth.com/latest/official/core.zerynth.stdlib/docs/index.html#zerynth <ZERYNTHprog)>` for more information on calling C from Python.
*    * **VHAL**: it is the Zerynth VM hardware abstraction layer. It contains functions to control the microcontroller peripherals: serial ports, SPI, I2C, ADC, PWM and so on. Each family of microcontroller has its own VHAL implementation so that the programmer calling C from Python can have an uniform hardware API across different microcontrollers.



## Zerynth and Python

The Zerynth VM has been developed with the goal of making Python usable in the IoT world. To do so some features of Python have been discarded because they were too resource intensive, while non-Python features have been introduced because they were more functional in the embedded setting. Here is a non comprehensive list: 

 

   * Python Object size has been reduced as much as possible:

        * integers are signed and 31 bits wide, so that they can be represented with 4 bytes without additional overhead. 
        * garbage collectore overhead has been brought down to 8 bytes per object (and there is still space for optimization)
        * names are not saved as strings in the bytecode; they are converted to 16 bits integers to occupy much less space. This apparently minor change leads to a series of important consequences. First of all, Zerynth becomes a less "dynamic" language with respect to Python, since introspection is not allowed. However on the pro side, Zerynth scripts can be statically analyzed to remove unused bytecode greatly reducing memory usage. Another important consequence is that *setattr* and *getattr* can not be used with non constant arguments.
        * sequences and dictionaries can have at most 65536 elements.
        * exceptions have been transformed from full fledged classes to a name organized in an inheritance tree. So an exception can't have methods, but it is faster to raise and to handle and it just takes 4 bytes of memory.

    * Compilation has been moved outside the language; by removing the compile() and eval() builtins the VM shrienked greatly in size.
    * Not so often used Python features have been removed. Closures, generators and decorators will be added in future updates in a modular way.
    * True multi-threading with priorities has been introduced. CPython implementations use green-threads to emulate multi-threaded environments without relying on any native OS capabilities, and they are managed in user space instead of kernel space, enabling them to work in environments that do not have native thread support. In Zerynth each thread is a RTOS thread with its own memory and priority. Because of the GIL, only one Zerynth thread can execute bytecode in a time quantum, but it is possible to have more than one non-Python thread running in parallel. For example, a complex driver can be structured as a VOSAL thread written in C to control hardware, with any number of Zerynth threads running bytecode.
    * New data structures have been introduced like shorts and short-array to hold sequences of 16 bits integers. BigIints and fixed point math are in development.





<!--stackedit_data:
eyJoaXN0b3J5IjpbMTEzNTAzNTM2NSwtMTgzODk5NTg1NywtMT
I0NzY2NzIwNCw1NjE1Mjg2MzZdfQ==
-->
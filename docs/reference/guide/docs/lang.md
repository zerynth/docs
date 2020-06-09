# VM Interface

C functions called from Python can create and handle Python entities like lists, tuples, dictionaries and so on. In the current version of Zerynth only a few selected Python data structures can be accessed from C. Since the internal organization of the VM may change without notice is very important to access VM structures via documented macros and functions only.

## PObject

The VM treats every Python object as a pointer to a *```PObject*``` structure. There exist two types of PObjects: tagged and untagged. Tagged PObjects contains all the object information encoded in the 4 bytes of the pointer. Untagged objects are pointers to actual C structures. As a consequence, tagged PObjects are not allocated on the heap but reside on the stack of a frame of execution.

To better understand tagged PObjects imagine the case of integers: representing integers by allocating a PObject structure in memory is both a waste of ram and of computational power. Therefore small signed integers up to 31 bits are represented as [tagged pointers](https://en.wikipedia.org/wiki/Tagged_pointer). This “trick” is possible because a PObject pointer is 4 bytes (32 bits) and due to architecture constraints a valid PObject pointer is at least aligned to 2 or 4. In practical terms it means that the least significant bit of a valid PObject pointer is always 0: by “tagging” the PObject pointer, namely changing its lsb to 1, the VM is able to distinguish between concrete PObjects residing on the heap (untagged, lsb=0) and tagged PObjects (lsb=1). The representation of the number 42 as a tagged PObject follows:

```
MSB                                                         LSB

0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 1 0 1

^--- Sign bit                                       Bit 0---^ ^--- TAG = 1
```

Instead, an untagged PObject is a valid pointer to a C structure organized like this:

```
GCH:  B0 B1 B2 B3 B4 B5 B6 B7
DATA: .....
```

where GCH is an 8 byte header holding both garbage collection info and type/size info; DATA is whatever fields are needed to implement the PObject.

### Macros


   ### IS_TAGGED(obj)

Check if *obj*```obj``` is tagged or untagged.


 

   ### PTYPE(obj)

Extract type info from *obj*```obj``` (both tagged or untagged)


   ### PHEADERTYPE(obj)

Extract type info from *obj*```obj``` (untagged only)


   ### PSMALLINT
()
Type of a PObject representing a small integer (30 bits signed). Tagged.


   ### PINTEGER
()
Type of a PObject representing an integer up to int64_t. Untagged.


   ### PFLOAT
()
Type of a PObject representing a 64 bits float. Untagged.


    ### PBOOL
()
Type of a PObject representing a boolean. Tagged.


   ### PSTRING
()
Type of a PObject representing a string. Untagged.


   ### PBYTES
()
Type of a PObject representing a byte immutable sequence. Untagged.


   ### PBYTEARRAY
()
Type of a PObject representing a byte mutable sequence. Tagged.


   ### PSHORTS
()
Type of a PObject representing a 16 bits unsigned integer immutable sequence. Untagged.

   
### PSHORTARRAY
()
Type of a PObject representing a 16 bits unsigned integer mutable sequence. Untagged.


   ### PLIST
()
Type of a PObject representing a mutable sequence of PObjects. Untagged.


   ### PTUPLE
()
Type of a PObject representing an immutable sequence of PObjects. Untagged.


   ### PRANGE
()
Type of a PObject representing a range. Untagged.


   ### PFSET
()
Type of a PObject representing an immutable set. Untagged.


   ### PSET
()
Type of a PObject representing a mutable set. Untagged.


   ### PDICT
()
Type of a PObject representing a dictionary. Untagged.


   ### PFUNCTION
()
Type of a PObject representing a function. Untagged.


   ### PMETHOD
()
Type of a PObject representing a method. Untagged.


    ### PCLASS
()
Type of a PObject representing a class. Untagged.


   ### PINSTANCE
()
Type of a PObject representing an instance. Untagged.


   ### PMODULE
()
Type of a PObject representing a module. Untagged.


   ### PBUFFER
()
Type of a PObject representing a buffer. Untagged.


   ### PSLICE
()
Type of a PObject representing a slice. Untagged.


   ### PITERATOR
()
Type of a PObject representing an iterator over a sequence. Untagged.


   ### PFRAME
()
Type of a PObject representing an execution frame. Untagged.


   ### PCELL
()
Type of a PObject representing a cell. Tagged.


   ### PNONE
()
Type of a PObject representing None. Tagged.


    ### PEXCEPTION
()
Type of a PObject representing an exception. Tagged.


   ### PNATIVE
()
Type of a PObject representing a native function. Tagged.


   ### PSYSOBJ
()
Type of a PObject representing a system object. Untagged.


   ### PDRIVER
()
Type of a PObject representing a driver. Tagged.


   ### PTHREAD
()
Type of a PObject representing a Python thread. Untagged.

### Functions


    int parse_py_args(const char *fmt, int nargs, PObject **args, ...)

Given an array of PObject pointers *args*, with *nargs* elements, try to convert such elements to C structures according to a format string *fmt*. *fmt* is conceptually similar to the format string of printf.

The variadic arguments (vararg) are usually pointers to store the converted value of *args[n]*. The nth character of *fmt* identifies the type of PObject expected in *args[n]*. If the length of *fmt* is greater than *nargs*, the remaining varargs must also specify default values.

*fmt* may contain any of the following characters in the nth position:


* “l”: the nth argument must be of type PINTEGER. One vararg required of type int64_t* to store the converted value.


* “L”: the nth argument is an optional PINTEGER. Two varargs are required, one of type int64_t holding the default value, and one of type int64_t* holding the converted value.


* “i”: the nth argument must be of type PINTEGER. One vararg required of type int32_t* to store the converted value.


* “I”: the nth argument is an optional PINTEGER. Two varargs are required, one of type int32_t holding the default value, and one of type int32_t* holding the converted value.


* “s”: the nth argument must be of type PSTRING or PBYTES or PBYTEARRAY. Two varargs are required; the first of type uint8_t** to hold the byte sequence, the second of type int32_t* to hold the number of elements of the sequence.


* “S”: the nth argument must be of type PSTRING or PBYTES or PBYTEARRAY. Three varargs are required; the first of type uint_8* holding a default byte sequence, the second of type uint8_t** to hold the byte sequence, the third of type int32_t* to hold the number of elements of the sequence.


* “b” and “B”: same as “s” and “S” with the difference that the last vararg holds the maximum amount of elements storable in the sequence.


* “f”: the nth argument must be of type PFLOAT. One vararg required of type double* to store the converted value.


* “F”: the nth argument is an optional PFLOAT. Two varargs are required, one of type double holding the default value, and one of type double* holding the converted value.

Return the number of converted objects. If the return value is less than the length of `fmt`, a conversion error has occurred.

The following code illustrates the use of parse_py_args:

```
int32_t a;
double b;
uint8_t *c;
int32_t len,d;

if (parse_py_args("ifsI",nargs,args,&a,&b,&c,&len,2,&d)!=4)
        return ERR_TYPE_EXC;

// a will hold the converted value of args[0] (must be a PSMALLINT)
// b will hold the converted value of args[1] (must be a PFLOAT)
// c will hold the byte sequence in args[2], len will hold the number of bytes in args[2]
// d will hold 2 if nargs<=3, otherwise it will hold args[3] converted from PSMALLINT to int32_t
```

## Numbers

In the current version there are only three supported type of numbers: PSMALLINT, PINTEGER and PFLOAT.


**`PSMALLINT_NEW(x)`**
Return a tagged PObject of type PSMALLINT containing the integer value x. No overflow check is done.


**`PSMALLINT_VALUE(x)`**
Return the integer value contained in *x*, a PObject of type PSMALLINT.


**`IS_PSMALLINT(x)`**
Check if *x* is of type PSMALLINT.


**`INTEGER_VALUE(x)`**
Return the integer value contained in *x*; works for PSMALLINT and PINTEGER types.

**`PFLOAT_VALUE(x)`**
Return the float value contained in *x*, an untagged PObject of type PFLOAT.

### Functions


 **`pinteger_new(int64_t x)`**
Return a PINTEGER object with value *x*

**`pfloat_new(double x)`**
Return a PFLOAT object with value *x*

## Bool & None

Python has some special values of boolean type, True and False, and a special value None. Accessing such values can be done with the following macros:


**`IS_BOOL(x)`**
Return true if *x* is a PObject of type PBOOL


**`PBOOL_TRUE`**
Return a tagged PObject of type PBOOL and value True


**`PBOOL_FALSE`**
Return a tagged PObject of type PBOOL and value False


**`MAKE_NONE`**
Return a tagged PObject of type PNONE and value None

## Sequences

Python provides many objects representing sequences of items. Zerynth supports lists, tuples, bytes, bytearrays, strings and introduces shorts and shortarrays. All this PObjects must be created, accessed and manipulated through the following macros and functions.

### Macros


**`PSEQUENCE_ELEMENTS(seq)`**
Return the elements of *seq*.


**`PSEQUENCE_ELEMENTS_SET(seq, n)`**
Set the number of elements of *seq* to *n*.


**`PSEQUENCE_SIZE(seq)`**
Return the maximum number of elements storable in seq*emphasized text*.


**`PSEQUENCE_BYTES(seq)`**
Return a uint8_t pointer to the bytes stored in ```seq```.


**`PSEQUENCE_SHORTS(seq)`**
Return a uint16_t pointer to the integers stored in ```seq```.


**`PSEQUENCE_OBJECTS(seq)`**
Return a PObject\*\* to the PObjects stored in ```seq```.


**`PLIST_ITEM(lst, i)`**
Return the i-th item in ```lst``` with ```lst``` of type PLIST.


 **`PLIST_SET_ITEM(lst, i, item)`**
Set the i-th item in ```lst``` to ```item```, with ```lst``` of type PLIST.


**`PTUPLE_ITEM(lst, i)`**
Return the i-th item in ```lst``` with ```lst``` of type PTUPLE.


**`PTUPLE_SET_ITEM(lst, i, item)`**
Set the i-th item in ```lst``` to ```item```, with ```lst``` of type PTUPLE.

### Functions


### psequence_new(uint8_t*  type*, uint16_t*  elements*)
Create an empty sequence of type ```type``` with space for at least ```elements``` elements. If the requested sequence is mutable, sequence elements are set to 0; if it is immutable, sequence elementes are set to ```elements``` and the sequence storage filled with zero.

Return a pointer to the created sequence or NULL in case of failure.


### pstring_new(uint16_t*  len*, uint8_t*  \```buf```)
Create a sequence of type PSTRING with ```len``` elements. If ```buf``` is not NULL, ```len``` bytes from ```buf``` are used to initialize the string.

Return NULL on failure.


### pbytes_new(uint16_t*  len*, uint8_t*  \```buf```)
Create a sequence of type PBYTES with ```len``` elements. If ```buf``` is not NULL, ```len``` bytes from ```buf``` are used to initialize the sequence.

Return NULL on failure.


### pshorts_new(uint16_t*  len*, uint16_t*  \```buf```)
Create a sequence of type PSHORTS with ```len``` elements. If ```buf``` is not NULL, ```len``` words from ```buf``` are used to initialize the sequence.

Return NULL on failure.


### ptuple_new(uint16_t*  len*, PObject*  \*\```buf```)
Create a sequence of type PTUPLE with ```len``` elements. If ```buf``` is not NULL, ```len``` objects from ```buf``` are used to initialize the sequence.

Return NULL on failure.


### plist_new(uint16_t*  len*, PObject*  \*\```buf```)
Create a sequence of type PLIST with ```len``` elements. If ```buf``` is not NULL, ```len``` objects from ```buf``` are used to initialize the sequence. Sequence elements are set to ```len```.

Return NULL on failure.

## Dictionaries and Sets

Some data structures in Python have functionalities similar to hash tables. In particular dictionaries are mappings from keys to values; set and frozenset are collections of items optimized to test the presence of a given item inside the set.
Internally, the hash code of an item is calculated and used to find the item inside the structure in a fast way.

Dictionaries and sets must be created, managed and manipulated with the following functions and macros only. Set and dictionaries automatically grow as needed.

### Macros


### PHASH_ELEMENTS(obj)
Return the elements in ```obj``` with obj a PDICT, PSET or PFSET.


### PHASH_SIZE(obj)
Return the total space for itens in ```obj``` with obj a PDICT, PSET or PFSET.


### PCHECK_HASHABLE(obj)
Return true if ```obj``` is hashable, i.e. an hash can be calculated for ```obj```.


### pdict_put(f, k, v)
Add the hashable PObject ```k``` as a key and PObject ```v``` as value, in ```f``` of type PDICT.


### pset_put(f, k)
Add the hashable PObject ```k```  in ```f``` of type PSET.


### pdict_get(f, k)
Return the value associated with the hashable PObject ```k``` in ```f``` of type PDICT. Return NULL if ```k``` is not present.


### pset_get(f, k)
Return ```k``` if the hashable PObject ```k``` is in ```f``` of type PSET or PFSET. Return NULL if ```k``` is not present.


### pdict_del(f, k)
Remove ```k``` and its associated value from ```f``` of type PDICT. Return NULL if ```k``` is not present.


### pset_del(f, k)
Remove ```k``` from ```f``` of type PSET. Return NULL if ```k``` is not present.

### Functions


### pdict_new(int*  size*)
Create an empty dictionary with enough space to hold ```size``` pairs (key,value)

Return NULL on failure.


### pset_new(int*  type*, int*  size*)
Create an empty set or frozenset depending on ```type```, with enough space to contain ```size``` items.

Return NULL on failure.

## Exceptions

The following macros must be returned by functions declared with C_NATIVE to signal the result of the call and eventually rise an exception. Non builtin exception names can not be retrieved by VM system calls, so no exception macro exists; a workaround for this limitation is to pass exception names from Python and store them somewhere in a C structure to be raised when needed.


### ERR_OK()
Call successful.


### ERR_TYPE_EXC()
Raise TypeError.


### ERR_ZERODIV_EXC()
Raise ZeroDivisionError.


### ERR_ATTRIBUTE_EXC()
Raise AttributeError.


### ERR_RUNTIME_EXC()
Raise RuntimeError.


### ERR_VALUE_EXC()
Raise ValueError.


### ERR_INDEX_EXC()
Raise IndexError.


### ERR_KEY_EXC()
Raise KeyError.


### ERR_NOT_IMPLEMENTED_EXC()
Raise NotImplementedError.


### ERR_UNSUPPORTED_EXC()
Raise UnsupportedError.


### ERR_OVERFLOW_EXC()
Raise OverflowError.


### ERR_STOP_ITERATION()
Raise StopIteration.


### ERR_NAME_EXC()
Raise NameError.


### ERR_IOERROR_EXC()
Raise IOError.


### ERR_IOERROR_EXC()
Raise IOError.


### ERR_CONNECTION_REF_EXC()
Raise ConnectionRefusedError.


### ERR_CONNECTION_RES_EXC()
Raise ConnectionResetError.


### ERR_CONNECTION_ABR_EXC()
Raise ConnectionAbortedError.


### ERR_TIMEOUT_EXC()
Raise TimeoutError.


### ERR_PERIPHERAL_ERROR_EXC()
Raise PeripheralError.


### ERR_PERIPHERAL_INVALID_PIN_EXC()
Raise InvalidPinError.


### ERR_PERIPHERAL_INVALID_HARDWARE_STATUS_EXC()
Raise InvalidHardwareStatusError.


### ERR_PERIPHERAL_INITIALIZATION_ERROR()
Raise HardwareInitializationError.



<!--stackedit_data:
eyJoaXN0b3J5IjpbLTExODMxMjEwNzksNzI5OTc2NDM0LDg2Mj
c1MzQ3MywxMDUyMTg0OTc0XX0=
-->
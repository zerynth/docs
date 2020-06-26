<!-- _rtttl -->
# Zerynth RTTTL

Ring Tone Text Transfer Language (RTTTL) was developed by Nokia to be used to transfer ringtones of mobile phones.

The RTTTL format is a string divided into three sections: name, default value, and data.

The name section consists of a string describing the name of the ringtone. It can be no longer than 10 characters, and cannot contain a colon ”:” character (however, since the Smart Messaging specification allows names up to 15 characters in length, some applications processing RTTTL also do so).

The default value section is a set of values separated by commas, where each value contains a key and a value separated by an ”=” character, which describes certain defaults which should be adhered to during the execution of the ringtone. Possible names are:


* d - duration
* o - octave
* b - beat, tempo

The data section consists of a set of character strings separated by commas, where each string contains a duration, pitch, octave and optional dotting (which increases the duration of the note by one half).

Here below, the Zerynth Library for RTTTL melody player and some examples to better understand how to use it.

Contents:


* [RTTTL Library](https://docs.zerynth.com/latest/official/lib.zerynth.rtttl/docs/official_lib.zerynth.rtttl_rtttl.html)
* [Examples](https://docs.zerynth.com/latest/official/lib.zerynth.rtttl/examples/examples.html)
    * [RTTTL Basics](https://docs.zerynth.com/latest/official/lib.zerynth.rtttl/examples/examples.html#rtttl-basics)

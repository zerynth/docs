# RTTTL Library

This module contains class definitions for the “RTTTL” melody player to be used for driving buzzers or speakers connected to PWM pins.

The format of RTTTL notation is similar to the Music Macro Language found in BASIC implementations present on many early microcomputers. Various RTTTL melodies can be founded and downloaded [here](http://ez4mobile.com/nokiatone/rtttf.htm) and many other websites.

##### class tune

```#!py3 class tune(txt)```

This is the class for creating the melody to be played by the RTTTL player. The melody is passed as string

###### tune.play

```#!py3 play(pin, callback=None, restart=False)```

Starts playing the melody actuating the PWM on the selected pin.

It is also possible to pass a function as callback that will be called every time a note is played. The callback passes the played note to the called function.

Moreover, loop play is also possible by setting the restart parameter to True.


* pin: Dx.PWM, it is the pin where the buzzer is connected.
* callback: the function to be called every time a note is played. Played note will be passed to the called function.
* restart: it activates the playloop.

###### tune.setbpm

```#!py3 setbpm(bpm)```

Changes the melody speed.

bpm: RTTTL melodies include tempo definition in BPM, however through this function it is possible to manually change the melody speed.

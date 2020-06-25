<!-- _servo -->
# Zerynth Servo

Servo Motors are rotary or linear actuators that allow for precise control of angular or linear position, velocity and acceleration. Each Servo Motor consists of a suitable motor coupled to a sensor for position feedback. It also requires a relatively sophisticated controller, often a dedicated module designed specifically for use with Servo Motors.

This kind of motor is a closed-loop servomechanism that uses position feedback to control its motion and final position. The input to its control is a signal, either analogue or digital, representing the position commanded for the output shaft.

The motor is paired with some type of encoder to provide position and speed feedback. The measured position of the output is compared to the command position, the external input to the controller. If the output position differs from that required, an error signal is generated which then causes the motor to rotate in either direction, as needed to bring the output shaft to the appropriate position. As the positions approach, the error signal reduces to zero and the motor stops.

Servo Motors are used in applications such as robotics, CNC machinery or automated manufacturing.

Here below, the Zerynth Library for Servo Motors and some examples to better understand how to use it.

Contents:


* [Servo Library](https://docs.zerynth.com/latest/official/lib.zerynth.servo/docs/official_lib.zerynth.servo_servo.html)
    * [Servo class](https://docs.zerynth.com/latest/official/lib.zerynth.servo/docs/official_lib.zerynth.servo_servo.html#servo-class)
* [Examples](https://docs.zerynth.com/latest/official/lib.zerynth.servo/examples/examples.html)
    * [Servo Motor Basics](https://docs.zerynth.com/latest/official/lib.zerynth.servo/examples/examples.html#servo-motor-basics)
    * [Servo Motor Animation](https://docs.zerynth.com/latest/official/lib.zerynth.servo/examples/examples.html#servo-motor-animation)

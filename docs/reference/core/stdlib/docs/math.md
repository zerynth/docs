# Math

This module implements various mathematical functions.

Except when explicitly noted otherwise, all return values are floats. The underlying implementations works on double precision floats that are converted back to single precision if the VM does not support double precision.

No exceptions are raised: in case of error, the return value can be infinite or NaN. Such cases can be checked with the provided functions.

The following constants are defined:


* `pi` 3.14159265


* `e`  2.71828182


---
#### `#!py3 tan()`

!!!abstract "`#!py3 tan(x)`"

Return the tangent of ```x``` radians.


---
#### `#!py3 cos()`

!!!abstract "`#!py3 cos(x)`"

Return the cosine of ```x``` radians.


---
#### `#!py3 sin()`

!!!abstract "`#!py3 sin(x)`"

Return the sine of ```x``` radians.


---
#### `#!py3 atan2()`

!!!abstract "`#!py3 atan2(y, x)`"

Return `atan(y / x)`, in radians. The result is between `-pi` and `pi`.
The vector in the plane from the origin to point `(x, y)` makes this angle
with the positive X axis. The point of `atan2()` is that the signs of both
inputs are known to it, so it can compute the correct quadrant for the angle.
For example, `atan(1)` and `atan2(1, 1)` are both `pi/4`, but `atan2(-1,
-1)` is `-3\*pi/4`.


---
#### `#!py3 atan()`

!!!abstract "`#!py3 atan(x)`"

Return the arc tangent of ```x```, in radians.


---
#### `#!py3 acos()`

!!!abstract "`#!py3 acos(x)`"

Return the arc cosine of ```x```, in radians.


---
#### `#!py3 asin()`

!!!abstract "`#!py3 asin(x)`"

Return the arc sine of ```x```, in radians.


---
#### `#!py3 degress()`

!!!abstract "`#!py3 degress(rad)`"

Converts ```rad``` from radians to degrees.


---
#### `#!py3 radians()`

!!!abstract "`#!py3 radians(degree)`"

Converts ```degree``` from degrees to radians.


---
#### `#!py3 exp()`

!!!abstract "`#!py3 exp(x)`"

Return `e\*\*x`.


---
#### `#!py3 log()`

!!!abstract "`#!py3 log(x, )`"

With one argument or with ```base``` non positive, return the natural logarithm of ```x``` (to base ```e```).

With two arguments, return the logarithm of ```x``` to the given ```base```,
calculated as `log(x)/log(base)`.


---
#### `#!py3 pow()`

!!!abstract "`#!py3 pow(x, y)`"

Return `x` raised to the power `y`.

Unlike the built-in `\*\*` operator, `math.pow()` converts both
its arguments to type `float()`.  Use `\*\*` or the built-in
`pow()` function for computing exact integer powers.


---
#### `#!py3 sqrt()`

!!!abstract "`#!py3 sqrt(x)`"

Return the square root of ```x```.


---
#### `#!py3 isnan()`

!!!abstract "`#!py3 isnan(x)`"

Return `True` if ```x``` is a NaN (not a number), and `False` otherwise.


---
#### `#!py3 isinf()`

!!!abstract "`#!py3 isinf(x)`"

Return `True` if ```x``` is a positive or negative infinity, and
`False` otherwise.


---
#### `#!py3 floor()`

!!!abstract "`#!py3 floor(x)`"

Return the floor of ```x```, the largest integer less than or equal to ```x```.


---
#### `#!py3 ceil()`

!!!abstract "`#!py3 ceil(x)`"

Return the ceiling of ```x```, the smallest integer greater than or equal to ```x```.

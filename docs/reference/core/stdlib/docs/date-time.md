# Date and time

This module supplies classes for manipulating dates, times, and deltas. It represents a minimalistic implementation of Python module  [datetime](https://docs.python.org/3/library/datetime.html).

[`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  objects may be categorized as “aware” or “naive” depending on whether or not they include timezone information. An aware object can locate itself relative to other aware objects. An  _aware_  object represents a specific moment in time that is not open to interpretation.

A  _naive_  object does not contain enough information to unambiguously locate itself relative to other  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  objects. Whether a naive object represents Coordinated Universal Time (UTC), local time, or time in some other timezone is purely up to the program, just like it is up to the program whether a particular number represents metres, miles, or mass. Naive objects are easy to understand and to work with, at the cost of ignoring some aspects of reality.

For applications requiring aware objects,  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  objects have an optional time zone information attribute,  _tzinfo_, that can be set to an instance of a  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  class. These objects capture information about the offset from UTC time and the time zone name.

The following classes are provided:

-   [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")
-   [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")
-   [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")

## timedelta Objects

A  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object represents a duration, the difference between two dates or times. With respect to the Python module  [datetime](https://docs.python.org/3/library/datetime.html), this implementation is constrained as follows:

> -   Minimum resolution is  _1 second_, instead of  _1 microsecond_.
> -   Arithmetic is done via direct function calls ([`add()`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.add "datetime.add")  vs  `__add__()`) due to Zerynth’s limits.

### Class attributes

`timedelta.``MINYEAR`

The year of  [`timedelta.min`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta.min "datetime.timedelta.min"), i.e.  `timedelta.min.tuple()[1]  //  (365×24×60×60)  ==  -34`.

`timedelta.``MAXYEAR`

The year of  [`timedelta.max`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta.max "datetime.timedelta.max"), i.e.  `timedelta.max.tuple()[1]  //  (365×24×60×60)  ==  34`.

`timedelta.``min`

The most negative  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object,  `timedelta(-2**30)`.

`timedelta.``max`

The most positive  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object,  `timedelta(2**30  -  1)`.

`timedelta.``resolution`

The smallest possible difference between non-equal  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  objects,  `timedelta(seconds=1)`.

### Class methods

_class_`timedelta`(_hours=0_,  _minutes=0_,  _seconds=0_,  _days=0_,  _weeks=0_)

All arguments are optional and default to  `0`. Arguments may be integers or floats, and may be positive or negative. Only seconds are stored internally. Arguments are converted to those units:

> -   A minute is converted to 60 seconds.
> -   An hour is converted to 3600 seconds.
> -   A week is converted to 7 days.

If no argument is a float, the conversion and normalization processes are exact (no information is lost).

`total_seconds`()

Return the total number of seconds contained in the duration.

`add`(_other_)

Return the difference between two durations.

`mul`(_other_)

Return a delta multiplied by an integer or float. The result is rounded to the nearest second using round-half-to-even.

`truediv`(_other_)

When  _other_  is a float or an integer, returns a delta divided by  _other_. The result is rounded to the nearest multiple of timedelta.resolution using round-half-to-even.

When  _other_  is a delta, division of overall duration by interval unit  _other_. Returns a float object.

`floordiv`(_other_)

The floor is computed and the remainder (if any) is thrown away. When  _other_  is a delta, an integer is returned.

`mod`(_other_)

The remainder is computed as a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object.

`divmod`(_other_)

Computes the quotient and the remainder:  `q  =  td1.floordiv(td2)`  and  `r  =  td1.mod(td2)`.  `q`  is an integer and  `r`  is a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object.

`neg`()

Equivalent to  `td1.mul(-1)`.

`eq`(_other_)

Equivalent to  `td1.total_seconds()  ==  td2.totalseconds()`.

`le`(_other_)

Equivalent to  `td1.total_seconds()  <=  td2.totalseconds()`.

`lt`(_other_)

Equivalent to  `td1.total_seconds()  <  td2.totalseconds()`.

`ge`(_other_)

Equivalent to  `td1.total_seconds()  >=  td2.totalseconds()`.

`gt`(_other_)

Equivalent to  `td1.total_seconds()  >  td2.totalseconds()`.

`bool`()

Return  `False`  when duration is  `0`.

`abs`()

Return a positive delta.

`tuple`(_sign_pos=''_)

Return the tuple  `(sign,  days,  hours,  minutes,  seconds)`, where  `sign`  is  `-`  if delta is negative,  _sign_pos_  otherwise.

### Examples of usage

An example of normalization:

```python
import datetime.timedelta

# Components of another_year add up to exactly 365 days
year = timedelta(days=365)
another_year = timedelta(weeks=40, days=84, hours=23, minutes=50, seconds=600)
print(year.eq(another_year)) # True
print(year.total_seconds())  # 31536000
```

Examples of timedelta arithmetic:

```python
import datetime.timedelta

year = timedelta(days=365)
ten_years = year.mul(10)
print(ten_years)                    # 3650d 00:00:00
nine_years = ten_years.sub(year)
print(nine_years)                   # 3285d 00:00:00
three_years = nine_years.floordiv(3)
print(three_years)                  # 1095d 00:00:00
```

## timezone Objects

The  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  class represents a timezone defined by a fixed offset from UTC. Define a subclass of  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  to capture information about a particular time zone.

An instance of  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  can be passed to the constructors for  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime"). The latter objects view their attributes as being in local time, and the  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  object supports methods revealing offset of local time from UTC, the name of the time zone, and DST offset, all relative to a date-time object passed to them.

### Methods to customize

A subclass of  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  may need to override the following methods. Exactly which methods are needed depends on the uses made of aware  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  objects. If in doubt, simply implement all of them.

`utcoffset`(_dt_)

Return offset of local time from UTC, as a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object that is positive east of UTC. If local time is west of UTC, this should be negative.

This represents the  _total_  offset from UTC; for example, if a  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  object represents both time zone and DST adjustments,  `timezone.utcoffset()`  should return their sum. If the UTC offset isn’t known, return  `None`. Else the value returned must be a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object strictly between  `timedelta(hours=-24)`  and  `timedelta(hours=24)`  (the magnitude of the offset must be less than one day). Most implementations of  `timezone.utcoffset()`  will probably look like one of these two:

> return CONSTANT # fixed-offset class return CONSTANT + self.dst(dt) # daylight-aware class

If  `timezone.utcoffset()`  does not return  `None`,  `timezone.dst()`  should not return None either.

The default implementation of  `timezone.utcoffset()`  returns the sum of time zone and DST adjustments, if available.

`dst`(_dt_)

Return the daylight saving time (DST) adjustment, as a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object or  `None`  if DST information isn’t known.

Return  `timedelta(0)`  if DST is not in effect. If DST is in effect, return the offset as a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object (see  `timezone.utcoffset()`  for details). Note that DST offset, if applicable, has already been added to the UTC offset returned by  `timezone.utcoffset()`, so there’s no need to consult  `timezone.dst()`  unless you’re interested in obtaining DST info separately.

Most implementations of  `timezone.dst()`  will probably look like one of these two:

```python
def dst(self, dt):
    # a fixed-offset class:  doesn't account for DST
    return timedelta(0)
```

or:

def dst(self, dt):
    # Code to set dston and dstoff to the time zone's DST
    # transition times based on the input *dt*'s year, and
    # expressed in standard local time.

    dt_ = dt.replace(tzinfo=None)
    if dt_.ge(dston) and dt_.lt(dstoff):
        return timedelta(hours=1)
    else:
        return timedelta(0)

The default implementation of  `timezone.dst()`  returns  `None`.

`tzname`(_dt_)

Return the time zone name corresponding to the  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  object  _dt_, as a string. Nothing about string names is defined by the  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  module, and there’s no requirement that it mean anything in particular. For example, “GMT”, “UTC”, “-500”, “-5:00”, “EDT”, “US/Eastern”, “America/New York” are all valid replies. Return  `None`  if a string name isn’t known. Note that this is a method rather than a fixed string primarily because some  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  subclasses will wish to return different names depending on the specific value of  _dt_  passed, especially if the  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  class is accounting for daylight time.

The default implementation of  `timezone.tzname()`  returns the fixed value specified when the  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  instance is constructed. If  _name_  is not provided in the constructor, the name returned by  `tzname()`  is generated from the value of the  `offset`  as follows. If  _offset_  is  `timedelta(0)`, the name is “UTC”, otherwise it returns the string provided by  `timezone.isoformat()`  method.

These methods are called by a  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  object, in response to their methods of the same names. A  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  object passes  _self_  as  _dt_  argument.

### Class attributes

`timezone.``utc`

The UTC timezone,  `timezone(timedelta(0))`.

### Class methods

_class_`timezone`(_offset_,  _name=None_)

The  _offset_  argument must be specified as a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object representing the difference between the local time and UTC. It must be strictly between  `timedelta(hours=-24)`  and  `timedelta(hours=24)`, otherwise  `ValueError`  is raised.

The  _name_  argument is optional. If specified it must be a string that will be used as the value returned by the  [`datetime.tzname()`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.tzname "datetime.tzname")  method.

`isoformat`(_dt_)

Return a string in the format  `UTC±HH:MM`, where  `±`  is the sign of  _offset_  from UTC,  `HH`  and  `MM`  are two digits of offset’s hours and offset’s minutes respectively. If  _offset_  is  `timedelta(0)`, “UTC” is returned.

If  _utc_  is  `False`, this method always returns  `±HH:MM`.

_dt_  is needed in determining the right offset; it can be  `None`.

### Examples of usage

[Central European Time](https://en.wikipedia.org/wiki/Summer_time_in_Europe)  (CET), used in most parts of Europe and a few North African countries, is a standard time which is 1 hour ahead of Coordinated Universal Time (UTC). As of 2011, all member states of the European Union observe summer time; those that during the winter use CET use Central European Summer Time (CEST) (or: UTC+02:00, daylight saving time) in summer (from last Sunday of March to last Sunday of October).

import datetime

class cet(datetime.timezone):
    def __init__(self):
        datetime.timezone.__init__(self, datetime.timedelta(hours=1))

    def dst(self, dt):
        return datetime.timedelta(hours=1) if self.isdst(dt) else datetime.timedelta(0)

    def tzname(self, dt):
        return 'CEST' if self.isdst(dt) else 'CET'

    def isdst(self, dt):
        if dt is None:
            return False
        dt_ = dt.replace(tzinfo=None)
        year = dt.tuple()[0]
        day = 31 - (5*year//4 + 4) % 7 # last Sunday of March
        dst = dt_.replace(month=3, day=day)
        if dt_.lt(dst):
            return False
        day = 31 - (5*year//4 + 1) % 7 # last Sunday of October
        dst = dt_.replace(month=10, day=day)
        if dt_.lt(dst):
            return True
        return False

tz = cet()
print(tz.isoformat(datetime(2011, 1, 1))) # UTC+01:00
print(tz.tzname   (datetime(2011, 1, 1))) # CET
print(tz.isoformat(datetime(2011, 8, 1))) # UTC+02:00
print(tz.tzname   (datetime(2011, 8, 1))) # CEST

## datetime Objects

A  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  object is a single object containing all the information for specifying an absolute date and time point.

[`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  assumes the current Gregorian calendar extended in both directions, past and future. January 1 of year 1 is called day number 1, January 2 of year 1 is called day number 2, and so on.

[`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  assumes there are exactly 3600*24 seconds in every day and subject to adjustment via a  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  object.

### Constructors

_class_`datetime`(_self_,  _year_,  _month_,  _day_,  _hour=0_,  _minute=0_,  _second=0_,  _tzinfo=None_)

The  _year_,  _month_  and  _day_  arguments are required.  _tzinfo_  may be  `None`, or an instance of a  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  class. The remaining arguments must be integers in the following ranges:

-   `MINYEAR  <=  year  <=  MAXYEAR`,
-   `1  <=  month  <=  12`,
-   `1  <=  day  <=  number  of  days  in  the  given  month  and  year`,
-   `0  <=  hour  <  24`,
-   `0  <=  minute  <  60`,
-   `0  <=  second  <  60`,

If an argument outside those ranges is given,  `ValueError`  is raised.

`fromisoformat`(_date_string_)

Return a  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  corresponding to a  _date_string_  in the format emitted by  [`datetime.isoformat()`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.isoformat "datetime.isoformat").

Specifically, this function supports strings in the format:

YYYY-MM-DD[*HH[:MM[:SS[.fff[fff]]]][+HH:MM[:SS[.ffffff]]]]

where  `*`  can match any single character.

`fromordinal`(_n_)

Return the  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  corresponding to the proleptic Gregorian ordinal, where January 1 of year 1 has ordinal 1.  `ValueError`  is raised unless  `1  <=  ordinal  <=  datetime.max.toordinal()`. The hour, minute and second of the result are all 0, and  _tzinfo_  is  `None`.

### Class attributes

`datetime.``MINYEAR`

The smallest year number allowed in a  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  object.  [`datetime.MINYEAR`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.datetime.MINYEAR "datetime.datetime.MINYEAR")  is  `1`.

`datetime.``MAXYEAR`

The largest year number allowed in a  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  object.  [`datetime.MAXYEAR`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.datetime.MAXYEAR "datetime.datetime.MAXYEAR")  is  `9999`.

### Class methods

`add`(_other_)

In the expression  `datetime2  =  datetime1.add(timedelta)`,  `datetime2`  is a duration of  `timedelta`  removed from  `datetime1`, moving forward in time if  `timedelta  >  0`, or backward if  `timedelta  <  0`. The result has the same  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  attribute as the input  `datetime1`, and  `datetime2  -  datetime1  ==  timedelta`  after.

Note that no time zone adjustments are done even if the input is an aware object.

`sub`(_other_)

If  _other_  is an instance of  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta"), the expression  `datetime2  =  datetime1.sub(timedelta)`  computes the  `datetime2`  such that  `datetime2  +  timedelta  ==  datetime1`. As for addition, the result has the same  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  attribute as the input  `datetime1`, and no time zone adjustments are done even if the input is aware.

If  _other_  is an instance of  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime"), subtraction  `timedelta  =  datetime2.sub(datetime1)`  is defined only if both operands are naive, or if both are aware. If one is aware and the other is naive,  `TypeError`  is raised.

If both are naive, or both are aware and have the same  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  attribute, the  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  attributes are ignored, and the result is a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object  _t_  such that  `datetime2  +  t  ==  datetime1`. No time zone adjustments are done in this case.

If both are aware and have different  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  attributes,  `a-b`  acts as if  _a_  and  _b_  were first converted to naive UTC datetimes first.

`lt`(_other_)

Equivalent to  `dt1.toordinal()  <  dt2.toordinal()`.

`lt`(_other_)

Equivalent to  `dt1.toordinal()  <=  dt2.toordinal()`.

`lt`(_other_)

Equivalent to  `dt1.toordinal()  ==  dt2.toordinal()`.

`lt`(_other_)

Equivalent to  `dt1.toordinal()  >=  dt2.toordinal()`.

`lt`(_other_)

Equivalent to  `dt1.toordinal()  >  dt2.toordinal()`.

`utcoffset`()

If  _tzinfo_  is  `None`, returns  `None`, else returns a  [`timedelta`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timedelta "datetime.timedelta")  object with magnitude less than one day.

`replace`(_year=None_,  _month=None_,  _day=None_,  _hour=None_,  _minute=None_,  _second=None_,  _tzinfo=True_)

Return a  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  with the same attributes, except for those attributes given new values by whichever keyword arguments are specified. Note that  `tzinfo=None`  can be specified to create a naive  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  from an aware  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  with no conversion of date and time data.

`astimezone`(_tz_)

Return a  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  object with new  _tzinfo_  attribute  _tz_, adjusting the date and time data so the result is the same UTC time as  _self_, but in  _tz_’s local time.  _self_  must be aware.

If you merely want to attach a  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  object  _tz_  to a  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  _dt_  without adjustment of date and time data, use  `dt.replace(tzinfo=tz)`. If you merely want to remove the  [`timezone`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.timezone "datetime.timezone")  object from an aware  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  _dt_  without conversion of date and time data, use  `dt.replace(tzinfo=None)`.

`isoformat`(_sep='T'_)

Return a string representing the date and time in ISO 8601 format  `YYYY-MM-DDTHH:MM:SS`. If  [`datetime.utcoffset()`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#datetime.utcoffset "datetime.utcoffset")  does not return  `None`, a string is appended, giving the UTC offset:  `YYYY-MM-DDTHH:MM:SS+HH:MM`.

`toordinal`()

Return the proleptic Gregorian ordinal of the date.

`isoweekday`()

Return the day of the week as an integer, where Monday is 1 and Sunday is 7. For example,  `date(2002,  12,  4).isoweekday()  ==  3`, a Wednesday.

`tuple`()

Return the tuple  `(year,  month,  day,  hour,  minute,  second,  tzinfo)`.

### Examples of usage

Examples of working with  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  objects:

from datetime import timedelta, timezone, datetime, fromisoformat

print(datetime(2005, 7, 14, 12, 30))            # 2005-07-14 12:30:00
dt = fromisoformat('2006-11-21 16:30+01:00')
print(dt.add(timedelta(hours=23)))              # 2006-11-22 15:30:00+01:00
tz1 = timezone(timedelta(hours=4, minutes=30))
print(tz1)                                      # UTC+04:30
dt = datetime(1900, 11, 21, 3, 30, tzinfo=tz1)
print(dt)                                       # 1900-11-21 03:30:00+04:30
print(dt.astimezone(timezone.utc))              # 1900-11-20 23:00:00+00:00
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTE2NzA5OTAxNSwtMTMyMjQ0NDQxM119
-->
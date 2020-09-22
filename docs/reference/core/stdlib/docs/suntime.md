# Sunrise and sunset time

Approximated calculation of sunrise and sunset time. Adapted from  [https://github.com/SatAgro/suntime](https://github.com/SatAgro/suntime).

## Class methods

_class_`Sun`(_latitude_,  _longitude_)

Arguments  _latitude_  and  _longitude_  are floats representing the coordinates of a place on Earth.

`get_sunrise_time`(_year_,  _month_,  _day_)

Calculate the sunrise time for the given date. It returns a tuple of integers  `(hour,  minute)`  in UTC time or  `None`  if sun doesn’t raise on that location at the given date.

`get_sunset_time`(_year_,  _month_,  _day_)

Calculate the sunset time for the given date. It returns a tuple of integers  `(hour,  minute)`  in UTC time or  `None`  if sun doesn’t set on that location at the given date.

## Examples of usage

This example calculates sunrise and sunset of three major cities:

```python
import suntime

test('suntime: example')

Rome     = suntime.Sun( 41.902782 , 12.496366 )
Warsaw   = suntime.Sun( 51.21     , 21.01     )
CapeTown = suntime.Sun(-33.9252192, 18.4240762)

dt1 = (2000, 1, 1)
sr1 = Rome.get_sunrise_time(*dt1) # (6, 38)
ss1 = Rome.get_sunset_time (*dt1) # (15, 49)
print('Rome:', sr1, ss1)

dt2 = (2014, 10, 3)
sr2 = Warsaw.get_sunrise_time(*dt2) # (4, 39)
ss2 = Warsaw.get_sunset_time (*dt2) # (16, 10)
print('Warsaw:', sr2, ss2)

dt3 = (2016, 12, 21)
sr3 = CapeTown.get_sunrise_time(*dt3) # (3, 32)
ss3 = CapeTown.get_sunset_time (*dt3) # (17, 57)
print('Cape Town:', sr3, ss3)
```

If  [`datetime`](https://oldtestdocs.zerynth.com/latest/official/core.zerynth.stdlib/docs/official_core.zerynth.stdlib_datetime.html#module-datetime "datetime")  module is available, results above can be expressed in local time:

```python
import datetime as datetimelib

timedelta = datetimelib.timedelta
timezone  = datetimelib.timezone
datetime  = datetimelib.datetime

utc = timezone.utc
tz1 = timezone(timedelta(hours=1))
tz2 = timezone(timedelta(hours=3))
tz3 = timezone(timedelta(hours=2))

# https://www.timeanddate.com/sun/italy/rome?month=1&year=2000
print('Rome:')
rt1 = datetime(*dt1, *sr1, tzinfo=utc).astimezone(tz1) # 2000-01-01 07:38:00+01:00
st1 = datetime(*dt1, *ss1, tzinfo=utc).astimezone(tz1) # 2000-01-01 16:49:00+01:00
print('>', rt1)
print('>', st1)

# https://www.timeanddate.com/sun/poland/warsaw?month=10&year=2014
print('Warsaw:')
rt2 = datetime(*dt2, *sr2, tzinfo=utc).astimezone(tz2) # 2014-10-03 07:39:00+03:00
st2 = datetime(*dt2, *ss2, tzinfo=utc).astimezone(tz2) # 2014-10-03 19:10:00+03:00
print('>', rt2)
print('>', st2)

# https://www.timeanddate.com/sun/south-africa/cape-town?month=12&year=2016
print('Cape Town:')
rt3 = datetime(*dt3, *sr3, tzinfo=utc).astimezone(tz3) # 2016-12-21 05:32:00+02:00
st3 = datetime(*dt3, *ss3, tzinfo=utc).astimezone(tz3) # 2016-12-21 19:57:00+02:00
print('>', rt3)
print('>', st3)
```
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE5NjE5ODE2NzddfQ==
-->
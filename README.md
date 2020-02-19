
# Time.ABAP

An ABAP library which lets ABAP developers perform date and time comparisons using unix timestamps.

## Initialization

There are 3 static constructors provided in class `YEA_TIME`:

### Now

Create a timestamp which represents the date/time at now. 

```abap
data(now) = yea_time=>now( ). " Using SY-ZONLO
data(now) = yea_time=>now( 'CET' ). " Using Central European Time"
```

### Unix Timestamp

Create a timestamp using a unix timestamp (the time that has passed since 01-01-1970 UTC).

```javascript
const now = new Date()
console.log(now)
// -> 2020-02-19T10:29:14.410Z
console.log(now.getTime())
// -> 1582108154410
```

```abap
data(unix_ts) = yea_time=>from_unix( 1582108154410 )
write : / unix_ts->iso( ).
# -> 2020-02-19T10:29:14+00:00
```

### ABAP Date/time

Creates a timestamp using the date, time, and timezone from ABAP. Be aware that if you use a timezone here the function assumes you mean that date/time in that timezone. (e.g. 11:00CET will be 11:00CET and 10:00UTC. 11:00UTC will be 12:00CET).

```abap
data(now_abap) = yea_time=>from_abap(
    date = sy-datum
    time = sy-uzeit
    timezone = 'CET'
).
write : / now_abap->iso( ).
# -> 2020-02-19T11:38:17+01:00
```

## API

### Retrevial

* `get_unix( )`: Returns a unix timestamp in milliseconds. Unix timestamps are always UTC.
* `get_date( )`: Returns an ABAP `datum`. The output is dependent on the timezone.
* `get_time( )`: Returns an ABAP `uzeit`. The output is dependent on the timezone.
* `get_zone( )`: Returns the timezone this instance is set too
* `get_delta( )`: Returns the timezone difference, if it's plus or minus from UTC.
* `get_day( )`: Returns a numeric day value, between 0 to 31 (depending on month)
* `get_month( )`: Returns a numeric month value, between 0 to 12.
* `get_year( )`: Returns the numeric year value. 
* `get_hour( )`: Returns the numeric hour value, between 0 to 23. 
* `get_minute( )`: Returns the numeric minute value, between 0 to 59.
* `get_second( )`: Returns the numeric second value, between 0 to 59.
* `get_day_string( lang )`: Returns a string representation of the day of the week, language dependent. 
* `get_month_string( lang )`: Returns a string representation of the month, language dependent.
* `iso( )`: ISO 8601 string representation. See: https://en.wikipedia.org/wiki/ISO_8601

### Mutations

* `set_timezone( timezone )`: Change the timezone of the timestamp. This won't change the unix timestamp, but will adjust the ABAP/DATE output.
```abap
data(time_original) = yea_time=>now( ).
data(time_copy) = time_original->copy( ).
time_copy->set_timezone( 'UTC' ).
write : / time_original->get_zone( ), time_original->iso( ).
" -> CET   2020-02-19T12:36:14+01:00
write : / time_copy->get_zone( ), time_copy->iso( ).
" -> UTC   2020-02-19T11:36:41+00:00
```
* `add_seconds( n )`: Add N seconds (negative for subtraction). Changes the timestamp.
```abap
data(time) = yea_time=>now( ).
write : / time->iso( ).
" -> 2020-02-19T12:22:28+01:00
time->add_seconds( 120 ).
write : / time->iso( ).
" -> 2020-02-19T12:24:28+01:00
```
* `add_minutes( n )`: Add N minutes (negative for subtraction). Changes the timestamp.
* `add_hours( n )`: Add N hours (negative for subtraction). Changes the timestamp.
* `add_days( n )`: Add N days (negative for subtraction). Changes the timestamp.
* `copy( time )`: Creates a new instance, copied from the current instance. Modifying the new timestamp won't change this instance.

### Comparisons

These functions use the unix timestamp for comparison. 

* `equal( time )`: Checks if these two timestamps have the same UTC time (e.g. 11:00UTC is the same time as 12:00CET).
* `greater_than( time )`: Checks if this timestamp is greater than the input timestamp. Check is exclusive.
* `greater_than_equal( time )`: Checks if this timestamp is greater than the input. Check is inclusive.
* `lesser_than( time )`: Checks if this timestamp is less than the input timestamp. Check is exclusive.
* `lesser_than_equal( time )`: Check if the timestamp is less than the input timestamp. Check is inclusive. 


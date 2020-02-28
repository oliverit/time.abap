class YEA_TIME definition
  public
  final
  create public .

public section.

  class-methods FROM_UNIX
    importing
      !TIMESTAMP type YEA_TS
    returning
      value(RETURNING) type ref to YEA_TIME .
  class-methods FROM_ABAP
    importing
      !DATE type DATUM
      !TIME type UZEIT
      !TIMEZONE type SYST_ZONLO
    returning
      value(RETURNING) type ref to YEA_TIME .
  class-methods FROM_NOW
    importing
      !TIMEZONE type SYST_ZONLO default SY-ZONLO
    returning
      value(RETURNING) type ref to YEA_TIME .
  class-methods FROM_TIMESTAMP
    importing
      !TIMESTAMP type TIMESTAMP
      !TIMEZONE type SY-ZONLO
    returning
      value(RETURNING) type ref to YEA_TIME .
  class-methods FROM_TIMESTAMPL
    importing
      !TIMESTAMP type TIMESTAMPL
      !TIMEZONE type SY-ZONLO
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods UNIX
    returning
      value(RETURNING) type YEA_TS .
  methods DATE
    returning
      value(RETURNING) type DATUM .
  methods TIME
    returning
      value(RETURNING) type UZEIT .
  methods SET_TIMEZONE
    importing
      !TIMEZONE type SYST_ZONLO .
  methods ADD_SECONDS
    importing
      !SECONDS type INT4 .
  methods ADD_MINUTES
    importing
      !MINUTES type INT4 .
  methods ADD_HOURS
    importing
      !HOURS type INT4 .
  methods ADD_DAYS
    importing
      !DAYS type INT4 .
  methods TZ
    returning
      value(RETURNING) type SYST_ZONLO .
  methods DELTA
    returning
      value(RETURNING) type INT4 .
  methods DISTANCE
    returning
      value(RETURNING) type INT4 .
  methods COPY
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods EQUAL
    importing
      !OTHER_TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods GREATER_THAN
    importing
      !OTHER_TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods LESSER_THAN
    importing
      !OTHER_TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods GREATER_THAN_EQUAL
    importing
      !OTHER_TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods LESSER_THAN_EQUAL
    importing
      !OTHER_TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods DAY
    returning
      value(RETURNING) type INT4 .
  methods WEEK
    returning
      value(RETURNING) type INT4 .
  methods MONTH
    returning
      value(RETURNING) type INT4 .
  methods YEAR
    returning
      value(RETURNING) type INT4 .
  methods HOUR
    returning
      value(RETURNING) type INT4 .
  methods MINUTE
    returning
      value(RETURNING) type INT4 .
  methods SECOND
    returning
      value(RETURNING) type INT4 .
  methods WEEKDAY
    returning
      value(RETURNING) type INT4 .
  methods DAY_STRING
    importing
      !LANG type SY-LANGU default SY-LANGU
    returning
      value(RETURNING) type STRING .
  methods MONTH_STRING
    importing
      !LANG type SY-LANGU default SY-LANGU
    returning
      value(RETURNING) type STRING .
  methods ISO
    returning
      value(RETURNING) type STRING .
  methods START_OF_DAY
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods END_OF_DAY
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods START_OF_WEEK
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods END_OF_WEEK
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods START_OF_MONTH
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods END_OF_MONTH
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods START_OF_YEAR
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods END_OF_YEAR
    returning
      value(RETURNING) type ref to YEA_TIME .
protected section.
private section.

  data UNIXTIME type YEA_TS .
  data TIMEZONE type SYST_ZONLO .
  data ABAPDATE type DATUM .
  data ABAPTIME type UZEIT .
  data DB_TTZZ type YEA_TTZZ .

  methods ADJUST_ABAP_DATETIME .
ENDCLASS.



CLASS YEA_TIME IMPLEMENTATION.


  method ADD_DAYS.
    me->add_hours( days * 24 ).
  endmethod.


  method ADD_HOURS.
    me->add_minutes( hours * 60 ).
  endmethod.


  method ADD_MINUTES.
    me->add_seconds( minutes * 60 ).
  endmethod.


  method ADD_SECONDS.
    me->unixtime = me->unixtime + ( seconds * 1000 ).
    me->adjust_abap_datetime( ).
  endmethod.


  method ADJUST_ABAP_DATETIME.
    data utc_date type datum.
    data utc_time type uzeit.
    cl_pco_utility=>convert_java_timestamp_to_abap(
      exporting iv_timestamp = conv #( me->unixtime )
      importing ev_date = utc_date
                ev_time = utc_time
    ).
    data abap_ts type timestampl.
    convert
      date utc_date
      time utc_time
      into time stamp abap_ts
      time zone 'UTC'.
    convert
      time stamp abap_ts
      time zone me->db_ttzz-tzone
      into date me->abapdate
           time me->abaptime.
  endmethod.


  method COPY.
    data(new_time) = new yea_time( ).
    new_time->unixtime = me->unixtime.
    new_time->timezone = me->timezone.
    new_time->abapdate = me->abapdate.
    new_time->abaptime = me->abaptime.
    new_time->db_ttzz = me->db_ttzz.
    returning = new_time.
  endmethod.


  method DATE.
    returning = me->abapdate.
  endmethod.


  method DAY.
    returning = abapdate+6(2).
  endmethod.


  method DAY_STRING.
    data long type t246-langt.
    data short type t246-kurzt.
    data outlang type sy-langu.
    call function 'GET_WEEKDAY_NAME'
      exporting date = me->abapdate
                language = lang
      importing langu_back = outlang
                longtext = long
                shorttext = short
     exceptions others = 1.
    returning = long.
  endmethod.


  method DELTA.
    returning = me->db_ttzz-delta.
    if ( me->db_ttzz-delta = '-' ).
      returning = 0 - returning.
    endif.
  endmethod.


  method DISTANCE.
  endmethod.


  method END_OF_DAY.
    returning = from_abap(
      date = abapdate
      time = '235959'
      timezone = timezone
    ).
  endmethod.


  method END_OF_MONTH.
    data(month_date) = me->abapdate.
    " Increase month by 1
    month_date+4(2) = me->month( ) + 1.
    " And set the day to the first month of the next month
    month_date+6(2) = 1.

    month_date = month_date - 1.
    returning = yea_time=>from_abap(
      date = month_date
      time = '235959'
      timezone = me->timezone
    ).
  endmethod.


  method END_OF_WEEK.
    data abapdate type scal-date.
    call function 'WEEK_GET_FIRST_DAY'
      exporting week = conv scal-week( me->week( ) )
      importing date = abapdate.
    abapdate = abapdate + 6.
    returning = yea_time=>from_abap(
      date = abapdate
      time = '235959'
      timezone = me->timezone
    ).
  endmethod.


  method END_OF_YEAR.
    data(month_date) = conv datum( |{ me->year( ) }{ 12 }{ 31 } | ).
    returning = yea_time=>from_abap(
      date = month_date
      time = '235959'
      timezone = me->timezone
    ).
  endmethod.


  method EQUAL.
    data is_equal type boolean.
    if ( other_time is not bound ).
      is_equal = abap_false.
    else.
      if ( other_time->unixtime = me->unixtime ).
        is_equal = abap_true.
      endif.
    endif.
    returning = is_equal.
  endmethod.


  method FROM_ABAP.
    data timezone_sec type p length 6.
    data unix_sec type p length 6.
    data(new_date) = new yea_time( ).
    new_date->set_timezone( timezone ).
    data(tzhours)   = new_date->db_ttzz-delta+0(2).
    data(tzminutes) = new_date->db_ttzz-delta+2(2).
    data(tzseconds) = new_date->db_ttzz-delta+4(2).
    data delta_seconds type p length 6.
    delta_seconds = tzseconds + ( tzminutes * 60 ) + ( ( tzhours * 60 ) * 60 ).
    if ( new_date->db_ttzz-direction = '+' ).
      delta_seconds = delta_seconds * -1.
    endif.
    perform date_time_to_p6 in program rstr0400 using date time unix_sec delta_seconds.
    new_date->timezone = timezone.
    new_date->unixtime = unix_sec * 1000.
    new_date->abapdate = date.
    new_date->abaptime = time.
    returning = new_date.
  endmethod.


  method FROM_NOW.
    returning = yea_time=>from_abap(
      date = sy-datum
      time = sy-uzeit
      timezone = timezone
    ).
  endmethod.


  method from_timestamp.
    convert time stamp timestamp time zone timezone into date data(new_abapdate) time data(new_abaptime).
    returning = yea_time=>from_abap(
      date = new_abapdate
      time = new_abaptime
      timezone = timezone
    ).
  endmethod.


  method FROM_TIMESTAMPL.
    convert time stamp timestamp time zone timezone into date data(new_abapdate) time data(new_abaptime).
    returning = yea_time=>from_abap(
      date = new_abapdate
      time = new_abaptime
      timezone = timezone
    ).
  endmethod.


  method FROM_UNIX.
    data(new_time) = new yea_time( ).
    new_time->unixtime = timestamp.
    new_time->set_timezone( 'UTC' ).
    returning = new_time.
  endmethod.


  method GREATER_THAN.
    data is_greater_than type boolean.
    if ( other_time is not bound ).
      is_greater_than = abap_false.
    else.
      if ( me->unixtime > other_time->unixtime ).
        is_greater_than = abap_true.
      endif.
    endif.
    returning = is_greater_than.
  endmethod.


  method GREATER_THAN_EQUAL.
    data is_greater_than type boolean.
    if ( other_time is not bound ).
      is_greater_than = abap_false.
    else.
      if ( me->unixtime >= other_time->unixtime ).
        is_greater_than = abap_true.
      endif.
    endif.
    returning = is_greater_than.
  endmethod.


  method HOUR.
    returning = me->abaptime+0(2).
  endmethod.


  method ISO.
    data:
      monthnum(2) type n,
      daynum(2) type n,
      hournum(2) type n,
      minutenum(2) type n,
      secondnum(2) type n.
    monthnum = me->month( ).
    daynum = me->day( ).
    hournum = me->hour( ).
    minutenum = me->minute( ).
    secondnum = me->second( ).
    returning = |{ me->year( ) }-{ monthnum }-{ daynum }T{ hournum }:{ minutenum }:{ secondnum }{ db_ttzz-direction }{ db_ttzz-delta+0(2) }:{ db_ttzz-delta+2(2) }|.
  endmethod.


  method LESSER_THAN.
    data is_lesser_than type boolean.
    if ( other_time is not bound ).
      is_lesser_than = abap_false.
    else.
      if ( me->unixtime < other_time->unixtime ).
        is_lesser_than = abap_true.
      endif.
    endif.
    returning = is_lesser_than.
  endmethod.


  method LESSER_THAN_EQUAL.
    data is_lesser_than type boolean.
    if ( other_time is not bound ).
      is_lesser_than = abap_false.
    else.
      if ( me->unixtime <= other_time->unixtime ).
        is_lesser_than = abap_true.
      endif.
    endif.
    returning = is_lesser_than.
  endmethod.


  method MINUTE.
    returning = me->abaptime+2(2).
  endmethod.


  method MONTH.
    returning = abapdate+4(2).
  endmethod.


  method MONTH_STRING.
    data(month_num) = me->month( ).
    select single ltx from t247 into returning
      where spras = lang
        and mnr = month_num.
    if ( sy-subrc <> 0 and lang <> sy-langu ).
      select single ltx from t247 into returning
        where spras = sy-langu
          and mnr = month_num.
    endif.
  endmethod.


  method SECOND.
    returning = me->abaptime+4(2).
  endmethod.


  method SET_TIMEZONE.
    select single * from yea_ttzz into me->db_ttzz where tzone = timezone and language = sy-langu.
    if ( sy-subrc = 0 ).
      me->timezone = timezone.
    endif.
    me->adjust_abap_datetime( ).
  endmethod.


  method START_OF_DAY.
    returning = from_abap(
      date = abapdate
      time = '000000'
      timezone = timezone
    ).
  endmethod.


  method start_of_month.
    data(month_date) = me->abapdate.
    month_date+6(2) = 01.
    returning = yea_time=>from_abap(
      date = month_date
      time = '000000'
      timezone = me->timezone
    ).
  endmethod.


  method start_of_week.
    data abapdate type scal-date.
    call function 'WEEK_GET_FIRST_DAY'
      exporting week = conv scal-week( me->week( ) )
      importing date = abapdate.
    returning = yea_time=>from_abap(
      date = abapdate
      time = '000000'
      timezone = me->timezone
    ).
  endmethod.


  method START_OF_YEAR.
    data(month_date) = me->abapdate. " conv datum( |{ me->year( ) }{ 01 }{ 01 }| ).
    month_date+4(2) = 01.
    month_date+6(2) = 01.
    returning = yea_time=>from_abap(
      date = month_date
      time = '000000'
      timezone = me->timezone
    ).
  endmethod.


  method TIME.
    returning = me->abaptime.
  endmethod.


  method TZ.
    returning = me->db_ttzz-tzone.
  endmethod.


  method UNIX.
    returning = me->unixtime.
  endmethod.


  method WEEK.
    data scal_week type scal-week.
    call function 'DATE_GET_WEEK'
      exporting date = conv scal-date( me->abapdate )
      importing week = scal_week.
    returning = scal_week.
  endmethod.


  method WEEKDAY.
    data packed type p.
    call function 'DAY_IN_WEEK'
      exporting datum = me->abapdate
      importing wotnr = packed.
    returning = packed.
  endmethod.


  method YEAR.
    returning = abapdate+0(4).
  endmethod.
ENDCLASS.

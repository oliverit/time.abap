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
  class-methods NOW
    importing
      !TIMEZONE type SYST_ZONLO default SY-ZONLO
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods GET_UNIX
    returning
      value(RETURNING) type YEA_TS .
  methods GET_DATE
    returning
      value(RETURNING) type DATUM .
  methods GET_TIME
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
  methods GET_ZONE
    returning
      value(RETURNING) type SYST_ZONLO .
  methods GET_DELTA
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
  methods GET_DAY
    returning
      value(RETURNING) type INT4 .
  methods GET_MONTH
    returning
      value(RETURNING) type INT4 .
  methods GET_YEAR
    returning
      value(RETURNING) type INT4 .
  methods GET_HOUR
    returning
      value(RETURNING) type INT4 .
  methods GET_MINUTE
    returning
      value(RETURNING) type INT4 .
  methods GET_SECOND
    returning
      value(RETURNING) type INT4 .
  methods GET_DAY_STRING
    importing
      !LANG type SY-LANGU default SY-LANGU
    returning
      value(RETURNING) type STRING .
  methods GET_MONTH_STRING
    importing
      !LANG type SY-LANGU default SY-LANGU
    returning
      value(RETURNING) type STRING .
  methods ISO
    returning
      value(RETURNING) type STRING .
protected section.
private section.

  data UNIXTIME type YEA_TS .
  data TIMEZONE type SYST_ZONLO .
  data ABAPDATE type DATUM .
  data ABAPTIME type UZEIT .
  data DB_TTZZ type YEA_TTZZ .
  data WEEKDAY type INT4 .

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
    new_time->weekday = me->weekday.
    returning = new_time.
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


  method FROM_UNIX.
    data(new_time) = new yea_time( ).
    new_time->unixtime = timestamp.
    new_time->set_timezone( 'UTC' ).
    returning = new_time.
  endmethod.


  method GET_DATE.
    returning = me->abapdate.
  endmethod.


  method GET_DAY.
    returning = abapdate+6(2).
  endmethod.


  method GET_DAY_STRING.
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


  method GET_DELTA.
    returning = me->db_ttzz-delta.
    if ( me->db_ttzz-delta = '-' ).
      returning = 0 - returning.
    endif.
  endmethod.


  method GET_HOUR.
    returning = me->abaptime+0(2).
  endmethod.


  method GET_MINUTE.
    returning = me->abaptime+2(2).
  endmethod.


  method GET_MONTH.
    returning = abapdate+4(2).
  endmethod.


  method GET_MONTH_STRING.
    data(month_num) = me->get_month( ).
    select single ltx from t247 into returning
      where spras = lang
        and mnr = month_num.
    if ( sy-subrc <> 0 and lang <> sy-langu ).
      select single ltx from t247 into returning
        where spras = sy-langu
          and mnr = month_num.
    endif.
  endmethod.


  method GET_SECOND.
    returning = me->abaptime+4(2).
  endmethod.


  method GET_TIME.
    returning = me->abaptime.
  endmethod.


  method GET_UNIX.
    returning = me->unixtime.
  endmethod.


  method GET_YEAR.
    returning = abapdate+0(4).
  endmethod.


  method GET_ZONE.
    returning = me->db_ttzz-tzone.
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


  method ISO.
    data:
      monthnum(2) type n,
      daynum(2) type n,
      hournum(2) type n,
      minutenum(2) type n,
      secondnum(2) type n.
    monthnum = me->get_month( ).
    daynum = me->get_day( ).
    hournum = me->get_hour( ).
    minutenum = me->get_minute( ).
    secondnum = me->get_second( ).
    returning = |{ me->get_year( ) }-{ monthnum }-{ daynum }T{ hournum }:{ minutenum }:{ secondnum }{ db_ttzz-direction }{ db_ttzz-delta+0(2) }:{ db_ttzz-delta+2(2) }|.
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


  method NOW.
    returning = yea_time=>from_abap(
      date = sy-datum
      time = sy-uzeit
      timezone = timezone
    ).
  endmethod.


  method SET_TIMEZONE.
    select single * from yea_ttzz into me->db_ttzz where tzone = timezone and language = sy-langu.
    if ( sy-subrc = 0 ).
      me->timezone = timezone.
    endif.
    me->adjust_abap_datetime( ).
  endmethod.
ENDCLASS.

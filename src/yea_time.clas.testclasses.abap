
class yea_Time_Unittest definition for testing
  duration short
  risk level harmless
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>yea_Time_Unittest
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>YEA_TIME
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE>X
*?</GENERATE_FIXTURE>
*?<GENERATE_CLASS_FIXTURE>X
*?</GENERATE_CLASS_FIXTURE>
*?<GENERATE_INVOCATION>X
*?</GENERATE_INVOCATION>
*?<GENERATE_ASSERT_EQUAL>X
*?</GENERATE_ASSERT_EQUAL>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  private section.
    data:
      f_Cut type ref to yea_Time.  "class under test

    class-methods: class_Setup.
    class-methods: class_Teardown.
    methods: setup.
    methods: teardown.
    methods: add_Days for testing.
    methods: add_Hours for testing.
    methods: add_Minutes for testing.
    methods: add_Seconds for testing.
    methods: copy for testing.
    methods: date for testing.
    methods: day for testing.
    methods: day_String for testing.
    methods: delta for testing.
    methods: distance for testing.
    methods: end_Of_Day for testing.
    methods: end_Of_Month for testing.
    methods: end_Of_Week for testing.
    methods: end_Of_Year for testing.
    methods: equal for testing.
    methods: from_Abap for testing.
    methods: from_Now for testing.
    methods: from_Timestamp for testing.
    methods: from_Timestampl for testing.
    methods: from_Unix for testing.
    methods: greater_Than for testing.
    methods: greater_Than_Equal for testing.
    methods: hour for testing.
    methods: iso for testing.
    methods: lesser_Than for testing.
    methods: lesser_Than_Equal for testing.
    methods: minute for testing.
    methods: month for testing.
    methods: month_String for testing.
    methods: second for testing.
    methods: set_Timezone for testing.
    methods: start_Of_Day for testing.
    methods: start_Of_Month for testing.
    methods: start_Of_Week for testing.
    methods: start_Of_Year for testing.
    methods: time for testing.
    methods: tz for testing.
    methods: unix for testing.
    methods: week for testing.
    methods: weekday for testing.
    methods: year for testing.
endclass.       "yea_Time_Unittest


class yea_Time_Unittest implementation.

  method class_Setup.



  endmethod.


  method class_Teardown.



  endmethod.


  method setup.

    f_cut = yea_time=>from_unix( 0 ).

  endmethod.


  method teardown.



  endmethod.


  method add_Days.

    data days type int4.

    f_Cut->add_Days( days ).

  endmethod.


  method add_Hours.

    data hours type int4.

    f_Cut->add_Hours( hours ).

  endmethod.


  method add_Minutes.

    data minutes type int4.

    f_Cut->add_Minutes( minutes ).

  endmethod.


  method add_Seconds.

    data seconds type int4.

    f_Cut->add_Seconds( seconds ).

  endmethod.


  method copy.

    data returning type ref to yea_Time.

    returning = f_Cut->copy(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method date.

    data returning type datum.

    returning = f_Cut->date(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = '19700101'          "<--- please adapt expected value
    " msg   = 'Unix epoch, 01.01.1970'
*     level =
    ).
  endmethod.


  method day.

    data returning type int4.

    returning = f_Cut->day(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = 1          "<--- please adapt expected value
    " msg   = 'Day 1'
*     level =
    ).
  endmethod.


  method day_String.

    data lang type syst_Langu.
    data returning type string.

    returning = f_Cut->day_String( 'E' ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = 'Thursday'          "<--- please adapt expected value
    " msg   = 'Unix epoch was on Thursday'
*     level =
    ).
  endmethod.


  method delta.

    data returning type int4.

    returning = f_Cut->delta(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = '0'          "<--- please adapt expected value
    " msg   = 'UTC Delta is zero'
*     level =
    ).
  endmethod.


  method distance.

    data returning type int4.

    returning = f_Cut->distance(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method end_Of_Day.

    data returning type ref to yea_Time.

    returning = f_Cut->end_Of_Day(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method end_Of_Month.

    data returning type ref to yea_Time.

    returning = f_Cut->end_Of_Month(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method end_Of_Week.

    data returning type ref to yea_Time.

    returning = f_Cut->end_Of_Week(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method end_Of_Year.

    data returning type ref to yea_Time.

    returning = f_Cut->end_Of_Year(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method equal.

    data other_Time type ref to yea_Time.
    data returning type boolean.

    returning = f_Cut->equal( other_Time ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method from_Abap.

    data date type datum.
    data time type uzeit.
    data timezone type syst_Zonlo.
    data returning type ref to yea_Time.

    returning = yea_Time=>from_Abap(
        DATE = date
        TIME = time
        TIMEZONE = timezone ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method from_Now.

    data timezone type syst_Zonlo.
    data returning type ref to yea_Time.

    returning = yea_Time=>from_Now( timezone ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method from_Timestamp.

    data timestamp type timestamp.
    data timezone type syst_Zonlo.
    data returning type ref to yea_Time.

    returning = yea_Time=>from_Timestamp(
        TIMESTAMP = timestamp
        TIMEZONE = timezone ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method from_Timestampl.

    data timestamp type timestampl.
    data timezone type syst_Zonlo.
    data returning type ref to yea_Time.

    returning = yea_Time=>from_Timestampl(
        TIMESTAMP = timestamp
        TIMEZONE = timezone ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method from_Unix.

    data timestamp type yea_Ts.
    data returning type ref to yea_Time.

    returning = yea_Time=>from_Unix( timestamp ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method greater_Than.

    data other_Time type ref to yea_Time.
    data returning type boolean.

    returning = f_Cut->greater_Than( other_Time ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method greater_Than_Equal.

    data other_Time type ref to yea_Time.
    data returning type boolean.

    returning = f_Cut->greater_Than_Equal( other_Time ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method hour.

    data returning type int4.

    returning = f_Cut->hour(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method iso.

    data returning type string.

    returning = f_Cut->iso(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method lesser_Than.

    data other_Time type ref to yea_Time.
    data returning type boolean.

    returning = f_Cut->lesser_Than( other_Time ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method lesser_Than_Equal.

    data other_Time type ref to yea_Time.
    data returning type boolean.

    returning = f_Cut->lesser_Than_Equal( other_Time ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method minute.

    data returning type int4.

    returning = f_Cut->minute(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method month.

    data returning type int4.

    returning = f_Cut->month(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method month_String.

    data lang type syst_Langu.
    data returning type string.

    returning = f_Cut->month_String( lang ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method second.

    data returning type int4.

    returning = f_Cut->second(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method set_Timezone.

    data timezone type syst_Zonlo.

    f_Cut->set_Timezone( timezone ).

  endmethod.


  method start_Of_Day.

    data returning type ref to yea_Time.

    returning = f_Cut->start_Of_Day(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method start_Of_Month.

    data returning type ref to yea_Time.

    returning = f_Cut->start_Of_Month(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method start_Of_Week.

    data returning type ref to yea_Time.

    returning = f_Cut->start_Of_Week(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method start_Of_Year.

    data returning type ref to yea_Time.

    returning = f_Cut->start_Of_Year(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method time.

    data returning type uzeit.

    returning = f_Cut->time(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method tz.

    data returning type syst_Zonlo.

    returning = f_Cut->tz(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method unix.

    data returning type yea_Ts.

    returning = f_Cut->unix(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method week.

    data returning type int4.

    returning = f_Cut->week(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method weekday.

    data returning type int4.

    returning = f_Cut->weekday(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.


  method year.

    data returning type int4.

    returning = f_Cut->year(  ).

    cl_Abap_Unit_Assert=>assert_Equals(
      act   = returning
      exp   = returning          "<--- please adapt expected value
    " msg   = 'Testing value returning'
*     level =
    ).
  endmethod.




endclass.

class YEA_TIME_SEGMENT definition
  public
  final
  create public .

public section.

  class-methods FROM
    importing
      !FROM type ref to YEA_TIME
    returning
      value(RETURNING) type ref to YEA_TIME_SEGMENT .
  class-methods TO
    importing
      !TO type ref to YEA_TIME
    returning
      value(RETURNING) type ref to YEA_TIME_SEGMENT .
  class-methods RANGE
    importing
      !FROM type ref to YEA_TIME
      !TILL type ref to YEA_TIME
    returning
      value(RETURNING) type ref to YEA_TIME_SEGMENT .
  methods INSIDE
    importing
      !TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods OUTSIDE
    importing
      !TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods BEFORE
    importing
      !TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods AFTER
    importing
      !TIME type ref to YEA_TIME
    returning
      value(RETURNING) type BOOLEAN .
  methods DIRECTION
    importing
      !TIME type ref to YEA_TIME
    returning
      value(RETURNING) type INT4 .
  methods DURATION
    returning
      value(RETURNING) type INT4 .
  methods STARTING
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods ENDING
    returning
      value(RETURNING) type ref to YEA_TIME .
  methods SECONDS_FROM_START
    importing
      !TIME type ref to YEA_TIME
    returning
      value(RETURNING) type INT4 .
  methods SECONDS_FROM_END
    importing
      !TIME type ref to YEA_TIME
    returning
      value(RETURNING) type INT4 .
protected section.
private section.

  data START type ref to YEA_TIME .
  data END type ref to YEA_TIME .
ENDCLASS.



CLASS YEA_TIME_SEGMENT IMPLEMENTATION.


  method AFTER.
    returning = time->greater_than( end ).
  endmethod.


  method BEFORE.
    returning = time->lesser_than( start ).
  endmethod.


  method direction.
    if ( inside( time ) = abap_true ).
      returning = 0.
    elseif ( before( time ) = abap_true ).
      returning = -1.
    elseif ( after( time ) = abap_true ).
      returning = 1.
    endif.
  endmethod.


  method DURATION.
    data(difference) = ( end->unix( ) - start->unix( ) ) / 1000.
    returning = difference.
  endmethod.


  method ENDING.
  endmethod.


  method FROM.
    data(new_segment) = new yea_time_segment( ).
    new_segment->start = from.
    new_segment->end = yea_time=>from_now( ).
    returning = new_segment.
  endmethod.


  method INSIDE.
    if ( time->greater_than_equal( start ) and time->lesser_than_equal( end ) ).
      returning = abap_true.
    endif.
  endmethod.


  method OUTSIDE.
    if ( time->lesser_than( start ) ).
      returning = abap_true.
    elseif ( time->greater_than_equal( start ) and time->greater_than( end ) ).
      returning = abap_true.
    endif.
  endmethod.


  method RANGE.
    data(new_segment) = new yea_time_segment( ).
    new_segment->start = from.
    new_segment->end = till.
    returning = new_segment.
  endmethod.


  method SECONDS_FROM_END.
    returning = ( time->unix( ) - end->unix( ) ) / 1000.
  endmethod.


  method SECONDS_FROM_START.
    returning = ( time->unix( ) - start->unix( ) ) / 1000.
  endmethod.


  method STARTING.
  endmethod.


  method TO.
    data(new_segment) = new yea_time_segment( ).
    new_segment->start = yea_time=>from_now( ).
    new_segment->end = to.
    returning = new_segment.
  endmethod.
ENDCLASS.

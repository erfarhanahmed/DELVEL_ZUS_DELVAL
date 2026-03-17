
CLEAR : gv_amount.
CLEAR : gv_date.
LOOP AT it_final INTO wa_final.
  IF wa_final-blart NE 'KZ'.
    gv_amount = wa_final-dmbtr + gv_amount.
  ENDIF.
    gv_date   = wa_final-ZALDT.

ENDLOOP.

clear gv_date1.

SPLIT gv_date at '-' into d1 d2 d3.
case d1.
  when '01'.
    d1 = 'Jan'.
    when '02'.
    d1 = 'Feb'.
    when '03'.
    d1 = 'Mar'.
    when '04'.
    d1 = 'Apr'.
    when '05'.
    d1 = 'May'.
    when '06'.
    d1 = 'June'.
    when '07'.
    d1 = 'July'.
    when '08'.
    d1 = 'Aug'.
    when '09'.
    d1 = 'Sep'.
    when '10'.
    d1 = 'Oct'.
    when '11'.
    d1 = 'Nov'.
    when '12'.
    d1 = 'Dec'.
  ENDCASE.

CONCATENATE d1 d2 ','d3 into gv_date1 SEPARATED BY space.
CONDENSE gv_date1.

clear gv_amount1.
CLEAR AMOUNT.
gv_amount1 = gv_amount.
amount = gv_amount.

split AMOUNT at '.' Into amt1 Amt2." AMT3.

CALL FUNCTION 'SPELL_AMOUNT'
 EXPORTING
   AMOUNT          = GV_AMOUNT1
   CURRENCY        = 'USD'
*   FILLER          = ' '
   LANGUAGE        = SY-LANGU
 IMPORTING
   IN_WORDS        = gv_amount2
* EXCEPTIONS
*   NOT_FOUND       = 1
*   TOO_LARGE       = 2
*   OTHERS          = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CONDENSE AMT2.

GV_AMOUNT3 = GV_AMOUNT2-WORD.

CALL FUNCTION 'ISP_CONVERT_FIRSTCHARS_TOUPPER'
  EXPORTING
    input_string        = GV_AMOUNT3
   SEPARATORS           = ' -.,;:'
 IMPORTING
   OUTPUT_STRING       =  GV_AMOUNT3
          .

CONCATENATE GV_AMOUNT3 'and' amt2'/100 Dollars' into amount SEPARATED BY space.


**************add blank lines****************

DELETE it_final WHERE blart EQ 'KZ'.
DESCRIBE TABLE it_final LINES lin.
lv_lines = lin / 10 .
if lin >= 10.

DO lv_lines TIMES.
  CLEAR lv_counter.
*CLEAR gv_amount.
  LOOP AT it_final INTO wa_final.
    lv_counter = lv_counter + 1.
    APPEND wa_final TO it_final1.
    IF lv_counter >= '10'.
      CLEAR lv_counter.
      EXIT.
    ENDIF.
  ENDLOOP.
*  enddo.

  DO 30 TIMES.
    APPEND INITIAL LINE TO it_final1.
  ENDDO.

   CLEAR lv_counter.
  LOOP AT it_final INTO wa_final.
    lv_counter = lv_counter + 1.
    APPEND wa_final TO it_final1.
    DELETE it_final WHERE belnr = wa_final-belnr.
    IF lv_counter >= '10'.
      CLEAR lv_counter.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDDO.
endif.
*DELETE it_final WHERE blart EQ 'KZ'.

IF IT_FINAL[] IS NOT INITIAL.
**************add remaining records****************
DESCRIBE TABLE it_final LINES lin.
if lin <= 10.
lv_lines = lin.
DO 1 TIMES.
  CLEAR lv_counter.
  LOOP AT it_final INTO wa_final.
    lv_counter = lv_counter + 1.
    APPEND wa_final TO it_final1.

  ENDLOOP.

lv_lines = ( 10 - lin ).
lv_lines = lv_lines + 30.
  DO lv_lines TIMES.
    APPEND INITIAL LINE TO it_final1.
  ENDDO.

  LOOP AT it_final INTO wa_final.
    APPEND wa_final TO it_final1.
    DELETE it_final WHERE belnr = wa_final-belnr.
  ENDLOOP.

ENDDO.
ENDIF.
endif.

DELETE it_final1 WHERE blart EQ 'KZ'.

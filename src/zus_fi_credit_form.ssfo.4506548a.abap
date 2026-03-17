
SELECT SINGLE * FROM t052 INTO wa_t052
  WHERE ZTERM = wa_bseg-ZTERM.

SELECT SINGLE * FROM bkpf INTO wa_bkpf
   WHERE belnr = wa_bseg-belnr
    AND  gjahr = wa_bseg-gjahr.

DATA :day TYPE i.
IF wa_t052-ZPRZ1 IS NOT INITIAL.
  day = wa_t052-ZTAG2.
ELSE.
  day = wa_t052-ZTAG1.
ENDIF.
DUE_DATE = wa_bkpf-budat + Day.


CLEAR WA_T247.
CALL FUNCTION 'IDWT_READ_MONTH_TEXT'
  EXPORTING
    langu         = sy-langu
    month         = DUE_DATE+4(2)
 IMPORTING
   T247          = WA_T247
          .

TRANSLATE wa_t247-ktx+1(2) TO LOWER CASE.
CONCATENATE  wa_t247-ktx DUE_DATE+6(2) DUE_DATE+0(4)
                INTO GV_DUE_DATE SEPARATED BY '.'.

CLEAR WA_T247.
CALL FUNCTION 'IDWT_READ_MONTH_TEXT'
  EXPORTING
    langu         = sy-langu
    month         = wa_bkpf-budat+4(2)
 IMPORTING
   T247          = WA_T247
          .
TRANSLATE wa_t247-ktx+1(2) TO LOWER CASE.
CONCATENATE  wa_t247-ktx wa_bkpf-budat+6(2) wa_bkpf-budat+0(4)
                INTO GV_INV_DATE SEPARATED BY '.'.
















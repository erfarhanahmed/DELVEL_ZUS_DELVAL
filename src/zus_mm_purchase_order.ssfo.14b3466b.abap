
REPLACE '-' INTO gv_dis WITH ''.
gv_damt = gv_damt * -1.

IF gv_dis IS NOT INITIAL.
CONCATENATE gv_dis '%' INTO gv_dis.
ENDIF.

total = gv_total.
gv_total = gv_total + zch_amt + zch1_amt + GV_AFR + GV_ZEXP.
clear gv_amt.
gv_amt = gv_total.

CALL FUNCTION 'SPELL_AMOUNT'
 EXPORTING
   AMOUNT          = gv_total
   CURRENCY        = 'USD'
*   FILLER          = ' '
   LANGUAGE        = SY-LANGU
 IMPORTING
   IN_WORDS        = gv_wrd
* EXCEPTIONS
*   NOT_FOUND       = 1
*   TOO_LARGE       = 2
*   OTHERS          = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

IF gv_wrd-DECWORD NE 'ZERO'.
  CONCATENATE gv_wrd-WORD 'DOLLAR &' gv_wrd-DECWORD 'CENTS ONLY'
  INTO gv_amt_wrd SEPARATED BY space.
ELSE.
  CONCATENATE gv_wrd-WORD 'DOLLAR ONLY'
  INTO gv_amt_wrd SEPARATED BY space.
ENDIF.

IF gv_damt IS NOT INITIAL.
    lv_flag = 'X'.
ENDIF.

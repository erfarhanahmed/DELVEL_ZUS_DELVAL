clear gv_amt.
gv_amt = gv_tot.

CALL FUNCTION 'HR_IN_CHG_INR_WRDS'
  EXPORTING
    amt_in_num               = gv_amt
 IMPORTING
   AMT_IN_WORDS             = gv_amt_wrd
* EXCEPTIONS
*   DATA_TYPE_MISMATCH       = 1
*   OTHERS                   = 2
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.



REPLACE 'Rupees' IN gv_amt_wrd with 'DOLLAR'.
REPLACE 'Paise'  IN gv_amt_wrd with 'CENTS ONLY'.





















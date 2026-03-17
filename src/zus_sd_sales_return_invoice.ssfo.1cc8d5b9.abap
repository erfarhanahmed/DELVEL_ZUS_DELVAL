
DATA :day TYPE i.
IF wa_t052-ZPRZ1 IS NOT INITIAL.
  day = wa_t052-ZTAG2.
ELSE.
  day = wa_t052-ZTAG1.
ENDIF...

DUE_DATE = WA_HDR-BIL_DATE + Day.

*
*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = DUE_DATE
*   IMPORTING
*     OUTPUT        = GV_DUE_DATE
*            .
*
*TRANSLATE GV_DUE_DATE+0(3) TO LOWER CASE.
*TRANSLATE GV_DUE_DATE+0(1) TO UPPER CASE.
*CONCATENATE  GV_DUE_DATE+0(3) GV_DUE_DATE+3(2) GV_DUE_DATE+5(4)
*                INTO GV_DUE_DATE SEPARATED BY '.'.

CONCATENATE  DUE_DATE+4(2) DUE_DATE+6(2) DUE_DATE+0(4)
                INTO GV_DUE_DATE SEPARATED BY '.'.




*BREAK PRIMUSABAP.
*
*IF WA_HDR-BIL_TYPE = 'US05'.
*
*    IF DUE_DATE+4(2) = '01'.
*      month = 'JAN'.
*
*     ELSEIF DUE_DATE+4(2) = '03'.
*      month = 'MAR'.
*
*ELSEIF DUE_DATE+4(2) = '02'.
*      month = 'FEB'.
*ELSEIF DUE_DATE+4(2) = '04'.
*      month = 'APR'.
*      ELSEIF DUE_DATE+4(2) = '05'.
*      month = 'MAY'.
*ELSEIF DUE_DATE+4(2) = '06'.
*      month = 'JUN'.
*ELSEIF DUE_DATE+4(2) = '07'.
*      month = 'JUL'..
*ELSEIF DUE_DATE+4(2) = '08'.
*      month = 'AUG'.
*ELSEIF DUE_DATE+4(2) = '09'.
*      month = 'SEP'.
*ELSEIF DUE_DATE+4(2) = '10'.
*      month = 'OCT'.
*ELSEIF DUE_DATE+4(2) = '11'.
*      month = 'NOV'.
*ELSEIF DUE_DATE+4(2) = '12'.
*      month = 'DEC'.
*  ENDIF.
*
*
*CONCATENATE MONTH  DUE_DATE+6(2) DUE_DATE+0(4)
*INTO  GV_DUE_DATE SEPARATED BY '.'.
*
*
*ENDIF.
*
*
*
*
*
*
*
*
*
*
*
*
*
*




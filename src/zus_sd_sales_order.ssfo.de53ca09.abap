*break primusabap.
SELECT SINGLE * FROM vbap INTO wa_vbap
  WHERE VBELN = IS_VBDKA-VBELN
    AND posnr = wa_final-posnr
    AND matnr = wa_final-matnr.

***CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
***    EXPORTING
***      input         = WA_VBAP-CUSTDELDATE
***   IMPORTING
***     OUTPUT        = GV_SHIP_D
            .
*TRANSLATE GV_SHIP_D+1(2) TO LOWER CASE.  "comment by DH

*CONCATENATE  GV_SHIP_D+0(3) GV_SHIP_D+3(2) GV_SHIP_D+5(4)
*                INTO GV_SHIP_D SEPARATED BY '.'.

"TRANSLATE GV_SHIP_D+3(2) TO LOWER CASE.  "comment by DH
if wa_vbap-DELDATE is not INITIAL.
gv_ship_d = wa_vbap-DELDATE."added by jyoti on 14.11.2024
elseif wa_vbap-custdeldate is not INITIAL. "added by jyoti on 14.11.2024
gv_ship_d = wa_vbap-custdeldate.
ENDIF. "added by jyoti on 14.11.2024

CONCATENATE GV_SHIP_D+4(2) GV_SHIP_D+6(2) GV_SHIP_D+0(4)
                INTO GV_SHIP_D SEPARATED BY '-'.

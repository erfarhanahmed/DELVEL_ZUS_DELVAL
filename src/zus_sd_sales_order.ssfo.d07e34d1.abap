SELECT SINGLE * FROM VBAK INTO WA_VBAK
  WHERE VBELN = IS_VBDKA-VBELN.

READ TABLE it_vbak into wa_vbak with key vbeln = IS_VBDKA-VBELN.

CLEAR:wa_konv.
READ TABLE IT_KONV INTO WA_KONV WITH KEY kposn = wa_final-posnr
                                         kschl = 'ZPR0'
                                         kinak = ' '.

gv_unit = wa_konv-kbetr.
gv_amt  = wa_konv-kwert.

*if wa_vbak-auart = 'US11' and wa_vbak-vbtyp = 'H'.
*    CONCATENATE '-' '$' gv_unit into gv_unit.
*  else .
*      CONCATENATE '$' gv_unit into gv_unit.
*  ENDIF.

GV_SUBTOT = GV_SUBTOT + WA_KONV-KWERT.

GV_TOT = GV_SUBTOT + GV_SALE + GV_HANDLING
         + GV_SERVICE + GV_MOUNTING .

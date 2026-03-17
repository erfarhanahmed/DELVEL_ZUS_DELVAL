SELECT SINGLE * FROM VBAK INTO WA_VBAK
  WHERE VBELN = IS_VBDKA-VBELN.

READ TABLE it_vbak into wa_vbak with key vbeln = IS_VBDKA-VBELN.
  gv_amt1 = wa_konv-KWERT.
  GV_SUBTOT1 = GV_SUBTOT.
  gv_sale1 = gv_sale.
  gv_handling1 = GV_HANDLING.
  GV_SERVICE1 = GV_SERVICE.
  GV_MOUNTING1 = GV_MOUNTING.
  gv_tot1 = gv_tot.

  if wa_vbak-auart = 'US11' and wa_vbak-vbtyp = 'H'.
    "gv_amt1 = -1 * wa_konv-kwert.
    CONCATENATE '-' '$' gv_amt1 into gv_amt1.
    CONCATENATE '-' '$' GV_SUBTOT1 into GV_SUBTOT1.
    CONCATENATE '-' '$' GV_sale1 into GV_Sale1.
    CONCATENATE '-' '$' GV_HANDLING1 into GV_HANDLING1.
    CONCATENATE '-' '$' GV_SERVICE1 into GV_SERVICE1.
     CONCATENATE '-' '$' GV_MOUNTING1 into GV_MOUNTING1.
     CONCATENATE '-' '$' GV_tot1 into GV_tot1.

    else .

      CONCATENATE '$' gv_amt1 into gv_amt1.
       CONCATENATE '$' GV_SUBTOT1 into GV_SUBTOT1.
       CONCATENATE '$' GV_Sale1 into GV_sale1.
       CONCATENATE '$' GV_HANDLING1 into GV_HANDLING1.
    CONCATENATE '$' GV_SERVICE1 into GV_SERVICE1.
     CONCATENATE  '$' GV_MOUNTING1 into GV_MOUNTING1.
     CONCATENATE  '$' GV_tot1 into GV_tot1.
  endif.














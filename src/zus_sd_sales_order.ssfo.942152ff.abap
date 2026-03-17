select  vbeln
        POSNR
        MATNR
        BRGEW
        NETPR
        NETWR
        KWMENG
  from VBAP
  into table it_vbap1
  where vbeln = wa_vbap-vbeln.

loop at it_vbap1 into wa_vbap1.
wa_final-kwmeng = wa_vbap1-kwmeng.
gv_qty = gv_qty + WA_FINAL-KWMENG.
 append WA_FINAL to it_final.
  clear WA_FINAL.
endloop.















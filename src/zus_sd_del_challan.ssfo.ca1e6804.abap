
SELECT SINGLE *
from vbfa
into wa_vbfa
 where VBELN = wa_lips-VBELN
  and vbtyp_n = 'J'.

SELECT VBELN
       POSNR
       kwmeng
       lfrel
  FROM  vbap INTO TABLE it_vbap1
  WHERE vbeln =  wa_vbfa-vbelv.

  loop at it_vbap1 into wa_vbap1.
    gv_qty = gv_qty + wa_vbap1-kwmeng.
  endloop.

*  SELECT VBELV
*         POSNV
*         VBELN
*         POSNN
*         VBTYP_N
*         TAQUI
*         FROM VBFA
*         INTO TABLE LT_VBFA
*         FOR ALL ENTRIES IN IT_LIPS
*         WHERE VBELV = IT_LIPS-VBELN
*         AND   POSNV = IT_LIPS-POSNR
*         AND   TAQUI = 'X'.


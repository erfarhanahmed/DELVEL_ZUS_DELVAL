
SELECT bukrs
       belnr
       GJAHR
       BUZEI
       BSCHL
       KOART
       SHKZG
       DMBTR
       SGTXT
       HKONT
       KUNNR
       ZFBDT
       ZTERM
       TXGRP FROM bseg INTO TABLE it_bseg
       WHERE belnr = wa_bseg-belnr
*          AND TXGRP = ' '
*         AND shkzg = 'H'
         AND KOART NE 'D'
         AND BUKRS = 'US00'
         AND GJAHR = wa_bseg-GJAHR.


SELECT SINGLE * FROM T001W INTO WA_T001W
  WHERE WERKS = 'US01'.

SELECT SINGLE * FROM ADRC INTO WA_ADRC1
  WHERE ADDRNUMBER = WA_T001W-ADRNR.

SELECT SINGLE * FROM kna1 INTO wa_kna1
  WHERE kunnr = wa_bseg-kunnr.




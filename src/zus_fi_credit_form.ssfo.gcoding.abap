SELECT bukrs
       belnr
       GJAHR
       BUZEI
       BSCHL
       SHKZG
       DMBTR
       SGTXT
       HKONT
       KUNNR
       ZFBDT
       ZTERM FROM bseg INTO TABLE it_bseg
       WHERE belnr = wa_bseg-belnr
*         AND shkzg = 'S'
         AND KOART NE 'D'
         AND bukrs = 'US00'
         AND GJAHR = wa_bseg-GJAHR.


SELECT SINGLE * FROM T001W INTO WA_T001W
  WHERE WERKS = 'US01'.

SELECT SINGLE * FROM ADRC INTO WA_ADRC1
  WHERE ADDRNUMBER = WA_T001W-ADRNR.

SELECT SINGLE * FROM kna1 INTO wa_kna1
  WHERE kunnr = wa_bseg-kunnr.










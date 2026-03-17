
READ TABLE it_ekpo INTO wa_ekpo INDEX 1.

SELECT SINGLE * FROM T001W INTO WA_T001W
  WHERE WERKS = WA_ekpo-WERKS.

SELECT SINGLE * FROM ADRC INTO WA_ADRC
  WHERE ADDRNUMBER = WA_T001W-ADRNR.


SELECT COUNT(*) FROM cdhdr INTO gv_revcnt
  WHERE objectclas = 'EINKBELEG'
    AND objectid = wa_ekko-ebeln
    AND ( tcode = 'ME23N'
       OR tcode = 'ME22N' ).

 SELECT * FROM cdhdr INTO TABLE it_cdhdr
   WHERE objectid = wa_ekko-ebeln
     AND objectclas = 'EINKBELEG'
     AND ( tcode = 'ME23N'
       OR tcode = 'ME22N' ).

SORT it_cdhdr DESCENDING by CHANGENR.

*READ TABLE it_cdhdr INTO wa_cdhdr INDEX 1.
data:hh TYPE string,
     time TYPE cdhdr-utime.
time = '103000'.
READ TABLE it_cdhdr INTO wa_cdhdr INDEX 1.
hh = wa_cdhdr-utime - time.
IF hh < 0.
wa_cdhdr-udate = wa_cdhdr-udate - 1.
ENDIF.
CONCATENATE wa_cdhdr-udate+4(2) wa_cdhdr-udate+6(2)  wa_cdhdr-udate+0(4)
                INTO GV_rev_dat SEPARATED BY '/'.



















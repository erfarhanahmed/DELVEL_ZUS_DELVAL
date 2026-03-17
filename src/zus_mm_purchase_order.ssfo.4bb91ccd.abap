
*SELECT SINGLE * FROM T001W INTO WA_T001W
*  WHERE WERKS = WA_HDR-WERKS.
*
*SELECT SINGLE * FROM t005t INTO wa_plant
*  WHERE SPRAS = wa_t001w-SPRAS
*   AND  LAND1 = wa_t001w-LAND1.
*
*SELECT SINGLE * FROM ADRC INTO WA_ADRC
*  WHERE ADDRNUMBER = WA_T001W-ADRNR.
*
*SELECT COUNT(*) FROM cdhdr INTO gv_revcnt
*  WHERE objectclas = 'EINKBELEG'
*    AND objectid = wa_hdr-ebeln
*    AND ( tcode = 'ME23N'
*       OR tcode = 'ME22N' ).
**    AND CHANGE_IND = 'U'.
*
* SELECT * FROM cdhdr INTO TABLE it_cdhdr
*   WHERE objectid = wa_hdr-ebeln
*     AND objectclas = 'EINKBELEG'
*     AND ( tcode = 'ME23N'
*       OR tcode = 'ME22N' ).
*
*SORT it_cdhdr DESCENDING by CHANGENR.
*
*
*data:hh TYPE string,
*     time TYPE cdhdr-utime.
*time = '103000'.
*READ TABLE it_cdhdr INTO wa_cdhdr INDEX 1.
*hh = wa_cdhdr-utime - time.
*IF hh < 0.
*wa_cdhdr-udate = wa_cdhdr-udate - 1.
*ENDIF.
*CONCATENATE wa_cdhdr-udate+4(2) wa_cdhdr-udate+6(2)  wa_cdhdr-udate+0(4)
*                INTO GV_rev_dat SEPARATED BY '/'.


**********
DATA: lv_name   TYPE thead-tdname,        "ADDED BY SUPRIYA ON 13TH AUGUST 2024
      lv_bedat  TYPE ekko-bedat,          "ADDED BY SUPRIYA ON 13TH AUGUST 2024
      lv_cutoff TYPE d VALUE '20240812'.  "ADDED BY SUPRIYA ON 13TH AUGUST 2024
lv_bedat = wa_hdr-bedat.                  "ADDED BY SUPRIYA ON 13TH AUGUST 2024

SELECT SINGLE * FROM T001W INTO WA_T001W
 WHERE WERKS = WA_HDR-WERKS.

SELECT SINGLE * FROM t005t INTO wa_plant
  WHERE SPRAS = wa_t001w-SPRAS
   AND  LAND1 = wa_t001w-LAND1.

SELECT SINGLE * FROM ADRC INTO WA_ADRC
  WHERE ADDRNUMBER = WA_T001W-ADRNR.
SELECT COUNT(*) FROM cdhdr INTO gv_revcnt
  WHERE objectclas = 'EINKBELEG'
    AND objectid = wa_hdr-ebeln
    AND ( tcode = 'ME23N'
       OR tcode = 'ME22N' ).
*    AND CHANGE_IND = 'U'.
SELECT * FROM cdhdr INTO TABLE it_cdhdr
   WHERE objectid = wa_hdr-ebeln
     AND objectclas = 'EINKBELEG'
     AND ( tcode = 'ME23N'
       OR tcode = 'ME22N' ).

SORT it_cdhdr DESCENDING by CHANGENR.
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


IF lv_bedat > lv_cutoff.
  wa_adrc-street = '6535 Industrial Dr, Ste 103'.

  ENDIF.








DATA : wa_ekpo      LIKE LINE OF xekpo,
       wa_eket      LIKE LINE OF xeket,
       wa_konv      LIKE LINE OF xtkomv.

*CLEAR gv_dis.
*READ TABLE xtkomv INTO wa_konv WITH KEY kschl = 'HB01' kposn = ' '.
*IF sy-subrc = 0.
**gv_dis = wa_konv-kbetr.
*amount = wa_konv-kawrt.
*GV_DAMT = wa_konv-kbetr.
*REPLACE '-' INTO gv_dis WITH ''.
*REPLACE '-' INTO GV_DAMT WITH ''.
*ENDIF.
*
*READ TABLE xtkomv INTO wa_konv WITH KEY kschl = 'R000' kposn = ' '.
*IF sy-subrc = 0.
*GV_DAMT = wa_konv-kwert.
*gv_dis = wa_konv-kbetr / 10.
*amount = wa_konv-kawrt .
*REPLACE '-' INTO gv_dis WITH ''.
*REPLACE '-' INTO GV_DAMT WITH ''.
*CONCATENATE gv_dis '%' INTO gv_dis.
*ENDIF.


wa_hdr-ebeln = xekko-ebeln.
wa_hdr-bsart = xekko-bsart.
wa_hdr-bukrs = xekko-bukrs.
wa_hdr-lifnr = xekko-lifnr.
wa_hdr-zterm = xekko-zterm.
wa_hdr-aedat = xekko-aedat.
wa_hdr-zbd1t = xekko-zbd1t.
wa_hdr-waers = xekko-waers.
wa_hdr-inco1 = xekko-inco1.
wa_hdr-inco2 = xekko-inco2.
wa_hdr-knumv = xekko-knumv.
wa_hdr-bedat = xekko-bedat.
wa_hdr-waers = xekko-waers.

LOOP AT xekpo INTO wa_ekpo.
  CLEAR wa_item.
  wa_item-ebelp = wa_ekpo-ebelp.
  wa_item-matnr = wa_ekpo-matnr.
  wa_item-txz01 = wa_ekpo-txz01.
  wa_item-werks = wa_ekpo-werks.
  wa_item-menge = wa_ekpo-menge.
  wa_item-meins = wa_ekpo-meins.
  wa_item-netpr = wa_ekpo-netpr.
  wa_item-netwr = wa_ekpo-netwr.
  wa_item-BRTWR = wa_ekpo-BRTWR.
  wa_item-ntgew = wa_ekpo-ntgew.
  wa_item-gewei = wa_ekpo-gewei.
  wa_item-banfn = wa_ekpo-banfn.
  wa_item-pstyp = wa_ekpo-pstyp.
  wa_item-packno = wa_ekpo-packno.
  WA_ITEM-infnr  = wa_ekpo-infnr.
  APPEND wa_item TO it_items.

ENDLOOP.
*BREAK-POINT.
************************************************

************************************************
READ TABLE xeket INTO wa_eket INDEX 1.
wa_hdr-werks  = wa_item-werks.
wa_hdr-banfn  = wa_item-banfn.
wa_hdr-eindt  = wa_eket-eindt.

*BREAK-POINT.
SELECT SINGLE * FROM lfa1 INTO wa_lfa1
  WHERE lifnr = wa_hdr-lifnr.

SELECT SINGLE * FROM t005t INTO wa_t005t
  WHERE spras = 'E'
    AND LAND1 = wa_lfa1-land1.

SELECT SINGLE * FROM t005u INTO wa_t005u
  WHERE spras = 'E'
    AND LAND1 = wa_lfa1-land1
    AND BLAND = wa_lfa1-regio.


SELECT SINGLE * FROM t052u INTO wa_t052u
  WHERE zterm = wa_hdr-zterm.

SELECT SINGLE * FROM tinct INTO wa_tinct
  WHERE inco1 = wa_hdr-inco1
    AND spras = 'EN'.

DATA: lv_name   TYPE thead-tdname.

  CLEAR: lv_lines,WA_LINES.
      REFRESH lv_lines.
      lv_name = wa_hdr-ebeln.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'F06'
          language                = sy-langu
          name                    = lv_name
          object                  = 'EKKO'
        TABLES
          lines                   = lv_lines
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
      READ TABLE lv_lines INTO WA_LINES INDEX 1.

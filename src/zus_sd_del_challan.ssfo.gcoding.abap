

wa_hdr = IS_DLV_DELNOTE-HD_GEN.
it_item = IS_DLV_DELNOTE-IT_GEN.
it_adr  = IS_DLV_DELNOTE-HD_ADR.


SELECT VBELN
       POSNR
       MATNR
       WERKS
       LFIMG
       VGBEL
       VGPOS FROM lips INTO TABLE it_lips
       WHERE vbeln = wa_hdr-DELIV_NUMB.

loop at it_lips INTO wa_lips.
  gv_qty1 = gv_qty1 + wa_lips-lfimg.
ENDLOOP.

*SELECT SINGLE * FROM kna1 INTO wa_kna1
*  WHERE kunnr = wa_hdr-SOLD_TO_PARTY.
*
*SELECT SINGLE * FROM knvv INTO wa_knvv
*  WHERE kunnr = wa_hdr-SOLD_TO_PARTY.

SELECT SINGLE * FROM likp INTO wa_likp
  WHERE vbeln = wa_hdr-DELIV_NUMB.


READ TABLE it_lips INTO wa_lips INDEX 1.
DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt  TYPE tline,
      ls_mattxt  TYPE tline.


CLEAR: lv_lines, ls_mattxt,GV_ref.
      REFRESH lv_lines.
      lv_name = wa_lips-vgbel.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U002'
          language                = sy-langu
          name                    = lv_name
          object                  = 'VBBK'
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
      IF NOT lv_lines IS INITIAL.

      READ TABLE lv_lines INTO wa_lines INDEX 1.
          IF NOT wa_lines-tdline IS INITIAL.
             GV_ref = wa_lines-tdline .
          ENDIF.


      ENDIF.







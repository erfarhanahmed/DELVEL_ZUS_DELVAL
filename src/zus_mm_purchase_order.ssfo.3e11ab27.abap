

SELECT SINGLE * FROM EKET INTO WA_EKET
  WHERE EBELN = WA_HDR-EBELN
   AND  EBELP = WA_ITEM-EBELP.
*BREAK primus.
CONCATENATE WA_EKET-EINDT+4(2) WA_EKET-EINDT+6(2)  WA_EKET-EINDT+0(4)
                INTO gv_ship SEPARATED BY '/'.

DATA: lv_name   TYPE thead-tdname.

  CLEAR: it_lines,LINES.
      REFRESH it_lines.
      lv_name = wa_item-matnr.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'GRUN'
          language                = sy-langu
          name                    = lv_name
          object                  = 'MATERIAL'
        TABLES
          lines                   = it_lines
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

*IF it_lines IS INITIAL .
SELECT SINGLE * FROM MAKT INTO WA_MAKT
  WHERE MATNR = WA_ITEM-MATNR.
*ENDIF.










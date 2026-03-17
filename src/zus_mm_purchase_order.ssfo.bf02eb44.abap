*break primus.
DATA: lv_name   TYPE thead-tdname.

  CLEAR: it_lines,LINES.
      REFRESH it_lines.
      lv_name = WA_HDR-EBELN.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'F01'
          language                = sy-langu
          name                    = lv_name
          object                  = 'EKKO'
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

CLEAR wa_text.
IF it_lines IS NOT INITIAL.
        LOOP AT  it_lines INTO lines.
      replace all occurences of '<(>&<)>' in lines-tdline with '&'.
         condense lines-tdline .
*         SHIFT lines-tdline RIGHT DELETING TRAILING '* '.
*          CONCATENATE  Ls_lines-tdline '' INTO ls_text-lv_lines.
          wa_text-lines = lines-tdline.
*          CONDENSE ls_text-lv_lines .
*           replace all occurences of space in
*           ls_text-lv_lines with ''.
         APPEND wa_text to it_text.
          CLEAR wa_text.
        ENDLOOP.

ENDIF.






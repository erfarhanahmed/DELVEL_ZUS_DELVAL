
CLEAR lv_name.
total = wa_ekpo-menge + total.
CONCATENATE wa_ekpo-ebeln wa_ekpo-ebelp INTO lv_name.


  CLEAR: it_lines,LINES.
      REFRESH it_lines.

      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'F08'
          language                = sy-langu
          name                    = lv_name
          object                  = 'EKPO'
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





















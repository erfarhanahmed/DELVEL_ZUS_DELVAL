DATA: lv_name   TYPE thead-tdname.

  SELECT infnr
       ekorg
       werks
       esokz
  from eine
  into table it_eine
  where infnr = WA_ITEM-infnr.

READ TABLE it_eine INTO wa_eine with key infnr = wa_ITEM-infnr.
 wa_ITEM-esokz = wa_eine-esokz.
 WA_ITEM-ekorg = WA_EINE-ekorg.

"DATA: lv_name   TYPE thead-tdname.

"BREAK-POINT.
  CLEAR: it_lines,WA_LINES,lv_memo.
      REFRESH it_lines.
"BREAK PRIMUS.
      CONCATENATE WA_ITEM-infnr WA_ITEM-ekorg wa_item-esokz WA_ITEM-werks
                INTO lv_name." SEPARATED BY ''.
*      lv_name = gv_text.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'BT'
          language                = sy-langu
          name                    = lv_name
          object                  = 'EINE'
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
        CLEAR: it_lines,WA_LINES,lv_memo.
      REFRESH it_lines.
"BREAK PRIMUS.
      CONCATENATE WA_ITEM-infnr WA_ITEM-ekorg wa_item-esokz
                INTO lv_name." SEPARATED BY ''.
*      lv_name = gv_text.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'BT'
          language                = sy-langu
          name                    = lv_name
          object                  = 'EINE'
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
        CLEAR: it_lines,WA_LINES,lv_memo.
      REFRESH it_lines.
"BREAK PRIMUS.
      CONCATENATE WA_EKET-EBELN WA_EKET-EBELP
                INTO lv_name." SEPARATED BY ''.
*      lv_name = gv_text.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'F02'
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

       endif.
     ENDIF.
IF it_lines IS NOT INITIAL.
      READ TABLE it_lines INTO WA_LINES INDEX 1.
      IF SY-SUBRC = 0.
      lv_memo = WA_LINES-tdline.
*      wa_final-lv_memo  = lv_memo  .
ENDIF.
    ENDIF.




















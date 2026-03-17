DATA: lv_name   TYPE thead-tdname.
 CLEAR: lt_lines,ls_LINES.
      REFRESH lt_lines.
      lv_name = wa_hdr-ebeln.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'F14'
          language                = sy-langu
          name                    = lv_name
          object                  = 'EKKO'
        TABLES
          lines                   = lt_lines
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
 IF lt_lines IS NOT INITIAL.
 READ TABLE lt_lines INTO ls_lines INDEX 1.
 IF sy-subrc = 0.
   ship_to = ls_lines-tdline.
 ENDIF.

 READ TABLE lt_lines INTO ls_lines INDEX 2.
 IF sy-subrc = 0.
   ship_to1 = ls_lines-tdline.
 ENDIF.

 READ TABLE lt_lines INTO ls_lines INDEX 3.
 IF sy-subrc = 0.
   ship_to2 = ls_lines-tdline.
 ENDIF.

 READ TABLE lt_lines INTO ls_lines INDEX 4.
 IF sy-subrc = 0.
   ship_to3 = ls_lines-tdline.
 ENDIF.

 READ TABLE lt_lines INTO ls_lines INDEX 5.
 IF sy-subrc = 0.
   ship_to4 = ls_lines-tdline.
 ENDIF.

 READ TABLE lt_lines INTO ls_lines INDEX 6.
 IF sy-subrc = 0.
   ship_to5 = ls_lines-tdline.
 ENDIF.

*
*   LOOP AT lt_lines INTO ls_lines.
*     IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ship_to ls_lines-tdline INTO ship_to SEPARATED BY space.
*     ENDIF.
*   ENDLOOP.
 ENDIF.

REPLACE ALL OCCURRENCES OF '<(>' IN ship_to WITH SPACE.
REPLACE ALL OCCURRENCES OF '<)>' IN ship_to WITH SPACE.
REPLACE ALL OCCURRENCES OF '<(>' IN ship_to1 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<)>' IN ship_to1 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<(>' IN ship_to2 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<)>' IN ship_to2 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<(>' IN ship_to3 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<)>' IN ship_to3 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<(>' IN ship_to4 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<)>' IN ship_to4 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<(>' IN ship_to5 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<)>' IN ship_to5 WITH SPACE.

















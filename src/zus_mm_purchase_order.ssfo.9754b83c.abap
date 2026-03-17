
CONCATENATE wa_hdr-bedat+4(2) wa_hdr-bedat+6(2)  wa_hdr-bedat+0(4)
                INTO gv_issue SEPARATED BY '/'.

CONCATENATE wa_hdr-eindt+4(2) wa_hdr-eindt+6(2) wa_hdr-eindt+0(4)
                INTO gv_exp SEPARATED BY '/'.

DATA: lv_name   TYPE thead-tdname.
 CLEAR: lt_lines,ls_LINES.
      REFRESH lt_lines.
      lv_name = wa_hdr-ebeln.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'F22'
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
   IF sy-subrc = 0 .
     cust = ls_lines-tdline.
   ENDIF.

   READ TABLE lt_lines INTO ls_lines INDEX 2.
   IF sy-subrc = 0 .
     cust1 = ls_lines-tdline.
   ENDIF.
ENDIF.

REPLACE ALL OCCURRENCES OF '<(>' IN cust WITH SPACE.
REPLACE ALL OCCURRENCES OF '<)>' IN cust WITH SPACE.
REPLACE ALL OCCURRENCES OF '<(>' IN cust1 WITH SPACE.
REPLACE ALL OCCURRENCES OF '<)>' IN cust1 WITH SPACE.

IF cust IS INITIAL .
  IF cust1 IS INITIAL.
    cust = 'STOCK ORDER'.
  ENDIF.

ENDIF.






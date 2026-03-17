*BREAK primus.
wa_hdr = LS_BIL_INVOICE-HD_GEN.
it_item = LS_BIL_INVOICE-it_gen.
IT_ADR = LS_BIL_INVOICE-HD_ADR.
WA_TERMS = LS_BIL_INVOICE-HD_GEN_DESCRIPT.
WA_PURCH = LS_BIL_INVOICE-HD_REF.

SELECT knumv
      kposn
      kschl
      kbetr
      waers
      kwert
 FROM PRCD_ELEMENTS
* FROM konv
 INTO TABLE IT_KONV
 WHERE knumv = wa_hdr-kond_numb.

SORT IT_KONV BY kposn.



*LOOP AT IT_KONV INTO WA_KONV.
* CASE WA_KONV-KSCHL.
*    WHEN 'ULOC' .
*      GV_ULOC = GV_ULOC + WA_KONV-KWERT.
*    WHEN 'USTA'.
*      GV_USTA = GV_USTA + WA_KONV-KWERT.
*    WHEN 'UCOU'.
*      GV_UCOU = GV_UCOU + WA_KONV-KWERT.
*ENDLOOP.

SELECT SINGLE * FROM t052 INTO wa_t052
  WHERE ZTERM = wa_hdr-TERMS_PAYM.

SELECT SINGLE * FROM vbrp INTO wa_vbrp
  WHERE vbeln = wa_hdr-BIL_NUMBER.

SELECT SINGLE * FROM T001W INTO WA_T001W
  WHERE WERKS = WA_VBRP-WERKS.

SELECT SINGLE * FROM ADRC INTO WA_ADRC
  WHERE ADDRNUMBER = WA_T001W-ADRNR.

SELECT SINGLE * FROM LIKP INTO WA_LIKP
  WHERE VBELN = WA_VBRP-VGBEL.

DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt  TYPE tline,
      ls_mattxt  TYPE tline.

CLEAR: lv_lines, ls_mattxt.
      REFRESH lv_lines.
      lv_name = wa_hdr-BIL_NUMBER.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U004'
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
        LOOP AT lv_lines INTO wa_lines.
          IF NOT wa_lines-tdline IS INITIAL.
            CONCATENATE  wa_lines-tdline GV_CREDIT INTO GV_CREDIT SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        CONDENSE GV_CREDIT.
      ENDIF.


CLEAR: lv_lines, ls_mattxt.
      REFRESH lv_lines.
      lv_name = wa_hdr-BIL_NUMBER.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U003'
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
        LOOP AT lv_lines INTO wa_lines.
          IF NOT wa_lines-tdline IS INITIAL.
            CONCATENATE GV_TRACK wa_lines-tdline INTO GV_TRACK SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        CONDENSE GV_TRACK.
      ENDIF.



BREAK PRIMUSABAP.

IF WA_HDR-BIL_TYPE = 'US05'.

    IF WA_HDR-BIL_DATE+4(2) = '01'.
      month = 'JAN'.

     ELSEIF WA_HDR-BIL_DATE+4(2) = '03'.
      month = 'MAR'.

ELSEIF WA_HDR-BIL_DATE+4(2) = '02'.
      month = 'FEB'.
ELSEIF WA_HDR-BIL_DATE+4(2) = '04'.
      month = 'APR'.
      ELSEIF WA_HDR-BIL_DATE+4(2) = '05'.
      month = 'MAY'.
ELSEIF WA_HDR-BIL_DATE+4(2) = '06'.
      month = 'JUN'.
ELSEIF WA_HDR-BIL_DATE+4(2) = '07'.
      month = 'JUL'.
ELSEIF WA_HDR-BIL_DATE+4(2) = '08'.
      month = 'AUG'.
ELSEIF WA_HDR-BIL_DATE+4(2) = '09'.
      month = 'SEP'.
ELSEIF WA_HDR-BIL_DATE+4(2) = '10'.
      month = 'OCT'.
ELSEIF WA_HDR-BIL_DATE+4(2) = '11'.
      month = 'NOV'.
ELSEIF WA_HDR-BIL_DATE+4(2) = '12'.
      month = 'DEC'.

ENDIF.

*CONCATENATE MONTH  WA_HDR-BIL_DATE+6(2) WA_HDR-BIL_DATE+0(4)
*INTO  GV_BILL_DATE SEPARATED BY '.'.
CONCATENATE WA_HDR-BIL_DATE+4(2)  WA_HDR-BIL_DATE+6(2) WA_HDR-BIL_DATE+0(4)
        INTO  GV_BILL_DATE SEPARATED BY '.'.



 ELSE.

   CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = WA_HDR-BIL_DATE
   IMPORTING
     OUTPUT        = GV_BILL_DATE.



TRANSLATE GV_BILL_DATE+0(3) TO LOWER CASE.
TRANSLATE GV_BILL_DATE+0(1) TO UPPER CASE.
*CONCATENATE  GV_BILL_DATE+0(3) GV_BILL_DATE+3(2) GV_BILL_DATE+5(4)
*                INTO GV_BILL_DATE SEPARATED BY '.'.

CONCATENATE  WA_HDR-BIL_DATE+4(2) GV_BILL_DATE+3(2) GV_BILL_DATE+5(4)
                INTO GV_BILL_DATE SEPARATED BY '.'.

ENDIF.
CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = WA_LIKP-WADAT
   IMPORTING
     OUTPUT        = GV_SHIP_DATE
            .
TRANSLATE GV_SHIP_DATE+0(3) TO LOWER CASE.
TRANSLATE GV_SHIP_DATE+0(1) TO UPPER CASE.
if wa_likp-wadat is not initial.
CONCATENATE  WA_LIKP-WADAT+4(2) GV_SHIP_DATE+3(2) GV_SHIP_DATE+5(4)
                INTO GV_SHIP_DATE SEPARATED BY '.'.
endif.
*CONCATENATE  GV_SHIP_DATE+0(3) GV_SHIP_DATE+3(2) GV_SHIP_DATE+5(4)
*                INTO GV_SHIP_DATE SEPARATED BY '.'.


*CLEAR: lt_lines, ls_mattxt,ls_lines.
*      REFRESH lv_lines.
*      lv_name = wa_hdr-BIL_NUMBER.
*      CALL FUNCTION 'READ_TEXT'
*        EXPORTING
*          client                  = sy-mandt
*          id                      = 'U005'
*          language                = sy-langu
*          name                    = lv_name
*          object                  = 'VBBK'
*        TABLES
*          lines                   = lt_lines
*        EXCEPTIONS
*          id                      = 1
*          language                = 2
*          name                    = 3
*          not_found               = 4
*          object                  = 5
*          reference_check         = 6
*          wrong_access_to_archive = 7
*          OTHERS                  = 8.
*      IF sy-subrc <> 0.
** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*      ENDIF.

CLEAR: lv_lines, ls_mattxt,gv_remark.
      REFRESH lv_lines.
      lv_name = wa_hdr-BIL_NUMBER.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U005'
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
        LOOP AT lv_lines INTO wa_lines.
          IF NOT wa_lines-tdline IS INITIAL.
            CONCATENATE gv_remark wa_lines-tdline INTO gv_remark SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        CONDENSE gv_remark.
      ENDIF.


CLEAR: lv_lines, ls_mattxt,GV_ref,wa_lines.
      REFRESH lv_lines.
      lv_name = wa_vbrp-aubel.
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

CLEAR: lv_lines, ls_mattxt,GV_SOREM,wa_lines.
      REFRESH lv_lines.
      lv_name = wa_vbrp-aubel.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U005'
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
        LOOP AT lv_lines INTO wa_lines.
          IF NOT wa_lines-tdline IS INITIAL.
            CONCATENATE GV_SOREM wa_lines-tdline  INTO GV_SOREM SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        CONDENSE GV_SOREM.
      ENDIF.

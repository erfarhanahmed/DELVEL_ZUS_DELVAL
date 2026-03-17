*&---------------------------------------------------------------------*
*& Report ZUS_CHNG_INFO_RECORD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_CHNG_INFO_RECORD.



TABLES:SSCRFIELDS.

TYPES: BEGIN OF ty_str,
       LIFNR(10),
       MATNR(18),
       DATAB(10),
       DATBI(10),
       END OF ty_str.

DATA :it_itab TYPE TABLE OF ty_str,
      wa_itab TYPE          ty_str.


TYPES: BEGIN OF t_error,
  excel_no(6) TYPE n,
  msg_typ,
  eror_msg(100),
  END OF t_error.


DATA: BDCDATA TYPE TABLE OF BDCDATA WITH HEADER LINE,
      IT_BDCMSGCOLL LIKE TABLE OF BDCMSGCOLL,
      WA_BDCMSGCOLL LIKE LINE OF IT_BDCMSGCOLL,
      TXT(4096) TYPE C OCCURS 0,
      excel_cnt TYPE i,
      excel_cnt_s TYPE i,
      excel_cnt_u TYPE i,
      n_excel_cnt(6) TYPE N,
      it_error TYPE TABLE OF t_error,
      wa_error TYPE t_error.


SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-002.
PARAMETERS : MY_FILE TYPE RLGRAP-FILENAME,
             ctu_mode LIKE ctu_params-dismode DEFAULT 'N'.
SELECTION-SCREEN : END OF BLOCK B1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR MY_FILE.

  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      PROGRAM_NAME  = SYST-CPROG
      DYNPRO_NUMBER = SYST-DYNNR
*     FIELD_NAME    = ' '
    IMPORTING
      FILE_NAME     = MY_FILE.

  START-OF-SELECTION.

CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
      I_TAB_RAW_DATA       = TXT
      I_FILENAME           = MY_FILE
    TABLES
      I_TAB_CONVERTED_DATA = it_itab
    EXCEPTIONS
      CONVERSION_FAILED    = 1
      OTHERS               = 2.
  IF SY-SUBRC <> 0.
    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
    WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

LOOP AT it_itab INTO wa_itab.
  excel_cnt = excel_cnt + 1.
  REFRESH :bdcdata,IT_BDCMSGCOLL.

perform bdc_dynpro      using 'SAPMM06I' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'EINA-LIFNR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'EINA-LIFNR'
                              WA_ITAB-LIFNR.          "'1100000'.
perform bdc_field       using 'EINA-MATNR'
                              WA_ITAB-MATNR.          "'138'.
perform bdc_field       using 'EINE-EKORG'
                              'US00'.
perform bdc_field       using 'EINE-WERKS'
                              'US01'.
perform bdc_field       using 'RM06I-NORMB'
                              'X'.
perform bdc_dynpro      using 'SAPMM06I' '0101'.
perform bdc_field       using 'BDC_CURSOR'
                              'EINA-MAHN1'.
perform bdc_field       using 'BDC_OKCODE'
                              '=KO'.
*perform bdc_field       using 'EINA-URZLA'
*                              'IN'.
*perform bdc_field       using 'EINA-REGIO'
*                              '13'.
*perform bdc_field       using 'EINA-VERKF'
*                              'Robbyn Hooks'.
*perform bdc_field       using 'EINA-MEINS'
*                              'NOS'.
*perform bdc_field       using 'EINA-UMREZ'
*                              '1'.
*perform bdc_field       using 'EINA-UMREN'
*                              '1'.
perform bdc_dynpro      using 'SAPLV14A' '0102'.
perform bdc_field       using 'BDC_CURSOR'
                              'VAKE-DATAB(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=PICK'.
perform bdc_dynpro      using 'SAPMV13A' '0201'.
perform bdc_field       using 'BDC_CURSOR'
                              'RV13A-DATAB'.
perform bdc_field       using 'BDC_OKCODE'
                              '=SICH'.
perform bdc_field       using 'RV13A-DATAB'
                              WA_ITAB-DATAB.            "'01.01.2019'.
perform bdc_field       using 'RV13A-DATBI'
                              WA_ITAB-DATBI.          "'31.12.9999'.

CALL TRANSACTION 'ME12' using  bdcdata
                            mode   ctu_mode
                            update 'S'
                            MESSAGES INTO IT_BDCMSGCOLL.

CLEAR WA_ITAB.

ENDLOOP.

LOOP AT IT_BDCMSGCOLL INTO WA_BDCMSGCOLL.

        CALL FUNCTION 'MESSAGE_TEXT_BUILD'
          EXPORTING
           MSGID     = WA_BDCMSGCOLL-MSGID
           MSGNR     = WA_BDCMSGCOLL-MSGNR
           MSGV1     = WA_BDCMSGCOLL-MSGV1
           MSGV2     = WA_BDCMSGCOLL-MSGV2
           MSGV3     = WA_BDCMSGCOLL-MSGV3
           MSGV4     = WA_BDCMSGCOLL-MSGV4
         IMPORTING
           MESSAGE_TEXT_OUTPUT       = wa_error-eror_msg.

        wa_error-excel_no = excel_cnt.
        wa_error-MSG_TYP = WA_BDCMSGCOLL-MSGTYP.
        APPEND wa_error TO it_error.
        CLEAR: wa_error, WA_BDCMSGCOLL.
ENDLOOP.
PERFORM report.

FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.                    "BDC_DYNPRO

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
  CLEAR BDCDATA.
  BDCDATA-FNAM = FNAM.
  BDCDATA-FVAL = FVAL.
  APPEND BDCDATA.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  REPORT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM report .
  TYPE-POOLS: SLIS.

DATA : it_fieldcat TYPE slis_t_fieldcat_alv WITH HEADER LINE,
       fs_layout  TYPE slis_layout_alv.

  it_fieldcat-col_pos   = 1.
  it_fieldcat-fieldname = 'EXCEL_NO'.
  it_fieldcat-tabname   = 'IT_ERROR'.
  it_fieldcat-seltext_m = 'Row no in Excel'.
  APPEND it_fieldcat.
  CLEAR it_fieldcat.

  it_fieldcat-col_pos   = 2.
  it_fieldcat-fieldname = 'MSG_TYP'.
  it_fieldcat-tabname   = 'IT_ERROR'.
  it_fieldcat-seltext_m = 'Message Type'.
  APPEND it_fieldcat.
  CLEAR it_fieldcat.

  it_fieldcat-col_pos   = 3.
  it_fieldcat-fieldname = 'EROR_MSG'.
  it_fieldcat-tabname   = 'IT_ERROR'.
  it_fieldcat-seltext_m = 'Message'.
  APPEND it_fieldcat.
  CLEAR it_fieldcat.

  fs_layout-colwidth_optimize = 'X'.
  fs_layout-zebra             = 'X'. " zebra

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = sy-repid
   I_CALLBACK_TOP_OF_PAGE            = 'TOP_OF_PAGE'
   IS_LAYOUT                         = fs_layout
   IT_FIELDCAT                       = it_fieldcat[]
  TABLES
    T_OUTTAB                          = IT_ERROR
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.
ENDFORM.

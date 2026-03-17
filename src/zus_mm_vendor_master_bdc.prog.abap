*&---------------------------------------------------------------------*
*& Report ZUS_MM_VENDOR_MASTER_BDC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_MM_VENDOR_MASTER_BDC
                no standard page heading line-size 255.
TABLES:SSCRFIELDS.

TYPES : BEGIN OF STR,
  BUKRS(004),       "Company Code
  EKORG(004),       "Purchasing Organisation
  KTOKK(004),       "Account Group
  TITLE_MEDI(30),    "title
  NAME1(40),         "NAME1
  SORT1(20),         "Search Term 1
  SORT2(20),         "Search Term 2
  STREET(60),         "STREET & House no
  str_suppl3(40),     "Street 4
  location(40),       "location
  CITY2(40),          "District
  POST_CODE1(10),      "City postal code
  CITY1(40),          "City
  COUNTRY(3),         "Country Key
  REGION(3),          "Region (State, Province, County)
  LANGU(1),           "Language Key
  TEL_NUMBER(30),     "First telephone no.: dialling code+number
  MOB_NUMBER(30),     "First Mobile Telephone No.: Dialing Code + Number
  FAX_NUMBER(30),     "First fax no.: dialling code+number
  SMTP_ADDR(241),     "E-Mail Address
  AKONT(010),       "Reconcilation Account
  ZTERM(004),       "payment Terms
  WAERS(005),       "Order Currency
  INCO1(003),       "Incoterms
  INCO2(028),       "Incoterms Desc.
  KALSK(002),       "Schema Group Vendor
  VERKF(030),       "Responsible Salesperson at Vendor's Office
  TELF1(016),       "Vendor's telephone number
  WEBRE(001),       "Indicator: GR-Based Invoice Verification
  LEBRE(001),       "Indicator for Service-Based Invoice Verification
  END OF STR.

TYPES: BEGIN OF t_error,
  excel_no(6) TYPE n,
  msg_typ,
  eror_msg(100),
  END OF t_error.



    DATA : IT_TAB     TYPE STANDARD TABLE OF STR,
           WA_TAB     TYPE STR,
           it_raw     TYPE truxs_t_text_data,
           excel_cnt TYPE i,
           IT_BDCMSGCOLL LIKE TABLE OF BDCMSGCOLL,
           WA_BDCMSGCOLL LIKE LINE OF IT_BDCMSGCOLL,
           it_error TYPE TABLE OF t_error,
           wa_error TYPE t_error,

           bdcmsgcoll type standard table of bdcmsgcoll,
           bdcdata    type standard table of bdcdata with header line.

   selection-screen : begin of block b1 with frame title text-001.
      parameters :  bdc_file type rlgrap-filename .
      PARAMETERS :  ctu_mode LIKE ctu_params-dismode DEFAULT 'A'.
   selection-screen : end of block  b1.


SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN PUSHBUTTON (25) W_BUTTON USER-COMMAND BUT1.
SELECTION-SCREEN END OF LINE.

INITIALIZATION.
* Add displayed text string to buttons
  W_BUTTON = 'Download Excel Template'.

  AT SELECTION-SCREEN.
  IF SSCRFIELDS-UCOMM EQ 'BUT1' .
    SUBMIT  ZUS_VENDOR_EXCEL VIA SELECTION-SCREEN .
  ENDIF.
* --------------------------------------------------------------
   at selection-screen on value-request for bdc_file.

  call function 'F4_FILENAME'
  exporting
   program_name        = syst-cprog
   dynpro_number       = syst-dynnr
   field_name          = ' '
  importing
   file_name           = bdc_file .
* --------------------------------------------------------------
  start-of-selection.
* --------------------------------------------------------------
  call function 'TEXT_CONVERT_XLS_TO_SAP'
  exporting
*   I_FIELD_SEPERATOR          =
    I_LINE_HEADER              = 'X'
    i_tab_raw_data             = it_raw
    i_filename                 = bdc_file
  tables
    i_tab_converted_data       = IT_TAB[]
  exceptions
   conversion_failed          = 1
   others                     = 2
          .
 if sy-subrc <> 0.
   message id sy-msgid type sy-msgty number sy-msgno
         with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
 endif .


LOOP AT IT_TAB INTO wa_tab.
excel_cnt = excel_cnt + 1.
  REFRESH :bdcdata,IT_BDCMSGCOLL.

perform bdc_dynpro      using 'SAPMF02K' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'USE_ZAV'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'RF02K-BUKRS'
                              wa_tab-bukrs .                     "  'US00'.
perform bdc_field       using 'RF02K-EKORG'
                              wa_tab-ekorg.                 "'US00'.
perform bdc_field       using 'RF02K-KTOKK'
                              wa_tab-ktokk.                   "'US01'.
perform bdc_field       using 'USE_ZAV'
                              'X'.
perform bdc_dynpro      using 'SAPMF02K' '0111'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BDC_CURSOR'
                              'SZA1_D0100-SMTP_ADDR'.
perform bdc_field       using 'SZA1_D0100-TITLE_MEDI'
                              wa_tab-title_medi.                  "'Company'.
perform bdc_field       using 'ADDR1_DATA-NAME1'
                              wa_tab-name1.                 "'Delval Flow Controls Pvt Ltd.'.
perform bdc_field       using 'ADDR1_DATA-SORT1'
                              wa_tab-sort1.                 "'Delval'.
perform bdc_field       using 'ADDR1_DATA-SORT2'
                              wa_tab-sort2.               "'Delval 2'.
perform bdc_field       using 'ADDR1_DATA-STREET'
                              wa_tab-street.              "'S NO 79/2 SHIVANE INDUSTRIL AREA'.
perform bdc_field       using 'ADDR1_DATA-STR_SUPPL3'
                              wa_tab-str_suppl3.          "'S NO 79/2 SHIVANE INDUSTRIL ARE1'.
perform bdc_field       using 'ADDR1_DATA-LOCATION'
                              wa_tab-location.            "'S NO 79/2 SHIVANE INDUSTRIL ARE2'.
perform bdc_field       using 'ADDR1_DATA-CITY2'
                              wa_tab-city2.                 "'X'.
perform bdc_field       using 'ADDR1_DATA-POST_CODE1'
                              wa_tab-post_code1.              "'411023'.
perform bdc_field       using 'ADDR1_DATA-CITY1'
                              wa_tab-city1.                 "'PUNE'.
perform bdc_field       using 'ADDR1_DATA-COUNTRY'
                              wa_tab-country.                   "'in'.
perform bdc_field       using 'ADDR1_DATA-REGION'
                              wa_tab-region.                    "'13'.
perform bdc_field       using 'ADDR1_DATA-LANGU'
                              wa_tab-langu.                 "'EN'.
perform bdc_field       using 'SZA1_D0100-TEL_NUMBER'
                              wa_tab-tel_number.              "'207-700121'.
perform bdc_field       using 'SZA1_D0100-MOB_NUMBER'
                              wa_tab-mob_number.            "'9503454098'.
perform bdc_field       using 'SZA1_D0100-FAX_NUMBER'
                              wa_tab-fax_number.            "'41'.
perform bdc_field       using 'SZA1_D0100-SMTP_ADDR'
                              wa_tab-smtp_addr.                 "'avinash.chaudhari@aacktechnocraf'.
perform bdc_dynpro      using 'SAPMF02K' '0120'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFA1-KUNNR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_dynpro      using 'SAPMF02K' '0130'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFBK-BANKS(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_dynpro      using 'SAPMF02K' '0380'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVK-NAMEV(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_dynpro      using 'SAPMF02K' '0210'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFB1-AKONT'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'LFB1-AKONT'
                              wa_tab-akont.                   "'20000'.
perform bdc_dynpro      using 'SAPMF02K' '0215'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFB1-ZTERM'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'LFB1-ZTERM'
                              wa_tab-zterm.                   "'U101'.
perform bdc_dynpro      using 'SAPMF02K' '0220'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFB5-MAHNA'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_dynpro      using 'SAPMF02K' '0310'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFM1-LEBRE'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'LFM1-WAERS'
                              wa_tab-waers.                         "'inr'.
perform bdc_field       using 'LFM1-INCO1'
                              wa_tab-inco1.                         "'CFR'.
perform bdc_field       using 'LFM1-INCO2'
                              wa_tab-inco2.                       "'Costs and freight'.
perform bdc_field       using 'LFM1-KALSK'
                              wa_tab-kalsk.                     "'U1'.
perform bdc_field       using 'LFM1-VERKF'
                              wa_tab-verkf.                   "'ARUN SHIROOR'.
perform bdc_field       using 'LFM1-TELF1'
                              wa_tab-telf1.                   "'7503456098'.
perform bdc_field       using 'LFM1-WEBRE'
                              wa_tab-webre.                   "'X'.
perform bdc_field       using 'LFM1-LEBRE'
                              wa_tab-lebre.                 "'X'.
perform bdc_dynpro      using 'SAPMF02K' '0320'.
perform bdc_field       using 'BDC_CURSOR'
                              'WYT3-PARVW(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=UPDA'.

call transaction 'XK01' using  bdcdata
                            mode   ctu_mode
                            update 'S'
                            MESSAGES INTO IT_BDCMSGCOLL.

CLEAR WA_TAB.

ENDLOOP.


*IF sy-subrc eq 0.
*MESSAGE 'Records Succesfully Uploaded' TYPE 'S'.
*ENDIF.

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

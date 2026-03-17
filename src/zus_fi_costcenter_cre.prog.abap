*&---------------------------------------------------------------------*
*& Report ZUS_FI_COSTCENTER_CRE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_FI_COSTCENTER_CRE.



* --------- DATA DECLARATION ------------------------------------------------
DATA : BDCDATA       TYPE STANDARD TABLE of BDCDATA   WITH HEADER LINE.
DATA : LT_BDCMSGCOLL TYPE STANDARD TABLE OF BDCMSGCOLL WITH HEADER LINE.
TYPES: trux_t_text_data(4096) type c occurs 0.
DATA : it_raw TYPE trux_t_text_data.
DATA : COUNT  TYPE I VALUE 0.
* -------- INTERNAL TABLE DECLARATION
DATA : BEGIN OF itab OCCURS 0,
         KOKRS(4)      , " Controlling Area
         KOSTL(10)     , " Cost Center
         DATAB_ANFO(10), " Valid From
         DATBI_ANFO(10), " Valid To
         KTEXT(20)     , " Name
         LTEXT(35)     , " Description
         VERAK_USER(20), " USER id
         VERAK(20)     , " Person Responsible
         ABTEI(12)     , " Department
         KOSAR(1)      , " Cost Center Category
         KHINR(12)     , " Hierarchy area
         BUKRS(4)      , " Company Code
         GSBER(4)      , " Business Area
         WAERS(5)      , " Currency
         PRCTR(10)     , " Profit Center.

      END OF itab.
* --------------------------------------------------------------

TABLES: sscrfields.

DATA : v_fullpath      TYPE string.

TYPES : BEGIN OF str_log,
        SAKNR(10),
        BUKRS(4),
END OF str_log.
DATA : it_log TYPE TABLE OF str_log,
      wa_log TYPE str_log.
TYPES : BEGIN OF ty_fieldnames,
  field_name(30)    TYPE C,         "Field names
END OF ty_fieldnames.

DATA : it_fieldnames TYPE TABLE OF ty_fieldnames.

DATA : wa_fieldnames TYPE ty_fieldnames.

INITIALIZATION.
* --------------------------------------------------------------
SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE GITL.
      PARAMETERS : ZVM      TYPE RLGRAP-FILENAME.
      PARAMETERS : ctu_mode LIKE ctu_params-dismode DEFAULT 'A'.
  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN PUSHBUTTON (25) w_button USER-COMMAND but1.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN:END OF BLOCK B1.

INITIALIZATION.
  GITL = 'WELMADE LOCKING SYSTEM'.

w_button = 'Download Excel Template'.

AT SELECTION-SCREEN.

IF sscrfields-ucomm EQ 'BUT1' .
  SUBMIT ZUS_FI_COSTCENTER_EXCEL VIA SELECTION-SCREEN .
ENDIF.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR ZVM.

CALL FUNCTION 'F4_FILENAME'
 EXPORTING
   PROGRAM_NAME        = SYST-CPROG
   DYNPRO_NUMBER       = SYST-DYNNR
   FIELD_NAME          = ' '
 IMPORTING
   FILE_NAME           = ZVM .
* --------------------------------------------------------------
start-of-selection.
* --------------------------------------------------------------

CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
EXPORTING
*   I_FIELD_SEPERATOR          =
    I_LINE_HEADER              = 'X'
    I_TAB_RAW_DATA             = it_raw
    I_FILENAME                 = ZVM
 TABLES
    I_TAB_CONVERTED_DATA       = ITAB[]
 EXCEPTIONS
   CONVERSION_FAILED          = 1
   OTHERS                     = 2
          .
IF SY-SUBRC <> 0.
 MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF .
* --------------------------------------------------------------

*DO 4 TIMES.
*
*  DELETE ITAB INDEX 1.
*
*ENDDO.

LOOP AT ITAB.
 CLEAR BDCDATA[].

perform bdc_dynpro      using 'SAPLKMA1' '0200'.
perform bdc_field       using 'BDC_CURSOR'
                              'CSKSZ-DATBI_ANFO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'CSKSZ-KOKRS'
                               itab-KOKRS.                               "'1000'.
perform bdc_field       using 'CSKSZ-KOSTL'
                               itab-KOSTL.                               "  '1003OP0006'.
perform bdc_field       using 'CSKSZ-DATAB_ANFO'
                               itab-DATAB_ANFO.                              "  '01.01.2017'.
perform bdc_field       using 'CSKSZ-DATBI_ANFO'
                               itab-DATBI_ANFO.                                "'31.12.9999'.
perform bdc_dynpro      using 'SAPLKMA1' '0299'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BDC_CURSOR'
                              'CSKSZ-PRCTR'.
perform bdc_field       using 'CSKSZ-KTEXT'
                               itab-KTEXT.                                "    'Test'.
perform bdc_field       using 'CSKSZ-LTEXT'
                               itab-LTEXT.                               " 'Test'.
perform bdc_field       using 'CSKSZ-VERAK_USER'
                               itab-VERAK_USER.                               " 'FICON'.
perform bdc_field       using 'CSKSZ-VERAK'
                               itab-VERAK.                              "    'Spectrum'.
perform bdc_field       using 'CSKSZ-ABTEI'
                               itab-ABTEI.                                  "   'Finance'.
perform bdc_field       using 'CSKSZ-KOSAR'
                               itab-KOSAR.                                 " 'F'.
perform bdc_field       using 'CSKSZ-KHINR'
                               itab-KHINR.                                " '10030902'.

perform bdc_field       using 'CSKSZ-BUKRS'
                               itab-BUKRS.                                " '10030902'.

perform bdc_field       using 'CSKSZ-WAERS'
                               itab-WAERS.                               " 'INR'.
perform bdc_field       using 'CSKSZ-PRCTR'
                               itab-PRCTR.                              "   '1003'.
perform bdc_dynpro      using 'SAPLKMA1' '0299'.
perform bdc_field       using 'BDC_OKCODE'
                              '=KOMM'.
perform bdc_dynpro      using 'SAPLKMA1' '0299'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BDC_CURSOR'
                              'CSKSZ-SPRAS'.
perform bdc_field       using 'CSKSZ-SPRAS'
                                'EN'.
perform bdc_dynpro      using 'SAPLKMA1' '0299'.
perform bdc_field       using 'BDC_OKCODE'
                              '=BU'.
* --------------------------------------------------------------
    CALL TRANSACTION 'KS01' USING  BDCDATA
                            mode   ctu_mode
                            update 'S'
                            MESSAGES INTO LT_BDCMSGCOLL .
* --------------------------------------------------------------
     count  = count + 1 .
* --------------------------------------------------------------
ENDLOOP.


LOOP AT LT_BDCMSGCOLL.

WRITE :/ LT_BDCMSGCOLL-MSGID,
           LT_BDCMSGCOLL-MSGV1,
           LT_BDCMSGCOLL-MSGV2.
           APPEND LT_BDCMSGCOLL.
ENDLOOP.

CALL FUNCTION 'GUI_FILE_SAVE_DIALOG'
  EXPORTING
    window_title      = 'STATUS RECORD FILE'
    default_extension = '.xls'
  IMPORTING
*     filename          = v_efile
    fullpath          = v_fullpath.

CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
    filename                = v_fullpath
    filetype                = 'ASC'
    write_field_separator   = 'X'
  TABLES
    data_tab                = it_log
    fieldnames              = it_fieldnames
  EXCEPTIONS
    file_write_error        = 1
    no_batch                = 2
    gui_refuse_filetransfer = 3
    invalid_type            = 4
    no_authority            = 5
    unknown_error           = 6
    header_not_allowed      = 7
    separator_not_allowed   = 8
    filesize_not_allowed    = 9
    header_too_long         = 10
    dp_error_create         = 11
    dp_error_send           = 12
    dp_error_write          = 13
    unknown_dp_error        = 14
    access_denied           = 15
    dp_out_of_memory        = 16
    disk_full               = 17
    dp_timeout              = 18
    file_not_found          = 19
    dataprovider_exception  = 20
    control_flush_error     = 21
    OTHERS                  = 22.
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.
* --------------------------------------------------------------
WRITE : / 'Successfuly records inserted ' , count.
* --------------------------------------------------------------
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.

FORM BDC_FIELD USING FNAM FVAL.
  CLEAR BDCDATA.
  BDCDATA-FNAM = FNAM.
  BDCDATA-FVAL = FVAL.
  APPEND BDCDATA.
ENDFORM.

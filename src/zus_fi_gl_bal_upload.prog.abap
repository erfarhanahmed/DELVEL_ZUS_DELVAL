*&---------------------------------------------------------------------*
*& Report ZUS_FI_GL_BAL_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_FI_GL_BAL_UPLOAD

       no standard page heading line-size 255.
TABLES: sscrfields.


DATA : it_bdcmsgcoll TYPE STANDARD TABLE OF bdcmsgcoll,
       wa_bdcmsgcoll TYPE bdcmsgcoll.
DATA : cnt(3)        TYPE n,
       v_message(50).
DATA : count  TYPE i VALUE 0.
TYPES: trux_t_text_data(4096) TYPE c OCCURS 0.
DATA : it_raw TYPE trux_t_text_data.

TYPES: BEGIN OF ty_fb01,
        bldat(10),    "Document Date
        blart(04),    "Document Type
        bukrs(04),    "Company Code
        budat(10),    "Posting Date
*        monat(02),    "Period
        waers(05),    "Currency
        kursf(14),    "Rate
        xblnr(16),    "Reference
        bktxt(25),    "Doc.Header Text
        newbs(02),   "Posting Key
        newko(17),   "Account


        wrbtr(15),   "Amount

        SGTXT(50),
        NEWBS_new(02),
        NEWKO_new(17),
        prctr(10),
        wrbtr_new(15),
        kostl(10),
        SGTXT_new(50),


       END OF ty_fb01.
 DATA: itab TYPE TABLE OF ty_FB01 WITH HEADER LINE.

DATA: bdcdata like bdcdata OCCURS 0 WITH HEADER LINE.
DATA: text(4096) TYPE c OCCURS 0.

*DATA: T_RAW TYPE TRUXS_T_TEXT_DATA.

* --------------------------------------------------------------
INITIALIZATION.
* --------------------------------------------------------------
  SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-003.
  PARAMETERS     : voli1 TYPE rlgrap-filename.
  PARAMETERS     : ctu_mode  LIKE ctu_params-dismode DEFAULT 'A'.
  SELECTION-SCREEN : END OF BLOCK  b1.
* --------------------------------------------------------------

  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN PUSHBUTTON (25) w_button USER-COMMAND but1.
  SELECTION-SCREEN END OF LINE.

* Add displayed text string to buttons
  w_button = 'Download Excel Template'.

* ============================================================
AT SELECTION-SCREEN.
  IF sscrfields-ucomm EQ 'BUT1' .
    SUBMIT ZUS_FI_GL_BAL_UPLOAD_EXCEL VIA SELECTION-SCREEN .
    ENDIF.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR voli1.

  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
      field_name    = ' '
    IMPORTING
      file_name     = voli1.
* --------------------------------------------------------------
START-OF-SELECTION.
* --------------------------------------------------------------
  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
*     I_FIELD_SEPERATOR    =
      i_line_header        = 'X'
      i_tab_raw_data       = it_raw
      i_filename           = voli1
    TABLES
      i_tab_converted_data = itab[]
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF .
  cnt = 2.


  LOOP AT itab.
*BREAK primus.
    REFRESH: bdcdata, it_bdcmsgcoll.
*if ITAB-NEWBS eq '40'." AND ITAB-NEWUM IS INITIAL.
perform bdc_dynpro      using 'SAPMF05A' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BKPF-BLDAT'
                              itab-bldat                   . "    '14.09.2018'.
perform bdc_field       using 'BKPF-BLART'
                              itab-blart                    ."'ue'.
perform bdc_field       using 'BKPF-BUKRS'
                              itab-bukrs                   . "'us00'.
perform bdc_field       using 'BKPF-BUDAT'
                              itab-budat                  .  "'14.09.2018'.
*perform bdc_field       using 'BKPF-MONAT'
*                              '6'.
perform bdc_field       using 'BKPF-WAERS'
                              itab-waers                 .   "'usd'.
perform bdc_field       using 'BKPF-KURSF'
                              itab-kursf                .    "'80.00'.
perform bdc_field       using 'BKPF-XBLNR'
                              itab-xblnr               .     "'Test1'.
perform bdc_field       using 'BKPF-BKTXT'
                              itab-bktxt              .      "'Test12'.
perform bdc_field       using 'FS006-DOCID'
                              '*'.
perform bdc_field       using 'RF05A-NEWBS'
                              itab-newbs             .        "'40'.
perform bdc_field       using 'RF05A-NEWKO'
                              itab-newko            .         "'90001'.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-wrbtr           .         "'700.00'.
perform bdc_field       using 'BSEG-SGTXT'
                              itab-sgtxt          .          "'Bal upload'.
perform bdc_field       using 'RF05A-NEWBS'
                              itab-newbs_new     .           "'50'.
perform bdc_field       using 'RF05A-NEWKO'
                              itab-newko_new    .            "'60000'.
*perform bdc_field       using 'DKACB-FMORE'
*                              'X'.

perform bdc_dynpro      using 'SAPLKACB' '0002'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'COBL-PRCTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
*IF itab-prctr IS NOT INITIAL.
*perform bdc_field       using 'COBL-PRCTR'
*                              itab-prctr       .             "'PRUS01_01'.
*ENDIF.

perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-WRBTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-wrbtr_new  .              "'700.00'.
perform bdc_field       using 'DKACB-FMORE'
                              'X'.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-KOSTL'. "'COBL-PRCTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
IF itab-kostl is NOT INITIAL .
perform bdc_field       using 'COBL-KOSTL'
                              itab-kostl     .               "'G1001001'.
ENDIF.
IF itab-prctr IS NOT INITIAL.
perform bdc_field       using 'COBL-PRCTR'
                              itab-prctr    .             "''.
ENDIF.

perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-SGTXT'.
perform bdc_field       using 'BDC_OKCODE'
                              '=BU'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-wrbtr_new.                "'700.00'.
perform bdc_field       using 'BSEG-SGTXT'
                              itab-sgtxt_new  .                  "'Bal upload'.
perform bdc_field       using 'DKACB-FMORE'
                              'X'.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-KOSTL'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
IF itab-kostl is NOT INITIAL.
perform bdc_field       using 'COBL-KOSTL'
                              itab-kostl .                     "'G1001001'.
ENDIF.

IF itab-prctr IS NOT INITIAL.
perform bdc_field       using 'COBL-PRCTR'
                              itab-prctr.                      "'PRUS01_01'.
ENDIF.



CALL TRANSACTION 'F-02' USING BDCDATA
      MODE ctu_mode
      UPDATE 'S' MESSAGES INTO it_bdcmsgcoll .

    count = count + 1.
* ------------------------------------------------------------------
*        Formating Error Msg
*---------------------------------------------------------------------
*    BREAK-POINT.
    LOOP AT it_bdcmsgcoll INTO wa_bdcmsgcoll.         "" added by Ashlesha

      CALL FUNCTION 'FORMAT_MESSAGE'                  "Formatting a T100 message
        EXPORTING
          id        = wa_bdcmsgcoll-msgid
          lang      = sy-langu
          no        = wa_bdcmsgcoll-msgnr
          v1        = wa_bdcmsgcoll-msgv1
          v2        = wa_bdcmsgcoll-msgv2
          v3        = wa_bdcmsgcoll-msgv3
          v4        = wa_bdcmsgcoll-msgv4
        IMPORTING
          msg       = v_message
        EXCEPTIONS
          not_found = 1
          OTHERS    = 2.

      IF wa_bdcmsgcoll-msgv1 IS NOT INITIAL AND wa_bdcmsgcoll-msgtyp = 'S'.
        WRITE:/ v_message.
      ENDIF.
*
      IF  wa_bdcmsgcoll-msgtyp = 'E'.

        WRITE:/ v_message ,' Error in Count'.

      ENDIF.

      CLEAR :cnt,v_message.

    ENDLOOP.
*
ENDLOOP.
* --------------------------------------------------------------
*  WRITE : / 'successfuly records inserted ' , count.
* --------------------------------------------------------------
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.
*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
*  IF FVAL <> NODATA.
    CLEAR BDCDATA.
    BDCDATA-FNAM = FNAM.
    BDCDATA-FVAL = FVAL.
    APPEND BDCDATA.
*  ENDIF.
ENDFORM.

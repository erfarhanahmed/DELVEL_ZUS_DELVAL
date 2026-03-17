report ZUS_FI_CUST_DOWNPAY_UPLOAD
       no standard page heading line-size 255.


TABLES: sscrfields.
* --------- DATA DECLARATION ----------------------------------------


DATA : bdcdata       TYPE STANDARD TABLE OF bdcdata WITH HEADER LINE.
DATA : it_bdcmsgcoll TYPE STANDARD TABLE OF bdcmsgcoll,
       wa_bdcmsgcoll TYPE bdcmsgcoll.
DATA : cnt(3)        TYPE n,
       v_message(50).
TYPES: trux_t_text_data(4096) TYPE c OCCURS 0.
DATA : it_raw TYPE trux_t_text_data.
DATA : count  TYPE i VALUE 0.

TYPES : BEGIN OF ty_itab,
        BLDAT(10),    "Document Date
        BLART(04),    "Document Type
        BUKRS(04),    "Company Code
        BUDAT(10),    "Posting Date
        WAERS(05),    "Currency
        KURSF(14),    "Rate
        XBLNR(16),    "Reference
        BKTXT(25),    "Doc.Header Text
        NEWBS(02),   "Posting Key
        NEWKO(17),   "Account
        NEWUM(01),    "SGL Ind
        WRBTR(15),   "Amount
        ZFBDT(10),    "Bline Date
        SGTXT(50),    "Text
        NEWBS_NEW(02),
        NEWKO_NEW(17),
        WRBTR_NEW(15),
        PRCTR(10),    "Profit Center
        SGTXT_NEW(50),    "Text
        END OF ty_itab.
DATA: itab TYPE TABLE OF ty_itab WITH HEADER LINE.

* --------------------------------------------------------------
INITIALIZATION.
* --------------------------------------------  ------------------
  SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-005.
  PARAMETERS     : voli1 TYPE rlgrap-filename.
  PARAMETERS     : ctu_mode  LIKE ctu_params-dismode DEFAULT 'A'.
  SELECTION-SCREEN: END OF BLOCK  b1.

  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN PUSHBUTTON (25) w_button USER-COMMAND but1.
  SELECTION-SCREEN END OF LINE.

* Add displayed text string to buttons
  w_button = 'Download Excel Template'.
* ============================================================
AT SELECTION-SCREEN.
  IF sscrfields-ucomm EQ 'BUT1' .
    SUBMIT ZUS_FI_CUST_DOWNPAY_EXCEL VIA SELECTION-SCREEN .
    ENDIF.

* --------------------------------------------------------------
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
  REFRESH BDCDATA[].

perform bdc_dynpro      using 'SAPMF05A' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWUM'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BKPF-BLDAT'
                               itab-BLDAT.                            "'26.09.2018'.
perform bdc_field       using 'BKPF-BLART'
                              itab-BLART.                             "'ue'.
perform bdc_field       using 'BKPF-BUKRS'
                              itab-BUKRS.                             "'us00'.
perform bdc_field       using 'BKPF-BUDAT'
                              itab-BUDAT.                             "'26.09.2018'.
*perform bdc_field       using 'BKPF-MONAT'
*                              '6'.
perform bdc_field       using 'BKPF-WAERS'
                              itab-WAERS.                             "'usd'.
perform bdc_field       using 'BKPF-KURSF'
                              itab-KURSF.                               "'1'.
perform bdc_field       using 'BKPF-XBLNR'
                              itab-xblnr.                   "'Test1'.
perform bdc_field       using 'BKPF-BKTXT'
                              itab-bktxt.                   "'test1'.
perform bdc_field       using 'FS006-DOCID'
                              '*'.
perform bdc_field       using 'RF05A-NEWBS'
                              itab-NEWBS.                               "'29'.
perform bdc_field       using 'RF05A-NEWKO'
                              itab-NEWKO.                               "'1000000'.
perform bdc_field       using 'RF05A-NEWUM'
                              itab-NEWUM.                                "'a'.
perform bdc_dynpro      using 'SAPMF05A' '0304'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-WRBTR.                               "'1000'.
perform bdc_field       using 'BSEG-ZFBDT'
                              itab-ZFBDT.                             "'26.09.2018'.
perform bdc_field       using 'BSEG-SGTXT'
                              itab-SGTXT.                             "'Down Payment'.
perform bdc_field       using 'RF05A-NEWBS'
                              itab-NEWBS_NEW.                          "'50'.
perform bdc_field       using 'RF05A-NEWKO'
                              itab-NEWKO_NEW.                            "'90003'.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-WRBTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-WRBTR_NEW.                             "'1000'.
perform bdc_field       using 'DKACB-FMORE'
                              'X'.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-PRCTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
perform bdc_field       using 'COBL-PRCTR'
                              itab-PRCTR.                               "'PRUS01_05'.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-SGTXT'.
perform bdc_field       using 'BDC_OKCODE'
                              '=BU'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-WRBTR_NEW.                           "'1,000.00'.
perform bdc_field       using 'BSEG-SGTXT'
                              itab-SGTXT_NEW.                           "'Test'.
perform bdc_field       using 'DKACB-FMORE'
                              'X'.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-PRCTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
perform bdc_field       using 'COBL-PRCTR'
                              itab-PRCTR..                            "'PRUS01_05'.

CALL TRANSACTION 'F-02' USING BDCDATA
      MODE ctu_mode
      UPDATE 'S' MESSAGES INTO it_bdcmsgcoll .
* --------------------------------------------------------------
    count = count + 1.
* --------------------------------------------------------------

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

      IF  wa_bdcmsgcoll-msgtyp = 'E'.

        WRITE:/ v_message ,' Error in Count'.

      ENDIF.

      CLEAR :cnt,v_message.

    ENDLOOP.

ENDLOOP.
* --------------------------------------------------------------
*  WRITE : / 'No of successfuly records inserted ' , count.
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

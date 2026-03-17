*&------------------------------------------------------------------*
*& Report ZUS_FI_VENDOR_OPEN_ITEM


REPORT ZUS_FI_VENDOR_OPEN_ITEM.


TABLES: bkpf,rf05a,bseg.
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

""""""""""""""""""""""""""""""""""
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
*        NEWUM(01),    "SGL Ind
        wrbtr(15),   "Amount
*        ZTERM(04),
        ZFBDT(10),
        SGTXT(50),
*
*        BUPLA(04),
*        SECCO(04),
*
*        ZUONR(18),

        NEWBS_new(02),
        NEWKO_new(17),

        wrbtr_new(15),
        prctr(10),
*        BUPLA_NEW(04),

*        ZUONR_new(18),
        SGTXT_new(50),
*        FMORE(01),

       END OF ty_fb01.
 DATA: itab TYPE TABLE OF ty_FB01 WITH HEADER LINE.
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
    SUBMIT zus_fi_vendor_open_excel VIA SELECTION-SCREEN .
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
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BKPF-BLDAT'
                              itab-bldat.               "'26.09.2018'.
perform bdc_field       using 'BKPF-BLART'
                              itab-blart.                   "'UE'.
perform bdc_field       using 'BKPF-BUKRS'
                              itab-bukrs.                   "'US00'.
perform bdc_field       using 'BKPF-BUDAT'
                              itab-budat.                    "'26.09.2018'.
*perform bdc_field       using 'BKPF-MONAT'
*                              '6'.
perform bdc_field       using 'BKPF-WAERS'
                              itab-waers.                 "  'usd'.
perform bdc_field       using 'BKPF-KURSF'
                              itab-kursf.                   "'1'.
perform bdc_field       using 'BKPF-XBLNR'
                              itab-xblnr.                   "'Test1'.
perform bdc_field       using 'BKPF-BKTXT'
                              itab-bktxt.                   "'test1'.
perform bdc_field       using 'FS006-DOCID'
                              '*'.
perform bdc_field       using 'RF05A-NEWBS'
                              itab-newbs.                     "'31'.
perform bdc_field       using 'RF05A-NEWKO'
                              itab-newko.                   "'1000000'.
perform bdc_dynpro      using 'SAPMF05A' '0302'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-wrbtr.                           "'100'.
perform bdc_field       using 'BSEG-MWSKZ'
                              '**'.
*perform bdc_field       using 'BSEG-ZTERM'
*                              itab-zterm.                           "'U104'.
perform bdc_field       using 'BSEG-ZFBDT'
                              itab-zfbdt.                           "'26.09.2018'.
perform bdc_field       using 'BSEG-SGTXT'
                              itab-sgtxt.                          "'Open Line item'.
perform bdc_field       using 'RF05A-NEWBS'
                              itab-newbs_new .                  "'40'.
perform bdc_field       using 'RF05A-NEWKO'
                              itab-newko_new.                   "'90003'.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-WRBTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-wrbtr_new.                     "'100'.
perform bdc_field       using 'DKACB-FMORE'
                              'X'.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-PRCTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
perform bdc_field       using 'COBL-PRCTR'
                              itab-prctr.                   "'PRUS01_01'.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-SGTXT'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-wrbtr_new.                   "'100.00'.
perform bdc_field       using 'BSEG-SGTXT'
                              itab-sgtxt_new.                   "'Open Line item'.
perform bdc_field       using 'DKACB-FMORE'
                              'X'.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-PRCTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
perform bdc_field       using 'COBL-PRCTR'
                              itab-prctr.                           "'PRUS01_01'.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-WRBTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=BU'.
perform bdc_field       using 'BSEG-WRBTR'
                              itab-wrbtr_new.           "'100.00'.
perform bdc_field       using 'BSEG-SGTXT'
                              itab-sgtxt_new.                 "'Open Line item'.
perform bdc_field       using 'DKACB-FMORE'
                              'X'.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-PRCTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
perform bdc_field       using 'COBL-PRCTR'
                              itab-prctr.                           "'PRUS01_01'.



*
*if ITAB-NEWBS eq '31' AND ITAB-NEWUM IS INITIAL.
*"*************** 1 st recording **********************
*perform bdc_dynpro      using 'SAPMF05A' '0100'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'RF05A-NEWKO'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BKPF-BLDAT'
*                              itab-BLDAT.                                               "'15.03.2018'.
*perform bdc_field       using 'BKPF-BLART'
*                              itab-BLART.                                            "'SA'.
*perform bdc_field       using 'BKPF-BUKRS'
*                              itab-BUKRS.                                         "'1000'.
*perform bdc_field       using 'BKPF-BUDAT'
*                              itab-BUDAT.                                          "'31.03.2018'.
**perform bdc_field       using 'BKPF-MONAT'
**                              itab-BUDAT+4(2).                                         " '1'.
*perform bdc_field       using 'BKPF-WAERS'
*                              itab-WAERS.                                             "'INR'.
*perform bdc_field       using 'BKPF-KURSF'
*                              itab-KURSF.                                                      " '1'.
*perform bdc_field       using 'BKPF-XBLNR'
*                              itab-XBLNR.                                           "'REF 112'.
*perform bdc_field       using 'BKPF-BKTXT'
*                              itab-BKTXT.                                          "'Header Text 112'.
*perform bdc_field       using 'FS006-DOCID'
*                              '*'.
*perform bdc_field       using 'RF05A-NEWBS'
*                               ITAB-NEWBS.                                                 " '31'.
*perform bdc_field       using 'RF05A-NEWKO'
*                              ITAB-NEWKO.    " '3100000000'.
*"""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*perform bdc_dynpro      using 'SAPMF05A' '0302'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'RF05A-NEWKO'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BSEG-WRBTR'
*                              itab-wrbtr.                                          " '110'.
*perform bdc_field       using 'BSEG-BUPLA'
*                              itab-BUPLA.               "'1000'.
*perform bdc_field       using 'BSEG-SECCO'
*                               itab-SECCO.          "'1000'.
*perform bdc_field       using 'BSEG-ZTERM'
*                               itab-ZTERM.           "'V001'.
*perform bdc_field       using 'BSEG-ZFBDT'
*                               itab-ZFBDT.               "'01.03.2018'.
*perform bdc_field       using 'BSEG-ZUONR'
*                               itab-ZUONR.                " 'Assignemt 1'.
*perform bdc_field       using 'BSEG-SGTXT'
*                               itab-SGTXT.              "'Text 1'.
*perform bdc_field       using 'RF05A-NEWBS'
*                               itab-NEWBS_NEW.            "'40'.
*perform bdc_field       using 'RF05A-NEWKO'
*                               itab-NEWKO_NEW.                 "'50000004'.
*
*"""""""""""""""""""""""""""""""""""""""""""""""""""""
*perform bdc_dynpro      using 'SAPMF05A' '0300'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'BSEG-SGTXT'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BSEG-WRBTR'
*                              itab-wrbtr_NEW.                    " '110'.
*perform bdc_field       using 'BSEG-BUPLA'
*                               itab-BUPLA_NEW.                "'1000'.
*perform bdc_field       using 'BSEG-ZUONR'
*                               itab-ZUONR_new.              "'Assignemt 2'.
*perform bdc_field       using 'BSEG-SGTXT'
*                               itab-SGTXT_new.                " 'Text 2'.
*perform bdc_field       using 'DKACB-FMORE'
*                              'X'.
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
*perform bdc_dynpro      using 'SAPLKACB' '0002'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'COBL-PRCTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=ENTE'.
*perform bdc_field       using 'COBL-PRCTR'
*                              itab-prctr.            "'1001'.
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*perform bdc_dynpro      using 'SAPMF05A' '0300'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'BSEG-WRBTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=BU'.
*perform bdc_field       using 'BSEG-WRBTR'
*                               itab-wrbtr_new.                  " '110.00'.
*perform bdc_field       using 'BSEG-BUPLA'
*                               itab-BUPLA_new.              " '1000'.
*perform bdc_field       using 'BSEG-ZUONR'
*                               itab-ZUONR_new.                " 'Assignemt 2'.
*perform bdc_field       using 'BSEG-SGTXT'
*                                itab-SGTXT_new.  "              'Text 2'.
*perform bdc_field       using 'DKACB-FMORE'
*                              'X'.
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*perform bdc_dynpro      using 'SAPLKACB' '0002'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'COBL-PRCTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=ENTE'.
*perform bdc_field       using 'COBL-PRCTR'
*                              itab-prctr.                " '1001'.
*
*ELSEIF ITAB-NEWBS eq '29' AND ITAB-NEWUM is NOT INITIAL.
*""""""""*************** 2 nd recording***********************************
*
*perform bdc_dynpro      using 'SAPMF05A' '0100'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'RF05A-NEWUM'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BKPF-BLDAT'
*                               itab-BLDAT.                " '15.03.2018'.
*perform bdc_field       using 'BKPF-BLART'
*                              itab-BLART.                      "'SA'.
*perform bdc_field       using 'BKPF-BUKRS'
*                              itab-BUKRS.                       "'1000'.
*perform bdc_field       using 'BKPF-BUDAT'
*                              itab-BUDAT.                 " '31.03.2018'.
**perform bdc_field       using 'BKPF-MONAT'
**                               itab-BUDAT+4(2).                      "'1'.
*perform bdc_field       using 'BKPF-WAERS'
*                              itab-WAERS.                    " 'INR'.
*perform bdc_field       using 'BKPF-KURSF'
*                              itab-KURSF.                   "'1'.
*perform bdc_field       using 'BKPF-XBLNR'
*                               itab-XBLNR.                 "'REF 112ADV'.
*perform bdc_field       using 'BKPF-BKTXT'
*                              itab-BKTXT.                     "'Header Text 112ADV'.
*perform bdc_field       using 'FS006-DOCID'
*                              '*'.
*perform bdc_field       using 'RF05A-NEWBS'
*                                itab-NEWBS.                           "'29'.
*perform bdc_field       using 'RF05A-NEWKO'
*                               itab-NEWKO.                           "'3100000000'.
*perform bdc_field       using 'RF05A-NEWUM'
*                               itab-NEWUM.                               "'0'.
*
*""""""""""""""""""""""""""""""""""""""""""""
*perform bdc_dynpro      using 'SAPMF05A' '0304'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'RF05A-NEWKO'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BSEG-WRBTR'
*                               itab-WRBTR.             " '100'.
*perform bdc_field       using 'BSEG-BUPLA'
*                               itab-BUPLA.               "'1000'.
*perform bdc_field       using 'BSEG-SECCO'
*                               itab-SECCO.                   "'1000'.
*perform bdc_field       using 'BSEG-GSBER'
*                                ''.
*perform bdc_field       using 'BSEG-ZUONR'
*                              itab-ZUONR.                     " 'Assignemt 1'.
*perform bdc_field       using 'BSEG-SGTXT'
*                              itab-SGTXT.               "'Text 1'.
*perform bdc_field       using 'RF05A-NEWBS'
*                              itab-NEWBS_NEW.                "'50'.
*perform bdc_field       using 'RF05A-NEWKO'
*                              itab-NEWKO_NEW.                  " '50000004'.
*
*""""""""""""""""""""""""""""""""""""""""""""""
*perform bdc_dynpro      using 'SAPMF05A' '0300'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'BSEG-SGTXT'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BSEG-WRBTR'
*                               itab-WRBTR_NEW.                  "'100'.
*perform bdc_field       using 'BSEG-BUPLA'
*                               itab-BUPLA_NEW.                       "'1000'.
*perform bdc_field       using 'BSEG-ZUONR'
*                               itab-ZUONR_new.                  "'Assignemt 2'.
*perform bdc_field       using 'BSEG-SGTXT'
*                               itab-SGTXT_new.                         "'Text 2'.
*perform bdc_field       using 'DKACB-FMORE'
*                              'X'.
*""""""""""""""""""""""""""""""""""""""'
*perform bdc_dynpro      using 'SAPLKACB' '0002'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'COBL-PRCTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=ENTE'.
*perform bdc_field       using 'COBL-PRCTR'
*                               itab-PRCTR.          "'1001'.
*
*perform bdc_dynpro      using 'SAPMF05A' '0300'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'BSEG-WRBTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=BU'.
*perform bdc_field       using 'BSEG-WRBTR'
*                               itab-WRBTR_NEW.          "  '100.00'.
*perform bdc_field       using 'BSEG-BUPLA'
*                               itab-BUPLA_NEW.              "'1000'.
*perform bdc_field       using 'BSEG-ZUONR'
*                               itab-ZUONR_new.                   "'Assignemt 2'.
*perform bdc_field       using 'BSEG-SGTXT'
*                               itab-SGTXT_new.                  "'Text 2'.
*perform bdc_field       using 'DKACB-FMORE'
*                              'X'.
*""""""""""""""""""""""""""""""""""""""""""""""
*perform bdc_dynpro      using 'SAPLKACB' '0002'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'COBL-PRCTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=ENTE'.
*perform bdc_field       using 'COBL-PRCTR'
*                               itab-PRCTR.            "  '1001'.
*
*ELSEIF ITAB-NEWBS eq '21' AND ITAB-NEWUM IS INITIAL.
*"****************3 rd recording***********************************
*
*perform bdc_dynpro      using 'SAPMF05A' '0100'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'RF05A-NEWUM'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BKPF-BLDAT'
*                               itab-BLDAT.                    " '15.03.2018'.
*perform bdc_field       using 'BKPF-BLART'
*                              itab-BLART.                 "'SA'.
*perform bdc_field       using 'BKPF-BUKRS'
*                               itab-BUKRS.               " '1000'.
*perform bdc_field       using 'BKPF-BUDAT'
*                               itab-BUDAT.             " '31.03.2018'.
**perform bdc_field       using 'BKPF-MONAT'
**                               itab-BUDAT+4(2).                    "'1'.
*perform bdc_field       using 'BKPF-WAERS'
*                              itab-WAERS.                 "'INR'.
*perform bdc_field       using 'BKPF-KURSF'
*                               itab-KURSF.                    "'1'.
*perform bdc_field       using 'BKPF-XBLNR'
*                               itab-XBLNR.                  " 'REF 112Debit Not'.
*perform bdc_field       using 'BKPF-BKTXT'
*                               itab-BKTXT.                "'Header Text 112Debit Note'.
*perform bdc_field       using 'FS006-DOCID'
*                              '*'.
*perform bdc_field       using 'RF05A-NEWBS'
*                              itab-NEWBS.                       " '21'.
*perform bdc_field       using 'RF05A-NEWKO'
*                              itab-NEWKO.                " '3100000000'.
*
*""""""""""""""""""""""""""""""""""""""""""""""""""""
*perform bdc_dynpro      using 'SAPMF05A' '0302'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'RF05A-NEWKO'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BSEG-WRBTR'
*                               itab-WRBTR.                     " '120'.
*perform bdc_field       using 'BSEG-MWSKZ'
*                              '**'.
*perform bdc_field       using 'BSEG-BUPLA'
*                              itab-BUPLA.                "'1000'.
*perform bdc_field       using 'BSEG-SECCO'
*                               itab-SECCO.         "'1000'.
*perform bdc_field       using 'BSEG-ZTERM'
*                               itab-ZTERM.            "'V001'.
*perform bdc_field       using 'BSEG-ZFBDT'
*                              itab-ZFBDT.           "'01.03.2018'.
*perform bdc_field       using 'BSEG-ZUONR'
*                               itab-ZUONR.             " 'Assignemt 1'.
*perform bdc_field       using 'BSEG-SGTXT'
*                               itab-SGTXT.              "'Text 1'.
*perform bdc_field       using 'RF05A-NEWBS'
*                                itab-NEWBS_NEW.           "'50'.
*perform bdc_field       using 'RF05A-NEWKO'
*                               itab-NEWKO_NEW.                 "'50000004'.
*"""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*perform bdc_dynpro      using 'SAPMF05A' '0300'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'BSEG-SGTXT'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '/00'.
*perform bdc_field       using 'BSEG-WRBTR'
*                                itab-WRBTR_NEW.                    " '120'.
*perform bdc_field       using 'BSEG-BUPLA'
*                               itab-BUPLA_NEW.              "'1000'.
*perform bdc_field       using 'BSEG-ZUONR'
*                               itab-ZUONR_new.                     " 'Assignemt 2'.
*perform bdc_field       using 'BSEG-SGTXT'
*                              itab-SGTXT_new.                   "'Text 2'.
*perform bdc_field       using 'DKACB-FMORE'
*                              'X'.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*perform bdc_dynpro      using 'SAPLKACB' '0002'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'COBL-PRCTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=ENTE'.
*perform bdc_field       using 'COBL-PRCTR'
*                              itab-PRCTR.            "'1001'.
*"""""""""""""""""""""""""""""""""""""""""""""'
*
*perform bdc_dynpro      using 'SAPMF05A' '0300'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'BSEG-WRBTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=BU'.
*perform bdc_field       using 'BSEG-WRBTR'
*                                itab-WRBTR_NEW.              "'120.00'.
*perform bdc_field       using 'BSEG-BUPLA'
*                               itab-BUPLA_NEW.                    "'1000'.
*perform bdc_field       using 'BSEG-ZUONR'
*                              itab-ZUONR_new.            " 'Assignemt 2'.
*perform bdc_field       using 'BSEG-SGTXT'
*                               itab-SGTXT_new.                 " 'Text 2'.
*perform bdc_field       using 'DKACB-FMORE'
*                              'X'.
*""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*perform bdc_dynpro      using 'SAPLKACB' '0002'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'COBL-PRCTR'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=ENTE'.
*perform bdc_field       using 'COBL-PRCTR'
*                               itab-PRCTR.                "'1001'.
*"(*******************************************************
*ENDIF.
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

*************************************************************************
*** Project	        : DELVAL
*** PROGRAM TITLE   : ZUS_CONV_FI_FSPO
*** MODULE          : FI
*** PROGRAM TYPE    : BDC
*** Description     : This development is about System shall able to
***                   Upload Deatils for GL Master Chart of account FSP0
*** INPUT           : Gayatri Shirke
*** Author          : Sagar Dev
*** CREATION DATE   : 30.07.2018
***----------------------------------------------------------------------
*** Modification History:
***----------------------------------------------------------------------
***   Date           |  Author    | Changes        | Trans Request No.
***----------------------------------------------------------------------
*** 30.07.2018       | Sagar Dev  | Intial Version |  DEVK904698
***----------------------------------------------------------------------
*************************************************************************
REPORT ZUS_CONV_FI_FSPO
       NO STANDARD PAGE HEADING LINE-SIZE 255.
*----------------------------------------------------------------------*
*                   T Y P E S                                          *
*----------------------------------------------------------------------*

TYPES: truxs_fileformat        TYPE trtm_format.
TYPES: truxs_t_text_data(4096) TYPE c OCCURS 0.
DATA : it_raw                  TYPE truxs_t_text_data.
DATA : bdcdata                 TYPE STANDARD TABLE OF bdcdata WITH HEADER LINE.
DATA : f_file                  TYPE string,
       wa_bdcmsgcoll           TYPE bdcmsgcoll,
       it_bdcmsgcoll           TYPE STANDARD TABLE OF bdcmsgcoll.
DATA : count                   TYPE i VALUE 0,
       filename                TYPE string.
DATA : ctu_mode.

*parameters: dataset(132) lower case.
***    DO NOT CHANGE - the generated data section - DO NOT CHANGE    ***
*
*   If it is nessesary to change the data section use the rules:
*   1.) Each definition of a field exists of two lines
*   2.) The first line shows exactly the comment
*       '* data element: ' followed with the data element
*       which describes the field.
*       If you don't have a data element use the
*       comment without a data element name
*   3.) The second line shows the fieldname of the
*       structure, the fieldname must consist of
*       a fieldname and optional the character '_' and
*       three numbers and the field length in brackets
*   4.) Each field must be type C.
*
*** Generated data section with specific formatting - DO NOT CHANGE  ***
DATA: BEGIN OF it_record OCCURS 0,
* data element: SAKNR
        saknr_001(010),    " G/L Account no
* data element: KTOPL
        ktopl_002(004),    " Chart of Accts
* data element: KTOKS
        ktoks_003(004),    " account group
* data element: XPLACCT
        xplacct_004(001),  " p@l account
* data element: XBILK
        xbilk_011(001),    " balance sheet a/c
* data element: TXT20_SKAT
        txt20_ml_012(020), " short text
* data element: TXT50_SKAT
        txt50_ml_013(050), " long text
*  langu_tx(02),
*  txt20_tx(20),
*  txt50_tx(50),

      END OF it_record.

*** End generated data section ***


*----------------------------------------------------------------------*
*                 Selection Screen                                     *
*----------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE text001.
PARAMETERS   p_fname   LIKE ibipparms-path OBLIGATORY.
SELECTION-SCREEN END OF BLOCK blk1.

INITIALIZATION.
  text001 = 'GL Chart of Account Creation'. " selection screen text

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
      field_name    = ' '
    IMPORTING
      file_name     = p_fname.

*----------------------------------------------------------------------*
*                        START  OF    SELECTION                        *
*----------------------------------------------------------------------*

START-OF-SELECTION.
*   This call function using convert data excel file to sap
  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
      i_tab_raw_data       = it_raw
      i_filename           = p_fname
    TABLES
      i_tab_converted_data = it_record " declare internal table
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

*  this loop all records is inserted
  LOOP AT it_record.
    REFRESH bdcdata.
    PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=ACC_CRE'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'GLACCOUNT_SCREEN_KEY-SAKNR'.
PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_KEY-SAKNR'
                                  it_record-saknr_001.
PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_KEY-KTOPL'
                                  it_record-ktopl_002.
*perform bdc_dynpro      using 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
*perform bdc_field       using 'BDC_OKCODE'
*                              '=ACC_MOD'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'GLACCOUNT_SCREEN_KEY-KTOPL'.
PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
PERFORM bdc_field       USING 'BDC_OKCODE'
                              '=TAB02'.
PERFORM bdc_field       USING 'BDC_CURSOR'
                              'GLACCOUNT_SCREEN_COA-KTOKS'.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-KTOKS'
                                  it_record-ktoks_003.
PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-XPLACCT'
                                  it_record-xplacct_004.
PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-XBILK'
                                  it_record-xbilk_011.

IF it_record-xplacct_004 IS NOT INITIAL.
PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-GVTYP'
                              'XL'.
ENDIF.

PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-TXT20_ML'
                                  it_record-txt20_ml_012.
PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-TXT50_ML'
                                  it_record-txt50_ml_013.
PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
PERFORM bdc_field       USING 'BDC_OKCODE'
                              '=ENTER'.
PERFORM bdc_field       USING 'BDC_CURSOR'
                              'GLACCOUNT_SCREEN_COA-TXT50_TX(02)'.
*PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-LANGU_TX(02)'
**                              'DE'.
*                              it_record-langu_tx.
*PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-TXT20_TX(02)'
*                              it_record-txt20_tx.
*PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_COA-TXT50_TX(02)'
*                              it_record-txt50_tx.
PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
PERFORM bdc_field       USING 'BDC_OKCODE'
                              '=SAVE'.
    CALL TRANSACTION 'FSP0' USING bdcdata
                            MODE ctu_mode
                            UPDATE 'S'.
*   Total records count
    count = count + 1.
  ENDLOOP.

  WRITE : / 'No of successfuly records inserted ' , count.

**----------------------------------------------------------------------*
**        Start new screen                                              *
**----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
  CLEAR bdcdata.
  bdcdata-program  = program.
  bdcdata-dynpro   = dynpro.
  bdcdata-dynbegin = 'X'.
  APPEND bdcdata.
ENDFORM.                    "BDC_DYNPRO

**----------------------------------------------------------------------*
**        Insert field                                                  *
**----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
  CLEAR bdcdata.
  bdcdata-fnam = fnam.
  bdcdata-fval = fval.
  APPEND bdcdata.
ENDFORM.                    "BDC_FIELD

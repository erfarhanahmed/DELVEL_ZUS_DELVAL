*************************************************************************
*** Project	        : DELVAL
*** PROGRAM TITLE   : ZUS_CONV_FI_GL_ALT_FS00
*** MODULE          : FI
*** PROGRAM TYPE    : BDC
*** Description     : This development is about System shall able to
***                   Upload Deatils for GL Alternative account assign FS00
*** INPUT           : Gayatri Shirke
*** Author          : Sagar Dev
*** CREATION DATE   : 30.07.2018
***----------------------------------------------------------------------
*** Modification History:
***----------------------------------------------------------------------
***   Date           |  Author    | Changes        | Trans Request No.
***----------------------------------------------------------------------
*** 30.07.2018       | Sagar Dev  | Intial Version |   DEVK904698
***----------------------------------------------------------------------
*************************************************************************
REPORT ZUS_CONV_FI_GL_ALT_FS00
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
        saknr(10),    " G/L Account no
* data element: bukrs
        bukrs(04),    " company code
* data element: altkt
        altkt(10),    " Alternative GL Account
      END OF it_record.

*** End generated data section ***
*----------------------------------------------------------------------*
*                 Selection Screen                                     *
*----------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE text001.
PARAMETERS   p_fname   LIKE ibipparms-path OBLIGATORY.
PARAMETERS   ctu_mode  LIKE ctu_params-dismode DEFAULT 'E'.
SELECTION-SCREEN END OF BLOCK blk1.

INITIALIZATION.
  text001 = 'GL Alternative Account Assign'. " selection screen text

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
      i_tab_converted_data = it_record[] " declare internal table
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
                                    '=ACC_MOD'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'GLACCOUNT_SCREEN_KEY-SAKNR'.
      PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_KEY-SAKNR'
                                    it_record-saknr. " G/L Account no
      PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_KEY-BUKRS'
                                    it_record-bukrs. " company code
      PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=TAB02'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'GLACCOUNT_SCREEN_COA-KTOKS'.
      PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=SAVE'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'GLACCOUNT_SCREEN_CCODE-ALTKT'.

      PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-ALTKT'
                                    it_record-altkt. " Alternative Account No
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=SAVE'.

      CALL TRANSACTION 'FS00' USING bdcdata
                              MODE  ctu_mode
                              UPDATE 'S'.   " update mode
* Total records count
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

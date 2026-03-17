*&---------------------------------------------------------------------*
*& Report ZUS_FI_CREDIT_MEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zus_fi_credit_memo.



TABLES:bseg.

DATA:it_bseg TYPE STANDARD TABLE OF bseg,
     wa_bseg TYPE bseg,
     wa_bkpf TYPE bkpf.


DATA : fm_name TYPE rs38l_fnam.
*&--------------------------------------------------------------------&
*  Declarations for adobe form
*&--------------------------------------------------------------------&
TYPES:
  ty_outputparams TYPE sfpoutputparams, "Form Parameters for Form Processing
  ty_docparams    TYPE sfpdocparams.    "Form Processing Output Parameter
DATA:
  wa_outputparams TYPE sfpoutputparams,
  wa_docparams    TYPE sfpdocparams,
  gv_fm_name      TYPE rs38l_fnam.

SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS : p_belnr TYPE bseg-belnr OBLIGATORY,
               p_gjahr TYPE bseg-gjahr OBLIGATORY,
               p_bukrs TYPE bseg-bukrs OBLIGATORY DEFAULT 'US00',
               p_adobe AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN:END OF BLOCK b1.


START-OF-SELECTION.
  PERFORM get_data.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
  SELECT SINGLE * FROM bseg
      WHERE belnr = @p_belnr
        AND gjahr = @p_gjahr
        AND bukrs = @p_bukrs
        AND kunnr IS NOT INITIAL
        INTO @wa_bseg.

  SELECT SINGLE * FROM bkpf INTO wa_bkpf
       WHERE belnr = wa_bseg-belnr
         AND gjahr = wa_bseg-gjahr
         AND blart = 'DG'.

  IF sy-subrc = 0.
IF p_adobe = 'X'.
      " Sets the output parameters and opens the spool job
*      wa_outputparams-device    =  'PRINTER'.
*      wa_outputparams-dest      =  'LP01'.
*      wa_outputparams-nodialog  = 'X'.
*      wa_outputparams-preview   = 'X'.


      "ADDITION OF CODE BY MADHAVI
   wa_outputparams-DEVICE = 'PRINTER'.
  wa_outputparams-DEST = 'LP01'.
  IF SY-UCOMM = 'PRNT'.
     wa_outputparams-NODIALOG = 'X'.
     wa_outputparams-PREVIEW = ''.
     wa_outputparams-REQIMM = 'X'.
  ELSE.
     wa_outputparams-NODIALOG = ''.
     wa_outputparams-PREVIEW = 'X'.
  ENDIF.

      CALL FUNCTION 'FP_JOB_OPEN'
        CHANGING
          ie_outputparams = wa_outputparams
        EXCEPTIONS
          cancel          = 1
          usage_error     = 2
          system_error    = 3
          internal_error  = 4
          OTHERS          = 5.
      IF sy-subrc <> 0.
        " <error handling>
      ENDIF.
      " Get the name of the generated function module
      CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
        EXPORTING
          i_name     = 'ZUS_FI_CREDIT_AF'
        IMPORTING
          e_funcname = gv_fm_name.
      IF sy-subrc <> 0.
        "<error handling>
      ENDIF.

      wa_docparams-langu   = 'E'.
      wa_docparams-country = 'SG'.

      CALL FUNCTION gv_fm_name     "'/1BCDWB/SM00000100'
        EXPORTING
          /1bcdwb/docparams = wa_docparams
          wa_bseg           = wa_bseg
*   IMPORTING
*         /1BCDWB/FORMOUTPUT       =
        EXCEPTIONS
          usage_error       = 1
          system_error      = 2
          internal_error    = 3
          OTHERS            = 4.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      " Close the spool job
      CALL FUNCTION 'FP_JOB_CLOSE'
        EXCEPTIONS
          usage_error    = 1
          system_error   = 2
          internal_error = 3
          OTHERS         = 4.
      IF sy-subrc <> 0.
        " <error handling>
      ENDIF.

    ELSE.

    CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
      EXPORTING
        formname = 'ZUS_FI_CREDIT_FORM'
*       VARIANT  = ' '
*       DIRECT_CALL              = ' '
      IMPORTING
        fm_name  = fm_name
* EXCEPTIONS
*       NO_FORM  = 1
*       NO_FUNCTION_MODULE       = 2
*       OTHERS   = 3
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    CALL FUNCTION fm_name "'/1BCDWB/SF00000105'
      EXPORTING
*       ARCHIVE_INDEX              =
*       ARCHIVE_INDEX_TAB          =
*       ARCHIVE_PARAMETERS         =
*       CONTROL_PARAMETERS         =
*       MAIL_APPL_OBJ              =
*       MAIL_RECIPIENT             =
*       MAIL_SENDER                =
*       OUTPUT_OPTIONS             =
*       USER_SETTINGS              = 'X'
        wa_bseg = wa_bseg
* IMPORTING
*       DOCUMENT_OUTPUT_INFO       =
*       JOB_OUTPUT_INFO            =
*       JOB_OUTPUT_OPTIONS         =
* EXCEPTIONS
*       FORMATTING_ERROR           = 1
*       INTERNAL_ERROR             = 2
*       SEND_ERROR                 = 3
*       USER_CANCELED              = 4
*       OTHERS  = 5
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
    endif.
  ELSE.
    MESSAGE 'This Is Not Credit Memo' TYPE 'E'.
  ENDIF.
ENDFORM.

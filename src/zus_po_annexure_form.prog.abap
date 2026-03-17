*&---------------------------------------------------------------------*
*& Report ZUS_PO_ANNEXURE_FORM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_PO_ANNEXURE_FORM.


TABLES : ekko.
TYPES:BEGIN OF ty_ekko,
      ebeln TYPE ekko-ebeln,
      bukrs TYPE ekko-ebeln,
      END OF ty_ekko.

DATA: it_ekko TYPE TABLE OF ty_ekko.
DATA:      wa_ekko TYPE ekko.

Data : fm_name TYPE rs38l_fnam.

SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  PARAMETERS : p_po TYPE ekko-ebeln.
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
SELECT SINGLE * INTO wa_ekko FROM ekko
       WHERE ebeln = p_po.
CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname                 = 'ZUS_PO_ANNEXURE_FORM'
*   VARIANT                  = ' '
*   DIRECT_CALL              = ' '
 IMPORTING
   FM_NAME                  =  fm_name
* EXCEPTIONS
*   NO_FORM                  = 1
*   NO_FUNCTION_MODULE       = 2
*   OTHERS                   = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.


  CALL FUNCTION fm_name
    EXPORTING
*     ARCHIVE_INDEX              =
*     ARCHIVE_INDEX_TAB          =
*     ARCHIVE_PARAMETERS         =
*     CONTROL_PARAMETERS         =
*     MAIL_APPL_OBJ              =
*     MAIL_RECIPIENT             =
*     MAIL_SENDER                =
*     OUTPUT_OPTIONS             =
*     USER_SETTINGS              = 'X'
      wa_ekko                    = wa_ekko
*   IMPORTING
*     DOCUMENT_OUTPUT_INFO       =
*     JOB_OUTPUT_INFO            =
*     JOB_OUTPUT_OPTIONS         =
*   EXCEPTIONS
*     FORMATTING_ERROR           = 1
*     INTERNAL_ERROR             = 2
*     SEND_ERROR                 = 3
*     USER_CANCELED              = 4
*     OTHERS                     = 5
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.

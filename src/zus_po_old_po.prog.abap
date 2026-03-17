*&---------------------------------------------------------------------*
*& Report ZUS_PO_OLD_PO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_PO_OLD_PO.


TABLES:EKKO.

TYPES: BEGIN OF TY_EKKO,
       EBELN TYPE EKKO-EBELN,
       BUKRS TYPE EKKO-BUKRS,
       LOEKZ TYPE EKKO-LOEKZ,
       AEDAT TYPE EKKO-AEDAT,
       END OF TY_EKKO,

       BEGIN OF TY_EKPO,
       EBELN TYPE EKPO-EBELN,
       EBELP TYPE EKPO-EBELP,
       MATNR TYPE EKPO-MATNR,
       MENGE TYPE EKPO-MENGE,
       NETPR TYPE EKPO-NETPR,
       END OF TY_EKPO,

       BEGIN OF TY_FINAL,
       EBELN TYPE EKPO-EBELN,
       EBELP TYPE EKPO-EBELP,
       MATNR TYPE EKPO-MATNR,
       MENGE TYPE EKPO-MENGE,
       OLD_PO TYPE CHAR100,
       NETPR TYPE EKPO-NETPR,
       VALUE TYPE STRING,
       END OF TY_FINAL.

DATA:IT_EKKO TYPE TABLE OF TY_EKKO,
     WA_EKKO TYPE          TY_EKKO,

     IT_EKPO TYPE TABLE OF TY_EKPO,
     WA_EKPO TYPE          TY_EKPO,

     IT_FINAL TYPE TABLE OF TY_FINAL,
     WA_FINAL TYPE          TY_FINAL.

DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat LIKE LINE OF it_fcat.


DATA: i_sort             TYPE slis_t_sortinfo_alv, " SORT
      gt_events          TYPE slis_t_event,        " EVENTS
      i_list_top_of_page TYPE slis_t_listheader,   " TOP-OF-PAGE
      wa_layout          TYPE  slis_layout_alv..            " LAYOUT WORKAREA
DATA t_sort TYPE slis_t_sortinfo_alv WITH HEADER LINE.


DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt TYPE tline,
      ls_mattxt TYPE tline.


 SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
   SELECT-OPTIONS: s_date FOR ekko-aedat.
 SELECTION-SCREEN: END OF BLOCK b1.


 START-OF-SELECTION.

 PERFORM get_data.
 PERFORM sort_data.
 PERFORM get_fcat.
 PERFORM get_display.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .

SELECT EBELN
       BUKRS
       LOEKZ
       AEDAT FROM ekko INTO TABLE it_ekko
       WHERE aedat IN s_date
        AND  BUKRS = 'US00'
        AND  LOEKZ NE 'C'.


IF it_ekko IS NOT INITIAL.
  SELECT EBELN
         EBELP
         MATNR
         MENGE
         NETPR FROM ekpo INTO TABLE it_ekpo
         FOR ALL ENTRIES IN it_ekko
         WHERE ebeln = it_ekko-ebeln.





ENDIF.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SORT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM sort_data .
LOOP AT it_ekpo INTO wa_ekpo.

wa_final-ebeln = wa_ekpo-ebeln.
wa_final-ebelp = wa_ekpo-ebelp.
wa_final-matnr = wa_ekpo-matnr.
wa_final-menge = wa_ekpo-menge.
wa_final-NETPR = wa_ekpo-NETPR.
wa_final-value = wa_ekpo-NETPR * wa_final-menge.


   CLEAR: lv_lines, ls_mattxt.
    REFRESH lv_lines.
CONCATENATE wa_final-ebeln wa_final-ebelp INTO lv_name." = wa_final-ebeln.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        client                  = sy-mandt
        id                      = 'F07'
        language                = sy-langu
        name                    = lv_name
        object                  = 'EKPO'
      TABLES
        lines                   = lv_lines
      EXCEPTIONS
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        OTHERS                  = 8.
    IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT lv_lines IS INITIAL.

      READ TABLE lv_lines INTO wa_lines INDEX 1.
        IF NOT wa_lines-tdline IS INITIAL.
           wa_final-old_po =  wa_lines-tdline.
        ENDIF.


    ENDIF.
APPEND wa_final TO it_final.
CLEAR wa_final.
ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_fcat .
PERFORM fcat USING :    '1'  'EBELN '          'IT_FINAL'  'Purchase Order No'         '18' ,
                        '2'  'EBELP '          'IT_FINAL'  'Purchase Order Line'         '18' ,
                        '3'  'MATNR '          'IT_FINAL'  'Material Number'             '18' ,
                        '4'  'MENGE '          'IT_FINAL'  'Purchase Order Quantity'     '18' ,
                        '5'  'NETPR '          'IT_FINAL'  'PO Rate'                     '18' ,
                        '6'  'VALUE '          'IT_FINAL'  'PO Value'                    '18' ,
                        '7'  'OLD_PO'          'IT_FINAL'  'Old PO No'                   '18' .
ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0729   text
*      -->P_0730   text
*      -->P_0731   text
*      -->P_0732   text
*      -->P_0733   text
*----------------------------------------------------------------------*
FORM fcat   USING    VALUE(p1)
                    VALUE(p2)
                    VALUE(p3)
                    VALUE(p4)
                    VALUE(p5).
  wa_fcat-col_pos   = p1.
  wa_fcat-fieldname = p2.
  wa_fcat-tabname   = p3.
  wa_fcat-seltext_l = p4.
*wa_fcat-key       = .
  wa_fcat-outputlen   = p5.

  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_display .
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK      = ' '
*     I_BYPASSING_BUFFER     = ' '
*     I_BUFFER_ACTIVE        = ' '
      i_callback_program     = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
      i_callback_top_of_page = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME       =
*     I_BACKGROUND_ID        = ' '
*     I_GRID_TITLE           =
*     I_GRID_SETTINGS        =
      is_layout              = wa_layout
      it_fieldcat            = it_fcat
*     IT_EXCLUDING           =
*     IT_SPECIAL_GROUPS      =
*     IT_SORT                =
*     IT_FILTER              =
*     IS_SEL_HIDE            =
*     I_DEFAULT              = 'X'
*     I_SAVE                 = ' '
*     IS_VARIANT             =
*     IT_EVENTS              =
*     IT_EVENT_EXIT          =
*     IS_PRINT               =
*     IS_REPREP_ID           =
*     I_SCREEN_START_COLUMN  = 0
*     I_SCREEN_START_LINE    = 0
*     I_SCREEN_END_COLUMN    = 0
*     I_SCREEN_END_LINE      = 0
*     I_HTML_HEIGHT_TOP      = 0
*     I_HTML_HEIGHT_END      = 0
*     IT_ALV_GRAPHICS        =
*     IT_HYPERLINK           =
*     IT_ADD_FIELDCAT        =
*     IT_EXCEPT_QINFO        =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER =
    TABLES
      t_outtab               = it_final
*   EXCEPTIONS
*     PROGRAM_ERROR          = 1
*     OTHERS                 = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.


FORM top-of-page.
*ALV HEADER DECLARATIONS
  DATA: lt_header     TYPE slis_t_listheader,
        ls_header     TYPE slis_listheader,
        lt_line       LIKE ls_header-info,
        ld_lines      TYPE i,
        ld_linesc(10) TYPE c.

* TITLE
  ls_header-typ  = 'H'.
  ls_header-info = 'New PO Old PO'.
  APPEND ls_header TO lt_header.
  CLEAR ls_header.

* DATE
  ls_header-typ  = 'S'.
  ls_header-key  = 'RUN DATE :'.
  CONCATENATE ls_header-info sy-datum+6(2) '.' sy-datum+4(2) '.' sy-datum(4) INTO ls_header-info.
  APPEND ls_header TO lt_header.
  CLEAR: ls_header.

*TIME
  ls_header-typ  = 'S'.
  ls_header-key  = 'RUN TIME :'.
  CONCATENATE ls_header-info sy-timlo(2) '.' sy-timlo+2(2) '.' sy-timlo+4(2) INTO ls_header-info.
  APPEND ls_header TO lt_header.
  CLEAR: ls_header.

* TOTAL NO. OF RECORDS SELECTED
  DESCRIBE TABLE it_final LINES ld_lines.
  ld_linesc = ld_lines.
  CONCATENATE 'TOTAL NO. OF RECORDS SELECTED: ' ld_linesc
     INTO lt_line SEPARATED BY space.


  ls_header-typ  = 'A'.
  ls_header-info = lt_line.
  APPEND ls_header TO lt_header.
  CLEAR: ls_header, lt_line.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header.
ENDFORM.                    " TOP-OF-PAGE

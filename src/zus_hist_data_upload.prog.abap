*&---------------------------------------------------------------------*
*& Report ZUS_HIST_DATA_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_HIST_DATA_UPLOAD.

TABLES:ZUS_HIST_DATA.

TABLES: sscrfields.
* --------- DATA DECLARATION ------------------------------------------------

DATA : bdcdata       TYPE STANDARD TABLE OF bdcdata WITH HEADER LINE.
DATA : it_bdcmsgcoll TYPE STANDARD TABLE OF bdcmsgcoll,
       wa_bdcmsgcoll TYPE bdcmsgcoll.
DATA : cnt(3)        TYPE n,
       v_message(50).
TYPES: trux_t_text_data(4096) TYPE c OCCURS 0.
DATA : it_raw TYPE trux_t_text_data.
DATA : count  TYPE i VALUE 0.


TYPES: BEGIN OF ty_str,
       ZITEM            TYPE ZUS_HIST_DATA-ZITEM,
       ZSERIES          TYPE ZUS_HIST_DATA-ZSERIES ,
       ZSIZE            TYPE ZUS_HIST_DATA-ZSIZE    ,
       HAND_QTY         TYPE ZUS_HIST_DATA-HAND_QTY  ,
       SO_QTY           TYPE ZUS_HIST_DATA-SO_QTY     ,
       AVAIL_QTY        TYPE ZUS_HIST_DATA-AVAIL_QTY   ,
       PO_QTY           TYPE ZUS_HIST_DATA-PO_QTY      ,
       TRANSIT_QTY      TYPE ZUS_HIST_DATA-TRANSIT_QTY ,
       TOTAL_SOLD       TYPE ZUS_HIST_DATA-TOTAL_SOLD  ,
       TOTAL_SOLD1      TYPE ZUS_HIST_DATA-TOTAL_SOLD1 ,

       TOTAL_SOLD2      TYPE ZUS_HIST_DATA-TOTAL_SOLD2 ,
       TOTAL_PUR        TYPE ZUS_HIST_DATA-TOTAL_PUR   ,
       TOTAL_PUR1       TYPE ZUS_HIST_DATA-TOTAL_PUR1  ,
       TOTAL_PUR2       TYPE ZUS_HIST_DATA-TOTAL_PUR2  ,
       SALES            TYPE ZUS_HIST_DATA-SALES       ,
       PURCHASE         TYPE ZUS_HIST_DATA-PURCHASE    ,
       END OF ty_str.

DATA:itab TYPE TABLE OF ty_str WITH HEADER LINE.
DATA: it_final TYPE TABLE OF ZUS_HIST_DATA WITH HEADER LINE.

DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat LIKE LINE OF it_fcat.

DATA   fs_layout TYPE slis_layout_alv.
* --------------------------------------------------------------
INITIALIZATION.
* --------------------------------------------  ------------------
  SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-004.
  PARAMETERS     : voli1 TYPE rlgrap-filename.
*  PARAMETERS     : ctu_mode  LIKE ctu_params-dismode DEFAULT 'A'.
  SELECTION-SCREEN : END OF BLOCK b1.



* Add displayed text string to buttons



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
PERFORM upload.
PERFORM display.


*&---------------------------------------------------------------------*
*&      Form  UPLOAD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM upload .
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


LOOP AT itab.
it_final-ZITEM       = itab-ZITEM   .
it_final-ZSERIES     = itab-ZSERIES  .
it_final-ZSIZE       = itab-ZSIZE     .
it_final-HAND_QTY    = itab-HAND_QTY   .
it_final-SO_QTY      = itab-SO_QTY      .
it_final-AVAIL_QTY   = itab-AVAIL_QTY   .
it_final-PO_QTY      = itab-PO_QTY      .
it_final-TRANSIT_QTY = itab-TRANSIT_QTY .
it_final-TOTAL_SOLD  = itab-TOTAL_SOLD  .
it_final-TOTAL_SOLD1 = itab-TOTAL_SOLD1 .

it_final-TOTAL_SOLD2   = itab-TOTAL_SOLD2 .
it_final-TOTAL_PUR     = itab-TOTAL_PUR   .
it_final-TOTAL_PUR1    = itab-TOTAL_PUR1   .
it_final-TOTAL_PUR2    = itab-TOTAL_PUR2   .
it_final-SALES         = itab-SALES         .
it_final-PURCHASE      = itab-PURCHASE      .


*APPEND it_
*MODIFY ZUS_HIST_DATA.
*UPDATE ZUS_HIST_DATA.
INSERT ZUS_HIST_DATA FROM it_final .

ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display .

select * from ZUS_HIST_DATA INTO TABLE it_final
  FOR ALL ENTRIES IN itab
  WHERE zitem = itab-zitem.


 PERFORM fcat USING :  '1'  'ZITEM'         'IT_FINAL'  'Item Id'                                     '18' ,
                       '2'  'ZSERIES'         'IT_FINAL'  'series code'                                     '18' ,
                       '3'  'ZSIZE'         'IT_FINAL'  'Size'                                     '18' ,
                       '4'  'HAND_QTY'         'IT_FINAL'  'Hand Qty'                                     '18' ,
                       '5'  'SO_QTY'         'IT_FINAL'  'So qty'                                     '18' ,
                       '6'  'AVAIL_QTY'         'IT_FINAL'  'AVAILabl QTY'                                     '18' ,
                       '7'  'PO_QTY'         'IT_FINAL'  'Po Qty'                                     '18' ,
                       '8'  'TRANSIT_QTY'         'IT_FINAL'  'TRANSIT QTY'                                     '18' ,
                       '9'  'TOTAL_SOLD'         'IT_FINAL'  'Total Sold Qty APR18-OCT18'                                     '18' ,
                      '10'  'TOTAL_SOLD1'         'IT_FINAL'  'Total Sold Qty APR17-MAR18'                                     '18' ,
                      '11'  'TOTAL_SOLD2'         'IT_FINAL'  'Total Sold Qty APR16-MAR17'                                     '18' ,
                      '12'  'TOTAL_PUR'         'IT_FINAL'  'Total Pur  Qty-APR18- OCT18'                                     '18' ,
                      '13'  'TOTAL_PUR1'         'IT_FINAL'  'Total Pur  Qty-APR17- MAR18'                                     '18' ,
                      '14'  'TOTAL_PUR2'         'IT_FINAL'  'Total Pur  Qty-APR16- MAR17'                                     '18' ,
                      '15'  'SALES'         'IT_FINAL'  'Sales($) Last 12 Month'                                     '18' ,
                      '16'  'PURCHASE'         'IT_FINAL'  'Purc($) Last 12 Month'                                     '18' .


CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER = ' '
*     I_BUFFER_ACTIVE    = ' '
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
     I_CALLBACK_TOP_OF_PAGE            = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
      IS_LAYOUT          = fs_layout
      it_fieldcat        = it_fcat
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            =
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
     I_SAVE             = 'X'
*     IS_VARIANT         =
*     IT_EVENTS          =
*     IT_EVENT_EXIT      =
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  = 0
*     I_HTML_HEIGHT_END  = 0
*     IT_ALV_GRAPHICS    =
*     IT_HYPERLINK       =
*     IT_ADD_FIELDCAT    =
*     IT_EXCEPT_QINFO    =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = it_final
*   EXCEPTIONS
*     PROGRAM_ERROR      = 1
*     OTHERS             = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.


FORM fcat  USING    VALUE(p1)
                    VALUE(p2)
                    VALUE(p3)
                    VALUE(p4)
                    VALUE(p5).
  wa_fcat-col_pos   = p1.
  wa_fcat-fieldname = p2.
  wa_fcat-tabname   = p3.
  wa_fcat-seltext_l = p4.
*  wa_fcat-key       = .
  wa_fcat-outputlen   = p5.

  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

ENDFORM.

FORM fill_layout .
  fs_layout-colwidth_optimize = 'X'.
  fs_layout-zebra             = 'X'.
  fs_layout-detail_popup      = 'X'.
  fs_layout-subtotals_text    = 'DR'.

ENDFORM.




*&---------------------------------------------------------------------*
*&      Form  top-of-page
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM top-of-page.

*  ALV Header declarations
  DATA: t_header      TYPE slis_t_listheader,
        wa_header     TYPE slis_listheader,
        t_line        LIKE wa_header-info,
        ld_lines      TYPE i,
        ld_linesc(10) TYPE c,
*        year          TYPE char10,
        period        TYPE char100.



*  Title
  wa_header-typ  = 'H'.
  wa_header-info = 'Historicle Data '.
  APPEND wa_header TO t_header.
  CLEAR wa_header.



*  Date
  wa_header-typ  = 'S'.
  wa_header-key  = 'Run Date : '.
  CONCATENATE wa_header-info sy-datum+6(2) '.' sy-datum+4(2) '.'
                      sy-datum(4) INTO wa_header-info.
  APPEND wa_header TO t_header.
  CLEAR: wa_header.

*  Time
  wa_header-typ  = 'S'.
  wa_header-key  = 'Run Time: '.
  CONCATENATE wa_header-info sy-timlo(2) ':' sy-timlo+2(2) ':'
                      sy-timlo+4(2) INTO wa_header-info.
  APPEND wa_header TO t_header.
  CLEAR: wa_header.

*   Total No. of Records Selected
  DESCRIBE TABLE it_final LINES ld_lines.
  ld_linesc = ld_lines.

  CONCATENATE 'Total No. of Records Selected: ' ld_linesc
     INTO t_line SEPARATED BY space.

  wa_header-typ  = 'A'.
  wa_header-info = t_line.
  APPEND wa_header TO t_header.
  CLEAR: wa_header, t_line.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = t_header.
ENDFORM.                    " top-of-page

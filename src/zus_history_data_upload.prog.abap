*&---------------------------------------------------------------------*
*& Report ZUS_HISTORY_DATA_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_HISTORY_DATA_UPLOAD.


*TABLES: ZUS_HISTORY.
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
        MATNR       TYPE char18,"ZUS_HISTORY-MATNR      ,
        PART_NO     TYPE char40,"ZUS_HISTORY-PART_NO    ,
        MAT_DESC    TYPE char250  ,
        SH_DESC     TYPE char250  ,
        USA_DESC    TYPE char250  ,
        ITEM_TYPE   TYPE char100,"ZUS_HISTORY-ITEM_TYPE  ,
        MAR19       TYPE char13,"ZUS_HISTORY-MAR19      ,
        FEB19       TYPE char13,"ZUS_HISTORY-FEB19      ,
        JAN19       TYPE char13,"ZUS_HISTORY-JAN19      ,
        DEC18       TYPE char13,"ZUS_HISTORY-DEC18      ,
        NOV18       TYPE char13,"ZUS_HISTORY-NOV18      ,
        OCT18       TYPE char13,"ZUS_HISTORY-OCT18      ,
        SEP18       TYPE char13,"ZUS_HISTORY-SEP18      ,
        AUG18       TYPE char13,"ZUS_HISTORY-AUG18      ,
        JUL18       TYPE char13,"ZUS_HISTORY-JUL18      ,
        JUN18       TYPE char13,"ZUS_HISTORY-JUN18      ,
        MAY18       TYPE char13,"ZUS_HISTORY-MAY18      ,
        APR18       TYPE char13,"ZUS_HISTORY-APR18      ,
        TOTAL_SOLD  TYPE char13,"ZUS_HISTORY-TOTAL_SOLD ,
        TOTAL_SOLD1 TYPE char13,"ZUS_HISTORY-TOTAL_SOLD1,
        PMAR19      TYPE char13,"ZUS_HISTORY-PMAR19     ,
        PFEB19      TYPE char13,"ZUS_HISTORY-PFEB19     ,
        PJAN19      TYPE char13,"ZUS_HISTORY-PJAN19     ,
        PDEC18      TYPE char13,"ZUS_HISTORY-PDEC18    ,
        PNOV18      TYPE char13,"ZUS_HISTORY-PNOV18    ,
        POCT18      TYPE char13,"ZUS_HISTORY-POCT18    ,
        PSEP18      TYPE char13,"ZUS_HISTORY-PSEP18    ,
        PAUG18      TYPE char13,"ZUS_HISTORY-PAUG18    ,
        PJUL18      TYPE char13,"ZUS_HISTORY-PJUL18    ,
        PJUN18      TYPE char13,"ZUS_HISTORY-PJUN18    ,
        PMAY18      TYPE char13,"ZUS_HISTORY-PMAY18    ,
        PAPR18      TYPE char13,"ZUS_HISTORY-PAPR18    ,
        TOTAL_PUR   TYPE char13,"ZUS_HISTORY-TOTAL_PUR ,
        TOTAL_PUR1  TYPE char13,"ZUS_HISTORY-TOTAL_PUR1,
        BRAND       TYPE char3,"ZUS_HISTORY-BRAND     ,
        ZSERIES     TYPE char3,"ZUS_HISTORY-ZSERIES   ,
        ZSIZE       TYPE char3,"ZUS_HISTORY-ZSIZE     ,
        MOC         TYPE char3,"ZUS_HISTORY-MOC       ,
        TYPE        TYPE char3,"ZUS_HISTORY-TYPE      ,

       END OF ty_str.

DATA:itab TYPE TABLE OF ty_str WITH HEADER LINE.
DATA: it_final TYPE TABLE OF ZUS_HIST_TABLE WITH HEADER LINE.

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
*PERFORM display.


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
it_final-MATNR       = itab-MATNR    .
it_final-PART_NO     = itab-PART_NO   .
it_final-MAT_DESC    = itab-MAT_DESC   .
it_final-SH_DESC     = itab-SH_DESC    .
it_final-USA_DESC    = itab-USA_DESC   .
it_final-ITEM_TYPE   = itab-ITEM_TYPE  .
it_final-MAR19       = itab-MAR19      .
it_final-FEB19       = itab-FEB19       .
it_final-JAN19       = itab-JAN19       .
it_final-DEC18       = itab-DEC18       .
it_final-NOV18       = itab-NOV18       .
it_final-OCT18       = itab-OCT18       .
it_final-SEP18       = itab-SEP18       .
it_final-AUG18       = itab-AUG18       .
it_final-JUL18       = itab-JUL18       .
it_final-JUN18       = itab-JUN18       .
it_final-MAY18       = itab-MAY18       .
it_final-APR18       = itab-APR18       .
it_final-TOTAL_SOLD  = itab-TOTAL_SOLD  .
it_final-TOTAL_SOLD1 = itab-TOTAL_SOLD1 .
it_final-PMAR19      = itab-PMAR19      .
it_final-PFEB19      = itab-PFEB19      .
it_final-PJAN19      = itab-PJAN19      .
it_final-PDEC18      = itab-PDEC18      .

it_final-PNOV18       = itab-PNOV18    .
it_final-POCT18       = itab-POCT18    .
it_final-PSEP18       = itab-PSEP18     .
it_final-PAUG18       = itab-PAUG18     .
it_final-PJUL18       = itab-PJUL18      .
it_final-PJUN18       = itab-PJUN18      .
it_final-PMAY18       = itab-PMAY18      .
it_final-PAPR18       = itab-PAPR18      .
it_final-TOTAL_PUR    = itab-TOTAL_PUR   .
it_final-TOTAL_PUR1   = itab-TOTAL_PUR1  .
it_final-BRAND        = itab-BRAND       .
it_final-ZSERIES      = itab-ZSERIES     .
it_final-ZSIZE        = itab-ZSIZE       .
it_final-MOC          = itab-MOC         .
it_final-TYPE         = itab-TYPE        .




INSERT ZUS_HIST_TABLE FROM it_final .

ENDLOOP.
if sy-subrc eq 4.
    MESSAGE 'Update is not possible' type 'E'.
    ELSE.
       MESSAGE 'Table Updated Successfully' type 'S'.

    ENDIF .
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*FORM display .
*
*select * from ZUS_HISTORY INTO TABLE it_final
*  FOR ALL ENTRIES IN itab
*  WHERE MATNR = itab-MATNR.
*
*
* PERFORM fcat USING :  '1'  'ZITEM'         'IT_FINAL'  'Item Id'                                     '18' ,
*                       '2'  'ZSERIES'         'IT_FINAL'  'series code'                                     '18' ,
*                       '3'  'ZSIZE'         'IT_FINAL'  'Size'                                     '18' ,
*                       '4'  'HAND_QTY'         'IT_FINAL'  'Hand Qty'                                     '18' ,
*                       '5'  'SO_QTY'         'IT_FINAL'  'So qty'                                     '18' ,
*                       '6'  'AVAIL_QTY'         'IT_FINAL'  'AVAILabl QTY'                                     '18' ,
*                       '7'  'PO_QTY'         'IT_FINAL'  'Po Qty'                                     '18' ,
*                       '8'  'TRANSIT_QTY'         'IT_FINAL'  'TRANSIT QTY'                                     '18' ,
*                       '9'  'TOTAL_SOLD'         'IT_FINAL'  'Total Sold Qty APR18-OCT18'                                     '18' ,
*                      '10'  'TOTAL_SOLD1'         'IT_FINAL'  'Total Sold Qty APR17-MAR18'                                     '18' ,
*                      '11'  'TOTAL_SOLD2'         'IT_FINAL'  'Total Sold Qty APR16-MAR17'                                     '18' ,
*                      '12'  'TOTAL_PUR'         'IT_FINAL'  'Total Pur  Qty-APR18- OCT18'                                     '18' ,
*                      '13'  'TOTAL_PUR1'         'IT_FINAL'  'Total Pur  Qty-APR17- MAR18'                                     '18' ,
*                      '14'  'TOTAL_PUR2'         'IT_FINAL'  'Total Pur  Qty-APR16- MAR17'                                     '18' ,
*                      '15'  'SALES'         'IT_FINAL'  'Sales($) Last 12 Month'                                     '18' ,
*                      '16'  'PURCHASE'         'IT_FINAL'  'Purc($) Last 12 Month'                                     '18' .
*
*
*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*    EXPORTING
**     I_INTERFACE_CHECK  = ' '
**     I_BYPASSING_BUFFER = ' '
**     I_BUFFER_ACTIVE    = ' '
*      i_callback_program = sy-repid
**     I_CALLBACK_PF_STATUS_SET          = ' '
**     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = 'TOP-OF-PAGE'
**     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
**     I_CALLBACK_HTML_END_OF_LIST       = ' '
**     I_STRUCTURE_NAME   =
**     I_BACKGROUND_ID    = ' '
**     I_GRID_TITLE       =
**     I_GRID_SETTINGS    =
*      IS_LAYOUT          = fs_layout
*      it_fieldcat        = it_fcat
**     IT_EXCLUDING       =
**     IT_SPECIAL_GROUPS  =
**     IT_SORT            =
**     IT_FILTER          =
**     IS_SEL_HIDE        =
**     I_DEFAULT          = 'X'
*     I_SAVE             = 'X'
**     IS_VARIANT         =
**     IT_EVENTS          =
**     IT_EVENT_EXIT      =
**     IS_PRINT           =
**     IS_REPREP_ID       =
**     I_SCREEN_START_COLUMN             = 0
**     I_SCREEN_START_LINE               = 0
**     I_SCREEN_END_COLUMN               = 0
**     I_SCREEN_END_LINE  = 0
**     I_HTML_HEIGHT_TOP  = 0
**     I_HTML_HEIGHT_END  = 0
**     IT_ALV_GRAPHICS    =
**     IT_HYPERLINK       =
**     IT_ADD_FIELDCAT    =
**     IT_EXCEPT_QINFO    =
**     IR_SALV_FULLSCREEN_ADAPTER        =
**   IMPORTING
**     E_EXIT_CAUSED_BY_CALLER           =
**     ES_EXIT_CAUSED_BY_USER            =
*    TABLES
*      t_outtab           = it_final
**   EXCEPTIONS
**     PROGRAM_ERROR      = 1
**     OTHERS             = 2
*    .
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.
*
*
*ENDFORM.
*
*
*FORM fcat  USING    VALUE(p1)
*                    VALUE(p2)
*                    VALUE(p3)
*                    VALUE(p4)
*                    VALUE(p5).
*  wa_fcat-col_pos   = p1.
*  wa_fcat-fieldname = p2.
*  wa_fcat-tabname   = p3.
*  wa_fcat-seltext_l = p4.
**  wa_fcat-key       = .
*  wa_fcat-outputlen   = p5.
*
*  APPEND wa_fcat TO it_fcat.
*  CLEAR wa_fcat.
*
*ENDFORM.
*
*FORM fill_layout .
*  fs_layout-colwidth_optimize = 'X'.
*  fs_layout-zebra             = 'X'.
*  fs_layout-detail_popup      = 'X'.
*  fs_layout-subtotals_text    = 'DR'.
*
*ENDFORM.
*
*
*
*
**&---------------------------------------------------------------------*
**&      Form  top-of-page
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
*FORM top-of-page.
*
**  ALV Header declarations
*  DATA: t_header      TYPE slis_t_listheader,
*        wa_header     TYPE slis_listheader,
*        t_line        LIKE wa_header-info,
*        ld_lines      TYPE i,
*        ld_linesc(10) TYPE c,
**        year          TYPE char10,
*        period        TYPE char100.
*
*
*
**  Title
*  wa_header-typ  = 'H'.
*  wa_header-info = 'Historicle Data '.
*  APPEND wa_header TO t_header.
*  CLEAR wa_header.
*
*
*
**  Date
*  wa_header-typ  = 'S'.
*  wa_header-key  = 'Run Date : '.
*  CONCATENATE wa_header-info sy-datum+6(2) '.' sy-datum+4(2) '.'
*                      sy-datum(4) INTO wa_header-info.
*  APPEND wa_header TO t_header.
*  CLEAR: wa_header.
*
**  Time
*  wa_header-typ  = 'S'.
*  wa_header-key  = 'Run Time: '.
*  CONCATENATE wa_header-info sy-timlo(2) ':' sy-timlo+2(2) ':'
*                      sy-timlo+4(2) INTO wa_header-info.
*  APPEND wa_header TO t_header.
*  CLEAR: wa_header.
*
**   Total No. of Records Selected
*  DESCRIBE TABLE it_final LINES ld_lines.
*  ld_linesc = ld_lines.
*
*  CONCATENATE 'Total No. of Records Selected: ' ld_linesc
*     INTO t_line SEPARATED BY space.
*
*  wa_header-typ  = 'A'.
*  wa_header-info = t_line.
*  APPEND wa_header TO t_header.
*  CLEAR: wa_header, t_line.
*
*  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
*    EXPORTING
*      it_list_commentary = t_header.
*ENDFORM.                    " top-of-page

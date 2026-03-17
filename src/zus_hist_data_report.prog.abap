*&---------------------------------------------------------------------*
*& Report ZUS_HIST_DATA_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_HIST_DATA_REPORT.

TABLES: mara.



DATA :it_final TYPE STANDARD TABLE OF  ZUS_HIST_TABLE,
      wa_final TYPE ZUS_HIST_TABLE.



DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat LIKE LINE OF it_fcat.

DATA   fs_layout TYPE slis_layout_alv.

* --------------------------------------------------------------
INITIALIZATION.
* --------------------------------------------  ------------------
  SELECTION-SCREEN: BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_matnr FOR mara-matnr.
*                  s_part  FOR mara-matnr.

SELECTION-SCREEN: END OF BLOCK B1.

START-OF-SELECTION.
PERFORM get_data.
PERFORM display.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .


SELECT * FROM ZUS_HIST_TABLE INTO TABLE it_final
   WHERE matnr IN s_matnr.
*   AND   part_no IN s_part.

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
 PERFORM fcat USING :
                      '1'  'MATNR      '         'IT_FINAL'  'Material_No'                                     '18' ,
                      '2'  'PART_NO    '         'IT_FINAL'  'Usa_Part_No'                                     '18' ,
                      '3'  'MAT_DESC   '         'IT_FINAL'  'Material_Description'                                     '18' ,
                      '4'  'SH_DESC    '         'IT_FINAL'  'Item Short Description'                                     '18' ,
                      '5'  'USA_DESC   '         'IT_FINAL'  'Delval USA Item Description'                                     '18' ,
                      '6'  'ITEM_TYPE  '         'IT_FINAL'  'ITEM TYPE'                                     '18' ,
                      '7'  'MAR19      '         'IT_FINAL'  'Units Sold Qty 03/31/19'                                     '18' ,
                      '8'  'FEB19      '         'IT_FINAL'  'Units Sold Qty 02/28/19'                                     '18' ,
                      '9'  'JAN19      '         'IT_FINAL'  'Units Sold Qty 01/31/19'                                     '18' ,
                     '10'  'DEC18      '         'IT_FINAL'  'Units Sold Qty 12/31/18'                                     '18' ,
                     '11'  'NOV18      '         'IT_FINAL'  'Units Sold Qty 11/30/18'                                     '18' ,
                     '12'  'OCT18      '         'IT_FINAL'  'Units Sold Qty 10/31/18'                                     '18' ,
                     '13'  'SEP18      '         'IT_FINAL'  'Units Sold Qty 9/30/18'                                     '18' ,
                     '14'  'AUG18      '         'IT_FINAL'  'Units Sold Qty 8/31/18'                                     '18' ,
                     '15'  'JUL18      '         'IT_FINAL'  'Units Sold Qty 7/31/18'                                     '18' ,
                     '16'  'JUN18      '         'IT_FINAL'  'Units Sold Qty 6/30/18'                                     '18' ,
                     '17'  'MAY18      '         'IT_FINAL'  'Units Sold Qty 5/31/18'                                     '18' ,
                     '18'  'APR18      '         'IT_FINAL'  'Units Sold Qty 4/30/18'                                     '18' ,
                     '19'  'TOTAL_SOLD '         'IT_FINAL'  'Unit Sold Qty  Apr17 Mar18'                                     '18' ,
                     '20'  'TOTAL_SOLD1'         'IT_FINAL'  'Unit Sold Qty  Apr16 Mar17'                                     '18' ,
                     '21'  'PMAR19     '         'IT_FINAL'  'Units Purc Qty 03/31/19'                                     '18' ,
                     '22'  'PFEB19     '         'IT_FINAL'  'Units Purc Qty 02/28/19'                                     '18' ,
                     '23'  'PJAN19     '         'IT_FINAL'  'Units Purc Qty 01/31/19'                                     '18' ,
                     '24'  'PDEC18     '         'IT_FINAL'  'Units Purc Qty 12/31/18'                                     '18' ,
                     '25'  'PNOV18     '         'IT_FINAL'  'Units Purc Qty 11/30/18'                                     '18' ,
                     '26'  'POCT18     '         'IT_FINAL'  'Units Purc Qty 10/31/18'                                     '18' ,
                     '27'  'PSEP18     '         'IT_FINAL'  'Units Purc Qty 9/30/18'                                     '18' ,
                     '28'  'PAUG18     '         'IT_FINAL'  'Units Purc Qty 8/31/18'                                     '18' ,
                     '29'  'PJUL18     '         'IT_FINAL'  'Units Purc Qty 7/31/18'                                     '18' ,
                     '30'  'PJUN18     '         'IT_FINAL'  'Units Purc Qty 6/30/18'                                     '18' ,
                     '31'  'PMAY18     '         'IT_FINAL'  'Units Purc Qty 5/31/18'                                     '18' ,
                     '32'  'PAPR18     '         'IT_FINAL'  'Units Purc Qty 4/30/18'                                     '18' ,
                     '33'  'TOTAL_PUR  '         'IT_FINAL'  'Unit Pur Qty Apr17 Mar18'                                     '18' ,
                     '34'  'TOTAL_PUR1 '         'IT_FINAL'  'Unit Pur  QtyApr16 Mar17'                                     '18' ,
                     '35'  'BRAND      '         'IT_FINAL'  'Brand'                                     '18' ,
                     '36'  'ZSERIES    '         'IT_FINAL'  'Series'                                     '18' ,
                     '37'  'ZSIZE      '         'IT_FINAL'  'Size'                                     '18' ,
                     '38'  'MOC        '         'IT_FINAL'  'MOC'                                     '18' ,
                     '39'  'TYPE       '         'IT_FINAL'  'Type'                                     '18' .

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
ENDFORM.                    " top-of-p

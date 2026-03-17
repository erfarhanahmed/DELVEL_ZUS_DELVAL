*&---------------------------------------------------------------------*
*& Report ZPO_ITEM_TEXT_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_PO_ITEM_TEXT_REPORT.

TABLES:EKKO.

TYPES:BEGIN OF ty_ekko,
      ebeln TYPE ekko-ebeln,
      bukrs TYPE ekko-bukrs,
      lifnr TYPE ekko-lifnr,
      ekgrp TYPE ekko-ekgrp,
      END OF ty_ekko,

      BEGIN OF ty_ekpo,
      ebeln TYPE ekpo-ebeln,
      ebelp TYPE ekpo-ebelp,
      matnr TYPE ekpo-matnr,
      menge TYPE ekpo-menge,
      netpr TYPE ekpo-netpr,
      bstyp TYPE ekpo-bstyp,
      END OF ty_ekpo,

      BEGIN OF ty_lfa1,
      lifnr TYPE lfa1-lifnr,
      name1 TYPE lfa1-name1,
      END OF ty_lfa1,

      BEGIN OF ty_makt,
      matnr TYPE makt-matnr,
      maktx TYPE makt-maktx,
      END OF ty_makt,

      BEGIN OF ty_final,
      ebeln TYPE ekpo-ebeln,
      ebelp TYPE ekpo-ebelp,
*      menge TYPE ekpo-menge,
      text  TYPE char255,
*      name1 TYPE lfa1-name1,
*      lifnr TYPE lfa1-lifnr,
*      matnr TYPE ekpo-matnr,
*      maktx TYPE makt-maktx,
*      netpr TYPE ekpo-netpr,
*      ekgrp TYPE ekko-ekgrp,
      END OF ty_final.

DATA:it_ekko TYPE TABLE OF ty_ekko,
     wa_ekko TYPE          ty_ekko,

     it_ekpo TYPE TABLE OF ty_ekpo,
     wa_ekpo TYPE          ty_ekpo,

     it_makt TYPE TABLE OF ty_makt,
     wa_makt TYPE          ty_makt,

     it_lfa1 TYPE TABLE OF ty_lfa1,
     wa_lfa1 TYPE          ty_lfa1,

     it_final TYPE TABLE OF ty_final,
     wa_final TYPE          ty_final.

TYPES : BEGIN OF ty_fieldnames,
          field_name(30) TYPE c,         "Field names
        END OF ty_fieldnames.
DATA : it_fieldnames TYPE TABLE OF ty_fieldnames,
       wa_fieldnames TYPE ty_fieldnames.




DATA: it_fcat type slis_t_fieldcat_alv,
      wa_fcat like line of it_fcat.

DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt  TYPE tline,
      ls_mattxt  TYPE tline.

DATA   fs_layout TYPE slis_layout_alv.

SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  SELECT-OPTIONS: s_ebeln FOR ekko-ebeln.
  PARAMETERS    : p_bukrs TYPE ekko-bukrs OBLIGATORY DEFAULT 'US00'.
SELECTION-SCREEN:END OF BLOCK b1.


START-OF-SELECTION.
PERFORM get_data.
PERFORM sort_data.
PERFORM get_fcat.
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
SELECT ebeln
       bukrs
       lifnr
       ekgrp FROM ekko INTO TABLE it_ekko
       WHERE ebeln IN s_ebeln
         AND bukrs = p_bukrs.


IF it_ekko IS NOT INITIAL.
SELECT ebeln
       ebelp
       matnr
       menge
       netpr
       bstyp  FROM ekpo INTO TABLE it_ekpo
       FOR ALL ENTRIES IN it_ekko
       WHERE ebeln = it_ekko-ebeln
         AND bstyp = 'F'.

SELECT lifnr
       name1 FROM lfa1 INTO TABLE it_lfa1
       FOR ALL ENTRIES IN it_ekko
       WHERE lifnr = it_ekko-lifnr.

ENDIF.

IF it_ekpo IS NOT INITIAL.
SELECT matnr
       maktx FROM makt INTO TABLE it_makt
       FOR ALL ENTRIES IN it_ekpo
       WHERE matnr = it_ekpo-matnr.
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
*  wa_final-matnr = wa_ekpo-matnr.
*  wa_final-netpr = wa_ekpo-netpr.

*READ TABLE it_makt INTO wa_makt WITH KEY matnr = wa_ekpo-matnr.
*IF sy-subrc = 0.
*  wa_final-maktx = wa_makt-maktx.
*ENDIF.

*READ TABLE it_ekko INTO wa_ekko WITH KEY  ebeln = wa_ekpo-ebeln.
*IF sy-subrc = 0.
* wa_final-lifnr = wa_ekko-lifnr.
* wa_final-ekgrp = wa_ekko-ekgrp.
*ENDIF.

*READ TABLE it_lfa1 INTO wa_lfa1 WITH KEY lifnr = wa_ekko-lifnr.
*IF sy-subrc = 0.
*  wa_final-name1 = wa_lfa1-name1.
*ENDIF.

   CLEAR: lv_lines, ls_mattxt,wa_lines,lv_name.
      REFRESH lv_lines.
*      lv_name = wa_final-ebeln.
      CONCATENATE wa_final-ebeln wa_final-ebelp INTO lv_name.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'F01'
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
        LOOP AT lv_lines INTO wa_lines.
          IF NOT wa_lines-tdline IS INITIAL.
            CONCATENATE WA_final-text wa_lines-tdline INTO wa_final-text SEPARATED BY space.
          ENDIF.
        ENDLOOP.

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
PERFORM FCAT USING :   "'1'   'LIFNR'           'IT_FINAL'      'Vendor Code'                 '15' ,
                       "'2'   'NAME1'           'IT_FINAL'      'Vendor Name'                 '20' ,
                       '1'   'EBELN'           'IT_FINAL'      'PO No'                       '15' ,
                       '2'   'EBELP'           'IT_FINAL'      'PO Line Item '               '15' ,
                       "'5'   'EKGRP'           'IT_FINAL'      'Purchasing Group '           '20' ,
                       "'6'   'MATNR'           'IT_FINAL'      'Material '                   '15' ,
                      " '7'   'MAKTX'           'IT_FINAL'      'Material Description '       '25' ,
                       "'8'   'NETPR'           'IT_FINAL'      'Net Price '                  '10' ,
                       '3'   'TEXT'            'IT_FINAL'      'Item Text'                   '60'.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0325   text
*      -->P_0326   text
*      -->P_0327   text
*      -->P_0328   text
*      -->P_0329   text
*----------------------------------------------------------------------*
FORM fcat  USING    VALUE(p1)
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

append wa_fcat to it_fcat.
CLEAR wa_fcat.

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
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
   EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
     I_CALLBACK_PROGRAM                = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
     I_CALLBACK_TOP_OF_PAGE            = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
*     I_GRID_TITLE                      =
*     I_GRID_SETTINGS                   =
     IS_LAYOUT                         = fs_layout
     IT_FIELDCAT                       = it_fcat
*     IT_EXCLUDING                      =
*     IT_SPECIAL_GROUPS                 =
*     IT_SORT                           =
*     IT_FILTER                         =
*     IS_SEL_HIDE                       =
*     I_DEFAULT                         = 'X'
     I_SAVE                            = 'X'
*     IS_VARIANT                        =
*     IT_EVENTS                         =
*     IT_EVENT_EXIT                     =
*     IS_PRINT                          =
*     IS_REPREP_ID                      =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS                   =
*     IT_HYPERLINK                      =
*     IT_ADD_FIELDCAT                   =
*     IT_EXCEPT_QINFO                   =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab                          = it_final
*   EXCEPTIONS
*     PROGRAM_ERROR                     = 1
*     OTHERS                            = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

PERFORM download.
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
  wa_header-info = 'PO Item Text Report'.
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
*&---------------------------------------------------------------------*
*&      Form  DOWNLOAD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DOWNLOAD .
PERFORM fieldname.

DATA : v_fullpath      TYPE string.

  CALL FUNCTION 'GUI_FILE_SAVE_DIALOG'
    EXPORTING
      window_title      = 'STATUS RECORD FILE'
      default_extension = 'LOG.xls'
    IMPORTING
*     filename          = v_efile
      fullpath          = v_fullpath.

CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        filename                = v_fullpath
        filetype                = 'ASC'
        write_field_separator   = 'X'
        show_transfer_status    = ' '
      TABLES
*       data_tab                = lt_consume2
        data_tab                = it_final
        fieldnames              = it_fieldnames
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        OTHERS                  = 22.
    IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*           WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELDNAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELDNAME .
    wa_fieldnames-field_name = 'PO No'.
    APPEND wa_fieldnames TO it_fieldnames.

    wa_fieldnames-field_name = 'PO Line Item'.
    APPEND wa_fieldnames TO it_fieldnames.

    wa_fieldnames-field_name = 'Item Text'.
    APPEND wa_fieldnames TO it_fieldnames.
ENDFORM.

*&---------------------------------------------------------------------*
*& Report ZUS_MB1B_BAPI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_MB1B_BAPI
       no standard page heading line-size 255.

TYPES: BEGIN OF gty_upload,
         srno       TYPE sy-tabix,
         BLDAT      TYPE mkpf-BLDAT,
         BUDAT      TYPE mkpf-BUDAT,
         material   TYPE mseg-matnr,
         plant      TYPE mseg-werks,
         MOVE_PLANT TYPE mseg-werks,
         stge_loc   TYPE mseg-lgort,
         move_stloc TYPE mseg-lgort,
         SALES_ORD  TYPE vbap-vbeln,
         S_ORD_ITEM TYPE vbap-posnr,
         spec_stock TYPE mseg-sobkz,
         entry_qnt  TYPE char16,
         VAL_SALES_ORD TYPE vbap-vbeln,
         VAL_S_ORD_ITEM TYPE vbap-posnr,
         move_mat   TYPE mseg-matnr,
*         batch      TYPE charg_d,
*         move_batch TYPE umcha,
       END OF gty_upload.

TYPES : BEGIN OF gty_log,
          srno       TYPE sy-tabix,
          BLDAT      TYPE mkpf-BLDAT,
          BUDAT      TYPE mkpf-BUDAT,
          matno      TYPE matnr,
          plant      TYPE werks,
          move_stloc TYPE mseg-lgort,
          stge_loc   TYPE mseg-lgort,
          batch      TYPE charg_d,
          move_batch TYPE umcha,
          matdoc_no  LIKE bapi2017_gm_head_ret,
          type       TYPE bapiret2-type,
          message    TYPE bapiret2-message,
        END OF gty_log.

DATA: gt_log  TYPE TABLE OF gty_log,
      gwa_log TYPE gty_log.

DATA: gt_upload  TYPE TABLE OF gty_upload,
      gwa_upload TYPE gty_upload.

SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_file TYPE rlgrap-filename OBLIGATORY.
SELECTION-SCREEN END OF BLOCK blk1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM p_f4_help.

START-OF-SELECTION.

  PERFORM p_upload_file.
  PERFORM p_call_bapi.
  PERFORM p_display.
*&---------------------------------------------------------------------*
*& Form P_F4_HELP
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM p_f4_help .
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
      field_name    = ' '
    IMPORTING
      file_name     = p_file.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form P_UPLOAD_FILE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM p_upload_file .

  DATA: gt_raw TYPE truxs_t_text_data.

  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
*      i_field_seperator    = 'X'
      i_line_header        = 'X'
      i_tab_raw_data       = gt_raw
      i_filename           = p_file
    TABLES
      i_tab_converted_data = gt_upload
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form P_CALL_BAPI
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM p_call_bapi .

  DATA: gwa_header TYPE bapi2017_gm_head_01,
        gt_item    TYPE TABLE OF bapi2017_gm_item_create,
        gwa_item   TYPE bapi2017_gm_item_create,
        lv_gmcode  TYPE bapi2017_gm_code,
        lv_doc     LIKE bapi2017_gm_head_ret,
        gt_return  TYPE TABLE OF bapiret2,
        gwa_return TYPE bapiret2.



  lv_gmcode = '04'.
  LOOP AT gt_upload INTO gwa_upload.
    gwa_header-pstng_date =  gwa_upload-BUDAT. "sy-datum.
    gwa_header-doc_date   =  gwa_upload-BLDAT. "sy-datum.
    gwa_item-move_type = '413'.
    gwa_item-spec_stock = gwa_upload-spec_stock.
    gwa_item-material = gwa_upload-material." |{ gwa_upload-material  ALPHA = IN }|.
    gwa_item-plant = gwa_upload-plant.
    gwa_item-MOVE_PLANT = gwa_upload-MOVE_PLANT.
    gwa_item-stge_loc = gwa_upload-stge_loc.
    gwa_item-move_stloc = gwa_upload-move_stloc.
    gwa_item-entry_qnt = gwa_upload-entry_qnt.
    gwa_item-VAL_SALES_ORD  = gwa_upload-VAL_SALES_ORD .
*    gwa_item-ORDERID  = gwa_upload-VAL_SALES_ORD .
    gwa_item-VAL_S_ORD_ITEM = gwa_upload-VAL_S_ORD_ITEM.
*    gwa_item-ORDER_ITNO = gwa_upload-VAL_S_ORD_ITEM.
    gwa_item-SALES_ORD  = gwa_upload-SALES_ORD .
    gwa_item-S_ORD_ITEM = gwa_upload-S_ORD_ITEM.
    gwa_item-move_mat = gwa_upload-move_mat.
*    gwa_item-batch = gwa_upload-batch     .
*    gwa_item-move_batch = gwa_upload-move_batch.

    APPEND gwa_item TO gt_item.
    CLEAR: gwa_item.

    CALL FUNCTION 'BAPI_GOODSMVT_CREATE'
      EXPORTING
        goodsmvt_header  = gwa_header
        goodsmvt_code    = lv_gmcode
      IMPORTING
        goodsmvt_headret = lv_doc
      TABLES
        goodsmvt_item    = gt_item
        return           = gt_return.

    IF lv_doc IS NOT INITIAL.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
    ENDIF.

    gwa_log-srno = gwa_upload-srno.
    gwa_log-BLDAT = gwa_upload-BLDAT.
    gwa_log-BUDAT = gwa_upload-BUDAT.
    gwa_log-plant = gwa_upload-plant.
    gwa_log-matdoc_no = lv_doc.
    gwa_log-matno = gwa_upload-material.
    gwa_log-stge_loc   = gwa_upload-stge_loc.
    gwa_log-move_stloc = gwa_upload-move_stloc.
*    gwa_log-batch   = gwa_upload-batch.
*    gwa_log-move_batch = gwa_upload-move_batch.

    IF gt_return IS INITIAL.
      gwa_log-type   = 'S'.
      gwa_log-message = '413 Movement Successful.'.
      APPEND gwa_log TO gt_log.
    ELSE.
      LOOP AT gt_return INTO gwa_return.
        gwa_log-message = gwa_return-message.
        gwa_log-type   = gwa_return-type.
        APPEND gwa_log TO gt_log.
      ENDLOOP.
    ENDIF.
    CLEAR: gt_item, gwa_item, gwa_header, gt_return, gwa_return, gwa_log, lv_doc.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form P_DISPLAY
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM p_display .
  cl_salv_table=>factory( IMPORTING r_salv_table = DATA(gr_table)
                          CHANGING t_table = gt_log ).

  DATA(columns) = gr_table->get_columns( ).
  columns->set_optimize( ).

  DATA(functions) = gr_table->get_functions( ).
  functions->set_all( ).

  gr_table->display( ).
ENDFORM.

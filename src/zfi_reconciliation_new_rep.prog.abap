*&---------------------------------------------------------------------*
*& Report ZFI_RECONCILIATION_NEW_REP .
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zfi_reconciliation_new_rep.

TYPE-POOLS : sdydo,dbpsj,slis,icon.
TABLES     : bsis,t100.
DATA: dd(02) TYPE c,
      mm(02) TYPE c,
      yy(04) TYPE c.
DATA : BEGIN OF w_t012,
         bukrs TYPE t012-bukrs,
         hdkid TYPE t012-hbkid,
         banks TYPE t012-banks,
         hkont TYPE t012k-hkont,
       END OF w_t012.

DATA : v_hkont1 TYPE bsas-hkont,
       v_hkont2 TYPE bsas-hkont.

TYPES : BEGIN OF t_bsis,
          belnr TYPE bsis-belnr,
          budat TYPE bsis-budat,
          zuonr TYPE bsis-zuonr,
          shkzg TYPE bsis-shkzg,
          dmbtr TYPE bsis-dmbtr,
          gsber TYPE bsis-gsber,
          prctr TYPE bsis-prctr,
          buzei TYPE bsis-buzei,
          bukrs TYPE bsis-bukrs,
          gjahr TYPE bsis-gjahr,
          blart TYPE bsis-blart,
          name  TYPE zus_bankreco-name,
        END OF t_bsis.

DATA : name TYPE zus_bankreco-name.
DATA : v_augdt TYPE bsis-budat.
DATA : w_bsis TYPE t_bsis,
       i_bsis TYPE TABLE OF t_bsis.

TYPES : BEGIN OF t_gs_outtab.
    INCLUDE STRUCTURE zus_bankreco.

TYPES :
  v_augdt  TYPE bsis-budat,
  checkbox TYPE c,
  gsber    TYPE bsis-gsber,
  prctr    TYPE bsis-prctr,
  r_date   TYPE bsis-budat.
TYPES : END OF t_gs_outtab.

TYPES : BEGIN OF t_bseg,
          belnr TYPE bsis-belnr,
          buzei TYPE bsis-buzei,
          hkont TYPE bseg-hkont,
          kunnr TYPE bseg-kunnr,
          lifnr TYPE bseg-lifnr,
        END OF t_bseg.

DATA : w_bseg  TYPE t_bseg,
       i_bseg  TYPE TABLE OF t_bseg,
       if_bseg TYPE TABLE OF t_bseg.

DATA : w_gs_outtab    TYPE t_gs_outtab,
       w_gs_outtab_us TYPE t_gs_outtab,
       i_gs_outtab    TYPE TABLE OF t_gs_outtab.

DATA :   bdcdata LIKE bdcdata    OCCURS 0 WITH HEADER LINE.
*       messages of call transaction
DATA :   messtab LIKE bdcmsgcoll OCCURS 0 WITH HEADER LINE.

DATA : ok_code            LIKE sy-ucomm,
       lt_list_commentary TYPE slis_t_listheader, """COMENTARY
       save_ok            LIKE sy-ucomm,
       g_container        TYPE scrfname VALUE 'CON',
       grid1              TYPE REF TO cl_gui_alv_grid,
       gt_fieldcat        TYPE lvc_t_fcat,
       g_custom_container TYPE REF TO cl_gui_custom_container,
       gs_layout          TYPE lvc_s_layo,
       g_max              TYPE i VALUE 100,
       ls_celltab         TYPE lvc_s_styl,
       lt_celltab         TYPE lvc_t_styl,
       v_text             TYPE t012t-text1,
       l_index            TYPE i.
DATA : nodata VALUE '/' .
DATA : j_gs_outtab  TYPE TABLE OF t_gs_outtab,docno(10) TYPE c,w1_gs_outtab TYPE t_gs_outtab.


***********************************************************************
CLASS:      lcl_alv_toolbar   DEFINITION DEFERRED.

DATA : c_alv_toolbar        TYPE REF TO lcl_alv_toolbar,           "Alv toolbar
       c_alv_toolbarmanager TYPE REF TO cl_alv_grid_toolbar_manager,  "Toolbar manager
       c_alvgd              TYPE REF TO cl_gui_alv_grid,   "ALV grid object
       o_event              TYPE REF TO cl_alv_event_toolbar_set. "Events
DATA : ty_toolbar TYPE stb_button.

TYPES: BEGIN OF ty_button,
         function  TYPE stb_button-function,
         icon      TYPE stb_button-icon,
         quickinfo TYPE stb_button-quickinfo,
         butn_type TYPE stb_button-butn_type,
         disabled  TYPE stb_button-disabled,
         text      TYPE stb_button-text,
         checked   TYPE stb_button-checked,
       END OF ty_button.

*******************************************************************************************************************
*---------------------------------------------------------------------
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_bukrs LIKE bsis-bukrs OBLIGATORY,
            p_hbkid LIKE t012-hbkid OBLIGATORY,
            p_budat LIKE bsis-budat.
*****SELECT-OPTIONS :   s_prctr FOR bsis-prctr.
SELECTION-SCREEN END OF BLOCK b1.
*----------------------------------------------------------------------

START-OF-SELECTION.
  PERFORM get_data.
  "PERFORM TOP_PAGE.

END-OF-SELECTION.
  CALL SCREEN 100.

**************************************************************************
CLASS lcl_alv_toolbar DEFINITION.
  PUBLIC SECTION.

    METHODS: constructor
      IMPORTING
        io_alv_grid TYPE REF TO cl_gui_alv_grid,
      on_toolbar
      FOR EVENT toolbar
            OF  cl_gui_alv_grid
        IMPORTING
            e_object,
      handle_user_command
                    FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.

ENDCLASS.

CLASS lcl_alv_toolbar IMPLEMENTATION.
  METHOD constructor.
    CREATE OBJECT c_alv_toolbarmanager
      EXPORTING
        io_alv_grid = io_alv_grid.

  ENDMETHOD.

  METHOD on_toolbar.
    ty_toolbar-function = 'SLCT'.
    ty_toolbar-icon      =  icon_select_all.
    ty_toolbar-butn_type = 0.
    ty_toolbar-text = 'Select all'.
    APPEND ty_toolbar TO e_object->mt_toolbar.
    ty_toolbar-function = 'DLCT'.
    ty_toolbar-icon      =  icon_deselect_all.
    ty_toolbar-butn_type = 0.
    ty_toolbar-text = 'Deselect all'.
    APPEND ty_toolbar TO e_object->mt_toolbar.

  ENDMETHOD.

  METHOD handle_user_command.
    PERFORM user_command USING e_ucomm.
  ENDMETHOD.

ENDCLASS.                    "lcl_alv_toolbar IMPLEMENTATION

****************************************************************************************************
FORM get_data .
  SELECT SINGLE a~bukrs a~hbkid a~banks b~hkont INTO w_t012 FROM t012 AS a
                                             INNER JOIN t012k AS b ON
                                             a~bukrs = b~bukrs AND
                                             a~hbkid = b~hbkid
                                             WHERE
                                             a~bukrs = p_bukrs AND
  a~hbkid = p_hbkid.

  SELECT SINGLE text1 INTO v_text FROM t012t
                                   WHERE
                                   spras = 'EN' AND
                                   bukrs = w_t012-bukrs AND
  hbkid = w_t012-hdkid.
*  v_hkont1 = w_t012-hkont + 1.
  v_hkont1 = w_t012-hkont + 2.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = v_hkont1
    IMPORTING
      output = v_hkont1.

  SELECT belnr budat zuonr shkzg dmbtr gsber buzei bukrs gjahr blart INTO  CORRESPONDING FIELDS OF TABLE i_bsis FROM bsis "prctr
                                  WHERE
*****                                  prctr IN s_prctr AND
                                  bukrs = w_t012-bukrs AND
                                  hkont = v_hkont1 AND
  budat <= p_budat.

*  v_hkont2 = v_hkont1 + 1.
  v_hkont2 = v_hkont1 - 1.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = v_hkont2
    IMPORTING
      output = v_hkont2.

  SELECT belnr budat zuonr shkzg dmbtr gsber  buzei bukrs gjahr blart APPENDING CORRESPONDING FIELDS OF TABLE i_bsis FROM bsis  "prctr
                                  WHERE
*****                                  prctr IN s_prctr AND
                                  bukrs = w_t012-bukrs AND
                                  hkont = v_hkont2 AND
  budat <= p_budat.

********************************************code added by sachin shende*******************************************************
  LOOP AT i_bsis INTO w_bsis.
    IF ( w_bsis-belnr BETWEEN 7100001280 AND 7100001290 ) AND w_bsis-gjahr EQ 2015." or w_bsis-belnr eq 7200004223.
      DELETE i_bsis WHERE belnr EQ w_bsis-belnr.
    ENDIF.
    IF ( w_bsis-belnr EQ 7200004309 OR w_bsis-belnr EQ 7200004312
      OR w_bsis-belnr EQ 7200004314 OR w_bsis-belnr EQ 7200004315
      OR w_bsis-belnr EQ 7200004318 ) AND w_bsis-gjahr EQ 2014." or w_bsis-belnr eq 7200004223.
      DELETE i_bsis WHERE belnr EQ w_bsis-belnr.
    ENDIF.
  ENDLOOP.
********************************************code added by sachin shende*******************************************************

  LOOP AT i_bsis INTO w_bsis.
    CLEAR w_bseg.
    SELECT  SINGLE belnr buzei hkont kunnr lifnr FROM bseg INTO CORRESPONDING FIELDS OF w_bseg
                                  WHERE
                                   belnr = w_bsis-belnr AND
                                   shkzg NE w_bsis-shkzg AND
                                   buzei NE w_bsis-buzei AND
                                   gjahr EQ w_bsis-gjahr AND
    bukrs EQ w_bsis-bukrs.
    IF sy-subrc EQ 0.
      APPEND w_bseg TO if_bseg.
    ENDIF.
  ENDLOOP.

  SORT i_bsis ASCENDING BY belnr.
  SORT if_bseg ASCENDING BY belnr.

  LOOP AT i_bsis INTO w_bsis.
    READ TABLE  if_bseg INTO w_bseg WITH KEY belnr = w_bsis-belnr.
    CHECK sy-subrc EQ 0.
    IF w_bseg-kunnr IS NOT INITIAL.
      SELECT SINGLE name1 FROM kna1 INTO name WHERE kunnr = w_bseg-kunnr.
    ENDIF.

    IF w_bseg-lifnr IS NOT INITIAL.
      SELECT SINGLE name1 FROM lfa1 INTO name WHERE lifnr = w_bseg-lifnr.

    ENDIF.

    IF w_bseg-kunnr IS INITIAL.
      IF w_bseg-lifnr IS INITIAL.
        SELECT SINGLE txt50 FROM skat INTO name WHERE ktopl = '1000' AND
        saknr = w_bseg-hkont.

      ENDIF.
    ENDIF.
    w_bsis-name = name.
    MODIFY i_bsis FROM w_bsis TRANSPORTING name.
    CLEAR name.

  ENDLOOP.

  LOOP AT i_bsis INTO w_bsis.
    SELECT SINGLE chect FROM payr INTO w_bsis-zuonr WHERE vblnr EQ w_bsis-belnr AND gjahr EQ  w_bsis-gjahr.
    IF sy-subrc EQ 0.
      MODIFY i_bsis FROM w_bsis TRANSPORTING zuonr.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " GET_DATA
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'MAIN100'.
  SET TITLEBAR 'MAIN100'.
  IF g_custom_container IS INITIAL.
********************** Added By Shweta And (Toshit And Sujata)***********
    CREATE OBJECT g_custom_container
      EXPORTING
        container_name = g_container.

    CREATE OBJECT grid1
      EXPORTING
        i_parent = g_custom_container.

    CREATE OBJECT c_alv_toolbar
      EXPORTING
        io_alv_grid = grid1.

**********************************************************************
    PERFORM create_and_init_alv.

    PERFORM build_comment USING
                   lt_list_commentary.
******************** Added By Shweta And (Toshit And Sujata)****************

    IF grid1 IS NOT INITIAL.
      SET HANDLER c_alv_toolbar->on_toolbar FOR grid1.
    ENDIF.

    SET HANDLER c_alv_toolbar->handle_user_command FOR grid1.
*****************************************************************************
    CALL METHOD grid1->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_fieldcatalog = gt_fieldcat                 "it_toolbar_excluding = lt_exclude
        it_outtab       = i_gs_outtab.

  ENDIF.

ENDMODULE.                 " STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Form  CREATE_AND_INIT_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_and_init_alv .
  PERFORM build_fieldcat CHANGING gt_fieldcat.
ENDFORM.                    " CREATE_AND_INIT_ALV
*&---------------------------------------------------------------------*
*&      Form  BUILD_FIELDCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_FIELDCAT  text
*----------------------------------------------------------------------*
FORM build_fieldcat CHANGING pt_fieldcat TYPE lvc_t_fcat.

  DATA ls_fcat TYPE lvc_s_fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'zUS_bankreco'
    CHANGING
      ct_fieldcat      = pt_fieldcat.

*§A2.Add an entry for the checkbox in the fieldcatalog
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'V_AUGDT'.
*  ls_fcat-checkbox = 'X'.
  ls_fcat-edit = 'X'.
  ls_fcat-col_pos = '10'.
  ls_fcat-coltext = TEXT-f02.
  ls_fcat-outputlen = 10.
  ls_fcat-scrtext_l = 'Value Date'.
  APPEND ls_fcat TO pt_fieldcat.

*§A2.Add an entry for the checkbox in the fieldcatalog
  CLEAR ls_fcat.
  ls_fcat-fieldname = 'CHECKBOX'.
  ls_fcat-checkbox = 'X'.
  ls_fcat-edit = 'X'.
  ls_fcat-col_pos = '11'.
  ls_fcat-coltext = TEXT-f01.
  ls_fcat-outputlen = 12.
  ls_fcat-scrtext_l = 'Check Box'.
  APPEND ls_fcat TO pt_fieldcat.

  LOOP AT i_bsis INTO w_bsis.
    MOVE-CORRESPONDING w_bsis TO w_gs_outtab.
*    IF w_gs_outtab-prctr IS INITIAL.
*      SELECT SINGLE prctr FROM acdoca INTO w_gs_outtab-prctr WHERE belnr = w_bsis-belnr AND gjahr = w_bsis-gjahr.
*    ENDIF.
    IF w_bsis-shkzg = 'H'.
      w_gs_outtab-shkzg = 'P'.
      w_gs_outtab-credit = w_bsis-dmbtr.
    ELSE.
      w_gs_outtab-shkzg = 'R'.
      w_gs_outtab-debit = w_bsis-dmbtr.
    ENDIF.
    APPEND w_gs_outtab TO i_gs_outtab.
    CLEAR w_gs_outtab.
  ENDLOOP.
ENDFORM.                    " BUILD_FIELDCAT
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  save_ok = sy-ucomm.
  CLEAR ok_code.
  CASE save_ok.
    WHEN 'BACK'.
***      LEAVE PROGRAM.
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
      PERFORM save_entries .
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*&      Form  SAVE_ENTRIES
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_I_GS_OUTTAB  text
*----------------------------------------------------------------------*
FORM save_entries  .
  DATA: l_valid  TYPE c,
        l_locked TYPE c.
  CALL METHOD grid1->check_changed_data
    IMPORTING
      e_valid = l_valid.

  LOOP AT i_gs_outtab INTO w_gs_outtab WHERE checkbox = 'X'.
    IF  p_bukrs = 'US00'.
    w_gs_outtab_us = w_gs_outtab.
    EXPORT w_gs_outtab_us TO MEMORY ID 'CODE'.
    ENDIF.

    PERFORM bdc.
  ENDLOOP.
  PERFORM post.
  CALL METHOD grid1->refresh_table_display.
  CLEAR: i_gs_outtab.
  "LEAVE TO TRANSACTION 'ZRECO'.
ENDFORM.                    " SAVE_ENTRIES
*&---------------------------------------------------------------------*
*&      Form  BDC
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM bdc .
  DATA: v_date(10),
        v_date2(10),
        amt(17).

  PERFORM bdc_dynpro      USING 'SAPMF05A' '0122'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'BKPF-BLDAT'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '/00'.

  WRITE w_gs_outtab-budat TO v_date.
  PERFORM bdc_field       USING 'BKPF-BLDAT'
                                v_date.

  PERFORM bdc_field       USING 'BKPF-BLART'
                                'ZR'.
  PERFORM bdc_field       USING 'BKPF-BUKRS'
                                p_bukrs.
  IF p_budat IS INITIAL.
    WRITE sy-datum TO v_date.   "sy-datum
  ELSE.
    WRITE p_budat TO v_date. " p_budat
  ENDIF.
  PERFORM bdc_field       USING 'BKPF-BUDAT'
                                v_date.
  PERFORM bdc_field       USING 'BKPF-WAERS'
                                'USD'.
  PERFORM bdc_field       USING 'BKPF-XBLNR'
                                'Bank Recon'.
  PERFORM bdc_field       USING 'FS006-DOCID'
                                '*'.
  IF w_gs_outtab-shkzg = 'P'.                               " 50 H 40 S
    PERFORM bdc_field       USING 'RF05A-NEWBS'
                                  '50'.
  ELSE.
    PERFORM bdc_field       USING 'RF05A-NEWBS'
                               '40'.
  ENDIF.

  PERFORM bdc_field       USING 'RF05A-NEWKO'
                                w_t012-hkont.
  PERFORM bdc_field       USING 'RF05A-XPOS1(02)'
                                ''.
  PERFORM bdc_field       USING 'RF05A-XPOS1(04)'
                                'X'.

  PERFORM bdc_dynpro      USING 'SAPMF05A' '0300'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RF05A-NEWBS'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '/00'.
  IF w_gs_outtab-shkzg = 'P'.
    amt = w_gs_outtab-credit.
    PERFORM bdc_field       USING 'BSEG-WRBTR'
                                  amt.
  ELSE.
    amt = w_gs_outtab-debit.
    PERFORM bdc_field       USING 'BSEG-WRBTR'
                               amt.
  ENDIF.
  v_date2 = w_gs_outtab-v_augdt .
  dd =  v_date2+6(2) .
  mm =   v_date2+4(2) .
  yy =  v_date2+0(4).
  IF p_bukrs = 'US00'.
    CONCATENATE mm dd yy INTO v_date2 SEPARATED BY '-'.
  ELSE.
    CONCATENATE dd mm yy INTO v_date2 SEPARATED BY '.'.

  ENDIF.

  PERFORM bdc_field       USING 'BSEG-VALUT'
                              v_date2.
  PERFORM bdc_field       USING 'BSEG-ZUONR'
                                w_gs_outtab-zuonr.
  PERFORM bdc_field       USING 'BSEG-SGTXT'
                                'Bank Recon'.

  PERFORM bdc_dynpro      USING 'SAPLKACB' '0002'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'COBL-PRCTR'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=ENTE'.

*****  PERFORM bdc_field       USING 'COBL-GSBER'
*****                                w_gs_outtab-gsber.

  PERFORM bdc_field       USING 'COBL-PRCTR'
                                w_gs_outtab-prctr.

  PERFORM bdc_dynpro      USING 'SAPMF05A' '0300'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'BSEG-WRBTR'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=SL'.
  PERFORM bdc_field       USING 'DKACB-FMORE'
                                'X'.
  PERFORM bdc_dynpro      USING 'SAPLKACB' '0002'.
****  PERFORM bdc_field       USING 'BDC_CURSOR'
****                                'COBL-GSBER'.

  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'COBL-PRCTR'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=ENTE'.

  PERFORM bdc_dynpro      USING 'SAPMF05A' '0710'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RF05A-AGKON'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '/00'.
  PERFORM bdc_field       USING 'RF05A-AGBUK'
                                p_bukrs.
  IF w_gs_outtab-shkzg = 'R'.
    PERFORM bdc_field       USING 'RF05A-AGKON'  "check dependng on H or S
                                  v_hkont2.
  ELSE.
    PERFORM bdc_field       USING 'RF05A-AGKON'  "check dependng on H or S
                                v_hkont1.
  ENDIF.
  PERFORM bdc_field       USING 'RF05A-AGKOA'
                                'S'.
  PERFORM bdc_field       USING 'RF05A-XNOPS'
                                'X'.

  PERFORM bdc_dynpro      USING 'SAPDF05X' '3100'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=OSU'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RF05A-ABPOS'.
  PERFORM bdc_field       USING 'RF05A-ABPOS'
                                '1'.

  PERFORM bdc_dynpro      USING 'SAPDF05X' '2000'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RF05A-XPOS1(03)'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=GO'.
  PERFORM bdc_field       USING 'RF05A-XPOS1(01)'
                                ''.
  PERFORM bdc_field       USING 'RF05A-XPOS1(03)'
                                'X'.

  PERFORM bdc_dynpro      USING 'SAPDF05X' '0731'.
  PERFORM bdc_field       USING 'BDC_CURSOR'
                                'RF05A-SEL01(01)'.
  PERFORM bdc_field       USING 'BDC_OKCODE'
                                '=GO'.
  PERFORM bdc_field       USING 'RF05A-SEL01(01)'
  w_gs_outtab-belnr
  .
perform bdc_dynpro      using 'SAPDF05X' '3100'.
perform bdc_field       using 'BDC_OKCODE'
                              '=OMK'.
perform bdc_field       using 'BDC_CURSOR'
                              'RFOPS_DK-ZUONR(01)'.
perform bdc_field       using 'RF05A-ABPOS'
                              '1'.
perform bdc_dynpro      using 'SAPDF05X' '3100'.
perform bdc_field       using 'BDC_OKCODE'
                              '=Z+'.
perform bdc_field       using 'BDC_CURSOR'
                              'RFOPS_DK-ZUONR(01)'.
perform bdc_field       using 'RF05A-ABPOS'
                              '1'.
perform bdc_dynpro      using 'SAPDF05X' '3100'.
perform bdc_field       using 'BDC_OKCODE'
                              '=BU'.
perform bdc_field       using 'BDC_CURSOR'
                              'RFOPS_DK-ZUONR(01)'.
perform bdc_field       using 'RF05A-ABPOS'
                              '1'.
*  PERFORM bdc_dynpro      USING 'SAPDF05X' '3100'.
*  PERFORM bdc_field       USING 'BDC_OKCODE'
*                                '=PI'.
*  PERFORM bdc_field       USING 'BDC_CURSOR'
*                                'DF05B-PSBET(01)'.
*  PERFORM bdc_field       USING 'RF05A-ABPOS'
*                                '1'.
*
*  PERFORM bdc_dynpro      USING 'SAPDF05X' '3100'.
*  PERFORM bdc_field       USING 'BDC_OKCODE'
*                                '=BU'.
*  PERFORM bdc_field       USING 'BDC_CURSOR'
*                                'DF05B-PSBET(01)'.
*  PERFORM bdc_field       USING 'RF05A-ABPOS'
*                                '1'.
  PERFORM bdc_transaction USING 'F-04' CHANGING docno.

  IF docno IS NOT INITIAL.
    w1_gs_outtab-belnr  = w_gs_outtab-belnr.
    w1_gs_outtab-zuonr  = docno.
    w1_gs_outtab-r_date = w_gs_outtab-budat.
    APPEND w1_gs_outtab TO j_gs_outtab.
    CLEAR w1_gs_outtab.
  ENDIF.
  WAIT UP TO 2 SECONDS.

ENDFORM.                    " BDC

*----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
  CLEAR bdcdata.
  bdcdata-program  = program.
  bdcdata-dynpro   = dynpro.
  bdcdata-dynbegin = 'X'.
  APPEND bdcdata.
ENDFORM.                    "BDC_DYNPRO

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
  "IF FVAL <> NODATA.
  CLEAR bdcdata.
  bdcdata-fnam = fnam.
  bdcdata-fval = fval.
  APPEND bdcdata.
  "ENDIF.
ENDFORM.                    "BDC_FIELD

*&---------------------------------------------------------------------*
*&      Form  BDC_TRANSACTION
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->TCODE      text
*----------------------------------------------------------------------*
FORM bdc_transaction USING tcode CHANGING docno TYPE c.
  DATA: l_mstring(480).

* batch input session
  REFRESH messtab.
  CALL TRANSACTION tcode USING bdcdata
                   MODE   'E'
                   UPDATE 'A'
                   MESSAGES INTO messtab.

  WRITE: / 'CALL_TRANSACTION',
           tcode,
           'returncode:'(i05),
           sy-subrc,
           'RECORD:',
           sy-index.
  LOOP AT messtab.
    SELECT SINGLE * FROM t100 WHERE sprsl = messtab-msgspra
                              AND   arbgb = messtab-msgid
    AND   msgnr = messtab-msgnr.
    IF sy-subrc = 0.
      l_mstring = t100-text.
      IF l_mstring CS '&1'.
        REPLACE '&1' WITH messtab-msgv1 INTO l_mstring.
        REPLACE '&2' WITH messtab-msgv2 INTO l_mstring.
        REPLACE '&3' WITH messtab-msgv3 INTO l_mstring.
        REPLACE '&4' WITH messtab-msgv4 INTO l_mstring.
      ELSE.
        REPLACE '&' WITH messtab-msgv1 INTO l_mstring.
        REPLACE '&' WITH messtab-msgv2 INTO l_mstring.
        REPLACE '&' WITH messtab-msgv3 INTO l_mstring.
        REPLACE '&' WITH messtab-msgv4 INTO l_mstring.
        docno = messtab-msgv1.
      ENDIF.
      CONDENSE l_mstring.
      WRITE: / messtab-msgtyp, l_mstring(250).
    ELSE.
      WRITE: / messtab.
    ENDIF.
  ENDLOOP.

  SKIP.
  REFRESH bdcdata.
ENDFORM.                    "BDC_TRANSACTION
*&---------------------------------------------------------------------*
*&      Form  BUILD_COMMENT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LT_LIST_COMMENTARY  text
*----------------------------------------------------------------------*
FORM build_comment  USING    pt_list_commentary TYPE slis_t_listheader.
  DATA: ls_line  TYPE slis_listheader, text(60) TYPE c.
  CLEAR ls_line.
  ls_line-typ  = 'H'.
* LS_LINE-KEY:  NOT USED FOR THIS TYPE
  ls_line-info = v_text.
  APPEND ls_line TO pt_list_commentary.

ENDFORM.                    " BUILD_COMMENT
*&---------------------------------------------------------------------*
*&      Form  POST
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM post .
*form posted_documents .

  DATA: i_fcat TYPE slis_t_fieldcat_alv,
        w_fcat TYPE slis_fieldcat_alv.

  w_fcat-col_pos   = 1.
  w_fcat-fieldname = 'BELNR'.
  w_fcat-tabname   = 'J_GS_OUTTAB'.
  w_fcat-seltext_l = 'Document No.'.
  APPEND w_fcat TO i_fcat.
  CLEAR w_fcat.

  w_fcat-col_pos   = 2.
  w_fcat-fieldname = 'ZUONR'.
  w_fcat-tabname   = 'J_GS_OUTTAB'.
  w_fcat-seltext_l = 'Post Doc. No.'.
  APPEND w_fcat TO i_fcat.
  CLEAR w_fcat.

  w_fcat-col_pos   = 3.
  w_fcat-fieldname = 'R_DATE'.
  w_fcat-tabname   = 'J_GS_OUTTAB'.
  w_fcat-seltext_l = 'Post Date.'.
  APPEND w_fcat TO i_fcat.
  CLEAR w_fcat.

  w_fcat-col_pos   = 4.
  w_fcat-fieldname = 'CREDIT'.
  w_fcat-tabname   = 'J_GS_OUTTAB'.
  w_fcat-seltext_l = 'CREDIT'.
  APPEND w_fcat TO i_fcat.
  CLEAR w_fcat.

  w_fcat-col_pos   = 5.
  w_fcat-fieldname = 'DEBIT'.
  w_fcat-tabname   = 'J_GS_OUTTAB'.
  w_fcat-seltext_l = 'DEBIT'.
  APPEND w_fcat TO i_fcat.
  CLEAR w_fcat.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program     = sy-repid
      i_callback_top_of_page = 'TOP_OF_PAGE'
      i_grid_title           = 'Posted Documents'
      it_fieldcat            = i_fcat
      i_screen_start_column  = 5
      i_screen_start_line    = 20
      i_screen_end_column    = 45
      i_screen_end_line      = 55
    TABLES
      t_outtab               = j_gs_outtab.

ENDFORM.

*---------------------------------------------------------------------*
*&      Form  USER_COMMAND
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_E_UCOMM  text
*----------------------------------------------------------------------*

FORM user_command  USING    p_e_ucomm.
  CASE p_e_ucomm.
    WHEN 'SLCT'.
      LOOP AT i_gs_outtab INTO w_gs_outtab.
        w_gs_outtab-checkbox = 'X'.
        MODIFY i_gs_outtab FROM w_gs_outtab.
        CLEAR w_gs_outtab.
      ENDLOOP.

      grid1->refresh_table_display(
****       EXPORTING
****         is_stable      = is_stable
****         i_soft_refresh = i_soft_refresh
****       EXCEPTIONS
****         finished       = 1
             ).
      IF sy-subrc <> 0.
*      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                 WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

    WHEN 'DLCT'.
      LOOP AT i_gs_outtab INTO w_gs_outtab.
        w_gs_outtab-checkbox = ''.
        MODIFY i_gs_outtab FROM w_gs_outtab.
        CLEAR w_gs_outtab.
      ENDLOOP.

      grid1->refresh_table_display(
*       EXPORTING
*         is_stable      = is_stable
*         i_soft_refresh = i_soft_refresh
*       EXCEPTIONS
*         finished       = 1
             ).
      IF sy-subrc <> 0.
*      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                 WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
*	WHEN OTHERS.
  ENDCASE.
ENDFORM.                    " USER_COMMAND
*------------------------------------------------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Report ZUS_PO_SO_RATE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zus_po_so_rate.


TABLES: vapma.


TYPES:BEGIN OF ty_vapma,
        matnr TYPE vapma-matnr,
        vkorg TYPE vapma-vkorg,
        vtweg TYPE vapma-vtweg,
        kunnr TYPE vapma-kunnr,
        bstnk TYPE ekpo-ebeln,
        vbeln TYPE vapma-vbeln,
        posnr TYPE vapma-posnr,
        werks TYPE vapma-werks,
      END OF ty_vapma,

      BEGIN OF ty_vbap,
        vbeln  TYPE vbap-vbeln,
        posnr  TYPE vbap-posnr,
        matnr  TYPE vbap-matnr,
        netpr  TYPE vbap-netpr,
        posex  TYPE vbap-posex,
        abgru  TYPE vbap-abgru,
        kwmeng TYPE vbap-kwmeng,
      END OF ty_vbap,

      BEGIN OF ty_ekpo,
        ebeln TYPE ekpo-ebeln,
        ebelp TYPE ekpo-ebelp,
        loekz TYPE ekpo-loekz,
        matnr TYPE ekpo-matnr,
        bukrs TYPE ekpo-bukrs,
        werks TYPE ekpo-werks,
        netpr TYPE ekpo-netpr,
        menge TYPE ekpo-menge,
        inco1 TYPE ekpo-inco1,
        inco2 TYPE ekpo-inco2,
      END OF ty_ekpo,

      BEGIN OF ty_ekko,
        ebeln TYPE ekko-ebeln,
        bedat TYPE ekko-bedat,
        inco1 TYPE ekko-inco1,
        inco2 TYPE ekko-inco2,
        knumv type ekko-knumv,
      END OF ty_ekko,


      BEGIN OF ty_vbkd,
        vbeln TYPE vbkd-vbeln,
        posnr TYPE vbkd-posnr,
        inco1 TYPE vbkd-inco1,
        inco2 TYPE vbkd-inco2,
      END OF ty_vbkd,

      begin of ty_konv,
       KNUMV type PRCD_ELEMENTS-knumv,
       KPOSN type PRCD_ELEMENTS-kposn,
       STUNR type PRCD_ELEMENTS-stunr,
       ZAEHK type PRCD_ELEMENTS-zaehk,
       kbetr type PRCD_ELEMENTS-kbetr,
       kschl type PRCD_ELEMENTS-kschl,
      end of ty_konv,


      BEGIN OF ty_final,
        so_matnr     TYPE vapma-matnr,
        po_matnr     TYPE vapma-matnr,
        kunnr        TYPE vapma-kunnr,
        vbeln        TYPE vapma-vbeln,
        posnr        TYPE vapma-posnr,
        werks        TYPE vapma-werks,
        ebeln        TYPE ekpo-ebeln,
        ebelp        TYPE ekpo-ebelp,
        so_rate      TYPE ekpo-netpr,
        po_rate      TYPE ekpo-netpr,
        diff         TYPE ekpo-netpr,
        po_res       TYPE char15,
        abgru        TYPE vbap-abgru,
        so_res       TYPE char50,
        po_qty       TYPE ekpo-menge,
        so_qty       TYPE ekpo-menge,
        bedat        TYPE ekko-bedat,
        kdgrp        TYPE vbkd-kdgrp,
        text         TYPE char255,
        wrkst        TYPE mara-wrkst,
        po_inco1     TYPE ekpo-inco1,
        po_inco2     TYPE ekpo-inco2,
        so_inco1     TYPE vbkd-inco1,
        so_inco2     TYPE vbkd-inco2,
        cust_details TYPE char300,
        ctbg_details TYPE char300,
        kbetr        type prcd_elements-kbetr,

      END OF ty_final,

      BEGIN OF ty_down,
        ebeln        TYPE char20,
        ebelp        TYPE char10,
        po_matnr     TYPE char20,
        vbeln        TYPE char20,
        posnr        TYPE char10,
        so_matnr     TYPE char20,
        po_rate      TYPE char250,
        so_rate      TYPE char250,
        diff         TYPE char15,
        ref          TYPE char15,
        po_res       TYPE char15,
        abgru        TYPE vbap-abgru,
        so_res       TYPE char50,
        po_qty       TYPE char15,
        so_qty       TYPE char15,
        bedat        TYPE char15,
        kdgrp        TYPE vbkd-kdgrp,
        text         TYPE char255,
        wrkst        TYPE mara-wrkst,
        po_inco1     TYPE ekpo-inco1,
        po_inco2     TYPE ekpo-inco2,
        so_inco1     TYPE vbkd-inco1,
        so_inco2     TYPE vbkd-inco2,
        cust_details TYPE char300,
        ref_time     TYPE char15,                 "added by pankaj 28.12.2021

        kbetr        type char30,
        ctbg_details TYPE char300,
      END OF ty_down.

DATA : it_vapma TYPE TABLE OF ty_vapma,
       wa_vapma TYPE          ty_vapma,

       it_vbap  TYPE TABLE OF ty_vbap,
       wa_vbap  TYPE          ty_vbap,

       it_ekpo  TYPE TABLE OF ty_ekpo,
       wa_ekpo  TYPE          ty_ekpo,

       it_ekko  TYPE TABLE OF ty_ekko,
       wa_ekko  TYPE          ty_ekko,

       it_vbkd  TYPE TABLE OF ty_vbkd,
       wa_vbkd  TYPE          ty_vbkd,

       it_konv  TYPE TABLE OF ty_konv,
       wa_konv  TYPE          ty_konv,

       it_final TYPE TABLE OF ty_final,
       wa_final TYPE          ty_final,

       it_down  TYPE TABLE OF ty_down,
       wa_down  TYPE          ty_down.

DATA: it_fcat   TYPE slis_t_fieldcat_alv,
      wa_fcat   LIKE LINE OF it_fcat,
      gt_layout TYPE slis_layout_alv,
      gt_event  TYPE slis_t_event        WITH HEADER LINE.


DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt TYPE tline,
      ls_mattxt TYPE tline.

DATA : lv_text TYPE string.
*DATA : lv_ctbg_details(50000)." TYPE string.

SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: so FOR vapma-vbeln.
SELECTION-SCREEN:END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT '/Delval/USA'."USA'."USA'."USA'."usa'.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN :BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
SELECTION-SCREEN  COMMENT /1(60) TEXT-004.
SELECTION-SCREEN COMMENT /1(70) TEXT-005.
SELECTION-SCREEN: END OF BLOCK b3.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM sort_data.
  PERFORM get_fcat.
*  PERFORM f_layout.
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
  SELECT matnr
         vkorg
         vtweg
         kunnr
         bstnk
         vbeln
         posnr
         werks FROM vapma INTO TABLE it_vapma
         WHERE vbeln IN so
           AND kunnr = '0000300000'.

  IF it_vapma IS NOT INITIAL.
    SELECT vbeln
           posnr
           matnr
           netpr
           posex
           abgru
           kwmeng FROM vbap INTO TABLE it_vbap
           FOR ALL ENTRIES IN it_vapma
           WHERE vbeln = it_vapma-vbeln
            AND  posnr = it_vapma-posnr.


    SELECT vbeln
           posnr
           inco1
           inco2 FROM vbkd INTO TABLE it_vbkd
           FOR ALL ENTRIES IN it_vapma
           WHERE vbeln = it_vapma-vbeln
            AND  posnr = it_vapma-posnr.


    SELECT ebeln
           ebelp
           loekz
           matnr
           bukrs
           werks
           netpr
           menge
           inco1
           inco2 FROM ekpo INTO TABLE it_ekpo
           FOR ALL ENTRIES IN it_vapma
           WHERE ebeln = it_vapma-bstnk.
*           AND ebelp = it_vapma-posnr.

  ENDIF.


  IF it_ekpo IS NOT INITIAL.
    SELECT ebeln
           bedat
           inco1
           inco2
           knumv FROM ekko INTO TABLE it_ekko
           FOR ALL ENTRIES IN it_ekpo
           WHERE ebeln = it_ekpo-ebeln.


  ENDIF.
  IF it_ekko IS NOT INITIAL.
  select KNUMV
         KPOSN
         STUNR
         ZAEHK
         kbetr
         kschl
         from prcd_elements
         into table it_konv
         for all entries in it_ekko
         where knumv = it_ekko-knumv
         and stunr = '1'.




  endif.
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
  LOOP AT it_vapma INTO wa_vapma.
    wa_final-vbeln = wa_vapma-vbeln.
    wa_final-posnr = wa_vapma-posnr.

    READ TABLE it_vbap INTO wa_vbap WITH KEY vbeln = wa_final-vbeln posnr = wa_final-posnr.
    IF sy-subrc = 0.
      wa_final-so_rate = wa_vbap-netpr.
      wa_final-so_matnr = wa_vbap-matnr.
      wa_final-abgru   = wa_vbap-abgru.
      wa_final-so_qty   = wa_vbap-kwmeng.
    ENDIF.

    READ TABLE it_vbkd INTO wa_vbkd WITH KEY vbeln = wa_final-vbeln
                                             posnr = wa_final-posnr.
    IF sy-subrc = 0.
      wa_final-so_inco1   = wa_vbkd-inco1.
      wa_final-so_inco2   = wa_vbkd-inco2.
    ENDIF.

    IF wa_final-so_inco1 IS INITIAL .
      SELECT SINGLE inco1 inco2 INTO ( wa_final-so_inco1 , wa_final-so_inco2 ) FROM vbkd WHERE vbeln = wa_final-vbeln.
    ENDIF.

    SELECT SINGLE wrkst INTO wa_final-wrkst FROM mara WHERE matnr = wa_final-so_matnr.
    SELECT SINGLE bezei INTO wa_final-so_res FROM tvagt WHERE abgru = wa_final-abgru AND spras = 'EN'.

    READ TABLE it_ekpo INTO wa_ekpo WITH KEY ebeln = wa_vapma-bstnk ebelp = wa_vbap-posex.
    IF sy-subrc = 0.
      wa_final-ebeln = wa_ekpo-ebeln.
      wa_final-ebelp = wa_ekpo-ebelp.
      wa_final-po_rate = wa_ekpo-netpr.
      wa_final-po_matnr = wa_ekpo-matnr.
      wa_final-po_qty = wa_ekpo-menge.

      IF wa_ekpo-loekz = 'L'.
        wa_final-po_res = 'YES'.
      ELSE.
        wa_final-po_res = 'NO'.
      ENDIF.
    ENDIF.

    CLEAR: lv_lines,wa_lines,lv_name.
    REFRESH lv_lines.
*      lv_name = wa_final-ebeln.
    CONCATENATE wa_final-ebeln wa_final-ebelp INTO lv_name.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        client                  = sy-mandt
        id                      = 'F09'
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
          CONCATENATE wa_final-text wa_lines-tdline INTO wa_final-text SEPARATED BY space.
        ENDIF.
      ENDLOOP.

    ENDIF.

    READ TABLE it_ekko INTO wa_ekko WITH KEY ebeln = wa_final-ebeln .
    IF sy-subrc = 0.
      wa_final-bedat = wa_ekko-bedat.
      wa_final-po_inco1 = wa_ekko-inco1.
      wa_final-po_inco2 = wa_ekko-inco2.


    ENDIF.


    read table it_konv into wa_konv with key knumv = wa_ekko-knumv kposn = wa_final-ebelp.     "kposn = wa_final-posnr..
    IF sy-subrc = 0.
    wa_final-kbetr = wa_konv-kbetr.
    endif.

***********Avinash Bhagat
    CLEAR: lv_lines,wa_lines,lv_name.
    REFRESH lv_lines.
    lv_name = wa_final-ebeln.
*      CONCATENATE wa_final-ebeln wa_final-ebelp INTO lv_name.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        client                  = sy-mandt
        id                      = 'F22'
        language                = sy-langu
        name                    = lv_name
        object                  = 'EKKO'
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
          CONCATENATE wa_final-cust_details wa_lines-tdline INTO wa_final-cust_details SEPARATED BY space.
        ENDIF.
      ENDLOOP.

    ENDIF.

  REPLACE ALL OCCURRENCES OF '<(>' IN wa_final-cust_details WITH SPACE.
  REPLACE ALL OCCURRENCES OF '<)>' IN wa_final-cust_details WITH SPACE.

***********END AVINASH

*    SELECT SINGLE BEDAT INTO WA_FINAL-BEDAT FROM EKKO WHERE EBELN = WA_FINAL-EBELN.
    SELECT SINGLE kdgrp INTO wa_final-kdgrp FROM vbkd WHERE vbeln = wa_final-vbeln AND posnr = ' '.
    wa_final-diff = wa_final-so_rate - wa_final-po_rate.
*    WA_FINAL-QTY_DIFF = WA_FINAL-PO_QTY - WA_FINAL-SO_QTY.

*---------------------------------------------------------------------------------------------*"Added By PB 05.03.2022

    CLEAR: lv_lines,wa_lines,lv_name.
    REFRESH lv_lines.

    CONCATENATE wa_final-ebeln wa_final-ebelp INTO lv_text.
    lv_name = lv_text.

    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        client                  = sy-mandt
        id                      = 'F08'
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
* Implement suitable error handling here
    ENDIF.

    IF NOT lv_lines IS INITIAL.
      LOOP AT lv_lines INTO wa_lines.
        IF NOT wa_lines-tdline IS INITIAL.
          CONCATENATE wa_final-ctbg_details wa_lines-tdline INTO wa_final-ctbg_details SEPARATED BY space.
        ENDIF.
      ENDLOOP.
    ENDIF.
*---------------------------------------------------------------------------------------------*"Added By PB 05.03.2022

    APPEND wa_final TO it_final.
    CLEAR wa_final.
  ENDLOOP.

  SORT it_final BY vbeln posnr.
  DELETE it_final WHERE ebeln = ' '.
  IF p_down = 'X'.
    LOOP AT it_final INTO wa_final.

      wa_down-ebeln       = wa_final-ebeln     .
      wa_down-ebelp       = wa_final-ebelp     .
      wa_down-po_matnr    = wa_final-po_matnr  .
      wa_down-vbeln       = wa_final-vbeln     .
      wa_down-posnr       = wa_final-posnr     .
      wa_down-so_matnr    = wa_final-so_matnr  .
      wa_down-po_rate     = wa_final-po_rate   .
      wa_down-so_rate     = wa_final-so_rate   .
      wa_down-diff        = wa_final-diff      .
      wa_down-abgru        = wa_final-abgru      .
      wa_down-so_res        = wa_final-so_res      .
      wa_down-po_res        = wa_final-po_res      .
      wa_down-so_qty        = wa_final-so_qty      .
      wa_down-po_qty        = wa_final-po_qty      .
      wa_down-kdgrp         = wa_final-kdgrp.
      wa_down-text          = wa_final-text .
      wa_down-cust_details  = wa_final-cust_details .
      wa_down-wrkst         = wa_final-wrkst.
      wa_down-so_inco1      = wa_final-so_inco1.
      wa_down-so_inco2      = wa_final-so_inco2.

      wa_down-po_inco1      = wa_final-po_inco1.
      wa_down-po_inco2      = wa_final-po_inco2.
*      wa_down-ctbg_details  = wa_final-ctbg_details.

      CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
        CHANGING
          value = wa_down-diff.

      CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
        CHANGING
          value = wa_down-po_rate.

      CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
        CHANGING
          value = wa_down-so_rate.


      IF wa_final-bedat IS NOT INITIAL.
        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            input  = wa_final-bedat
          IMPORTING
            output = wa_down-bedat.

        CONCATENATE wa_down-bedat+0(2) wa_down-bedat+2(3) wa_down-bedat+5(4)
                        INTO wa_down-bedat SEPARATED BY '-'.
      ENDIF.


      wa_down-ref = sy-datum.
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_down-ref
        IMPORTING
          output = wa_down-ref.

      CONCATENATE wa_down-ref+0(2) wa_down-ref+2(3) wa_down-ref+5(4)
                      INTO wa_down-ref SEPARATED BY '-'.

      "added by pankaj 28.12.2021
      wa_down-ref_time = sy-uzeit.
      CONCATENATE wa_down-ref_time+0(2) ':' wa_down-ref_time+2(2)  INTO wa_down-ref_time.

       wa_down-kbetr = wa_final-kbetr.
      APPEND wa_down TO it_down.
      CLEAR wa_down.
    ENDLOOP.
  ENDIF.

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

  PERFORM fcat USING :  '1'  'EBELN '           'IT_FINAL'  'USA PO No'                       '18' ,
                        '2'  'EBELP '           'IT_FINAL'  'USA PO Item'                     '18' ,
                        '3'  'PO_MATNR'         'IT_FINAL'  'USA PO Code'                     '18' ,
                        '4'  'VBELN'            'IT_FINAL'  'IND So No'                       '18' ,
                        '5'  'POSNR'            'IT_FINAL'  'IND SO Item'                     '18' ,
                        '6'  'SO_MATNR'         'IT_FINAL'  'IND SO Code'                     '18' ,
                        '7'  'PO_RATE'          'IT_FINAL'  'PO Unit Price After Discount'    '30' ,
                        '8'  'SO_RATE'          'IT_FINAL'  'IND SO Rate'                     '18' ,
                        '9'  'DIFF'            'IT_FINAL'  'Difference'                      '18' ,
                        '10'  'PO_RES'          'IT_FINAL'  'PO Del.Ind.'                     '18' ,
                        '11'  'ABGRU'           'IT_FINAL'  'SO Del.Ind.'                     '18' ,
                        '12'  'SO_RES'          'IT_FINAL'  'Reason For Rejection'            '18' ,
                        '13'  'PO_QTY'          'IT_FINAL'  'PO Quantity'                     '18' ,
                        '14'  'SO_QTY'          'IT_FINAL'  'SO Quantity'                     '18' ,
                        '15'  'BEDAT'           'IT_FINAL'  'PO Date'                         '18' ,
                        '16'  'KDGRP'           'IT_FINAL'  'Customer Group'                  '18' ,
                        '17'  'TEXT'            'IT_FINAL'  'USA Part NO-ON CTBG'             '18' ,
                        '18'  'WRKST'           'IT_FINAL'  'USA Part NO-India SO'            '18' ,
                        '19'  'PO_INCO1'        'IT_FINAL'  'Po Incoterms'                    '18' ,
                        '20'  'PO_INCO2'        'IT_FINAL'  'Po Inco Desc.'                   '18' ,
                        '21'  'SO_INCO1'        'IT_FINAL'  'So Incoterms'                    '18' ,
                        '22'  'SO_INCO2'        'IT_FINAL'  'So Inco Desc.'                   '18' ,
                        '23'  'CUST_DETAILS'    'IT_FINAL'  'Customer Details'                '18' ,
                        '24'   'KBETR'           'IT_FINAL'  'PO Unit Price Before Discount'   '30' .
*                        '24'  'CTBG_DETAILS'    'IT_FINAL'  'USA CTBG Details'            '50' .

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0377   text
*      -->P_0378   text
*      -->P_0379   text
*      -->P_0380   text
*      -->P_0381   text
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
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER = ' '
*     I_BUFFER_ACTIVE    = ' '
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND = 'USER_CMD'
*     i_callback_top_of_page = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
*     is_layout          = gt_layout
      it_fieldcat        = it_fcat
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            = t_sort[]
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
      i_save             = 'X'
*     IS_VARIANT         =
*it_events               = gt_event[]
*     IT_EVENT_EXIT      =
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     I_SCREEN_START_COLUMN  = 0
*     I_SCREEN_START_LINE    = 0
*     I_SCREEN_END_COLUMN    = 0
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
*     ES_EXIT_CAUSED_BY_USER =
    TABLES
      t_outtab           = it_final
*   EXCEPTIONS
*     PROGRAM_ERROR      = 1
*     OTHERS             = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  IF p_down = 'X'.
    PERFORM download.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DOWNLOAD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM download .
  TYPE-POOLS truxs.
  DATA: it_csv TYPE truxs_t_text_data,
        wa_csv TYPE LINE OF truxs_t_text_data,
        hd_csv TYPE LINE OF truxs_t_text_data.

*  DATA: lv_folder(150).
  DATA: lv_file(30).
  DATA: lv_fullfile TYPE string,
        lv_dat(10),
        lv_tim(4).
  DATA: lv_msg(80).

  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = it_down
    CHANGING
      i_tab_converted_data = it_csv
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  PERFORM cvs_header USING hd_csv.

*  lv_folder = 'D:\usr\sap\DEV\D00\work'.


  lv_file = 'ZPO_VERIFY.TXT'.


  CONCATENATE p_folder '/' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'ZPO_VERIFY REPORT started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_732 TYPE string.
DATA lv_crlf_732 TYPE string.
lv_crlf_732 = cl_abap_char_utilities=>cr_lf.
lv_string_732 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_732 lv_crlf_732 wa_csv INTO lv_string_732.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_396 TO lv_fullfile.
*TRANSFER lv_string_1953 TO lv_fullfile.
TRANSFER lv_string_732 TO lv_fullfile.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.

  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = it_down
    CHANGING
      i_tab_converted_data = it_csv
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  PERFORM cvs_header USING hd_csv.

*  lv_folder = 'D:\usr\sap\DEV\D00\work'.


  lv_file = 'ZPO_VERIFY.TXT'.


  CONCATENATE p_folder '/' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZPO_VERIFY REPORT started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_769 TYPE string.
DATA lv_crlf_769 TYPE string.
lv_crlf_769 = cl_abap_char_utilities=>cr_lf.
lv_string_769 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_769 lv_crlf_769 wa_csv INTO lv_string_769.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_396 TO lv_fullfile.
*TRANSFER lv_string_1953 TO lv_fullfile.
TRANSFER lv_string_769 TO lv_fullfile.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CVS_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_HD_CSV  text
*----------------------------------------------------------------------*
FORM cvs_header  USING    pd_csv.
  DATA: l_field_seperator.
  l_field_seperator = cl_abap_char_utilities=>horizontal_tab.

  CONCATENATE 'USA PO No'
              'USA PO Item'
              'USA PO Code'
              'IND So No'
              'IND SO Item'
              'IND SO Code'
              'PO Unit Price After Discount'
              'IND SO Rate'
              'Difference'
              'Refresh On'
              'PO Del.Ind.'
              'SO Del.Ind.'
              'Reason For Rejection'
              'PO Quantity'
              'SO Quantity'
              'PO Date'
              'Customer Group'
              'USA Part NO-ON CTBG'
              'USA Part NO-India SO'
              'Po Incoterms'
              'Po Inco Desc.'
              'So Incoterms'
              'So Inco Desc.'
              'Customer Details'
              'Ref Time'
*              'USA CTBG Details'
               'PO Unit Price Before Discount'
               INTO pd_csv
              SEPARATED BY l_field_seperator.
ENDFORM.

*&---------------------------------------------------------------------*
*& REPORT ZMB51_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zus_mb51_report.

TABLES: mseg.

TYPE-POOLS: slis.

TYPES: BEGIN OF ty_mseg,                  " STRUCTURE
         matnr      TYPE mseg-matnr,
         budat_mkpf TYPE mseg-budat_mkpf,
         mblnr      TYPE mseg-mblnr,
         zeile      TYPE mseg-zeile,
         bwart      TYPE mseg-bwart,
         menge      TYPE mseg-menge,
         dmbtr      TYPE mseg-dmbtr,
         lgort      TYPE mseg-lgort,
         kdauf      TYPE mseg-kdauf,
         kdpos      TYPE mseg-kdpos,
         aufnr      TYPE mseg-aufnr,
         meins      TYPE mseg-meins,
         werks      TYPE mseg-werks,
         shkzg      TYPE mseg-shkzg,
         usnam_mkpf TYPE mseg-usnam_mkpf,
         "fields added by shreya -start 06-10-2021-start
         erfmg      TYPE mseg-erfmg,
         erfme      TYPE mseg-erfme,
         kunnr      TYPE mseg-kunnr,
         lifnr      TYPE mseg-lifnr,
         ebeln      TYPE mseg-ebeln,
         ebelp      TYPE mseg-ebelp,
         grund      TYPE mseg-grund,
         kzbew      TYPE mseg-kzbew,
         vgart_mkpf TYPE mseg-vgart_mkpf,
         anln1      TYPE mseg-anln1,
         sobkz      TYPE mseg-sobkz,
         "fields added by shreya-end 06-10-2021-end
         chARG     TYPE MSEG-CHARG,
       END OF ty_mseg,

       BEGIN OF ty_mara,
         matnr   TYPE mara-matnr,
         zseries TYPE mara-zseries,
         zsize   TYPE mara-zsize,
         brand   TYPE mara-brand,
         moc     TYPE mara-moc,
         type    TYPE mara-type,
         wrkst  type mara-wrkst,
       END OF ty_mara,
* structure created by shreya 06-10-2021
       BEGIN OF ty_mkpf,
        mblnr type mkpf-mblnr,
        bldat type mkpf-bldat,
        cpudt type mkpf-cpudt,
        cputm type mkpf-cputm,
        xblnr type mkpf-xblnr,
        bktxt type mkpf-bktxt,
        VGARt type mkpf-VGARt,
       end of ty_mkpf,
       BEGIN OF ty_makt,
         matnr type makt-matnr,
         maktx type makt-maktx,
       END OF ty_makt,

       BEGIN OF ty_final,
         matnr      TYPE mseg-matnr,
         budat_mkpf TYPE mseg-budat_mkpf,
         mblnr      TYPE mseg-mblnr,
         zeile      TYPE mseg-zeile,
         bwart      TYPE mseg-bwart,
         menge      TYPE mseg-menge,
         dmbtr      TYPE mseg-dmbtr,
         lgort      TYPE mseg-lgort,
         kdauf      TYPE mseg-kdauf,
         kdpos      TYPE mseg-kdpos,
         aufnr      TYPE mseg-aufnr,
         meins      TYPE mseg-meins,
         werks      TYPE mseg-werks,
         shkzg      TYPE mseg-shkzg,
         btext      TYPE t156t-btext,
         usnam_mkpf TYPE mseg-usnam_mkpf,
         "matnr      TYPE mara-matnr.
         zseries    TYPE mara-zseries,
         zsize      TYPE mara-zsize,
         brand      TYPE mara-brand,
         moc        TYPE mara-moc,
         type       TYPE mara-type,
         erfmg      TYPE mseg-erfmg,
         erfme      TYPE mseg-erfme,
         kunnr      TYPE mseg-kunnr,
         lifnr      TYPE mseg-lifnr,
         ebeln      TYPE mseg-ebeln,
         ebelp      TYPE mseg-ebelp,
         grund      TYPE mseg-grund,
         kzbew      TYPE mseg-kzbew,
         vgart_mkpf TYPE mseg-vgart_mkpf,
         anln1      TYPE mseg-anln1,
         sobkz      TYPE mseg-sobkz,
         bldat      TYPE mkpf-bldat,
         "mblnr      type mkpf-mblnr,
         "bldat      type mkpf-bldat,
         cpudt      type mkpf-cpudt,
         cputm      type mkpf-cputm,
         xblnr      type mkpf-xblnr,
         bktxt      type mkpf-bktxt,
         maktx      type makt-maktx,
         wrkst      type mara-wrkst,
         chARG     TYPE MSEG-CHARG,
         VGARt type mkpf-VGARt,
       END OF ty_final.

TYPES: BEGIN OF ty_down,                    " STRUCTURE TO DOWNLOAD DATA
*         matnr      TYPE char18,                       "MSEG-MATNR,
         matnr      TYPE char40,                       "MSEG-MATNR,
         budat_mkpf TYPE char15,                       "MSEG-BUDAT_MKPF,
         mblnr      TYPE char10,                       "MSEG-MBLNR,
         zeile      TYPE char4,                        "MSEG-ZEILE,
         bwart      TYPE char3,                        "MSEG-BWART,
         btext      TYPE char20,
         menge      TYPE char15,                       "MSEG-MENGE,
         dmbtr      TYPE char15,                       "MSEG-DMBTR,
         lgort      TYPE char4,                        "MSEG-LGORT,
         kdauf      TYPE char10,                       "MSEG-KDAUF,
         kdpos      TYPE char10,                       "MSEG-KDPOS,
         aufnr      TYPE char15,                       "MSEG-AUFNR,
         meins      TYPE char3,                        "MSEG-MEINS,
         werks      TYPE char4,                        "MSEG-WERKS,
         shkzg      TYPE char1,                        "MSEG-SHKZG,
*         ref        TYPE char15,
*         btext      TYPE char20,
         usnam_mkpf TYPE mseg-usnam_mkpf,
         zseries    TYPE mara-zseries,
         zsize      TYPE mara-zsize,
         brand      TYPE mara-brand,
         moc        TYPE mara-moc,
         type       TYPE mara-type,
         maktx      type CHAR40,
         erfmg      TYPE CHAR15,
         erfme      TYPE CHAR3,
         kunnr      TYPE char10,
         lifnr      TYPE char10,
         ebeln      TYPE CHAR15,
         ebelp      TYPE char5,
         grund      TYPE char4,
         kzbew      TYPE char1,
         vgart_mkpf TYPE char2,
         anln1      TYPE char12,
         sobkz      TYPE char1,
         bldat      TYPE char15,
         cpudt      type char15,
         cputm      type  mkpf-cputm,
         xblnr      type chAR16,
         bktxt      type char25,
         wrkst      type char50,
        chARG     TYPE MSEG-CHARG,
         ref        TYPE char15,
         ref_time TYPE char15,
         "VGARt type mkpf-VGARt,
       END OF ty_down.

DATA : it_mseg TYPE TABLE OF ty_mseg,
       wa_mseg TYPE          ty_mseg.

DATA : lt_mara TYPE TABLE OF ty_mara,
       ls_mara TYPE          ty_mara.

DATA : it_makt TYPE TABLE OF ty_makt,    " added by shreya 06-10-2021
       ls_makt TYPE          ty_makt.

DATA : it_final TYPE TABLE OF ty_final,    " INTERNAL TABLE FOR FINAL STRUCTURE
       wa_final TYPE          ty_final.    " WORK AREA FOR FINAL STRUCTURE

DATA : it_down TYPE TABLE OF ty_down,    " INTERNAL TABLE FOR DOWN STRUCTURE
       wa_down TYPE          ty_down.    " WORK AREA FOR DOWN STRUCTURE

DATA : it_mkpf type TABLE OF ty_mkpf,     "add by shreya 06-10-2021
       wa_mkpf type          ty_mkpf.

DATA : it_fcat TYPE slis_t_fieldcat_alv,   " INTERNAL TABLE FOR FIELD CATALOG
       wa_fcat LIKE LINE OF it_fcat,       " WORK AREA FOR FIELD CATALOG
       v_pos   TYPE i,                     " TO DEFINE FIELD/COLUMN POSTION IN FIELD CATALOG
       n       TYPE i.                     " TO STORE TOTAL NUMBER OF RECORDS DISPLAYED

************************* MACRO FOR FIELD CATALOG **********************
DEFINE fcat.
  wa_fcat-col_pos = v_pos + 1.
  wa_fcat-fieldname = &1.
  wa_fcat-tabname = 'IT_FINAL'.
  wa_fcat-seltext_m = &2.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.
END-OF-DEFINITION.

SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE TEXT-005 .
SELECT-OPTIONS: s_matnr FOR mseg-matnr,                    " MATERIAL NUMBER
                s_budat FOR mseg-budat_mkpf,               " POSTING DATE IN THE DOCUMENT
                s_mblnr FOR mseg-mblnr,                    " NUMBER OF MATERIAL DOCUMENT
                s_bwart FOR mseg-bwart,                    " MOVEMENT TYPE
                s_lgort FOR mseg-lgort,                    " STORAGE LOCATION
                s_kdauf FOR mseg-kdauf,                    " SALES ORDER NUMBER
                s_kdpos FOR mseg-kdpos,                    " ITEM NUMBER IN SALES ORDER
                s_aufnr FOR mseg-aufnr,                    " ORDER NUMBER
                s_meins FOR mseg-meins,                    " UNIT OF MEASURE
                s_werks FOR mseg-werks OBLIGATORY DEFAULT 'US01'.     " PLANT
SELECT-OPTIONS : batch for mseg-chARG,
                 vendor for mseg-lifnr,
                 cust for mseg-kunnr,
                 sp_stock for mseg-sobkz.
SELECTION-SCREEN : END OF BLOCK b5.
SELECTION-SCREEN : END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-006 .
SELECT-OPTIONS : s_user for mseg-usnam_mkpf,
                 s_tras for wa_mkpf-VGARt,
                 s_ref for wa_mkpf-xblnr.
SELECTION-SCREEN: END OF BLOCK b4.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT  '/Delval/USA'."USA'."usa'."'/delval/usa'.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN :BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
SELECTION-SCREEN  COMMENT /1(60) TEXT-004.
SELECTION-SCREEN COMMENT /1(70) TEXT-005.
SELECTION-SCREEN: END OF BLOCK b3.
*


START-OF-SELECTION.
  PERFORM get_data.

END-OF-SELECTION.
  PERFORM create_fcat.
  PERFORM display_alvgrid.
*&---------------------------------------------------------------------*
*&      FORM  GET_DATA
*&---------------------------------------------------------------------*
*       TEXT
*----------------------------------------------------------------------*
*  -->  P1        TEXT
*  <--  P2        TEXT
*----------------------------------------------------------------------*
FORM get_data .
  BREAK primus.
  SELECT matnr
         budat_mkpf
         mblnr
         zeile
         bwart
         menge
         dmbtr
         lgort
         kdauf
         kdpos
         aufnr
         meins
         werks
         shkzg
         usnam_mkpf
* start of changes by shreya 06-10-2021
         erfmg
         erfme
         kunnr
         lifnr
         ebeln
         ebelp
         grund
         kzbew
         vgart_mkpf
         anln1
         sobkz
*end of changes by shreya 06-10-2021
        CHARG
    FROM mseg
    INTO CORRESPONDING FIELDS OF TABLE it_mseg
    WHERE matnr      IN s_matnr
    AND   budat_mkpf IN s_budat
    AND   mblnr      IN s_mblnr
    AND   bwart      IN s_bwart
    AND   lgort      IN s_lgort
    AND   kdauf      IN s_kdauf
    AND   kdpos      IN s_kdpos
    AND   aufnr      IN s_aufnr
    AND   meins      IN s_meins
    AND   werks      IN s_werks.
  DELETE it_mseg WHERE werks = 'PL01'.

  IF it_mseg IS NOT INITIAL.
    SELECT matnr
           zseries
           zsize
           brand
           moc
           type
           wrkst
      FROM mara
      INTO TABLE lt_mara
      FOR ALL ENTRIES IN it_mseg
      WHERE matnr = it_mseg-matnr.
  ENDIF.
  IF it_mseg IS NOT INITIAL.
    SELECT mblnr
           bldat
           cpudt
           cputm
           xblnr
           bktxt
          " VGARt
      FROM mkpf
      INTO TABLE it_mkpf
      FOR ALL ENTRIES IN it_mseg

      WHERE mblnr = it_mseg-mblnr
            and budat = it_mseg-budat_mkpf.
  ENDIF.
IF it_mseg IS NOT INITIAL.
    SELECT matnr
           maktx
      FROM makt
      INTO TABLE it_makt
      FOR ALL ENTRIES IN it_mseg
      WHERE matnr = it_mseg-matnr.
  ENDIF.

  LOOP AT it_mseg INTO wa_mseg.                      " TO SHOW NEGATIVE SIGN
    wa_final-matnr      = wa_mseg-matnr     .
    wa_final-budat_mkpf = wa_mseg-budat_mkpf.
    wa_final-mblnr      = wa_mseg-mblnr     .
    wa_final-zeile      = wa_mseg-zeile     .
    wa_final-bwart      = wa_mseg-bwart     .
*  wa_final-MENGE      = wa_mseg-MENGE     .
*  wa_final-DMBTR      = wa_mseg-DMBTR     .
    wa_final-lgort      = wa_mseg-lgort     .
    wa_final-kdauf      = wa_mseg-kdauf     .
    wa_final-kdpos      = wa_mseg-kdpos     .
    wa_final-aufnr      = wa_mseg-aufnr     .
    wa_final-meins      = wa_mseg-meins     .
    wa_final-werks      = wa_mseg-werks     .
    wa_final-shkzg      = wa_mseg-shkzg     .
    wa_final-usnam_mkpf = wa_mseg-usnam_mkpf.
* start of changes by shreya 06-10-2021
    wa_final-erfmg      = wa_mseg-erfmg.
    wa_final-erfme      = wa_mseg-erfme     .
    wa_final-kunnr      = wa_mseg-kunnr      .
    wa_final-lifnr      = wa_mseg-lifnr      .
    wa_final-ebeln      = wa_mseg-ebeln      .
    wa_final-ebelp      = wa_mseg-ebelp      .
    wa_final-grund      = wa_mseg-grund      .
    wa_final-kzbew      = wa_mseg-kzbew      .
    wa_final-vgart_mkpf  = wa_mseg-vgart_mkpf .
    wa_final-anln1      = wa_mseg-anln1   .
    wa_final-sobkz      = wa_mseg-sobkz   .
* end of changes by shreya 06-10-2021
    IF wa_final-shkzg = 'H'.
      wa_final-menge = wa_mseg-menge * -1.
      wa_final-dmbtr = wa_mseg-dmbtr * -1.

*      MODIFY IT_FINAL FROM WA_FINAL TRANSPORTING MENGE DMBTR WHERE MBLNR = WA_FINAL-MBLNR AND ZEILE = WA_FINAL-ZEILE.
    ELSEIF wa_final-shkzg = 'S'.
      wa_final-menge = wa_mseg-menge * 1.
      wa_final-dmbtr = wa_mseg-dmbtr * 1.
*      MODIFY IT_FINAL FROM WA_FINAL TRANSPORTING MENGE DMBTR WHERE MBLNR = WA_FINAL-MBLNR AND ZEILE = WA_FINAL-ZEILE.
    ENDIF.
wa_final-charg = WA_MSEG-CHARG.
    SELECT SINGLE btext INTO wa_final-btext FROM t156t WHERE spras = 'EN' AND bwart = wa_final-bwart.

    READ TABLE lt_mara INTO ls_mara WITH KEY matnr = wa_final-matnr.      "Added BY Snehal Rajale On 29 jan 2021.
    IF sy-subrc = 0.
      wa_final-matnr   = ls_mara-matnr.
      wa_final-zseries = ls_mara-zseries.
      wa_final-zsize   = ls_mara-zsize.
      wa_final-brand   = ls_mara-brand.
      wa_final-moc     = ls_mara-moc.
      wa_final-type    = ls_mara-type.
      wa_final-wrkst   = ls_mara-wrkst.

    ENDIF.
* added code by shreya 06-10-2021 start

    READ TABLE it_mkpf into data(ls_mkpf) with key mblnr = wa_final-mblnr.
    IF sy-subrc = 0.
      wa_final-mblnr = ls_mkpf-mblnr.
      wa_final-bldat = ls_mkpf-bldat.
      wa_final-cpudt = ls_mkpf-cpudt.
      wa_final-cputm = ls_mkpf-cputm.
      wa_final-xblnr = ls_mkpf-xblnr.
      wa_final-bktxt = ls_mkpf-bktxt.
      "wa_final-VGARt = ls_mkpf-VGARt.
    ENDIF.

    READ TABLE it_makt INTO data(ls_makt) with key matnr = wa_final-matnr.
    if sy-subrc = 0.
      wa_final-matnr = ls_makt-matnr.
      wa_final-maktx = ls_makt-maktx.
    endif.
*added code by shreya 06-10-2021 end

    APPEND wa_final TO it_final.
    CLEAR : wa_final,ls_mara.
  ENDLOOP.

  DESCRIBE TABLE it_final LINES n.  " TO FETCH TOTAL NUMBER OF RECORDS

*************************** TO DOWNLOAD DATA ***********************************
  IF p_down = 'X'.
    LOOP AT it_final INTO wa_final.
      wa_down-matnr      = wa_final-matnr.
*    WA_DOWN-BUDAT_MKPF = WA_FINAL-BUDAT_MKPF.
      wa_down-mblnr      = wa_final-mblnr.
      wa_down-zeile      = wa_final-zeile.
      wa_down-bwart      = wa_final-bwart.
      wa_down-lgort      = wa_final-lgort.
      wa_down-kdauf      = wa_final-kdauf.
      wa_down-kdpos      = wa_final-kdpos.
      wa_down-aufnr      = wa_final-aufnr.
      wa_down-meins      = wa_final-meins.
      wa_down-werks      = wa_final-werks.
      wa_down-shkzg      = wa_final-shkzg.
      wa_down-btext      = wa_final-btext.
      wa_down-bktxt      = wa_final-bktxt.
      wa_down-usnam_mkpf = wa_final-usnam_mkpf.
       wa_down-maktx = wa_final-maktx.
      wa_down-zseries =  wa_final-zseries.
      wa_down-zsize   =  wa_final-zsize.
      wa_down-brand   =  wa_final-brand.
      wa_down-moc     =  wa_final-moc.
      wa_down-type    =  wa_final-type .
      wa_down-wrkst    =  wa_final-wrkst .

    wa_down-erfmg      = wa_final-erfmg.
    wa_down-erfme      = wa_final-erfme     .
    wa_down-kunnr      = wa_final-kunnr      .
    wa_down-lifnr      = wa_final-lifnr      .
    wa_down-ebeln      = wa_final-ebeln      .
    wa_down-ebelp      = wa_final-ebelp      .
    wa_down-grund      = wa_final-grund      .
    wa_down-kzbew      = wa_final-kzbew      .
    wa_down-vgart_mkpf  = wa_final-vgart_mkpf .
    wa_down-anln1      = wa_final-anln1   .
    wa_down-sobkz      = wa_final-sobkz   .
    wa_down-cputm      = wa_final-cputm   .
    wa_down-xblnr      = wa_final-xblnr   .

      wa_down-menge      = abs( wa_final-menge ).
      wa_down-dmbtr      = abs( wa_final-dmbtr ).

      IF wa_final-menge < 0 .
        CONDENSE wa_down-menge.
        CONCATENATE '-' wa_down-menge INTO wa_down-menge.
      ENDIF.

      IF wa_final-dmbtr < 0 .
        CONDENSE wa_down-dmbtr.
        CONCATENATE '-' wa_down-dmbtr INTO wa_down-dmbtr.
      ENDIF.


      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = sy-datum
        IMPORTING
          output = wa_down-ref.

      CONCATENATE wa_down-ref+0(2) wa_down-ref+2(3) wa_down-ref+5(4)
                      INTO wa_down-ref SEPARATED BY '-'.

       if wa_final-budat_mkpf is NOT INITIAL.
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_final-budat_mkpf
        IMPORTING
          output = wa_down-budat_mkpf.

      CONCATENATE wa_down-budat_mkpf+0(2) wa_down-budat_mkpf+2(3) wa_down-budat_mkpf+5(4)
                      INTO wa_down-budat_mkpf SEPARATED BY '-'.
       endif.

      if wa_final-bldat is NOT INITIAL.
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_final-bldat
        IMPORTING
          output = wa_down-bldat.

      CONCATENATE wa_down-bldat+0(2) wa_down-bldat+2(3) wa_down-bldat+5(4)
                      INTO wa_down-bldat SEPARATED BY '-'.
      endif.

       if wa_final-cpudt is NOT INITIAL.
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_final-cpudt
        IMPORTING
          output = wa_down-cpudt.

      CONCATENATE wa_down-cpudt+0(2) wa_down-cpudt+2(3) wa_down-cpudt+5(4)
                      INTO wa_down-cpudt SEPARATED BY '-'.
      endif.

      wa_down-charg = WA_FINAL-charg.
     " wa_down-vgart = wa_final-vgart.

        wa_down-ref_time = sy-uzeit.
      CONCATENATE wa_down-ref_time+0(2) ':' wa_down-ref_time+2(2)  INTO wa_down-ref_time.

      APPEND wa_down TO it_down.
      CLEAR wa_down.
    ENDLOOP.
  ENDIF.
********************************************************************************
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CREATE_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM create_fcat .
  v_pos = 0.
  fcat 'MATNR     '     'Material No.'.
  fcat 'BUDAT_MKPF'     'Posting Date'.
  fcat 'MBLNR     '     'Material Document No.'.
  fcat 'ZEILE     '     'Item in Material Document'.
  fcat 'BWART     '     'Movement Type'.
  fcat 'BTEXT     '     'Mov.Type Desc'.
  fcat 'MENGE     '     'Quantity'.
  fcat 'DMBTR     '     'Amount'.
  fcat 'LGORT     '     'Storage Location'.
  fcat 'KDAUF     '     'Sales Order NO'.
  fcat 'KDPOS     '     'Item No'.
  fcat 'AUFNR     '     'Order No'.
  fcat 'MEINS     '     'Unit Of Measure'.
  fcat 'WERKS     '     'Plant'.
  fcat 'SHKZG     '     'Debit/Credit Indicator'.
  fcat 'USNAM_MKPF'     'User'.
  fcat 'ZSERIES   '     'Series'.
  fcat 'ZSIZE     '     'Size'.
  fcat 'BRAND     '     'Brand'.
  fcat 'MOC       '     'MOC'.
  fcat 'TYPE      '     'Type'.
* start changes by shreya 06-10-2021
  fcat 'MAKTX     '     'Material Desc'.
  fcat 'ERFMG     '     'Quantity in UnE'.
  fcat 'ERFME     '     'Unit of Entry'.
  fcat 'KUNNR     '     'Customer'.
  fcat 'LIFNR     '     'Vendor'.
  fcat 'EBELN     '     'Purchase Order'.
  fcat 'EBELP     '     'Purchase Order Line'.
  fcat 'GRUND     '     'Reason For Movement'.
  fcat 'KZBEW     '     'Movement Indicator'.
  fcat 'VGART_MKPF'     'Trans./Event Type'.
  fcat 'ANLN1     '     'Asset'.
  fcat 'SOBKZ     '     'Special Stock'.
  fcat 'BLDAT     '     'Doc Date'.
  fcat 'CPUDT     '     'Entry Date'.
  fcat 'CPUTM     '     'Entry Time'.
  fcat 'XBLNR     '     'Reference'.
  fcat 'BKTXT     '     'Document Header Text'.
  fcat 'WRKST     '     'USA Code'.
* end changes by shreya 06-10-2021
  FCAT 'CHARG'          'Batch'.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_ALVGRID
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_alvgrid .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program     = sy-repid
      i_callback_top_of_page = 'TOP_OF_PAGE'
      it_fieldcat            = it_fcat
      I_SAVE = 'A'
    TABLES
      t_outtab               = it_final.
  .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  IF p_down = 'X'.
    PERFORM download.
  ENDIF.
ENDFORM.

FORM top_of_page .

  DATA :
    it_header TYPE slis_t_listheader,
    wa_header LIKE LINE OF it_header.

  CLEAR it_header.

  wa_header-typ = 'H'.
  wa_header-info = 'MB51 REPORT'.
  APPEND wa_header TO it_header.
  CLEAR wa_header.

  wa_header-typ = 'S'.
  wa_header-key = 'DATE: '.
  CONCATENATE sy-datum+6(2) '.' sy-datum+4(2) '.' sy-datum(4) INTO wa_header-info.
  APPEND wa_header TO it_header.
  CLEAR wa_header.

  wa_header-typ = 'S'.
  wa_header-key = 'Total No Of Records:'.
  wa_header-info = n.
  APPEND wa_header TO it_header.
  CLEAR wa_header.


  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = it_header.

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
  DATA: it_csv TYPE         truxs_t_text_data,
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


  lv_file = 'ZUS_MB51.TXT'.


  CONCATENATE p_folder '/' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUSMB51 REPORT Started On', sy-datum, 'At', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_683 TYPE string.
DATA lv_crlf_683 TYPE string.
lv_crlf_683 = cl_abap_char_utilities=>cr_lf.
lv_string_683 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_683 lv_crlf_683 wa_csv INTO lv_string_683.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_1922 TO lv_fullfile.
*TRANSFER lv_string_396 TO lv_fullfile.
TRANSFER lv_string_683 TO lv_fullfile.
    CONCATENATE 'File' lv_fullfile 'Downloaded' INTO lv_msg SEPARATED BY space.
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
FORM cvs_header  USING    pd_csv.         "p_hd_csv.
  DATA: l_field_seperator.
  l_field_seperator = cl_abap_char_utilities=>horizontal_tab.
*  CONCATENATE 'Material No.'
*              'Posting Date'
*              'Material Document No.'
*              'Item in Material Document'
*              'Movement Type'
*              'Quantity'
*              'Amount'
*              'Storage Location'
*              'Sales Order No'
*              'Item No'
*              'Order No'
*              'Unit Of Measure'
*              'Plant'
*              'Debit/Credit Indicator'
*              'Refreshable Date'
*              'Mov.Type Desc'
*              'User'
*              'Series'
*              'Size'
*              'Brand'
*              'MOC'
*              'Type'
*              'Batch'

  CONCATENATE 'Material No.'
              'Posting Date'
              'Material Document No.'
              'Item in Material Document'
              'Movement Type'
              'Mov.Type Desc'
              'Quantity'
              'Amount'
              'Storage Location'
              'Sales Order NO'
              'Item No'
              'Order No'
              'Unit Of Measure'
              'Plant'
              'Debit/Credit Indicator'
              'User'
              'Series'
              'Size'
              'Brand'
              'MOC'
              'Type'
              'Material Desc'
              'Quantity in UnE'
              'Unit of Entry'
              'Customer'
              'Vendor'
              'Purchase Order'
              'Purchase Order Line'
              'Reason For Movement'
              'Movement Indicator'
              'Trans./Event Type'
              'Asset'
              'Special Stock'
              'Doc Date'
              'Entry Date'
              'Entry Time'
              'Reference'
              'Document Header Text'
              'USA Code'
              'Batch'
              'Refresahble Date'
              'Refreshable Time'
               INTO pd_csv
               SEPARATED BY l_field_seperator.
ENDFORM.

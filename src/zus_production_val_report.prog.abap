*&---------------------------------------------------------------------*
*& Report ZPRODUCTION_VAL_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zus_production_val_report.

TYPE-POOLS:slis,
           ole2.
TABLES :AFPO.

DATA:
  tmp_budat TYPE mseg-budat_mkpf,
  tmp_kdauf TYPE mseg-kdauf,
  tmp_mat   TYPE mseg-matnr,
  tmp_dauat TYPE afpo-dauat,
  tmp_lgort TYPE mseg-lgort.


TYPES:
  BEGIN OF t_mat_doc,
    mblnr      TYPE mseg-mblnr,
    mjahr      TYPE mseg-mjahr,
    zeile      TYPE mseg-zeile,
    bwart      TYPE mseg-bwart,
    matnr      TYPE mseg-matnr,
    werks      TYPE mseg-werks,
    lgort      TYPE mseg-lgort,
    kunnr      TYPE mseg-kunnr,
    kdauf      TYPE mseg-kdauf,
    kdpos      TYPE mseg-kdpos,
    waers      TYPE mseg-waers,
    menge      TYPE mseg-menge,
    aufnr      TYPE mseg-aufnr,
    budat_mkpf TYPE mseg-budat_mkpf,
  END OF t_mat_doc,
  tt_mat_doc TYPE STANDARD TABLE OF t_mat_doc.

TYPES: BEGIN OF ty_mseg,
       mblnr      TYPE mseg-mblnr,
       bwart      TYPE mseg-bwart,
       werks      TYPE mseg-werks,
       smbln      TYPE mseg-smbln,
       END OF ty_mseg.

DATA:it_mseg TYPE TABLE OF ty_mseg,
     wa_mseg TYPE          ty_mseg.




TYPES:
  BEGIN OF t_vbkd,
    vbeln TYPE vbkd-vbeln,
    posnr TYPE vbkd-posnr,
    kursk TYPE vbkd-kursk,
  END OF t_vbkd,
  tt_vbkd TYPE STANDARD TABLE OF t_vbkd.

TYPES:
  BEGIN OF t_coep,
    kokrs  TYPE coep-kokrs,
    belnr  TYPE coep-belnr,
    buzei  TYPE coep-buzei,
    wtgbtr TYPE coep-wtgbtr,
    objnr  TYPE coep-objnr,
    beknz  TYPE coep-beknz,
  END OF t_coep,
  tt_coep TYPE STANDARD TABLE OF t_coep.


TYPES:
  BEGIN OF t_order_item,
    aufnr TYPE afpo-aufnr,
    posnr TYPE afpo-posnr,
    dauat TYPE afpo-dauat,
    psmng TYPE afpo-psmng,
    PWERK TYPE AFPO-PWERK,
    objnr TYPE coep-objnr,
  END OF t_order_item,
  tt_order_item TYPE STANDARD TABLE OF t_order_item.

TYPES:
  BEGIN OF t_order_hdr,
    aufnr TYPE afko-aufnr,
    ftrmi TYPE afko-ftrmi,
  END OF t_order_hdr,
  tt_order_hdr TYPE STANDARD TABLE OF t_order_hdr.

TYPES:
  BEGIN OF t_sales_ord_hdr,
    vbeln TYPE vbak-vbeln,
    audat TYPE vbak-audat,
    auart TYPE vbak-auart,
    vkbur TYPE vbak-vkbur,
    knumv TYPE vbak-knumv,
    kunnr TYPE vbak-kunnr,
    aedat TYPE vbak-aedat,
    waerk TYPE vbak-waerk,
  END OF t_sales_ord_hdr,
  tt_sales_ord_hdr TYPE STANDARD TABLE OF t_sales_ord_hdr.

TYPES:
  BEGIN OF t_sales_ord_item,
    vbeln   TYPE vbap-vbeln,
    posnr   TYPE vbap-posnr,
    matnr   TYPE vbap-matnr,
    kdmat   TYPE vbap-kdmat,
    kwmeng  TYPE vbap-kwmeng,
    deldate TYPE vbap-deldate,
    kzwi1   TYPE vbap-kzwi1,
  END OF t_sales_ord_item,
  tt_sales_ord_item TYPE STANDARD TABLE OF t_sales_ord_item.

TYPES:
  BEGIN OF t_mat_mast,
    matnr   TYPE mara-matnr,
    zseries TYPE mara-zseries,
    zsize   TYPE mara-zsize,
    brand   TYPE mara-brand,
    moc     TYPE mara-moc,
    type    TYPE mara-type,
    wrkst   TYPE mara-wrkst,
  END OF t_mat_mast,
  tt_mat_mast TYPE STANDARD TABLE OF t_mat_mast.

TYPES:
  BEGIN OF t_mat_desc,
    matnr TYPE makt-matnr,
    maktx TYPE makt-maktx,
  END OF t_mat_desc,
  tt_mat_desc TYPE STANDARD TABLE OF t_mat_desc.

TYPES:
  BEGIN OF t_vbep,
    vbeln TYPE vbep-vbeln,
    posnr TYPE vbep-posnr,
    edatu TYPE vbep-edatu,
  END OF t_vbep,
  tt_vbep TYPE STANDARD TABLE OF t_vbep.

TYPES:
  BEGIN OF t_cust_info,
    kunnr TYPE kna1-kunnr,
    name1 TYPE kna1-name1,
    stcd3 TYPE kna1-stcd3,
  END OF t_cust_info,
  tt_cust_info TYPE STANDARD TABLE OF t_cust_info.

TYPES:
  BEGIN OF t_marc,
    matnr TYPE marc-matnr,
    werks TYPE marc-werks,
    dispo TYPE marc-dispo,
  END OF t_marc,
  tt_marc TYPE STANDARD TABLE OF t_marc.

TYPES:
  BEGIN OF t_mbew,
    matnr TYPE mbew-matnr,
    bwkey TYPE mbew-bwkey,
    stprs TYPE mbew-stprs,
    verpr  TYPE mbew-verpr,

  END OF t_mbew,
  tt_mbew TYPE STANDARD TABLE OF t_mbew.

TYPES:
  BEGIN OF t_qamb,
    prueflos TYPE qamb-prueflos,
    typ      TYPE qamb-typ,
    mblnr    TYPE qamb-mblnr,
    mjahr    TYPE qamb-mjahr,
    zeile    TYPE qamb-zeile,
  END OF t_qamb,
  tt_qamb TYPE STANDARD TABLE OF t_qamb.

TYPES:
  BEGIN OF t_qals,
    prueflos TYPE qals-prueflos,
    aufnr    TYPE qals-aufnr,
    mjahr    TYPE qals-mjahr,
    mblnr    TYPE qals-mblnr,
  END OF t_qals,
  tt_qals TYPE STANDARD TABLE OF t_qals.

**TYPES:
**  BEGIN OF t_t005u,
**    land1 TYPE t005u-land1,
**    bland TYPE t005u-bland,
**    bezei TYPE t005u-bezei,
**  END OF t_t005u.

TYPES:
  BEGIN OF t_final,
    dispo     TYPE marc-dispo,
    brand     TYPE mara-brand,
    matnr     TYPE mseg-matnr,
    maktx     TYPE vbrp-arktx,
    long_txt  TYPE char250,
    dauat     TYPE afpo-dauat,
    aufnr     TYPE mseg-aufnr,
    menge     TYPE mseg-menge,
    budat_con TYPE mseg-budat_mkpf,
    budat_in  TYPE mseg-budat_mkpf,
    prd_amt   TYPE vbap-netwr,
    stprs     TYPE mbew-stprs,
    zseries   TYPE mara-zseries,
    zsize     TYPE mara-zsize,
    moc       TYPE mara-moc,
    type      TYPE mara-type,
    lgort     TYPE mseg-lgort,
    ftrmi     TYPE afko-ftrmi,
    curr_date TYPE sy-datum,
    price     TYPE vbap-netwr,
    wrkst     TYPE mara-wrkst,
    werks     TYPE mseg-werks,
    CSONO     TYPE char40,
*    kdauf     TYPE mseg-kdauf,
*    kdpos     TYPE mseg-kdpos,
*    vkbur     TYPE vbak-vkbur,
*    name1     TYPE kna1-name1,
*    edatu     TYPE char10, "vbep-edatu,
*    kwmeng    TYPE vbap-kwmeng,
*    deldate   TYPE char10, "vbap-deldate,
*    kdmat     TYPE vbap-kdmat,
*    netpr     TYPE vbap-netpr,
*    aedat     TYPE char10, "vbak-aedat,
*    waerk     TYPE vbak-waerk,
*    kursk     TYPE vbkd-kursk,
*    s_val     TYPE konv-kwert,
*    s_val_lc  TYPE konv-kwert,
*    auart     TYPE vbak-auart,
*    so_curr   TYPE vbkd-kursk,
*    werks     TYPE mseg-werks,
*    kunnr     TYPE mseg-kunnr,
*    stcd3     TYPE kna1-stcd3,
*    kzwi1     TYPE vbap-kzwi1,

  END OF t_final,
  tt_final TYPE STANDARD TABLE OF t_final.


TYPES:
  BEGIN OF ty_final,
    dispo     TYPE char100,
    brand     TYPE char100,
    matnr     TYPE char100,
    maktx     TYPE char100,
    long_txt  TYPE char250,
    dauat     TYPE char100,
    aufnr     TYPE char100,
    menge     TYPE char100,
    budat_con TYPE char11, "mseg-budat_mkpf,
    budat_in  TYPE char11, "mseg-budat_mkpf,
    prd_amt   TYPE char100,
    stprs     TYPE char100,
    zseries   TYPE char100,
    zsize     TYPE char3, "mara-zsize,
    moc       TYPE char100,
    type      TYPE char100,
    lgort     TYPE char100,
    ftrmi     TYPE char11, "afko-ftrmi,
    curr_date TYPE char11,
    price     TYPE char15,
    wrkst     TYPE mara-wrkst,
    werks     TYPE mseg-werks,
    CSONO     TYPE char100,
*    kdauf     TYPE char100,
*    kdpos     TYPE char100,
*    vkbur     TYPE char100,
*    name1     TYPE char100,
*    edatu     TYPE char11, "vbep-edatu,
*    kwmeng    TYPE char100,
*    deldate   TYPE char11, "vbap-deldate,
*    kdmat     TYPE char100,
*    netpr     TYPE char100,
*    aedat     TYPE char11, "vbak-aedat,
*    waerk     TYPE char100,
*    kursk     TYPE char100,
*    s_val     TYPE char100,
*    s_val_lc  TYPE char100,
*    auart     TYPE char100,
*    so_curr   TYPE char100,
*    werks     TYPE mseg-werks,
*    kunnr     TYPE mseg-kunnr,
*    stcd3     TYPE kna1-stcd3,
*    kzwi1     TYPE vbap-kzwi1,

  END OF ty_final.
*  tt_final TYPE STANDARD TABLE OF t_final.

DATA:
  gt_final TYPE tt_final,
  IT_FINAL TYPE TABLE OF ty_FINAL.

SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE xyz.
SELECT-OPTIONS: so_budat FOR tmp_budat OBLIGATORY DEFAULT '20170401' TO sy-datum,
                so_dauat FOR tmp_dauat NO INTERVALS,
*                so_kdauf FOR tmp_kdauf,
                so_lgort FOR tmp_lgort NO INTERVALS,
                so_matnr FOR tmp_mat,
                so_plant FOR afpo-pwerk OBLIGATORY DEFAULT 'US01'.
SELECTION-SCREEN: END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE abc .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder TYPE rlgrap-filename DEFAULT '/Delval/USA'."USA'."USA'."usa'.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN :BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
  SELECTION-SCREEN  COMMENT /1(60) TEXT-004.
  SELECTION-SCREEN COMMENT /1(70) TEXT-005.
SELECTION-SCREEN: END OF BLOCK B3.

INITIALIZATION.
  xyz = 'Select Options'(tt1).
  abc = 'Download File'(tt2).

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_folder.

  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
*     FIELD_NAME    = ' '
    IMPORTING
      file_name     = p_folder.

START-OF-SELECTION.

  PERFORM fetch_data CHANGING gt_final.
  PERFORM display USING gt_final.
*&---------------------------------------------------------------------*
*&      Form  FETCH_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_FINAL  text
*----------------------------------------------------------------------*
FORM fetch_data  CHANGING ct_final TYPE tt_final.
  DATA:
    lt_mat_doc        TYPE tt_mat_doc,
    ls_mat_doc        TYPE t_mat_doc,
    lt_mat_doc_101    TYPE tt_mat_doc,
    ls_mat_doc_101    TYPE t_mat_doc,
    lt_order_item     TYPE tt_order_item,
    ls_order_item     TYPE t_order_item,
    lt_sales_ord_hdr  TYPE tt_sales_ord_hdr,
    ls_sales_ord_hdr  TYPE t_sales_ord_hdr,
    lt_sales_ord_item TYPE tt_sales_ord_item,
    ls_sales_ord_item TYPE t_sales_ord_item,
    lt_mat_mast       TYPE tt_mat_mast,
    ls_mat_mast       TYPE t_mat_mast,
    lt_mat_desc       TYPE tt_mat_desc,
    ls_mat_desc       TYPE t_mat_desc,
    lt_vbep           TYPE tt_vbep,
    ls_vbep           TYPE t_vbep,
    lt_cust_info      TYPE tt_cust_info,
    ls_cust_info      TYPE t_cust_info,
    lt_marc           TYPE tt_marc,
    ls_marc           TYPE t_marc,
    lt_mbew           TYPE tt_mbew,
    ls_mbew           TYPE t_mbew,
    lt_qamb           TYPE tt_qamb,
    ls_qamb           TYPE t_qamb,
    lt_qals           TYPE tt_qals,
    ls_qals           TYPE t_qals,
    lt_order_hdr      TYPE tt_order_hdr,
    ls_order_hdr      TYPE t_order_hdr,
    lt_coep           TYPE tt_coep,
    ls_coep           TYPE t_coep,
    lt_vbkd           TYPE tt_vbkd,
    ls_vbkd           TYPE t_vbkd,
    ls_final          TYPE t_final,
    WA_FINAL          TYPE Ty_FINAL.

  DATA:
    lv_id        TYPE thead-tdname,
    lt_lines     TYPE STANDARD TABLE OF tline,
    ls_lines     TYPE tline,
    lv_index     TYPE sy-tabix,
    lv_cost      TYPE prcd_elements-kwert,
    lv_cost_h      TYPE prcd_elements-kwert,
    ls_exch_rate TYPE bapi1093_0.



  IF NOT so_dauat IS INITIAL.
    SELECT aufnr
           posnr
           dauat
           psmng
           PWERK
      FROM afpo
      INTO TABLE lt_order_item
      WHERE dauat IN so_dauat
      AND PWERK IN so_plant." 'US01'." ADDED BY MD

    IF NOT lt_order_item IS INITIAL.
      SELECT mblnr
             mjahr
             zeile
             bwart
             matnr
             werks
             lgort
             kunnr
             kdauf
             kdpos
             waers
             menge
             aufnr
             budat_mkpf
        FROM mseg
        INTO TABLE lt_mat_doc
        FOR ALL ENTRIES IN lt_order_item
        WHERE aufnr = lt_order_item-aufnr
        AND   budat_mkpf IN so_budat
        AND   bwart = '101'
*        AND   xauto = 'X'
        AND   matnr IN so_matnr
        AND   lgort IN so_lgort
*        AND   kdauf IN so_kdauf
        AND   WERKS = lt_order_item-PWERK." ADDED BY MD
    ENDIF.
  ELSE.
    SELECT mblnr
           mjahr
           zeile
           bwart
           matnr
           werks
           lgort
           kunnr
           kdauf
           kdpos
           waers
           menge
           aufnr
           budat_mkpf
      FROM mseg
      INTO TABLE lt_mat_doc
      WHERE budat_mkpf IN so_budat
      AND   bwart = '101'
*      AND   xauto = 'X'
      AND   matnr IN so_matnr
      AND   lgort IN so_lgort
*      AND   kdauf IN so_kdauf
      AND   aufnr NE space
      AND   WERKS IN so_plant." 'US01'.


  ENDIF.
  IF lt_mat_doc IS INITIAL.
    MESSAGE 'Data Not Found' TYPE 'E'.
  ELSE.
  IF lt_mat_doc IS NOT INITIAL.
    SELECT mblnr
           bwart
           werks
           smbln FROM mseg INTO TABLE it_mseg
           FOR ALL ENTRIES IN lt_mat_doc
           WHERE smbln = lt_mat_doc-mblnr.



  ENDIF.

    SELECT aufnr
           posnr
           dauat
           psmng
      FROM afpo
      INTO TABLE lt_order_item
      FOR ALL ENTRIES IN lt_mat_doc
      WHERE aufnr = lt_mat_doc-aufnr.

    IF NOT lt_order_item IS INITIAL.
      LOOP AT lt_order_item INTO ls_order_item.
        CONCATENATE 'OR' ls_order_item-aufnr INTO ls_order_item-objnr.
        MODIFY lt_order_item FROM ls_order_item TRANSPORTING objnr.
      ENDLOOP.

      SELECT aufnr
             ftrmi
        FROM afko
        INTO TABLE lt_order_hdr
        FOR ALL ENTRIES IN lt_order_item
        WHERE aufnr = lt_order_item-aufnr.

      SELECT kokrs
             belnr
             buzei
             wtgbtr
             objnr
             beknz
        FROM coep
        INTO TABLE lt_coep
        FOR ALL ENTRIES IN lt_order_item
        WHERE objnr = lt_order_item-objnr
        AND   beknz IN ( 'S' , 'H' ).
    ENDIF.
    SELECT vbeln
           audat
           auart
           vkbur
           knumv
           kunnr
           aedat
           waerk
      FROM vbak
      INTO TABLE lt_sales_ord_hdr
      FOR ALL ENTRIES IN lt_mat_doc
      WHERE vbeln = lt_mat_doc-kdauf.

    SELECT vbeln
           posnr
           matnr
           kdmat
           kwmeng
           deldate
           kzwi1
      FROM vbap
      INTO TABLE lt_sales_ord_item
      FOR ALL ENTRIES IN lt_mat_doc
      WHERE vbeln = lt_mat_doc-kdauf
      AND   posnr = lt_mat_doc-kdpos.

    SELECT vbeln
           posnr
           kursk
      FROM vbkd
      INTO TABLE lt_vbkd
      FOR ALL ENTRIES IN lt_sales_ord_item
      WHERE vbeln = lt_sales_ord_item-vbeln.

    SELECT matnr
           zseries
           zsize
           brand
           moc
           type
           wrkst
      FROM mara
      INTO TABLE lt_mat_mast
      FOR ALL ENTRIES IN lt_mat_doc
      WHERE matnr = lt_mat_doc-matnr.

    SELECT matnr
           maktx
      FROM makt
      INTO TABLE lt_mat_desc
      FOR ALL ENTRIES IN lt_mat_mast
      WHERE matnr = lt_mat_mast-matnr
      AND   spras = sy-langu.

    SELECT vbeln
           posnr
           edatu
      FROM vbep
      INTO TABLE lt_vbep
      FOR ALL ENTRIES IN lt_mat_doc
      WHERE vbeln = lt_mat_doc-kdauf
      AND   posnr = lt_mat_doc-kdpos.

    SELECT kunnr
           name1
           stcd3
      FROM kna1
      INTO TABLE lt_cust_info
      FOR ALL ENTRIES IN lt_sales_ord_hdr
      WHERE kunnr = lt_sales_ord_hdr-kunnr.

    SELECT matnr
           werks
           dispo
      FROM marc
      INTO TABLE lt_marc
      FOR ALL ENTRIES IN lt_mat_doc
      WHERE matnr = lt_mat_doc-matnr.

    SELECT matnr
           bwkey
           stprs
           verpr
      FROM mbew
      INTO TABLE lt_mbew
      FOR ALL ENTRIES IN lt_mat_doc
      WHERE matnr = lt_mat_doc-matnr
        AND bwkey = lt_mat_doc-werks.

    SELECT prueflos
           typ
           mblnr
           mjahr
           zeile
      FROM qamb
      INTO TABLE lt_qamb
      FOR ALL ENTRIES IN lt_mat_doc
      WHERE mblnr = lt_mat_doc-mblnr
      AND   mjahr = lt_mat_doc-mjahr.
*        AND   zeile = lt_mat_doc-zeile.

    IF NOT lt_qamb IS INITIAL.

      SELECT prueflos
             aufnr
             mjahr
             mblnr
        FROM qals
        INTO TABLE lt_qals
        FOR ALL ENTRIES IN lt_qamb
        WHERE prueflos = lt_qamb-prueflos.

      IF NOT lt_qals IS INITIAL.
        SELECT mblnr
           mjahr
           zeile
           bwart
           matnr
           werks
           lgort
           kunnr
           kdauf
           kdpos
           waers
           menge
           aufnr
           budat_mkpf
      FROM mseg
      INTO TABLE lt_mat_doc_101
      FOR ALL ENTRIES IN lt_qals
      WHERE mblnr = lt_qals-mblnr
      AND   mjahr = lt_qals-mjahr
      AND   aufnr = lt_qals-aufnr
      AND   bwart = '101'.
      ENDIF.
    ENDIF.
  ENDIF.


  SORT lt_coep BY objnr.
  LOOP AT lt_mat_doc INTO ls_mat_doc.

*    ls_final-kdauf    = ls_mat_doc-kdauf.
*    ls_final-kdpos    = ls_mat_doc-kdpos.
*    ls_final-waers    = ls_mat_doc-waers.
    ls_final-aufnr    = ls_mat_doc-aufnr.
    ls_final-budat_in = ls_mat_doc-budat_mkpf.
    ls_final-budat_con = ls_mat_doc-budat_mkpf.
    ls_final-matnr    = ls_mat_doc-matnr.
*    ls_final-werks    = ls_mat_doc-werks.
    ls_final-lgort    = ls_mat_doc-lgort.
*    ls_final-kunnr    = ls_mat_doc-kunnr.
    ls_final-menge    = ls_mat_doc-menge.
    ls_final-werks    = ls_mat_doc-werks.

    READ TABLE lt_marc INTO ls_marc WITH KEY matnr = ls_mat_doc-matnr
                                             werks = ls_mat_doc-werks.
    IF sy-subrc IS INITIAL.
      ls_final-dispo  = ls_marc-dispo.
    ENDIF.
    READ TABLE lt_order_item INTO ls_order_item WITH KEY aufnr = ls_mat_doc-aufnr.
    IF sy-subrc IS INITIAL.
      ls_final-dauat  = ls_order_item-dauat.
    ENDIF.
*
    LOOP AT lt_coep INTO ls_coep WHERE objnr = ls_order_item-objnr AND beknz = 'S'.
       lv_cost = lv_cost + ls_coep-wtgbtr.
    ENDLOOP.

    LOOP AT lt_coep INTO ls_coep WHERE objnr = ls_order_item-objnr AND beknz = 'H'.
       lv_cost_h = lv_cost_h - ls_coep-wtgbtr.
    ENDLOOP.

*    READ TABLE lt_coep INTO ls_coep WITH KEY objnr = ls_order_item-objnr beknz = 'S'.
*    IF sy-subrc IS INITIAL.
*      lv_index = sy-tabix.
*      LOOP AT lt_coep INTO ls_coep FROM lv_index.
*        IF ls_coep-objnr = ls_order_item-objnr .
*          lv_cost = lv_cost + ls_coep-wtgbtr.
*        ELSE.
*          EXIT.
*        ENDIF.
*
*      ENDLOOP.
*    ENDIF.
*
*    CLEAR ls_coep.
*    READ TABLE lt_coep INTO ls_coep WITH KEY objnr = ls_order_item-objnr beknz = 'H'.
*    IF sy-subrc IS INITIAL.
*      lv_index = sy-tabix.
*      LOOP AT lt_coep INTO ls_coep FROM lv_index.
*        IF ls_coep-objnr = ls_order_item-objnr .
*          lv_cost_h = lv_cost_h - ls_coep-wtgbtr.
*        ELSE.
*          EXIT.
*        ENDIF.
*
*      ENDLOOP.
*    ENDIF.

    lv_cost = lv_cost - lv_cost_h.

    ls_final-prd_amt = ( lv_cost / ls_order_item-psmng )  * ls_final-menge.
    ls_final-price  = ls_final-prd_amt / ls_final-menge.

    READ TABLE lt_order_hdr INTO ls_order_hdr WITH KEY aufnr = ls_order_item-aufnr.
    IF sy-subrc IS INITIAL.
      ls_final-ftrmi = ls_order_hdr-ftrmi.

    ENDIF.
    READ TABLE lt_sales_ord_item INTO ls_sales_ord_item WITH KEY vbeln = ls_mat_doc-kdauf
                                                                 posnr = ls_mat_doc-kdpos.
    IF sy-subrc IS INITIAL.
*      ls_final-kdmat   = ls_sales_ord_item-kdmat.
*      ls_final-kwmeng  = ls_sales_ord_item-kwmeng.
      IF NOT ls_sales_ord_item-deldate IS INITIAL.
*
*        CONCATENATE ls_sales_ord_item-deldate+6(2) ls_sales_ord_item-deldate+4(2) ls_sales_ord_item-deldate+0(4)
*                INTO ls_final-deldate SEPARATED BY '-'.
      ELSE.
*        ls_final-deldate = 'NULL'.
      ENDIF.

*      ls_final-kzwi1   = ls_sales_ord_item-kzwi1.
*      ls_final-netpr   = ls_sales_ord_item-kzwi1 / ls_sales_ord_item-kwmeng.
*      ls_final-s_val = ls_final-netpr * ls_final-menge.
    ELSE.
*      ls_final-deldate = 'NULL'.
*    ls_final-so_amt  =
    ENDIF.
    READ TABLE lt_vbkd INTO ls_vbkd WITH KEY vbeln = ls_sales_ord_item-vbeln.
    IF sy-subrc IS INITIAL.
*      ls_final-so_curr    = ls_vbkd-kursk.
    ENDIF.
    READ TABLE lt_sales_ord_hdr INTO ls_sales_ord_hdr WITH KEY vbeln = ls_sales_ord_item-vbeln.
    IF sy-subrc IS INITIAL.
*      ls_final-waerk   = ls_sales_ord_hdr-waerk.
*      ls_final-vkbur   = ls_sales_ord_hdr-vkbur.
*      ls_final-auart = ls_sales_ord_hdr-auart.


*      CALL FUNCTION 'BAPI_EXCHANGERATE_GETDETAIL'
*        EXPORTING
*          rate_type  = 'M'
**          from_curr  = ls_final-waerk
*          to_currncy = 'INR'
*          date       = sy-datum
*        IMPORTING
*          exch_rate  = ls_exch_rate
**         RETURN     =
        .

*      ls_final-kursk    = ls_exch_rate-exch_rate.
*      ls_final-s_val_lc = ls_final-s_val * ls_exch_rate-exch_rate.


      IF NOT ls_sales_ord_hdr-aedat IS INITIAL.

*        CONCATENATE ls_sales_ord_hdr-aedat+6(2) ls_sales_ord_hdr-aedat+4(2) ls_sales_ord_hdr-aedat+0(4)
*                INTO ls_final-aedat SEPARATED BY '-'.
      ELSE.
*        ls_final-aedat = 'NULL'.
      ENDIF.

    ELSE.
*      ls_final-aedat = 'NULL'.
    ENDIF.
    READ TABLE lt_vbep INTO ls_vbep WITH KEY vbeln = ls_mat_doc-kdauf
                                             posnr = ls_mat_doc-kdpos.
    IF sy-subrc IS INITIAL.
      IF NOT ls_vbep-edatu IS INITIAL.

*        CONCATENATE ls_vbep-edatu+6(2) ls_vbep-edatu+4(2) ls_vbep-edatu+0(4)
*                INTO ls_final-edatu SEPARATED BY '-'.
      ELSE.
*        ls_final-edatu = 'NULL'.
      ENDIF.
    ELSE.
*      ls_final-edatu = 'NULL'.
    ENDIF.
    READ TABLE lt_cust_info INTO ls_cust_info WITH KEY kunnr = ls_sales_ord_hdr-kunnr.
    IF sy-subrc IS INITIAL.
*      ls_final-name1 = ls_cust_info-name1.
*      ls_final-stcd3 = ls_cust_info-stcd3.
    ENDIF.
    READ TABLE lt_mat_mast INTO ls_mat_mast WITH KEY matnr = ls_final-matnr.
    IF sy-subrc IS INITIAL.
      ls_final-zseries = ls_mat_mast-zseries.
      ls_final-zsize   = ls_mat_mast-zsize.
      ls_final-brand   = ls_mat_mast-brand.
      ls_final-moc     = ls_mat_mast-moc.
      ls_final-type    = ls_mat_mast-type.
      ls_final-wrkst   = ls_mat_mast-wrkst.
    ENDIF.
    READ TABLE lt_mat_desc INTO ls_mat_desc WITH KEY matnr = ls_final-matnr.
    IF sy-subrc IS INITIAL.
      ls_final-maktx   = ls_mat_desc-maktx.

    ENDIF.
    READ TABLE lt_mbew INTO ls_mbew WITH KEY matnr = ls_final-matnr.
    IF sy-subrc IS INITIAL.
      ls_final-stprs   = ls_mbew-verpr.
    ENDIF.
*    READ TABLE lt_qamb INTO ls_qamb WITH KEY mblnr = ls_mat_doc-mblnr
*                                             mjahr = ls_mat_doc-mjahr.
*    IF sy-subrc IS INITIAL.
*      READ TABLE lt_qals INTO ls_qals WITH KEY prueflos = ls_qamb-prueflos.
*      IF sy-subrc IS INITIAL.
*        READ TABLE lt_mat_doc_101 INTO ls_mat_doc_101 WITH KEY mblnr = ls_qals-mblnr
*                                                               mjahr = ls_qals-mjahr.
*        IF sy-subrc IS INITIAL.
*          IF NOT ls_mat_doc_101-budat_mkpf IS INITIAL.
*
*            CONCATENATE ls_mat_doc_101-budat_mkpf+6(2) ls_mat_doc_101-budat_mkpf+4(2) ls_mat_doc_101-budat_mkpf+0(4)
*                    INTO ls_final-budat_con SEPARATED BY '-'.
*          ELSE.
*            ls_final-budat_con = 'NULL'.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*    ENDIF.
    "Material Long Text
    lv_id = ls_final-matnr.
    CLEAR: lt_lines,ls_lines.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        client                  = sy-mandt
        id                      = 'GRUN'
        language                = sy-langu
        name                    = lv_id
        object                  = 'MATERIAL'
      TABLES
        lines                   = lt_lines
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
    IF NOT lt_lines IS INITIAL.
      LOOP AT lt_lines INTO ls_lines.
        IF NOT ls_lines-tdline IS INITIAL.
          CONCATENATE ls_final-long_txt ls_lines-tdline INTO ls_final-long_txt SEPARATED BY space.
        ENDIF.
      ENDLOOP.
      CONDENSE ls_final-long_txt.
    ENDIF.

    REPLACE ALL OCCURRENCES OF '<(>' IN ls_final-long_txt WITH SPACE.
    REPLACE ALL OCCURRENCES OF '<)>' IN ls_final-long_txt WITH SPACE.

    LS_FINAL-CURR_DATE = SY-DATUM.

    """"""""""""""""""""""""""""""""
*    BREAK primusabap.
       CLEAR: lt_lines,ls_lines.                                       """added by Pranit 18.11.2024
      CONCATENATE SY-MANDT ls_final-aufnr INTO LV_id.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'KOPF'
          language                = sy-langu
          name                    = LV_id
          object                  = 'AUFK'
        TABLES
          lines                   = lt_lines
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

      IF NOT lt_lines IS INITIAL.                  "added by supriya 26.06.2024
        LOOP AT lt_lines INTO ls_lines.
          IF NOT ls_lines-tdline IS INITIAL.
            CONCATENATE ls_final-CSONO ls_lines-tdline INTO ls_final-CSONO SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        CONDENSE ls_final-CSONO.
      ENDIF.
    """"""""""""""""""""""""""""""""

***************************************************new file download******************************

IF ls_vbep-edatu IS NOT INITIAL.
*
*  CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = ls_vbep-edatu
*   IMPORTING
*     OUTPUT        = WA_FINAL-EDATU
*            .
*CONCATENATE WA_FINAL-EDATU+0(2) WA_FINAL-EDATU+2(3) WA_FINAL-EDATU+5(4)
*                INTO WA_FINAL-EDATU SEPARATED BY '-'.
*CONCATENATE WA_FINAL-EDATU

ENDIF.

IF ls_sales_ord_item-deldate IS NOT INITIAL.


*  CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = ls_sales_ord_item-deldate
*   IMPORTING
*     OUTPUT        = WA_FINAL-DELDATE
*            .
*CONCATENATE WA_FINAL-DELDATE+0(2) WA_FINAL-DELDATE+2(3) WA_FINAL-DELDATE+5(4)
*                INTO WA_FINAL-DELDATE SEPARATED BY '-'.
ENDIF.

IF ls_mat_doc-budat_mkpf IS NOT INITIAL.
  CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = ls_mat_doc-budat_mkpf
   IMPORTING
     OUTPUT        = WA_FINAL-BUDAT_CON
            .

CONCATENATE WA_FINAL-BUDAT_CON+0(2) WA_FINAL-BUDAT_CON+2(3) WA_FINAL-BUDAT_CON+5(4)
                INTO WA_FINAL-BUDAT_CON SEPARATED BY '-'.
ENDIF.

IF ls_mat_doc-budat_mkpf IS NOT INITIAL.
  CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = ls_mat_doc-budat_mkpf
   IMPORTING
     OUTPUT        = WA_FINAL-BUDAT_IN
            .

CONCATENATE WA_FINAL-BUDAT_IN+0(2) WA_FINAL-BUDAT_IN+2(3) WA_FINAL-BUDAT_IN+5(4)
                INTO WA_FINAL-BUDAT_IN SEPARATED BY '-'.

ENDIF.
*break primus.
IF ls_sales_ord_hdr-aedat IS NOT INITIAL.
*  CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = ls_sales_ord_hdr-aedat
*   IMPORTING
*     OUTPUT        = WA_FINAL-AEDAT
*            .
*
*CONCATENATE WA_FINAL-AEDAT+0(2) WA_FINAL-AEDAT+2(3) WA_FINAL-AEDAT+5(4)
*                INTO WA_FINAL-AEDAT SEPARATED BY '-'.
ENDIF.

IF ls_order_hdr-ftrmi IS NOT INITIAL.
   CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = ls_order_hdr-ftrmi
   IMPORTING
     OUTPUT        = WA_FINAL-FTRMI
            .

CONCATENATE WA_FINAL-FTRMI+0(2) WA_FINAL-FTRMI+2(3) WA_FINAL-FTRMI+5(4)
                INTO WA_FINAL-FTRMI SEPARATED BY '-'.

ENDIF.


IF LS_FINAL-CURR_DATE IS NOT INITIAL.
   CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = LS_FINAL-CURR_DATE
   IMPORTING
     OUTPUT        = WA_FINAL-CURR_DATE
            .

CONCATENATE WA_FINAL-CURR_DATE+0(2) WA_FINAL-CURR_DATE+2(3) WA_FINAL-CURR_DATE+5(4)
                INTO WA_FINAL-CURR_DATE SEPARATED BY '-'.

ENDIF.

WA_FINAL-DISPO = LS_FINAL-DISPO.

WA_FINAL-BRAND = LS_FINAL-BRAND.

wa_final-csono = ls_final-csono.

*WA_FINAL-KDAUF = LS_FINAL-KDAUF.

*WA_FINAL-KDPOS = LS_FINAL-KDPOS.

*WA_FINAL-AUART = LS_FINAL-AUART.

*WA_FINAL-VKBUR = LS_FINAL-VKBUR.

WA_FINAL-MATNR = LS_FINAL-MATNR.
WA_FINAL-wrkst = LS_FINAL-wrkst.
WA_FINAL-werks = LS_FINAL-werks.

WA_FINAL-PRD_AMT = LS_FINAL-PRD_AMT.
WA_FINAL-price   = LS_FINAL-price.

 CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
    CHANGING
        value = WA_FINAL-price.

 CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
    CHANGING
        value = WA_FINAL-PRD_AMT.

*WA_FINAL-NETPR = LS_FINAL-NETPR.

WA_FINAL-STPRS = LS_FINAL-STPRS.

*WA_FINAL-S_VAL = LS_FINAL-S_VAL.

*WA_FINAL-S_VAL_LC = LS_FINAL-S_VAL_LC.

WA_FINAL-MAKTX = LS_FINAL-MAKTX.

WA_FINAL-LONG_TXT = LS_FINAL-LONG_TXT.

WA_FINAL-DAUAT = LS_FINAL-DAUAT.

*WA_FINAL-NAME1 = LS_FINAL-NAME1.

*WA_FINAL-KWMENG = LS_FINAL-KWMENG.

*WA_FINAL-KDMAT = LS_FINAL-KDMAT.

WA_FINAL-AUFNR = LS_FINAL-AUFNR.

WA_FINAL-MENGE = LS_FINAL-MENGE.

*WA_FINAL-WAERK = LS_FINAL-WAERK.

*WA_FINAL-SO_CURR = LS_FINAL-SO_CURR.

*WA_FINAL-KURSK = LS_FINAL-KURSK.

WA_FINAL-ZSERIES = LS_FINAL-ZSERIES.

WA_FINAL-ZSIZE = LS_FINAL-ZSIZE.

WA_FINAL-TYPE = LS_FINAL-TYPE.

WA_FINAL-MOC = LS_FINAL-MOC.

WA_FINAL-LGORT = LS_FINAL-LGORT.

READ TABLE it_mseg INTO wa_mseg WITH KEY smbln = ls_mat_doc-mblnr.
IF sy-subrc = 4.
APPEND WA_FINAL TO IT_FINAL.

APPEND ls_final TO ct_final.
ENDIF.

    CLEAR: ls_final,ls_mat_doc,ls_mat_doc_101,ls_qals,ls_qamb,ls_mbew,ls_mat_mast,ls_cust_info,ls_vbep,ls_sales_ord_hdr,ls_sales_ord_item,
           ls_order_item,ls_order_hdr,ls_coep,ls_vbkd,lv_cost,lv_cost_h.
  ENDLOOP.

  SORT ct_final BY aufnr.
  SORT IT_FINAL BY aufnr.
*  APPEND LINES OF CT_FINAL TO IT_FINAL.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GT_FINAL  text
*----------------------------------------------------------------------*
FORM display  USING    ct_final TYPE tt_final.
  DATA:
    lt_fieldcat     TYPE slis_t_fieldcat_alv,
    ls_alv_layout   TYPE slis_layout_alv,
    l_callback_prog TYPE sy-repid.

  l_callback_prog = sy-repid.


  PERFORM prepare_display CHANGING lt_fieldcat.
  CLEAR ls_alv_layout.
  ls_alv_layout-zebra = 'X'.
  ls_alv_layout-colwidth_optimize = 'X'.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = l_callback_prog
*     I_CALLBACK_PF_STATUS_SET          = ' '
      i_callback_user_command = 'UCOMM_ON_ALV'
*     I_CALLBACK_TOP_OF_PAGE  = ' '
      is_layout               = ls_alv_layout
      it_fieldcat             = lt_fieldcat
    TABLES
      t_outtab                = ct_final
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  IF p_down = 'X'.

    PERFORM download.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PREPARE_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_LT_FIELDCAT  text
*----------------------------------------------------------------------*
FORM prepare_display  CHANGING ct_fieldcat TYPE slis_t_fieldcat_alv.
  DATA:
    gv_pos      TYPE i,
    ls_fieldcat TYPE slis_fieldcat_alv.

  REFRESH ct_fieldcat.
  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'DISPO'.
*  ls_fieldcat-outputlen = '15'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'MRP Controller'."(100).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'BRAND'.
*  ls_fieldcat-outputlen = '8'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Brand'."(101).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'KDAUF'.
**  ls_fieldcat-outputlen = '15'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Sales Order No.'(102).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'KDPOS'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Line Item'(103).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'AUART'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Order Type'(132).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'VKBUR'.
**  ls_fieldcat-outputlen = '12'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Sales Office'(104).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'MATNR'.
*  ls_fieldcat-outputlen = '18'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Material No'."(105).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'WRKST'.
*  ls_fieldcat-outputlen = '18'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'USA Code'."(105).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'MAKTX'.
*  ls_fieldcat-outputlen = '40'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Item Description'."(106).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'LONG_TXT'.
*  ls_fieldcat-outputlen = '40'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Long Description'."(127).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.
  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'DAUAT'.
*  ls_fieldcat-outputlen = '21'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Production Order Type'."(107).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.


*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'NAME1'.
**  ls_fieldcat-outputlen = '30'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Customer Name'(125).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'EDATU'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Production Date'(126).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'KWMENG'.
**  ls_fieldcat-outputlen = '7'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'SO QTY.'(108).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'DELDATE'.
**  ls_fieldcat-outputlen = '13'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Delivery Date'(109).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'KDMAT'.
**  ls_fieldcat-outputlen = '18'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Customer Item Code'(110).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'AUFNR'.
*  ls_fieldcat-outputlen = '20'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Production Order No'."(111).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'MENGE'.
*  ls_fieldcat-outputlen = '10'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Quantity'."(112).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'BUDAT_CON'.
*  ls_fieldcat-outputlen = '17'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Confirmation Date'."(113).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'BUDAT_IN'.
*  ls_fieldcat-outputlen = '15'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Inspection Date'."(114).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'PRD_AMT'.
*  ls_fieldcat-outputlen = '15'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Production Amt'."(115).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'PRICE'.
*  ls_fieldcat-outputlen = '15'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Production Amt/PC'."(150).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.


*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'S_VAL'.
**  ls_fieldcat-outputlen = '15'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Sales Value(DC)'(128).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'WAERK'.
**  ls_fieldcat-outputlen = '15'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Currency'(129).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'SO_CURR'.
**  ls_fieldcat-outputlen = '15'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'SO Exchange Rate'(131).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'KURSK'.
**  ls_fieldcat-outputlen = '15'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Current Exchange Rate'(133).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'S_VAL_LC'.
**  ls_fieldcat-outputlen = '15'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Sales Value(LC)'(130).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'NETPR'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'Rate'(116).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'STPRS'.
*  ls_fieldcat-outputlen = '13'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Standard Cost'."(117).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'ZSERIES'.
*  ls_fieldcat-outputlen = '10'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Series'."(118).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'ZSIZE'.
*  ls_fieldcat-outputlen = '8'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Size'."(119).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'MOC'.
*  ls_fieldcat-outputlen = '8'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'MOC'."(120).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'TYPE'.
*  ls_fieldcat-outputlen = '10'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Type'."(121).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'LGORT'.
*  ls_fieldcat-outputlen = '12'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Storage Loc'."(122).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'AEDAT'.
**  ls_fieldcat-outputlen = '15'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_m = 'MRP Date'(123).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'FTRMI'.
*  ls_fieldcat-outputlen = '15'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Order Create Date'."(124).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'CURR_DATE'.
*  ls_fieldcat-outputlen = '15'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'File Create Date'."(134).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

  gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'WERKS'.
*  ls_fieldcat-outputlen = '15'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Plant'."(124).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.

    gv_pos = gv_pos + 1.
  ls_fieldcat-fieldname = 'CSONO'.
*  ls_fieldcat-outputlen = '15'.
  ls_fieldcat-tabname   = 'GT_FINAL'.
  ls_fieldcat-seltext_l = 'Customer SO NO./Name'."(124).
  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND ls_fieldcat TO ct_fieldcat.
  CLEAR ls_fieldcat.
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
      i_tab_sap_data       = gt_final
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
  lv_file = 'ZUSPRD.TXT'.

  CONCATENATE p_folder '/' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'ZPRD Download started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1576 TYPE string.
DATA lv_crlf_1576 TYPE string.
lv_crlf_1576 = cl_abap_char_utilities=>cr_lf.
lv_string_1576 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1576 lv_crlf_1576 wa_csv INTO lv_string_1576.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_1648 TO lv_fullfile.
TRANSFER lv_string_1576 TO lv_fullfile.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.

*************************************************SECOND FILE ***************************************


  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = IT_final
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
  lv_file = 'ZUSPRDCOPY.TXT'.

  CONCATENATE p_folder '/' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZPRD Download started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1613 TYPE string.
DATA lv_crlf_1613 TYPE string.
lv_crlf_1613 = cl_abap_char_utilities=>cr_lf.
lv_string_1613 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1613 lv_crlf_1613 wa_csv INTO lv_string_1613.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_1648 TO lv_fullfile.
TRANSFER lv_string_1613 TO lv_fullfile.
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
  CONCATENATE 'MRP Controller'
              'Brand'
              'Material No'
              'Item Description'
              'Long Description'
              'Production Order Type'
              'Production Order No'
              'Quantity'
              'Confirmation Date'
              'Inspection Date'
              'Production Amt.'
              'Standard Cost'
              'Series'
              'Size'
              'MOC'
              'Type'
              'Storage Loc.'
              'Order Release Date'
              'Refresh Date'
              'Production Amt/PC'
              'USA Code'
              'Plant'
              'Customer SO NO./Name'
*              'Sales Order No.'
*              'Line Item'
*              'Sales Office'
*              'Customer Name'
*              'Production Date'
*              'SO QTY.'
*              'Delivery Date'
*              'Customer Item Code'
*              'Rate'
*              'MRP Date'
*              'Currency'
*              'Current Exchange Rate'
*              'Sales Value(DC)'
*              'Sales Value(LC)'
*              'Sales Order Type'
*              'SO Exchange Rate'

              INTO pd_csv
              SEPARATED BY l_field_seperator.

ENDFORM.

*&---------------------------------------------------------------------*
*& Report ZUS_ITEM_MASTER_PURCHASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_ITEM_PURCHASE_MASTER.


TABLES:mseg.

TYPES:BEGIN OF ty_mseg,
      MBLNR TYPE mseg-mblnr,
      zeile TYPE mseg-zeile,
      MJAHR TYPE mseg-MJAHR,
      BWART TYPE mseg-BWART,
      MATNR TYPE mseg-MATNR,
      WERKS TYPE mseg-WERKS,
      DMBTR TYPE mseg-DMBTR,
      MENGE TYPE mseg-MENGE,
      GJAHR TYPE mseg-GJAHR,
      BUDAT_MKPF TYPE mseg-BUDAT_MKPF,
      EBELN TYPE mseg-EBELN,
      EBELP TYPE mseg-EBELP,
      aufnr TYPE mseg-aufnr,
      smbln TYPE mseg-smbln,
      END OF ty_mseg,

      BEGIN OF str_mseg,
      MBLNR TYPE mseg-mblnr,
      BWART TYPE mseg-BWART,
      MATNR TYPE mseg-MATNR,
      WERKS TYPE mseg-WERKS,
      MENGE TYPE mseg-MENGE,
      EBELN TYPE mseg-EBELN,
      EBELP TYPE mseg-EBELP,
      aufnr TYPE mseg-aufnr,
      SMBLN TYPE mseg-SMBLN,
      END OF str_mseg,


      BEGIN OF ty_ekko,
      EBELN TYPE ekko-EBELN,
      AEDAT TYPE ekko-AEDAT,
      END OF ty_ekko,


      BEGIN OF ty_ekpo,
      EBELN TYPE ekpo-EBELN,
      EBELP TYPE ekpo-EBELP,
      matnr TYPE ekpo-matnr,
      werks TYPE ekpo-werks,
      netpr TYPE ekpo-netpr,
      MENGE TYPE ekpo-MENGE,
      loekz TYPE ekpo-loekz,
      END OF ty_ekpo,



      BEGIN OF ty_mara,
      MATNR TYPE mara-MATNR,
      ERSDA TYPE mara-ERSDA,
      MTART TYPE mara-MTART,
      MATKL TYPE mara-MATKL,
      WRKST TYPE mara-WRKST,
      ZSERIES TYPE mara-ZSERIES,
      ZSIZE   TYPE mara-ZSIZE  ,
      BRAND   TYPE mara-BRAND  ,
      MOC     TYPE mara-MOC    ,
      TYPE    TYPE mara-TYPE   ,

      END OF ty_mara,

      BEGIN OF ty_makt,
      matnr TYPE makt-matnr,
      maktx TYPE makt-maktx,
      END OF ty_makt,

      BEGIN OF ty_mard,
      matnr TYPE mard-matnr,
      werks TYPE mard-werks,
      lgort TYPE mard-lgort,
      labst TYPE mard-labst,
      END OF ty_mard,

      BEGIN OF ty_mslb,
      matnr TYPE mslb-matnr,
      werks TYPE mslb-werks,
      lblab TYPE mslb-lblab,
      END OF ty_mslb,

      BEGIN OF ty_mska,
      matnr TYPE mska-matnr,
      werks TYPE mska-werks,
      kalab TYPE mska-kalab,
      END OF ty_mska,

      BEGIN OF ty_mbew,
      matnr TYPE mbew-matnr,
      bwkey TYPE mbew-bwkey,
*      lbkum TYPE mbew-lbkum,
*      salk3 TYPE mbew-salk3,
      vprsv TYPE mbew-vprsv,
      verpr TYPE mbew-verpr,
      stprs TYPE mbew-stprs,
      BKLAS TYPE mbew-BKLAS,
      END OF ty_mbew,

      BEGIN OF ty_final,
      MBLNR     TYPE mseg-mblnr,
      BWART     TYPE mseg-BWART,
      MATNR     TYPE mseg-MATNR,
      WERKS     TYPE mseg-WERKS,
      MENGE     TYPE mseg-MENGE,
      BUDAT_MKPF TYPE mseg-BUDAT_MKPF,
      MJAHR      TYPE mseg-MJAHR,
      ERSDA     TYPE mara-ERSDA,
      MTART     TYPE mara-MTART,
      MATKL     TYPE mara-MATKL,
      WRKST     TYPE mara-WRKST,
      maktx     TYPE makt-maktx,
      ZSERIES   TYPE mara-ZSERIES,
      ZSIZE     TYPE mara-ZSIZE  ,
      BRAND     TYPE mara-BRAND  ,
      MOC       TYPE mara-MOC    ,
      TYPE      TYPE mara-TYPE   ,
      mattxt    TYPE text100,
      jan       TYPE mseg-MENGE,
      feb       TYPE mseg-MENGE,
      mar       TYPE mseg-MENGE,
      apr       TYPE mseg-MENGE,
      may       TYPE mseg-MENGE,
      jun       TYPE mseg-MENGE,
      jul       TYPE mseg-MENGE,
      aug       TYPE mseg-MENGE,
      sep       TYPE mseg-MENGE,
      oct       TYPE mseg-MENGE,
      nov       TYPE mseg-MENGE,
      dec       TYPE mseg-MENGE,
      jan_pr    TYPE ekpo-netpr,
      feb_pr    TYPE ekpo-netpr,
      mar_pr    TYPE ekpo-netpr,
      apr_pr    TYPE ekpo-netpr,
      may_pr    TYPE ekpo-netpr,
      jun_pr    TYPE ekpo-netpr,
      jul_pr    TYPE ekpo-netpr,
      aug_pr    TYPE ekpo-netpr,
      sep_pr    TYPE ekpo-netpr,
      oct_pr    TYPE ekpo-netpr,
      nov_pr    TYPE ekpo-netpr,
      dec_pr    TYPE ekpo-netpr,
      po_qty    TYPE ekpo-menge,
      gr_qty    TYPE ekpo-menge,
      on_ord    TYPE ekpo-menge,
      labst     TYPE mard-labst,
      kalab     TYPE mska-kalab,
      on_hand   TYPE mard-labst,
      price     TYPE mbew-verpr,
      BKLAS     TYPE mbew-BKLAS,
      sale_tot TYPE vbrp-fkimg,
      pri_tot  TYPE vbrp-netwr,
      END OF ty_final.


TYPES:BEGIN OF ty_str,
      MATNR     TYPE mseg-MATNR,
      WRKST     TYPE mara-WRKST,
      BKLAS     TYPE mbew-BKLAS,
      maktx     TYPE makt-maktx,
      MTART     TYPE mara-MTART,
      MATKL     TYPE mara-MATKL,
      ERSDA     TYPE char15,
      ZSERIES   TYPE mara-ZSERIES,
      ZSIZE     TYPE mara-ZSIZE  ,
      BRAND     TYPE mara-BRAND  ,
      MOC       TYPE mara-MOC    ,
      TYPE      TYPE mara-TYPE   ,
      jan       TYPE char15,
      feb       TYPE char15,
      mar       TYPE char15,
      apr       TYPE char15,
      may       TYPE char15,
      jun       TYPE char15,
      jul       TYPE char15,
      aug       TYPE char15,
      sep       TYPE char15,
      oct       TYPE char15,
      nov       TYPE char15,
      dec       TYPE char15,
*      on_ord    TYPE char15,
*      on_hand   TYPE char15,
*      labst     TYPE char15,
      jan_pr    TYPE char15,
      feb_pr    TYPE char15,
      mar_pr    TYPE char15,
      apr_pr    TYPE char15,
      may_pr    TYPE char15,
      jun_pr    TYPE char15,
      jul_pr    TYPE char15,
      aug_pr    TYPE char15,
      sep_pr    TYPE char15,
      oct_pr    TYPE char15,
      nov_pr    TYPE char15,
      dec_pr    TYPE char15,
      price     TYPE char15,
      ref       TYPE char15,
      sale_tot TYPE char15,
      pri_tot  TYPE char15,
*      WERKS     TYPE char10,
      END OF ty_str.


DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat LIKE LINE OF it_fcat.

DATA   fs_layout TYPE slis_layout_alv.


DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt  TYPE tline,
      ls_mattxt  TYPE tline.

DATA : date TYPE int4,
       pur_dat TYPE int4,
       fild TYPE dd03p-scrtext_l,
       year TYPE char4.





*      BEGIN OF ty_mard,
*      matnr TYPE mard-matnr,
*

DATA : it_down TYPE TABLE OF ty_str,
       wa_down TYPE          ty_str.

DATA: it_mseg TYPE TABLE OF ty_mseg,
      wa_mseg TYPE          ty_mseg,

      it_rev TYPE TABLE OF ty_mseg,
      wa_rev TYPE          ty_mseg,

      lt_mseg TYPE TABLE OF str_mseg,
      ls_mseg TYPE          str_mseg,

      lt_mseg1 TYPE TABLE OF str_mseg,
      ls_mseg1 TYPE          str_mseg,

      it_mara TYPE TABLE OF ty_mara,
      wa_mara TYPE          ty_mara,

      it_makt TYPE TABLE OF ty_makt,
      wa_makt TYPE          ty_makt,

      it_mard TYPE TABLE OF ty_mard,
      wa_mard TYPE          ty_mard,

      lt_mard TYPE TABLE OF ty_mard,
      ls_mard TYPE          ty_mard,

      it_mslb TYPE TABLE OF ty_mslb,
      wa_mslb TYPE          ty_mslb,

      it_mska TYPE TABLE OF ty_mska,
      wa_mska TYPE          ty_mska,

      it_mbew TYPE TABLE OF ty_mbew,
      wa_mbew TYPE          ty_mbew,

      lt_mbew TYPE TABLE OF ty_mbew,
      ls_mbew TYPE          ty_mbew,



      it_ekpo TYPE TABLE OF ty_ekpo,
      wa_ekpo TYPE          ty_ekpo,

      it_ekko TYPE TABLE OF ty_ekko,
      wa_ekko TYPE          ty_ekko,

      it_final TYPE TABLE OF ty_final,
      wa_final TYPE          ty_final,

      it_sort TYPE TABLE OF ty_final,
      wa_sort TYPE          ty_final.





SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  SELECT-OPTIONS:s_matnr FOR mseg-matnr,
*                 s_budat FOR mseg-BUDAT_MKPF.
                 s_werks FOR mseg-werks OBLIGATORY DEFAULT 'US01'.
  PARAMETERS    :
                 p_year  TYPE mseg-MJAHR OBLIGATORY DEFAULT '2018'.

SELECTION-SCREEN:END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT  '/Delval/USA'."USA'."USA'."usa' ."'E:/Delval/USA'."usa118'.
SELECTION-SCREEN END OF BLOCK b2.


DATA : JAN_un TYPE dd03p-scrtext_l,
       FEB_un TYPE dd03p-scrtext_l,
       MAR_un TYPE dd03p-scrtext_l,
       APR_un TYPE dd03p-scrtext_l,
       MAY_un TYPE dd03p-scrtext_l,
       JUN_un TYPE dd03p-scrtext_l,
       JUL_un TYPE dd03p-scrtext_l,
       AUG_un TYPE dd03p-scrtext_l,
       SEP_un TYPE dd03p-scrtext_l,
       OCT_un TYPE dd03p-scrtext_l,
       NOV_un TYPE dd03p-scrtext_l,
       DEC_un TYPE dd03p-scrtext_l.

DATA :JAN_pr TYPE dd03p-scrtext_l,
      FEB_pr TYPE dd03p-scrtext_l,
      MAR_pr TYPE dd03p-scrtext_l,
      APR_pr TYPE dd03p-scrtext_l,
      MAY_pr TYPE dd03p-scrtext_l,
      JUN_pr TYPE dd03p-scrtext_l,
      JUL_pr TYPE dd03p-scrtext_l,
      AUG_pr TYPE dd03p-scrtext_l,
      SEP_pr TYPE dd03p-scrtext_l,
      OCT_pr TYPE dd03p-scrtext_l,
      NOV_pr TYPE dd03p-scrtext_l,
      DEC_pr TYPE dd03p-scrtext_l.

year = p_year + 1.

CONCATENATE 'Units Pur JAN'  year INTO JAN_un SEPARATED BY '/'.
CONCATENATE 'Units Pur FEB'  year INTO FEB_un SEPARATED BY '/'.
CONCATENATE 'Units Pur MAR'  year INTO MAR_un SEPARATED BY '/'.
CONCATENATE 'Units Pur APR'  p_year INTO APR_un SEPARATED BY '/'.
CONCATENATE 'Units Pur MAY'  p_year INTO MAY_un SEPARATED BY '/'.
CONCATENATE 'Units Pur JUN'  p_year INTO JUN_un SEPARATED BY '/'.
CONCATENATE 'Units Pur JUL'  p_year INTO JUL_un SEPARATED BY '/'.
CONCATENATE 'Units Pur AUG'  p_year INTO AUG_un SEPARATED BY '/'.
CONCATENATE 'Units Pur SEP'  p_year INTO SEP_un SEPARATED BY '/'.
CONCATENATE 'Units Pur OCT'  p_year INTO OCT_un SEPARATED BY '/'.
CONCATENATE 'Units Pur NOV'  p_year INTO NOV_un SEPARATED BY '/'.
CONCATENATE 'Units Pur DEC'  p_year INTO DEC_un SEPARATED BY '/'.

*JAN_un = 'Units Pur JAN'.
*FEB_un = 'Units Pur FEB'.
*MAR_un = 'Units Pur MAR'.
*APR_un = 'Units Pur APR'.
*MAY_un = 'Units Pur MAY'.
*JUN_un = 'Units Pur JUN'.
*JUL_un = 'Units Pur JUL'.
*AUG_un = 'Units Pur AUG'.
*SEP_un = 'Units Pur SEP'.
*OCT_un = 'Units Pur OCT'.
*NOV_un = 'Units Pur NOV'.
*DEC_un = 'Units Pur DEC'.
*
*JAN_pr = 'Units Price JAN'.
*FEB_pr = 'Units Price FEB'.
*MAR_pr = 'Units Price MAR'.
*APR_pr = 'Units Price APR'.
*MAY_pr = 'Units Price MAY'.
*JUN_pr = 'Units Price JUN'.
*JUL_pr = 'Units Price JUL'.
*AUG_pr = 'Units Price AUG'.
*SEP_pr = 'Units Price SEP'.
*OCT_pr = 'Units Price OCT'.
*NOV_pr = 'Units Price NOV'.
*DEC_pr = 'Units Price DEC'.

CONCATENATE 'Units Price($) JAN'   year INTO JAN_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) FEB'   year INTO FEB_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) MAR'   year INTO MAR_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) APR'   p_year INTO APR_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) MAY'   p_year INTO MAY_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) JUN'   p_year INTO JUN_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) JUL'   p_year INTO JUL_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) AUG'   p_year INTO AUG_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) SEP'   p_year INTO SEP_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) OCT'   p_year INTO OCT_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) NOV'   p_year INTO NOV_pr SEPARATED BY '/'.
CONCATENATE 'Units Price($) DEC'   p_year INTO DEC_pr SEPARATED BY '/'.

START-OF-SELECTION.


DELETE s_werks WHERE low = 'PL03'.
DELETE s_werks WHERE high = 'PL03'.
PERFORM get_data.
PERFORM get_sort.
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

SELECT MBLNR
       zeile
       MJAHR
       BWART
       MATNR
       WERKS
       DMBTR
       MENGE
       GJAHR
       BUDAT_MKPF
       EBELN
       EBELP
       aufnr
       smbln FROM mseg INTO TABLE it_mseg
       WHERE matnr IN s_matnr
        AND  GJAHR = p_year
        AND  werks IN s_werks
        AND  bwart IN ( '101' ,'105' )
        AND  aufnr = ''.




IF it_mseg IS NOT INITIAL.

  SELECT matnr
         werks
         lgort
         labst FROM mard INTO TABLE lt_mard
         FOR ALL ENTRIES IN it_mseg
         WHERE matnr = it_mseg-matnr
          AND  werks = it_mseg-werks.

SORT lt_mard by matnr werks.
DELETE ADJACENT DUPLICATES FROM lt_mard COMPARING matnr werks.


SELECT MBLNR
       zeile
       MJAHR
       BWART
       MATNR
       WERKS
       DMBTR
       MENGE
       GJAHR
       BUDAT_MKPF
       EBELN
       EBELP
       aufnr
       smbln FROM mseg INTO TABLE it_rev
       FOR ALL ENTRIES IN it_mseg
       WHERE smbln = it_mseg-mblnr
        AND  zeile = it_mseg-zeile
        AND  matnr = it_mseg-matnr
        AND  bwart IN ( '102' ,'106' ).




  SELECT MATNR
         ERSDA
         MTART
         MATKL
         WRKST
         ZSERIES
         ZSIZE
         BRAND
         MOC
         TYPE FROM mara INTO TABLE it_mara
         FOR ALL ENTRIES IN it_mseg
         WHERE matnr = it_mseg-matnr.


  SELECT matnr
         maktx FROM makt INTO TABLE it_makt
         FOR ALL ENTRIES IN it_mseg
         WHERE matnr = it_mseg-matnr.

  SELECT matnr
         werks
         lgort
         labst FROM mard INTO TABLE it_mard
         FOR ALL ENTRIES IN it_mseg
         WHERE matnr = it_mseg-matnr
          AND  werks = it_mseg-werks
          AND  NOT ( lgort = 'RJ' and lgort = 'SCR' ).


  SELECT matnr
         werks
         lblab FROM mslb INTO TABLE it_mslb
         FOR ALL ENTRIES IN it_mseg
         WHERE matnr = it_mseg-matnr
          AND  werks = it_mseg-werks.

  SELECT matnr
         werks
         kalab FROM mska INTO TABLE it_mska
         FOR ALL ENTRIES IN it_mseg
         WHERE matnr = it_mseg-matnr
          AND  werks = it_mseg-werks.


    SELECT matnr
           bwkey
           vprsv
           verpr
           stprs
           BKLAS FROM mbew INTO TABLE it_mbew
           FOR ALL ENTRIES IN it_mseg
           WHERE matnr = it_mseg-matnr
           AND  bwkey = it_mseg-werks.
*
*  SELECT EBELN
*         EBELP
*         matnr
*         werks
*         netpr FROM ekpo INTO TABLE it_ekpo
*         FOR ALL ENTRIES IN it_mseg
*         WHERE ebeln = it_mseg-ebeln
*          AND  ebelp = it_mseg-ebelp
*          AND matnr = it_mseg-matnr
*          AND  werks = it_mseg-werks.
*
*  SELECT EBELN
*         AEDAT FROM ekko INTO TABLE it_ekko
*         FOR ALL ENTRIES IN it_mseg
*         WHERE ebeln = it_mseg-ebeln.
*

ENDIF.

IF it_mara IS NOT INITIAL.

  SELECT EBELN
         EBELP
         matnr
         werks
         netpr
         menge
         loekz FROM ekpo INTO TABLE it_ekpo
         FOR ALL ENTRIES IN it_mara
         WHERE matnr = it_mara-matnr
          AND  werks IN s_werks
          AND  loekz NE 'L'.





ENDIF.

IF it_ekpo IS NOT INITIAL.

  SELECT MBLNR
         BWART
         MATNR
         WERKS
         MENGE
         EBELN
         EBELP
         aufnr
         SMBLN FROM mseg INTO TABLE lt_mseg
         FOR ALL ENTRIES IN it_ekpo
         WHERE ebeln = it_ekpo-ebeln
          AND  ebelp = it_ekpo-ebelp
          AND  matnr = it_ekpo-matnr
          AND  BWART IN ( '101' , '105' )
          AND  aufnr = ''.


  SELECT MBLNR
         BWART
         MATNR
         WERKS
         MENGE
         EBELN
         EBELP
         aufnr
         SMBLN FROM mseg INTO TABLE lt_mseg1
         FOR ALL ENTRIES IN it_ekpo
         WHERE ebeln = it_ekpo-ebeln
          AND  ebelp = it_ekpo-ebelp
          AND  matnr = it_ekpo-matnr
          AND  BWART IN ( '102' , '106' )
          AND  aufnr = ''.




ENDIF.


*LOOP AT it_mara INTO wa_mara.
LOOP AT lt_mard INTO ls_mard.

wa_final-werks  = ls_mard-werks.
READ TABLE it_mara INTO wa_mara WITH KEY matnr = ls_mard-matnr.

IF sy-subrc = 0.
 wa_final-matnr = wa_mara-matnr.
 wa_final-mtart = wa_mara-mtart.
 wa_final-matkl = wa_mara-matkl.
 wa_final-WRKST = wa_mara-WRKST.
 wa_final-ersda = wa_mara-ersda.
 wa_final-ZSERIES = wa_mara-ZSERIES.
 wa_final-ZSIZE   = wa_mara-ZSIZE  .
 wa_final-BRAND   = wa_mara-BRAND  .
 wa_final-MOC     = wa_mara-MOC    .
 wa_final-TYPE    = wa_mara-TYPE   .
ENDIF.
READ TABLE it_makt INTO wa_makt WITH KEY matnr = wa_mara-matnr.
 IF sy-subrc = 0.
   wa_final-maktx = wa_makt-maktx.

 ENDIF.

LOOP AT it_mseg INTO wa_mseg WHERE matnr = wa_mara-matnr AND werks = ls_mard-werks.
IF wa_mseg-aufnr IS INITIAL.
wa_final-MJAHR = wa_mseg-MJAHR.
CLEAR wa_rev.
READ TABLE it_rev INTO wa_rev WITH KEY smbln = wa_mseg-mblnr matnr = wa_mseg-matnr zeile = wa_mseg-zeile.
IF sy-subrc = 0.
  wa_mseg-menge = wa_mseg-menge - wa_rev-menge.
  wa_mseg-dmbtr = wa_mseg-dmbtr - wa_rev-dmbtr.
ENDIF.
date = wa_mseg-budat_mkpf+4(2).

IF date = '01'.
  wa_final-jan = wa_final-jan + wa_mseg-menge.
  wa_final-jan_pr = wa_final-jan_pr + wa_mseg-dmbtr.
ELSEIF date = '02'.
  wa_final-feb = wa_final-feb + wa_mseg-menge.
  wa_final-feb_pr = wa_final-feb_pr + wa_mseg-dmbtr.
ELSEIF date = '03'.
  wa_final-mar = wa_final-mar + wa_mseg-menge.
  wa_final-mar_pr = wa_final-mar_pr + wa_mseg-dmbtr.
ELSEIF date = '04'.
  wa_final-apr = wa_final-apr + wa_mseg-menge.
  wa_final-apr_pr = wa_final-apr_pr + wa_mseg-dmbtr.
ELSEIF date = '05'.
  wa_final-may = wa_final-may + wa_mseg-menge.
  wa_final-may_pr = wa_final-may_pr + wa_mseg-dmbtr.
ELSEIF date = '06'.
  wa_final-jun = wa_final-jun + wa_mseg-menge.
  wa_final-jun_pr = wa_final-jun_pr + wa_mseg-dmbtr.
ELSEIF date = '07'.
  wa_final-jul = wa_final-jul + wa_mseg-menge.
  wa_final-jul_pr = wa_final-jul_pr + wa_mseg-dmbtr.
ELSEIF date = '08'.
  wa_final-aug = wa_final-aug + wa_mseg-menge.
  wa_final-aug_pr = wa_final-aug_pr + wa_mseg-dmbtr.
ELSEIF date = '09'.
  wa_final-sep = wa_final-sep + wa_mseg-menge.
  wa_final-sep_pr = wa_final-sep_pr + wa_mseg-dmbtr.
ELSEIF date = '10'.
  wa_final-oct = wa_final-oct + wa_mseg-menge.
  wa_final-oct_pr = wa_final-oct_pr + wa_mseg-dmbtr.
ELSEIF date = '11'.
  wa_final-nov = wa_final-nov + wa_mseg-menge.
  wa_final-nov_pr = wa_final-nov_pr + wa_mseg-dmbtr.
ELSEIF date = '12'.
  wa_final-dec = wa_final-dec + wa_mseg-menge.
  wa_final-dec_pr = wa_final-dec_pr + wa_mseg-dmbtr.
ENDIF.
ENDIF.
ENDLOOP.

LOOP AT it_ekpo INTO wa_ekpo WHERE matnr = wa_mara-matnr .

 wa_final-po_qty = wa_final-po_qty + wa_ekpo-menge.

ENDLOOP.

LOOP AT lt_mseg INTO ls_mseg WHERE  matnr = wa_ekpo-matnr AND werks = ls_mard-werks.
wa_final-gr_qty = wa_final-gr_qty + ls_mseg-menge.
READ TABLE lt_mseg1 INTO ls_mseg1 WITH KEY smbln = ls_mseg-mblnr matnr = ls_mseg-matnr.
IF sy-subrc = 0.
wa_final-gr_qty = wa_final-gr_qty - ls_mseg1-menge.

ENDIF.

ENDLOOP.


   wa_final-sale_tot =   wa_final-jan + wa_final-feb + wa_final-mar + wa_final-apr + wa_final-may + wa_final-jun +
                         wa_final-jul + wa_final-aug + wa_final-sep + wa_final-oct + wa_final-nov + wa_final-dec      .

 wa_final-pri_tot =    wa_final-jan_pr + wa_final-feb_pr + wa_final-mar_pr + wa_final-apr_pr + wa_final-may_pr +
                       wa_final-jun_pr + wa_final-jul_pr + wa_final-aug_pr + wa_final-sep_pr + wa_final-oct_pr +
                       wa_final-nov_pr + wa_final-dec_pr.


LOOP AT it_mard INTO wa_mard WHERE matnr = wa_mara-matnr AND werks = ls_mard-werks.

wa_final-labst = wa_final-labst + wa_mard-labst.
ENDLOOP.

LOOP AT it_mska INTO wa_mska WHERE matnr = wa_mara-matnr AND werks = ls_mard-werks.
wa_final-kalab = wa_final-kalab + wa_mska-kalab.
ENDLOOP.

wa_final-on_hand = wa_final-labst + wa_final-kalab.
wa_final-on_ord = wa_final-po_qty - wa_final-gr_qty.

READ TABLE it_mbew INTO wa_mbew WITH KEY matnr = wa_mara-matnr bwkey = ls_mard-werks.
    IF  sy-subrc = 0.
      wa_final-BKLAS = wa_mbew-BKLAS.
      IF wa_mbew-vprsv = 'S'.
        wa_final-price = wa_mbew-stprs.
      ELSEIF wa_mbew-vprsv = 'V'..
        wa_final-price = wa_mbew-verpr.

      ENDIF.

    ENDIF.




APPEND wa_final TO it_final.
clear:wa_final,date,pur_dat.
ENDLOOP.

data: jan TYPE char100.

CONCATENATE 'Units Pur JAN' wa_final-MJAHR INTO jan SEPARATED BY '/'."'Units Pur 31/JAN'

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  GET_SORT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_SORT .
LOOP AT it_mara INTO wa_mara.

  LOOP AT it_final INTO wa_final WHERE matnr = wa_mara-matnr.
    wa_sort-matnr    =   wa_final-matnr .
    wa_sort-mtart    =   wa_final-mtart  .
    wa_sort-matkl    =   wa_final-matkl  .
    wa_sort-WRKST    =   wa_final-WRKST  .
    wa_sort-ersda    =   wa_final-ersda  .
    wa_sort-ZSERIES  =   wa_final-ZSERIES .
    wa_sort-ZSIZE    =   wa_final-ZSIZE   .
    wa_sort-BRAND    =   wa_final-BRAND   .
    wa_sort-MOC      =   wa_final-MOC     .
    wa_sort-TYPE     =   wa_final-TYPE    .


    wa_sort-maktx = wa_final-maktx .

    wa_sort-MJAHR = wa_final-MJAHR.

    wa_sort-jan     = wa_sort-jan + wa_final-jan.
     wa_sort-jan_pr  = wa_sort-jan_pr + wa_final-jan_pr.

     wa_sort-feb     = wa_sort-feb + wa_final-feb.
     wa_sort-feb_pr  = wa_sort-feb_pr + wa_final-feb_pr.

     wa_sort-mar     = wa_sort-mar  + wa_final-mar   .
     wa_sort-mar_pr  = wa_sort-mar_pr + wa_final-mar_pr.

     wa_sort-apr     = wa_sort-apr   + wa_final-apr   .
     wa_sort-apr_pr  = wa_sort-apr_pr + wa_final-apr_pr.

     wa_sort-may     = wa_sort-may  + wa_final-may   .
     wa_sort-may_pr  = wa_sort-may_pr + wa_final-may_pr.

     wa_sort-jun     = wa_sort-jun +  wa_final-jun   .
     wa_sort-jun_pr  = wa_sort-jun_pr + wa_final-jun_pr.

     wa_sort-jul     = wa_sort-jul +  wa_final-jul   .
     wa_sort-jul_pr  = wa_sort-jul_pr + wa_final-jul_pr.

     wa_sort-aug     = wa_sort-aug +  wa_final-aug   .
     wa_sort-aug_pr  = wa_sort-aug_pr + wa_final-aug_pr.

     wa_sort-sep     = wa_sort-sep +  wa_final-sep   .
     wa_sort-sep_pr  = wa_sort-sep_pr + wa_final-sep_pr.

     wa_sort-oct     = wa_sort-oct +  wa_final-oct   .
     wa_sort-oct_pr  = wa_sort-oct_pr + wa_final-oct_pr.

     wa_sort-nov     = wa_sort-nov +  wa_final-nov   .
     wa_sort-nov_pr  = wa_sort-nov_pr + wa_final-nov_pr.

     wa_sort-dec     = wa_sort-dec +  wa_final-dec   .
     wa_sort-dec_pr  = wa_sort-dec_pr + wa_final-dec_pr.

     wa_sort-po_qty = wa_sort-po_qty + wa_final-po_qty .

     wa_sort-gr_qty = wa_sort-gr_qty + wa_final-gr_qty.

     wa_sort-sale_tot = wa_sort-sale_tot + wa_final-sale_tot.

     wa_sort-pri_tot = wa_sort-pri_tot + wa_final-pri_tot.

     wa_sort-labst = wa_sort-labst + wa_final-labst.

     wa_sort-kalab = wa_sort-kalab + wa_final-kalab.

     wa_sort-on_hand = wa_sort-on_hand + wa_final-on_hand.
     wa_sort-on_ord  = wa_sort-on_ord  + wa_final-on_ord .

     wa_sort-BKLAS = wa_final-BKLAS.
     wa_sort-price = wa_sort-price + wa_final-price.




  ENDLOOP.
  DATA : LINE TYPE I.
    CLEAR LINE .
  REFRESH LT_MBEW.

   SELECT matnr
           bwkey
           vprsv
           verpr
           stprs
           BKLAS FROM mbew INTO TABLE lt_mbew
           WHERE matnr = wa_mara-matnr
           AND  bwkey IN s_werks.

  DESCRIBE TABLE LT_MBEW LINES LINE.
   IF LINE = 2.
      wa_sort-price =  wa_sort-price / 2.
    ELSEIF LINE = 1.
      wa_sort-price =  wa_sort-price / 1.
    ENDIF.
 APPEND wa_sort TO it_sort.
 CLEAR wa_sort.
ENDLOOP.

IF p_down = 'X'.
 LOOP AT it_sort INTO wa_sort.
   wa_down-MATNR     = wa_sort-MATNR    .
   wa_down-WRKST     = wa_sort-WRKST    .
   wa_down-BKLAS     = wa_sort-BKLAS    .
   wa_down-maktx     = wa_sort-maktx    .
   wa_down-MTART     = wa_sort-MTART    .
   wa_down-MATKL     = wa_sort-MATKL    .
   wa_down-ERSDA     = wa_sort-ERSDA    .
*   wa_down-werks     = wa_sort-werks    .

  CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
      EXPORTING
        input  = wa_sort-ERSDA
      IMPORTING
        output = wa_down-ERSDA.

    CONCATENATE wa_down-ERSDA+0(2) wa_down-ERSDA+2(3) wa_down-ERSDA+5(4)
                    INTO wa_down-ERSDA SEPARATED BY '-'.


   wa_down-ref = sy-datum.


    CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
      EXPORTING
        input  = wa_down-ref
      IMPORTING
        output = wa_down-ref.

    CONCATENATE wa_down-ref+0(2) wa_down-ref+2(3) wa_down-ref+5(4)
                    INTO wa_down-ref SEPARATED BY '-'.



   wa_down-ZSERIES   = wa_sort-ZSERIES  .
   wa_down-ZSIZE     = wa_sort-ZSIZE    .
   wa_down-BRAND     = wa_sort-BRAND    .
   wa_down-MOC       = wa_sort-MOC      .
   wa_down-TYPE      = wa_sort-TYPE     .
   wa_down-jan       = wa_sort-jan      .
   wa_down-feb       = wa_sort-feb      .
   wa_down-mar       = wa_sort-mar      .
   wa_down-apr       = wa_sort-apr      .
   wa_down-may       = wa_sort-may      .
   wa_down-jun       = wa_sort-jun      .
   wa_down-jul       = wa_sort-jul      .
   wa_down-aug       = wa_sort-aug      .
   wa_down-sep       = wa_sort-sep      .
   wa_down-oct       = wa_sort-oct      .
   wa_down-nov       = wa_sort-nov      .
   wa_down-dec       = wa_sort-dec      .
*   wa_down-on_ord    = wa_sort-on_ord   .
*   wa_down-on_hand   = wa_sort-on_hand  .
*   wa_down-labst     = wa_sort-labst    .
*   wa_down-jan_pr    = wa_sort-jan_pr   .
    wa_down-jan_pr       = abs( wa_sort-jan_pr )  .
 IF wa_sort-jan_pr < 0.
    CONDENSE wa_down-jan_pr.
    CONCATENATE '-' wa_down-jan_pr INTO wa_down-jan_pr.
 ENDIF.


   wa_down-feb_pr       =  abs( wa_sort-feb_pr )      .
 IF wa_sort-feb_pr < 0.
    CONDENSE wa_down-feb_pr.
    CONCATENATE '-' wa_down-feb_pr INTO wa_down-feb_pr.
 ENDIF.

 wa_down-mar_pr       =  abs( wa_sort-mar_pr )      .
 IF wa_sort-mar_pr < 0.
    CONDENSE wa_down-mar_pr.
    CONCATENATE '-' wa_down-mar_pr INTO wa_down-mar_pr.
 ENDIF.

 wa_down-apr_pr       =  abs( wa_sort-apr_pr ).
 IF wa_sort-apr_pr < 0.
    CONDENSE wa_down-apr_pr.
    CONCATENATE '-' wa_down-apr_pr INTO wa_down-apr_pr.
 ENDIF.

 wa_down-may_pr       =  abs( wa_sort-may_pr ).
 IF wa_sort-may_pr < 0.
    CONDENSE wa_down-may_pr.
    CONCATENATE '-' wa_down-may_pr INTO wa_down-may_pr.
 ENDIF.

 wa_down-jun_pr       =  abs( wa_sort-jun_pr ).
 IF wa_sort-jun_pr < 0.
    CONDENSE wa_down-jun_pr.
    CONCATENATE '-' wa_down-jun_pr INTO wa_down-jun_pr.
 ENDIF.

 wa_down-jul_pr       = abs( wa_sort-jul_pr ).
 IF wa_sort-jul_pr < 0.
    CONDENSE wa_down-jul_pr.
    CONCATENATE '-' wa_down-jul_pr INTO wa_down-jul_pr.
 ENDIF.

 wa_down-aug_pr       =  abs( wa_sort-aug_pr ).
 IF wa_sort-aug_pr < 0.
    CONDENSE wa_down-aug_pr.
    CONCATENATE '-' wa_down-aug_pr INTO wa_down-aug_pr.
 ENDIF.

 wa_down-sep_pr       =  abs( wa_sort-sep_pr ).
 IF wa_sort-sep_pr < 0.
    CONDENSE wa_down-sep_pr.
    CONCATENATE '-' wa_down-sep_pr INTO wa_down-sep_pr.
 ENDIF.

 wa_down-oct_pr       =  abs( wa_sort-oct_pr ).
 IF wa_sort-oct_pr < 0.
    CONDENSE wa_down-oct_pr.
    CONCATENATE '-' wa_down-oct_pr INTO wa_down-oct_pr.
 ENDIF.

 wa_down-nov_pr       =  abs( wa_sort-nov_pr ).
 IF wa_sort-nov_pr < 0.
    CONDENSE wa_down-nov_pr.
    CONCATENATE '-' wa_down-nov_pr INTO wa_down-nov_pr.
 ENDIF.

 wa_down-dec_pr       =  abs( wa_sort-dec_pr ).
 IF wa_sort-dec_pr < 0.
    CONDENSE wa_down-dec_pr.
    CONCATENATE '-' wa_down-dec_pr INTO wa_down-dec_pr.
 ENDIF.

   wa_down-price     = wa_sort-price    .
   wa_down-sale_tot     =  wa_sort-sale_tot     .

 wa_down-pri_tot      =  abs( wa_sort-pri_tot ).
 IF wa_sort-pri_tot < 0.
    CONDENSE wa_down-pri_tot.
    CONCATENATE '-' wa_down-pri_tot INTO wa_down-pri_tot.
 ENDIF.




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
PERFORM fcat USING : "mara table.
                       '1'  'MATNR'         'IT_FINAL'  'Material.No.'                                     '18' ,
                       '2'  'WRKST'         'IT_FINAL'  'USA Code'                                     '18' ,
                       '3'  'BKLAS'         'IT_FINAL'  'Valuation Class'                                     '18' ,
                       '4'  'MAKTX'         'IT_FINAL'  'Material Desc'                                    '18',
                       '5'  'MTART'         'IT_FINAL'  'Material Type'                                    '18',
                       '6'  'MATKL'         'IT_FINAL'  'Material Group'                                    '18',
                       '7'  'ERSDA'         'IT_FINAL'  'Creation Date'                                    '18',
                       '8'  'ZSERIES'         'IT_FINAL'  'Series'                                    '18',
                       '9'  'ZSIZE  '         'IT_FINAL'  'Size'                                    '18',
                      '10'  'BRAND  '         'IT_FINAL'  'Brand'                                    '18',
                      '11'  'MOC    '         'IT_FINAL'  'MOC'                                    '18',
                      '12'  'TYPE   '         'IT_FINAL'  'Type'                                    '18',
*                       IF WA_FINAL-JAN IS NOT INITIAL.

*                       ENDIF.
                      '13'  'APR'           'IT_FINAL'  APR_un   '18',                     "  'Units Pur 30/APR'
                      '14'  'MAY'           'IT_FINAL'  MAY_un   '18',                     " 'Units Pur 31/MAY'
                      '15'  'JUN'           'IT_FINAL'  JUN_un   '18',                     " 'Units Pur 30/JUN'
                      '16'  'JUL'           'IT_FINAL'  JUL_un   '18',                     " 'Units Pur 31/JUL'
                      '17'  'AUG'           'IT_FINAL'  AUG_un   '18',                     " 'Units Pur 31/AUG'
                      '18'  'SEP'           'IT_FINAL'  SEP_un   '18',                     " 'Units Pur 30/SEP'
                      '19'  'OCT'           'IT_FINAL'  OCT_un   '18',                     " 'Units Pur 31/OCT'
                      '20'  'NOV'           'IT_FINAL'  NOV_un   '18',                     " 'Units Pur 30/NOV'
                      '21'  'DEC'           'IT_FINAL'  DEC_un   '18',                     " 'Units Pur 31/DEC'
                      '22'  'JAN'           'IT_FINAL'  JAN_un   '18',                     "  'Units Pur 31/JAN'
                      '23'  'FEB'           'IT_FINAL'  FEB_un   '18',                     "   'Units Pur 28/FEB'
                      '24'  'MAR'           'IT_FINAL'  MAR_un   '18',                     " 'Units Pur 31/MAR'
                      '25'  'SALE_TOT'      'IT_FINAL'  'Total Unit'     '18',
*                      '25'  'ON_ORD'        'IT_FINAL'  'On Order Stock'                                   '18',
*                      '26'  'ON_HAND'       'IT_FINAL'  'On Hand Qty'                                      '18',
*                      '27'  'LABST'         'IT_FINAL'  'Qty Available'                                      '18',

                      '26'  'APR_PR'           'IT_FINAL'  APR_pr     '18',                 "'Units Price 30/APR'
                      '27'  'MAY_PR'           'IT_FINAL'  MAY_pr     '18',                 "'Units Price 31/MAY'
                      '28'  'JUN_PR'           'IT_FINAL'  JUN_pr     '18',                 "'Units Price 30/JUN'
                      '29'  'JUL_PR'           'IT_FINAL'  JUL_pr     '18',                 "'Units Price 31/JUL'
                      '30'  'AUG_PR'           'IT_FINAL'  AUG_pr     '18',                 "'Units Price 31/AUG'
                      '31'  'SEP_PR'           'IT_FINAL'  SEP_pr     '18',                 "'Units Price 30/SEP'
                      '32'  'OCT_PR'           'IT_FINAL'  OCT_pr     '18',                 "'Units Price 31/OCT'
                      '33'  'NOV_PR'           'IT_FINAL'  NOV_pr     '18',                 "'Units Price 30/NOV'
                      '34'  'DEC_PR'           'IT_FINAL'  DEC_pr     '18',                 "'Units Price 31/DEC'
                      '35'  'JAN_PR'           'IT_FINAL'  JAN_pr     '18',                 "'Units Price 31/JAN'
                      '36'  'FEB_PR'           'IT_FINAL'  FEB_pr     '18',                 "'Units Price 28/FEB'
                      '37'  'MAR_PR'           'IT_FINAL'  MAR_pr     '18',                 "'Units Price 31/MAR'
                      '38'  'PRI_TOT'          'IT_FINAL'  'Total Price'     '18',
                      '39'  'PRICE'            'IT_FINAL' 'Price'     '18'.
*                      '40'  'WERKS'            'IT_FINAL' 'Plant'     '18'.


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
      t_outtab           = it_sort
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
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0518   text
*      -->P_0519   text
*      -->P_0520   text
*      -->P_0521   text
*      -->P_0522   text
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


  CONCATENATE  year 'To' p_year INTO period SEPARATED BY space.
 CONDENSE period.

*  Title
  wa_header-typ  = 'H'.
  wa_header-info = 'Purchase Item Master '.
  APPEND wa_header TO t_header.
  CLEAR wa_header.

  wa_header-typ  = 'S'.
  wa_header-key  = 'Purchase Period :'  .
  wa_header-info =  period.  "'Sales Item Master'.
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


    lv_file = 'ZUS_ITEM_PURCHASE1.TXT'.


  CONCATENATE p_folder '/' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUS_ITEM_PURCHASE REPORT started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1285 TYPE string.
DATA lv_crlf_1285 TYPE string.
lv_crlf_1285 = cl_abap_char_utilities=>cr_lf.
lv_string_1285 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1285 lv_crlf_1285 wa_csv INTO lv_string_1285.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_1323 TO lv_fullfile.
TRANSFER lv_string_1285 TO lv_fullfile.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.

****************************************SQL UPLOAD FILE******************
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


    lv_file = 'ZUS_ITEM_PURCHASE1.TXT'.


  CONCATENATE p_folder '/' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUS_ITEM_PURCHASE REPORT started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1323 TYPE string.
DATA lv_crlf_1323 TYPE string.
lv_crlf_1323 = cl_abap_char_utilities=>cr_lf.
lv_string_1323 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1323 lv_crlf_1323 wa_csv INTO lv_string_1323.
  CLEAR: wa_csv.
ENDLOOP.
TRANSFER lv_string_1323 TO lv_fullfile.
TRANSFER lv_string_1323 TO lv_fullfile.
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
CONCATENATE 'Material.No.'
            'USA Code'
            'Valuation Class'
            'Material Desc'
            'Material Type'
            'Material Group'
            'Creation Date'
            'Series'
            'Size'
            'Brand'
            'MOC'
            'Type'
            JAN_un
            FEB_un
            MAR_un
            APR_un
            MAY_un
            JUN_un
            JUL_un
            AUG_un
            SEP_un
            OCT_un
            NOV_un
            DEC_un
*            'On Order Stock'
*            'On Hand Qty'
*            'Qty Available'
            JAN_pr
            FEB_pr
            MAR_pr
            APR_pr
            MAY_pr
            JUN_pr
            JUL_pr
            AUG_pr
            SEP_pr
            OCT_pr
            NOV_pr
            DEC_pr
           'Price'
           'Refresh File Date'
           'Total Unit'
           'Total Price'
*           'Plant'
              INTO pd_csv
              SEPARATED BY l_field_seperator.


ENDFORM.

*&---------------------------------------------------------------------*
*& Report ZUS_ITEM_MASTER_SALES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zus_item_sales_new.


TABLES: vbrk,vbrp.

TYPES: BEGIN OF ty_vbrk_rp,
         vbeln    TYPE vbrk-vbeln,
         POSNR_I  TYPE vbrp-posnr,
         FKART    TYPE vbrk-FKART,
         VKORG    TYPE vbrk-VKORG,
         KALSM    TYPE vbrk-KALSM,
         FKDAT    TYPE vbrk-FKDAT,
         FKIMG_I  TYPE vbrp-FKIMG,
         MATNR_I  TYPE vbrp-MATNR,
         WERKS_I  TYPE vbrp-WERKS,
         SFAKN    TYPE vbrk-SFAKN,
       END OF ty_vbrk_rp,

       BEGIN OF ty_bseg,
         bukrs TYPE bseg-bukrs,
         belnr TYPE bseg-belnr,
         gjahr TYPE bseg-gjahr,
         buzei TYPE bseg-buzei,
         shkzg TYPE bseg-shkzg,
         dmbtr TYPE bseg-dmbtr,
         matnr TYPE bseg-matnr,
         werks TYPE bseg-werks,
         menge TYPE bseg-menge,
         kstar TYPE bseg-kstar,
       END OF ty_bseg,

       BEGIN OF ty_bkpf,
         bukrs TYPE bkpf-bukrs,
         belnr TYPE bkpf-belnr,
         gjahr TYPE bkpf-gjahr,
         blart TYPE bkpf-blart,
         monat TYPE bkpf-monat,
         stblg TYPE bkpf-stblg,
         AWKEY TYPE bkpf-AWKEY,
       END OF ty_bkpf,



       BEGIN OF ty_mara,
         matnr   TYPE mara-matnr,
         mtart   TYPE mara-mtart,
         matkl   TYPE mara-matkl,
         wrkst   TYPE mara-wrkst,
         ersda   TYPE mara-ersda,
         zseries TYPE mara-zseries,
         zsize   TYPE mara-zsize,
         brand   TYPE mara-brand,
         moc     TYPE mara-moc,
         type    TYPE mara-type,

       END OF ty_mara,

       BEGIN OF ty_makt,
         matnr TYPE makt-matnr,
         maktx TYPE makt-maktx,
       END OF ty_makt,

       BEGIN OF ty_mard,
         matnr TYPE mard-matnr,
         werks TYPE mard-werks,
         labst TYPE mard-labst,
       END OF ty_mard,

       BEGIN OF ty_mbew,
        matnr TYPE mbew-matnr,
        BWKEY TYPE mbew-BWKEY,
        BKLAS TYPE mbew-BKLAS,
       END OF ty_mbew,

       BEGIN OF ty_konv,
         knumv TYPE prcd_elements-knumv,
         kposn TYPE prcd_elements-kposn,
         kschl TYPE prcd_elements-kschl,
         kawrt TYPE prcd_elements-kawrt,
         kwert TYPE prcd_elements-kwert,
       END OF ty_konv,


       BEGIN OF ty_vbap,
         vbeln  TYPE vbap-vbeln,
         posnr  TYPE vbap-posnr,
         matnr  TYPE vbap-matnr,
         werks  TYPE vbap-werks,
         kwmeng TYPE vbap-kwmeng,
       END OF ty_vbap,

       BEGIN OF ty_vbup,
         vbeln TYPE vbup-vbeln,
         posnr TYPE vbup-posnr,
         lfgsa TYPE vbup-lfgsa,
       END OF ty_vbup,

       BEGIN OF ty_lips,
         vgbel TYPE lips-vgbel,
         vgpos TYPE lips-vgpos,
         lfimg TYPE lips-lfimg,
       END OF ty_lips,

       BEGIN OF ty_final,
         matnr    TYPE vbrp-matnr,
         werks    TYPE vbrp-werks,
         mtart    TYPE mara-mtart,
         matkl    TYPE mara-matkl,
         wrkst    TYPE mara-wrkst,
         ersda    TYPE mara-ersda,
         zseries  TYPE mara-zseries,
         zsize    TYPE mara-zsize,
         brand    TYPE mara-brand,
         moc      TYPE mara-moc,
         type     TYPE mara-type,
         BKLAS    TYPE mbew-BKLAS,
         maktx    TYPE makt-maktx,
         jan      TYPE vbrp-fkimg,
         feb      TYPE vbrp-fkimg,
         mar      TYPE vbrp-fkimg,
         apr      TYPE vbrp-fkimg,
         may      TYPE vbrp-fkimg,
         jun      TYPE vbrp-fkimg,
         jul      TYPE vbrp-fkimg,
         aug      TYPE vbrp-fkimg,
         sep      TYPE vbrp-fkimg,
         oct      TYPE vbrp-fkimg,
         nov      TYPE vbrp-fkimg,
         dec      TYPE vbrp-fkimg,
         jan_pr   TYPE vbrp-netwr,
         feb_pr   TYPE vbrp-netwr,
         mar_pr   TYPE vbrp-netwr,
         apr_pr   TYPE vbrp-netwr,
         may_pr   TYPE vbrp-netwr,
         jun_pr   TYPE vbrp-netwr,
         jul_pr   TYPE vbrp-netwr,
         aug_pr   TYPE vbrp-netwr,
         sep_pr   TYPE vbrp-netwr,
         oct_pr   TYPE vbrp-netwr,
         nov_pr   TYPE vbrp-netwr,
         dec_pr   TYPE vbrp-netwr,
         vbap_qty TYPE vbrp-fkimg,
         lips_qty TYPE vbrp-fkimg,
         open_qty TYPE vbrp-fkimg,
         un_qty   TYPE mard-labst,
         sale_tot TYPE vbrp-fkimg,
         pri_tot  TYPE vbrp-netwr,
       END OF ty_final,

       BEGIN OF ty_str,
         matnr    TYPE vbrp-matnr,
         wrkst    TYPE mara-wrkst,
         maktx    TYPE makt-maktx,
         mtart    TYPE mara-mtart,
         matkl    TYPE mara-matkl,
         ersda    TYPE char15,
         BKLAS    TYPE mbew-BKLAS,
         zseries  TYPE mara-zseries,
         zsize    TYPE mara-zsize,
         brand    TYPE mara-brand,
         moc      TYPE mara-moc,
         type     TYPE mara-type,
         apr      TYPE char15,
         may      TYPE char15,
         jun      TYPE char15,
         jul      TYPE char15,
         aug      TYPE char15,
         sep      TYPE char15,
         oct      TYPE char15,
         nov      TYPE char15,
         dec      TYPE char15,
         jan      TYPE char15,
         feb      TYPE char15,
         mar      TYPE char15,
         sale_tot TYPE char15,
*         open_qty TYPE char15,
*         un_qty   TYPE char15,
         apr_pr   TYPE char15,
         may_pr   TYPE char15,
         jun_pr   TYPE char15,
         jul_pr   TYPE char15,
         aug_pr   TYPE char15,
         sep_pr   TYPE char15,
         oct_pr   TYPE char15,
         nov_pr   TYPE char15,
         dec_pr   TYPE char15,
         jan_pr   TYPE char15,
         feb_pr   TYPE char15,
         mar_pr   TYPE char15,
         pri_tot  TYPE char15,
*         werks    TYPE char10,
         ref      TYPE char15,
       END OF ty_str.



DATA : it_down TYPE TABLE OF ty_str,
       wa_down TYPE          ty_str.



DATA:it_vbrk_rp TYPE TABLE OF ty_vbrk_rp,
     wa_vbrk_rp TYPE          ty_vbrk_rp,

     it_cancel TYPE TABLE OF ty_vbrk_rp,
     wa_cancel TYPE          ty_vbrk_rp,

     it_bseg    TYPE TABLE OF ty_bseg,
     wa_bseg    TYPE          ty_bseg,

     it_bkpf    TYPE TABLE OF ty_bkpf,
     wa_bkpf    TYPE          ty_bkpf,

     lt_bkpf    TYPE TABLE OF ty_bkpf,
     ls_bkpf    TYPE          ty_bkpf,

     it_mara    TYPE TABLE OF ty_mara,
     wa_mara    TYPE          ty_mara,

     it_mbew    TYPE TABLE OF ty_mbew,
     wa_mbew    TYPE          ty_mbew,

     it_mard    TYPE TABLE OF ty_mard,
     wa_mard    TYPE          ty_mard,

     lt_mard    TYPE TABLE OF ty_mard,
     ls_mard    TYPE          ty_mard,

     it_makt    TYPE TABLE OF ty_makt,
     wa_makt    TYPE          ty_makt,

     it_vbap    TYPE TABLE OF ty_vbap,
     wa_vbap    TYPE          ty_vbap,

     it_konv    TYPE TABLE OF ty_konv,
     wa_konv    TYPE          ty_konv,

     it_vbup    TYPE TABLE OF ty_vbup,
     wa_vbup    TYPE          ty_vbup,

     it_lips    TYPE TABLE OF ty_lips,
     wa_lips    TYPE          ty_lips,

     it_final   TYPE TABLE OF ty_final,
     wa_final   TYPE          ty_final,

     it_sort   TYPE TABLE OF ty_final,
     wa_sort   TYPE          ty_final.



DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat LIKE LINE OF it_fcat.
DATA   fs_layout TYPE slis_layout_alv.

DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt TYPE tline,
      ls_mattxt TYPE tline.

DATA: low  TYPE fkdat,
      high TYPE fkdat,
      date TYPE int4,
      year TYPE char4.


SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS:s_matnr FOR vbrp-matnr,
*                 s_budat FOR mseg-BUDAT_MKPF.
               s_werks FOR vbrp-werks OBLIGATORY DEFAULT 'US01'.
PARAMETERS    :
               p_year  TYPE vbrk-gjahr OBLIGATORY DEFAULT '2018'.

SELECTION-SCREEN:END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT '/Delval/USA'."USA'."usa'.  "'E:\delval\usa'.
SELECTION-SCREEN END OF BLOCK b2.


START-OF-SELECTION.

  CONCATENATE p_year '0101' INTO low.
  CONCATENATE p_year '1231' INTO high.


  DATA : jan_un TYPE dd03p-scrtext_l,
         feb_un TYPE dd03p-scrtext_l,
         mar_un TYPE dd03p-scrtext_l,
         apr_un TYPE dd03p-scrtext_l,
         may_un TYPE dd03p-scrtext_l,
         jun_un TYPE dd03p-scrtext_l,
         jul_un TYPE dd03p-scrtext_l,
         aug_un TYPE dd03p-scrtext_l,
         sep_un TYPE dd03p-scrtext_l,
         oct_un TYPE dd03p-scrtext_l,
         nov_un TYPE dd03p-scrtext_l,
         dec_un TYPE dd03p-scrtext_l.

  DATA :jan_pr TYPE dd03p-scrtext_l,
        feb_pr TYPE dd03p-scrtext_l,
        mar_pr TYPE dd03p-scrtext_l,
        apr_pr TYPE dd03p-scrtext_l,
        may_pr TYPE dd03p-scrtext_l,
        jun_pr TYPE dd03p-scrtext_l,
        jul_pr TYPE dd03p-scrtext_l,
        aug_pr TYPE dd03p-scrtext_l,
        sep_pr TYPE dd03p-scrtext_l,
        oct_pr TYPE dd03p-scrtext_l,
        nov_pr TYPE dd03p-scrtext_l,
        dec_pr TYPE dd03p-scrtext_l.

  year = p_year + 1.
  CONCATENATE 'Units Sold JAN'  year INTO jan_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold FEB'  year INTO feb_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold MAR'  year INTO mar_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold APR'  p_year INTO apr_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold MAY'  p_year INTO may_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold JUN'  p_year INTO jun_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold JUL'  p_year INTO jul_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold AUG'  p_year INTO aug_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold SEP'  p_year INTO sep_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold OCT'  p_year INTO oct_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold NOV'  p_year INTO nov_un SEPARATED BY '/'.
  CONCATENATE 'Units Sold DEC'  p_year INTO dec_un SEPARATED BY '/'.

*  jan_un = 'Units Sold JAN'.
*  feb_un = 'Units Sold FEB'.
*  mar_un = 'Units Sold MAR'.
*  apr_un = 'Units Sold APR'.
*  may_un = 'Units Sold MAY'.
*  jun_un = 'Units Sold JUN'.
*  jul_un = 'Units Sold JUL'.
*  aug_un = 'Units Sold AUG'.
*  sep_un = 'Units Sold SEP'.
*  oct_un = 'Units Sold OCT'.
*  nov_un = 'Units Sold NOV'.
*  dec_un = 'Units Sold DEC'.
*
*  jan_pr = 'Sales Price($) JAN'.
*  feb_pr = 'Sales Price($) FEB'.
*  mar_pr = 'Sales Price($) MAR'.
*  apr_pr = 'Sales Price($) APR'.
*  may_pr = 'Sales Price($) MAY'.
*  jun_pr = 'Sales Price($) JUN'.
*  jul_pr = 'Sales Price($) JUL'.
*  aug_pr = 'Sales Price($) AUG'.
*  sep_pr = 'Sales Price($) SEP'.
*  oct_pr = 'Sales Price($) OCT'.
*  nov_pr = 'Sales Price($) NOV'.
*  dec_pr = 'Sales Price($) DEC'.







  CONCATENATE 'Sales Price($) JAN'   year INTO jan_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) FEB'   year INTO feb_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) MAR'   year INTO mar_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) APR'   p_year INTO apr_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) MAY'   p_year INTO may_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) JUN'   p_year INTO jun_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) JUL'   p_year INTO jul_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) AUG'   p_year INTO aug_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) SEP'   p_year INTO sep_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) OCT'   p_year INTO oct_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) NOV'   p_year INTO nov_pr SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) DEC'   p_year INTO dec_pr SEPARATED BY '/'.




DELETE s_werks WHERE low = 'PL01'.
DELETE s_werks WHERE high = 'PL01'.
  PERFORM get_data.
  PERFORM SORT_DATA.
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


  SELECT bukrs
         belnr
         gjahr
         buzei
         shkzg
         dmbtr
         matnr
         werks
         menge
         kstar FROM bseg INTO TABLE it_bseg
         WHERE gjahr = p_year
           AND werks IN s_werks
           AND matnr IN s_matnr
           AND kstar IN ( '0000040000', '0000040010' )." , '0000040120' ).

DATA:fd TYPE vbrk-fkdat,
     td TYPE vbrk-fkdat,
     s_year  TYPE vbrk-gjahr.
BREAK primusabap.
s_year = p_year + 1.
CONCATENATE p_year '0401' INTO fd.
CONCATENATE s_year '0331' INTO td.


  SELECT vbeln
         POSNR_I
         FKART
         VKORG
         KALSM
         FKDAT
         FKIMG_I
         MATNR_I
         WERKS_I
         SFAKN  FROM WB2_V_VBRK_VBRP2 INTO TABLE it_vbrk_rp
         WHERE fkdat    BETWEEN fd AND td "p_year
           AND werks_i IN s_werks
           AND matnr_i IN s_matnr
           AND KALSM = 'UFOCSA'
           AND SFAKN = ' '.


IF it_vbrk_rp IS NOT INITIAL .
  SELECT vbeln
         POSNR_I
         FKART
         VKORG
         KALSM
         FKDAT
         FKIMG_I
         MATNR_I
         WERKS_I
         SFAKN  FROM WB2_V_VBRK_VBRP2 INTO TABLE it_cancel
         FOR ALL ENTRIES IN it_vbrk_rp
         WHERE sfakn = it_vbrk_rp-vbeln.

ENDIF.


*
*DELETE it_vbrk_rp WHERE fkart EQ 'US05'.
*DELETE it_vbrk_rp WHERE fkart EQ 'US03'.
*DELETE it_vbrk_rp WHERE fkart EQ 'US08'.

  IF it_bseg IS NOT INITIAL.

    SELECT matnr
           werks
           labst FROM mard INTO TABLE lt_mard
           FOR ALL ENTRIES IN it_bseg
           WHERE matnr = it_bseg-matnr
             AND werks = it_bseg-werks.

SORT LT_MARD BY MATNR WERKS.
DELETE ADJACENT DUPLICATES FROM LT_MARD COMPARING MATNR WERKS.




    SELECT bukrs
           belnr
           gjahr
           blart
           monat
           stblg
           AWKEY FROM bkpf INTO TABLE it_bkpf
           FOR ALL ENTRIES IN it_bseg
           WHERE belnr = it_bseg-belnr
            AND  bukrs = it_bseg-bukrs
            AND  gjahr = it_bseg-gjahr.
*            AND  blart NE 'AB'.

    SELECT matnr
           mtart
           matkl
           wrkst
           ersda
           zseries
           zsize
           brand
           moc
           type   FROM mara INTO TABLE it_mara
           FOR ALL ENTRIES IN it_bseg
           WHERE matnr = it_bseg-matnr.

     SELECT matnr
            BWKEY
            BKLAS FROM mbew INTO TABLE it_mbew
            FOR ALL ENTRIES IN it_bseg
            WHERE matnr = it_bseg-matnr
              AND BWKEY = it_bseg-werks.


*    SELECT knumv
*           kposn
*           kschl
*           kawrt
*           kwert FROM konv INTO TABLE it_konv
*           FOR ALL ENTRIES IN it_vbrk_rp
*           WHERE knumv = it_vbrk_rp-knumv
*            AND  kposn = it_vbrk_rp-posnr
*            AND  kschl = 'ZPR0'.



    SELECT vbeln
           posnr
           matnr
           werks
           kwmeng FROM vbap INTO TABLE it_vbap
           FOR ALL ENTRIES IN it_bseg
           WHERE matnr = it_bseg-matnr
            AND  werks = it_bseg-werks.



  ENDIF.



  IF it_vbap IS NOT INITIAL.
    SELECT vbeln
           posnr
           lfgsa FROM vbup INTO TABLE it_vbup
           FOR ALL ENTRIES IN it_vbap
           WHERE vbeln = it_vbap-vbeln
           AND   posnr = it_vbap-posnr
           AND   lfgsa = 'B'.
  ENDIF.

  IF it_vbup IS NOT INITIAL .
    SELECT vgbel
           vgpos
           lfimg FROM lips INTO TABLE it_lips
           FOR ALL ENTRIES IN it_vbup
           WHERE vgbel = it_vbup-vbeln
            AND  vgpos = it_vbup-posnr.


  ENDIF.


*****Logic for US08.
IF it_vbrk_rp IS NOT INITIAL.
    SELECT matnr
           werks
           labst FROM mard APPENDING TABLE lt_mard
           FOR ALL ENTRIES IN it_vbrk_rp
           WHERE matnr = it_vbrk_rp-matnr_i
             AND werks = it_vbrk_rp-werks_i.

    SELECT matnr
           mtart
           matkl
           wrkst
           ersda
           zseries
           zsize
           brand
           moc
           type   FROM mara APPENDING TABLE it_mara
           FOR ALL ENTRIES IN it_vbrk_rp
           WHERE matnr = it_vbrk_rp-matnr_i.

     SELECT matnr
            BWKEY
            BKLAS FROM mbew INTO TABLE it_mbew
            FOR ALL ENTRIES IN it_vbrk_rp
            WHERE matnr = it_vbrk_rp-matnr_i
             AND bwkey = it_vbrk_rp-werks_i.
ENDIF.
**************End**************************
IF it_mara IS NOT INITIAL.

    SELECT matnr
           werks
           labst FROM mard INTO TABLE it_mard
           FOR ALL ENTRIES IN it_mara
           WHERE matnr = it_mara-matnr
             AND werks IN s_werks.

    SELECT matnr
           maktx FROM makt INTO TABLE it_makt
           FOR ALL ENTRIES IN it_mara
           WHERE matnr = it_mara-matnr.

  ENDIF.


SORT it_mbew BY matnr bwkey.
DELETE ADJACENT DUPLICATES FROM it_mbew COMPARING matnr bwkey.
SORT LT_MARD BY MATNR WERKS.
DELETE ADJACENT DUPLICATES FROM LT_MARD COMPARING MATNR WERKS.

lt_bkpf = it_bkpf.

*  LOOP AT it_mara INTO wa_mara.
LOOP AT LT_MARD INTO LS_MARD.

  wa_final-werks = ls_mard-werks.

  READ TABLE IT_MARA INTO WA_MARA WITH KEY MATNR = LS_MARD-MATNR.
    wa_final-matnr = wa_mara-matnr.
    wa_final-mtart = wa_mara-mtart.
    wa_final-matkl = wa_mara-matkl.
    wa_final-wrkst = wa_mara-wrkst.
    wa_final-ersda = wa_mara-ersda.
    wa_final-zseries = wa_mara-zseries.
    wa_final-zsize   = wa_mara-zsize  .
    wa_final-brand   = wa_mara-brand  .
    wa_final-moc     = wa_mara-moc    .
    wa_final-type    = wa_mara-type   .

    READ TABLE it_mbew INTO wa_mbew WITH KEY matnr = wa_mara-matnr BWKEY = ls_mard-werks.
    IF sy-subrc = 0.
      wa_final-BKLAS = wa_mbew-BKLAS.

    ENDIF.

    READ TABLE it_makt INTO wa_makt WITH KEY matnr = wa_mara-matnr.
    IF sy-subrc = 0.

      wa_final-maktx = wa_makt-maktx.

    ENDIF.


    LOOP AT it_bseg INTO wa_bseg WHERE matnr = wa_mara-matnr AND werks = ls_mard-werks.
      READ TABLE it_bkpf INTO wa_bkpf WITH KEY belnr = wa_bseg-belnr.
      IF sy-subrc = 0.

      ENDIF.
     READ TABLE lt_bkpf INTO ls_bkpf WITH KEY stblg = wa_bkpf-belnr.
     IF sy-subrc = 4.
       IF wa_bkpf-awkey+0(2) NE '13' and wa_bkpf-awkey+0(2) NE '14' AND wa_bkpf-awkey+0(2) NE '15' .


      "*************JAN
      IF wa_bkpf-monat = '10'.
        IF wa_bkpf-blart = 'DG'.
          wa_final-jan = wa_final-jan - wa_bseg-menge.
        ELSE.
          wa_final-jan = wa_final-jan + wa_bseg-menge.
        ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-jan_pr = wa_final-jan_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-jan_pr = wa_final-jan_pr - wa_bseg-dmbtr.
        ENDIF.

      "**************FEB
      ELSEIF wa_bkpf-monat = '11'.
        IF wa_bkpf-blart = 'DG'.
          wa_final-feb = wa_final-feb - wa_bseg-menge .
        ELSE.
          wa_final-feb = wa_final-feb + wa_bseg-menge.
        ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-feb_pr = wa_final-feb_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-feb_pr = wa_final-feb_pr - wa_bseg-dmbtr.
        ENDIF.
*        wa_final-feb_pr = wa_final-feb_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.


      "******************MAR
      ELSEIF wa_bkpf-monat = '12'.
        IF wa_bkpf-blart = 'DG'.
          wa_final-mar = wa_final-mar - wa_bseg-menge .
        ELSE.
          wa_final-mar = wa_final-mar + wa_bseg-menge.
        ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-mar_pr = wa_final-mar_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-mar_pr = wa_final-mar_pr - wa_bseg-dmbtr.
        ENDIF.
*        wa_final-mar_pr = wa_final-mar_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.


      "******************APR
      ELSEIF wa_bkpf-monat = '01'.
       IF wa_bkpf-blart = 'DG'.
         wa_final-apr = wa_final-apr -  wa_bseg-menge .
       ELSE.
         wa_final-apr = wa_final-apr + wa_bseg-menge.
       ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-apr_pr = wa_final-apr_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-apr_pr = wa_final-apr_pr - wa_bseg-dmbtr.
        ENDIF.
*        wa_final-apr_pr = wa_final-apr_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.

      "******************MAY
      ELSEIF wa_bkpf-monat = '02'.
       IF wa_bkpf-blart = 'DG'.
         wa_final-may = wa_final-may - wa_bseg-menge .
       ELSE.
         wa_final-may = wa_final-may + wa_bseg-menge.
       ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-may_pr = wa_final-may_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-may_pr = wa_final-may_pr - wa_bseg-dmbtr.
        ENDIF.
*        wa_final-may_pr = wa_final-may_pr + wa_konv-kwert ."wa_vbrk_rp-netwr.


      "******************JUN
      ELSEIF wa_bkpf-monat = '03'.
        IF wa_bkpf-blart = 'DG'.
          wa_final-jun = wa_final-jun - wa_bseg-menge .
        ELSE.
          wa_final-jun = wa_final-jun + wa_bseg-menge.
        ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-jun_pr = wa_final-jun_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-jun_pr = wa_final-jun_pr - wa_bseg-dmbtr.
        ENDIF.

*        wa_final-jun_pr = wa_final-jun_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.

      "******************JUL
      ELSEIF wa_bkpf-monat = '04'.
       IF wa_bkpf-blart = 'DG'.
         wa_final-jul = wa_final-jul - wa_bseg-menge .
       ELSE.
         wa_final-jul = wa_final-jul + wa_bseg-menge .
       ENDIF.
        IF wa_bseg-shkzg = 'H'.
          wa_final-jul_pr = wa_final-jul_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-jul_pr = wa_final-jul_pr - wa_bseg-dmbtr.
        ENDIF.

*        wa_final-jul_pr = wa_final-jul_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.

      "******************AUG
      ELSEIF wa_bkpf-monat = '05'.
       IF wa_bkpf-blart = 'DG'.
         wa_final-aug = wa_final-aug - wa_bseg-menge .
       ELSE.
         wa_final-aug = wa_final-aug + wa_bseg-menge.
       ENDIF.
        IF wa_bseg-shkzg = 'H'.
          wa_final-aug_pr = wa_final-aug_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-aug_pr = wa_final-aug_pr - wa_bseg-dmbtr.
        ENDIF.

*        wa_final-aug_pr = wa_final-aug_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.

      "******************SEP
      ELSEIF wa_bkpf-monat = '06'.
      IF wa_bkpf-blart = 'DG'.
        wa_final-sep = wa_final-sep - wa_bseg-menge .
      ELSE.
        wa_final-sep = wa_final-sep + wa_bseg-menge.
      ENDIF.
        IF wa_bseg-shkzg = 'H'.
          wa_final-sep_pr = wa_final-sep_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-sep_pr = wa_final-sep_pr - wa_bseg-dmbtr.
        ENDIF.

*        wa_final-sep_pr = wa_final-sep_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.

      "******************OCT
      ELSEIF wa_bkpf-monat = '07'.
       IF wa_bkpf-blart = 'DG'.
        wa_final-oct = wa_final-oct - wa_bseg-menge .
       ELSE.
        wa_final-oct = wa_final-oct + wa_bseg-menge.
       ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-oct_pr = wa_final-oct_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-oct_pr = wa_final-oct_pr - wa_bseg-dmbtr.
        ENDIF.
*        wa_final-oct_pr = wa_final-oct_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.


      "******************NOV
      ELSEIF wa_bkpf-monat = '08'.
        IF wa_bkpf-blart = 'DG'.
          wa_final-nov = wa_final-nov - wa_bseg-menge .
        ELSE.
          wa_final-nov = wa_final-nov + wa_bseg-menge.
        ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-nov_pr = wa_final-nov_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-nov_pr = wa_final-nov_pr - wa_bseg-dmbtr.
        ENDIF.
*        wa_final-nov_pr = wa_final-nov_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.

      "******************NOV
      ELSEIF wa_bkpf-monat = '09'.
       IF wa_bkpf-blart = 'DG'.
          wa_final-dec = wa_final-dec - wa_bseg-menge .
       ELSE.
         wa_final-dec = wa_final-dec + wa_bseg-menge.
       ENDIF.

        IF wa_bseg-shkzg = 'H'.
          wa_final-dec_pr = wa_final-dec_pr + wa_bseg-dmbtr.
        ELSE.
          wa_final-dec_pr = wa_final-dec_pr - wa_bseg-dmbtr.
        ENDIF.
*        wa_final-dec_pr = wa_final-dec_pr + wa_konv-kwert.  "wa_vbrk_rp-netwr.
      ENDIF.
    ENDIF.
    ENDIF.
    ENDLOOP.

    LOOP AT it_vbrk_rp INTO wa_vbrk_rp WHERE matnr_i = ls_mard-matnr AND werks_i = ls_mard-werks.

      READ TABLE it_cancel INTO wa_cancel WITH KEY sfakn = wa_vbrk_rp-vbeln.
      IF sy-subrc = 4.
        IF wa_vbrk_rp-fkdat+4(2) = '01'.

          wa_final-jan = wa_final-jan + wa_vbrk_rp-fkimg_i.

      "**************FEB
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '02'.

          wa_final-feb = wa_final-feb + wa_vbrk_rp-fkimg_i.

      "******************MAR
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '03'.

          wa_final-mar = wa_final-mar + wa_vbrk_rp-fkimg_i.

      "******************APR
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '04'.

         wa_final-apr = wa_final-apr  + wa_vbrk_rp-fkimg_i.

      "******************MAY
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '05'.

         wa_final-may = wa_final-may + wa_vbrk_rp-fkimg_i .

      "******************JUN
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '06'.

          wa_final-jun = wa_final-jun + wa_vbrk_rp-fkimg_i.

      "******************JUL
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '07'.

         wa_final-jul = wa_final-jul + wa_vbrk_rp-fkimg_i .

      "******************AUG
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '08'.

         wa_final-aug = wa_final-aug + wa_vbrk_rp-fkimg_i.

      "******************SEP
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '09'.

        wa_final-sep = wa_final-sep + wa_vbrk_rp-fkimg_i.

      "******************OCT
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '10'.

        wa_final-oct = wa_final-oct + wa_vbrk_rp-fkimg_i.

      "******************NOV
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '11'.

          wa_final-nov = wa_final-nov + wa_vbrk_rp-fkimg_i.

      "******************NOV
      ELSEIF wa_vbrk_rp-fkdat+4(2) = '12'.

          wa_final-dec = wa_final-dec + wa_vbrk_rp-fkimg_i.

      ENDIF.
    ENDIF.



    ENDLOOP.

   wa_final-sale_tot =   wa_final-jan + wa_final-feb + wa_final-mar + wa_final-apr + wa_final-may + wa_final-jun +
                         wa_final-jul + wa_final-aug + wa_final-sep + wa_final-oct + wa_final-nov + wa_final-dec      .

   wa_final-pri_tot =    wa_final-jan_pr + wa_final-feb_pr + wa_final-mar_pr + wa_final-apr_pr + wa_final-may_pr +
                         wa_final-jun_pr + wa_final-jul_pr + wa_final-aug_pr + wa_final-sep_pr + wa_final-oct_pr +
                         wa_final-nov_pr + wa_final-dec_pr.


    LOOP AT it_vbap INTO wa_vbap WHERE matnr = wa_mara-matnr AND werks = ls_mard-werks.
      wa_final-vbap_qty = wa_final-vbap_qty + wa_vbap-kwmeng.
      READ TABLE it_vbup INTO wa_vbup WITH KEY vbeln = wa_vbap-vbeln posnr = wa_vbap-posnr.
      IF sy-subrc = 0.
        READ TABLE it_lips INTO wa_lips WITH KEY vgbel = wa_vbup-vbeln vgpos = wa_vbup-posnr.
        IF sy-subrc = 0.

*      wa_final-vbap_qty = wa_final-vbap_qty + wa_vbap-kwmeng.
          wa_final-lips_qty = wa_final-lips_qty + wa_lips-lfimg.

        ENDIF.

      ENDIF.

    ENDLOOP.
    wa_final-open_qty = wa_final-lips_qty - wa_final-vbap_qty.

    LOOP AT it_mard INTO wa_mard WHERE matnr = wa_mara-matnr AND werks = ls_mard-werks.

      wa_final-un_qty = wa_final-un_qty + wa_mard-labst.


    ENDLOOP.



    APPEND wa_final TO it_final.
    CLEAR:wa_final,date.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  SORT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SORT_DATA .

SORT it_mara by matnr.
DELETE ADJACENT DUPLICATES FROM it_mara COMPARING matnr.
  LOOP AT it_mara INTO wa_mara.
    LOOP AT it_final INTO wa_final WHERE matnr = wa_mara-matnr.
     wa_sort-matnr   =  wa_final-matnr .
     wa_sort-mtart   =  wa_final-mtart .
     wa_sort-matkl   =  wa_final-matkl .
     wa_sort-wrkst   =  wa_final-wrkst .
     wa_sort-ersda   =   wa_final-ersda .
     wa_sort-zseries =  wa_final-zseries.
     wa_sort-zsize   =  wa_final-zsize  .
     wa_sort-brand   =  wa_final-brand  .
     wa_sort-moc     =  wa_final-moc    .
     wa_sort-type    =  wa_final-type   .

     wa_sort-BKLAS   = wa_final-BKLAS.
     wa_sort-maktx   = wa_final-maktx.

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

     wa_sort-sale_tot = wa_sort-sale_tot + wa_final-sale_tot.
     wa_sort-pri_tot  = wa_sort-pri_tot  + wa_final-pri_tot.

     wa_sort-vbap_qty = wa_sort-vbap_qty + wa_final-vbap_qty .
     wa_sort-lips_qty = wa_sort-lips_qty + wa_final-lips_qty.

     wa_sort-open_qty = wa_sort-open_qty + wa_final-open_qty.
     wa_sort-un_qty   = wa_sort-un_qty   + wa_final-un_qty.


    ENDLOOP.
  APPEND wa_sort TO it_sort.
  CLEAR wa_sort.
  ENDLOOP.


IF p_down = 'X'.
LOOP AT it_sort INTO wa_sort.
 wa_down-matnr     =  wa_sort-matnr    .
 wa_down-wrkst     =  wa_sort-wrkst    .
 wa_down-maktx     =  wa_sort-maktx    .
 wa_down-mtart     =  wa_sort-mtart    .
 wa_down-matkl     =  wa_sort-matkl    .
* wa_down-werks     =  wa_sort-werks    .

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



 wa_down-BKLAS     =  wa_sort-BKLAS    .
 wa_down-zseries   =  wa_sort-zseries  .
 wa_down-zsize     =  wa_sort-zsize    .
 wa_down-brand     =  wa_sort-brand    .
 wa_down-moc       =  wa_sort-moc      .
 wa_down-type      =  wa_sort-type     .
 wa_down-jan       =  wa_sort-jan      .
 wa_down-feb       =  wa_sort-feb      .
 wa_down-mar       =  wa_sort-mar      .
 wa_down-apr       =  wa_sort-apr      .
 wa_down-may       =  wa_sort-may      .
 wa_down-jun       =  wa_sort-jun      .
 wa_down-jul       =  wa_sort-jul      .
 wa_down-aug       =  wa_sort-aug      .
 wa_down-sep       =  wa_sort-sep      .
 wa_down-oct       =  wa_sort-oct      .
 wa_down-nov       =  wa_sort-nov      .
 wa_down-dec          =  wa_sort-dec          .
* wa_down-open_qty     =  wa_sort-open_qty     .
* wa_down-un_qty       =  wa_sort-un_qty       .
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

 wa_down-pri_tot      =  abs( wa_sort-pri_tot ).
 IF wa_sort-pri_tot < 0.
    CONDENSE wa_down-pri_tot.
    CONCATENATE '-' wa_down-pri_tot INTO wa_down-pri_tot.
 ENDIF.

 wa_down-sale_tot     =  wa_sort-sale_tot     .



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
                         '3'  'MAKTX'         'IT_FINAL'  'Material Desc.'                                     '18' ,
                         '4'  'MTART'         'IT_FINAL'  'Material Type'                                     '18' ,
                         '5'  'MATKL'         'IT_FINAL'  'Material Group'                                     '18' ,
                         '6'  'ERSDA'         'IT_FINAL'  'Material Creat Date.'                                     '18' ,
                         '7'  'BKLAS'         'IT_FINAL'  'Valuation Class'                                     '18' ,
                         '8'  'ZSERIES'       'IT_FINAL'  'series '                                     '18' ,
                         '9'  'ZSIZE'         'IT_FINAL'  'Size'                                     '18' ,
                        '10'  'BRAND'         'IT_FINAL'  'Brand'                                     '18' ,
                        '11'  'MOC'           'IT_FINAL'  'Moc'                                     '18' ,
                        '12'  'TYPE'          'IT_FINAL'  'Type'                                     '18' ,

                        '13'  'APR'           'IT_FINAL'  apr_un          '18',                     "  'Units Pur 30/APR'
                        '14'  'MAY'           'IT_FINAL'  may_un          '18',                     " 'Units Pur 31/MAY'
                        '15'  'JUN'           'IT_FINAL'  jun_un          '18',                     " 'Units Pur 30/JUN'
                        '16'  'JUL'           'IT_FINAL'  jul_un          '18',                     " 'Units Pur 31/JUL'
                        '17'  'AUG'           'IT_FINAL'  aug_un          '18',                     " 'Units Pur 31/AUG'
                        '18'  'SEP'           'IT_FINAL'  sep_un          '18',                     " 'Units Pur 30/SEP'
                        '19'  'OCT'           'IT_FINAL'  oct_un          '18',                     " 'Units Pur 31/OCT'
                        '20'  'NOV'           'IT_FINAL'  nov_un          '18',                     " 'Units Pur 30/NOV'
                        '21'  'DEC'           'IT_FINAL'  dec_un          '18',                     " 'Units Pur 31/DEC'
                        '22'  'JAN'           'IT_FINAL'  jan_un          '18',                     "  'Units Pur 31/JAN'
                        '23'  'FEB'           'IT_FINAL'  feb_un          '18',                     "   'Units Pur 28/FEB'
                        '24'  'MAR'           'IT_FINAL'  mar_un          '18',                     " 'Units Pur 31/MAR'
                        '25'  'SALE_TOT'      'IT_FINAL'  'Total Unit'     '18',
*                        '25'  'OPEN_QTY'      'IT_FINAL'  'Open Qty'   '18',
*                        '26'  'UN_QTY'        'IT_FINAL'  'Unrestricted Stock'   '18',


                        '26'  'APR_PR'           'IT_FINAL'  apr_pr         '18',                 "'Units Price 30/APR'
                        '27'  'MAY_PR'           'IT_FINAL'  may_pr         '18',                 "'Units Price 31/MAY'
                        '28'  'JUN_PR'           'IT_FINAL'  jun_pr         '18',                 "'Units Price 30/JUN'
                        '29'  'JUL_PR'           'IT_FINAL'  jul_pr         '18',                 "'Units Price 31/JUL'
                        '30'  'AUG_PR'           'IT_FINAL'  aug_pr         '18',                 "'Units Price 31/AUG'
                        '31'  'SEP_PR'           'IT_FINAL'  sep_pr         '18',                 "'Units Price 30/SEP'
                        '32'  'OCT_PR'           'IT_FINAL'  oct_pr         '18',                 "'Units Price 31/OCT'
                        '33'  'NOV_PR'           'IT_FINAL'  nov_pr         '18',                 "'Units Price 30/NOV'
                        '34'  'DEC_PR'           'IT_FINAL'  dec_pr         '18',                 "'Units Price 31/DEC'
                        '35'  'JAN_PR'           'IT_FINAL'  jan_pr         '18',                 "'Units Price 31/JAN'
                        '36'  'FEB_PR'           'IT_FINAL'  feb_pr         '18',                 "'Units Price 28/FEB'
                        '37'  'MAR_PR'           'IT_FINAL'  mar_pr         '18',                 "'Units Price 31/MAR'
                        '38'  'PRI_TOT'          'IT_FINAL'  'Total Price'     '18'.
*                        '39'  'WERKS'            'IT_FINAL'  'Plant'          '18'.


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
     IS_LAYOUT          =  fs_layout
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

        period        TYPE char100.


  CONCATENATE  p_year 'To' year INTO period SEPARATED BY space.
 CONDENSE period.



*  Title
  wa_header-typ  = 'H'.
  wa_header-info = 'Sales Item Master'.
  APPEND wa_header TO t_header.
  CLEAR wa_header.

  wa_header-typ  = 'S'.
  wa_header-key  = 'Sales Period :'  .
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


    lv_file = 'ZUS_ITEM_SALES1.TXT'.


  CONCATENATE p_folder '/' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUS_ITEM_SALES REPORT started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1458 TYPE string.
DATA lv_crlf_1458 TYPE string.
lv_crlf_1458 = cl_abap_char_utilities=>cr_lf.
lv_string_1458 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1458 lv_crlf_1458 wa_csv INTO lv_string_1458.
  CLEAR: wa_csv.
ENDLOOP.
TRANSFER lv_string_1458 TO lv_fullfile.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.

***************************************SQL UPLOAD FILE*************************
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


    lv_file = 'ZUS_ITEM_SALES1.TXT'.


  CONCATENATE p_folder '/' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUS_ITEM_SALES REPORT started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1496 TYPE string.
DATA lv_crlf_1496 TYPE string.
lv_crlf_1496 = cl_abap_char_utilities=>cr_lf.
lv_string_1496 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1496 lv_crlf_1496 wa_csv INTO lv_string_1496.
  CLEAR: wa_csv.
ENDLOOP.
TRANSFER lv_string_1496 TO lv_fullfile.
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
            'Material Desc.'
            'Material Type'
            'Material Group'
            'Material Creat Date.'
            'Valuation Class'
            'series '
            'Size'
            'Brand'
            'Moc'
            'Type'
            apr_un
            may_un
            jun_un
            jul_un
            aug_un
            sep_un
            oct_un
            nov_un
            dec_un
            jan_un
            feb_un
            mar_un
            'Total Unit'

*            'Open Qty'
*            'Unrestricted Stock'
           apr_pr
           may_pr
           jun_pr
           jul_pr
           aug_pr
           sep_pr
           oct_pr
           nov_pr
           dec_pr
           jan_pr
           feb_pr
           mar_pr
           'Total Price'
*           'Plant'
           'Refresh Date'
              INTO pd_csv
              SEPARATED BY l_field_seperator.


ENDFORM.

*&---------------------------------------------------------------------*
*&  Include           ZUS_SD_PEND_SO_TOP
*&---------------------------------------------------------------------*


TABLES: vbrp.
TYPES: BEGIN OF ty_data,
         vbeln TYPE vbeln,
         posnr TYPE posnr,

       END OF ty_data.

TYPES:BEGIN OF ty_vbap,
      vbeln       TYPE vbap-vbeln,
      posnr       TYPE vbap-posnr,
      matnr       TYPE vbap-matnr,
      abgru       TYPE vbap-abgru,
      KDMAT       TYPE vbap-KDMAT,
      ARKTX       TYPE vbap-ARKTX,
      WAERK       TYPE vbap-WAERK,
      KWMENG      TYPE vbap-KWMENG,
      WERKS       TYPE vbap-WERKS,
      OBJNR       TYPE vbap-OBJNR,

      HOLDDATE    TYPE vbap-HOLDDATE,
      HOLDRELDATE TYPE vbap-HOLDRELDATE,
      CANCELDATE  TYPE vbap-CANCELDATE,
      DELDATE     TYPE vbap-DELDATE,
      CUSTDELDATE TYPE vbap-CUSTDELDATE,
      END OF ty_vbap,

      BEGIN OF ty_vbak,
      vbeln       TYPE vbak-vbeln,
      ERDAT       TYPE vbak-ERDAT,
      AUART       TYPE vbak-AUART,
      WAERK       TYPE vbak-WAERK,
      VKBUR       TYPE vbak-VKBUR,"23
      KNUMV       TYPE vbak-KNUMV,"28
      VDATU       TYPE vbak-VDATU,"29
      BSTDK       TYPE VBAK-BSTDK,
      BNAME       TYPE vbak-BNAME,"44
      KUNNR       TYPE vbak-KUNNR,"48
      ZLDFROMDATE TYPE vbak-ZLDFROMDATE,
      ZLDPERWEEK  TYPE vbak-ZLDPERWEEK,
      ZLDMAX      TYPE vbak-ZLDMAX,
      END OF ty_vbak.

TYPES:BEGIN OF ty_vbpa,
      vbeln TYPE vbpa-vbeln,
      kunnr TYPE vbpa-kunnr,
      parvw TYPE vbpa-parvw,
      END OF ty_vbpa,

      BEGIN OF ty_kna1,
      kunnr TYPE kna1-kunnr,
      name1 TYPE kna1-name1,
      END OF ty_kna1,

      BEGIN OF ty_ship,
      kunnr TYPE kna1-kunnr,
      name1 TYPE kna1-name1,
      STRAS TYPE kna1-STRAS,
      PSTLZ TYPE kna1-PSTLZ,
      ORT01 TYPE kna1-ORT01,
      REGIO TYPE kna1-REGIO,
      LAND1 TYPE kna1-LAND1,
      END OF ty_ship,

      BEGIN OF ty_t005u,
      spras TYPE t005u-spras,
      land1 TYPE t005u-land1,
      bland TYPE t005u-bland,
      bezei TYPE t005u-bezei,
      END OF ty_t005u,

      BEGIN OF ty_t005t,
      spras TYPE t005t-spras,
      land1 TYPE t005t-land1,
      landx TYPE t005t-landx,
      END OF ty_t005t,

      BEGIN OF ty_knvv,
      kunnr TYPE knvv-kunnr,
      kdgrp TYPE knvv-kdgrp,
      bzirk TYPE knvv-bzirk,
      vkbur TYPE knvv-vkbur,
      END OF ty_knvv,

      BEGIN OF ty_t151t,
      spras TYPE t151t-spras,
      kdgrp TYPE t151t-kdgrp,
      ktext TYPE t151t-ktext,
      END OF ty_t151t,

      BEGIN OF ty_t016t,
      spras TYPE t016t-spras,
      brsch TYPE t016t-brsch,
      brtxt TYPE t016t-brtxt,
      END OF ty_t016t.


TYPES : BEGIN OF output,
          werks       TYPE werks_ext,
          auart       TYPE vbak-auart,
          bstkd       TYPE vbkd-bstkd,
          BSTDK       TYPE VBAK-BSTDK,
          kunnr       TYPE kna1-kunnr,
          name1       TYPE kna1-name1,
          partner     TYPE kna1-kunnr,
          part_name   TYPE kna1-name1,
          kdgrp       TYPE knvv-kdgrp,
          ktext       TYPE char25,
          brsch       TYPE kna1-brsch,
          brtxt       TYPE char25,
          vkbur       TYPE vbak-vkbur,
          vbeln       TYPE vbak-vbeln,
          erdat       TYPE vbak-erdat,
          vdatu       TYPE vbak-vdatu,
          status      TYPE text30,
          holddate    TYPE vbap-holddate,
          reldate     TYPE vbap-holdreldate,
          canceldate  TYPE vbap-canceldate,
          deldate     TYPE vbap-deldate,
          tpi         TYPE char100,
          tag_req     TYPE char100,
          ld_txt      TYPE char100,
          matnr       TYPE vbap-matnr,
          wrkst       TYPE mara-wrkst,
          bklas       TYPE mbew-bklas,
          posnr       TYPE vbap-posnr,
          arktx       TYPE vbap-arktx,
          mattxt      TYPE text100,
          kwmeng      TYPE vbap-kwmeng,
          lfimg       TYPE lips-lfimg,
          fkimg       TYPE vbrp-fkimg,
          pnd_qty     LIKE vbrp-fkimg,
          ettyp       TYPE vbep-ettyp,
          mrp_dt      TYPE udate,
          edatu       TYPE vbep-edatu,
          kbetr       TYPE konv-kbetr,
          waerk       TYPE vbap-waerk,
          amont       TYPE kbetr,
          ordr_amt    TYPE kbetr,
          st_cost     TYPE mbew-stprs,
          zseries     TYPE mara-zseries,
          zsize       TYPE mara-zsize,
          brand       TYPE mara-brand,
          moc         TYPE mara-moc,
          type        TYPE mara-type,
          dispo       TYPE marc-dispo,
          mtart       TYPE mara-mtart,
          etenr       TYPE vbep-etenr,
          schid(25),
          zterm       TYPE vbkd-zterm,
          text1       TYPE t052u-text1,
          inco1       TYPE vbkd-inco1,
          inco2       TYPE vbkd-inco2,
          CUSTDELDATE    TYPE vbap-CUSTDELDATE,
          bname       TYPE vbak-bname,
          eccn        TYPE char100,
          ABGRU       TYPE vbap-ABGRU,
          BEZEI       TYPE TVAGT-BEZEI,
          ref_dt      TYPE sy-datum,
          ship_name   TYPE kna1-name1,
          stras       TYPE kna1-stras,
          pstlz       TYPE kna1-pstlz,
          ort01       TYPE kna1-ort01,
          ship_rig    TYPE char20,
          ship_land   TYPE char20,

*
*          zldperweek  TYPE zldperweek1,
*          zldmax      TYPE vbak-zldmax,
*          zldfromdate TYPE vbak-zldfromdate,
*          stock_qty   TYPE mska-kalab,
*          curr_con    TYPE ukursp,
*          in_price    TYPE konv-kbetr,
*          in_pr_dt    TYPE konv-kdatu,
*          est_cost    TYPE konv-kbetr,
*          latst_cost  TYPE konv-kbetr,
*          wip         TYPE i,
*          kdmat       TYPE vbap-kdmat,
*          qmqty       TYPE mska-kains,
*          itmtxt      TYPE text100,
*          so_exc      TYPE ukursp,
*          ofm         TYPE char50,
*          ofm_date    TYPE char50,
*          spl         TYPE string,
*          desc        TYPE char250,
*          sale_off    TYPE knvv-vkbur,
*          bzirk       TYPE knvv-bzirk,


          """"""""""""""""""""""""""""""""""""""""""""
        END OF output.

TYPES : BEGIN OF TY_TVAGT,
  SPRAS  TYPE  TVAGT-SPRAS,
  ABGRU TYPE  TVAGT-ABGRU,
  BEZEI  TYPE  TVAGT-BEZEI,
  END OF TY_TVAGT.

  DATA : IT_TVAGT TYPE STANDARD TABLE OF TY_TVAGT,
          WA_TVAGT TYPE TY_TVAGT.






""""""""""    Added By KD 04.05.2017        """""""""""
TYPES : BEGIN OF ty_afpo,
          aufnr TYPE afpo-aufnr,
          posnr TYPE afpo-posnr,
          kdauf TYPE afpo-kdauf,
          kdpos TYPE afpo-kdpos,
          matnr TYPE afpo-matnr,
          pgmng TYPE afpo-pgmng,
          psmng TYPE afpo-psmng,
          wemng TYPE afpo-wemng,
        END OF ty_afpo.

TYPES : BEGIN OF ty_caufv,
          aufnr TYPE caufv-aufnr,
          objnr TYPE caufv-objnr,
          kdauf TYPE caufv-kdauf,
          kdpos TYPE caufv-kdpos,
          igmng TYPE caufv-igmng,
        END OF ty_caufv .

TYPES : BEGIN OF ty_jest,
          objnr TYPE jest-objnr,
          stat  TYPE jest-stat,
        END OF ty_jest.

TYPES : BEGIN OF ty_tj02t,
          istat TYPE tj02t-istat,
          txt04 TYPE tj02t-txt04,
        END OF ty_tj02t.

TYPES : BEGIN OF ty_mast,
          matnr TYPE mast-matnr,
          werks TYPE mast-werks,
          stlan TYPE mast-stlan,
          stlnr TYPE mast-stlnr,
          stlal TYPE mast-stlal,
        END OF ty_mast.

TYPES : BEGIN OF ty_stko,
          stlty TYPE stko-stlty,
          stlnr TYPE stko-stlnr,
          stlal TYPE stko-stlal,
          stkoz TYPE stko-stkoz,
        END OF ty_stko.

TYPES : BEGIN OF ty_stpo,
          stlty TYPE stpo-stlty,
          stlnr TYPE stpo-stlnr,
          stlkn TYPE stpo-stlkn,
          stpoz TYPE stpo-stpoz,
          idnrk TYPE stpo-idnrk,
        END OF ty_stpo.

TYPES:
  BEGIN OF t_resb,
    rsnum TYPE resb-rsnum,
    rspos TYPE resb-rspos,
    rsart TYPE resb-rsart,
    bdmng TYPE resb-bdmng,
    enmng TYPE resb-enmng,
    aufnr TYPE resb-aufnr,
    kdauf TYPE resb-kdauf,
    kdpos TYPE resb-kdpos,
  END OF t_resb,
  tt_resb TYPE STANDARD TABLE OF t_resb.


TYPES:
  BEGIN OF t_final,
    werks       TYPE werks_ext,
    auart       TYPE vbak-auart,
    bstkd       TYPE vbkd-bstkd,
    BSTDK       TYPE char11,
    kunnr       TYPE kna1-kunnr,
    name1       TYPE kna1-name1,
    partner     TYPE kna1-kunnr,
    part_name   TYPE kna1-name1,
    kdgrp       TYPE knvv-kdgrp,
    ktext       TYPE char25,
    brsch       TYPE kna1-brsch,
    brtxt       TYPE char25,
    vkbur       TYPE vbak-vkbur,
    vbeln       TYPE vbak-vbeln,
    erdat       TYPE char11, "vbak-erdat,
    vdatu       TYPE char11, "vbak-vdatu,
    status      TYPE text30,
    holddate    TYPE char11, "vbap-holddate,
    reldate     TYPE char11, "vbap-holdreldate,
    canceldate  TYPE char11, "vbap-canceldate,
    deldate     TYPE char11, "vbap-deldate,
    tpi         TYPE char20,
    tag_req     TYPE char20,
    ld_txt      TYPE char20,
    matnr       TYPE vbap-matnr,
    wrkst       TYPE mara-wrkst,
    bklas       TYPE mbew-bklas,
    posnr       TYPE vbap-posnr,
    arktx       TYPE vbap-arktx,
    mattxt      TYPE char100,
    kwmeng      TYPE char15, "vbap-kwmeng,
    lfimg       TYPE char15, "lips-lfimg,
    fkimg       TYPE char15, "vbrp-fkimg,
    pnd_qty     TYPE char15, "vbrp-fkimg,
    ettyp       TYPE vbep-ettyp,
    mrp_dt      TYPE char11, "udate,
    edatu       TYPE char11, "vbep-edatu,
    kbetr       TYPE char15, "konv-kbetr,
    waerk       TYPE vbap-waerk,
    amont       TYPE char15, "kbetr,
    ordr_amt    TYPE char15, "kbetr,
    st_cost     TYPE char15, "mbew-stprs,
    zseries     TYPE mara-zseries,
    zsize       TYPE mara-zsize,
    brand       TYPE mara-brand,
    moc         TYPE mara-moc,
    type        TYPE mara-type,
    dispo       TYPE marc-dispo,
    mtart       TYPE mara-mtart,

    etenr       TYPE vbep-etenr,
    schid(25),
    zterm       TYPE vbkd-zterm,
    text1       TYPE char50,
    inco1       TYPE vbkd-inco1,
    inco2       TYPE char30,
    custdeldate TYPE char11, "vbap-deldate,
    bname       TYPE vbak-bname,
    eccn        TYPE char100,
    ABGRU       TYPE vbap-ABGRU,
    BEZEI       TYPE TVAGT-BEZEI,
    ref_dt      TYPE char11,
    ship_name   TYPE kna1-name1,
    stras       TYPE kna1-stras,
    pstlz       TYPE kna1-pstlz,
    ort01       TYPE kna1-ort01,
    ship_rig    TYPE char20,
    ship_land   TYPE char20,

  END OF t_final,
  tt_final TYPE STANDARD TABLE OF t_final.

DATA : it_afpo  TYPE TABLE OF ty_afpo,
       wa_afpo  TYPE ty_afpo,
       it_caufv TYPE TABLE OF ty_caufv,
       wa_caufv TYPE ty_caufv,
       it_jest2 TYPE TABLE OF ty_jest,
       wa_jest2 TYPE ty_jest,
       it_tj02t TYPE TABLE OF ty_tj02t,
       wa_tj02t TYPE ty_tj02t,
       it_mast  TYPE TABLE OF mast,
       wa_mast  TYPE mast,
       it_stko  TYPE TABLE OF ty_stko,
       wa_stko  TYPE ty_stko,
       it_stpo  TYPE TABLE OF ty_stpo,
       wa_stpo  TYPE ty_stpo.

"""""""""""""""    end   04.05.2017  """""""""""""""""""""""""""""

DATA: it_vbak      TYPE TABLE OF ty_vbak,
      wa_vbak      TYPE ty_vbak,
      it_vbap      TYPE TABLE OF ty_vbap,
      wa_vbap      TYPE ty_vbap,
      it_vbkd      TYPE STANDARD TABLE OF vbkd,
      wa_vbkd      TYPE vbkd,
      it_t052u     TYPE STANDARD TABLE OF t052u,
      wa_t052u     TYPE t052u,
      it_tvzbt     TYPE STANDARD TABLE OF tvzbt,
      wa_tvzbt     TYPE t052u,
      it_kna1      TYPE STANDARD TABLE OF  kna1,
      wa_kna1      TYPE kna1,
      it_mska      TYPE STANDARD TABLE OF mska,
      wa_mska      TYPE mska,
      it_vbfa      TYPE STANDARD TABLE OF vbfa,
      wa_vbfa      TYPE vbfa,
      it_lips      TYPE STANDARD TABLE OF lips,
      wa_lips      TYPE lips,
      wa_lfimg     TYPE lips-lfimg,
      wa_lfimg_sum TYPE lips-lfimg,
      it_vbrk      TYPE STANDARD TABLE OF vbrk,
      wa_vbrk      TYPE vbrk,
      it_vbrp      TYPE STANDARD TABLE OF vbrp,
      wa_vbrp      TYPE vbrp,
      wa_fkimg     TYPE lips-lfimg,
      wa_fkimg_sum TYPE lips-lfimg,
      it_vbep      TYPE STANDARD TABLE OF vbep,
      wa_vbep      TYPE vbep,
      lt_vbep      TYPE STANDARD TABLE OF vbep,
      ls_vbep      TYPE vbep,
      it_konv      TYPE STANDARD TABLE OF konv,
      wa_konv      TYPE konv,
      it_konh      TYPE STANDARD TABLE OF konh,
      wa_konh      TYPE konh,
      it_konp      TYPE STANDARD TABLE OF konp,
      wa_konp      TYPE konp,
      it_jest      TYPE STANDARD TABLE OF jest,
      wa_jest1     TYPE jest,
      it_tj30t     TYPE STANDARD TABLE OF tj30t,
      wa_tj30t     TYPE tj30t,
***      it_a508    TYPE STANDARD TABLE OF a508,
***      wa_a508    TYPE a508,
      it_cdhdr     TYPE STANDARD TABLE OF cdhdr,
      wa_cdhdr     TYPE cdhdr,
      it_cdpos     TYPE STANDARD TABLE OF cdpos,
      wa_cdpos     TYPE cdpos,
      it_output    TYPE STANDARD TABLE OF output,
      wa_output    TYPE output,
      wa_mbew      TYPE mbew,
      wa_mara      TYPE mara,
      it_oauto     TYPE STANDARD TABLE OF output,
      wa_oauto     TYPE output,
      it_mara      TYPE TABLE OF mara,
      it_makt      TYPE TABLE OF makt,
      wa_makt      TYPE makt,
      it_vbpa      TYPE TABLE OF ty_vbpa,
      wa_vbpa      TYPE ty_vbpa,
      it_partner   TYPE TABLE OF ty_kna1,
      wa_partner   TYPE ty_kna1,
      it_ship      TYPE TABLE OF ty_ship,
      wa_ship      TYPE ty_ship,
      it_t005u     TYPE TABLE OF ty_t005u,
      wa_t005u     TYPE ty_t005u,
      it_t005t     TYPE TABLE OF ty_t005t,
      wa_t005t     TYPE ty_t005t,
      it_knvv      TYPE TABLE OF ty_knvv,
      wa_knvv      TYPE          ty_knvv,
      it_t151t     TYPE TABLE OF ty_t151t,
      wa_t151t     TYPE          ty_t151t,
      it_t016t     TYPE TABLE OF ty_t016t,
      wa_t016t     TYPE          ty_t016t.


DATA:
  lt_resb TYPE tt_resb,
  ls_resb TYPE t_resb.
DATA:
   gt_final TYPE tt_final.
DATA: it_data   TYPE STANDARD TABLE OF ty_data,
      wa_data   TYPE ty_data,
      wa_data2  TYPE ty_data,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_lines  LIKE tline,
      wa_ln_ld  LIKE tline,
      wa_tag_rq LIKE tline,
      lv_name   TYPE thead-tdname,
      wa_text   TYPE char20.
DATA ls_mattxt  TYPE tline.
DATA ls_itmtxt  TYPE tline.
*data for bapi to convert currency

DATA: BEGIN OF ls_fr_curr OCCURS 0.
    INCLUDE STRUCTURE bapi1093_3.
DATA: END OF ls_fr_curr.

DATA: BEGIN OF ls_to_curr OCCURS 0.
    INCLUDE STRUCTURE bapi1093_4.
DATA: END OF ls_to_curr.

DATA: BEGIN OF ls_ex_rate OCCURS 0.
    INCLUDE STRUCTURE bapi1093_0.
DATA: END OF ls_ex_rate.

DATA: lv_ex_rate TYPE bapi1093_0.

DATA: BEGIN OF ls_return OCCURS 0.
    INCLUDE STRUCTURE bapiret1.
DATA: END OF ls_return.

ls_fr_curr-sign   = 'I'.
ls_fr_curr-option = 'EQ'.
*LV_FR_CURR-LOW = 'EQ'.

ls_to_curr-sign   = 'I'.
ls_to_curr-option = 'EQ'.
ls_to_curr-low = 'INR'.
APPEND ls_to_curr .


* ALV RELATED DATA
*---------------------------------------------------------------------*
*     STRUCTURES, VARIABLES AND CONSTANTS FOR ALV
*---------------------------------------------------------------------*
TYPE-POOLS : slis.
DATA: fieldcatalog TYPE slis_t_fieldcat_alv WITH HEADER LINE,
      fieldlayout  TYPE slis_layout_alv,

      it_fcat      TYPE slis_t_fieldcat_alv,
      wa_fcat      TYPE LINE OF slis_t_fieldcat_alv. " SLIS_T_FIELDCAT_ALV.

DATA: i_sort             TYPE slis_t_sortinfo_alv, " SORT
      gt_events          TYPE slis_t_event,        " EVENTS
      i_list_top_of_page TYPE slis_t_listheader,   " TOP-OF-PAGE
      wa_layout          TYPE  slis_layout_alv..            " LAYOUT WORKAREA
************************************************************************
*                                CONSTANTS                             *
************************************************************************
CONSTANTS:
  c_formname_top_of_page   TYPE slis_formname
                                   VALUE 'TOP_OF_PAGE',
  c_formname_pf_status_set TYPE slis_formname
                                 VALUE 'PF_STATUS_SET',
  c_s                      TYPE c VALUE 'S',
  c_h                      TYPE c VALUE 'H'.

INITIALIZATION.

  REFRESH : it_vbak, it_vbap, it_vbkd, it_mska,
         it_vbrp, it_vbep, it_konv.

  CLEAR  : wa_vbak, wa_vbap, wa_vbkd, wa_mska,
           wa_vbrp, wa_vbep, wa_konv.

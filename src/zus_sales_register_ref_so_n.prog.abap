*&---------------------------------------------------------------------*
*& Report ZUS_SALES_REGISTER_REF_SO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_SALES_REGISTER_REF_SO_N.


TYPE-POOLS:SLIS.

DATA:
  TMP_VBELN TYPE VBRK-VBELN,
  TMP_FKDAT TYPE VBRK-FKDAT,
  TMP_SO    TYPE VBAK-VBELN,
  TMP_KUNNR TYPE KNA1-KUNNR,
  DMP_VBELN TYPE VBRK-VBELN,
  DMP_ORD   TYPE VBAK-VBELN,
  TMP_WERKS TYPE VBRP-WERKS.


TYPES:
  BEGIN OF T_SALES_INV_HDR,
    VBELN     TYPE VBRK-VBELN,
    FKART     TYPE VBRK-FKART,
    FKTYP     TYPE VBRK-FKTYP,
    WAERK     TYPE VBRK-WAERK,
    VKORG     TYPE VBRK-VKORG,
    VTWEG     TYPE VBRK-VTWEG,
    KNUMV     TYPE VBRK-KNUMV,
    FKDAT     TYPE VBRK-FKDAT,
    KUNAG     TYPE VBRK-KUNAG,
    KTGRD     TYPE VBRK-KTGRD,
    FKSTO     TYPE VBRK-FKSTO,
    XBLNR     TYPE VBRK-XBLNR,
    ZUONR     TYPE VBRK-ZUONR,
    KURRF_DAT TYPE VBRK-KURRF_DAT,
    KURRF     TYPE VBRK-KURRF,
    KUNRG     TYPE VBRK-KUNRG,
    KIDNO     TYPE VBRK-KIDNO,
  END OF T_SALES_INV_HDR,
  TT_SALES_INV_HDR TYPE STANDARD TABLE OF T_SALES_INV_HDR.

TYPES:
  BEGIN OF T_SALES_INV_ITEM,
    VBELN TYPE VBRP-VBELN,
    POSNR TYPE VBRP-POSNR,
    FKIMG TYPE VBRP-FKIMG,
    VRKME TYPE VBRP-VRKME,
    KURSK TYPE VBRP-KURSK,
    NETWR TYPE VBRP-NETWR,
    VGBEL TYPE VBRP-VGBEL,
    VGPOS TYPE VBRP-VGPOS,
    VGTYP TYPE VBRP-VGTYP,
    AUBEL TYPE VBRP-AUBEL,
    AUPOS TYPE VBRP-AUPOS,
    MATNR TYPE VBRP-MATNR,
    ARKTX TYPE VBRP-ARKTX,
    CHARG TYPE VBRP-CHARG,
    PRODH TYPE VBRP-PRODH,
    WERKS TYPE VBRP-WERKS,
  END OF T_SALES_INV_ITEM,
  TT_SALES_INV_ITEM TYPE STANDARD TABLE OF T_SALES_INV_ITEM.

TYPES:
  BEGIN OF T_SALES_ORD_HDR,
    VBELN       TYPE VBAK-VBELN,
    AUDAT       TYPE VBAK-AUDAT,
    AUART       TYPE VBAK-AUART,
    VKBUR       TYPE VBAK-VKBUR,
    VDATU       TYPE VBAK-VDATU,
    BSTNK       TYPE VBAK-BSTNK,
    ZLDFROMDATE TYPE VBAK-ZLDFROMDATE,
    ZLDPERWEEK  TYPE VBAK-ZLDPERWEEK,
    ZLDMAX      TYPE VBAK-ZLDMAX,
  END OF T_SALES_ORD_HDR,
  TT_SALES_ORD_HDR TYPE STANDARD TABLE OF T_SALES_ORD_HDR.

TYPES:
  BEGIN OF T_SALES_PARTNER,
    VBELN TYPE VBPA-VBELN,
    KUNNR TYPE VBPA-KUNNR,
    PARVW TYPE VBPA-PARVW,
  END OF T_SALES_PARTNER,
  TT_SALES_PARTNER TYPE STANDARD TABLE OF T_SALES_PARTNER.

TYPES:
  BEGIN OF T_SALES_ORD_ITEM,
    VBELN   TYPE VBAP-VBELN,
    POSNR   TYPE VBAP-POSNR,
    MATNR   TYPE VBAP-MATNR,
    KDMAT   TYPE VBAP-KDMAT,
    DELDATE TYPE VBAP-DELDATE,
  END OF T_SALES_ORD_ITEM,
  TT_SALES_ORD_ITEM TYPE STANDARD TABLE OF T_SALES_ORD_ITEM.

TYPES:
  BEGIN OF T_CUST_INFO,
    KUNNR TYPE KNA1-KUNNR,
    NAME1 TYPE KNA1-NAME1,
    ORT01 TYPE KNA1-ORT01,
    LAND1 TYPE KNA1-LAND1,
    REGIO TYPE KNA1-REGIO,
    ADRNR TYPE KNA1-ADRNR,
    STCD3 TYPE KNA1-STCD3,
    BRSCH TYPE KNA1-BRSCH,
    PSTLZ TYPE KNA1-PSTLZ,
  END OF T_CUST_INFO,
  TT_CUST_INFO TYPE STANDARD TABLE OF T_CUST_INFO.

TYPES:BEGIN OF TY_KNVV,
        KUNNR TYPE KNVV-KUNNR,
        KDGRP TYPE KNVV-KDGRP,
        BZIRK TYPE KNVV-BZIRK,
        VKBUR TYPE KNVV-VKBUR,
      END OF TY_KNVV.

TYPES:BEGIN OF TY_T016T,
        SPRAS TYPE T016T-SPRAS,
        BRSCH TYPE T016T-BRSCH,
        BRTXT TYPE T016T-BRTXT,
      END OF TY_T016T,

      BEGIN OF TY_TVKBT,
        SPRAS TYPE TVKBT-SPRAS,
        VKBUR TYPE TVKBT-VKBUR,
        BEZEI TYPE TVKBT-BEZEI,
      END OF TY_TVKBT,

      BEGIN OF TY_T171T,
        SPRAS TYPE T171T-SPRAS,
        BZIRK TYPE T171T-BZIRK,
        BZTXT TYPE T171T-BZTXT,
      END OF TY_T171T,

      BEGIN OF TY_T151T,
        SPRAS TYPE T151T-SPRAS,
        KDGRP TYPE T151T-KDGRP,
        KTEXT TYPE T151T-KTEXT,
      END OF TY_T151T,

      BEGIN OF TY_VBFA,
        VBELV TYPE VBFA-VBELV,
        VBELN TYPE VBFA-VBELN,
        ERDAT TYPE VBFA-ERDAT,
        MJAHR TYPE VBFA-MJAHR,
      END OF TY_VBFA.

TYPES:
  BEGIN OF T_T005U,
    LAND1 TYPE T005U-LAND1,
    BLAND TYPE T005U-BLAND,
    BEZEI TYPE ZGST_REGION-BEZEI,
  END OF T_T005U,
  TT_T005U TYPE STANDARD TABLE OF T_T005U.

TYPES:
  BEGIN OF T_ZGST_REGION,
    GST_REGION TYPE ZGST_REGION-GST_REGION,
    BEZEI      TYPE ZGST_REGION-BEZEI,
  END OF T_ZGST_REGION,
  TT_ZGST_REGION TYPE STANDARD TABLE OF T_ZGST_REGION.

TYPES:
  BEGIN OF T_KNVI,
    KUNNR TYPE KNVI-KUNNR,
    TAXKD TYPE KNVI-TAXKD,
  END OF T_KNVI,
  TT_KNVI TYPE STANDARD TABLE OF T_KNVI.

TYPES:
  BEGIN OF T_TSKDT,
    TATYP TYPE TSKDT-TATYP,
    TAXKD TYPE TSKDT-TAXKD,
    VTEXT TYPE TSKDT-VTEXT,
  END OF T_TSKDT,
  TT_TSKDT TYPE STANDARD TABLE OF T_TSKDT.

TYPES:
  BEGIN OF T_SCHEDULE_LINE,
    VBELN TYPE VBEP-VBELN,
    POSNR TYPE VBEP-POSNR,
    EDATU TYPE VBEP-EDATU,
  END OF T_SCHEDULE_LINE,
  TT_SCHEDULE_LINE TYPE STANDARD TABLE OF T_SCHEDULE_LINE.

TYPES:
  BEGIN OF T_TVKTT,
    KTGRD TYPE TVKTT-KTGRD,
    VTEXT TYPE TVKTT-VTEXT,
  END OF T_TVKTT,
  TT_TVKTT TYPE STANDARD TABLE OF T_TVKTT.

TYPES:
  BEGIN OF T_CONDITIONS,
    KNUMV   TYPE PRCD_ELEMENTS-KNUMV,
    KPOSN   TYPE PRCD_ELEMENTS-KPOSN,
    KSCHL   TYPE PRCD_ELEMENTS-KSCHL,
    KBETR   TYPE PRCD_ELEMENTS-KBETR,
    MWSK1   TYPE PRCD_ELEMENTS-MWSK1,
    KWERT   TYPE PRCD_ELEMENTS-KWERT,
    KSTAT   TYPE PRCD_ELEMENTS-KSTAT,
    KWERT_K TYPE PRCD_ELEMENTS-KWERT_K,
  END OF T_CONDITIONS,
  TT_CONDITIONS TYPE STANDARD TABLE OF T_CONDITIONS.

TYPES:
  BEGIN OF T_T007S,
    MWSKZ TYPE T007S-MWSKZ,
    TEXT1 TYPE T007S-TEXT1,
  END OF T_T007S,
  TT_T007S TYPE STANDARD TABLE OF T_T007S.

TYPES:
  BEGIN OF T_ACCOUNTING_DOC_ITEM,
    BUKRS TYPE BSEG-BUKRS,
    BELNR TYPE BSEG-BELNR,
    GJAHR TYPE BSEG-GJAHR,
    BUZEI TYPE BSEG-BUZEI,
    VBELN TYPE BSEG-VBELN,
    VBEL2 TYPE BSEG-VBEL2,
    POSN2 TYPE BSEG-POSN2,
    HKONT TYPE BSEG-HKONT,
    KUNNR TYPE BSEG-KUNNR,
    ZFBDT TYPE BSEG-ZFBDT,
    MWSK1 TYPE BSEG-MWSK1,
    DMBT1 TYPE BSEG-DMBT1,
    REBZG TYPE BSEG-REBZG,
    REBZJ TYPE BSEG-REBZJ,
  END OF T_ACCOUNTING_DOC_ITEM,
  TT_ACCOUNTING_DOC_ITEM TYPE STANDARD TABLE OF T_ACCOUNTING_DOC_ITEM.

TYPES:
  BEGIN OF T_ACCOUNTING_MDOC_ITEM,
    BUKRS TYPE BSEG-BUKRS,
    BELNR TYPE BSEG-BELNR,
    GJAHR TYPE BSEG-GJAHR,
    BUZEI TYPE BSEG-BUZEI,
    BUZID TYPE BSEG-BUZID,
    SHKZG TYPE BSEG-SHKZG,
    DMBTR TYPE BSEG-DMBTR,
    MENGE TYPE BSEG-MENGE,
  END OF T_ACCOUNTING_MDOC_ITEM,
  TT_ACCOUNTING_MDOC_ITEM TYPE STANDARD TABLE OF T_ACCOUNTING_MDOC_ITEM.

TYPES:
  BEGIN OF T_ACCOUNTING_DOC_HDR,
    BUKRS TYPE BKPF-BUKRS,
    BELNR TYPE BKPF-BELNR,
    GJAHR TYPE BKPF-GJAHR,
    BLART TYPE BKPF-BLART,
    XBLNR TYPE BKPF-XBLNR,
    BKTXT TYPE BKPF-BKTXT,
  END OF T_ACCOUNTING_DOC_HDR,
  TT_ACCOUNTING_DOC_HDR TYPE STANDARD TABLE OF T_ACCOUNTING_DOC_HDR.

TYPES:
  BEGIN OF T_MAT_MASTER,
    MATNR   TYPE MARA-MATNR,
    WRKST   TYPE MARA-WRKST,
    ZSERIES TYPE MARA-ZSERIES,
    ZSIZE   TYPE MARA-ZSIZE,
    BRAND   TYPE MARA-BRAND,
    MOC     TYPE MARA-MOC,
    TYPE    TYPE MARA-TYPE,
  END OF T_MAT_MASTER,
  TT_MAT_MASTER TYPE STANDARD TABLE OF T_MAT_MASTER.

TYPES:
  BEGIN OF T_MATERIAL_VAL,
    MATNR TYPE MBEW-MATNR,
    BWKEY TYPE MBEW-BWKEY,
    BWTAR TYPE MBEW-BWTAR,
    STPRS TYPE MBEW-STPRS,
    BKLAS TYPE MBEW-BKLAS,
  END OF T_MATERIAL_VAL,
  TT_MATERIAL_VAL TYPE STANDARD TABLE OF T_MATERIAL_VAL.

TYPES:
  BEGIN OF T_MARC,
    MATNR TYPE MARC-MATNR,
    WERKS TYPE MARC-WERKS,
    STEUC TYPE MARC-STEUC,
  END OF T_MARC,
  TT_MARC TYPE STANDARD TABLE OF T_MARC.

TYPES:
  BEGIN OF T_SALES_BUSS,
    VBELN TYPE VBKD-VBELN,
    POSNR TYPE VBKD-POSNR,
    TRATY TYPE VBKD-TRATY,
  END OF T_SALES_BUSS,
  TT_SALES_BUSS TYPE STANDARD TABLE OF T_SALES_BUSS.

TYPES:
  BEGIN OF T_SKAT,
    SAKNR TYPE SKAT-SAKNR,
    TXT20 TYPE SKAT-TXT20,
  END OF T_SKAT,
  TT_SKAT TYPE STANDARD TABLE OF T_SKAT.

TYPES:
  BEGIN OF T_ADRC,
    ADDRNUMBER TYPE ADRC-ADDRNUMBER,
    NAME1      TYPE ADRC-NAME1,
    CITY1      TYPE ADRC-CITY1,
    CITY2      TYPE ADRC-CITY2,
    POST_CODE1 TYPE ADRC-POST_CODE1,
    STREET     TYPE ADRC-STREET,
    STR_SUPPL1 TYPE ADRC-STR_SUPPL1,
    STR_SUPPL2 TYPE ADRC-STR_SUPPL2,
    STR_SUPPL3 TYPE ADRC-STR_SUPPL3,
    LOCATION   TYPE ADRC-LOCATION,
    COUNTRY    TYPE ADRC-COUNTRY,
    HOUSE_NUM1 TYPE ADRC-HOUSE_NUM1,
  END OF T_ADRC,
  TT_ADRC TYPE STANDARD TABLE OF T_ADRC.

TYPES:BEGIN OF TY_VBPA,
        VBELN TYPE VBPA-VBELN,
        KUNNR TYPE VBPA-KUNNR,
        PARVW TYPE VBPA-PARVW,
      END OF TY_VBPA,

      BEGIN OF TY_KNA1,
        KUNNR TYPE KNA1-KUNNR,
        NAME1 TYPE KNA1-NAME1,
      END OF TY_KNA1.

DATA : IT_VBPA TYPE TABLE OF TY_VBPA,
       WA_VBPA TYPE          TY_VBPA,

       IT_KNA1 TYPE TABLE OF TY_KNA1,
       WA_KNA1 TYPE          TY_KNA1,

       IT_VBFA TYPE TABLE OF TY_VBFA,
       WA_VBFA TYPE          TY_VBFA.

TYPES :
  BEGIN OF T_SAL_TXT,
    SAL_TXT TYPE STRING,
  END OF T_SAL_TXT,
  TT_SAL_TXT TYPE STANDARD TABLE OF T_SAL_TXT.

*********************************************

****************************25-11-2019  AP ***********************

TYPES : BEGIN OF TY_BKPF,
          BUKRS TYPE BKPF-BUKRS,
          BELNR TYPE BKPF-BELNR,
          GJAHR TYPE BKPF-GJAHR,
          XBLNR TYPE BKPF-XBLNR,
        END OF TY_BKPF.

DATA : IT_BKPF TYPE STANDARD TABLE OF TY_BKPF,
       WA_BKPF TYPE TY_BKPF.


DATA : IT_BKPF1 TYPE STANDARD TABLE OF T_ACCOUNTING_DOC_HDR,
       WA_BKPF1 TYPE T_ACCOUNTING_DOC_HDR.



TYPES : BEGIN OF LS_FIELDNAME,
          FIELD_NAME(40),
        END OF LS_FIELDNAME.

DATA : IT_FIELDNAME TYPE TABLE OF LS_FIELDNAME,
       WA_FIELDNAME TYPE LS_FIELDNAME,
       GV_GJAHR     TYPE BSEG-GJAHR,
       GV_BELNR     TYPE BSEG-BELNR,
       GV_DMBTR     TYPE BSEG-DMBTR,
       GV_VBELN     TYPE BSEG-VBELN,
       GV_DMBTR2    TYPE BSEG-DMBTR,
       GV_SHKZG     TYPE BSEG-SHKZG.




*****************************************
TYPES:
  BEGIN OF T_FINAL,
    WERKS        TYPE VBRP-WERKS,      "Plant
    VBELN        TYPE VBRK-VBELN,      "Inv No
    ORIG_NO      TYPE VBFA-VBELN,
    ORIG_DT      TYPE VBFA-ERDAT,
    STATUS       TYPE C,                       "Invoice Status
    POSNR        TYPE VBRP-POSNR,      "Line Item
    FKART        TYPE VBRK-FKART,      "Billing Type
    FKDAT        TYPE VBRK-FKDAT,
    AUART        TYPE VBAK-AUART,      "Sales Order Type
    VKBUR        TYPE VBAK-VKBUR,      "Sales Office
    AUBEL        TYPE VBRP-AUBEL,      "Sales Order No
    AUDAT        TYPE VBAK-AUDAT,      "Sales Order Date
    VDATU        TYPE VBAK-VDATU,      "Req Delivery Date
    EDATU        TYPE VBEP-EDATU,        "Delivery Date
    BSTNK        TYPE VBAK-BSTNK,      "Customer Ref No.
    KUNAG        TYPE KNA1-KUNNR,      "Customer Code
    NAME1        TYPE KNA1-NAME1,        "Customer Name
    ADDRESS      TYPE STRING,      "" ** Address
    PARTNER      TYPE KNA1-KUNNR,
    PART_NAME    TYPE KNA1-NAME1,
    KDGRP        TYPE KNVV-KDGRP,
    KTEXT        TYPE CHAR25,
    SALE_OFF     TYPE KNVV-VKBUR,
    ORG_UNIT     TYPE CHAR25,
    BZIRK        TYPE KNVV-BZIRK,
    BZTXT        TYPE CHAR25,
    BRSCH        TYPE KNA1-BRSCH,
    BRTXT        TYPE CHAR25,
    GST_REGION   TYPE ZGST_REGION-GST_REGION,  "State Code
    BEZEI        TYPE T005U-BEZEI,             "Region
    NAME1_SH     TYPE KNA1-NAME1,
*    gst_region_sh TYPE zgst_region-gst_region,  "Ship To State Code
    BEZEI_SH     TYPE T005U-BEZEI,             " Ship To Region
    MATNR        TYPE VBRP-MATNR,      "Material Code
    WRKST        TYPE MARA-WRKST,      "Series
    ARKTX        TYPE VBRP-ARKTX,      "Sales Text
    LONG_TXT     TYPE CHAR100,         "Long Text for Material
    BKLAS        TYPE MBEW-BKLAS,
    KDMAT        TYPE VBAP-KDMAT,              "Customer Item Code
    FKIMG        TYPE VBRP-FKIMG,      "Invoice Qty char15, "
    VRKME        TYPE VBRP-VRKME,              "Unit
    NETPR        TYPE CHAR100,              "Rate
    BLART        TYPE BKPF-BLART,              "FI Document Type
    BELNR        TYPE BKPF-BELNR,              "FI Document No.
    MWSKZ        TYPE PRCD_ELEMENTS-MWSK1,              "Taxcode
    TAX_TXT      TYPE T007S-TEXT1,             "Tax Code Description
    BASE_VAL     TYPE DMBTR,   "char100,        "Base Price
    WAERK        TYPE VBRK-WAERK,      "Currency
    DIS          TYPE DMBTR, "char100,        "Discount
    VAL_INR      TYPE DMBTR,      "Amount in Local Currency
    ULOC_P       TYPE PRCD_ELEMENTS-KBETR,              "ULOC %
    ULOC         TYPE DMBTR,        "ULOC
    USTA_P       TYPE PRCD_ELEMENTS-KBETR,              "USTA %
    USTA         TYPE DMBTR,        "USTA
    UCOU_P       TYPE PRCD_ELEMENTS-KBETR,              "UCOU %
    UCOU         TYPE DMBTR,        "JOIG
    PF_VAL       TYPE DMBTR,        "P&F
    FRT          TYPE DMBTR,        "Freight
    TES          TYPE DMBTR,              "Testing Charge
    ASS_VAL      TYPE DMBTR,        "Assessable
    VTEXT        TYPE TVKTT-VTEXT,       "Sales Type Text
*    stprs         TYPE char100,        "Cost
*    stprs1        TYPE char100,        "Cost
    ZSERIES      TYPE MARA-ZSERIES,      "Series
    ZSIZE        TYPE MARA-ZSIZE,        "Size
    BRAND        TYPE MARA-BRAND,              "Brand
    MOC          TYPE MARA-MOC,                "MOC
    TYPE         TYPE MARA-TYPE,               "Type
    REF_DATE     TYPE STRING,
    PSTLZ        TYPE KNA1-PSTLZ,
    TRACK        TYPE CHAR50,
    INT_PR2      TYPE PRCD_ELEMENTS-KWERT,
    FI_DES       TYPE CHAR100,
    BILL_STREET  TYPE CHAR100,
    BILL_STR1    TYPE ADRC-STR_SUPPL1,
    BILL_STR2    TYPE ADRC-STR_SUPPL2,
    BILL_POST    TYPE ADRC-POST_CODE1,
    BILL_CITY    TYPE ADRC-CITY1,
    BILL_REG     TYPE CHAR50,
    BILL_COUNTRY TYPE CHAR20,
    SHIP_CODE    TYPE KNA1-KUNNR,
    SHIP_STATE   TYPE ZGST_REGION-GST_REGION,
    UOTH_P       TYPE PRCD_ELEMENTS-KBETR,              "othr tax%
    UOTH         TYPE DMBTR,        "othr tax
    ORT01        TYPE KNA1-ORT01,
*****    XBLNR        TYPE MKPF-XBLNR, "AP
*****    MBLNR        TYPE MKPF-MBLNR, "AP
*****    MJAHR        TYPE MKPF-MJAHR, "AP
    BELNR1       TYPE BKPF-BELNR,
    INT_PR3      TYPE PRCD_ELEMENTS-KWERT,
  END OF T_FINAL,
  TT_FINAL TYPE STANDARD TABLE OF T_FINAL.

DATA:
  GT_FINAL TYPE TT_FINAL.

TYPES:
  BEGIN OF TY_FINAL,
    WERKS        TYPE VBRP-WERKS,      "Plant
    VBELN        TYPE VBRK-VBELN,      "Inv No
    ORIG_NO      TYPE VBFA-VBELN,
    ORIG_DT      TYPE CHAR11,
    STATUS       TYPE C,                       "Invoice Status
    POSNR        TYPE VBRP-POSNR,      "Line Item
    FKART        TYPE VBRK-FKART,      "Billing Type
    FKDAT        TYPE CHAR11,
    AUART        TYPE VBAK-AUART,      "Sales Order Type
    VKBUR        TYPE VBAK-VKBUR,      "Sales Office
    AUBEL        TYPE VBRP-AUBEL,      "Sales Order No
    AUDAT        TYPE CHAR11, "vbak-audat,      "Sales Order Date
    VDATU        TYPE CHAR11, "vbak-vdatu,      "Req Delivery Date
    EDATU        TYPE CHAR11, "vbep-edatu,        "Delivery Date
    BSTNK        TYPE VBAK-BSTNK,      "Customer Ref No.
    KUNAG        TYPE KNA1-KUNNR,      "Customer Code
    NAME1        TYPE KNA1-NAME1,        "Customer Name
    ADDRESS      TYPE STRING,      "" ** Address
    PARTNER      TYPE KNA1-KUNNR,
    PART_NAME    TYPE KNA1-NAME1,
    KDGRP        TYPE KNVV-KDGRP,
    KTEXT        TYPE CHAR25,
    SALE_OFF     TYPE KNVV-VKBUR,
    ORG_UNIT     TYPE CHAR25,
    BZIRK        TYPE KNVV-BZIRK,
    BZTXT        TYPE CHAR25,
    BRSCH        TYPE KNA1-BRSCH,
    BRTXT        TYPE CHAR25,
    GST_REGION   TYPE ZGST_REGION-GST_REGION,  "State Code
    BEZEI        TYPE T005U-BEZEI,             "Region
    NAME1_SH     TYPE KNA1-NAME1,
*    gst_region_sh TYPE zgst_region-gst_region,  "Ship To State Code
    BEZEI_SH     TYPE T005U-BEZEI,             " Ship To Region
    MATNR        TYPE VBRP-MATNR,      "Material Code
    WRKST        TYPE MARA-WRKST,
    ARKTX        TYPE VBRP-ARKTX,      "Sales Text
    LONG_TXT     TYPE CHAR100,         "Long Text for Material
    BKLAS        TYPE MBEW-BKLAS,
    KDMAT        TYPE VBAP-KDMAT,              "Customer Item Code
    FKIMG        TYPE CHAR15, "vbrp-fkimg,      "Invoice Qty
    VRKME        TYPE VBRP-VRKME,              "Unit
    NETPR        TYPE CHAR100,              "Rate
    BLART        TYPE BKPF-BLART,              "FI Document Type
    BELNR        TYPE BKPF-BELNR,              "FI Document No.
    MWSKZ        TYPE PRCD_ELEMENTS-MWSK1,              "Taxcode
    TAX_TXT      TYPE T007S-TEXT1,             "Tax Code Description
    BASE_VAL     TYPE CHAR100,        "Base Price
    WAERK        TYPE VBRK-WAERK,      "Currency
    DIS          TYPE CHAR100,        "Discount
    VAL_INR      TYPE CHAR100,      "Amount in Local Currency
    ULOC_P       TYPE CHAR15,    "konv-kbetr,              "ULOC %
    ULOC         TYPE CHAR100,        "ULOC
    USTA_P       TYPE CHAR15,    "konv-kbetr,              "USTA %
    USTA         TYPE CHAR100,        "USTA
    UCOU_P       TYPE CHAR15,    "konv-kbetr,              "UCOU %
    UCOU         TYPE CHAR100,        "JOIG
    PF_VAL       TYPE CHAR100,        "P&F
    FRT          TYPE CHAR100,        "Freight
    TES          TYPE CHAR100,              "Testing Charge
    ASS_VAL      TYPE CHAR100,        "Assessable
    VTEXT        TYPE TVKTT-VTEXT,       "Sales Type Text
*    stprs         TYPE char100,        "Cost
*    stprs1        TYPE char100,        "Cost
    ZSERIES      TYPE MARA-ZSERIES,      "Series
    ZSIZE        TYPE MARA-ZSIZE,        "Size
    BRAND        TYPE MARA-BRAND,              "Brand
    MOC          TYPE MARA-MOC,                "MOC
    TYPE         TYPE MARA-TYPE,               "Type
    REF_DATE     TYPE CHAR11,
    PSTLZ        TYPE KNA1-PSTLZ,
    TRACK        TYPE CHAR50,
    INT_PR2      TYPE CHAR15,
    FI_DES       TYPE CHAR100,
    BILL_STREET  TYPE CHAR100,
    BILL_STR1    TYPE CHAR50,
    BILL_STR2    TYPE CHAR50,
    BILL_POST    TYPE CHAR20,
    BILL_CITY    TYPE CHAR50,
    BILL_REG     TYPE CHAR50,
    BILL_COUNTRY TYPE CHAR20,
    SHIP_CODE    TYPE CHAR20,
    SHIP_STATE   TYPE CHAR10,
    UOTH_P       TYPE CHAR15,               "othr tax%
    UOTH         TYPE CHAR100,   "othr tax
    ORT01        TYPE CHAR50,
    BELNR1       TYPE CHAR10,
    INT_PR3      TYPE CHAR15,
  END OF TY_FINAL.

DATA: IT_FINAL TYPE TABLE OF TY_FINAL,
      WA_FINAL TYPE          TY_FINAL.


SELECTION-SCREEN: BEGIN OF BLOCK B1 WITH FRAME TITLE XYZ.
SELECT-OPTIONS: SO_VBELN FOR TMP_VBELN,
                SO_FKDAT FOR TMP_FKDAT OBLIGATORY DEFAULT '20190101' TO SY-DATUM,
                SO_ORD   FOR TMP_SO,
                SO_KUNNR FOR TMP_KUNNR.
PARAMETERS : SO_WERKS TYPE VBRP-WERKS OBLIGATORY  DEFAULT 'US01'.
SELECTION-SCREEN: END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B5 WITH FRAME TITLE ABC .
PARAMETERS P_DOWN AS CHECKBOX.
PARAMETERS P_FOLDER LIKE RLGRAP-FILENAME DEFAULT 'E:\delval\usa'.
SELECTION-SCREEN END OF BLOCK B5.

*SELECTION-SCREEN BEGIN OF BLOCK b6 WITH FRAME TITLE pqr .
*PARAMETERS p_own AS CHECKBOX.
**PARAMETERS p_folder LIKE rlgrap-filename DEFAULT 'E:\delval\temp'.
*SELECTION-SCREEN END OF BLOCK b6.

INITIALIZATION.
  XYZ = 'Select Options'(tt1).
  ABC = 'Download File'(tt2).
*  pqr = 'Download File to Own PC'(tt3).

AT SELECTION-SCREEN.
  IF NOT SO_VBELN IS INITIAL.
    SELECT SINGLE VBELN
            FROM  VBRK
            INTO  DMP_VBELN
            WHERE VBELN IN SO_VBELN.
    IF NOT SY-SUBRC IS  INITIAL.
      MESSAGE 'Please Check Billing Document No.' TYPE 'E'.
    ENDIF.

  ENDIF.

  IF NOT SO_ORD IS INITIAL.
    SELECT SINGLE AUBEL
            FROM  VBRP
            INTO  DMP_ORD
            WHERE AUBEL IN SO_ORD.
    IF NOT SY-SUBRC IS  INITIAL.
      MESSAGE 'Please Check Sales Order No.' TYPE 'E'.
    ENDIF.

  ENDIF.

START-OF-SELECTION.
  IF SO_WERKS NE 'PL01'.
    PERFORM FETCH_DATA CHANGING GT_FINAL.
    PERFORM DISPLAY USING GT_FINAL.
  ELSE .

    MESSAGE 'This Report valid For US01 & US02 Plant' TYPE 'S'.

  ENDIF.


*&---------------------------------------------------------------------*
*&      Form  FETCH_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GT_FINAL  text
*----------------------------------------------------------------------*
FORM FETCH_DATA  CHANGING CT_FINAL TYPE TT_FINAL.
  DATA:
    LT_SALES_INV_HDR        TYPE TT_SALES_INV_HDR,
    LS_SALES_INV_HDR        TYPE T_SALES_INV_HDR,
    LS_SALES_INV_HDR_N      TYPE T_SALES_INV_HDR,
    LS_SALES_INV_HDR_N1     TYPE T_SALES_INV_HDR,
    LT_SALES_INV_ITEM       TYPE TT_SALES_INV_ITEM,
    LS_SALES_INV_ITEM       TYPE T_SALES_INV_ITEM,
    LT_SALES_ORD_HDR        TYPE TT_SALES_ORD_HDR,
    LS_SALES_ORD_HDR        TYPE T_SALES_ORD_HDR,
    LT_SALES_ORD_ITEM       TYPE TT_SALES_ORD_ITEM,
    LS_SALES_ORD_ITEM       TYPE T_SALES_ORD_ITEM,
    LT_SALES_PARTNER        TYPE TT_SALES_PARTNER,
    LS_SALES_PARTNER        TYPE T_SALES_PARTNER,
    LT_CUST_INFO            TYPE TT_CUST_INFO,
    LS_CUST_INFO            TYPE T_CUST_INFO,
    LT_BILL_TO              TYPE TT_CUST_INFO,
    LS_BILL_TO              TYPE T_CUST_INFO,
    LT_SCHEDULE_LINE        TYPE TT_SCHEDULE_LINE,
    LS_SCHEDULE_LINE        TYPE T_SCHEDULE_LINE,
    LT_TVKTT                TYPE TT_TVKTT,
    LS_TVKTT                TYPE T_TVKTT,
    LT_CONDITIONS           TYPE TT_CONDITIONS,
    LS_CONDITIONS           TYPE T_CONDITIONS,
    LT_MAT_MASTER           TYPE TT_MAT_MASTER,
    LS_MAT_MASTER           TYPE T_MAT_MASTER,
    LT_MATERIAL_VAL         TYPE TT_MATERIAL_VAL,
    LS_MATERIAL_VAL         TYPE T_MATERIAL_VAL,
    LT_MARC                 TYPE TT_MARC,
    LS_MARC                 TYPE T_MARC,
    LT_SALES_BUSS           TYPE TT_SALES_BUSS,
    LS_SALES_BUSS           TYPE T_SALES_BUSS,
    LT_T005U                TYPE TT_T005U,
    LS_T005U                TYPE T_T005U,
    LT_ZGST_REGION          TYPE TT_ZGST_REGION,
    LS_ZGST_REGION          TYPE T_ZGST_REGION,
    LT_T007S                TYPE TT_T007S,
    LS_T007S                TYPE T_T007S,
    LT_KNVI                 TYPE TT_KNVI,
    LS_KNVI                 TYPE T_KNVI,
    LT_TSKDT                TYPE TT_TSKDT,
    LS_TSKDT                TYPE T_TSKDT,
    LT_ACCOUNTING_DOC_ITEM  TYPE TT_ACCOUNTING_DOC_ITEM,
    LT_ACCOUNTING_MDOC_ITEM TYPE TT_ACCOUNTING_MDOC_ITEM,
    LT_ACCOUNTING_DOC_ITM1  TYPE TT_ACCOUNTING_DOC_ITEM,   "For GL Account
    LS_ACCOUNTING_DOC_ITEM  TYPE T_ACCOUNTING_DOC_ITEM,
    LT_ACCOUNTING_DOC_HDR   TYPE TT_ACCOUNTING_DOC_HDR,
    LS_ACCOUNTING_DOC_HDR   TYPE T_ACCOUNTING_DOC_HDR,
    LT_SKAT                 TYPE TT_SKAT,
    LS_SKAT                 TYPE T_SKAT,
    LS_FINAL                TYPE T_FINAL,
    WS_FINAL                TYPE T_FINAL,
    LT_ADRC                 TYPE TT_ADRC,
    LS_ADRC                 TYPE T_ADRC,
    LT_BILL_ADRC            TYPE TT_ADRC,
    LS_BILL_ADRC            TYPE T_ADRC,
    LS_SAL_TXT              TYPE T_SAL_TXT.

  DATA : LS_ACCOUNTING_MDOC_ITEM TYPE T_ACCOUNTING_MDOC_ITEM.

  DATA:IT_KNVV  TYPE TABLE OF TY_KNVV,
       WA_KNVV  TYPE          TY_KNVV,

       IT_T016T TYPE TABLE OF TY_T016T,
       WA_T016T TYPE          TY_T016T,

       IT_TVKBT TYPE TABLE OF TY_TVKBT,
       WA_TVKBT TYPE          TY_TVKBT,

       IT_T171T TYPE TABLE OF TY_T171T,
       WA_T171T TYPE          TY_T171T,

       IT_T151T TYPE TABLE OF TY_T151T,
       WA_T151T TYPE          TY_T151T.

  DATA:
    LV_ID    TYPE THEAD-TDNAME,
    LT_LINES TYPE STANDARD TABLE OF TLINE,
    LS_LINES TYPE TLINE.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      TEXT       = 'Reading data...'(i01)
      PERCENTAGE = 1.

  IF NOT SO_ORD IS INITIAL.

    SELECT VBELN
           POSNR
           FKIMG
           VRKME
           KURSK
           NETWR
           VGBEL
           VGPOS
           VGTYP
           AUBEL
           AUPOS
           MATNR
           ARKTX
           CHARG
           PRODH
           WERKS
      FROM VBRP
      INTO TABLE LT_SALES_INV_ITEM
      WHERE VBELN IN SO_VBELN
    AND   AUBEL IN SO_ORD
    AND  WERKS = SO_WERKS.


    IF SY-SUBRC IS INITIAL.

      SELECT VBELN
             FKART
             FKTYP
             WAERK
             VKORG
             VTWEG
             KNUMV
             FKDAT
             KUNAG
             KTGRD
             FKSTO
             XBLNR
             ZUONR
             KURRF_DAT
             KURRF
             KUNRG
             KIDNO
        FROM VBRK
        INTO TABLE LT_SALES_INV_HDR
        FOR ALL ENTRIES IN LT_SALES_INV_ITEM
        WHERE VBELN = LT_SALES_INV_ITEM-VBELN
        AND   FKDAT IN SO_FKDAT
        AND   KUNAG IN SO_KUNNR.

    ELSE.
      MESSAGE 'Data Not Found' TYPE 'I'.
    ENDIF.
  ELSE.
    SELECT VBELN
           FKART
           FKTYP
           WAERK
           VKORG
           VTWEG
           KNUMV
           FKDAT
           KUNAG
           KTGRD
           FKSTO
           XBLNR
           ZUONR
           KURRF_DAT
            KURRF
            KUNRG
            KIDNO
      FROM VBRK
      INTO TABLE LT_SALES_INV_HDR
      WHERE VBELN IN SO_VBELN
      AND   FKDAT IN SO_FKDAT
      AND   KUNAG IN SO_KUNNR
      AND   FKART NOT IN ('ZF5','ZF8','F5','F8','ZSN','ZSP','ZS1').

  ENDIF.

  IF NOT LT_SALES_INV_HDR IS INITIAL.
    SELECT BUKRS
           BELNR
           GJAHR
           BUZEI
           VBELN
           VBEL2
           POSN2
           HKONT
           KUNNR
           ZFBDT
           MWSK1
           DMBT1
           REBZG
           REBZJ
      FROM BSEG
      INTO TABLE LT_ACCOUNTING_DOC_ITEM
      FOR ALL ENTRIES IN LT_SALES_INV_HDR
      WHERE VBELN = LT_SALES_INV_HDR-VBELN
      %_HINTS ORACLE 'INDEX("BSEG""BSEG~ZVB")'.

    SORT LT_ACCOUNTING_DOC_ITEM BY BELNR.
    DELETE ADJACENT DUPLICATES FROM LT_ACCOUNTING_DOC_ITEM.
    IF NOT LT_ACCOUNTING_DOC_ITEM IS INITIAL.
      SELECT BUKRS
           BELNR
           GJAHR
           BUZEI
           VBELN
           VBEL2
           POSN2
           HKONT
           KUNNR
           ZFBDT
           MWSK1
           DMBT1
           REBZG
           REBZJ
      FROM BSEG
      INTO TABLE LT_ACCOUNTING_DOC_ITM1
      FOR ALL ENTRIES IN LT_ACCOUNTING_DOC_ITEM
      WHERE BELNR = LT_ACCOUNTING_DOC_ITEM-BELNR
      AND   GJAHR = LT_ACCOUNTING_DOC_ITEM-GJAHR
      AND   XBILK = SPACE.

      SELECT SAKNR
             TXT20
        FROM SKAT
        INTO TABLE LT_SKAT
        FOR ALL ENTRIES IN LT_ACCOUNTING_DOC_ITM1
        WHERE SAKNR = LT_ACCOUNTING_DOC_ITM1-HKONT
        AND   SPRAS = SY-LANGU
        AND   KTOPL = '1000'.

      SELECT BUKRS
             BELNR
             GJAHR
             BLART
             XBLNR
             BKTXT
        FROM BKPF
        INTO TABLE LT_ACCOUNTING_DOC_HDR
        FOR ALL ENTRIES IN LT_ACCOUNTING_DOC_ITEM
        WHERE BELNR = LT_ACCOUNTING_DOC_ITEM-BELNR
        AND   GJAHR = LT_ACCOUNTING_DOC_ITEM-GJAHR.

    ENDIF.

    SELECT VBELN
         POSNR
         FKIMG
         VRKME
         KURSK
         NETWR
         VGBEL
         VGPOS
         VGTYP
         AUBEL
         AUPOS
         MATNR
         ARKTX
         CHARG
         PRODH
         WERKS
    FROM VBRP
    INTO TABLE LT_SALES_INV_ITEM
    FOR ALL ENTRIES IN LT_SALES_INV_HDR
    WHERE VBELN = LT_SALES_INV_HDR-VBELN
      AND  WERKS = SO_WERKS.

    SELECT VBELV
           VBELN
           ERDAT
           MJAHR
            FROM VBFA
           INTO TABLE IT_VBFA
           FOR ALL ENTRIES IN LT_SALES_INV_HDR
           WHERE VBELV = LT_SALES_INV_HDR-VBELN.

    SELECT VBELN
           POSNR
           MATNR
           KDMAT
           DELDATE
      FROM VBAP
      INTO TABLE LT_SALES_ORD_ITEM
      FOR ALL ENTRIES IN LT_SALES_INV_ITEM
      WHERE VBELN = LT_SALES_INV_ITEM-AUBEL
      AND   POSNR = LT_SALES_INV_ITEM-AUPOS.

    SELECT KTGRD
           VTEXT
      FROM TVKTT
      INTO TABLE LT_TVKTT
      FOR ALL ENTRIES IN LT_SALES_INV_HDR
      WHERE KTGRD = LT_SALES_INV_HDR-KTGRD
      AND   SPRAS = SY-LANGU.


    SELECT KNUMV
           KPOSN
           KSCHL
           KBETR
           MWSK1
           KWERT
           KSTAT
           KWERT_K
      FROM PRCD_ELEMENTS
      INTO TABLE LT_CONDITIONS
      FOR ALL ENTRIES IN LT_SALES_INV_HDR
      WHERE KNUMV = LT_SALES_INV_HDR-KNUMV
      AND   KINAK = SPACE.

    SELECT MWSKZ
           TEXT1
      FROM T007S
      INTO TABLE LT_T007S
      FOR ALL ENTRIES IN LT_CONDITIONS
      WHERE MWSKZ = LT_CONDITIONS-MWSK1
      AND   KALSM = 'ZTAXUS'.

    IF NOT LT_SALES_INV_ITEM IS INITIAL.

      SELECT VBELN
             AUDAT
             AUART
             VKBUR
             VDATU
             BSTNK
             ZLDFROMDATE
             ZLDPERWEEK
             ZLDMAX
        FROM VBAK
        INTO TABLE LT_SALES_ORD_HDR
        FOR ALL ENTRIES IN LT_SALES_INV_ITEM
      WHERE VBELN = LT_SALES_INV_ITEM-AUBEL.

      SELECT KUNNR
             NAME1
             ORT01
             LAND1
             REGIO
             ADRNR
             STCD3
             BRSCH
             PSTLZ
        FROM KNA1
        INTO TABLE LT_CUST_INFO
        FOR ALL ENTRIES IN LT_SALES_INV_HDR
        WHERE KUNNR = LT_SALES_INV_HDR-KUNAG.

      SELECT KUNNR
           NAME1
           ORT01
           LAND1
           REGIO
           ADRNR
           STCD3
           BRSCH
           PSTLZ
      FROM KNA1
      INTO TABLE LT_BILL_TO
      FOR ALL ENTRIES IN LT_SALES_INV_HDR
      WHERE KUNNR = LT_SALES_INV_HDR-KUNRG.


      SELECT VBELN
             KUNNR
            PARVW
        FROM VBPA
        INTO TABLE LT_SALES_PARTNER
        FOR ALL ENTRIES IN LT_SALES_ORD_HDR
        WHERE VBELN = LT_SALES_ORD_HDR-VBELN
        AND   PARVW IN ('SH','WE').


      SELECT VBELN
             KUNNR
             PARVW
        FROM VBPA
        INTO TABLE IT_VBPA
        FOR ALL ENTRIES IN LT_SALES_ORD_HDR
        WHERE VBELN = LT_SALES_ORD_HDR-VBELN.


      SELECT KUNNR
             NAME1
             FROM KNA1 INTO TABLE IT_KNA1
             FOR ALL ENTRIES IN IT_VBPA
             WHERE KUNNR = IT_VBPA-KUNNR.


      SELECT KUNNR
             NAME1
             ORT01
             LAND1
             REGIO
             ADRNR
             STCD3
             BRSCH
             PSTLZ
        FROM KNA1
        APPENDING TABLE LT_CUST_INFO
        FOR ALL ENTRIES IN LT_SALES_PARTNER
        WHERE KUNNR = LT_SALES_PARTNER-KUNNR.

      SORT LT_CUST_INFO BY KUNNR.
      DELETE ADJACENT DUPLICATES FROM LT_CUST_INFO.
      IF NOT LT_CUST_INFO IS INITIAL.

        SELECT KUNNR
               KDGRP
               BZIRK
               VKBUR FROM KNVV INTO TABLE IT_KNVV
               FOR ALL ENTRIES IN LT_CUST_INFO
               WHERE KUNNR = LT_CUST_INFO-KUNNR.

        SELECT SPRAS
               BRSCH
               BRTXT FROM T016T INTO TABLE IT_T016T
               FOR ALL ENTRIES IN LT_CUST_INFO
               WHERE BRSCH = LT_CUST_INFO-BRSCH.

        SELECT ADDRNUMBER
               NAME1
               CITY1
               CITY2
               POST_CODE1
               STREET
               STR_SUPPL1
               STR_SUPPL2
               STR_SUPPL3
               LOCATION
               COUNTRY
               HOUSE_NUM1
          FROM ADRC
          INTO TABLE LT_ADRC
          FOR ALL ENTRIES IN LT_CUST_INFO
          WHERE ADDRNUMBER = LT_CUST_INFO-ADRNR.

        SELECT ADDRNUMBER
             NAME1
             CITY1
             CITY2
             POST_CODE1
             STREET
             STR_SUPPL1
             STR_SUPPL2
             STR_SUPPL3
             LOCATION
             COUNTRY
             HOUSE_NUM1
        FROM ADRC
        INTO TABLE LT_BILL_ADRC
        FOR ALL ENTRIES IN LT_BILL_TO
        WHERE ADDRNUMBER = LT_BILL_TO-ADRNR.

        SELECT KUNNR
               TAXKD
          FROM KNVI
          INTO TABLE LT_KNVI
          FOR ALL ENTRIES IN LT_CUST_INFO
          WHERE KUNNR = LT_CUST_INFO-KUNNR
          AND   TATYP IN ('UCOU','USTA','ULOC').


        IF SY-SUBRC IS INITIAL.
          SELECT TATYP
                 TAXKD
                 VTEXT
            FROM TSKDT
            INTO TABLE LT_TSKDT
            FOR ALL ENTRIES IN LT_KNVI
            WHERE TAXKD = LT_KNVI-TAXKD
            AND   SPRAS = SY-LANGU.


        ENDIF.
        SELECT LAND1
               BLAND
               BEZEI
          FROM T005U
          INTO TABLE LT_T005U
          FOR ALL ENTRIES IN LT_CUST_INFO
          WHERE SPRAS = SY-LANGU
          AND   LAND1 = LT_CUST_INFO-LAND1
          AND   BLAND = LT_CUST_INFO-REGIO.

        SELECT GST_REGION
               BEZEI
          FROM ZGST_REGION
          INTO TABLE LT_ZGST_REGION
          FOR ALL ENTRIES IN LT_T005U
          WHERE BEZEI = LT_T005U-BEZEI.

      ENDIF.

      IF IT_KNVV IS NOT INITIAL.
        SELECT SPRAS
               KDGRP
               KTEXT FROM T151T INTO TABLE IT_T151T
               FOR ALL ENTRIES IN IT_KNVV
               WHERE SPRAS = 'E'
                AND  KDGRP = IT_KNVV-KDGRP.

        SELECT SPRAS
               BZIRK
               BZTXT FROM T171T INTO TABLE IT_T171T
               FOR ALL ENTRIES IN IT_KNVV
               WHERE SPRAS = 'E'
                 AND BZIRK = IT_KNVV-BZIRK.

        SELECT SPRAS
               VKBUR
               BEZEI FROM TVKBT INTO TABLE IT_TVKBT
               FOR ALL ENTRIES IN IT_KNVV
               WHERE SPRAS = 'E'
                 AND VKBUR = IT_KNVV-VKBUR.

      ENDIF.

      SELECT VBELN
             POSNR
             EDATU
        FROM VBEP
        INTO TABLE LT_SCHEDULE_LINE
        FOR ALL ENTRIES IN LT_SALES_ORD_HDR
      WHERE VBELN = LT_SALES_ORD_HDR-VBELN.

      SELECT MATNR
             WRKST
             ZSERIES
             ZSIZE
             BRAND
             MOC
             TYPE
        FROM MARA
        INTO TABLE LT_MAT_MASTER
        FOR ALL ENTRIES IN LT_SALES_INV_ITEM
      WHERE MATNR = LT_SALES_INV_ITEM-MATNR.

      SELECT MATNR
             BWKEY
             BWTAR
             STPRS
             BKLAS
        FROM MBEW
        INTO TABLE LT_MATERIAL_VAL
        FOR ALL ENTRIES IN LT_SALES_INV_ITEM
      WHERE MATNR = LT_SALES_INV_ITEM-MATNR
        AND BWKEY = LT_SALES_INV_ITEM-WERKS.


      SELECT MATNR
             WERKS
             STEUC
        FROM MARC
        INTO TABLE LT_MARC
        FOR ALL ENTRIES IN LT_SALES_INV_ITEM
      WHERE MATNR = LT_SALES_INV_ITEM-MATNR.

      SELECT VBELN
             POSNR
             TRATY
        FROM VBKD
        INTO TABLE LT_SALES_BUSS
        FOR ALL ENTRIES IN LT_SALES_INV_ITEM
        WHERE VBELN = LT_SALES_INV_ITEM-AUBEL
      AND   POSNR = LT_SALES_INV_ITEM-AUPOS.

    ENDIF.
  ENDIF.

  IF LT_SALES_INV_ITEM IS INITIAL.
    MESSAGE 'Data Not Found' TYPE 'E'.

  ELSE.
    LOOP AT LT_SALES_INV_ITEM INTO LS_SALES_INV_ITEM WHERE WERKS NE 'PL01'.

      LS_FINAL-VBELN = LS_SALES_INV_ITEM-VBELN.
      LS_FINAL-POSNR = LS_SALES_INV_ITEM-POSNR.
      LS_FINAL-FKIMG = LS_SALES_INV_ITEM-FKIMG.
      LS_FINAL-VRKME = LS_SALES_INV_ITEM-VRKME.
*      IF ls_sales_inv_item-netwr LT 0.
*        ls_final-netwr = ls_sales_inv_item-netwr * -1.
*      ELSE.
*        ls_final-netwr = ls_sales_inv_item-netwr.
*      ENDIF.

*      ls_final-vgbel = ls_sales_inv_item-vgbel.
*      ls_final-vgpos = ls_sales_inv_item-vgpos. """""
*      ls_final-vgtyp = ls_sales_inv_item-vgtyp.
      LS_FINAL-AUBEL = LS_SALES_INV_ITEM-AUBEL.
*      ls_final-aupos = ls_sales_inv_item-aupos.
      LS_FINAL-MATNR = LS_SALES_INV_ITEM-MATNR.
      LS_FINAL-ARKTX = LS_SALES_INV_ITEM-ARKTX.
*      ls_final-prodh = ls_sales_inv_item-prodh.
      LS_FINAL-WERKS = LS_SALES_INV_ITEM-WERKS.
*      ls_final-kursk = ls_sales_inv_item-kursk.
*      ls_final-val_inr = ls_sales_inv_item-kursk * ls_final-netwr.
************************************************************************************************************************

**********************************************************************************************************************

      READ TABLE LT_SALES_ORD_HDR INTO LS_SALES_ORD_HDR WITH KEY VBELN = LS_SALES_INV_ITEM-AUBEL.
      IF SY-SUBRC IS INITIAL.
*        IF NOT ls_sales_ord_hdr-audat IS INITIAL.
*          CONCATENATE ls_sales_ord_hdr-audat+6(2) ls_sales_ord_hdr-audat+4(2) ls_sales_ord_hdr-audat+0(4)
*             INTO ls_final-audat SEPARATED BY '-'.
**        ELSE.
**          ls_final-audat = 'NULL'.
*        ENDIF.
        LS_FINAL-AUDAT       = LS_SALES_ORD_HDR-AUDAT.
        LS_FINAL-AUART       = LS_SALES_ORD_HDR-AUART.
        LS_FINAL-VKBUR       = LS_SALES_ORD_HDR-VKBUR.

        LS_FINAL-VDATU       = LS_SALES_ORD_HDR-VDATU.
*        IF NOT ls_sales_ord_hdr-vdatu IS INITIAL.
*          CONCATENATE ls_sales_ord_hdr-vdatu+6(2) ls_sales_ord_hdr-vdatu+4(2) ls_sales_ord_hdr-vdatu+0(4)
*             INTO ls_final-vdatu SEPARATED BY '-'.
**        ELSE.
**          ls_final-vdatu = 'NULL'.
*        ENDIF.

        LS_FINAL-BSTNK       = LS_SALES_ORD_HDR-BSTNK.

*        IF NOT ls_sales_ord_hdr-zldfromdate IS INITIAL.
*          CONCATENATE ls_sales_ord_hdr-zldfromdate+6(2) ls_sales_ord_hdr-zldfromdate+4(2) ls_sales_ord_hdr-zldfromdate+0(4)
*             INTO ls_final-zldfromdate SEPARATED BY '-'.
**        ELSE.
**          ls_final-zldfromdate = 'NULL'.
*        ENDIF.
*        ls_final-zldperweek  = ls_sales_ord_hdr-zldperweek.
*        ls_final-zldmax      = ls_sales_ord_hdr-zldmax.
      ENDIF.
      READ TABLE LT_SALES_INV_HDR INTO LS_SALES_INV_HDR WITH KEY VBELN = LS_SALES_INV_ITEM-VBELN.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-WAERK = LS_SALES_INV_HDR-WAERK.
*        ls_final-kursk = ls_sales_inv_hdr-kurrf.
*        ls_final-vtweg = ls_sales_inv_hdr-vtweg.
        LS_FINAL-FKDAT  = LS_SALES_INV_HDR-FKDAT.
*        IF NOT ls_sales_inv_hdr-fkdat IS INITIAL.
*          CONCATENATE ls_sales_inv_hdr-fkdat+6(2) ls_sales_inv_hdr-fkdat+4(2) ls_sales_inv_hdr-fkdat+0(4)
*             INTO ls_final-fkdat SEPARATED BY '-'.
*
**        ELSE.
**          ls_final-fkdat = 'NULL'.
*        ENDIF.
        LS_FINAL-FKART = LS_SALES_INV_HDR-FKART.
        LS_FINAL-KUNAG = LS_SALES_INV_HDR-KUNAG.



*        ls_final-xblnr = ls_sales_inv_hdr-xblnr.
*        ls_final-ktgrd = ls_sales_inv_hdr-ktgrd.
        IF LS_FINAL-FKART = 'US04' OR LS_FINAL-FKART = 'US05'.
*          ls_final-zuonr     = ls_sales_inv_hdr-zuonr.
*          IF ls_final-zuonr IS INITIAL.
*            ls_final-zuonr = ls_final-xblnr.
*          ENDIF.


*          IF NOT ls_sales_inv_hdr-kurrf_dat IS INITIAL.
*            CONCATENATE ls_sales_inv_hdr-kurrf_dat+6(2) ls_sales_inv_hdr-kurrf_dat+4(2) ls_sales_inv_hdr-kurrf_dat+0(4)
*               INTO ls_final-kurrf_dat SEPARATED BY '-'.
*
*            CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*              EXPORTING
*                input  = ls_sales_inv_hdr-kurrf_dat
*              IMPORTING
*                output = wa_final-kurrf_dat.
*
*
*            CONCATENATE wa_final-kurrf_dat+0(2) wa_final-kurrf_dat+2(3) wa_final-kurrf_dat+5(4)
*                      INTO wa_final-kurrf_dat SEPARATED BY '-'.
*
**          ELSE.
**            ls_final-kurrf_dat = 'NULL'.
*          ENDIF.

        ENDIF.

      ENDIF.
      READ TABLE LT_ACCOUNTING_DOC_ITEM INTO LS_ACCOUNTING_DOC_ITEM WITH KEY VBELN = LS_SALES_INV_HDR-VBELN.
      IF SY-SUBRC IS INITIAL.

        READ TABLE LT_ACCOUNTING_DOC_HDR INTO LS_ACCOUNTING_DOC_HDR WITH KEY BELNR = LS_ACCOUNTING_DOC_ITEM-BELNR
                                                                             GJAHR = LS_ACCOUNTING_DOC_ITEM-GJAHR.
        IF SY-SUBRC IS INITIAL.
          LS_FINAL-BELNR = LS_ACCOUNTING_DOC_HDR-BELNR.
          LS_FINAL-BLART = LS_ACCOUNTING_DOC_HDR-BLART.
        ENDIF.

        IF LS_FINAL-BLART = 'RV'.
          LS_FINAL-FI_DES = 'Billing Invoice'.
        ELSEIF LS_FINAL-BLART = 'AB'.
          LS_FINAL-FI_DES = 'Reverse Invoice'.
        ELSEIF LS_FINAL-BLART = 'DG'.
          LS_FINAL-FI_DES = 'Credit Memo'.
        ELSEIF LS_FINAL-BLART = 'DA'.
          LS_FINAL-FI_DES = 'Customer Document'.
        ELSEIF LS_FINAL-BLART = 'UE'.
          LS_FINAL-FI_DES = 'Initial Upload'.
        ENDIF.
        READ TABLE IT_VBFA INTO WA_VBFA WITH KEY VBELV = LS_SALES_INV_HDR-VBELN.
        IF SY-SUBRC = 0.
          LS_FINAL-ORIG_NO = WA_VBFA-VBELN.
          LS_FINAL-ORIG_DT = WA_VBFA-ERDAT.
        ENDIF.
**************************** sagar dev
        SELECT BUKRS BELNR GJAHR XBLNR INTO CORRESPONDING FIELDS OF TABLE IT_BKPF FROM BKPF WHERE XBLNR = LS_SALES_INV_ITEM-VGBEL AND GJAHR = LS_ACCOUNTING_DOC_ITEM-GJAHR
           AND BUKRS = LS_ACCOUNTING_DOC_ITEM-BUKRS.
        CLEAR: WS_FINAL,WA_BKPF,WS_FINAL.
        IF IT_BKPF IS NOT INITIAL.
          LOOP AT IT_BKPF INTO WA_BKPF.
            CLEAR: LS_ACCOUNTING_MDOC_ITEM,LT_ACCOUNTING_MDOC_ITEM,GV_DMBTR.
            SELECT BUKRS
                   BELNR
                   GJAHR
                   BUZEI
                   BUZID
                   SHKZG
                   DMBTR
                   MENGE
              FROM BSEG
              INTO TABLE LT_ACCOUNTING_MDOC_ITEM
              WHERE BELNR = WA_BKPF-BELNR
              AND   GJAHR = WA_BKPF-GJAHR
              AND   BUKRS = WA_BKPF-BUKRS
              AND   MATNR = LS_FINAL-MATNR
              AND   POSN2 = LS_FINAL-POSNR
              AND   MENGE = LS_FINAL-FKIMG
              AND   KOART = 'S'.
            LOOP AT LT_ACCOUNTING_MDOC_ITEM INTO LS_ACCOUNTING_MDOC_ITEM.
              GV_DMBTR = GV_DMBTR + LS_ACCOUNTING_MDOC_ITEM-DMBTR.
            ENDLOOP.
            IF LS_ACCOUNTING_MDOC_ITEM-SHKZG = 'H'.
              GV_DMBTR = GV_DMBTR * -1.
            ENDIF.
            IF LS_SALES_INV_HDR-FKART = 'US1'.
              GV_DMBTR = GV_DMBTR * -1.
            ENDIF.
            LS_FINAL-INT_PR3 = GV_DMBTR.
            LS_FINAL-BELNR1  = WA_BKPF-BELNR.
            CLEAR:  WA_BKPF,WS_FINAL.
          ENDLOOP.
        ELSE.
          CLEAR: LS_ACCOUNTING_MDOC_ITEM,LT_ACCOUNTING_MDOC_ITEM,GV_DMBTR.
          SELECT BUKRS
                 BELNR
                 GJAHR
                 BUZEI
                 BUZID
                 SHKZG
                 DMBTR
                 MENGE
            FROM BSEG
            INTO TABLE LT_ACCOUNTING_MDOC_ITEM
            WHERE VBEL2 = LS_FINAL-AUBEL
            AND   GJAHR = LS_ACCOUNTING_DOC_ITEM-GJAHR
            AND   BUKRS = LS_ACCOUNTING_DOC_ITEM-BUKRS
            AND   MATNR = LS_FINAL-MATNR
            AND   POSN2 = LS_FINAL-POSNR
            AND   MENGE = LS_FINAL-FKIMG
            AND   KOART = 'S'.

          LOOP AT LT_ACCOUNTING_MDOC_ITEM INTO LS_ACCOUNTING_MDOC_ITEM.
            GV_DMBTR = GV_DMBTR + LS_ACCOUNTING_MDOC_ITEM-DMBTR.
          ENDLOOP.
          IF LS_ACCOUNTING_MDOC_ITEM-SHKZG = 'H'.
            GV_DMBTR = GV_DMBTR * -1.
          ENDIF.
          IF LS_SALES_INV_HDR-FKART = 'US1'.
            GV_DMBTR = GV_DMBTR * -1.
          ENDIF.
          LS_FINAL-BELNR1 = LS_ACCOUNTING_MDOC_ITEM-BELNR.
          LS_FINAL-INT_PR3 = GV_DMBTR.
        ENDIF.
        CLEAR: GV_VBELN.
        SELECT SINGLE VBELN INTO GV_VBELN FROM VBRK WHERE VBELN = LS_FINAL-ORIG_NO.
        IF GV_VBELN IS INITIAL.
        ELSE.
          IF LS_FINAL-ORIG_NO <> ''.
            LS_FINAL-BELNR1 = ''.
            LS_FINAL-INT_PR3 = ''.
          ENDIF.
        ENDIF.


        READ TABLE LT_ACCOUNTING_DOC_ITM1 INTO LS_ACCOUNTING_DOC_ITEM WITH KEY BELNR = LS_ACCOUNTING_DOC_HDR-BELNR
                                                                               GJAHR = LS_ACCOUNTING_DOC_HDR-GJAHR.
*                                                                               vbel2 = ls_sales_inv_item-aubel
*                                                                               posn2 = ls_sales_inv_item-aupos.
        IF SY-SUBRC IS INITIAL.
*          ls_final-hkont   = ls_accounting_doc_item-hkont.

          READ TABLE LT_SKAT INTO LS_SKAT WITH KEY SAKNR = LS_ACCOUNTING_DOC_ITEM-HKONT.
          IF SY-SUBRC IS INITIAL.
*            ls_final-vtext1 = ls_skat-txt20.
          ENDIF.
        ENDIF.
      ELSE.
        SELECT BUKRS BELNR GJAHR XBLNR INTO CORRESPONDING FIELDS OF TABLE IT_BKPF FROM BKPF WHERE XBLNR = LS_SALES_INV_ITEM-VGBEL AND GJAHR = LS_ACCOUNTING_DOC_ITEM-GJAHR
           AND BUKRS = LS_ACCOUNTING_DOC_ITEM-BUKRS.
        CLEAR: WS_FINAL,WA_BKPF,WS_FINAL.
        LOOP AT IT_BKPF INTO WA_BKPF.
          CLEAR: LS_ACCOUNTING_MDOC_ITEM,LT_ACCOUNTING_MDOC_ITEM,GV_DMBTR.
          SELECT BUKRS
                 BELNR
                 GJAHR
                 BUZEI
                 BUZID
                 SHKZG
                 DMBTR
                 MENGE
            FROM BSEG
            INTO TABLE LT_ACCOUNTING_MDOC_ITEM
            WHERE BELNR = WA_BKPF-BELNR
            AND   GJAHR = WA_BKPF-GJAHR
            AND   BUKRS = WA_BKPF-BUKRS
            AND   MATNR = LS_FINAL-MATNR
            AND   POSN2 = LS_FINAL-POSNR
            AND   MENGE = LS_FINAL-FKIMG
            AND   KOART = 'S'.
          LOOP AT LT_ACCOUNTING_MDOC_ITEM INTO LS_ACCOUNTING_MDOC_ITEM.
            GV_DMBTR = GV_DMBTR + LS_ACCOUNTING_MDOC_ITEM-DMBTR.
          ENDLOOP.
          IF LS_ACCOUNTING_MDOC_ITEM-SHKZG = 'H'.
            GV_DMBTR = GV_DMBTR * -1.
          ENDIF.
          READ TABLE CT_FINAL INTO WS_FINAL WITH KEY BELNR1 = LS_FINAL-BELNR1 ORIG_NO = ''.
          IF SY-SUBRC = 0.
            LS_FINAL-INT_PR3 = GV_DMBTR.
            LS_FINAL-BELNR1  = WA_BKPF-BELNR.
          ENDIF.
        ENDLOOP.
      ENDIF.
      READ TABLE LT_SALES_ORD_ITEM INTO LS_SALES_ORD_ITEM WITH KEY VBELN = LS_SALES_INV_ITEM-AUBEL
                                                                   POSNR = LS_SALES_INV_ITEM-AUPOS.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-KDMAT = LS_SALES_ORD_ITEM-KDMAT.
      ENDIF.
      READ TABLE LT_CUST_INFO INTO LS_CUST_INFO WITH KEY KUNNR = LS_SALES_INV_HDR-KUNAG.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-NAME1 = LS_CUST_INFO-NAME1.
        LS_FINAL-PSTLZ = LS_CUST_INFO-PSTLZ.
        LS_FINAL-BRSCH = LS_CUST_INFO-BRSCH.
        LS_FINAL-GST_REGION =  LS_CUST_INFO-REGIO.
      ENDIF.

      READ TABLE IT_T016T INTO WA_T016T WITH KEY BRSCH = LS_CUST_INFO-BRSCH.
      IF SY-SUBRC = 0.
        LS_FINAL-BRTXT = WA_T016T-BRTXT.

      ENDIF.

      READ TABLE IT_KNVV INTO WA_KNVV WITH KEY KUNNR = LS_CUST_INFO-KUNNR.
      IF SY-SUBRC = 0.
        LS_FINAL-KDGRP      = WA_KNVV-KDGRP.
        LS_FINAL-SALE_OFF   = WA_KNVV-VKBUR.
        LS_FINAL-BZIRK      = WA_KNVV-BZIRK.
      ENDIF.
      READ TABLE IT_T151T INTO WA_T151T WITH KEY KDGRP = WA_KNVV-KDGRP.
      IF SY-SUBRC = 0.
        LS_FINAL-KTEXT = WA_T151T-KTEXT.

      ENDIF.

      READ TABLE IT_T171T INTO WA_T171T WITH KEY BZIRK = WA_KNVV-BZIRK.
      IF SY-SUBRC = 0.
        LS_FINAL-BZTXT = WA_T171T-BZTXT.

      ENDIF.

      READ TABLE IT_TVKBT INTO WA_TVKBT WITH KEY VKBUR = WA_KNVV-VKBUR.
      IF SY-SUBRC = 0.
        LS_FINAL-ORG_UNIT = WA_TVKBT-BEZEI.

      ENDIF.


      READ TABLE LT_ADRC INTO LS_ADRC WITH KEY ADDRNUMBER = LS_CUST_INFO-ADRNR.
      IF SY-SUBRC IS INITIAL.
        IF NOT LS_ADRC-STREET IS INITIAL.
          CONCATENATE LS_FINAL-ADDRESS LS_ADRC-STREET INTO LS_FINAL-ADDRESS.
        ENDIF.

        IF NOT LS_ADRC-STR_SUPPL1 IS INITIAL.
          CONCATENATE LS_FINAL-ADDRESS LS_ADRC-STR_SUPPL1 INTO LS_FINAL-ADDRESS SEPARATED BY ','.
        ENDIF.

        IF NOT LS_ADRC-STR_SUPPL2 IS INITIAL.
          CONCATENATE LS_FINAL-ADDRESS LS_ADRC-STR_SUPPL2 INTO LS_FINAL-ADDRESS SEPARATED BY ','.
        ENDIF.



        IF NOT LS_ADRC-STR_SUPPL3 IS INITIAL.
          CONCATENATE LS_FINAL-ADDRESS LS_ADRC-STR_SUPPL3 INTO LS_FINAL-ADDRESS SEPARATED BY ','.
        ENDIF.
        IF NOT LS_ADRC-LOCATION IS INITIAL.
          CONCATENATE LS_FINAL-ADDRESS LS_ADRC-LOCATION INTO LS_FINAL-ADDRESS SEPARATED BY ','.
        ENDIF.

        IF NOT LS_ADRC-CITY1 IS INITIAL.
          CONCATENATE LS_FINAL-ADDRESS LS_ADRC-CITY1 INTO LS_FINAL-ADDRESS SEPARATED BY ','.
        ENDIF.
        IF NOT LS_ADRC-POST_CODE1 IS INITIAL.
          CONCATENATE LS_FINAL-ADDRESS 'PIN:' LS_ADRC-POST_CODE1 INTO LS_FINAL-ADDRESS SEPARATED BY ','.
        ENDIF.
        CONDENSE LS_FINAL-ADDRESS.

      ENDIF.

      READ TABLE LT_BILL_TO INTO LS_BILL_TO WITH KEY KUNNR = LS_SALES_INV_HDR-KUNRG.
      IF SY-SUBRC = 0.

      ENDIF.

      READ TABLE LT_BILL_ADRC INTO LS_BILL_ADRC WITH KEY ADDRNUMBER = LS_BILL_TO-ADRNR.
      IF SY-SUBRC = 0.
        LS_FINAL-BILL_STREET   = LS_BILL_ADRC-STREET.
        IF LS_BILL_ADRC-HOUSE_NUM1 IS NOT INITIAL.
          CONCATENATE LS_FINAL-BILL_STREET LS_BILL_ADRC-HOUSE_NUM1 INTO LS_FINAL-BILL_STREET SEPARATED BY '/'.
        ENDIF.

        LS_FINAL-BILL_STR1     = LS_BILL_ADRC-STR_SUPPL1.
        LS_FINAL-BILL_STR2     = LS_BILL_ADRC-STR_SUPPL2.
        LS_FINAL-BILL_POST     = LS_BILL_ADRC-POST_CODE1  .
        LS_FINAL-BILL_CITY     = LS_BILL_ADRC-CITY1.

      ENDIF.

      SELECT SINGLE LANDX INTO LS_FINAL-BILL_COUNTRY FROM T005T WHERE SPRAS = 'EN' AND LAND1 = LS_BILL_ADRC-COUNTRY.
      SELECT SINGLE BEZEI INTO LS_FINAL-BILL_REG FROM T005U WHERE SPRAS = 'EN' AND BLAND = LS_BILL_TO-REGIO AND LAND1 = LS_BILL_ADRC-COUNTRY.


      READ TABLE LT_T005U INTO LS_T005U WITH KEY LAND1 = LS_CUST_INFO-LAND1
                                                 BLAND = LS_CUST_INFO-REGIO.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-BEZEI = LS_T005U-BEZEI.
      ENDIF.

      IF LS_CUST_INFO-LAND1 = 'US'.
        READ TABLE LT_KNVI INTO LS_KNVI WITH KEY KUNNR = LS_CUST_INFO-KUNNR.
        IF SY-SUBRC IS INITIAL.
          IF LS_CUST_INFO-REGIO = '13'.
            READ TABLE LT_TSKDT INTO LS_TSKDT WITH KEY TATYP = 'JOCG'.
            IF SY-SUBRC IS INITIAL.
*              ls_final-vtext_tax = ls_tskdt-vtext.
            ENDIF.
          ELSE.
            READ TABLE LT_TSKDT INTO LS_TSKDT WITH KEY TATYP = 'JOIG'.
            IF SY-SUBRC IS INITIAL.
*              ls_final-vtext_tax = ls_tskdt-vtext.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
*      READ TABLE lt_zgst_region INTO ls_zgst_region WITH KEY bezei = ls_t005u-bezei.
*      IF sy-subrc IS INITIAL.
*        ls_final-gst_region = ls_zgst_region-gst_region.
*      ENDIF.


      READ TABLE LT_SALES_PARTNER INTO LS_SALES_PARTNER WITH KEY VBELN = LS_SALES_ORD_HDR-VBELN.
      IF SY-SUBRC IS INITIAL.
*        ls_final-kunnr  = ls_sales_partner-kunnr.
      ENDIF.

      READ TABLE IT_VBPA INTO WA_VBPA WITH KEY VBELN = LS_SALES_ORD_HDR-VBELN PARVW = 'UR'.
      IF SY-SUBRC = 0.
        LS_FINAL-PARTNER = WA_VBPA-KUNNR.
      ENDIF.

      READ TABLE IT_KNA1 INTO WA_KNA1 WITH KEY KUNNR = WA_VBPA-KUNNR.
      IF SY-SUBRC = 0.
        LS_FINAL-PART_NAME = WA_KNA1-NAME1.
      ENDIF.



      CLEAR:LS_CUST_INFO,LS_T005U,LS_ZGST_REGION.
      READ TABLE LT_SALES_PARTNER INTO LS_SALES_PARTNER WITH KEY VBELN = LS_SALES_ORD_HDR-VBELN PARVW = 'WE'.
      IF SY-SUBRC IS INITIAL.
*        ls_final-kunnr  = ls_sales_partner-kunnr.
      ENDIF.
      READ TABLE LT_CUST_INFO INTO LS_CUST_INFO WITH KEY KUNNR = LS_SALES_PARTNER-KUNNR.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-SHIP_CODE  = LS_CUST_INFO-KUNNR.
        LS_FINAL-ORT01      = LS_CUST_INFO-ORT01.
        LS_FINAL-NAME1_SH = LS_CUST_INFO-NAME1.
        LS_FINAL-PSTLZ = LS_CUST_INFO-PSTLZ.
        LS_FINAL-SHIP_STATE = LS_CUST_INFO-REGIO.
*        ls_final-stcd3 = ls_cust_info-stcd3.
*        ls_final-brsch = ls_cust_info-brsch.
      ENDIF.

      READ TABLE LT_T005U INTO LS_T005U WITH KEY LAND1 = LS_CUST_INFO-LAND1
                                                 BLAND = LS_CUST_INFO-REGIO.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-BEZEI_SH = LS_T005U-BEZEI.

      ENDIF.
      READ TABLE LT_ZGST_REGION INTO LS_ZGST_REGION WITH KEY BEZEI = LS_T005U-BEZEI.
      IF SY-SUBRC IS INITIAL.
*        ls_final-gst_region_sh = ls_zgst_region-gst_region.
      ENDIF.

      READ TABLE LT_SCHEDULE_LINE INTO LS_SCHEDULE_LINE WITH KEY VBELN = LS_SALES_INV_ITEM-AUBEL
                                                                 POSNR = LS_SALES_INV_ITEM-AUPOS.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-EDATU = LS_SCHEDULE_LINE-EDATU.
*        IF NOT ls_schedule_line-edatu IS INITIAL.
*          CONCATENATE ls_schedule_line-edatu+6(2) ls_schedule_line-edatu+4(2) ls_schedule_line-edatu+0(4)
*             INTO ls_final-edatu SEPARATED BY '-'.
**        ELSE.
**          ls_final-edatu = 'NULL'.
*        ENDIF.
*      ELSE.
*        ls_final-edatu = 'NULL'.
      ENDIF.

      READ TABLE LT_TVKTT INTO LS_TVKTT WITH KEY KTGRD = LS_SALES_INV_HDR-KTGRD.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-VTEXT = LS_TVKTT-VTEXT.
*        ls_final-vtext1 = ls_tvktt-vtext.
      ENDIF.

      READ TABLE LT_MAT_MASTER INTO LS_MAT_MASTER WITH KEY MATNR = LS_SALES_INV_ITEM-MATNR.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-WRKST = LS_MAT_MASTER-WRKST.
        LS_FINAL-ZSERIES = LS_MAT_MASTER-ZSERIES.
        LS_FINAL-ZSIZE   = LS_MAT_MASTER-ZSIZE.
        LS_FINAL-BRAND   = LS_MAT_MASTER-BRAND.
        LS_FINAL-MOC     = LS_MAT_MASTER-MOC.
        LS_FINAL-TYPE    = LS_MAT_MASTER-TYPE.
      ENDIF.

      READ TABLE LT_MATERIAL_VAL INTO LS_MATERIAL_VAL WITH KEY MATNR = LS_SALES_INV_ITEM-MATNR.
      IF SY-SUBRC IS INITIAL.
*        ls_final-stprs  = ls_material_val-stprs.
*        ls_final-stprs1 = ls_material_val-stprs.
        LS_FINAL-BKLAS = LS_MATERIAL_VAL-BKLAS.
      ENDIF.
      READ TABLE LT_MARC INTO LS_MARC WITH KEY MATNR = LS_SALES_INV_ITEM-MATNR.
      IF SY-SUBRC IS INITIAL.
*        ls_final-steuc = ls_marc-steuc.
      ENDIF.
***      READ TABLE lt_sales_buss INTO ls_sales_buss WITH KEY vbeln = ls_sales_inv_item-aubel
***                                                           posnr = ls_sales_inv_item-aupos.
***      IF sy-subrc IS INITIAL.
***        ls_final-traty = ls_sales_buss-traty.
***      ENDIF.

      "Base Price
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZPR0'.

      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-BASE_VAL = LS_CONDITIONS-KWERT.
*        ls_final-val_inr  = ls_conditions-kwert * ls_sales_inv_item-kursk.
*        ls_final-val_inr  = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
        LS_FINAL-NETPR    = LS_FINAL-BASE_VAL / LS_FINAL-FKIMG.
      ENDIF.

      "Discount Price
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'U007'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-DIS = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
*        ls_final-dis = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "Internal Price
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'VPRS'.
*                                                           kstat = space.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-int_pr = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-int_pr = ls_conditions-kwert * ls_sales_inv_item-kursk.
        IF LS_SALES_INV_HDR-WAERK = 'USD'.
*        ls_final-int_pr = ls_conditions-KBETR * ls_sales_inv_hdr-kurrf.
          LS_FINAL-INT_PR2 = LS_CONDITIONS-KWERT_K.
        ELSE.
*        ls_final-int_pr = ls_conditions-KBETR.
          LS_FINAL-INT_PR2 = LS_CONDITIONS-KWERT_K.
        ENDIF.


      ENDIF.

      "Packing Forwarding Charge
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'UHF1'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-PF_VAL = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
*        ls_final-pf_val = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "Assessable Value
*      ls_final-ass_val = ls_final-val_inr + ls_final-pf_val + ls_final-dis.

      "Excise Duty
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZEXP'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-exe_val = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-exe_val = ls_conditions-kwert * ls_sales_inv_item-kursk.
        LS_FINAL-MWSKZ = LS_CONDITIONS-MWSK1.
      ENDIF.

      "Education Cess Amount
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZCEP'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-edu_val = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-edu_val = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "Higher Education Cess Amount
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZCEH'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-hse_val = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-hse_val = ls_conditions-kwert * ls_sales_inv_item-kursk.

      ENDIF.

      "VAT
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZCST'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-vat = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-vat = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "Testing Charge
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'USC1'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-TES = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
*        ls_final-tes = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.


      "LST
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZLST'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-vat = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-vat = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "ULOC
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ULOC'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-ULOC_P = LS_CONDITIONS-KBETR / 10.
        LS_FINAL-ULOC   = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
*        ls_final-ULOC   = ls_conditions-kwert * ls_sales_inv_item-kursk.
        LS_FINAL-MWSKZ  = LS_CONDITIONS-MWSK1.
      ENDIF.

      "USTA
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'USTA'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-USTA_P = LS_CONDITIONS-KBETR / 10.
*        ls_final-USTA   = ls_conditions-kwert * ls_sales_inv_item-kursk.
        LS_FINAL-USTA   = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
      ENDIF.

      "UOTH
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                          KPOSN = LS_SALES_INV_ITEM-POSNR
                                                          KSCHL = 'UOTH'
                                                          KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-UOTH_P = LS_CONDITIONS-KBETR / 10.
*        ls_final-USTA   = ls_conditions-kwert * ls_sales_inv_item-kursk.
        LS_FINAL-UOTH   = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
      ENDIF.

      "UCOU
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'UCOU'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-UCOU_P = LS_CONDITIONS-KBETR / 10.
        LS_FINAL-UCOU   = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
*        ls_final-UCOU   = ls_conditions-kwert * ls_sales_inv_item-kursk.
        LS_FINAL-MWSKZ  = LS_CONDITIONS-MWSK1.
      ENDIF.

      READ TABLE LT_T007S INTO LS_T007S WITH KEY MWSKZ = LS_FINAL-MWSKZ.
      IF SY-SUBRC IS INITIAL.
        LS_FINAL-TAX_TXT = LS_T007S-TEXT1.
      ENDIF.
      "Freight
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'UMC1'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-FRT = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
*        ls_final-frt = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.
      "Freight
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZFR2'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-FRT = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
*        ls_final-frt = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.
      "Freight
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZFRP'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
        LS_FINAL-FRT = LS_CONDITIONS-KWERT * LS_SALES_INV_HDR-KURRF.
*        ls_final-frt = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "Insurance
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZIN1'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-ins = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-ins = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "Insurance
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZIN2'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-ins = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-ins = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "Insurance
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZIPP'
                                                           KSTAT = SPACE.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-ins = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-ins = ls_conditions-kwert * ls_sales_inv_item-kursk.
      ENDIF.

      "TCS
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZTCS'.
*                                                           kstat = space.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-tcs   = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-tcs   = ls_conditions-kwert * ls_sales_inv_item-kursk.
*        ls_final-tcs_p = ls_conditions-kbetr / 10.
      ENDIF.

      "Compensation Cess
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZCES'.
*                                                           kstat = space.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-com_cess   = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-com_cess   = ls_conditions-kwert * ls_sales_inv_item-kursk.
*        ls_final-tcs_p = ls_conditions-kbetr / 10.
      ENDIF.

      "Compensation Cess
      READ TABLE LT_CONDITIONS INTO LS_CONDITIONS WITH KEY KNUMV = LS_SALES_INV_HDR-KNUMV
                                                           KPOSN = LS_SALES_INV_ITEM-POSNR
                                                           KSCHL = 'ZCEV'.
*                                                           kstat = space.
      IF SY-SUBRC IS  INITIAL.
*        ls_final-com_cess_v  = ls_conditions-kwert * ls_sales_inv_hdr-kurrf.
*        ls_final-com_cess_v  = ls_conditions-kwert * ls_sales_inv_item-kursk.
*        ls_final-tcs_p = ls_conditions-kbetr / 10.
      ENDIF.

*      IF NOT ls_final-ULOC IS INITIAL OR
*        NOT ls_final-UCOU IS INITIAL.
*      ls_final-ass_gst = ls_final-ass_val + ls_final-frt  + ls_final-tes." + ls_final-ins.
*      ENDIF.
***    Net Value calculation.
      LS_FINAL-VAL_INR = LS_FINAL-BASE_VAL + LS_FINAL-DIS.
***   Gross Amount
      LS_FINAL-ASS_VAL =   LS_FINAL-VAL_INR + LS_FINAL-ULOC + LS_FINAL-USTA + LS_FINAL-UCOU + LS_FINAL-UOTH
                         + LS_FINAL-PF_VAL + LS_FINAL-FRT + LS_FINAL-TES.

*      IF ls_sales_inv_hdr-fksto = 'X' .
*        ls_final-status     = 'C'.
*        ls_final-base_val   = 0.
*        ls_final-val_inr    = 0.
*        ls_final-dis        = 0.
**        ls_final-int_pr     = 0.
*        ls_final-pf_val     = 0.
*        ls_final-ass_val    = 0.
**        ls_final-exe_val    = 0.
**        ls_final-edu_val    = 0.
**        ls_final-hse_val    = 0.
**        ls_final-vat        = 0.
*        ls_final-ULOC       = 0.
*        ls_final-USTA       = 0.
*        ls_final-UCOU       = 0.
*        ls_final-UOTH      = 0.
*        ls_final-frt        = 0.
**        ls_final-ins        = 0.
*        ls_final-tes        = 0.
**        ls_final-ass_gst    = 0.
**        ls_final-com_cess   = 0.
**        ls_final-com_cess_v = 0.
**        ls_final-tcs_p      = 0.
**        ls_final-tcs        = 0.
*
*      ENDIF.

      IF LS_FINAL-FKART = 'US08'.
        LS_FINAL-STATUS     = 'F'.
        LS_FINAL-BASE_VAL   = 0.
        LS_FINAL-VAL_INR    = 0.
        LS_FINAL-DIS        = 0.
        LS_FINAL-PF_VAL     = 0.
        LS_FINAL-ASS_VAL    = 0.
        LS_FINAL-ULOC       = 0.
        LS_FINAL-USTA       = 0.
        LS_FINAL-UCOU       = 0.
        LS_FINAL-UOTH       = 0.
        LS_FINAL-FRT        = 0.
        LS_FINAL-TES        = 0.

      ENDIF.

      IF LS_FINAL-FKART = 'US03' OR LS_FINAL-FKART = 'US05' OR LS_FINAL-FKART = 'US1'." OR ls_final-fkart = 'US2'.
        LS_FINAL-INT_PR2 = - LS_FINAL-INT_PR2.
      ENDIF.

      IF LS_FINAL-FKART = 'US03' OR LS_FINAL-FKART = 'US05' .
        LS_FINAL-BASE_VAL = - LS_FINAL-BASE_VAL.
        LS_FINAL-VAL_INR = - LS_FINAL-VAL_INR.
        LS_FINAL-ULOC = - LS_FINAL-ULOC.
        LS_FINAL-USTA = - LS_FINAL-USTA.
        LS_FINAL-UCOU = - LS_FINAL-UCOU.
        LS_FINAL-UOTH = - LS_FINAL-UOTH.
        LS_FINAL-PF_VAL = - LS_FINAL-PF_VAL.
        LS_FINAL-FRT = - LS_FINAL-FRT.
        LS_FINAL-TES = - LS_FINAL-TES.
        LS_FINAL-ASS_VAL = - LS_FINAL-ASS_VAL.

      ENDIF.

*       IF ( ls_final-fkart = 'US1' OR ls_final-fkart = 'US2' ).
      IF LS_FINAL-FKART = 'US1' .
        LS_FINAL-STATUS     = 'C'.
        LS_FINAL-BASE_VAL   = LS_FINAL-BASE_VAL * -1 .
        LS_FINAL-VAL_INR    = LS_FINAL-VAL_INR  * -1.
        LS_FINAL-DIS        = LS_FINAL-DIS      * -1.
        LS_FINAL-PF_VAL     = LS_FINAL-PF_VAL   * -1.
        LS_FINAL-ASS_VAL    = LS_FINAL-ASS_VAL  * -1.
        LS_FINAL-ULOC       = LS_FINAL-ULOC     * -1.
        LS_FINAL-USTA       = LS_FINAL-USTA     * -1.
        LS_FINAL-UCOU       = LS_FINAL-UCOU     * -1.
        LS_FINAL-UOTH       = LS_FINAL-UOTH     * -1.
        LS_FINAL-FRT        = LS_FINAL-FRT      * -1.
        LS_FINAL-TES        = LS_FINAL-TES      * -1.
      ENDIF.
      IF LS_FINAL-STATUS     = 'C'.
        LS_FINAL-BELNR1 = ''.
        LS_FINAL-INT_PR3 = ''.
      ENDIF.

*      ls_final-tot =
*             ls_final-ass_val     + ls_final-ULOC + ls_final-USTA
*             + ls_final-UCOU + ls_final-frt  + ls_final-tes  .
      "+ ls_final-exe_val + ls_final-edu_val + ls_final-hse_val + ls_final-vat + ls_final-ins + ls_final-com_cess
      "+ ls_final-com_cess_v  + ls_final-tcs
      IF LS_FINAL-FKART = 'ZRE' OR LS_FINAL-FKART = 'ZCR'.
*        ls_final-tot        = ls_final-tot * -1.
        LS_FINAL-BASE_VAL   = LS_FINAL-BASE_VAL * -1.
        LS_FINAL-VAL_INR    = LS_FINAL-VAL_INR * -1.
        LS_FINAL-ASS_VAL    = LS_FINAL-ASS_VAL * -1.
*        ls_final-exe_val    = ls_final-exe_val * -1.
*        ls_final-edu_val    = ls_final-edu_val * -1.
*        ls_final-hse_val    = ls_final-hse_val * -1.
*        ls_final-vat        = ls_final-vat * -1.
        LS_FINAL-ULOC       = LS_FINAL-ULOC * -1.
        LS_FINAL-USTA       = LS_FINAL-ULOC * -1.
        LS_FINAL-UCOU       = LS_FINAL-UCOU * -1.
        LS_FINAL-UOTH       = LS_FINAL-UOTH * -1.
        LS_FINAL-FRT        = LS_FINAL-FRT * -1.
*        ls_final-ins        = ls_final-ins * -1.
        LS_FINAL-TES        = LS_FINAL-TES * -1.
*        ls_final-ass_gst    = ls_final-ass_gst * -1.
*        ls_final-com_cess   = ls_final-com_cess * -1.
*        ls_final-com_cess_v = ls_final-com_cess_v * -1.
*        ls_final-tcs        = ls_final-tcs * -1.

      ENDIF.

      LV_ID = LS_FINAL-VBELN.

      READ TABLE IT_VBFA INTO WA_VBFA WITH KEY VBELV = LS_SALES_INV_HDR-VBELN.
      IF SY-SUBRC = 0.
        LS_FINAL-ORIG_NO = WA_VBFA-VBELN.
        LS_FINAL-ORIG_DT = WA_VBFA-ERDAT.
      ENDIF.
*
*IF ls_final-orig_dt IS INITIAL .
*ls_final-orig_dt = ' '.
*
*ENDIF.
*IF ls_final-orig_no IS NOT INITIAL OR ls_final-fkart = 'US03' OR ls_final-fkart = 'US05' .


      "Transporter Name Text
*      CALL FUNCTION 'READ_TEXT'
*        EXPORTING
*          client                  = sy-mandt
*          id                      = 'Z002'
*          language                = sy-langu
*          name                    = lv_id
*          object                  = 'VBBK'
*        TABLES
*          lines                   = lt_lines
*        EXCEPTIONS
*          id                      = 1
*          language                = 2
*          name                    = 3
*          not_found               = 4
*          object                  = 5
*          reference_check         = 6
*          wrong_access_to_archive = 7
*          OTHERS                  = 8.
*      IF sy-subrc <> 0.
** Implement suitable error handling here
*      ENDIF.
*      IF NOT lt_lines IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-trans ls_lines-tdline INTO ls_final-trans SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-trans.
*      ENDIF.

      "LR No.
*      CLEAR: lt_lines[],ls_lines.
*      CALL FUNCTION 'READ_TEXT'
*        EXPORTING
*          client                  = sy-mandt
*          id                      = 'Z026'
*          language                = sy-langu
*          name                    = lv_id
*          object                  = 'VBBK'
*        TABLES
*          lines                   = lt_lines
*        EXCEPTIONS
*          id                      = 1
*          language                = 2
*          name                    = 3
*          not_found               = 4
*          object                  = 5
*          reference_check         = 6
*          wrong_access_to_archive = 7
*          OTHERS                  = 8.
*      IF sy-subrc <> 0.
** Implement suitable error handling here
*      ENDIF.
*      IF NOT lt_lines IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-lr_no ls_lines-tdline INTO ls_final-lr_no SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-lr_no.
*      ENDIF.

      "LR Date.
*      CLEAR: lt_lines[],ls_lines.
*      CALL FUNCTION 'READ_TEXT'
*        EXPORTING
*          client                  = sy-mandt
*          id                      = 'Z012'
*          language                = sy-langu
*          name                    = lv_id
*          object                  = 'VBBK'
*        TABLES
*          lines                   = lt_lines
*        EXCEPTIONS
*          id                      = 1
*          language                = 2
*          name                    = 3
*          not_found               = 4
*          object                  = 5
*          reference_check         = 6
*          wrong_access_to_archive = 7
*          OTHERS                  = 8.
*      IF sy-subrc <> 0.
** Implement suitable error handling here
*      ENDIF.
*      IF NOT lt_lines IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-lr_dt ls_lines-tdline INTO ls_final-lr_dt SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-lr_dt.
*      ENDIF.

      "Transport Type
*      CLEAR: lt_lines[],ls_lines.
*      CALL FUNCTION 'READ_TEXT'
*        EXPORTING
*          client                  = sy-mandt
*          id                      = 'Z013'
*          language                = sy-langu
*          name                    = lv_id
*          object                  = 'VBBK'
*        TABLES
*          lines                   = lt_lines
*        EXCEPTIONS
*          id                      = 1
*          language                = 2
*          name                    = 3
*          not_found               = 4
*          object                  = 5
*          reference_check         = 6
*          wrong_access_to_archive = 7
*          OTHERS                  = 8.
*      IF sy-subrc <> 0.
** Implement suitable error handling here
*      ENDIF.
*      IF NOT lt_lines IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-traty ls_lines-tdline INTO ls_final-traty SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-traty.
*      ENDIF.

      "Freight Type.
*      CLEAR: lt_lines[],ls_lines.
*      CALL FUNCTION 'READ_TEXT'
*        EXPORTING
*          client                  = sy-mandt
*          id                      = 'Z005'
*          language                = sy-langu
*          name                    = lv_id
*          object                  = 'VBBK'
*        TABLES
*          lines                   = lt_lines
*        EXCEPTIONS
*          id                      = 1
*          language                = 2
*          name                    = 3
*          not_found               = 4
*          object                  = 5
*          reference_check         = 6
*          wrong_access_to_archive = 7
*          OTHERS                  = 8.
*      IF sy-subrc <> 0.
** Implement suitable error handling here
*      ENDIF.
*      IF NOT lt_lines IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-frt_typ ls_lines-tdline INTO ls_final-frt_typ SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-frt_typ.
*      ENDIF.

      "LD Tag.
      CLEAR: LT_LINES[],LS_LINES.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          CLIENT                  = SY-MANDT
          ID                      = 'Z038'
          LANGUAGE                = SY-LANGU
          NAME                    = LV_ID
          OBJECT                  = 'VBBK'
        TABLES
          LINES                   = LT_LINES
        EXCEPTIONS
          ID                      = 1
          LANGUAGE                = 2
          NAME                    = 3
          NOT_FOUND               = 4
          OBJECT                  = 5
          REFERENCE_CHECK         = 6
          WRONG_ACCESS_TO_ARCHIVE = 7
          OTHERS                  = 8.
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.
      IF NOT LT_LINES IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-ld_tg ls_lines-tdline INTO ls_final-ld_tg SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-ld_tg.
      ELSE.
        LV_ID = LS_FINAL-AUBEL.
        CALL FUNCTION 'READ_TEXT'
          EXPORTING
            CLIENT                  = SY-MANDT
            ID                      = 'Z038'
            LANGUAGE                = SY-LANGU
            NAME                    = LV_ID
            OBJECT                  = 'VBBK'
          TABLES
            LINES                   = LT_LINES
          EXCEPTIONS
            ID                      = 1
            LANGUAGE                = 2
            NAME                    = 3
            NOT_FOUND               = 4
            OBJECT                  = 5
            REFERENCE_CHECK         = 6
            WRONG_ACCESS_TO_ARCHIVE = 7
            OTHERS                  = 8.
        IF SY-SUBRC <> 0.
* Implement suitable error handling here
        ENDIF.
        IF NOT LT_LINES IS INITIAL.
*          LOOP AT lt_lines INTO ls_lines.
*            IF NOT ls_lines-tdline IS INITIAL.
*              CONCATENATE ls_final-ld_tg ls_lines-tdline INTO ls_final-ld_tg SEPARATED BY space.
*            ENDIF.
*          ENDLOOP.
*          CONDENSE ls_final-ld_tg.
        ENDIF.
      ENDIF.


      LV_ID = LS_FINAL-VBELN.
      "Port Code
      CLEAR: LT_LINES[],LS_LINES.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          CLIENT                  = SY-MANDT
          ID                      = 'Z350'
          LANGUAGE                = SY-LANGU
          NAME                    = LV_ID
          OBJECT                  = 'VBBK'
        TABLES
          LINES                   = LT_LINES
        EXCEPTIONS
          ID                      = 1
          LANGUAGE                = 2
          NAME                    = 3
          NOT_FOUND               = 4
          OBJECT                  = 5
          REFERENCE_CHECK         = 6
          WRONG_ACCESS_TO_ARCHIVE = 7
          OTHERS                  = 8.
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.
      IF NOT LT_LINES IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-port_cd ls_lines-tdline INTO ls_final-port_cd SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-port_cd.
      ENDIF.

      "Shipping Bill Number
      CLEAR: LT_LINES[],LS_LINES.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          CLIENT                  = SY-MANDT
          ID                      = 'Z360'
          LANGUAGE                = SY-LANGU
          NAME                    = LV_ID
          OBJECT                  = 'VBBK'
        TABLES
          LINES                   = LT_LINES
        EXCEPTIONS
          ID                      = 1
          LANGUAGE                = 2
          NAME                    = 3
          NOT_FOUND               = 4
          OBJECT                  = 5
          REFERENCE_CHECK         = 6
          WRONG_ACCESS_TO_ARCHIVE = 7
          OTHERS                  = 8.
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.
      IF NOT LT_LINES IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-shp_bil ls_lines-tdline INTO ls_final-shp_bil SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-shp_bil.
      ENDIF.

      "Shipping Bill Date
      CLEAR: LT_LINES[],LS_LINES.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          CLIENT                  = SY-MANDT
          ID                      = 'Z370'
          LANGUAGE                = SY-LANGU
          NAME                    = LV_ID
          OBJECT                  = 'VBBK'
        TABLES
          LINES                   = LT_LINES
        EXCEPTIONS
          ID                      = 1
          LANGUAGE                = 2
          NAME                    = 3
          NOT_FOUND               = 4
          OBJECT                  = 5
          REFERENCE_CHECK         = 6
          WRONG_ACCESS_TO_ARCHIVE = 7
          OTHERS                  = 8.
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.
      IF NOT LT_LINES IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-shp_bl_dt ls_lines-tdline INTO ls_final-shp_bl_dt SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-shp_bl_dt.
      ENDIF.

      "Proof of Delivery
      CLEAR: LT_LINES[],LS_LINES.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          CLIENT                  = SY-MANDT
          ID                      = 'Z380'
          LANGUAGE                = SY-LANGU
          NAME                    = LV_ID
          OBJECT                  = 'VBBK'
        TABLES
          LINES                   = LT_LINES
        EXCEPTIONS
          ID                      = 1
          LANGUAGE                = 2
          NAME                    = 3
          NOT_FOUND               = 4
          OBJECT                  = 5
          REFERENCE_CHECK         = 6
          WRONG_ACCESS_TO_ARCHIVE = 7
          OTHERS                  = 8.
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.
      IF NOT LT_LINES IS INITIAL.
*        LOOP AT lt_lines INTO ls_lines.
*          IF NOT ls_lines-tdline IS INITIAL.
*            CONCATENATE ls_final-shp_bl_dt ls_lines-tdline INTO ls_final-shp_bl_dt SEPARATED BY space.
*          ENDIF.
*        ENDLOOP.
*        CONDENSE ls_final-shp_bl_dt.
      ENDIF.

      DATA: LV_NAME   TYPE THEAD-TDNAME.
      REFRESH LT_LINES.
      CLEAR: LS_LINES,LV_NAME.
      LV_NAME = LS_SALES_INV_HDR-VBELN.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          CLIENT                  = SY-MANDT
          ID                      = 'U003'
          LANGUAGE                = SY-LANGU
          NAME                    = LV_NAME
          OBJECT                  = 'VBBK'
        TABLES
          LINES                   = LT_LINES
        EXCEPTIONS
          ID                      = 1
          LANGUAGE                = 2
          NAME                    = 3
          NOT_FOUND               = 4
          OBJECT                  = 5
          REFERENCE_CHECK         = 6
          WRONG_ACCESS_TO_ARCHIVE = 7
          OTHERS                  = 8.
      IF SY-SUBRC <> 0.
* IMPLEMENT SUITABLE ERROR HANDLING HERE
      ENDIF.
      LOOP AT LT_LINES INTO LS_LINES.
*      lv_lines1 = ls_lines-tdline.
        LS_FINAL-TRACK = LS_LINES-TDLINE .

      ENDLOOP.




      "Material Long Text
      LV_ID = LS_FINAL-MATNR.
      CLEAR: LT_LINES,LS_LINES.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          CLIENT                  = SY-MANDT
          ID                      = 'GRUN'
          LANGUAGE                = SY-LANGU
          NAME                    = LV_ID
          OBJECT                  = 'MATERIAL'
        TABLES
          LINES                   = LT_LINES
        EXCEPTIONS
          ID                      = 1
          LANGUAGE                = 2
          NAME                    = 3
          NOT_FOUND               = 4
          OBJECT                  = 5
          REFERENCE_CHECK         = 6
          WRONG_ACCESS_TO_ARCHIVE = 7
          OTHERS                  = 8.
      IF SY-SUBRC <> 0.
* Implement suitable error handling here
      ENDIF.
      IF NOT LT_LINES IS INITIAL.
        LOOP AT LT_LINES INTO LS_LINES.
          IF NOT LS_LINES-TDLINE IS INITIAL.
            CONCATENATE LS_FINAL-LONG_TXT LS_LINES-TDLINE INTO LS_FINAL-LONG_TXT SEPARATED BY SPACE.
          ENDIF.
        ENDLOOP.
        CONDENSE LS_FINAL-LONG_TXT.
      ENDIF.

      SHIFT LS_FINAL-VBELN LEFT DELETING LEADING '0'.
      SHIFT LS_FINAL-AUBEL LEFT DELETING LEADING '0'.
*      SHIFT ls_final-xblnr LEFT DELETING LEADING '0'.
*      SHIFT ls_final-kunag LEFT DELETING LEADING '0'.

*      ls_final-curr_date  = sy-datum.
*      IF NOT ls_final-curr_date IS INITIAL.
*        CONCATENATE ls_final-curr_date+6(2) ls_final-curr_date+4(2) ls_final-curr_date+0(4)
*           INTO ls_final-curr_date SEPARATED BY '-'.
*      ENDIF.

      LS_FINAL-REF_DATE = SY-DATUM.
      IF NOT LS_FINAL-REF_DATE IS INITIAL.
        CONCATENATE LS_FINAL-REF_DATE+6(2) LS_FINAL-REF_DATE+4(2) LS_FINAL-REF_DATE+0(4)
           INTO LS_FINAL-REF_DATE SEPARATED BY '-'.
      ENDIF.

      WA_FINAL-WERKS         = LS_FINAL-WERKS.
      WA_FINAL-VBELN         = LS_FINAL-VBELN.
      WA_FINAL-STATUS        = LS_FINAL-STATUS.
      WA_FINAL-POSNR         = LS_FINAL-POSNR.
      WA_FINAL-FKART         = LS_FINAL-FKART.
      WA_FINAL-AUART         = LS_FINAL-AUART.
      WA_FINAL-VKBUR         = LS_FINAL-VKBUR.
      WA_FINAL-AUBEL         = LS_FINAL-AUBEL.
      WA_FINAL-BSTNK         = LS_FINAL-BSTNK.
      WA_FINAL-KUNAG         = LS_FINAL-KUNAG.
      WA_FINAL-NAME1         = LS_FINAL-NAME1.
      WA_FINAL-ADDRESS       = LS_FINAL-ADDRESS.
*      wa_final-vtext_tax     = ls_final-vtext_tax.
*      wa_final-stcd3         = ls_final-stcd3.
      WA_FINAL-GST_REGION    = LS_FINAL-GST_REGION.
      WA_FINAL-BEZEI         = LS_FINAL-BEZEI.
*      wa_final-kunnr         = ls_final-kunnr.
      WA_FINAL-NAME1_SH      = LS_FINAL-NAME1_SH.
*      wa_final-gst_region_sh = ls_final-gst_region_sh.
      WA_FINAL-BEZEI_SH      = LS_FINAL-BEZEI_SH.
      WA_FINAL-MATNR         = LS_FINAL-MATNR.
      WA_FINAL-ARKTX         = LS_FINAL-ARKTX.
      WA_FINAL-LONG_TXT      = LS_FINAL-LONG_TXT.
      WA_FINAL-KDMAT         = LS_FINAL-KDMAT.
      WA_FINAL-FKIMG         = LS_FINAL-FKIMG.
      WA_FINAL-VRKME         = LS_FINAL-VRKME.
      WA_FINAL-NETPR         = LS_FINAL-NETPR.
      WA_FINAL-BLART         = LS_FINAL-BLART.
      WA_FINAL-FI_DES        = LS_FINAL-FI_DES.
      WA_FINAL-BELNR         = LS_FINAL-BELNR.
      WA_FINAL-MWSKZ         = LS_FINAL-MWSKZ.
      WA_FINAL-TAX_TXT       = LS_FINAL-TAX_TXT.
      WA_FINAL-BASE_VAL      = ABS( LS_FINAL-BASE_VAL ).
      WA_FINAL-BKLAS         = LS_FINAL-BKLAS.
      WA_FINAL-KTEXT         = LS_FINAL-KTEXT    .
      WA_FINAL-BZTXT         = LS_FINAL-BZTXT    .
      WA_FINAL-ORG_UNIT      = LS_FINAL-ORG_UNIT .
      WA_FINAL-BRTXT         = LS_FINAL-BRTXT    .
      WA_FINAL-BRSCH         = LS_FINAL-BRSCH.
      WA_FINAL-KDGRP         = LS_FINAL-KDGRP   .
      WA_FINAL-SALE_OFF      = LS_FINAL-SALE_OFF.
      WA_FINAL-BZIRK         = LS_FINAL-BZIRK   .
      WA_FINAL-ORIG_NO       = LS_FINAL-ORIG_NO   .
      WA_FINAL-PARTNER       = LS_FINAL-PARTNER   .
      WA_FINAL-PART_NAME     = LS_FINAL-PART_NAME .
      WA_FINAL-WRKST         = LS_FINAL-WRKST .
      WA_FINAL-PSTLZ         = LS_FINAL-PSTLZ .
      WA_FINAL-TRACK         = LS_FINAL-TRACK .

      WA_FINAL-BILL_STREET     = LS_FINAL-BILL_STREET   .
      WA_FINAL-BILL_STR1       = LS_FINAL-BILL_STR1     .
      WA_FINAL-BILL_STR2       = LS_FINAL-BILL_STR2     .
      WA_FINAL-BILL_POST       = LS_FINAL-BILL_POST     .
      WA_FINAL-BILL_CITY       = LS_FINAL-BILL_CITY     .
      WA_FINAL-BILL_REG        = LS_FINAL-BILL_REG      .
      WA_FINAL-BILL_COUNTRY    = LS_FINAL-BILL_COUNTRY  .
      WA_FINAL-SHIP_CODE       = LS_FINAL-SHIP_CODE  .
      WA_FINAL-SHIP_STATE      = LS_FINAL-SHIP_STATE .
      WA_FINAL-ORT01           = LS_FINAL-ORT01 .
      WA_FINAL-BELNR1           = LS_FINAL-BELNR1.
      WA_FINAL-INT_PR3          = LS_FINAL-INT_PR3.

      CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
        CHANGING
          VALUE = WA_FINAL-INT_PR3.



      IF LS_FINAL-BASE_VAL < 0.
        CONDENSE WA_FINAL-BASE_VAL.
        CONCATENATE '-' WA_FINAL-BASE_VAL INTO WA_FINAL-BASE_VAL.
      ENDIF.
      WA_FINAL-WAERK         = LS_FINAL-WAERK.
*      wa_final-kursk         = ls_final-kursk.
      WA_FINAL-VAL_INR       = ABS( LS_FINAL-VAL_INR ).

      IF LS_FINAL-VAL_INR < 0.
        CONDENSE WA_FINAL-VAL_INR.
        CONCATENATE '-' WA_FINAL-VAL_INR INTO WA_FINAL-VAL_INR.
      ENDIF.

      WA_FINAL-PF_VAL        = ABS( LS_FINAL-PF_VAL ).
      IF LS_FINAL-PF_VAL < 0.
        CONDENSE WA_FINAL-PF_VAL.
        CONCATENATE '-' WA_FINAL-PF_VAL INTO WA_FINAL-PF_VAL.
      ENDIF.

      WA_FINAL-DIS           = ABS( LS_FINAL-DIS ).
      IF LS_FINAL-DIS < 0.
        CONDENSE WA_FINAL-DIS.
        CONCATENATE '-' WA_FINAL-DIS INTO WA_FINAL-DIS.
      ENDIF.

      WA_FINAL-ASS_VAL       = ABS( LS_FINAL-ASS_VAL ).
      IF LS_FINAL-ASS_VAL < 0.
        CONDENSE WA_FINAL-ASS_VAL.
        CONCATENATE '-' WA_FINAL-ASS_VAL INTO WA_FINAL-ASS_VAL.
      ENDIF.


      WA_FINAL-FRT           = ABS( LS_FINAL-FRT ).
      IF LS_FINAL-FRT < 0.
        CONDENSE WA_FINAL-FRT.
        CONCATENATE '-' WA_FINAL-FRT INTO WA_FINAL-FRT.
      ENDIF.



      WA_FINAL-TES           = ABS( LS_FINAL-TES ).
      IF LS_FINAL-TES < 0.
        CONDENSE WA_FINAL-TES.
        CONCATENATE '-' WA_FINAL-TES INTO WA_FINAL-TES.
      ENDIF.



      WA_FINAL-ULOC_P        = LS_FINAL-ULOC_P.


      WA_FINAL-ULOC          = ABS( LS_FINAL-ULOC ).
      IF LS_FINAL-ULOC < 0.
        CONDENSE WA_FINAL-ULOC.
        CONCATENATE '-' WA_FINAL-ULOC INTO WA_FINAL-ULOC.
      ENDIF.

      WA_FINAL-UOTH_P        = LS_FINAL-UOTH_P.

      WA_FINAL-UOTH          = ABS( LS_FINAL-UOTH ).
      IF LS_FINAL-UOTH < 0.
        CONDENSE WA_FINAL-UOTH.
        CONCATENATE '-' WA_FINAL-UOTH INTO WA_FINAL-UOTH.
      ENDIF.


      WA_FINAL-USTA_P        = LS_FINAL-USTA_P.

      WA_FINAL-USTA          = ABS( LS_FINAL-USTA ).
      IF LS_FINAL-USTA < 0.
        CONDENSE WA_FINAL-USTA.
        CONCATENATE '-' WA_FINAL-USTA INTO WA_FINAL-USTA.
      ENDIF.

      WA_FINAL-UCOU_P        = LS_FINAL-UCOU_P.

      WA_FINAL-UCOU          = ABS( LS_FINAL-UCOU ).
      IF LS_FINAL-UCOU < 0.
        CONDENSE WA_FINAL-UCOU.
        CONCATENATE '-' WA_FINAL-UCOU INTO WA_FINAL-UCOU.
      ENDIF.

      WA_FINAL-INT_PR2       = ABS( LS_FINAL-INT_PR2 ).
      IF LS_FINAL-INT_PR2 < 0.
        CONDENSE WA_FINAL-INT_PR2.
        CONCATENATE '-' WA_FINAL-INT_PR2 INTO WA_FINAL-INT_PR2.
      ENDIF.



      WA_FINAL-VTEXT         = LS_FINAL-VTEXT.

*      wa_final-stprs         = ls_final-stprs.
*      wa_final-stprs1        = ls_final-stprs1.
      WA_FINAL-ZSERIES       = LS_FINAL-ZSERIES.
      WA_FINAL-ZSIZE         = LS_FINAL-ZSIZE.
      WA_FINAL-BRAND         = LS_FINAL-BRAND.
      WA_FINAL-MOC           = LS_FINAL-MOC.
      WA_FINAL-TYPE          = LS_FINAL-TYPE.



      IF  LS_FINAL-FKDAT IS NOT INITIAL.
        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = LS_FINAL-FKDAT
          IMPORTING
            OUTPUT = WA_FINAL-FKDAT.
        CONCATENATE WA_FINAL-FKDAT+0(2) WA_FINAL-FKDAT+2(3) WA_FINAL-FKDAT+5(4)
                       INTO WA_FINAL-FKDAT SEPARATED BY '-'.


      ENDIF.


      IF LS_SALES_ORD_HDR-AUDAT IS NOT INITIAL .


        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = LS_SALES_ORD_HDR-AUDAT
          IMPORTING
            OUTPUT = WA_FINAL-AUDAT.
        CONCATENATE WA_FINAL-AUDAT+0(2) WA_FINAL-AUDAT+2(3) WA_FINAL-AUDAT+5(4)
                       INTO WA_FINAL-AUDAT SEPARATED BY '-'.


      ENDIF.



      IF LS_SALES_ORD_HDR-VDATU IS NOT INITIAL .


        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = LS_SALES_ORD_HDR-VDATU
          IMPORTING
            OUTPUT = WA_FINAL-VDATU.
        CONCATENATE WA_FINAL-VDATU+0(2) WA_FINAL-VDATU+2(3) WA_FINAL-VDATU+5(4)
                       INTO WA_FINAL-VDATU SEPARATED BY '-'.

      ENDIF.

      IF LS_FINAL-ORIG_DT IS NOT INITIAL .


        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = LS_FINAL-ORIG_DT
          IMPORTING
            OUTPUT = WA_FINAL-ORIG_DT.
        CONCATENATE WA_FINAL-ORIG_DT+0(2) WA_FINAL-ORIG_DT+2(3) WA_FINAL-ORIG_DT+5(4)
                       INTO WA_FINAL-ORIG_DT SEPARATED BY '-'.

      ENDIF.


      IF LS_SCHEDULE_LINE-EDATU IS NOT INITIAL .


        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = LS_SCHEDULE_LINE-EDATU
          IMPORTING
            OUTPUT = WA_FINAL-EDATU.
        CONCATENATE WA_FINAL-EDATU+0(2) WA_FINAL-EDATU+2(3) WA_FINAL-EDATU+5(4)
                       INTO WA_FINAL-EDATU SEPARATED BY '-'.

      ENDIF.

*      IF ls_final-curr_date IS NOT INITIAL .
*
*
*        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = sy-datum
*          IMPORTING
*            output = wa_final-curr_date.
*        CONCATENATE wa_final-curr_date+0(2) wa_final-curr_date+2(3) wa_final-curr_date+5(4)
*                       INTO wa_final-curr_date SEPARATED BY '-'.
*
*      ENDIF.
*******************************************************************************************************************

      IF  LS_SALES_INV_ITEM-AUBEL  IS NOT INITIAL.


        DATA:
          NAME      TYPE THEAD-TDNAME,
          BLANK     TYPE TLINE-TDFORMAT,
          DES       TYPE TLINE-TDLINE,
          COUNT     TYPE NUM VALUE '1',
          LT1_LINES TYPE STANDARD TABLE OF TLINE,
          LS1_LINES TYPE TLINE.



        CLEAR: LT1_LINES[],LS1_LINES.

        CALL FUNCTION 'READ_TEXT'
          EXPORTING
            CLIENT                  = SY-MANDT
            ID                      = '0001'
            LANGUAGE                = 'E'
            NAME                    = NAME
            OBJECT                  = 'VBBP'
          TABLES
            LINES                   = LT1_LINES
          EXCEPTIONS
            ID                      = 1
            LANGUAGE                = 2
            NAME                    = 3
            NOT_FOUND               = 4
            OBJECT                  = 5
            REFERENCE_CHECK         = 6
            WRONG_ACCESS_TO_ARCHIVE = 7
            OTHERS                  = 8.
        IF SY-SUBRC <> 0.
* Implement suitable error handling here
        ENDIF.


*        CLEAR ls_final-sal_txt.
        IF LT1_LINES IS NOT INITIAL.


          LOOP AT LT1_LINES INTO LS1_LINES .


          ENDLOOP.

        ENDIF.

      ENDIF.

*--------------------------------------------------------------------*
*------------Added By Abhishek Pisolkar (26.03.2018)--------------------------
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          INPUT  = SY-DATUM
        IMPORTING
          OUTPUT = WA_FINAL-REF_DATE.
      CONCATENATE WA_FINAL-REF_DATE+0(2) WA_FINAL-REF_DATE+2(3) WA_FINAL-REF_DATE+5(4)
                     INTO WA_FINAL-REF_DATE SEPARATED BY '-'.
*--------------------------------------------------------------------*
********************************************************************************************************************
*
*




      APPEND WA_FINAL TO IT_FINAL.


      APPEND LS_FINAL TO CT_FINAL.

      CLEAR:
         LS_FINAL,WA_FINAL, LS_SALES_INV_ITEM,LS_SALES_INV_HDR,LS_SALES_ORD_HDR,LS_TVKTT,LS_CUST_INFO,LS_MAT_MASTER,LS_MARC,LS_SCHEDULE_LINE,
         LS_SALES_BUSS,LT_LINES,LS_LINES,LT1_LINES,LS1_LINES,BLANK,DES,LS_SAL_TXT, LS_SAL_TXT,NAME,COUNT.
*    DELETE FROM ct_final WHERE werks = 'PL01'.
*    DELETE FROM it_final WHERE werks = 'PL01'.
    ENDLOOP.

  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GT_FINAL  text
*----------------------------------------------------------------------*
FORM DISPLAY  USING    CT_FINAL TYPE TT_FINAL.
  DATA:
    LT_FIELDCAT     TYPE SLIS_T_FIELDCAT_ALV,
    LS_ALV_LAYOUT   TYPE SLIS_LAYOUT_ALV,
    L_CALLBACK_PROG TYPE SY-REPID.

  L_CALLBACK_PROG = SY-REPID.

  PERFORM PREPARE_DISPLAY CHANGING LT_FIELDCAT.
  CLEAR LS_ALV_LAYOUT.
  LS_ALV_LAYOUT-ZEBRA = 'X'.
  LS_ALV_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.

* if p_own = 'X'.
**   PERFORM FIELDNAMES.
**  PERFORM DOWNLOAD_LOG.
*  ENDIF.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      I_CALLBACK_PROGRAM      = L_CALLBACK_PROG
*     I_CALLBACK_PF_STATUS_SET          = ' '
      I_CALLBACK_USER_COMMAND = 'UCOMM_ON_ALV'
*     I_CALLBACK_TOP_OF_PAGE  = ' '
      IS_LAYOUT               = LS_ALV_LAYOUT
      IT_FIELDCAT             = LT_FIELDCAT
      I_SAVE                  = 'X'
    TABLES
      T_OUTTAB                = CT_FINAL
    EXCEPTIONS
      PROGRAM_ERROR           = 1
      OTHERS                  = 2.
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

  IF P_DOWN = 'X'.

    PERFORM DOWNLOAD.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PREPARE_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_LT_FIELDCAT  text
*----------------------------------------------------------------------*
FORM PREPARE_DISPLAY  CHANGING CT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.
  DATA:
    GV_POS      TYPE I,
    LS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

  REFRESH CT_FIELDCAT.
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'WERKS'.
*  ls_fieldcat-outputlen = '5'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Plant'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'VBELN'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Invoice No.'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  LS_FIELDCAT-HOTSPOT   = 'X'.
  LS_FIELDCAT-NO_ZERO   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'XBLNR'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Invoice No.'(102).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ORIG_NO'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Cancel Invoice No.'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ORIG_DT'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Cancel Invoice Dt.'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'STATUS'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Status'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'POSNR'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Item Line'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'FKART'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Billing Type'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'FKDAT'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Inv. Date'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'AUART'.
*  ls_fieldcat-outputlen = '9'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Ord. Type'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'VKBUR'.
*  ls_fieldcat-outputlen = '9'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales Off'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'AUBEL'.
*  ls_fieldcat-outputlen = '12'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales Order No.'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  LS_FIELDCAT-HOTSPOT   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'AUDAT'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'SO Date'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'VDATU'.
*  ls_fieldcat-outputlen = '12'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Req.Del.Date'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'EDATU'.
*  ls_fieldcat-outputlen = '9'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Del.Date'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BSTNK'.
*  ls_fieldcat-outputlen = '16'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Customer PO.No.'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'KUNAG'.
*  ls_fieldcat-outputlen = '15'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Customer Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'NAME1'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Customer Name'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ADDRESS'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Address'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'KDGRP'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Customer Group'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'KTEXT'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Customer Group Desc'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'GST_REGION'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Customer State Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BEZEI'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Customer State Name'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.



  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'PARTNER'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales Rep. No'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'PART_NAME'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales Rep. Name'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.




  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'SALE_OFF'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales Office'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ORG_UNIT'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales Office Desc'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BZIRK'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales District'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BZTXT'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales District Desc'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BRSCH'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Industry Sector'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BRTXT'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Industry Sector Desc'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'VTEXT_TAX'.
**  ls_fieldcat-outputlen = '14'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'REGD/URD/SEZ/DEEMED/GOV'(182).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'STCD3'.
**  ls_fieldcat-outputlen = '14'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Customer GSTIN'(161).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'SHIP_CODE'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Ship To Party Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'NAME1_SH'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Ship To Name'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'GST_REGION_SH'.
**  ls_fieldcat-outputlen = '14'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Ship To Party State Code'(165).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'SHIP_STATE'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Ship To Party State Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BEZEI_SH'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Ship To Party State'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'PSTLZ'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Ship To Party Zip Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ORT01'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Ship To City'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'MATNR'.
*  ls_fieldcat-outputlen = '12'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Item Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'WRKST'.
*  ls_fieldcat-outputlen = '12'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'USA Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ARKTX'.
*  ls_fieldcat-outputlen = '30'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales Text'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'LONG_TXT'.
*  ls_fieldcat-outputlen = '50'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Long Text'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BKLAS'.
*  ls_fieldcat-outputlen = '50'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Valuation Class'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  CLEAR LS_FIELDCAT.
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'KDMAT'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Customer Item Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'FKIMG'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Inv.Qty.'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  LS_FIELDCAT-DO_SUM    = 'X'.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'VRKME'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'UOM'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'NETPR'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Rate'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BLART'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'FI Doc.Type'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'FI_DES'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'FI Doc.Type Desc'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.



  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BELNR'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'FI Doc.No.'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'MWSKZ'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Tax Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'TAX_TXT'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Tax Code Description'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BASE_VAL'.
*  ls_fieldcat-outputlen = '15'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Basic Amt(D.C.)'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  LS_FIELDCAT-DO_SUM    = 'X'.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'WAERK'.
*  ls_fieldcat-outputlen = '5'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Currency'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'DIS'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Discount'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'KURSK'.
**  ls_fieldcat-outputlen = '7'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Ex.Rate'(132).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'VAL_INR'.
*  ls_fieldcat-outputlen = '14'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Net Val'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  LS_FIELDCAT-DO_SUM    = 'X'.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ULOC_P'.
*  ls_fieldcat-outputlen = '7'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Local Tax %'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.
*
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ULOC'.
*  ls_fieldcat-outputlen = '7'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Local Amt'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.
*
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'USTA_P'.
*  ls_fieldcat-outputlen = '7'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'State Tax %'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.
*
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'USTA'.
*  ls_fieldcat-outputlen = '7'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'State Amt'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.
*
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'UCOU_P'.
*  ls_fieldcat-outputlen = '7'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'County Tax %'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.
*
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'UCOU'.
*  ls_fieldcat-outputlen = '7'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'County Amt'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'UOTH_P'.
*  ls_fieldcat-outputlen = '7'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Other Tax %'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.
*
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'UOTH'.
*  ls_fieldcat-outputlen = '7'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Other Amt'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.



  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'PF_VAL'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Handling & Shipping Chrg'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.




*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'EXE_VAL'.
**  ls_fieldcat-outputlen = '14'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Exe Duty Amt.'(121).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'EDU_VAL'.
**  ls_fieldcat-outputlen = '13'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Edu. Cess Amt'(122).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'HSE_VAL'.
**  ls_fieldcat-outputlen = '13'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'H.E. Cess Amt'(123).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'VAT'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'VAT/CST'(124).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'FRT'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Mounting Chrg'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'INS'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Insurance'(129).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'TES'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Service Charge'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ASS_VAL'.
*  ls_fieldcat-outputlen = '9'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Gross Amt'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'ASS_GST'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Assessable GST'(172).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'COM_CESS'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Com.Cess'(173).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'COM_CESS_V'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Com.Cess Amt.'(174).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'TCS_P'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'TCS%'(175).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'TCS'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'TCS Amt.'(176).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'TOT'.
**  ls_fieldcat-outputlen = '02'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Grand Total'(130).
*  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-do_sum    = 'X'.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'PRODH'.
**  ls_fieldcat-outputlen = '14'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Prod. Category'(133).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'STEUC'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'HSN Code'(134).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'VTEXT'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Sales Type'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'TRANS'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Transporter Name'(136).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'LR_NO'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'LR No.'(137).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'LR_DT'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'LR Date'(138).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'TRATY'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Transport Type'(139).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'FRT_TYP'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Freight Type'(140).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'INT_PR'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Internal Price'(141).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'STPRS'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Est. Cost'(142).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'STPRS1'.
**  ls_fieldcat-outputlen = '9'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Std. Cost'(143).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ZSERIES'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Series'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'ZSIZE'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Size'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BRAND'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Brand'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'MOC'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'MOC'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'TYPE'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Type'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'TRACK'.
*  ls_fieldcat-outputlen = '8'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Tracking No'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'LD_TG'.
**  ls_fieldcat-outputlen = '10'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'LD Tag'(149).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'ZLDFROMDATE'.
**  ls_fieldcat-outputlen = '12'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'LD Date'(150).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'ZLDPERWEEK'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'LD% Min'(155).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'ZLDMAX'.
**  ls_fieldcat-outputlen = '8'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'LD% Max'(151).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'HKONT'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Sales Ledger Code'(177).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'VTEXT1'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Sales Ledger Head'(152).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'PORT_CD'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Port Code'(178).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'SHP_BIL'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Shipping Bill Number'(179).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'SHP_BL_DT'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Shipping Bill Date'(180).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'DEL_PROOF'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Proof of Delivery'(181).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'INT_PR2'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Internal Price'(141).
  LS_FIELDCAT-SELTEXT_L = 'Total Material Cost'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BILL_STREET'.
*  ls_fieldcat-outputlen = '10'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Internal Price'(141).
  LS_FIELDCAT-SELTEXT_L = 'Bill To Street/House No'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BILL_STR1'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Bill To Street 2'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BILL_STR2'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Bill To Street 3'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BILL_POST'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Bill To Postal Code'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BILL_CITY'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Bill To City'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BILL_REG'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Bill To Region'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BILL_COUNTRY'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'Bill To Country'.
  LS_FIELDCAT-COL_POS   = GV_POS.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'REF_DATE'.
*  ls_fieldcat-outputlen = '25'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'File Create Date'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.


  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'BELNR1'.
*  ls_fieldcat-outputlen = '25'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'COGS Doc. No.'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.

  GV_POS = GV_POS + 1.
  LS_FIELDCAT-FIELDNAME = 'INT_PR3'.
*  ls_fieldcat-outputlen = '25'.
  LS_FIELDCAT-TABNAME   = 'GT_FINAL'.
  LS_FIELDCAT-SELTEXT_L = 'COGS Amount'.
  LS_FIELDCAT-COL_POS   = GV_POS.
*  ls_fieldcat-hotspot   = 'X'.
  APPEND LS_FIELDCAT TO CT_FIELDCAT.
  CLEAR LS_FIELDCAT.





*
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'SAL_TXT'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'PO DOCUMENT NO'(191).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
*
*  """""""""""""ADDED BY SARIKA TALEKAR """""""
*  gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'DELDATE'.
**  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'ADDL_Data_B_Date'(191).
*  ls_fieldcat-col_pos   = gv_pos.
**  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.
  """"""""""""""""""""""""""
*   gv_pos = gv_pos + 1.
*  ls_fieldcat-fieldname = 'REP_DATE'.
*  ls_fieldcat-outputlen = '25'.
*  ls_fieldcat-tabname   = 'GT_FINAL'.
*  ls_fieldcat-seltext_l = 'Report Ececuted Date'(191).
*  ls_fieldcat-col_pos   = gv_pos.
*  ls_fieldcat-hotspot   = 'X'.
*  APPEND ls_fieldcat TO ct_fieldcat.
*  CLEAR ls_fieldcat.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  UCOMM
*&---------------------------------------------------------------------*
*       Handlung of Commands on ALV
*----------------------------------------------------------------------*
*      -->U_UCOMM        USER COMMAND
*      -->U_SELFIELD     SELECT FIELD
*----------------------------------------------------------------------*
FORM UCOMM_ON_ALV
     USING U_UCOMM    TYPE SY-UCOMM "#EC CALLED       "Form ucomm is called indirectly.
           U_SELFIELD TYPE SLIS_SELFIELD .

  DATA:
    LS_FINAL      TYPE T_FINAL,
    L_INV_DISPLAY TYPE TCODE VALUE 'VF03',
    L_ORD_DISPLAY TYPE TCODE VALUE 'VA03'.


  IF U_UCOMM = '&IC1'.  "Klick on field

    READ TABLE GT_FINAL
         INDEX U_SELFIELD-TABINDEX
          INTO LS_FINAL.
*   Code to Display Selected purchase order in report
    IF U_SELFIELD-FIELDNAME = 'VBELN' .
      IF U_SELFIELD-VALUE IS NOT INITIAL.
        SET PARAMETER ID 'VF'
            FIELD U_SELFIELD-VALUE.
        CALL TRANSACTION  L_INV_DISPLAY AND SKIP FIRST SCREEN . "#EC CI_CALLTA       " Needs authorization for call transaction
      ENDIF.
    ENDIF.
    IF U_SELFIELD-FIELDNAME = 'AUBEL' .
      IF U_SELFIELD-VALUE IS NOT INITIAL.
        SET PARAMETER ID 'AUN'
            FIELD U_SELFIELD-VALUE.
        CALL TRANSACTION  L_ORD_DISPLAY AND SKIP FIRST SCREEN . "#EC CI_CALLTA       " Needs authorization for call transaction
      ENDIF.
    ENDIF.
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
FORM DOWNLOAD .



  TYPE-POOLS TRUXS.
  DATA: IT_CSV TYPE TRUXS_T_TEXT_DATA,
        WA_CSV TYPE LINE OF TRUXS_T_TEXT_DATA,
        HD_CSV TYPE LINE OF TRUXS_T_TEXT_DATA.

*  DATA: lv_folder(150).
  DATA: LV_FILE(30).
  DATA: LV_FULLFILE TYPE STRING,
        LV_DAT(10),
        LV_TIM(4).
  DATA: LV_MSG(80).

  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      I_TAB_SAP_DATA       = GT_FINAL
    CHANGING
      I_TAB_CONVERTED_DATA = IT_CSV
    EXCEPTIONS
      CONVERSION_FAILED    = 1
      OTHERS               = 2.
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

  PERFORM CVS_HEADER USING HD_CSV.

*  lv_folder = 'D:\usr\sap\DEV\D00\work'.
  LV_FILE = 'ZUSSALES.TXT'.

  CONCATENATE P_FOLDER '\' SY-DATUM SY-UZEIT LV_FILE
    INTO LV_FULLFILE.

  WRITE: / 'ZUSSALES Download started on', SY-DATUM, 'at', SY-UZEIT.
  OPEN DATASET LV_FULLFILE
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF SY-SUBRC = 0.
    TRANSFER HD_CSV TO LV_FULLFILE.
    LOOP AT IT_CSV INTO WA_CSV.
      IF SY-SUBRC = 0.
        TRANSFER WA_CSV TO LV_FULLFILE.

      ENDIF.
    ENDLOOP.
    CLOSE DATASET LV_FULLFILE.            " Abhishek Pisolkar (26.03.2018)
    CONCATENATE 'File' LV_FULLFILE 'downloaded' INTO LV_MSG SEPARATED BY SPACE.
    MESSAGE LV_MSG TYPE 'S'.
  ENDIF.


******************************************************new file zsales **********************************
  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      I_TAB_SAP_DATA       = IT_FINAL
    CHANGING
      I_TAB_CONVERTED_DATA = IT_CSV
    EXCEPTIONS
      CONVERSION_FAILED    = 1
      OTHERS               = 2.
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.
  .


  PERFORM CVS_HEADER USING HD_CSV.

*  lv_folder = 'D:\usr\sap\DEV\D00\work'.
  LV_FILE = 'ZUSSALES.TXT'.

  CONCATENATE P_FOLDER '\' LV_FILE
    INTO LV_FULLFILE.

  WRITE: / 'ZUSSALES Download started on', SY-DATUM, 'at', SY-UZEIT.
  OPEN DATASET LV_FULLFILE
     FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF SY-SUBRC = 0.
    TRANSFER HD_CSV TO LV_FULLFILE.
    LOOP AT IT_CSV INTO WA_CSV.
      IF SY-SUBRC = 0.
        TRANSFER WA_CSV TO LV_FULLFILE.

      ENDIF.
    ENDLOOP.
    CONCATENATE 'File' LV_FULLFILE 'downloaded' INTO LV_MSG SEPARATED BY SPACE.
    MESSAGE LV_MSG TYPE 'S'.


  ENDIF.

  """"""""""""""""""''''''temp code for file download
*  PERFORM fieldnames.
*  PERFORM download_log.
  """"""""""""""""""""""""""""""""""""


ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  CVS_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_HD_CSV  text
*----------------------------------------------------------------------*
FORM CVS_HEADER  USING    PD_CSV.
  DATA: L_FIELD_SEPERATOR.
  L_FIELD_SEPERATOR = CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB.
  CONCATENATE 'Plant'
              'Invoice No'
              'Cancel Invoice No'
              'Cancel Invoice Dt'
              'Status'
              'Item Line'
              'Billing Type'
              'Inv. Date'
              'Ord. Type'
              'Sales Off'
              'Sales Order No.'
              'SO Date'
              'Req.Del.Date'
              'Del.Date'
              'Customer PO.No.'
              'Customer Code'
              'Customer Name'
              'Address'
              'Sales Rep. No'
              'Sales Rep. Name'
              'Customer Group'
              'Customer Group Desc'
              'Sales Office'
              'Sales Office Desc'
              'Sales District'
              'Sales District Desc'
              'Industry Sector'
              'Industry Sector Desc'
              'Customer State Code'
              'Customer State Name'
              'Ship To Name'
*              'Ship To Party State Code'
              'Ship To Party State'
              'Item Code'
              'USA Code'
              'Sales Text'
              'Long Text'
              'Valuation Class'
              'Customer Item Code'
              'Inv.Qty'
              'UOM'
              'Rate'
              'FI Doc.Type'
              'FI Doc.No'
              'Tax Code'
              'Tax Code Description'
              'Basic Amt(D.C.)'
              'Currency'
              'Discount'
              'Net Val'
              'Local Tax %'
              'Local Amt'
              'State Tax %'
              'State Amt'
              'County Tax %'
              'County Amt'
              'Handling & Shipping Chrg'
              'Mounting Chrg'
              'Service Charge'
              'Gross Amt'
              'Sales Type'
*              'Est. Cost'
*              'Std. Cost'
              'Series'
              'Size'
              'Brand'
              'MOC'
              'Type'
              'Refeshable Date'
              'Ship To Party Zip Code'
              'Tracking No'
              'Total Material Cost'
              'FI Doc.Type Desc'
              'Bill To Street/House No'
              'Bill To Street 2'
              'Bill To Street 3'
              'Bill To Postal Code'
              'Bill To City'
              'Bill To Region'
              'Bill To Country'
              'Ship To Party Code'
              'Ship To Party State Code'
              'Other Tax %'
              'Other Amt'
              'Ship To City'
              'COGS Doc. No'
              'COGS Amount'
  INTO PD_CSV
  SEPARATED BY L_FIELD_SEPERATOR.

ENDFORM.
**************************************************************************************************************************

*
*FORM fieldnames.
*
*  wa_fieldname-field_name = 'Plant'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Invoice No'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Cancel Invoice No'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Cancel Invoice Dt'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Status'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Item Line'.
*  APPEND wa_fieldname TO it_fieldname.
*
*
*  wa_fieldname-field_name = 'Billing Type'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Inv. Date'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Ord. Type'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Sales Off'.
*  APPEND wa_fieldname TO it_fieldname.
**  WA_FIELDNAME-FIELD_NAME = 'Sales Off'.
**  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*  wa_fieldname-field_name = 'Sales Order No.'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'SO Date'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Req.Del.Date'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Del.Date'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Customer PO.No.'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Customer Code'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Customer Name'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Address'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Sales Rep. No'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Sales Rep. Name'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Customer Group'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Customer Group Desc'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Sales Office'.
*  APPEND wa_fieldname TO it_fieldname.
*
*
*
*  wa_fieldname-field_name = 'Sales Office Desc'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Sales District'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Sales District Desc'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Industry Sector'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Industry Sector Desc'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Customer State Code'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Customer State Name'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Ship To Name'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Ship To Party State Code'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Ship To Party State'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Item Code'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'USA Code'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Sales Text'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Long Text'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Valuation Class'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Customer Item Code'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Inv.Qty'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'UOM'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Rate'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'FI Doc.Type'.
*  APPEND wa_fieldname TO it_fieldname.
**
**  WA_FIELDNAME-FIELD_NAME = 'Est. Cost'.
**  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  wa_fieldname-field_name = 'FI Doc.No'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Tax Code'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Tax Code Description'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Basic Amt(D.C.)'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Currency'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Discount'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Net Val'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Local Tax %'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Local Amt'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'State Tax %'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'State Amt'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'County Tax %'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'County Amt'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Handling & Shipping Chrg'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Mounting Chrg'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Service Charge'.
*  APPEND wa_fieldname TO it_fieldname.
*
*  wa_fieldname-field_name = 'Gross Amt'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Sales Type'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Est. Cost'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Std. Cost'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Series'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Size'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Brand'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'MOC'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Type'.
*  APPEND wa_fieldname TO it_fieldname.
*  wa_fieldname-field_name = 'Refeshable Date'.
*  APPEND wa_fieldname TO it_fieldname.
*
*
*ENDFORM.
*
*FORM download_log.
*
*  DATA : v_fullpath      TYPE string.
*
*  CALL FUNCTION 'GUI_FILE_SAVE_DIALOG'
*    EXPORTING
*      window_title      = 'STATUS RECORD FILE'
*      default_extension = '.xls'
*    IMPORTING
**     filename          = v_efile
*      fullpath          = v_fullpath.
*
*
*  CALL FUNCTION 'GUI_DOWNLOAD'
*    EXPORTING
*      filename                = v_fullpath
*      filetype                = 'ASC'
*      write_field_separator   = 'X'
*    TABLES
*      data_tab                = it_final
*      fieldnames              = it_fieldname
*    EXCEPTIONS
*      file_write_error        = 1
*      no_batch                = 2
*      gui_refuse_filetransfer = 3
*      invalid_type            = 4
*      no_authority            = 5
*      unknown_error           = 6
*      header_not_allowed      = 7
*      separator_not_allowed   = 8
*      filesize_not_allowed    = 9
*      header_too_long         = 10
*      dp_error_create         = 11
*      dp_error_send           = 12
*      dp_error_write          = 13
*      unknown_dp_error        = 14
*      access_denied           = 15
*      dp_out_of_memory        = 16
*      disk_full               = 17
*      dp_timeout              = 18
*      file_not_found          = 19
*      dataprovider_exception  = 20
*      control_flush_error     = 21
*      OTHERS                  = 22.
*
*  IF sy-subrc <> 0.
** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*  ELSE.
*    MESSAGE 'Please check Status File' TYPE 'S'.
*  ENDIF.



*ENDFORM.

**&---------------------------------------------------------------------*
**&      Form  CVS_HEADER
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**      -->P_HD_CSV  text
**----------------------------------------------------------------------*
*FORM cvs_header  USING    pd_csv.
*  DATA: l_field_seperator.
*  l_field_seperator = cl_abap_char_utilities=>horizontal_tab.
*  CONCATENATE 'Plant'
*              'Billing No.'
*              'Invoice No.'
*              'Item Line'
*              'Billing Type'
*              'Inv. Date'
*              'Ord. Type'
*              'Sales Off'
*              'Sales Doc.No.'
*              'SO Date'
*              'Req.Del.Date'
*              'Del.Date'
*              'Customer Ref.No.'
*              'Customer Code'
*              'Customer Name'
*              'Item Code'
*              'Sales Text'
*              'Long Text'
*              'Inv.Qty.'
*              'Basic Amt(D.C.)'
*              'Curr'
*              'Ex.Rate'
*              'Basic Val(INR)'
*              'P&F Amt'
*              'Discount'
*              'Ass. Val.'
*              'Exe Duty Amt.'
*              'Edu. Cess Amt'
*              'H.E. Cess Amt'
*              'VAT/CST'
*              'Freight'
*              'Insurance'
*              'ULOC'
*              'USTA'
*              'UCOU'
*              'Grand Total'
*              'Prod. Category'
*              'HSN Code'
*              'Sales Type'
*              'Transporter Name'
*              'LR No.'
*              'LR Date'
*              'Transport Type'
*              'Freight Type'
*              'Internal Price'
*              'Est. Cost'
*              'Std. Cost'
*              'Series'
*              'Size'
*              'Brand'
*              'MOC'
*              'Type'
*              'LD Tag'
*              'LD Date'
*              'LD% Min'
*              'LD% Max'
*              'Sales Ledger Head'
*              'Status'
*              'Customer Item Code'
*              'GSTIN No'
*              'Region'
*              'State Code'
*              'Ship To Party'
*              'Ship To Party Name'
*              'Ship To Region'
*              'Ship To State Code'
*              'Unit'
*              'Rate'
*              'Taxcode'
*              'Tax Code Description'
*              'Testing Charge'
*              'Assessable GST'
*              'Comp Cess%'
*              'Comp Cess Amt'
*              'TCS%'
*              'TCS amt'
*              'Sales Ledger'
*              'Port Code'
*              'Shipping Bill Number'
*              'Shipping Bill Dt'
*              'Proof of Delivery'
*              'Tax Classification'
*              'Original Invoice Number'
*              'Invoice Date'
*              'FI Document No.'
*              'FI Document Type'
*              'ULOC%'
*              'USTA%'
*              'UCOU%'
*              'FILE CREATE DATE'
*              'Customer Address'
*              'Sales Item Text'
*  INTO pd_csv
*  SEPARATED BY l_field_seperator.
*
*ENDFORM.

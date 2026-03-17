*&---------------------------------------------------------------------*
*& Report ZDAILY_PURCHASE_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_DAILY_PURCHASE_REPORT.

TYPE-POOLS: SLIS.
TABLES:EKKO,EKPO.

TYPES: BEGIN OF TY_DATA,
         EBELN TYPE EKKO-EBELN,
         LIFNR TYPE EKKO-LIFNR,
         AEDAT TYPE EKKO-AEDAT,
         BUKRS TYPE EKKO-BUKRS,
         EBELP TYPE EKPO-EBELP,
         WERKS TYPE EKPO-WERKS,
         ELIKZ TYPE EKPO-ELIKZ,
         LOEKZ TYPE EKPO-LOEKZ,
       END OF TY_DATA.

TYPES: BEGIN OF TY_EKKO,
         EBELN TYPE EKKO-EBELN,
         BUKRS TYPE EKKO-BUKRS,
         BSART TYPE EKKO-BSART,
         EKORG TYPE EKKO-EKORG,
         LIFNR TYPE EKKO-LIFNR,
         AEDAT TYPE EKKO-AEDAT,
         EKGRP TYPE EKKO-EKGRP,
         WAERS TYPE EKKO-WAERS,
         ZTERM TYPE EKKO-ZTERM,
         SUBMI TYPE EKKO-SUBMI,
         INCO1 TYPE EKKO-INCO1,
         INCO2 TYPE EKKO-INCO2,
         FRGZU TYPE EKKO-FRGZU,
         FRGRL TYPE EKKO-FRGRL,
         KNUMV TYPE EKKO-KNUMV,
       END OF TY_EKKO,

       BEGIN OF TY_EKPO,
         EBELN  TYPE EKPO-EBELN,
         EBELP  TYPE EKPO-EBELP,
         WERKS  TYPE EKPO-WERKS,
         TXZ01  TYPE EKPO-TXZ01,
         LOEKZ  TYPE EKPO-LOEKZ,
         MATNR  TYPE EKPO-MATNR,
         MENGE  TYPE EKPO-MENGE,
         PSTYP  TYPE EKPO-PSTYP,
         KNTTP  TYPE EKPO-KNTTP,
         MWSKZ  TYPE EKPO-MWSKZ,
         NETWR  TYPE EKPO-NETWR,
         NETPR  TYPE EKPO-NETPR,
         ELIKZ  TYPE EKPO-ELIKZ,
         BSTAE  TYPE EKPO-BSTAE,
         BUKRS  TYPE EKPO-BUKRS,
         INFNR  TYPE EKPO-INFNR,
         LGORT1 TYPE EKPO-LGORT,
       END OF TY_EKPO,

       BEGIN OF TY_LFA1,
         LIFNR TYPE LFA1-LIFNR,
         LAND1 TYPE LFA1-LAND1,
         NAME1 TYPE LFA1-NAME1,
         REGIO TYPE LFA1-REGIO,
         STCD3 TYPE LFA1-STCD3,
         ADRNR TYPE LFA1-ADRNR,
       END OF TY_LFA1,

       BEGIN OF TY_T005U,
         SPRAS TYPE T005U-SPRAS,
         LAND1 TYPE T005U-LAND1,
         BLAND TYPE T005U-BLAND,
         BEZEI TYPE T005U-BEZEI,
       END OF TY_T005U,

       BEGIN OF TY_T007S,
         MWSKZ TYPE T007S-MWSKZ,
         KALSM TYPE T007S-KALSM,
         TEXT1 TYPE T007S-TEXT1,
       END OF TY_T007S,

       BEGIN OF TY_T052U,
         SPRAS TYPE T052U-SPRAS,
         ZTERM TYPE T052U-ZTERM,
         TEXT1 TYPE T052U-TEXT1,
       END OF TY_T052U,

       BEGIN OF TY_MARA,
         MATNR   TYPE MARA-MATNR,
         MTART   TYPE MARA-MTART,
         WRKST   TYPE MARA-WRKST,
         ZSERIES TYPE MARA-ZSERIES,
         ZSIZE   TYPE MARA-ZSIZE,
         BRAND   TYPE MARA-BRAND,
         MOC     TYPE MARA-MOC,
         TYPE    TYPE MARA-TYPE,
       END OF TY_MARA,

       BEGIN OF TY_MSEG,
         MBLNR      TYPE MSEG-MBLNR,
         MJAHR      TYPE MSEG-MJAHR,
         ZEILE      TYPE MSEG-ZEILE,
         EBELN      TYPE MSEG-EBELN,
         EBELP      TYPE MSEG-EBELP,
         BWART      TYPE MSEG-BWART,
         XAUTO      TYPE MSEG-XAUTO,
         LGORT      TYPE MSEG-LGORT,
         MENGE      TYPE MSEG-MENGE,
         ERFMG      TYPE MSEG-ERFMG,
         DMBTR      TYPE MSEG-DMBTR,
         BUDAT_MKPF TYPE MSEG-BUDAT_MKPF,
       END OF TY_MSEG,

       BEGIN OF TY_GRN,
         MBLNR TYPE MSEG-MBLNR,
         EBELN TYPE MSEG-EBELN,
         EBELP TYPE MSEG-EBELP,
         BWART TYPE MSEG-BWART,
         SMBLN TYPE MSEG-SMBLN,
       END OF TY_GRN,

       BEGIN OF TY_QALS,
         PRUEFLOS TYPE QALS-PRUEFLOS,
         EBELN    TYPE QALS-EBELN,
         EBELP    TYPE QALS-EBELP,
         MBLNR    TYPE QALS-MBLNR,
       END OF TY_QALS,

       BEGIN OF TY_QAMB,
         PRUEFLOS TYPE QAMB-PRUEFLOS,
         MBLNR    TYPE QAMB-MBLNR,
         TYP      TYPE QAMB-TYP,
       END OF TY_QAMB,

       BEGIN OF TY_MKPF,
         MBLNR TYPE MKPF-MBLNR,
         BLDAT TYPE MKPF-BLDAT,
         XBLNR TYPE MKPF-XBLNR,
       END OF TY_MKPF,


       BEGIN OF TY_ADRC,
         ADDRNUMBER TYPE ADRC-ADDRNUMBER,
         NAME1      TYPE ADRC-NAME1,
         CITY2      TYPE ADRC-CITY2,
         POST_CODE1 TYPE ADRC-POST_CODE1,
         STREET     TYPE ADRC-STREET,
         STR_SUPPL3 TYPE ADRC-STR_SUPPL3,
         LOCATION   TYPE ADRC-LOCATION,
       END OF TY_ADRC,

       BEGIN OF TY_MARC,
         MATNR TYPE MARC-MATNR,
         STEUC TYPE MARC-STEUC,
       END OF TY_MARC,

       BEGIN OF TY_BKPF,
         BELNR     TYPE BKPF-BELNR,
         XBLNR     TYPE BKPF-XBLNR,
         XBLNR_ALT TYPE BKPF-XBLNR_ALT,
         BLDAT     TYPE BKPF-BLDAT,
         AWKEY     TYPE BKPF-AWKEY,
         BUDAT     TYPE BKPF-BUDAT,
       END OF TY_BKPF,

       BEGIN OF TY_RBKP,
         BELNR TYPE RBKP-BELNR,
         BKTXT TYPE RBKP-BKTXT,
         ZUONR TYPE RBKP-ZUONR,
         BUDAT TYPE RBKP-BUDAT,
       END OF TY_RBKP,

       BEGIN OF TY_EKET,
         EBELN TYPE EKET-EBELN,
         EBELP TYPE EKET-EBELP,
         EINDT TYPE EKET-EINDT,
       END OF TY_EKET,

       BEGIN OF TY_RSEG,
         BELNR TYPE RSEG-BELNR,
         GJAHR TYPE RSEG-GJAHR,
         BUZEI TYPE RSEG-BUZEI,
         EBELN TYPE RSEG-EBELN,
         EBELP TYPE RSEG-EBELP,
         MWSKZ TYPE RSEG-MWSKZ,
         WRBTR TYPE RSEG-WRBTR,
         SHKZG TYPE RSEG-SHKZG,
         MENGE TYPE RSEG-MENGE,
       END OF TY_RSEG,

       BEGIN OF TY_T163X,
         SPRAS TYPE T163X-SPRAS,
         PSTYP TYPE T163X-PSTYP,
         EPSTP TYPE T163X-EPSTP,
       END OF TY_T163X,

       BEGIN OF TY_J_1IMOVEND,
         LIFNR     TYPE J_1IMOVEND-LIFNR,
         VEN_CLASS TYPE J_1IMOVEND-VEN_CLASS,
       END OF TY_J_1IMOVEND,

       BEGIN OF TY_ZGST_REGION,
         REGION     TYPE ZGST_REGION-REGION,
         GST_REGION TYPE ZGST_REGION-GST_REGION,
       END OF TY_ZGST_REGION.

TYPES : BEGIN OF TY_EKPO_EKET,
          EBELN TYPE EKPO-EBELN,
          EBELP TYPE EKPO-EBELP,
          MATNR TYPE EKPO-MATNR,
          MENGE TYPE EKPO-MENGE,
          LOEKZ TYPE EKPO-LOEKZ,
          ELIKZ TYPE EKPO-ELIKZ,
          WERKS TYPE EKPO-WERKS,
          RETPO TYPE EKPO-RETPO,
          BRTWR TYPE EKPO-BRTWR,
          WEMNG TYPE EKET-WEMNG,
          NETWR TYPE EKPO-NETWR,
        END OF TY_EKPO_EKET.

DATA : IT_EKPO_EKET TYPE STANDARD TABLE OF TY_EKPO_EKET,
       WA_EKPO_EKET TYPE TY_EKPO_EKET.

TYPES: BEGIN OF TY_EKPO1,
         MATNR TYPE EKPO-MATNR,
         EBELN TYPE EKPO-EBELN,
         EBELP TYPE EKPO-EBELP,
         MENGE TYPE EKPO-MENGE,
         LOEKZ TYPE EKPO-LOEKZ,
         ELIKZ TYPE EKPO-ELIKZ,
         WERKS TYPE EKPO-WERKS,
         RETPO TYPE EKPO-RETPO,
         BRTWR TYPE EKPO-BRTWR,
         NETWR TYPE EKPO-NETWR,
       END OF TY_EKPO1.
*
*DATA : it_ekpo TYPE STANDARD TABLE OF ty_ekpo,
*       wa_ekpo TYPE ty_ekpo.
*
DATA : IT_EKPO1 TYPE STANDARD TABLE OF TY_EKPO1,
       WA_EKPO1 TYPE TY_EKPO1.

TYPES : BEGIN OF TY_NAST,
          OBJKY TYPE NAST-OBJKY,
          KSCHL TYPE NAST-KSCHL,
          ERDAT TYPE NAST-ERDAT,
          ERUHR TYPE NAST-ERUHR,
          AENDE TYPE NAST-AENDE,
        END OF TY_NAST.

DATA : IT_NAST TYPE TABLE OF TY_NAST,
       WA_NAST TYPE          TY_NAST.

TYPES :BEGIN OF TY_KONV,
         KNUMV TYPE PRCD_ELEMENTS-KNUMV,
         KPOSN TYPE PRCD_ELEMENTS-KPOSN,
         KSCHL TYPE PRCD_ELEMENTS-KSCHL,
         KBETR TYPE PRCD_ELEMENTS-KBETR,
         KWERT TYPE PRCD_ELEMENTS-KWERT,
         KNUMH TYPE PRCD_ELEMENTS-KNUMH,
       END OF TY_KONV,

       BEGIN OF TY_KONP,
         KNUMH TYPE KONP-KNUMH,
         KOPOS TYPE KONP-KOPOS,
         KSCHL TYPE KONP-KSCHL,
         KZNEP TYPE KONP-KZNEP,
       END OF TY_KONP.
TYPES : BEGIN OF TY_EINE,
          INFNR TYPE EINE-INFNR,
          EKORG TYPE EINE-EKORG,
          WERKS TYPE EINE-WERKS,
          ESOKZ TYPE EINE-ESOKZ,
        END OF TY_EINE.

DATA : IT_EINE TYPE TABLE OF TY_EINE,
       WA_EINE TYPE TY_EINE.

DATA:IT_KONV TYPE TABLE OF TY_KONV,
     WA_KONV TYPE          TY_KONV,

     IT_KONP TYPE TABLE OF TY_KONP,
     WA_KONP TYPE          TY_KONP.



TYPES: BEGIN OF TY_FINAL,
         EBELN                 TYPE EKKO-EBELN,
         EKORG                 TYPE EKKO-EKORG,
         LIFNR                 TYPE EKKO-LIFNR,
         AEDAT                 TYPE EKKO-AEDAT,
         WAERS                 TYPE EKKO-WAERS,
         ZTERM                 TYPE EKKO-ZTERM,
         EKGRP                 TYPE EKKO-EKGRP,
         SUBMI                 TYPE EKKO-SUBMI,
         BSART                 TYPE EKKO-BSART,
         EBELP                 TYPE EKPO-EBELP,
         MATNR                 TYPE EKPO-MATNR,
         MENGE                 TYPE EKPO-MENGE,
         LOEKZ                 TYPE EKPO-LOEKZ,
         KNTTP                 TYPE EKPO-KNTTP,
         MWSKZ                 TYPE EKPO-MWSKZ,
         NETWR                 TYPE EKPO-NETWR,
         NETPR                 TYPE EKPO-NETPR,
         ELIKZ                 TYPE EKPO-ELIKZ,
         MBLNR                 TYPE MSEG-MBLNR,
         BWART                 TYPE MSEG-BWART,
         LGORT                 TYPE MSEG-LGORT,
         ERFMG                 TYPE MSEG-ERFMG,
         DMBTR                 TYPE MSEG-DMBTR,
         BUDAT_MKPF            TYPE MSEG-BUDAT_MKPF,
         SMBLN                 TYPE MSEG-SMBLN,
         NAME1                 TYPE LFA1-NAME1,
         STCD3                 TYPE LFA1-STCD3,
         BELNR                 TYPE EKBE-BELNR,
         BEWTP                 TYPE EKBE-BEWTP,
         LFBNR                 TYPE EKBE-LFBNR,
         EINDT                 TYPE EKET-EINDT,
         XBLNR                 TYPE BKPF-XBLNR,
         XBLNR_ALT             TYPE BKPF-XBLNR_ALT,
         BLDAT                 TYPE BKPF-BLDAT,
         AWKEY                 TYPE BKPF-AWKEY,
         BUDAT                 TYPE BKPF-BUDAT,
         BKTXT                 TYPE RBKP-BKTXT,
         ZUONR                 TYPE RBKP-ZUONR,
         MIRO_DATE             TYPE RBKP-BUDAT,
         MTART                 TYPE MARA-MTART,
         WRKST                 TYPE MARA-WRKST,
         ZSERIES               TYPE MARA-ZSERIES,
         ZSIZE                 TYPE MARA-ZSIZE,
         BRAND                 TYPE MARA-BRAND,
         MOC                   TYPE MARA-MOC,
         TYPE                  TYPE MARA-TYPE,
         STEUC                 TYPE MARC-STEUC,
         VEN_CLASS             TYPE CHAR50,
         ADDRESS               TYPE CHAR100,
         GST_REGION            TYPE ZGST_REGION-GST_REGION,
         BEZEI                 TYPE T005U-BEZEI,
         TEXT1                 TYPE T007S-TEXT1,
         EPSTP                 TYPE T163X-EPSTP,
         ACC_QTY               TYPE MSEG-MENGE,
         REJ_QTY               TYPE MSEG-MENGE,
         SCP_QTY               TYPE MSEG-MENGE,
         REW_QTY               TYPE MSEG-MENGE,
         GRN_QTY               TYPE MSEG-MENGE,
         MAT_TEXT              TYPE TEXT100,
         WRBTR                 TYPE RSEG-WRBTR,
         INV_QTY               TYPE RSEG-MENGE,
         DEL_IND               TYPE CHAR2,
         TERM_DES              TYPE T052U-TEXT1,
         MENGE2                TYPE MSEG-MENGE,
         MENGE3                TYPE MSEG-MENGE,
         MENGE4                TYPE MSEG-MENGE,
         PO_VAL                TYPE MSEG-DMBTR,
         PO_VAL1               TYPE MSEG-DMBTR,
         PO_VAL2               TYPE MSEG-DMBTR,
         PEND_PO_QTY           TYPE MSEG-MENGE,
         PO_VALUE              TYPE MSEG-DMBTR,
         CUST_DET              TYPE TEXT100,
         CTBG                  TYPE CHAR255,
         OLD_PO                TYPE CHAR255,
         INCO1                 TYPE EKKO-INCO1,
         INCO2                 TYPE EKKO-INCO2,
         U1                    TYPE CHAR10,
         OUTPUT                TYPE CHAR10,
         EXTEND                TYPE CHAR10,
*        convert  TYPE CHAR10,
         BSTAE                 TYPE EKPO-BSTAE,
         KSCHL                 TYPE PRCD_ELEMENTS-KSCHL,
         DIS                   TYPE PRCD_ELEMENTS-KBETR,
         DIS_AMT               TYPE PRCD_ELEMENTS-KWERT,
         FIX_DIS               TYPE PRCD_ELEMENTS-KWERT,
         VALUE                 TYPE PRCD_ELEMENTS-KWERT,
         P000                  TYPE PRCD_ELEMENTS-KWERT,
         WERKS                 TYPE EKPO-WERKS,
         CUST_PO               TYPE CHAR50,
         SHIP_DATE             TYPE CHAR50,
         ARR_DATE              TYPE CHAR50,
         OA_DATE               TYPE CHAR50,
         TAG                   TYPE CHAR255,
         SHIP                  TYPE CHAR255,
         MTC_REQ               TYPE CHAR20,
         SHIP_FROM             TYPE CHAR30,  "added by shreya
         BUKRS                 TYPE EKPO-BUKRS,
         INFNR                 TYPE EKPO-INFNR,
         ESOKZ                 TYPE EINE-ESOKZ,
         TAG_NO                TYPE CHAR50,  "added by shreya
         LGORT1                TYPE EKPO-LGORT,
         SALES_ORDER_NO        TYPE CHAR30,
         SALES_ORDER_LT_NO     TYPE CHAR30,
         SALES_ORDER_UNIT_COST TYPE CHAR30,
         OLD_PO_DELIVERY_DATE  TYPE STRING,                      ""ADDED BY 102475 ON 12TH AUGUST 2024
       END OF TY_FINAL.


TYPES : BEGIN OF TY_DOWN,
          EKORG                 TYPE EKKO-EKORG,
          EKGRP                 TYPE EKKO-EKGRP,
          LIFNR                 TYPE EKKO-LIFNR,
          NAME1                 TYPE LFA1-NAME1,
          BEZEI                 TYPE T005U-BEZEI,
          BSART                 TYPE EKKO-BSART,
          MTART                 TYPE MARA-MTART,
          EBELN                 TYPE EKKO-EBELN,
          AEDAT                 TYPE CHAR11,
          ZTERM                 TYPE EKKO-ZTERM,
          TERM_DES              TYPE CHAR50,
          ELIKZ                 TYPE EKPO-ELIKZ,
          DEL_IND               TYPE CHAR2,
          EINDT                 TYPE CHAR11,
          EBELP                 TYPE EKPO-EBELP,
          MATNR                 TYPE EKPO-MATNR,
          WRKST                 TYPE MARA-WRKST,
          MAT_TEXT              TYPE CHAR100,
          EPSTP                 TYPE T163X-EPSTP,
          KNTTP                 TYPE EKPO-KNTTP,
          WAERS                 TYPE EKKO-WAERS,
          MENGE                 TYPE CHAR15,
          NETPR                 TYPE CHAR15,
          INV_QTY               TYPE CHAR15,
          WRBTR                 TYPE CHAR15,
          GRN_QTY               TYPE CHAR15,
          DMBTR                 TYPE CHAR15,
          MWSKZ                 TYPE EKPO-MWSKZ,
          TEXT1                 TYPE CHAR50,
          BRAND                 TYPE MARA-BRAND,
          ZSIZE                 TYPE MARA-ZSIZE,
          MOC                   TYPE MARA-MOC,
          TYPE                  TYPE MARA-TYPE,
          ZSERIES               TYPE MARA-ZSERIES,
          SUBMI                 TYPE EKKO-SUBMI,
          PEND_PO_QTY           TYPE CHAR15,
          PO_VALUE              TYPE CHAR15,
          REF                   TYPE CHAR11,
          CUST_DET              TYPE TEXT100,
          CTBG                  TYPE CHAR255,
          OLD_PO                TYPE CHAR255,
          INCO1                 TYPE EKKO-INCO1,
          INCO2                 TYPE CHAR30,
          U1                    TYPE CHAR10,
          OUTPUT                TYPE CHAR10,
          EXTEND                TYPE CHAR10,
*        convert TYPE CHAR10,
          BSTAE                 TYPE EKPO-BSTAE,
          KSCHL                 TYPE PRCD_ELEMENTS-KSCHL,
          DIS                   TYPE CHAR15,
          DIS_AMT               TYPE CHAR15,
          FIX_DIS               TYPE CHAR15,
          VALUE                 TYPE CHAR15,
          WERKS                 TYPE CHAR10,
          CUST_PO               TYPE CHAR50,
          SHIP_DATE             TYPE CHAR50,
          ARR_DATE              TYPE CHAR50,
          OA_DATE               TYPE CHAR50,
          TAG                   TYPE CHAR255,
          SHIP                  TYPE CHAR255,
          MTC_REQ               TYPE CHAR20,
          SHIP_FROM             TYPE CHAR30,  "added by shreya
          TAG_NO                TYPE CHAR50,  "added by shreya
          LGORT1                TYPE CHAR50,
          SALES_ORDER_NO        TYPE CHAR30,
          SALES_ORDER_LT_NO     TYPE CHAR30,
          SALES_ORDER_UNIT_COST TYPE CHAR30,
          OLD_PO_DELIVERY_DATE  TYPE STRING,                                   "ADDED BY 102475 ON 12TH AUGUST 2024
        END OF TY_DOWN.

DATA: LT_FINAL TYPE TABLE OF TY_DOWN,
      LS_FINAL TYPE          TY_DOWN.

DATA: DOC      TYPE BKPF-AWKEY,
      LV_IND   TYPE SY-TABIX,
      LV_INDEX TYPE SY-TABIX.


DATA: IT_EKKO        TYPE TABLE OF TY_EKKO,
      WA_EKKO        TYPE          TY_EKKO,

      IT_DATA        TYPE TABLE OF TY_DATA,
      WA_DATA        TYPE          TY_DATA,

      IT_EKPO        TYPE TABLE OF TY_EKPO,
      WA_EKPO        TYPE          TY_EKPO,

      IT_MSEG        TYPE TABLE OF TY_MSEG,
      WA_MSEG        TYPE          TY_MSEG,

      IT_QUAL        TYPE TABLE OF TY_MSEG, " QUANTITY
      WA_QUAL        TYPE          TY_MSEG,

      IT_GRN         TYPE TABLE OF TY_GRN, "102 MOVEMENT.
      WA_GRN         TYPE          TY_GRN,

      IT_MKPF        TYPE TABLE OF TY_MKPF,
      WA_MKPF        TYPE          TY_MKPF,

      IT_BKPF        TYPE TABLE OF TY_BKPF,
      WA_BKPF        TYPE          TY_BKPF,

      IT_LFA1        TYPE TABLE OF TY_LFA1,
      WA_LFA1        TYPE          TY_LFA1,

      IT_MARA        TYPE TABLE OF TY_MARA,
      WA_MARA        TYPE          TY_MARA,

      IT_MARC        TYPE TABLE OF TY_MARC,
      WA_MARC        TYPE          TY_MARC,

      IT_EKET        TYPE TABLE OF TY_EKET,
      WA_EKET        TYPE          TY_EKET,

      IT_RSEG        TYPE TABLE OF TY_RSEG,
      WA_RSEG        TYPE          TY_RSEG,

      IT_RBKP        TYPE TABLE OF TY_RBKP,
      WA_RBKP        TYPE          TY_RBKP,

      IT_ADRC        TYPE TABLE OF TY_ADRC,
      WA_ADRC        TYPE          TY_ADRC,

      IT_T005U       TYPE TABLE OF TY_T005U,
      WA_T005U       TYPE          TY_T005U,

      IT_T052U       TYPE TABLE OF TY_T052U,
      WA_T052U       TYPE          TY_T052U,

      IT_T007S       TYPE TABLE OF TY_T007S,
      WA_T007S       TYPE          TY_T007S,

      IT_T163X       TYPE TABLE OF TY_T163X,
      WA_T163X       TYPE          TY_T163X,

      IT_QALS        TYPE TABLE OF TY_QALS,
      WA_QALS        TYPE          TY_QALS,

      IT_QAMB        TYPE TABLE OF TY_QAMB,
      WA_QAMB        TYPE          TY_QAMB,

      IT_J_1IMOVEND  TYPE TABLE OF TY_J_1IMOVEND,
      WA_J_1IMOVEND  TYPE          TY_J_1IMOVEND,

      IT_ZGST_REGION TYPE TABLE OF TY_ZGST_REGION,
      WA_ZGST_REGION TYPE          TY_ZGST_REGION,

      IT_FINAL       TYPE TABLE OF TY_FINAL,
      WA_FINAL       TYPE          TY_FINAL,

      IT_MSEG2       TYPE TABLE OF TY_MSEG,
      WA_MSEG2       TYPE          TY_MSEG.

DATA: IT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
      WA_FCAT LIKE LINE OF IT_FCAT.

DATA: LV_NAME   TYPE THEAD-TDNAME,
      LV_LINES  TYPE STANDARD TABLE OF TLINE,
      WA_LINES  LIKE TLINE,
      LS_ITMTXT TYPE TLINE,
      LS_MATTXT TYPE TLINE.

DATA : WA_MVKE TYPE MVKE.

SELECTION-SCREEN: BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: S_EBELN FOR EKKO-EBELN,
                  S_LIFNR FOR EKKO-LIFNR,
                  S_AEDAT FOR EKKO-AEDAT,
                  S_WERKS FOR EKPO-WERKS OBLIGATORY DEFAULT 'US01'.
*  PARAMETERS :    P_BUKRS TYPE EKKO-BUKRS OBLIGATORY DEFAULT 'US00'.
SELECTION-SCREEN: END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-002 .
  PARAMETERS P_DOWN AS CHECKBOX.
  PARAMETERS P_FOLDER LIKE RLGRAP-FILENAME DEFAULT '/Delval/USA'."USA'."USA'."usa'.
SELECTION-SCREEN END OF BLOCK B2.

SELECTION-SCREEN :BEGIN OF BLOCK B3 WITH FRAME TITLE TEXT-003.
  SELECTION-SCREEN  COMMENT /1(60) TEXT-004.
  SELECTION-SCREEN COMMENT /1(70) TEXT-005.
SELECTION-SCREEN: END OF BLOCK B3.

LOOP AT S_WERKS.
  IF S_WERKS-LOW = 'PL01'.
    S_WERKS-LOW = ' '.
  ENDIF.
  IF S_WERKS-HIGH = 'PL01'.
    S_WERKS-HIGH = ' '.
  ENDIF.
  MODIFY S_WERKS.
ENDLOOP.

START-OF-SELECTION.

  PERFORM GET_DATA.
  PERFORM GET_FCAT.
  PERFORM GET_DISPLAY.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_DATA .
  SELECT A~EBELN
         A~LIFNR
         A~AEDAT
         A~BUKRS
         B~EBELP
         B~WERKS
         B~ELIKZ
         B~LOEKZ
         INTO TABLE IT_DATA
         FROM EKKO AS A INNER JOIN  EKPO AS B
         ON A~EBELN = B~EBELN
         WHERE A~EBELN IN S_EBELN
         AND   A~LIFNR IN S_LIFNR
         AND   A~AEDAT IN S_AEDAT
         AND   B~WERKS IN S_WERKS
         AND   B~LOEKZ NE 'L'.
*         AND   b~elikz EQ ' '.

  DELETE IT_DATA WHERE WERKS = 'PL01'.

  IF IT_DATA IS NOT INITIAL.
    SELECT EBELN
           BUKRS
           BSART
           EKORG
           LIFNR
           AEDAT
           EKGRP
           WAERS
           ZTERM
           SUBMI
           INCO1
           INCO2
           FRGZU
           FRGRL
           KNUMV FROM EKKO INTO TABLE IT_EKKO
           FOR ALL ENTRIES IN IT_DATA
           WHERE EBELN = IT_DATA-EBELN.
  ENDIF.

  IF IT_EKKO IS NOT INITIAL.
    SELECT EBELN
           EBELP
           WERKS
           TXZ01
           LOEKZ
           MATNR
           MENGE
           PSTYP
           KNTTP
           MWSKZ
           NETWR
           NETPR
           ELIKZ
           BSTAE
           BUKRS
           INFNR
           LGORT FROM EKPO INTO TABLE IT_EKPO
           FOR ALL ENTRIES IN IT_EKKO
           WHERE EBELN = IT_EKKO-EBELN
            AND  LOEKZ NE 'L'.

    SELECT KNUMV
           KPOSN
           KSCHL
           KBETR
           KWERT
           KNUMH FROM PRCD_ELEMENTS INTO TABLE IT_KONV
           FOR ALL ENTRIES IN IT_EKKO
           WHERE KNUMV = IT_EKKO-KNUMV.




    SELECT LIFNR
           LAND1
           NAME1
           REGIO
           STCD3
           ADRNR FROM LFA1 INTO TABLE IT_LFA1
           FOR ALL ENTRIES IN IT_EKKO
           WHERE LIFNR = IT_EKKO-LIFNR.


    SELECT SPRAS
           ZTERM
           TEXT1 FROM T052U INTO TABLE IT_T052U
           FOR ALL ENTRIES IN IT_EKKO
           WHERE SPRAS = 'E'
             AND ZTERM = IT_EKKO-ZTERM.


  ENDIF.

  IF IT_KONV IS NOT INITIAL.
    SELECT KNUMH
           KOPOS
           KSCHL
           KZNEP FROM KONP INTO TABLE IT_KONP
           FOR ALL ENTRIES IN IT_KONV
           WHERE KNUMH = IT_KONV-KNUMH
*             AND kopos = it_konv-kposn+0(2)
             AND KZNEP = 'X'.

  ENDIF.

  IF  IT_EKPO IS NOT INITIAL.

    SELECT EBELN
             EBELP
             EINDT FROM EKET INTO TABLE IT_EKET
             FOR ALL ENTRIES IN IT_EKPO
             WHERE EBELN = IT_EKPO-EBELN
               AND EBELP = IT_EKPO-EBELP.

    SELECT A~EBELN
           A~EBELP
           A~MATNR
           A~MENGE
           A~LOEKZ
           A~ELIKZ
           A~WERKS
           A~RETPO
           A~BRTWR
           B~WEMNG
           A~NETWR
           INTO TABLE IT_EKPO_EKET
           FROM EKPO AS A
           INNER JOIN EKET AS B
           ON A~EBELN = B~EBELN
           AND A~EBELP = B~EBELP
           FOR ALL ENTRIES IN IT_EKPO
           WHERE A~EBELN EQ IT_EKPO-EBELN AND A~EBELP EQ IT_EKPO-EBELP
           AND A~LOEKZ NE 'L' AND A~RETPO NE 'X'.

    SELECT MATNR
           EBELN
           EBELP
           MENGE
           LOEKZ
           ELIKZ
           WERKS
           RETPO
           BRTWR
           NETWR
           FROM EKPO
           INTO TABLE IT_EKPO1
           FOR ALL ENTRIES IN IT_EKPO
           WHERE EBELN EQ IT_EKPO-EBELN
             AND EBELP EQ IT_EKPO-EBELP
             AND RETPO EQ 'X'.



******************code added by shreya*************
    SELECT INFNR
           EKORG
           WERKS
           ESOKZ
      FROM EINE
      INTO TABLE IT_EINE
      FOR ALL ENTRIES IN IT_EKPO
      WHERE INFNR = IT_EKPO-INFNR.

******************end by shreya*********
    SELECT BELNR
           GJAHR
           BUZEI
           EBELN
           EBELP
           MWSKZ
           WRBTR
           SHKZG
           MENGE FROM RSEG INTO TABLE IT_RSEG
           FOR ALL ENTRIES IN IT_EKPO
           WHERE EBELN = IT_EKPO-EBELN
             AND EBELP = IT_EKPO-EBELP.




    SELECT MATNR
           MTART
           WRKST
           ZSERIES
           ZSIZE
           BRAND
           MOC
           TYPE   FROM MARA INTO TABLE IT_MARA
           FOR ALL ENTRIES IN IT_EKPO
           WHERE MATNR = IT_EKPO-MATNR.

    SELECT MBLNR
           MJAHR
           ZEILE
           EBELN
           EBELP
           BWART
           XAUTO
           LGORT
           MENGE
           ERFMG
           DMBTR
           BUDAT_MKPF FROM MSEG INTO TABLE IT_MSEG
           FOR ALL ENTRIES IN IT_EKPO
           WHERE EBELN = IT_EKPO-EBELN
           AND   EBELP = IT_EKPO-EBELP
           AND BWART IN ('101','105').

    SELECT MBLNR
           MJAHR
           ZEILE
           EBELN
           EBELP
           BWART
           XAUTO
           LGORT
           MENGE
           ERFMG
           DMBTR
           BUDAT_MKPF FROM MSEG INTO TABLE IT_MSEG2
           FOR ALL ENTRIES IN IT_EKPO
           WHERE EBELN = IT_EKPO-EBELN
           AND   EBELP = IT_EKPO-EBELP
           AND BWART IN ('122').


    SELECT MBLNR
           MJAHR
           ZEILE
           EBELN
           EBELP
           BWART
           XAUTO
           LGORT
           MENGE
           ERFMG
           DMBTR
           BUDAT_MKPF FROM MSEG INTO TABLE IT_QUAL
           FOR ALL ENTRIES IN IT_EKPO
           WHERE EBELN = IT_EKPO-EBELN
           AND   EBELP = IT_EKPO-EBELP
           AND BWART = '321'
           AND XAUTO = 'X'.



    SELECT MATNR
           STEUC FROM MARC INTO TABLE IT_MARC
           FOR ALL ENTRIES IN IT_EKPO
           WHERE MATNR = IT_EKPO-MATNR.

    SELECT MWSKZ
           KALSM
           TEXT1 FROM T007S INTO TABLE IT_T007S
           FOR ALL ENTRIES IN IT_EKPO
           WHERE MWSKZ = IT_EKPO-MWSKZ
           AND   KALSM = 'ZTAXIN'.

    SELECT SPRAS
           PSTYP
           EPSTP FROM T163X INTO TABLE IT_T163X
           FOR ALL ENTRIES IN IT_EKPO
           WHERE SPRAS = SY-LANGU
           AND PSTYP = IT_EKPO-PSTYP.

  ENDIF.

  IF IT_MSEG IS NOT INITIAL .

    SELECT MBLNR
           EBELN
           EBELP
           BWART
           SMBLN FROM MSEG INTO TABLE IT_GRN
           FOR ALL ENTRIES IN IT_MSEG
           WHERE SMBLN = IT_MSEG-MBLNR
            AND EBELN = IT_MSEG-EBELN
            AND EBELP = IT_MSEG-EBELP
            AND BWART IN ( '102' , '106' ).


    SELECT PRUEFLOS
           EBELN
           EBELP
           MBLNR   FROM QALS INTO TABLE IT_QALS
           FOR ALL ENTRIES IN IT_MSEG
           WHERE MBLNR = IT_MSEG-MBLNR.

  ENDIF.

  IF IT_QALS IS NOT INITIAL.

    SELECT PRUEFLOS
           MBLNR
           TYP    FROM QAMB INTO TABLE IT_QAMB
           FOR ALL ENTRIES IN IT_QALS
           WHERE PRUEFLOS = IT_QALS-PRUEFLOS
           AND   TYP = '3'.


  ENDIF.

  IF IT_QAMB IS NOT INITIAL.

    SELECT MBLNR
           MJAHR
           ZEILE
           EBELN
           EBELP
           BWART
           XAUTO
           LGORT
           MENGE
           ERFMG
           DMBTR
           BUDAT_MKPF FROM MSEG INTO TABLE IT_QUAL
           FOR ALL ENTRIES IN IT_QAMB
           WHERE MBLNR = IT_QAMB-MBLNR
           AND BWART = '321'
           AND XAUTO = 'X'.

  ENDIF.

  IF  IT_RSEG[] IS NOT INITIAL.


    SELECT BELNR
           BKTXT
           ZUONR
           BUDAT FROM RBKP INTO TABLE IT_RBKP
           FOR ALL ENTRIES IN IT_RSEG
           WHERE BELNR = IT_RSEG-BELNR.



  ENDIF.

  IF  IT_LFA1 IS NOT INITIAL .
    SELECT LIFNR
           VEN_CLASS FROM J_1IMOVEND INTO TABLE IT_J_1IMOVEND
           FOR ALL ENTRIES IN IT_LFA1
           WHERE LIFNR = IT_LFA1-LIFNR.

    SELECT ADDRNUMBER
           NAME1
           CITY2
           POST_CODE1
           STREET
           STR_SUPPL3
           LOCATION   FROM ADRC INTO TABLE IT_ADRC
           FOR ALL ENTRIES IN IT_LFA1
           WHERE ADDRNUMBER = IT_LFA1-ADRNR.

    SELECT SPRAS
           LAND1
           BLAND
           BEZEI FROM T005U INTO TABLE IT_T005U
           FOR ALL ENTRIES IN IT_LFA1
           WHERE SPRAS = SY-LANGU
           AND   LAND1 = IT_LFA1-LAND1
           AND   BLAND = IT_LFA1-REGIO.

    SELECT REGION
           GST_REGION FROM ZGST_REGION INTO TABLE IT_ZGST_REGION
           FOR ALL ENTRIES IN IT_LFA1
           WHERE REGION = IT_LFA1-REGIO.


  ENDIF.

  IF IT_MSEG IS NOT INITIAL.

    SELECT MBLNR
           BLDAT
           XBLNR FROM MKPF INTO TABLE IT_MKPF
           FOR ALL ENTRIES IN IT_MSEG
           WHERE MBLNR = IT_MSEG-MBLNR.

  ENDIF.


  LOOP AT IT_EKPO INTO WA_EKPO.

    WA_FINAL-EBELN = WA_EKPO-EBELN.
    WA_FINAL-EBELP = WA_EKPO-EBELP.
    WA_FINAL-MATNR = WA_EKPO-MATNR.
    WA_FINAL-MENGE = WA_EKPO-MENGE.
*  WA_FINAL-PSTYP = WA_EKPO-PSTYP.
    WA_FINAL-KNTTP = WA_EKPO-KNTTP.
    WA_FINAL-MWSKZ = WA_EKPO-MWSKZ.
    WA_FINAL-NETWR = WA_EKPO-NETWR.
    WA_FINAL-NETPR = WA_EKPO-NETPR.
    WA_FINAL-ELIKZ = WA_EKPO-ELIKZ.
    WA_FINAL-BSTAE = WA_EKPO-BSTAE.
    WA_FINAL-WERKS = WA_EKPO-WERKS.
    WA_FINAL-INFNR = WA_EKPO-INFNR. "added by shreya
    WA_FINAL-LGORT1 = WA_EKPO-LGORT1. "added by shreya


    READ TABLE IT_EINE INTO WA_EINE WITH KEY INFNR = WA_EKPO-INFNR. " ADDED BY SHREYA 11_07_22
    WA_FINAL-ESOKZ = WA_EINE-ESOKZ.

    IF WA_EKPO-LOEKZ = 'L'.
      WA_FINAL-DEL_IND = 'X'.
    ENDIF.



    SELECT SINGLE OBJKY
                  KSCHL
                  ERDAT
                  ERUHR
                  AENDE FROM NAST INTO WA_NAST
                  WHERE OBJKY = WA_EKKO-EBELN
                    AND KSCHL = 'UNEU'
                    AND AENDE = ' '.
    IF WA_NAST IS NOT INITIAL.
      WA_FINAL-OUTPUT = 'YES'.
    ELSE.
      WA_FINAL-OUTPUT = 'NO'.
    ENDIF.

    SELECT SINGLE * FROM MVKE INTO WA_MVKE WHERE MATNR = WA_FINAL-MATNR AND VKORG = '1000' AND VTWEG = '30'.

    IF WA_MVKE IS NOT INITIAL.
      WA_FINAL-EXTEND = 'YES'.
    ELSE .
      WA_FINAL-EXTEND = 'NO'.
    ENDIF.



    LOOP AT IT_MSEG INTO WA_MSEG WHERE EBELN = WA_EKPO-EBELN AND EBELP = WA_EKPO-EBELP.
      READ TABLE IT_GRN INTO WA_GRN WITH KEY SMBLN = WA_MSEG-MBLNR EBELN = WA_MSEG-EBELN EBELP = WA_MSEG-EBELP.
      IF SY-SUBRC = 4.
        WA_FINAL-GRN_QTY = WA_FINAL-GRN_QTY + WA_MSEG-MENGE.
        WA_FINAL-DMBTR  = WA_FINAL-DMBTR + WA_MSEG-DMBTR.

      ENDIF.

    ENDLOOP.

*LOOP AT IT_MSEG INTO WA_MSEG WHERE EBELN = WA_EKPO-EBELN AND EBELP = WA_EKPO-EBELP.
*  READ TABLE IT_MSEG2 INTO WA_MSEG2 WITH KEY  EBELN = WA_MSEG-EBELN EBELP = WA_MSEG-EBELP.
*  IF sy-subrc = 0.
*   WA_FINAL-GRN_QTY = WA_FINAL-GRN_QTY - WA_MSEG2-MENGE.
*  ENDIF.
*  CLEAR:WA_MSEG2 .
*endloop.
    LOOP AT IT_EKPO_EKET INTO WA_EKPO_EKET WHERE EBELN = WA_EKPO-EBELN AND EBELP = WA_EKPO-EBELP.
      IF WA_EKPO_EKET-ELIKZ NE 'X' OR WA_EKPO_EKET-WEMNG NE 0.

        WA_FINAL-MENGE2 = WA_FINAL-MENGE2 + WA_EKPO_EKET-MENGE.
        WA_FINAL-PO_VAL = WA_FINAL-PO_VAL + WA_EKPO_EKET-NETWR.

      ENDIF.

      WA_FINAL-MENGE3 = WA_FINAL-MENGE3 + WA_EKPO_EKET-WEMNG.
    ENDLOOP.

    LOOP AT IT_EKPO1 INTO WA_EKPO1 WHERE EBELN = WA_EKPO-EBELN AND EBELP = WA_EKPO-EBELP.

      WA_FINAL-MENGE4 = WA_FINAL-MENGE4 + WA_EKPO1-MENGE.
      WA_FINAL-PO_VAL1 = WA_FINAL-PO_VAL1 + WA_EKPO1-NETWR.

    ENDLOOP.

    CLEAR WA_FINAL-PEND_PO_QTY.
    WA_FINAL-PEND_PO_QTY = WA_FINAL-MENGE2 - WA_FINAL-MENGE3 - WA_FINAL-MENGE4.
    WA_FINAL-PO_VAL2 =  WA_FINAL-PO_VAL - WA_FINAL-PO_VAL1.

    WA_FINAL-PO_VALUE = WA_FINAL-PO_VAL2 - WA_FINAL-DMBTR.

    IF WA_FINAL-PEND_PO_QTY LT 0.
      WA_FINAL-PEND_PO_QTY = 0.
    ENDIF.

    IF WA_FINAL-PO_VALUE LT 0.
      WA_FINAL-PO_VALUE = 0.
    ENDIF.



    READ TABLE IT_EKKO INTO WA_EKKO WITH KEY EBELN = WA_EKPO-EBELN.
    IF SY-SUBRC = 0.
      WA_FINAL-EKORG = WA_EKKO-EKORG.
      WA_FINAL-LIFNR = WA_EKKO-LIFNR.
      WA_FINAL-AEDAT = WA_EKKO-AEDAT.
      WA_FINAL-WAERS = WA_EKKO-WAERS.
      WA_FINAL-ZTERM = WA_EKKO-ZTERM.
      WA_FINAL-EKGRP = WA_EKKO-EKGRP.
      WA_FINAL-SUBMI = WA_EKKO-SUBMI.
      WA_FINAL-BSART = WA_EKKO-BSART.
      WA_FINAL-INCO1 = WA_EKKO-INCO1.
      WA_FINAL-INCO2 = WA_EKKO-INCO2.

      IF WA_EKKO-FRGRL = 'X'.
        WA_FINAL-U1 = 'NO'.
      ELSE.
        WA_FINAL-U1 = 'YES'.
      ENDIF.

    ENDIF.

    LOOP AT IT_KONV INTO WA_KONV WHERE KNUMV = WA_EKKO-KNUMV AND KPOSN = WA_FINAL-EBELP.
      CASE WA_KONV-KSCHL.
        WHEN 'R000'.
          WA_FINAL-DIS = WA_KONV-KBETR / 10.
          WA_FINAL-DIS_AMT = WA_KONV-KWERT.
        WHEN 'RA01'.
          WA_FINAL-DIS = WA_KONV-KBETR / 10.
          WA_FINAL-DIS_AMT = WA_KONV-KWERT.
        WHEN 'HB01'.
          WA_FINAL-FIX_DIS = WA_KONV-KBETR.
        WHEN 'P000'.

          IF WA_FINAL-WAERS = 'USDN'.
            WA_FINAL-P000 = WA_KONV-KBETR / 1000.
          ELSE.
            WA_FINAL-P000 = WA_KONV-KBETR.
          ENDIF.

        WHEN 'PB00'.
          WA_FINAL-P000 = WA_KONV-KBETR.
        WHEN 'PBXX'.
          WA_FINAL-P000 = WA_KONV-KBETR.
      ENDCASE.

      READ TABLE IT_KONP INTO WA_KONP WITH KEY KNUMH = WA_KONV-KNUMH." kopos = wa_konv-kposn.
      IF SY-SUBRC = 0.
        WA_FINAL-KSCHL = WA_KONP-KSCHL.
      ENDIF.

    ENDLOOP.

    READ TABLE IT_T052U INTO WA_T052U WITH KEY ZTERM = WA_EKKO-ZTERM.
    IF SY-SUBRC = 0.
      WA_FINAL-TERM_DES = WA_T052U-TEXT1.
    ENDIF.

    READ TABLE IT_T163X INTO WA_T163X WITH KEY PSTYP = WA_EKPO-PSTYP.
    IF SY-SUBRC = 0.
      WA_FINAL-EPSTP = WA_T163X-EPSTP.

    ENDIF.

    READ TABLE IT_MKPF INTO WA_MKPF WITH KEY MBLNR = WA_MSEG-MBLNR.
    IF SY-SUBRC = 0.
      WA_FINAL-XBLNR = WA_MKPF-XBLNR.
      WA_FINAL-BLDAT = WA_MKPF-BLDAT.

    ENDIF.


    READ TABLE IT_LFA1 INTO WA_LFA1 WITH KEY LIFNR = WA_EKKO-LIFNR.
    IF SY-SUBRC = 0.
      WA_FINAL-NAME1 = WA_LFA1-NAME1.
      WA_FINAL-STCD3 = WA_LFA1-STCD3.

    ENDIF.
    READ TABLE IT_J_1IMOVEND INTO WA_J_1IMOVEND WITH KEY LIFNR = WA_LFA1-LIFNR.
    IF  SY-SUBRC = 0.
      CASE WA_J_1IMOVEND-VEN_CLASS.
        WHEN ' '.
          WA_FINAL-VEN_CLASS = 'Registered'.
        WHEN '0'.
          WA_FINAL-VEN_CLASS = 'Not Registered'.
        WHEN '1'.
          WA_FINAL-VEN_CLASS = 'Compounding Scheme'.
      ENDCASE.

    ENDIF.

    READ TABLE IT_ZGST_REGION INTO WA_ZGST_REGION WITH KEY REGION = WA_LFA1-REGIO.
    IF SY-SUBRC = 0.
      WA_FINAL-GST_REGION = WA_ZGST_REGION-GST_REGION.

    ENDIF.

    READ TABLE IT_T005U INTO WA_T005U WITH KEY LAND1 = WA_LFA1-LAND1 BLAND = WA_LFA1-REGIO.
    IF SY-SUBRC = 0.
      WA_FINAL-BEZEI = WA_T005U-BEZEI.

    ENDIF.

    LOOP AT IT_RSEG INTO WA_RSEG WHERE EBELN = WA_EKPO-EBELN AND EBELP = WA_EKPO-EBELP.


      WA_FINAL-WRBTR   = WA_FINAL-WRBTR   + WA_RSEG-WRBTR.
      IF WA_RSEG-SHKZG = 'S'.
        WA_FINAL-INV_QTY = WA_FINAL-INV_QTY + WA_RSEG-MENGE.
      ENDIF.
    ENDLOOP.

    LOOP AT IT_RSEG INTO WA_RSEG WHERE EBELN = WA_EKPO-EBELN AND EBELP = WA_EKPO-EBELP.

      IF WA_RSEG-SHKZG = 'H'.
        WA_FINAL-INV_QTY = WA_FINAL-INV_QTY - WA_RSEG-MENGE.
      ENDIF.
    ENDLOOP.
*READ TABLE IT_RSEG INTO WA_RSEG WITH KEY EBELN = WA_EKPO-EBELN.
*IF SY-SUBRC = 0.
*  WA_FINAL-BELNR = WA_RSEG-BELNR.
*  WA_FINAL-WRBTR = WA_RSEG-WRBTR.
*  WA_FINAL-INV_QTY = WA_RSEG-MENGE.
*
*ENDIF.
*wa_final-value = WA_FINAL-INV_QTY * wa_final-p000. " PO Value Before Discount
    WA_FINAL-VALUE = WA_FINAL-MENGE * WA_FINAL-P000. " PO Value Before Discount
    READ TABLE IT_T007S INTO WA_T007S WITH KEY MWSKZ = WA_EKPO-MWSKZ.
    IF SY-SUBRC = 0.
      WA_FINAL-TEXT1 = WA_T007S-TEXT1.

    ENDIF.

    CONCATENATE WA_RSEG-BELNR WA_RSEG-GJAHR INTO DOC.

*    SELECT  BELNR
*            XBLNR
*            XBLNR_ALT
*            BLDAT
*            AWKEY
*            BUDAT FROM BKPF INTO TABLE IT_BKPF
*            WHERE AWKEY = DOC.



    READ TABLE IT_EKET INTO WA_EKET WITH KEY EBELN = WA_EKPO-EBELN EBELP = WA_EKPO-EBELP.
    IF SY-SUBRC = 0.
      WA_FINAL-EINDT = WA_EKET-EINDT.

    ENDIF.

    READ TABLE IT_MARA INTO WA_MARA WITH KEY MATNR = WA_EKPO-MATNR.
    IF SY-SUBRC = 0.
      WA_FINAL-MTART    = WA_MARA-MTART  .
      WA_FINAL-WRKST    = WA_MARA-WRKST  .
      WA_FINAL-ZSERIES  = WA_MARA-ZSERIES.
      WA_FINAL-ZSIZE    = WA_MARA-ZSIZE  .
      WA_FINAL-BRAND    = WA_MARA-BRAND  .
      WA_FINAL-MOC      = WA_MARA-MOC    .
      WA_FINAL-TYPE     = WA_MARA-TYPE   .

    ENDIF.

    READ TABLE IT_MARC INTO WA_MARC WITH KEY MATNR = WA_EKPO-MATNR.
    IF SY-SUBRC = 0.
      WA_FINAL-STEUC = WA_MARC-STEUC.

    ENDIF.

*READ TABLE IT_BKPF INTO WA_BKPF WITH KEY AWKEY = DOC.
* IF SY-SUBRC = 0.
**   WA_FINAL-XBLNR     = WA_BKPF-XBLNR.
*   WA_FINAL-XBLNR_ALT = WA_BKPF-XBLNR_ALT.
**   WA_FINAL-BLDAT     = WA_BKPF-BLDAT.
*   WA_FINAL-AWKEY     = WA_BKPF-AWKEY.
*   WA_FINAL-BUDAT     = WA_BKPF-BUDAT.
*
*
* ENDIF.

    READ TABLE IT_RBKP INTO WA_RBKP WITH KEY BELNR = WA_RSEG-BELNR.
    IF SY-SUBRC = 0.
      WA_FINAL-BKTXT = WA_RBKP-BKTXT.
      WA_FINAL-ZUONR = WA_RBKP-ZUONR.
      WA_FINAL-MIRO_DATE = WA_RBKP-BUDAT.
    ENDIF.

    READ TABLE IT_ADRC INTO WA_ADRC WITH KEY ADDRNUMBER = WA_LFA1-ADRNR.
    IF SY-SUBRC = 0.
      CONCATENATE WA_ADRC-NAME1 WA_ADRC-CITY2 WA_ADRC-STREET WA_ADRC-STR_SUPPL3 WA_ADRC-LOCATION 'PIN:' WA_ADRC-POST_CODE1
                  INTO WA_FINAL-ADDRESS SEPARATED BY ','.


    ENDIF.

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    LV_NAME = WA_FINAL-MATNR.
    IF LV_NAME IS NOT INITIAL.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          CLIENT                  = SY-MANDT
          ID                      = 'GRUN'
          LANGUAGE                = SY-LANGU
          NAME                    = LV_NAME
          OBJECT                  = 'MATERIAL'
        TABLES
          LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
      IF NOT LV_LINES IS INITIAL.
        LOOP AT LV_LINES INTO WA_LINES.
          IF NOT WA_LINES-TDLINE IS INITIAL.
            CONCATENATE WA_FINAL-MAT_TEXT WA_LINES-TDLINE INTO WA_FINAL-MAT_TEXT SEPARATED BY SPACE.
          ENDIF.
        ENDLOOP.

      ENDIF.
    ENDIF.
    IF WA_EKPO-PSTYP = '9'.
      WA_FINAL-MAT_TEXT = WA_EKPO-TXZ01.
    ENDIF.

    REPLACE ALL OCCURRENCES OF '<(>' IN WA_FINAL-MAT_TEXT WITH ''.
    REPLACE ALL OCCURRENCES OF '<)>' IN WA_FINAL-MAT_TEXT WITH ''.

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    LV_NAME = WA_FINAL-EBELN.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F22'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKKO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
*      break primus.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-CUST_DET WA_LINES-TDLINE INTO WA_FINAL-CUST_DET SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

      REPLACE ALL OCCURRENCES OF '<(>' IN WA_FINAL-CUST_DET WITH ''.
      REPLACE ALL OCCURRENCES OF '<)>' IN WA_FINAL-CUST_DET WITH ''.

    ENDIF.


    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    LV_NAME = WA_FINAL-EBELN.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F06'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKKO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-SHIP WA_LINES-TDLINE INTO WA_FINAL-SHIP SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.




****************ADDING STARTED BY SHREYA**********************

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    LV_NAME = WA_FINAL-EBELN.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F28'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKKO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
*      break primus.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-MTC_REQ WA_LINES-TDLINE INTO WA_FINAL-MTC_REQ SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.

********************ADDING END BY SHREYA***********************************************

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
*      lv_name = wa_final-ebeln.
    CONCATENATE WA_FINAL-EBELN WA_FINAL-EBELP INTO LV_NAME.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F08'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKPO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-CTBG WA_LINES-TDLINE INTO WA_FINAL-CTBG SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.


    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
*      lv_name = wa_final-ebeln.
    CONCATENATE WA_FINAL-EBELN WA_FINAL-EBELP INTO LV_NAME.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F09'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKPO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-TAG WA_LINES-TDLINE INTO WA_FINAL-TAG SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.



    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
*      lv_name = wa_final-ebeln.
    CONCATENATE WA_FINAL-EBELN WA_FINAL-EBELP INTO LV_NAME.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F07'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKPO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-OLD_PO WA_LINES-TDLINE INTO WA_FINAL-OLD_PO SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    LV_NAME = WA_FINAL-EBELN.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F23'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKKO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-CUST_PO WA_LINES-TDLINE INTO WA_FINAL-CUST_PO SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    LV_NAME = WA_FINAL-EBELN.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F24'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKKO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-SHIP_DATE WA_LINES-TDLINE INTO WA_FINAL-SHIP_DATE SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    LV_NAME = WA_FINAL-EBELN.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F25'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKKO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-ARR_DATE WA_LINES-TDLINE INTO WA_FINAL-ARR_DATE SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
*    CONCATENATE wa_final-ebeln wa_final-ebelp INTO lv_name.
    LV_NAME = WA_FINAL-EBELN.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F26'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKKO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-OA_DATE WA_LINES-TDLINE INTO WA_FINAL-OA_DATE SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.

*-----------------------------Added by vijay on 20.06.2024----------------*

    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    CONCATENATE WA_FINAL-EBELN WA_FINAL-EBELP INTO LV_NAME.
*    lv_name = wa_final-ebeln.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F10'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKPO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-SALES_ORDER_NO WA_LINES-TDLINE INTO WA_FINAL-SALES_ORDER_NO SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.



    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    CONCATENATE WA_FINAL-EBELN WA_FINAL-EBELP INTO LV_NAME.
*    lv_name = wa_final-ebeln.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F11'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKPO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-SALES_ORDER_LT_NO WA_LINES-TDLINE INTO WA_FINAL-SALES_ORDER_LT_NO SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.


    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    CONCATENATE WA_FINAL-EBELN WA_FINAL-EBELP INTO LV_NAME.
*    lv_name = wa_final-ebeln.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F12'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKPO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-SALES_ORDER_UNIT_COST WA_LINES-TDLINE INTO WA_FINAL-SALES_ORDER_UNIT_COST SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.



*---------------------------------------ended by vijay on 20.06.2024-----------------*


***************************    added by shreya **********
    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    LV_NAME = WA_FINAL-EBELN.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F29'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKKO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
*      break primus.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-SHIP_FROM WA_LINES-TDLINE INTO WA_FINAL-SHIP_FROM SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

      REPLACE ALL OCCURRENCES OF '<(>' IN WA_FINAL-CUST_DET WITH ''.
      REPLACE ALL OCCURRENCES OF '<)>' IN WA_FINAL-CUST_DET WITH ''.

    ENDIF.


    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    "lv_name = wa_final-ebeln.
    CONCATENATE WA_FINAL-INFNR WA_FINAL-EKORG WA_FINAL-ESOKZ WA_FINAL-WERKS INTO LV_NAME.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'BT'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EINE'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-TAG_NO WA_LINES-TDLINE INTO WA_FINAL-TAG_NO SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.

*************************Added by 102475 on 12th August 2024***************************
    CLEAR: LV_LINES, LS_MATTXT,WA_LINES,LV_NAME.
    REFRESH LV_LINES.
    CONCATENATE WA_FINAL-EBELN WA_FINAL-EBELP INTO LV_NAME.                   "Commented and added by 102475


*    lv_name = wa_final-ebeln.
    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        CLIENT                  = SY-MANDT
        ID                      = 'F13'
        LANGUAGE                = SY-LANGU
        NAME                    = LV_NAME
        OBJECT                  = 'EKPO'
      TABLES
        LINES                   = LV_LINES
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
*      break primus.
    IF NOT LV_LINES IS INITIAL.
      LOOP AT LV_LINES INTO WA_LINES.
        IF NOT WA_LINES-TDLINE IS INITIAL.
          CONCATENATE WA_FINAL-OLD_PO_DELIVERY_DATE WA_LINES-TDLINE INTO WA_FINAL-OLD_PO_DELIVERY_DATE SEPARATED BY SPACE.
        ENDIF.
      ENDLOOP.

    ENDIF.
********************************End of the changes by 102475********************************************************************


*******************************    added by shreya********************


*--------------------------------------------------------------------*
    DATA  : LV_MENGE1 TYPE MSEG-MENGE.
    DATA  : LV_MENGE2 TYPE MSEG-MENGE.
*SELECT SINGLE sum( menge ) FROM mseg INTO lv_menge1 WHERE ebeln = wa_final-ebeln AND ebelp = wa_final-ebelp AND bwart = '103'.
*    wa_final-INV_QTY = lv_menge1.
    SELECT SINGLE SUM( MENGE ) FROM MSEG INTO LV_MENGE2 WHERE EBELN = WA_FINAL-EBELN AND EBELP = WA_FINAL-EBELP  AND BWART = '122'.
    IF SY-SUBRC = 0.
      WA_FINAL-GRN_QTY = WA_FINAL-GRN_QTY - LV_MENGE2.
    ENDIF.


*--------------------------------------------------------------------*
    APPEND WA_FINAL TO IT_FINAL.




    CLEAR: WA_FINAL,DOC,WA_BKPF,WA_RSEG,WA_QAMB,WA_QALS,WA_QUAL,WA_MSEG,WA_MKPF,LV_MENGE2.",lv_menge2.

  ENDLOOP.

  IF P_DOWN = 'X'.
    LOOP AT IT_FINAL INTO WA_FINAL.

      LS_FINAL-EKORG = WA_FINAL-EKORG.
      LS_FINAL-EKGRP = WA_FINAL-EKGRP.
      LS_FINAL-WERKS = WA_FINAL-WERKS.
      LS_FINAL-LIFNR = WA_FINAL-LIFNR.
      LS_FINAL-NAME1 = WA_FINAL-NAME1.
      LS_FINAL-BEZEI = WA_FINAL-BEZEI.
      LS_FINAL-BSART = WA_FINAL-BSART.
      LS_FINAL-MTART = WA_FINAL-MTART.
      LS_FINAL-EBELN = WA_FINAL-EBELN.
      LS_FINAL-INCO1 = WA_FINAL-INCO1.
      LS_FINAL-INCO2 = WA_FINAL-INCO2.
      LS_FINAL-U1    = WA_FINAL-U1.
      LS_FINAL-OUTPUT   = WA_FINAL-OUTPUT.
      LS_FINAL-EXTEND   = WA_FINAL-EXTEND.
      LS_FINAL-BSTAE   = WA_FINAL-BSTAE.
      LS_FINAL-KSCHL   = WA_FINAL-KSCHL.
      LS_FINAL-VALUE   = WA_FINAL-VALUE.

*  ls_final-convert   = wa_final-convert.
*  ls_final-AEDAT = wa_final-AEDAT.

      IF WA_FINAL-AEDAT IS NOT INITIAL.


        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = WA_FINAL-AEDAT
          IMPORTING
            OUTPUT = LS_FINAL-AEDAT.

        CONCATENATE LS_FINAL-AEDAT+0(2) LS_FINAL-AEDAT+2(3) LS_FINAL-AEDAT+5(4)
                        INTO LS_FINAL-AEDAT SEPARATED BY '-'.

      ENDIF.

      LS_FINAL-ZTERM = WA_FINAL-ZTERM.
      LS_FINAL-TERM_DES = WA_FINAL-TERM_DES.
      LS_FINAL-ELIKZ = WA_FINAL-ELIKZ.
      LS_FINAL-DEL_IND = WA_FINAL-DEL_IND.


      IF WA_FINAL-EINDT IS NOT INITIAL.


        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = WA_FINAL-EINDT
          IMPORTING
            OUTPUT = LS_FINAL-EINDT.

        CONCATENATE LS_FINAL-EINDT+0(2) LS_FINAL-EINDT+2(3) LS_FINAL-EINDT+5(4)
                        INTO LS_FINAL-EINDT SEPARATED BY '-'.

      ENDIF.
      LS_FINAL-EBELP = WA_FINAL-EBELP.
      LS_FINAL-MATNR = WA_FINAL-MATNR.
      LS_FINAL-WRKST = WA_FINAL-WRKST.
      LS_FINAL-MAT_TEXT = WA_FINAL-MAT_TEXT.
      LS_FINAL-CUST_DET = WA_FINAL-CUST_DET.
      LS_FINAL-EPSTP = WA_FINAL-EPSTP.
      LS_FINAL-KNTTP = WA_FINAL-KNTTP.
      LS_FINAL-WAERS = WA_FINAL-WAERS.


      LS_FINAL-MENGE = WA_FINAL-MENGE.

      IF WA_FINAL-MENGE < 0 .    """""""""" NC
        CONDENSE LS_FINAL-MENGE NO-GAPS  .
        REPLACE ALL OCCURRENCES OF '-' IN LS_FINAL-MENGE WITH SPACE .
        CONCATENATE '-' LS_FINAL-MENGE  INTO LS_FINAL-MENGE  .
      ENDIF.

      LS_FINAL-NETPR = WA_FINAL-NETPR.

      LS_FINAL-INV_QTY = WA_FINAL-INV_QTY.
      IF WA_FINAL-INV_QTY < 0 .    """""""""" NC
        CONDENSE LS_FINAL-INV_QTY NO-GAPS  .
        REPLACE ALL OCCURRENCES OF '-' IN LS_FINAL-INV_QTY WITH SPACE .
        CONCATENATE '-' LS_FINAL-INV_QTY  INTO LS_FINAL-INV_QTY  .
      ENDIF.


      LS_FINAL-WRBTR         = WA_FINAL-WRBTR      .
      LS_FINAL-GRN_QTY       = WA_FINAL-GRN_QTY    .
      LS_FINAL-DMBTR         = WA_FINAL-DMBTR      .
      LS_FINAL-MWSKZ         = WA_FINAL-MWSKZ      .
      LS_FINAL-TEXT1         = WA_FINAL-TEXT1      .
      LS_FINAL-BRAND         = WA_FINAL-BRAND      .
      LS_FINAL-ZSIZE         = WA_FINAL-ZSIZE      .
      LS_FINAL-MOC           = WA_FINAL-MOC        .
      LS_FINAL-TYPE          = WA_FINAL-TYPE       .
      LS_FINAL-ZSERIES       = WA_FINAL-ZSERIES    .
      LS_FINAL-SUBMI         = WA_FINAL-SUBMI      .
      LS_FINAL-PEND_PO_QTY   = WA_FINAL-PEND_PO_QTY.
      LS_FINAL-PO_VALUE      = WA_FINAL-PO_VALUE   .
      LS_FINAL-OLD_PO        = WA_FINAL-OLD_PO     .
      LS_FINAL-CTBG          = WA_FINAL-CTBG       .
      LS_FINAL-TAG           = WA_FINAL-TAG        .
      LS_FINAL-SHIP          = WA_FINAL-SHIP       .

      LS_FINAL-DIS           = WA_FINAL-DIS.
      LS_FINAL-DIS_AMT       = WA_FINAL-DIS_AMT.
      LS_FINAL-FIX_DIS       = WA_FINAL-FIX_DIS.
      LS_FINAL-CUST_PO       = WA_FINAL-CUST_PO.
      LS_FINAL-SHIP_DATE = WA_FINAL-SHIP_DATE.

      IF LS_FINAL-SHIP_DATE IS NOT INITIAL.                                   """ADDED BY MA ON 27.03.24
        CONDENSE LS_FINAL-SHIP_DATE.
        CONCATENATE LS_FINAL-SHIP_DATE+6(4) LS_FINAL-SHIP_DATE+0(2) LS_FINAL-SHIP_DATE+3(2) INTO LS_FINAL-SHIP_DATE.

        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = LS_FINAL-SHIP_DATE
          IMPORTING
            OUTPUT = LS_FINAL-SHIP_DATE.

        CONCATENATE LS_FINAL-SHIP_DATE+0(2) LS_FINAL-SHIP_DATE+2(3) LS_FINAL-SHIP_DATE+7(2)
                        INTO LS_FINAL-SHIP_DATE SEPARATED BY '-'.
      ENDIF.

      LS_FINAL-ARR_DATE = WA_FINAL-ARR_DATE.

      IF LS_FINAL-ARR_DATE IS NOT INITIAL.                                   """ADDED BY MA ON 27.03.24
        CONDENSE LS_FINAL-ARR_DATE.
        CONCATENATE LS_FINAL-ARR_DATE+6(4) LS_FINAL-ARR_DATE+0(2) LS_FINAL-ARR_DATE+3(2) INTO LS_FINAL-ARR_DATE.

        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = LS_FINAL-ARR_DATE
          IMPORTING
            OUTPUT = LS_FINAL-ARR_DATE.

        CONCATENATE LS_FINAL-ARR_DATE+0(2) LS_FINAL-ARR_DATE+2(3) LS_FINAL-ARR_DATE+7(2)
                        INTO LS_FINAL-ARR_DATE SEPARATED BY '-'.
      ENDIF.

      LS_FINAL-OA_DATE = WA_FINAL-OA_DATE.

      IF LS_FINAL-OA_DATE IS NOT INITIAL.                                   """ADDED BY MA ON 27.03.24
        CONDENSE LS_FINAL-OA_DATE.
        CONCATENATE LS_FINAL-OA_DATE+6(4) LS_FINAL-OA_DATE+0(2) LS_FINAL-OA_DATE+3(2) INTO LS_FINAL-OA_DATE.

        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = LS_FINAL-OA_DATE
          IMPORTING
            OUTPUT = LS_FINAL-OA_DATE.

        CONCATENATE LS_FINAL-OA_DATE+0(2) LS_FINAL-OA_DATE+2(3) LS_FINAL-OA_DATE+7(2)
                        INTO LS_FINAL-OA_DATE SEPARATED BY '-'.
      ENDIF.

      CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
        CHANGING
          VALUE = LS_FINAL-DIS.

      CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
        CHANGING
          VALUE = LS_FINAL-DIS_AMT.

      CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
        CHANGING
          VALUE = LS_FINAL-FIX_DIS.

      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          INPUT  = SY-DATUM
        IMPORTING
          OUTPUT = LS_FINAL-REF.

      CONCATENATE LS_FINAL-REF+0(2) LS_FINAL-REF+2(3) LS_FINAL-REF+7(2)
                      INTO LS_FINAL-REF SEPARATED BY '-'.
      LS_FINAL-MTC_REQ = WA_FINAL-MTC_REQ. "added by shreya
      LS_FINAL-SHIP_FROM = WA_FINAL-SHIP_FROM. "added by shreya 01.07.22
      LS_FINAL-TAG_NO = WA_FINAL-TAG_NO. "added by shreya 11-07-22
      LS_FINAL-LGORT1 = WA_FINAL-LGORT1.

      LS_FINAL-SALES_ORDER_NO         =   WA_FINAL-SALES_ORDER_NO       .
      LS_FINAL-SALES_ORDER_LT_NO       =  WA_FINAL-SALES_ORDER_LT_NO    .
      LS_FINAL-SALES_ORDER_UNIT_COST    = WA_FINAL-SALES_ORDER_UNIT_COST.
      LS_FINAL-OLD_PO_DELIVERY_DATE   = WA_FINAL-OLD_PO_DELIVERY_DATE.               "Added by 102475 on 12th August 2024

      APPEND LS_FINAL TO LT_FINAL.
      CLEAR: LS_FINAL,WA_NAST,WA_MVKE."lv_menge1..
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
FORM GET_FCAT .
  PERFORM FCAT USING : '1'   'EKORG'           'IT_FINAL'      'Purchase Org'                 '20' ,
                       '2'   'EKGRP'           'IT_FINAL'      'Purchasing Group '            '20' ,
                       '3'   'LIFNR'           'IT_FINAL'      'Vendor'                       '20',
                       '4'   'NAME1'           'IT_FINAL'      'Vendor Name'                  '20' ,
                       '5'   'BEZEI'           'IT_FINAL'      'Vendor State'                 '20' ,
                       '6'   'BSART'           'IT_FINAL'      'Purchase Order Type'          '20',
                       '7'   'MTART'           'IT_FINAL'      'Material Type'                '20',
                       '8'   'EBELN'           'IT_FINAL'      'PO No.'                       '20',
*                       '9'   'XBLNR'           'IT_FINAL'      'Vendor Inv.No.'               '20',
                       '9'   'AEDAT'           'IT_FINAL'      'PO Date'                      '20',
                       '10'  'ZTERM'           'IT_FINAL'      'PO Payment Term'              '20',
                       '11'  'TERM_DES'        'IT_FINAL'      'Payment Term Desc'            '20',
                       '12'  'ELIKZ'           'IT_FINAL'      'Delivery Ind.'                '20',
                       '13'  'DEL_IND'         'IT_FINAL'      'Deletion Ind.'                '20',
                       '14'  'EINDT'           'IT_FINAL'      'Delivery Date'                '20',
                       '15'  'EBELP'           'IT_FINAL'      'PO Line Item'                 '20',
                       '16'  'MATNR'           'IT_FINAL'      'Item Code'                    '20',
                       '17'  'WRKST'           'IT_FINAL'      'USA Item Code'                '20',
                       '18'  'MAT_TEXT'        'IT_FINAL'      'Item Description '            '25',
                       '19'  'EPSTP'           'IT_FINAL'      'Item Category'                '20',
                       '20'  'KNTTP'           'IT_FINAL'      'Acc.Assign.Category'          '20',
                       '21'  'WAERS'           'IT_FINAL'      'PO.Currency'                  '10',
                       '22'  'MENGE'           'IT_FINAL'      'PO Qty'                       '20',
                       '23'  'NETPR'           'IT_FINAL'      'Unit Price'                   '20',
                       '24'  'INV_QTY'         'IT_FINAL'      'Miro Qty.'                   '20',
                       '25'  'WRBTR'           'IT_FINAL'      'Miro Value'                '20',
                       '26'  'GRN_QTY'         'IT_FINAL'      'GRN Quantity.'                '20',
                       '27'  'DMBTR'           'IT_FINAL'      'GRN Value'                   '20',
                       '28'  'MWSKZ'           'IT_FINAL'      'Tax Code'                     '10',
                       '29'  'TEXT1'           'IT_FINAL'      'Tax Code Desc.'               '18',
                       '30'  'BRAND'           'IT_FINAL'      'BRAND'                        '10',
                       '31'  'ZSIZE'           'IT_FINAL'      'SIZE'                         '10',
                       '32'  'MOC'             'IT_FINAL'      'MOC'                          '10',
                       '33'  'TYPE'            'IT_FINAL'      'TYPE'                         '10',
                       '34'  'ZSERIES'         'IT_FINAL'      'SERIES'                       '10',
                       '35'  'SUBMI'           'IT_FINAL'      'So Acknowledgement No'        '20',
                       '36'  'PEND_PO_QTY'     'IT_FINAL'      'Pending Po Quantity'          '20',
                       '37'  'PO_VALUE'        'IT_FINAL'      'Pending PO Value'             '15',
                       '38'  'CUST_DET'        'IT_FINAL'      'Customer Details'             '20',
                       '39'  'CTBG'            'IT_FINAL'      'CTBG Description'             '20',
                       '40'  'OLD_PO'          'IT_FINAL'      'Old Po No'                    '20',
                       '41'  'INCO1'           'IT_FINAL'      'Incoterm'                     '20',
                       '42'  'INCO2'           'IT_FINAL'      'Incoterm Description'         '20',
                       '43'  'U1'              'IT_FINAL'      'Release Status'               '10',
                       '44'  'OUTPUT'          'IT_FINAL'      'PO Output Type'               '10',
                       '45'  'EXTEND'          'IT_FINAL'      'Sales Area Extension (India)' '20',
                       '46'  'BSTAE'           'IT_FINAL'      'Confirmation Key '            '20',
                       '47'  'KSCHL'           'IT_FINAL'      'Condition'                    '20',
                       '48'  'DIS'             'IT_FINAL'      'Discount %'                   '20',
                       '49'  'DIS_AMT'         'IT_FINAL'      'Calculated Amount '           '20',
                       '50'  'FIX_DIS'         'IT_FINAL'      'Fixed Discount'               '20',
                       '51'  'VALUE'           'IT_FINAL'      'PO Value Before Dis'          '20',
                       '52'  'WERKS'           'IT_FINAL'      'Plant'                        '15',
*                       '53'  'CUST_PO'         'IT_FINAL'      'Customer PO'                        '10',    Commented by 102475 on 12th August 2024
                       '53'  'CUST_PO'         'IT_FINAL'      'Old PO Number(Header)'                        '10',   "Added  by 102475 on 12th August 2024
                       '54'  'SHIP_DATE'       'IT_FINAL'      'Shipping Date'                        '15',
                       '55'  'ARR_DATE'        'IT_FINAL'      'Arrival Del Date'                        '15',
                       '56'  'OA_DATE'         'IT_FINAL'      'OA Received Date'                        '15',
                       '57'  'TAG'             'IT_FINAL'      'USA Code'                             '15',
                       '58'  'SHIP'            'IT_FINAL'      'Shipping instructions'                    '20',


*                       '46'  'CONVERT'         'IT_FINAL'      'Convertable To SO'            '20'.





*
*                       '5'   'ADDRESS'         'IT_FINAL'      'ADDRESS'                      '25' ,
**                       '6'   'STCD3'           'IT_FINAL'      'GSTIN No.'                    '20' ,
*                       '7'   'VEN_CLASS'       'IT_FINAL'      'REGD/URD /Comp'               '25' ,
*                       '8'   'GST_REGION'      'IT_FINAL'      'State Code'                   '20' ,
*                       '10'  'XBLNR_ALT'       'IT_FINAL'      'Invoice No.'                  '20',
*                       '12'  'BLDAT'           'IT_FINAL'      'Invoice Date'                 '20',

*                       '25'  'ZUONR'           'IT_FINAL'      'Supplier Inv. No.'            '20',
*                       '26'  'BKTXT'           'IT_FINAL'      'Supplier Inv.Dt.'             '20',
**                       '27'  'BELNR'           'IT_FINAL'      'Miro No.'                     '20',
**                       '28'  'MIRO_DATE'       'IT_FINAL'      'Miro Date.'                   '20',
*                       '31'  'STEUC'           'IT_FINAL'      'HSN/SAC Code'                 '20',
*                       '37'  'NETWR'           'IT_FINAL'      'Total Price'                  '20',
*                       '39'  'ERFMG'           'IT_FINAL'      'Recpt.Qty.'                   '20',
*                       '40'  'ACC_QTY'         'IT_FINAL'      'Acc.Qty.'                     '20',
*                       '41'  'REJ_QTY'         'IT_FINAL'      'Rejected Qty.'                '20',
*                       '42'  'SCP_QTY'         'IT_FINAL'      'Scrap Qty.'                   '20',
*                       '43'  'REW_QTY'         'IT_FINAL'      'Rework Qty.'                  '20',
                        '59'  'MTC_REQ'         'IT_FINAL'      'MTC Required'                 '20',
                        '60'  'SHIP_FROM'       'IT_FINAL'      'Shipping Directly From'       '20',
                        '61'  'TAG_NO'          'IT_FINAL'      'Item Tag Number'              '20',
                        '62'  'LGORT1'          'IT_FINAL'      'Storage Location'              '20',
                        '63'  'SALES_ORDER_NO'          'IT_FINAL'       'Sales order no'           '20',
                        '64'  'SALES_ORDER_LT_NO'       'IT_FINAL'       'Sales Order Line-Iem No'   '20',
                        '65'  'SALES_ORDER_UNIT_COST'   'IT_FINAL'       'Sales Order Unit Cost'      '20',
                        '66'  'OLD_PO_DELIVERY_DATE'            'IT_FINAL'      'Old PO Delivery Date'                    '20'. "Added by 102475 on 12th August 2024



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_1083   text
*      -->P_1084   text
*      -->P_1085   text
*      -->P_1086   text
*      -->P_1087   text
*----------------------------------------------------------------------*
FORM FCAT  USING    VALUE(P1)
                    VALUE(P2)
                    VALUE(P3)
                    VALUE(P4)
                    VALUE(P5).
  WA_FCAT-COL_POS   = P1.
  WA_FCAT-FIELDNAME = P2.
  WA_FCAT-TABNAME   = P3.
  WA_FCAT-SELTEXT_L = P4.
*wa_fcat-key       = .
  WA_FCAT-OUTPUTLEN   = P5.

  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_DISPLAY .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER = ' '
*     I_BUFFER_ACTIVE    = ' '
      I_CALLBACK_PROGRAM = SY-REPID
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
*     IS_LAYOUT          =
      IT_FIELDCAT        = IT_FCAT
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            =
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
*     I_SAVE             = ' '
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
      T_OUTTAB           = IT_FINAL
*   EXCEPTIONS
*     PROGRAM_ERROR      = 1
*     OTHERS             = 2
    .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.
  IF P_DOWN = 'X'.

    PERFORM DOWNLOAD.

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
      I_TAB_SAP_DATA       = LT_FINAL
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


  LV_FILE = 'ZUS_PENDPO.TXT'.


  CONCATENATE P_FOLDER '/' SY-DATUM SY-UZEIT LV_FILE
    INTO LV_FULLFILE.

  WRITE: / 'ZUS_PENDPO REPORT started on', SY-DATUM, 'at', SY-UZEIT.
  OPEN DATASET LV_FULLFILE
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF SY-SUBRC = 0.
    DATA LV_STRING_2370 TYPE STRING.
    DATA LV_CRLF_2370 TYPE STRING.
    LV_CRLF_2370 = CL_ABAP_CHAR_UTILITIES=>CR_LF.
    LV_STRING_2370 = HD_CSV.
    LOOP AT IT_CSV INTO WA_CSV.
      CONCATENATE LV_STRING_2370 LV_CRLF_2370 WA_CSV INTO LV_STRING_2370.
      CLEAR: WA_CSV.
    ENDLOOP.
*TRANSFER lv_string_1648 TO lv_fullfile.
*TRANSFER lv_string_941 TO lv_fullfile.
    TRANSFER LV_STRING_2370 TO LV_FULLFILE.
    CONCATENATE 'File' LV_FULLFILE 'downloaded' INTO LV_MSG SEPARATED BY SPACE.
    MESSAGE LV_MSG TYPE 'S'.
  ENDIF.
*********************************************SQL UPLOAD FILE *****************************************
  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      I_TAB_SAP_DATA       = LT_FINAL
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


  LV_FILE = 'ZUS_PENDPO.TXT'.


  CONCATENATE P_FOLDER '/' LV_FILE
    INTO LV_FULLFILE.

  WRITE: / 'ZUS_PENDPO REPORT started on', SY-DATUM, 'at', SY-UZEIT.
  OPEN DATASET LV_FULLFILE
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF SY-SUBRC = 0.
    DATA LV_STRING_2407 TYPE STRING.
    DATA LV_CRLF_2407 TYPE STRING.
    LV_CRLF_2407 = CL_ABAP_CHAR_UTILITIES=>CR_LF.
    LV_STRING_2407 = HD_CSV.
    LOOP AT IT_CSV INTO WA_CSV.
      CONCATENATE LV_STRING_2407 LV_CRLF_2407 WA_CSV INTO LV_STRING_2407.
      CLEAR: WA_CSV.
    ENDLOOP.
*TRANSFER lv_string_1648 TO lv_fullfile.
*TRANSFER lv_string_941 TO lv_fullfile.
    TRANSFER LV_STRING_2407 TO LV_FULLFILE.
    CONCATENATE 'File' LV_FULLFILE 'downloaded' INTO LV_MSG SEPARATED BY SPACE.
    MESSAGE LV_MSG TYPE 'S'.
  ENDIF.




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
  CONCATENATE 'Purchase Org'
              'Purchasing Group '
              'Vendor'
              'Vendor Name'
              'Vendor State'
              'Purchase Order Type'
              'Material Type'
              'PO No.'
              'PO Date'
              'PO Payment Term'
              'Payment Term Desc'
              'Delivery Ind.'
              'Deletion Ind.'
              'Delivery Date'
              'PO Line Item'
              'Item Code'
              'USA Item Code'
              'Item Description '
              'Item Category'
              'Acc.Assign.Category'
              'PO.Currency'
              'PO Qty'
              'Unit Price'
              'Miro Qty.'
              'Miro Value'
              'GRN Quantity.'
              'GRN Value'
              'Tax Code'
              'Tax Code Desc.'
              'BRAND'
              'SIZE'
              'MOC'
              'TYPE'
              'SERIES'
              'So Acknowledgement No'
              'Pending Po Quantity'
              'Pending PO Value'
              'Refresh Date'
              'Customer Details'
              'CTBG Description'
              'Old Po No'
              'Incoterm'
              'Incoterm Description'
              'Release Status'
              'PO Output Type'
              'Sales Area Extension (India)'
*            'Convertable To SO'
              'Confirmation Key '
              'Condition '
              'Discount %'
              'Calculated Amount '
              'Fixed Discount'
              'PO Value Before Dis'
              'Plant'
*              'Customer PO'
              'Old PO Number(Header)'      "Added by 102475 on 12th August 2024
              'Shipping Date'
              'Arrival Del Date'
              'OA Received Date'
              'USA Code'
              'Shipping instructions'
              'MTC Required'
              'Shipping Directly From' "added by shreya
              'Item Tag Number' "added by shreya
              'Storage Location'
              'Sales order no'
              'Sales Order Line-Iem No'
              'Sales Order Unit Cost'
              'Old PO Delivery Date'
                INTO PD_CSV
                SEPARATED BY L_FIELD_SEPERATOR.


ENDFORM.

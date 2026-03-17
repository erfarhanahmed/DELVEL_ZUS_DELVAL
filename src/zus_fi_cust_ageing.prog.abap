REPORT  ZFI_CUST_AGEING
        NO STANDARD PAGE HEADING LINE-COUNT 300.

** **************TABLE DECLARATION

DATA:
   TMP_KUNNR TYPE KNA1-KUNNR.
*TABLES: bsid,kna1, bsad, knb1.
TYPE-POOLS : SLIS.

**************DATA DECLARATION

DATA : DATE1 TYPE SY-DATUM, DATE2 TYPE SY-DATUM, DATE3 TYPE I.

DATA   FS_LAYOUT TYPE SLIS_LAYOUT_ALV.
DATA : FM_NAME TYPE RS38L_FNAM.
DATA : T_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV WITH HEADER LINE.

DATA : IT_ALV_GRAPHICS             TYPE DTC_T_TC,
       IT_HYPERLINK                TYPE LVC_T_HYPE,
       IT_ADD_FIELDCAT             TYPE SLIS_T_ADD_FIELDCAT,
       IT_EXCEPT_QINFO             TYPE SLIS_T_QINFO_ALV,
       I_CALLBACK_PF_STATUS_SET    TYPE SLIS_FORMNAME,
       I_CALLBACK_HTML_TOP_OF_PAGE TYPE SLIS_FORMNAME,
       I_CALLBACK_HTML_END_OF_LIST TYPE SLIS_FORMNAME,
       I_STRUCTURE_NAME            TYPE DD02L-TABNAME,
       I_BACKGROUND_ID             TYPE SDYDO_KEY,
       I_GRID_TITLE                TYPE LVC_TITLE,
       I_GRID_SETTINGS             TYPE LVC_S_GLAY,
       IS_LAYOUT                   TYPE SLIS_LAYOUT_ALV,
       IT_SPECIAL_GROUPS           TYPE SLIS_T_SP_GROUP_ALV,
       IT_SORT                     TYPE SLIS_T_SORTINFO_ALV,
       IT_FILTER                   TYPE SLIS_T_FILTER_ALV,
       IT_EXCLUDING                TYPE SLIS_T_EXTAB,
       IS_SEL_HIDE                 TYPE SLIS_SEL_HIDE_ALV,
       IS_VARIANT                  TYPE DISVARIANT,
       IT_EVENTS                   TYPE SLIS_T_EVENT,
       IT_EVENT_EXIT               TYPE SLIS_T_EVENT_EXIT,
       IS_PRINT                    TYPE SLIS_PRINT_ALV,
       IS_REPREP_ID                TYPE SLIS_REPREP_ID.

*       IR_SALV_FULLSCREEN_ADAPTER TYPE CL_SALV_FULLSCREEN_ADAPTER,
*       O_PREVIOUS_SRAL_HANDLER    TYPE IF_SALV_GUI_SRAL_HANDLER,
*       O_COMMON_HUB               TYPE IF_SALV_GUI_COMMON_HUB.

*Internal Table for sorting
DATA T_SORT TYPE SLIS_T_SORTINFO_ALV WITH HEADER LINE.


TYPES:
  BEGIN OF T_KNVV,
    KUNNR TYPE KNVV-KUNNR,
    VKBUR TYPE KNVV-VKBUR,
  END OF T_KNVV,
  TT_KNVV TYPE STANDARD TABLE OF T_KNVV.

TYPES:
  BEGIN OF T_TVKBT,
    VKBUR TYPE TVKBT-VKBUR,
    BEZEI TYPE TVKBT-BEZEI,
  END OF T_TVKBT,
  TT_TVKBT TYPE STANDARD TABLE OF T_TVKBT.

TYPES:
  BEGIN OF T_VBRK,
    VBELN TYPE VBRK-VBELN,
    KNUMV TYPE VBRK-KNUMV,
    FKDAT TYPE VBRK-FKDAT,
  END OF T_VBRK,
  TT_VBRK TYPE STANDARD TABLE OF T_VBRK.

TYPES:
  BEGIN OF T_VBRP,
    VBELN TYPE VBRP-VBELN,
    POSNR TYPE VBRP-POSNR,
    AUBEL TYPE VBRP-AUBEL,
  END OF T_VBRP,
  TT_VBRP TYPE STANDARD TABLE OF T_VBRP.

TYPES:
  BEGIN OF T_SKAT,
    SAKNR TYPE SKAT-SAKNR,
    TXT50 TYPE SKAT-TXT50,
  END OF T_SKAT,
  TT_SKAT TYPE STANDARD TABLE OF T_SKAT.

TYPES:
  BEGIN OF T_VBAK,
    VBELN TYPE VBAK-VBELN,
    AUDAT TYPE VBAK-AUDAT,
    BSTNK TYPE VBAK-BSTNK,
    BSTDK TYPE VBAK-BSTDK,
  END OF T_VBAK,
  TT_VBAK TYPE STANDARD TABLE OF T_VBAK.

TYPES:
  BEGIN OF T_TVZBT,
    ZTERM TYPE TVZBT-ZTERM,
    VTEXT TYPE TVZBT-VTEXT,
  END OF T_TVZBT,
  TT_TVZBT TYPE STANDARD TABLE OF T_TVZBT.

TYPES:BEGIN OF TY_KNA1,
        KUNNR TYPE KNA1-KUNNR,
        NAME1 TYPE KNA1-NAME1,
        ADRNR TYPE KNA1-ADRNR,
      END OF TY_KNA1,

      BEGIN OF TY_ADRC,
        ADDRNUMBER TYPE ADRC-ADDRNUMBER,
        STREET     TYPE ADRC-STREET,
        HOUSE_NUM1 TYPE ADRC-HOUSE_NUM1,
        POST_CODE1 TYPE ADRC-POST_CODE1,
        CITY1      TYPE ADRC-CITY1,
        CITY2      TYPE ADRC-CITY2,
        COUNTRY    TYPE ADRC-COUNTRY,
        REGION     TYPE ADRC-REGION,
      END OF TY_ADRC,

      BEGIN OF TY_ADR6,
        ADDRNUMBER TYPE ADR6-ADDRNUMBER,
        SMTP_ADDR  TYPE ADR6-SMTP_ADDR,
      END OF TY_ADR6,

      BEGIN OF TY_BKPF,
        BUKRS TYPE BKPF-BUKRS,
        BELNR TYPE BKPF-BELNR,
        BLART TYPE BKPF-BLART,
        XBLNR TYPE BKPF-XBLNR,
        BKTXT TYPE BKPF-BKTXT,
      END OF TY_BKPF,

      BEGIN OF TY_BSEG,
        BUKRS TYPE BSEG-BUKRS,
        VBELN TYPE BSEG-VBELN,
        SKFBT TYPE BSEG-SKFBT,
        SKNTO TYPE BSEG-SKNTO,
      END OF TY_BSEG,

      BEGIN OF TY_KONV,
        KNUMV TYPE PRCD_ELEMENTS-KNUMV,
        KPOSN TYPE PRCD_ELEMENTS-KPOSN,
        KSCHL TYPE PRCD_ELEMENTS-KSCHL,
        KWERT TYPE PRCD_ELEMENTS-KWERT,
      END OF TY_KONV.



DATA : IT_KNA1 TYPE TABLE OF TY_KNA1,
       WA_KNA1 TYPE          TY_KNA1,

       IT_ADRC TYPE TABLE OF TY_ADRC,
       WA_ADRC TYPE          TY_ADRC,

       IT_ADR6 TYPE TABLE OF TY_ADR6,
       WA_ADR6 TYPE          TY_ADR6,

       IT_BKPF TYPE TABLE OF TY_BKPF,
       WA_BKPF TYPE          TY_BKPF,

       IT_BSEG TYPE TABLE OF TY_BSEG,
       WA_BSEG TYPE          TY_BSEG,

       IT_KONV TYPE TABLE OF TY_KONV,
       WA_KONV TYPE          TY_KONV.



TYPES: BEGIN OF IDATA ,
         NAME1      LIKE KNA1-NAME1,          "custmor Name
         NAME2      LIKE KNA1-NAME1,          "Bill to Name
         KTOKD      LIKE KNA1-KTOKD,          " customer account group
         KUNNR      LIKE BSID-KUNNR,          "Customer Code
         SHKZG      LIKE BSID-SHKZG,          "debit/credit s/h
         BUKRS      LIKE BSID-BUKRS,          "Company Code
         AUGBL      LIKE BSID-AUGBL,          "Clearing Doc No
         AUGGJ      LIKE BSID-AUGGJ,
         AUGDT      LIKE BSID-AUGDT,          "Clearing Date
         GJAHR      LIKE BSID-GJAHR,          "Fiscal year
         BELNR      LIKE BSID-BELNR,          "Document no.
         UMSKZ      LIKE BSID-UMSKZ,          "Special G/L indicator
         BUZEI      LIKE BSID-BUZEI,          "Line item no.
         BUDAT      LIKE BSID-BUDAT,          "Posting date in the document
         BLDAT      LIKE BSID-BLDAT,          "Document date in document
         WAERS      LIKE BSID-WAERS,          "Currency
         BLART      LIKE BSID-BLART,          "Doc. Type
         XBLNR      TYPE BSID-XBLNR,          "ODN
         DMBTR      LIKE BSID-DMBTR,          "Amount in local curr.
         WRBTR      LIKE BSID-WRBTR,          "Amount in local curr.
         REBZG      LIKE BSID-REBZG,          "refr inv no
         REBZJ      LIKE BSID-REBZJ,          "Fiscal year
         REBZZ      LIKE BSID-REBZZ,          "Line Item no
         VBELN      TYPE BSAD-VBELN,          "Invoice Number
         DUEDATE    LIKE BSID-AUGDT,        "Due Date
         ZTERM      LIKE BSID-ZTERM,         "Payment Term
*         zbd1t     LIKE bsid-zbd1t,         "Cash Discount Days 1
         DAY        TYPE I,
         DEBIT      LIKE BSID-DMBTR,         "Amount in local curr.
         CREDIT     LIKE BSID-DMBTR,         "Amount in local curr.
         NETBAL     LIKE BSID-DMBTR,         "Amount in local curr.
         NOT_DUE_CR TYPE BSID-DMBTR,        "Amount in local curr.
         NOT_DUE_DB TYPE BSID-DMBTR,        "Amount in local curr.
         NOT_DUE    TYPE BSID-DMBTR,        "Amount in local curr.
         DEBIT30    LIKE BSID-DMBTR,        "Amount in local curr.
         CREDIT30   LIKE BSID-DMBTR,       "Amount in local curr.
         NETB30     LIKE BSID-DMBTR,         "Amount in local curr.
         DEBIT60    LIKE BSID-DMBTR,        "Amount in local curr.
         CREDIT60   LIKE BSID-DMBTR,       "Amount in local curr.
         NETB60     LIKE BSID-DMBTR,         "Amount in local curr.
         DEBIT90    LIKE BSID-DMBTR,        "Amount in local curr.
         CREDIT90   LIKE BSID-DMBTR,       "Amount in local curr.
         NETB90     LIKE BSID-DMBTR,         "Amount in local curr.
         DEBIT120   LIKE BSID-DMBTR,       "Amount in local curr.
         CREDIT120  LIKE BSID-DMBTR,      "Amount in local curr.
         NETB120    LIKE BSID-DMBTR,         "Amount in local curr.
         DEBIT180   LIKE BSID-DMBTR,       "Amount in local curr.
         CREDIT180  LIKE BSID-DMBTR,      "Amount in local curr.
         NETB180    LIKE BSID-DMBTR,         "Amount in local curr.
         DEBIT360   LIKE BSID-DMBTR,       "Amount in local curr.
         CREDIT360  LIKE BSID-DMBTR,      "Amount in local curr.
         NETB360    LIKE BSID-DMBTR,         "Amount in local curr.
         DEBIT720   LIKE BSID-DMBTR,       "Amount in local curr.
         CREDIT720  LIKE BSID-DMBTR,      "Amount in local curr.
         NETB720    LIKE BSID-DMBTR,         "Amount in local curr.
         DEBIT730   LIKE BSID-DMBTR,       "Amount in local curr.
         CREDIT730  LIKE BSID-DMBTR,      "Amount in local curr.
         NETB730    LIKE BSID-DMBTR,         "Amount in local curr.
         DEBIT_AB   LIKE BSID-DMBTR,       "Amount in local curr.
         CREDIT_AB  LIKE BSID-DMBTR,      "Amount in local curr.
         NETB_AB    LIKE BSID-DMBTR,         "Amount in local curr.
         TDISP      TYPE STRING,
         GROUP      TYPE STRING,
         AKONT      TYPE KNB1-AKONT,
         ZFBDT      TYPE BSID-ZFBDT,
         ZBD1T      TYPE BSID-ZBD1T,
         ZBD2T      TYPE BSID-ZBD2T,
         ZBD3T      TYPE BSID-ZBD3T,
         CURR       TYPE BSID-DMBTR,
         BEZEI      TYPE TVKBT-BEZEI,
         FKDAT      TYPE VBRK-FKDAT,
         AUBEL      TYPE VBRP-AUBEL,
         AUDAT      TYPE VBAK-AUDAT,
         BSTNK      TYPE VBAK-BSTNK,
         BSTDK      TYPE VBAK-BSTDK,
         VTEXT      TYPE CHAR200,
         REC_TXT    TYPE CHAR70,     "Reconcilation Account text
         DEBIT1000  LIKE BSID-DMBTR,
         CREDIT1000 LIKE BSID-DMBTR,
         NETB1000   LIKE BSID-DMBTR,
         EMAIL      TYPE ADR6-SMTP_ADDR,
         STREET     TYPE ADRC-STREET,
         ADDRESS    TYPE CHAR100,
         BKTXT      TYPE BKPF-BKTXT,
         REF        TYPE BKPF-XBLNR,
         SKNTO      TYPE PRCD_ELEMENTS-KWERT,
         FI_DESC    TYPE CHAR100,
         SALE_OFF   TYPE KNA1-KUNNR,
         PRCTR      TYPE BSEG-PRCTR,
         PLANT      TYPE WERKS,


       END OF IDATA.

DATA: RP01(3) TYPE N,                                     "   0
      RP02(3) TYPE N,                                     "  20
      RP03(3) TYPE N,                                     "  40
      RP04(3) TYPE N,                                     "  80
      RP05(3) TYPE N,                                     " 100
      RP06(3) TYPE N,                                     "   1
      RP07(3) TYPE N,                                     "  21
      RP08(3) TYPE N,                                     "  41
      RP09(3) TYPE N,                                     "  81
      RP10(3) TYPE N,                                     " 101
      RP11(3) TYPE N,                                     " 101
      RP12(3) TYPE N,                                     " 101
      RP13(3) TYPE N,                                     " 101
      RP14(3) TYPE N.                                     " 101

DATA: RC01(14) TYPE C,                                     "  0
      RC02(14) TYPE C,                                    "  20
      RC03(14) TYPE C,                                    "  40
      RC04(14) TYPE C,                                    "  80
      RC05(14) TYPE C,                                    " 100
      RC06(14) TYPE C,                                    "   1
      RC07(14) TYPE C,                                    "  21
      RC08(14) TYPE C,                                    "  41
      RC09(14) TYPE C,                                    "  81
      RC10(14) TYPE C,                                    " 101
      RC11(14) TYPE C,                                    " 101
      RC12(14) TYPE C,                                    " 101
      RC13(14) TYPE C,                                    " 101
      RC14(20) TYPE C,                                    " 101
      RC15(20) TYPE C,                                    " 101
      RC16(20) TYPE C,                                    " 101
      RC17(20) TYPE C,                                    " 101
      RC18(30) TYPE C,                                    " 101
      RC19(30) TYPE C,                                    " 101
      RC20(30) TYPE C,                                    " 101
      RC21(30) TYPE C,                                    " 101
      RC22(30) TYPE C,                                    " 101
      RC23(30) TYPE C.                                    " 101

DATA: ITAB  TYPE IDATA OCCURS 0 WITH HEADER LINE.

******************SELECTION SCREEN

SELECTION-SCREEN BEGIN OF BLOCK A1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: PLANT LIKE BSID-BUKRS OBLIGATORY DEFAULT 'US00'.
  SELECT-OPTIONS: KUNNR FOR TMP_KUNNR.
*                akont FOR knb1-akont.
  PARAMETERS: DATE  LIKE BSID-BUDAT DEFAULT SY-DATUM OBLIGATORY.                "no-extension obligatory.
  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 01(30) TEXT-026 FOR FIELD RASTBIS1.

    SELECTION-SCREEN POSITION POS_LOW.

    PARAMETERS: RASTBIS1 LIKE RFPDO1-ALLGROGR DEFAULT '000'.
    PARAMETERS: RASTBIS2 LIKE RFPDO1-ALLGROGR DEFAULT '030'.
    PARAMETERS: RASTBIS3 LIKE RFPDO1-ALLGROGR DEFAULT '060'.
    PARAMETERS: RASTBIS4 LIKE RFPDO1-ALLGROGR DEFAULT '090'.
    PARAMETERS: RASTBIS5 LIKE RFPDO1-ALLGROGR DEFAULT '180'.
    PARAMETERS: RASTBIS6 LIKE RFPDO1-ALLGROGR DEFAULT '360'.
    PARAMETERS: RASTBIS7 LIKE RFPDO1-ALLGROGR DEFAULT '720'.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK A1.

SELECTION-SCREEN: BEGIN OF BLOCK B1 WITH FRAME.
  PARAMETERS: R1 RADIOBUTTON GROUP ABC DEFAULT 'X',
              R2 RADIOBUTTON GROUP ABC.
SELECTION-SCREEN: END OF BLOCK B1.
***********************Initialization.

INITIALIZATION.

**************************************************
AT SELECTION-SCREEN.

  IF RASTBIS1 GT '998'
  OR RASTBIS2 GT '998'
  OR RASTBIS3 GT '998'
  OR RASTBIS4 GT '998'
  OR RASTBIS5 GT '998'
  OR RASTBIS6 GT '998'
  OR RASTBIS7 GT '998'.

    SET CURSOR FIELD RASTBIS7.
    MESSAGE 'Enter a consistent sorted list' TYPE 'E'.      "e381.
  ENDIF.
  IF NOT RASTBIS7 IS INITIAL.
    IF  RASTBIS7 GT RASTBIS6
    AND RASTBIS6 GT RASTBIS5
    AND RASTBIS5 GT RASTBIS4
    AND RASTBIS4 GT RASTBIS3
    AND RASTBIS3 GT RASTBIS2
    AND RASTBIS2 GT RASTBIS1.
    ELSE.
      MESSAGE 'Enter a maximum of 998 days in the sorted list upper limits' TYPE 'E'.
    ENDIF.
  ELSE.
    IF NOT RASTBIS6 IS INITIAL.
      IF  RASTBIS6 GT RASTBIS5
      AND RASTBIS5 GT RASTBIS4
      AND RASTBIS4 GT RASTBIS3
      AND RASTBIS3 GT RASTBIS2
      AND RASTBIS2 GT RASTBIS1.
      ELSE.
        MESSAGE 'Enter a maximum of 998 days in the sorted list upper limits' TYPE 'E'.
      ENDIF.
    ELSE.
      IF NOT RASTBIS5 IS INITIAL.
        IF  RASTBIS5 GT RASTBIS4
        AND RASTBIS4 GT RASTBIS3
        AND RASTBIS3 GT RASTBIS2
        AND RASTBIS2 GT RASTBIS1.
        ELSE.
          MESSAGE 'Enter a maximum of 998 days in the sorted list upper limits' TYPE 'E'.
        ENDIF.
      ELSE.
        IF NOT RASTBIS4 IS INITIAL.
          IF  RASTBIS4 GT RASTBIS3
          AND RASTBIS3 GT RASTBIS2
          AND RASTBIS2 GT RASTBIS1.
          ELSE.
            MESSAGE 'Enter a maximum of 998 days in the sorted list upper limits' TYPE 'E'.
          ENDIF.
        ELSE.
          IF NOT RASTBIS3 IS INITIAL.
            IF  RASTBIS3 GT RASTBIS2
            AND RASTBIS2 GT RASTBIS1.
            ELSE.
              MESSAGE 'Enter a maximum of 998 days in the sorted list upper limits' TYPE 'E'.
            ENDIF.
          ELSE.
            IF NOT RASTBIS2 IS INITIAL.
              IF  RASTBIS2 GT RASTBIS1.
              ELSE.
                MESSAGE 'Enter a maximum of 998 days in the sorted list upper limits' TYPE 'E'.
              ENDIF.
            ELSE.
*         nichts zu tun
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.


  RP01 = RASTBIS1.
  RP02 = RASTBIS2.
  RP03 = RASTBIS3.
  RP04 = RASTBIS4.
  RP05 = RASTBIS5.
  RP06 = RASTBIS6.
  RP07 = RASTBIS7.

  RP08 = RP01 + 1.
  IF NOT RP02 IS INITIAL.
    RP09 = RP02 + 1.
  ELSE.
    RP09 = ''.
  ENDIF.
  IF NOT RP03 IS INITIAL.
    RP10 = RP03 + 1.
  ELSE.
    RP10 = ''.
  ENDIF.
  IF NOT RP04 IS INITIAL.
    RP11 = RP04 + 1.
  ELSE.
    RP11 = ''.
  ENDIF.
  IF NOT RP05 IS INITIAL.
    RP12 = RP05 + 1.
  ELSE.
    RP12 = ''.
  ENDIF.
  IF NOT RP06 IS INITIAL.
    RP13 = RP06 + 1.
  ELSE.
    RP13 = ''.
  ENDIF.
  IF NOT RP07 IS INITIAL.
    RP14 = RP07 + 1.
  ELSE.
    RP14 = ''.
  ENDIF.

  IF NOT RP01 IS INITIAL.
    CONCATENATE 'Upto'    RP01 'Dr' INTO RC01 SEPARATED BY SPACE.
    CONCATENATE 'Upto'    RP01 'Cr' INTO RC08 SEPARATED BY SPACE.
    CONCATENATE '000 to'  RP01 'Days' INTO RC17 SEPARATED BY SPACE.
  ELSE.
    CONCATENATE 'Upto'    RP01 'Dr' INTO RC01 SEPARATED BY SPACE.
    CONCATENATE 'Upto'    RP01 'Cr' INTO RC08 SEPARATED BY SPACE.
    CONCATENATE RP01 'Days' INTO RC17 SEPARATED BY SPACE.
  ENDIF.


  IF NOT RP02 IS INITIAL.
    CONCATENATE RP08 'To' RP02 'Dr' INTO RC02 SEPARATED BY SPACE.
    CONCATENATE RP08 'To' RP02 'Cr' INTO RC09 SEPARATED BY SPACE.
    CONCATENATE RP08 'To' RP02 'Days' INTO RC18 SEPARATED BY SPACE.
  ELSEIF RP03 IS INITIAL.
    CONCATENATE RP08 '& Above' 'Dr' INTO RC02 SEPARATED BY SPACE.
    CONCATENATE RP08 '& Above' 'Cr' INTO RC09 SEPARATED BY SPACE.
    CONCATENATE RP08 'Days' INTO RC18 SEPARATED BY SPACE.
  ENDIF.

  IF NOT RP03 IS INITIAL.
    CONCATENATE RP09 'To' RP03 'Dr' INTO RC03 SEPARATED BY SPACE.
    CONCATENATE RP09 'To' RP03 'Cr' INTO RC10 SEPARATED BY SPACE.
    CONCATENATE RP09 'To' RP03 'Days' INTO RC19 SEPARATED BY SPACE.
  ELSEIF RP02 IS INITIAL.
    RC03 = ''.
    RC08 = ''.
    RC15 = ''.
  ELSEIF RP04 IS INITIAL.
    CONCATENATE RP09 '& Above' 'Dr' INTO RC03 SEPARATED BY SPACE.
    CONCATENATE RP09 '& Above' 'Cr' INTO RC10 SEPARATED BY SPACE.
    CONCATENATE RP09 'Days' INTO RC19 SEPARATED BY SPACE.
  ENDIF.

  IF NOT RP04 IS INITIAL .
    CONCATENATE RP10 'To' RP04 'Dr' INTO RC04 SEPARATED BY SPACE.
    CONCATENATE RP10 'To' RP04 'Cr' INTO RC11 SEPARATED BY SPACE.
    CONCATENATE RP10 'To' RP04 'Days' INTO RC20 SEPARATED BY SPACE.
  ELSEIF RP03 IS INITIAL.
    RC04 = ''.
    RC09 = ''.
    RC16 = ''.
  ELSEIF RP05 IS INITIAL.
    CONCATENATE RP10 '& Above' 'Dr' INTO RC04 SEPARATED BY SPACE.
    CONCATENATE RP10 '& Above' 'Cr' INTO RC11 SEPARATED BY SPACE.
*    CONCATENATE rp08 '& Above' 'Net Bal' INTO rc16 SEPARATED BY space.
    CONCATENATE RP10 'Days' INTO RC20 SEPARATED BY SPACE.
  ENDIF.

  IF NOT RP05 IS INITIAL.
    CONCATENATE RP11 'To' RP05 'Dr' INTO RC05 SEPARATED BY SPACE.
    CONCATENATE RP11 'To' RP05 'Cr' INTO RC12 SEPARATED BY SPACE.
*    CONCATENATE rp09 'To' rp05 'Net Bal' INTO rc17 SEPARATED BY space.
    CONCATENATE RP11 'To' RP05 'Days' INTO RC21 SEPARATED BY SPACE.
  ELSEIF RP04 IS INITIAL.
    RC05 = ''.
    RC10 = ''.
    RC17 = ''.
  ELSE.
    CONCATENATE RP11 '& Above' 'Dr' INTO RC05 SEPARATED BY SPACE.
    CONCATENATE RP11 '& Above' 'Cr' INTO RC12 SEPARATED BY SPACE.
    CONCATENATE RP11 'Days' INTO RC21 SEPARATED BY SPACE.
  ENDIF.


  IF NOT RP06 IS INITIAL.
    CONCATENATE RP12 'To' RP06 'Dr' INTO RC06 SEPARATED BY SPACE.
    CONCATENATE RP12 'To' RP06 'Cr' INTO RC13 SEPARATED BY SPACE.
*    CONCATENATE rp09 'To' rp05 'Net Bal' INTO rc17 SEPARATED BY space.
    CONCATENATE RP12 'To' RP06 'Days' INTO RC22 SEPARATED BY SPACE.
  ELSEIF RP05 IS INITIAL.
    RC05 = ''.
    RC10 = ''.
    RC17 = ''.
  ELSE.
    CONCATENATE RP12 '& Above' 'Dr' INTO RC06 SEPARATED BY SPACE.
    CONCATENATE RP12 '& Above' 'Cr' INTO RC13 SEPARATED BY SPACE.
    CONCATENATE RP12 'Days' INTO RC22 SEPARATED BY SPACE.
  ENDIF.


  IF NOT RP07 IS INITIAL.
    CONCATENATE RP13 'To' RP07 'Dr' INTO RC07 SEPARATED BY SPACE.
    CONCATENATE RP13 'To' RP07 'Cr' INTO RC14 SEPARATED BY SPACE.
*    CONCATENATE rp09 'To' rp05 'Net Bal' INTO rc17 SEPARATED BY space.
    CONCATENATE RP13 'To' RP07 'Days' INTO RC23 SEPARATED BY SPACE.
  ELSEIF RP06 IS INITIAL.
    RC05 = ''.
    RC10 = ''.
    RC17 = ''.
  ELSE.
    CONCATENATE RP13 '& Above' 'Dr' INTO RC07 SEPARATED BY SPACE.
    CONCATENATE RP13 '& Above' 'Cr' INTO RC14 SEPARATED BY SPACE.
    CONCATENATE RP13 'Days' INTO RC23 SEPARATED BY SPACE.
  ENDIF.

  IF NOT RP14 IS INITIAL.
    CONCATENATE RP14 '& Above' 'Dr' INTO RC15 SEPARATED BY SPACE.
    CONCATENATE RP14 '& Above' 'Cr' INTO RC16 SEPARATED BY SPACE.
    CONCATENATE RP14 'Days and Above' INTO RC14 SEPARATED BY SPACE.
  ENDIF.
*******************************************

START-OF-SELECTION.

  PERFORM DATALIST_BSID.

  PERFORM FILL_FIELDCATALOG.
  PERFORM SORT_LIST.
  PERFORM FILL_LAYOUT.
  PERFORM LIST_DISPLAY.

END-OF-SELECTION.

*&---------------------------------------------------------------------*
*&      Form  datalist_bsid
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM DATALIST_BSID .
  DATA:
    LS_FAEDE_I TYPE FAEDE,
    LS_FAEDE_E TYPE FAEDE,
    LV_INDEX   TYPE SY-TABIX,
    LV_KTOPL   TYPE T001-KTOPL.

  DATA:
    LT_KNVV  TYPE TT_KNVV,
    LS_KNVV  TYPE T_KNVV,
    LT_TVKBT TYPE TT_TVKBT,
    LS_TVKBT TYPE T_TVKBT,
    LT_VBRK  TYPE TT_VBRK,
    LS_VBRK  TYPE T_VBRK,
    LT_VBRP  TYPE TT_VBRP,
    LS_VBRP  TYPE T_VBRP,
    LT_VBAK  TYPE TT_VBAK,
    LS_VBAK  TYPE T_VBAK,
    LT_TVZBT TYPE TT_TVZBT,
    LS_TVZBT TYPE T_TVZBT,
    LT_SKAT  TYPE TT_SKAT,
    LS_SKAT  TYPE T_SKAT,
    LT_DATA  TYPE STANDARD TABLE OF IDATA,
    LS_DATA  TYPE IDATA.

  SELECT BSID~BUKRS
         BSID~KUNNR
         AUGBL
         AUGGJ
         AUGDT
         GJAHR
         BELNR
         BUZEI
         BUDAT
         BLDAT
         WAERS
         SHKZG
         DMBTR
         WRBTR
         REBZG
         REBZJ
         REBZZ
         UMSKZ
         BSID~ZTERM
         ZBD1T
         XBLNR
         BLART
*     kna1~name1
*     kna1~ktokd
    KNB1~AKONT
    BSID~ZFBDT
    BSID~ZBD1T
    BSID~ZBD2T
    BSID~ZBD3T
    BSID~VBELN
  INTO CORRESPONDING FIELDS OF TABLE ITAB
                             FROM BSID INNER JOIN KNB1 ON BSID~KUNNR = KNB1~KUNNR AND KNB1~BUKRS = BSID~BUKRS
                             WHERE BSID~BUKRS = PLANT
                             AND   BSID~KUNNR IN KUNNR
                             AND   UMSKZ <> 'F'
                             AND   BUDAT <= DATE.
*                             AND   knb1~akont IN akont .
*                             AND   kna1~ktokd IN ktokd.

  SELECT BSAD~BUKRS
         BSAD~KUNNR
         AUGBL
         AUGGJ
         AUGDT
         GJAHR
         BELNR
         BUZEI
         BUDAT
         BLDAT
         WAERS
         SHKZG
         DMBTR
         WRBTR
         REBZG
         REBZJ
         REBZZ
         UMSKZ
         BSAD~ZTERM
         ZBD1T
         BLART
         XBLNR
    KNB1~AKONT
    BSAD~ZFBDT
    BSAD~ZBD1T
    BSAD~ZBD2T
    BSAD~ZBD3T
    BSAD~VBELN
APPENDING CORRESPONDING FIELDS OF TABLE ITAB
                             FROM BSAD INNER JOIN KNB1 ON KNB1~KUNNR = BSAD~KUNNR AND KNB1~BUKRS = BSAD~BUKRS
                             WHERE BSAD~BUKRS = PLANT
                             AND   BSAD~KUNNR IN KUNNR
                             AND   UMSKZ <> 'F'
*                             AND   budat <= date
                             AND   AUGDT >  DATE.
*                             AND  augdt = ' '
*                             AND   knb1~akont IN akont.

  DELETE ITAB WHERE BUDAT > DATE.

  LT_DATA[] = ITAB[].

  DELETE ITAB[] WHERE REBZG IS NOT INITIAL AND REBZG NE 'V' .
*  DELETE lt_data WHERE bldat EQ 'DR'.

  IF NOT ITAB[] IS INITIAL.
    SELECT BUKRS
           BELNR
           BLART
           XBLNR
           BKTXT FROM BKPF INTO TABLE IT_BKPF
           FOR ALL ENTRIES IN ITAB
           WHERE BUKRS = ITAB-BUKRS
             AND BELNR = ITAB-BELNR
             AND BLART = 'UE'.




    SELECT SINGLE KTOPL
                FROM  T001
                INTO  LV_KTOPL
                WHERE BUKRS = PLANT.

    SELECT KUNNR
           VKBUR
      FROM KNVV
      INTO TABLE LT_KNVV
      FOR ALL ENTRIES IN ITAB
      WHERE KUNNR = ITAB-KUNNR.

    SELECT KUNNR
           NAME1
           ADRNR FROM KNA1 INTO TABLE IT_KNA1
           FOR ALL ENTRIES IN ITAB
           WHERE KUNNR = ITAB-KUNNR.

    IF IT_KNA1 IS NOT INITIAL.
      SELECT ADDRNUMBER
             SMTP_ADDR FROM ADR6 INTO TABLE IT_ADR6
             FOR ALL ENTRIES IN IT_KNA1
             WHERE ADDRNUMBER = IT_KNA1-ADRNR.

      SELECT ADDRNUMBER
             STREET
             HOUSE_NUM1
             POST_CODE1
             CITY1
             CITY2
             COUNTRY
             REGION     FROM ADRC INTO TABLE IT_ADRC
             FOR ALL ENTRIES IN IT_KNA1
             WHERE ADDRNUMBER = IT_KNA1-ADRNR.



    ENDIF.



    IF SY-SUBRC IS INITIAL.
      SELECT VKBUR
             BEZEI
        FROM TVKBT
        INTO TABLE LT_TVKBT
        FOR ALL ENTRIES IN LT_KNVV
        WHERE VKBUR = LT_KNVV-VKBUR
        AND   SPRAS = SY-LANGU.
    ENDIF.

    SELECT VBELN
           KNUMV
           FKDAT
      FROM VBRK
      INTO TABLE LT_VBRK
      FOR ALL ENTRIES IN ITAB
      WHERE VBELN = ITAB-VBELN.

    SELECT VBELN
           POSNR
           AUBEL
      FROM VBRP
      INTO TABLE LT_VBRP
      FOR ALL ENTRIES IN ITAB
      WHERE VBELN = ITAB-VBELN.

    IF SY-SUBRC IS INITIAL.
      SELECT VBELN
             AUDAT
             BSTNK
             BSTDK
        FROM VBAK
        INTO TABLE LT_VBAK
        FOR ALL ENTRIES IN LT_VBRP
        WHERE VBELN = LT_VBRP-AUBEL.
    ENDIF.

    SELECT ZTERM
           VTEXT
      FROM TVZBT
      INTO TABLE LT_TVZBT
      FOR ALL ENTRIES IN ITAB
      WHERE ZTERM = ITAB-ZTERM
      AND   SPRAS =  SY-LANGU.

    SELECT SAKNR
           TXT50
      FROM SKAT
      INTO TABLE LT_SKAT
      FOR ALL ENTRIES IN ITAB
      WHERE SAKNR = ITAB-AKONT
      AND   KTOPL = LV_KTOPL
      AND   SPRAS = SY-LANGU.

  ENDIF.

  IF  LT_VBRK IS NOT INITIAL.
    SELECT BUKRS
           VBELN
           SKFBT
           SKNTO FROM BSEG INTO TABLE IT_BSEG
           FOR ALL ENTRIES IN LT_VBRK
           WHERE VBELN = LT_VBRK-VBELN.

    SELECT KNUMV
           KPOSN
           KSCHL
           KWERT FROM PRCD_ELEMENTS INTO TABLE IT_KONV
           FOR ALL ENTRIES IN LT_VBRK
           WHERE KNUMV = LT_VBRK-KNUMV
            AND  KSCHL = 'SKTO'.





  ENDIF.
  SORT ITAB[] BY BELNR GJAHR BUZEI.
  SORT LT_DATA[] BY REBZG REBZJ REBZZ.

  LOOP AT ITAB .

    READ TABLE LT_DATA INTO LS_DATA WITH KEY REBZG = ITAB-BELNR
                                             REBZJ = ITAB-GJAHR
                                             REBZZ = ITAB-BUZEI.
    IF SY-SUBRC IS INITIAL.
      LV_INDEX = SY-TABIX.
      LOOP AT LT_DATA INTO LS_DATA FROM LV_INDEX.
        IF LS_DATA-REBZG = ITAB-BELNR AND LS_DATA-REBZJ = ITAB-GJAHR AND LS_DATA-REBZZ = ITAB-BUZEI.
          IF LS_DATA-SHKZG = 'S'.
            ITAB-CREDIT = ITAB-CREDIT - LS_DATA-DMBTR. "total rec/cre memo amt logic
            ITAB-DEBIT = ITAB-DEBIT - LS_DATA-DMBTR. "transfer total inv amt
          ELSE.
            ITAB-CREDIT = ITAB-CREDIT + LS_DATA-DMBTR."total rec/cre memo amt logic
            ITAB-DEBIT = ITAB-DEBIT + LS_DATA-DMBTR.   "transfer total inv amt
          ENDIF.

        ELSE.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.
    MODIFY ITAB TRANSPORTING DEBIT CREDIT.
*    MODIFY itab TRANSPORTING credit.
  ENDLOOP.

  LOOP AT ITAB.


    IF ITAB-BLART = 'DR'.
      ITAB-FI_DESC = 'FI Invoice'.
    ELSEIF ITAB-BLART = 'DG'.
      ITAB-FI_DESC = 'Credit Memo'.
    ELSEIF ITAB-BLART = 'RV'.
      ITAB-FI_DESC = 'Sales Invoice'.
    ELSEIF ITAB-BLART = 'UE'.
      ITAB-FI_DESC = 'Initial Upload Invoice'.
    ELSEIF ITAB-BLART = 'DZ'.
      ITAB-FI_DESC = 'Payment'.
    ELSEIF ITAB-BLART = 'SA'.
      ITAB-FI_DESC = 'Invoice'.
    ENDIF.


*    SELECT SINGLE name1 INTO itab-name1 FROM kna1 WHERE kunnr = itab-kunnr.
    READ TABLE IT_BKPF INTO WA_BKPF WITH KEY BELNR = ITAB-BELNR BUKRS = ITAB-BUKRS.
    IF SY-SUBRC = 0.
      ITAB-BKTXT = WA_BKPF-BKTXT.
      ITAB-REF   = WA_BKPF-XBLNR.

    ENDIF.
    READ TABLE IT_KNA1 INTO WA_KNA1 WITH KEY KUNNR = ITAB-KUNNR.
    IF SY-SUBRC = 0.
      ITAB-NAME1 = WA_KNA1-NAME1.
      ITAB-NAME2 = WA_KNA1-NAME1.

    ENDIF.

    READ TABLE IT_ADR6 INTO WA_ADR6 WITH KEY ADDRNUMBER = WA_KNA1-ADRNR.
    IF SY-SUBRC = 0.
      ITAB-EMAIL = WA_ADR6-SMTP_ADDR.

    ENDIF.

    READ TABLE IT_ADRC INTO WA_ADRC WITH KEY ADDRNUMBER = WA_KNA1-ADRNR.
    IF SY-SUBRC = 0.
      ITAB-STREET     = WA_ADRC-STREET    .

      CONCATENATE WA_ADRC-CITY1 WA_ADRC-REGION WA_ADRC-POST_CODE1 INTO ITAB-ADDRESS SEPARATED BY ','.


    ENDIF.



***********Calculating DEBIT and CREDIT
    IF ITAB-SHKZG  = 'S'.
      ITAB-DEBIT  = ITAB-DMBTR - ITAB-DEBIT.
      ITAB-DEBIT  = ITAB-DEBIT + ITAB-CREDIT.
    ELSE.
*      itab-credit = itab-credit + itab-dmbtr. "total rec/cre memo amt logic
      ITAB-DEBIT =  ITAB-DMBTR + ITAB-DEBIT .    "transfer total inv amt
      ITAB-DEBIT  = ITAB-DEBIT - ITAB-CREDIT.

    ENDIF.



    IF ITAB-SHKZG  = 'S'.
      ITAB-DEBIT  = ITAB-DEBIT.
    ELSE.
      ITAB-DEBIT = ITAB-DEBIT * -1.
    ENDIF.

*    itab-debit        = abs( itab-debit ).
*      IF itab-debit < 0.
**        CONDENSE itab-debit.
*        CONCATENATE '-' itab-debit INTO itab-debit.
*      ENDIF.

*    IF itab-blart = 'DG'.
*      itab-debit = itab-debit * -1.
*    ENDIF.

    IF ITAB-UMSKZ  = ''.
      ITAB-GROUP  = 'Normal'.
    ELSE.
      ITAB-GROUP  = 'Special G/L'.
    ENDIF.


*    itab-duedate = itab-bldat. " + itab-zbd1t.

    LS_FAEDE_I-KOART = 'D'.
    LS_FAEDE_I-ZFBDT = ITAB-ZFBDT.
    LS_FAEDE_I-ZBD1T = ITAB-ZBD1T.
    LS_FAEDE_I-ZBD2T = ITAB-ZBD2T.
    LS_FAEDE_I-ZBD3T = ITAB-ZBD3T.

    CALL FUNCTION 'DETERMINE_DUE_DATE'
      EXPORTING
        I_FAEDE                    = LS_FAEDE_I
*       I_GL_FAEDE                 =
      IMPORTING
        E_FAEDE                    = LS_FAEDE_E
      EXCEPTIONS
        ACCOUNT_TYPE_NOT_SUPPORTED = 1
        OTHERS                     = 2.
    IF SY-SUBRC <> 0.
* Implement suitable error handling here
    ENDIF.

    ITAB-DUEDATE = LS_FAEDE_E-NETDT.
    IF R1 = 'X'.
      IF ITAB-BLDAT = DATE.
        ITAB-DAY  = 0.
      ELSE."if itab-bldat < date.
        ITAB-DAY     = DATE - ITAB-BLDAT.

      ENDIF.
    ELSE.
      IF ITAB-DUEDATE = DATE.
        ITAB-DAY  = 0.
      ELSEIF ITAB-DUEDATE IS NOT INITIAL.
        ITAB-DAY     = DATE - ITAB-DUEDATE.
      ENDIF.
    ENDIF.
***********Net Balance
    ITAB-NETBAL = ITAB-DEBIT - ITAB-CREDIT.

    IF ITAB-DAY < 0.
      ITAB-NOT_DUE_DB = ITAB-DEBIT.
      ITAB-NOT_DUE_CR = ITAB-CREDIT.
      ITAB-NOT_DUE    = ITAB-NOT_DUE_DB - ITAB-NOT_DUE_CR.
    ELSEIF ITAB-DAY <= RASTBIS1.
      ITAB-DEBIT30  = ITAB-DEBIT.
      ITAB-CREDIT30 = ITAB-CREDIT.
      ITAB-NETB30 = ITAB-DEBIT30 - ITAB-CREDIT30.
    ELSEIF RASTBIS2 IS INITIAL.
      ITAB-DEBIT60  = ITAB-DEBIT.
      ITAB-CREDIT60 = ITAB-CREDIT.
      ITAB-NETB60   = ITAB-DEBIT60 - ITAB-CREDIT60.
    ELSE.
      IF ITAB-DAY > RASTBIS1 AND ITAB-DAY <= RASTBIS2.
        ITAB-DEBIT60  = ITAB-DEBIT.
        ITAB-CREDIT60 = ITAB-CREDIT.
        ITAB-NETB60   = ITAB-DEBIT60 - ITAB-CREDIT60.
      ELSEIF RASTBIS3 IS INITIAL.
        ITAB-DEBIT90  = ITAB-DEBIT.
        ITAB-CREDIT90 = ITAB-CREDIT.
        ITAB-NETB90   = ITAB-DEBIT90 - ITAB-CREDIT90.
      ELSE.
        IF ITAB-DAY > RASTBIS2 AND ITAB-DAY <= RASTBIS3.
          ITAB-DEBIT90  = ITAB-DEBIT.
          ITAB-CREDIT90 = ITAB-CREDIT.
          ITAB-NETB90   = ITAB-DEBIT90 - ITAB-CREDIT90.
        ELSEIF RASTBIS4 IS INITIAL.
          ITAB-DEBIT120  = ITAB-DEBIT.
          ITAB-CREDIT120 = ITAB-CREDIT.
          ITAB-NETB120   = ITAB-DEBIT120 - ITAB-CREDIT120.
        ELSE.
          IF ITAB-DAY > RASTBIS3 AND ITAB-DAY <= RASTBIS4.
            ITAB-DEBIT120  = ITAB-DEBIT.
            ITAB-CREDIT120 = ITAB-CREDIT.
            ITAB-NETB120   = ITAB-DEBIT120 - ITAB-CREDIT120.
          ELSEIF RASTBIS5 IS INITIAL.
            ITAB-DEBIT180  = ITAB-DEBIT.
            ITAB-CREDIT180 = ITAB-CREDIT.
            ITAB-NETB180   = ITAB-DEBIT180 - ITAB-CREDIT180.
          ELSE.
            IF ITAB-DAY > RASTBIS4 AND ITAB-DAY <= RASTBIS5.
              ITAB-DEBIT180  = ITAB-DEBIT.
              ITAB-CREDIT180 = ITAB-CREDIT.
              ITAB-NETB180   = ITAB-DEBIT180 - ITAB-CREDIT180.
            ELSEIF RASTBIS6 IS INITIAL.
              ITAB-DEBIT360  = ITAB-DEBIT.
              ITAB-CREDIT360 = ITAB-CREDIT.
              ITAB-NETB360   = ITAB-DEBIT360 - ITAB-CREDIT360.
            ELSE.
              IF ITAB-DAY > RASTBIS5 AND ITAB-DAY <= RASTBIS6.
                ITAB-DEBIT360  = ITAB-DEBIT.
                ITAB-CREDIT360 = ITAB-CREDIT.
                ITAB-NETB360   = ITAB-DEBIT360 - ITAB-CREDIT360.
              ELSEIF RASTBIS6 IS INITIAL.
                ITAB-DEBIT720  = ITAB-DEBIT.
                ITAB-CREDIT720 = ITAB-CREDIT.
                ITAB-NETB720   = ITAB-DEBIT720 - ITAB-CREDIT720.

              ELSE.
                IF ITAB-DAY > RASTBIS6 AND ITAB-DAY <= RASTBIS7.
                  ITAB-DEBIT720  = ITAB-DEBIT.
                  ITAB-CREDIT720 = ITAB-CREDIT.
                  ITAB-NETB720   = ITAB-DEBIT720 - ITAB-CREDIT720.
                ELSEIF RASTBIS7 IS INITIAL.
                  ITAB-DEBIT1000  = ITAB-DEBIT.
                  ITAB-CREDIT1000 = ITAB-CREDIT.
                  ITAB-NETB1000   = ITAB-DEBIT1000 - ITAB-CREDIT1000.

                ELSE.
                  IF ITAB-DAY > RASTBIS7.
                    ITAB-DEBIT1000  = ITAB-DEBIT.
                    ITAB-CREDIT1000 = ITAB-CREDIT.
                    ITAB-NETB1000   = ITAB-DEBIT1000 - ITAB-CREDIT1000.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.

    ENDIF.

    CONCATENATE ITAB-KUNNR ITAB-NAME1 INTO ITAB-TDISP SEPARATED BY SPACE."itab-umskz
    SHIFT ITAB-XBLNR LEFT DELETING LEADING '0'.

    IF ITAB-VBELN IS INITIAL.
      ITAB-VBELN = ITAB-XBLNR.
    ENDIF.


    READ TABLE LT_KNVV INTO LS_KNVV WITH KEY KUNNR = ITAB-KUNNR.
    IF SY-SUBRC IS INITIAL.
      ITAB-SALE_OFF = LS_KNVV-VKBUR.
      READ TABLE LT_TVKBT INTO LS_TVKBT WITH KEY VKBUR = LS_KNVV-VKBUR.
      IF SY-SUBRC IS INITIAL.
        ITAB-BEZEI = LS_TVKBT.
      ENDIF.
    ENDIF.

    READ TABLE LT_VBRK INTO LS_VBRK WITH KEY VBELN = ITAB-VBELN.
    IF SY-SUBRC IS INITIAL.
      ITAB-FKDAT = LS_VBRK-FKDAT.
    ENDIF.



    SELECT SINGLE PRCTR INTO ITAB-PRCTR FROM BSEG WHERE BELNR = ITAB-BELNR AND PRCTR NE ' '.
    ITAB-PLANT = ITAB-PRCTR+2(4).
*    READ TABLE it_bseg INTO wa_bseg WITH KEY vbeln = itab-vbeln..
*    IF sy-subrc = 0.
*      itab-sknto = wa_bseg-sknto.
*
*    ENDIF.

    READ TABLE LT_VBRP INTO LS_VBRP WITH KEY VBELN = ITAB-VBELN.
    IF SY-SUBRC IS INITIAL.
      READ TABLE LT_VBAK INTO LS_VBAK WITH KEY VBELN = LS_VBRP-AUBEL.
      IF SY-SUBRC IS INITIAL.
        ITAB-AUBEL = LS_VBAK-VBELN.
        ITAB-AUDAT = LS_VBAK-AUDAT.
        ITAB-BSTNK = LS_VBAK-BSTNK.
        ITAB-BSTDK = LS_VBAK-BSTDK.
      ENDIF.
    ENDIF.
    IF ITAB-BLART NE 'DG'.

      LOOP AT IT_KONV INTO WA_KONV WHERE KNUMV = LS_VBRK-KNUMV." AND kposn = ls_vbrp-posnr.
        IF SY-SUBRC = 0.

          ITAB-SKNTO = ITAB-SKNTO + WA_KONV-KWERT.

        ENDIF.


      ENDLOOP.



    ENDIF.




    READ TABLE LT_TVZBT INTO LS_TVZBT WITH KEY ZTERM = ITAB-ZTERM.
    IF SY-SUBRC IS INITIAL.
      CONCATENATE LS_TVZBT-ZTERM LS_TVZBT-VTEXT INTO ITAB-VTEXT SEPARATED BY SPACE.
    ENDIF.
    IF ITAB-WAERS = 'INR'.
      IF NOT ITAB-DEBIT IS INITIAL.
        ITAB-CURR = ITAB-DMBTR.
      ELSEIF NOT ITAB-CREDIT IS INITIAL.
        ITAB-CURR = ITAB-DMBTR * -1.
      ENDIF.
    ELSE.

      IF NOT ITAB-DEBIT IS INITIAL.
        ITAB-CURR = ITAB-WRBTR.
      ELSEIF NOT ITAB-CREDIT IS INITIAL.
        ITAB-CURR = ITAB-WRBTR * -1.
      ENDIF.
    ENDIF.

    READ TABLE LT_SKAT INTO LS_SKAT WITH KEY SAKNR = ITAB-AKONT.
    IF SY-SUBRC IS INITIAL.
      CONCATENATE ITAB-AKONT LS_SKAT-TXT50 INTO ITAB-REC_TXT SEPARATED BY SPACE.
    ELSE.
      ITAB-REC_TXT = ITAB-AKONT.
    ENDIF.
    SHIFT ITAB-REC_TXT LEFT DELETING LEADING '0'.
    MODIFY ITAB.

  ENDLOOP.
  CLEAR:WA_BSEG.


ENDFORM.                    " DATALIST_Bsak


*&---------------------------------------------------------------------*
*&      Form  fill_fieldcatalog
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM FILL_FIELDCATALOG.

  PERFORM F_FIELDCATALOG USING '1'   'GROUP'     'GL Type'.
*  PERFORM f_fieldcatalog USING '2'   'BEZEI'     'Sales Office'.
  PERFORM F_FIELDCATALOG USING '2'   'SALE_OFF'     'Sales Office'.
  PERFORM F_FIELDCATALOG USING '3'   'KUNNR'     'Customer Code'.
  PERFORM F_FIELDCATALOG USING '4'   'NAME1'     'Customer Name'.
  PERFORM F_FIELDCATALOG USING '5'   'NAME2'     'Bill to Name'.
  PERFORM F_FIELDCATALOG USING '6'   'STREET'    'Address'.
  PERFORM F_FIELDCATALOG USING '7'   'ADDRESS'    'City ST ZIP'.
  PERFORM F_FIELDCATALOG USING '8'   'REF'        'Reference No.'.
  PERFORM F_FIELDCATALOG USING '9'   'BKTXT'      'Order No.'.
  PERFORM F_FIELDCATALOG USING '10'   'BLDAT'     'Document Date'.
  PERFORM F_FIELDCATALOG USING '11'   'BUDAT'     'Posting Date'.
  PERFORM F_FIELDCATALOG USING '12'   'REC_TXT'   'Reconciliation Account'.
  PERFORM F_FIELDCATALOG USING '13'   'DUEDATE'   'Due Date'.
  PERFORM F_FIELDCATALOG USING '14'   'BLART'     'FI Doc Type'.
  PERFORM F_FIELDCATALOG USING '15'   'FI_DESC'   'FI Doc Type Desc'.
  PERFORM F_FIELDCATALOG USING '16'   'BELNR'     'FI Doc No.'.
  PERFORM F_FIELDCATALOG USING '17'   'VBELN'     'Invoice No.'.
*  PERFORM f_fieldcatalog USING '11'  'XBLNR'     'Tax Invoice No.(ODN)'.
*  PERFORM f_fieldcatalog USING '12'  'FKDAT'     'Tax Invoice Date'.
  PERFORM F_FIELDCATALOG USING '18'  'VTEXT'     'Payment Terms'.
  PERFORM F_FIELDCATALOG USING '19'  'AUBEL'     'Sales Order No.'.
  PERFORM F_FIELDCATALOG USING '20'  'AUDAT'     'Sales Order Date'.
  PERFORM F_FIELDCATALOG USING '21'  'BSTNK'     'Customer PO. NO.'.
  PERFORM F_FIELDCATALOG USING '22'  'BSTDK'     'Customer PO. Date'.
  PERFORM F_FIELDCATALOG USING '23'  'CURR'      'Amt Document Currency'.
  PERFORM F_FIELDCATALOG USING '24'  'WAERS'     'Currency Key'.
  PERFORM F_FIELDCATALOG USING '25'  'DEBIT'     'Original Document Amt ' ."'Total Pending DR'.
  PERFORM F_FIELDCATALOG USING '26'  'SKNTO'     'Discount Amt' .
  PERFORM F_FIELDCATALOG USING '27'  'CREDIT'    'Total Rec/Cre Memo Amt' . "'Total Pending CR'.
  PERFORM F_FIELDCATALOG USING '28'  'NETBAL'    'Total Outstanding'. "'Net Pending'.
  PERFORM F_FIELDCATALOG USING '29'  'NOT_DUE'   'Not Due'. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '30'  'NETB30'     RC17. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '31'  'NETB60'     RC18. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '32'  'NETB90'     RC19. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '33'  'NETB120'    RC20. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '34'  'NETB180'    RC21. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '35'  'NETB360'    RC22. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '36'  'NETB720'    RC23. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '37'  'NETB1000'   RC14. "'Net Balance'.
  PERFORM F_FIELDCATALOG USING '38'  'DAY'        'Over Due Days'.
  PERFORM F_FIELDCATALOG USING '39'  'EMAIL'       'Email'.
  PERFORM F_FIELDCATALOG USING '40'  'PRCTR'       'Profit Center'.
  PERFORM F_FIELDCATALOG USING '41'  'PLANT'       'Plant'.

ENDFORM.                    " FILL_FIELDCATALOG

*&---------------------------------------------------------------------*
*&      Form  sort_list
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM SORT_LIST.
  T_SORT-SPOS      = '1'.
  T_SORT-FIELDNAME = 'GROUP'.
  T_SORT-TABNAME   = 'ITAB'.
  T_SORT-UP        = 'X'.
  T_SORT-SUBTOT    = 'X'.
  APPEND T_SORT.

  T_SORT-SPOS      = '2'.
  T_SORT-FIELDNAME = 'KUNNR'.
  T_SORT-TABNAME   = 'ITAB'.
  T_SORT-UP        = 'X'.
  T_SORT-SUBTOT    = 'X'.
  APPEND T_SORT.

  T_SORT-SPOS      = '3'.
  T_SORT-FIELDNAME = 'NAME1'.
  T_SORT-TABNAME   = 'ITAB'.
  T_SORT-UP        = 'X'.
  T_SORT-SUBTOT    = 'X'.
  APPEND T_SORT.

  T_SORT-SPOS      = '4'.
  T_SORT-FIELDNAME = 'BLDAT'.
  T_SORT-TABNAME   = 'ITAB'.
  T_SORT-UP        = 'X'.
  T_SORT-SUBTOT    = ' '.
  APPEND T_SORT.

ENDFORM.                    " sort_list

*&---------------------------------------------------------------------*
*&      Form  fill_layout
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM FILL_LAYOUT.
  FS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.
  FS_LAYOUT-ZEBRA             = 'X'.
  FS_LAYOUT-DETAIL_POPUP      = 'X'.
  FS_LAYOUT-SUBTOTALS_TEXT    = 'DR'.

ENDFORM.                    " fill_layout

*&---------------------------------------------------------------------*
*&      Form  f_fieldcatalog
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->VALUE(X)   text
*      -->VALUE(F1)  text
*      -->VALUE(F2)  text
*----------------------------------------------------------------------*
FORM F_FIELDCATALOG  USING   VALUE(X)
                             VALUE(F1)
                             VALUE(F2).
  T_FIELDCAT-COL_POS      = X.
  T_FIELDCAT-FIELDNAME    = F1.
  T_FIELDCAT-SELTEXT_L    = F2.
*  t_fieldcat-decimals_out = '2'.

  IF F1 = 'DEBIT'    OR F1 = 'CREDIT'    OR F1 = 'DEBIT30'  OR F1 = 'CREDIT30'  OR
     F1 = 'DEBIT60'  OR F1 = 'CREDIT60'  OR F1 = 'DEBIT90'  OR F1 = 'CREDIT90'  OR
     F1 = 'DEBIT120' OR F1 = 'CREDIT120' OR F1 = 'DEBIT180' OR F1 = 'CREDIT180' OR
     F1 = 'DEBIT360' OR F1 = 'CREDIT360' OR F1 = 'NETBAL'   OR F1 = 'NETB30'    OR
     F1 = 'NETB60'   OR F1 = 'NETB90'    OR F1 = 'NETB120'  OR F1 = 'NETB180'   OR
     F1 = 'NETB360'  OR F1 = 'NETB720'   OR F1 = 'NETB1000'   OR F1 = 'NOT_DUE' OR
     F1 = 'SKNTO'    OR F1 = 'CURR'      OR F1 = 'DEBIT'.

    T_FIELDCAT-DO_SUM = 'X'.
  ENDIF.

  IF F1 = 'BELNR'.
    T_FIELDCAT-HOTSPOT = 'X'.
  ENDIF.
  APPEND T_FIELDCAT.
  CLEAR T_FIELDCAT.

ENDFORM.                    " f_fieldcatalog

*&---------------------------------------------------------------------*
*&      Form  list_display
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM LIST_DISPLAY.
* DATA: gs_variant TYPE disvariant.
*  gs_variant-report  = sy-repid.
**  gs_variant-variant = p_var.     "PARAMETER p_var TYPE disvariant-variant
*
*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*    EXPORTING
*      i_callback_program = sy-repid
*      is_variant         = gs_variant
*      i_save             = 'A'
*      it_fieldcat        = T_FIELDCAT[]
*    TABLES
*      t_outtab           = ITAB[]
*    EXCEPTIONS
*      program_error      = 1
*      OTHERS             = 2.

IS_VARIANT-REPORT = SY-REPID.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      I_CALLBACK_PROGRAM       = SY-REPID
      I_CALLBACK_USER_COMMAND  = 'USER_CMD'
      IS_LAYOUT                = FS_LAYOUT
      I_CALLBACK_TOP_OF_PAGE   = 'TOP-OF-PAGE'
      IT_FIELDCAT              = T_FIELDCAT[]
      IT_SORT                  = T_SORT[]
      I_DEFAULT                = 'X'
      I_SAVE                   = 'A' "'U'
*      I_CALLBACK_PF_STATUS_SET = 'ZUS_FI_CUST'
       IS_VARIANT                  =   IS_VARIANT
    TABLES
      T_OUTTAB                 = ITAB[]
    EXCEPTIONS
      PROGRAM_ERROR            = 1
      OTHERS                   = 2.
  IF SY-SUBRC <> 0.
    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.



*  DATA : LV_PRO_NAME TYPE  SY-REPID .
*  LV_PRO_NAME =  'ZFI_CUST_AGEING' .
*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*    EXPORTING
*      I_INTERFACE_CHECK           = ' '
*      I_BYPASSING_BUFFER          = ' '
*      I_BUFFER_ACTIVE             = ' '
*      I_CALLBACK_PROGRAM          = LV_PRO_NAME "SY-REPID
*      I_CALLBACK_PF_STATUS_SET    = ' '
*      I_CALLBACK_USER_COMMAND     = 'USER_CMD'
*      I_CALLBACK_TOP_OF_PAGE      = 'TOP-OF-PAGE'
*      I_CALLBACK_HTML_TOP_OF_PAGE = I_CALLBACK_HTML_TOP_OF_PAGE
*      I_CALLBACK_HTML_END_OF_LIST = I_CALLBACK_HTML_END_OF_LIST
*      I_STRUCTURE_NAME            = I_STRUCTURE_NAME
*      I_BACKGROUND_ID             = I_BACKGROUND_ID
*      I_GRID_TITLE                = I_GRID_TITLE
*      I_GRID_SETTINGS             = I_GRID_SETTINGS
*      IS_LAYOUT                   = FS_LAYOUT
*      IT_FIELDCAT                 = T_FIELDCAT[]
*      IT_EXCLUDING                = IT_EXCLUDING
*      IT_SPECIAL_GROUPS           = IT_SPECIAL_GROUPS
*      IT_SORT                     = T_SORT[]
*      IT_FILTER                   = IT_FILTER
*      IS_SEL_HIDE                 = IS_SEL_HIDE
**     I_DEFAULT                   = 'X'
*      I_SAVE                      = 'X'
*     IS_VARIANT                  = IS_VARIANT
*     IT_EVENTS                   = IT_EVENTS
*     IT_EVENT_EXIT               = IT_EVENT_EXIT
*     IS_PRINT                    = IS_PRINT
*     IS_REPREP_ID                = IS_REPREP_ID
**     I_SCREEN_START_COLUMN       = 0
**     I_SCREEN_START_LINE         = 0
**     I_SCREEN_END_COLUMN         = 0
**     I_SCREEN_END_LINE           = 0
**     I_HTML_HEIGHT_TOP           = 0
**     I_HTML_HEIGHT_END           = 0
*      IT_ALV_GRAPHICS             = IT_ALV_GRAPHICS
*      IT_HYPERLINK                = IT_HYPERLINK
*      IT_ADD_FIELDCAT             = IT_ADD_FIELDCAT
*      IT_EXCEPT_QINFO             = IT_EXCEPT_QINFO
**     IR_SALV_FULLSCREEN_ADAPTER  =
**     O_PREVIOUS_SRAL_HANDLER     =
**     O_COMMON_HUB                =
**   IMPORTING
**     E_EXIT_CAUSED_BY_CALLER     =
**     ES_EXIT_CAUSED_BY_USER      =
*    TABLES
*      T_OUTTAB                    = ITAB[]
*    EXCEPTIONS
*      PROGRAM_ERROR               = 1
*      OTHERS                      = 2.
*  IF SY-SUBRC <> 0.
*    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*           WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*  ENDIF.




ENDFORM.                    " list_display
FORM zus_fi_cust USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'ZUS_FI_CUST' EXCLUDING rt_extab.
ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  top-of-page
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM TOP-OF-PAGE.

*  ALV Header declarations
  DATA: T_HEADER      TYPE SLIS_T_LISTHEADER,
        WA_HEADER     TYPE SLIS_LISTHEADER,
        T_LINE        LIKE WA_HEADER-INFO,
        LD_LINES      TYPE I,
        LD_LINESC(10) TYPE C.

*  Title
  WA_HEADER-TYP  = 'H'.
  WA_HEADER-INFO = 'Customer Aging Report'.
  APPEND WA_HEADER TO T_HEADER.
  CLEAR WA_HEADER.

*  Date
  WA_HEADER-TYP  = 'S'.
  WA_HEADER-KEY  = 'As on   :'.
  CONCATENATE WA_HEADER-INFO DATE+6(2) '.' DATE+4(2) '.' DATE(4) INTO WA_HEADER-INFO.
  APPEND WA_HEADER TO T_HEADER.
  CLEAR: WA_HEADER.

*  Date
  WA_HEADER-TYP  = 'S'.
  WA_HEADER-KEY  = 'Run Date : '.
  CONCATENATE WA_HEADER-INFO SY-DATUM+6(2) '.' SY-DATUM+4(2) '.'
                      SY-DATUM(4) INTO WA_HEADER-INFO.
  APPEND WA_HEADER TO T_HEADER.
  CLEAR: WA_HEADER.

*  Time
  WA_HEADER-TYP  = 'S'.
  WA_HEADER-KEY  = 'Run Time: '.
  CONCATENATE WA_HEADER-INFO SY-TIMLO(2) ':' SY-TIMLO+2(2) ':'
                      SY-TIMLO+4(2) INTO WA_HEADER-INFO.
  APPEND WA_HEADER TO T_HEADER.
  CLEAR: WA_HEADER.

*   Total No. of Records Selected
  DESCRIBE TABLE ITAB LINES LD_LINES.
  LD_LINESC = LD_LINES.

  CONCATENATE 'Total No. of Records Selected: ' LD_LINESC
     INTO T_LINE SEPARATED BY SPACE.

  WA_HEADER-TYP  = 'A'.
  WA_HEADER-INFO = T_LINE.
  APPEND WA_HEADER TO T_HEADER.
  CLEAR: WA_HEADER, T_LINE.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      IT_LIST_COMMENTARY = T_HEADER.
ENDFORM.                    " top-of-page


*&---------------------------------------------------------------------*
*&      Form  USER_CMD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

FORM USER_CMD USING R_UCOMM LIKE SY-UCOMM
                    RS_SELFIELD TYPE SLIS_SELFIELD.
  IF R_UCOMM = '&IC1'.
    IF RS_SELFIELD-FIELDNAME = 'BELNR'.
      READ TABLE ITAB WITH KEY BELNR = RS_SELFIELD-VALUE.
      SET PARAMETER ID 'BLN' FIELD RS_SELFIELD-VALUE.
      SET PARAMETER ID 'BUK' FIELD PLANT.
      SET PARAMETER ID 'GJR' FIELD ITAB-GJAHR.
      CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.
    ENDIF.
  ENDIF.
ENDFORM.

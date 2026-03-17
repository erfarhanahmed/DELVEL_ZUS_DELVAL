
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
* 1.PROGRAM OWNER          : PRIMUS TECHSYSTEMS PVT LTD.               *
* 2.CREATION DATE          : 30-12-2019                                *
* 3.CHANGED  DATE          : 08-01-2020                                *
* 4.CREATED BY             : AMAR POLEKAR                              *
* 5.CHANGED BY             : DHANANJAY KALE                            *
* 6.FUNCTIONAL CONSULTANT  : SAGAR PATKI / PRANAV KHADATKAR            *
* 7.TR DETAILS             : DEVK906801                                *
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*

REPORT ZUS_ITEM_MASTER.

TABLES : VBRP.

TYPES : BEGIN OF TY_FINAL,
          MATNR    TYPE MARA-MATNR,
          WRKST    TYPE MARA-WRKST,
          MAKTX    TYPE MAKT-MAKTX,
          MTART    TYPE MARA-MTART,
          MATKL    TYPE MARA-MATKL,
          ERSDA    TYPE MARA-ERSDA,
          BKLAS    TYPE MBEW-BKLAS,
          ZSERIES  TYPE MARA-ZSERIES,
          ZSIZE    TYPE MARA-ZSIZE,
          BRAND    TYPE MARA-BRAND,
          MOC      TYPE MARA-MOC,
          TYPE     TYPE MARA-TYPE,
          JAN      TYPE VBRP-FKLMG,
          FEB      TYPE VBRP-FKLMG,
          MAR      TYPE VBRP-FKLMG,
          APR      TYPE VBRP-FKLMG,
          MAY      TYPE VBRP-FKLMG,
          JUN      TYPE VBRP-FKLMG,
          JUL      TYPE VBRP-FKLMG,
          AUG      TYPE VBRP-FKLMG,
          SEP      TYPE VBRP-FKLMG,
          OCT      TYPE VBRP-FKLMG,
          NOV      TYPE VBRP-FKLMG,
          DEC      TYPE VBRP-FKLMG,
          JAN_PR   TYPE VBRP-NETWR,
          FEB_PR   TYPE VBRP-NETWR,
          MAR_PR   TYPE VBRP-NETWR,
          APR_PR   TYPE VBRP-NETWR,
          MAY_PR   TYPE VBRP-NETWR,
          JUN_PR   TYPE VBRP-NETWR,
          JUL_PR   TYPE VBRP-NETWR,
          AUG_PR   TYPE VBRP-NETWR,
          SEP_PR   TYPE VBRP-NETWR,
          OCT_PR   TYPE VBRP-NETWR,
          NOV_PR   TYPE VBRP-NETWR,
          DEC_PR   TYPE VBRP-NETWR,
          REF      TYPE CHAR15,
          SALE_TOT TYPE VBRP-FKIMG,
          PRI_TOT  TYPE VBRP-NETWR,
        END OF TY_FINAL.


DATA : LT_FINAL TYPE STANDARD TABLE OF TY_FINAL,
       LS_FINAL TYPE TY_FINAL.

DATA : LS_FISCAL   TYPE BKPF-GJAHR,
       NEXT_FISCAL TYPE BKPF-GJAHR.

DATA : CANCEL_QTY   TYPE VBRP-FKIMG,
       CANCEL_PRICE TYPE VBRP-NETWR.

DATA : IT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
       WA_FCAT LIKE LINE OF IT_FCAT.
DATA : FS_LAYOUT TYPE SLIS_LAYOUT_ALV.

DATA : JAN_UN TYPE DD03P-SCRTEXT_L,
       FEB_UN TYPE DD03P-SCRTEXT_L,
       MAR_UN TYPE DD03P-SCRTEXT_L,
       APR_UN TYPE DD03P-SCRTEXT_L,
       MAY_UN TYPE DD03P-SCRTEXT_L,
       JUN_UN TYPE DD03P-SCRTEXT_L,
       JUL_UN TYPE DD03P-SCRTEXT_L,
       AUG_UN TYPE DD03P-SCRTEXT_L,
       SEP_UN TYPE DD03P-SCRTEXT_L,
       OCT_UN TYPE DD03P-SCRTEXT_L,
       NOV_UN TYPE DD03P-SCRTEXT_L,
       DEC_UN TYPE DD03P-SCRTEXT_L.

DATA :JAN_PR TYPE DD03P-SCRTEXT_L,
      FEB_PR TYPE DD03P-SCRTEXT_L,
      MAR_PR TYPE DD03P-SCRTEXT_L,
      APR_PR TYPE DD03P-SCRTEXT_L,
      MAY_PR TYPE DD03P-SCRTEXT_L,
      JUN_PR TYPE DD03P-SCRTEXT_L,
      JUL_PR TYPE DD03P-SCRTEXT_L,
      AUG_PR TYPE DD03P-SCRTEXT_L,
      SEP_PR TYPE DD03P-SCRTEXT_L,
      OCT_PR TYPE DD03P-SCRTEXT_L,
      NOV_PR TYPE DD03P-SCRTEXT_L,
      DEC_PR TYPE DD03P-SCRTEXT_L.

DATA : YEAR  TYPE CHAR4.
DATA : MONTH TYPE CHAR2.
DATA : YEAR2 TYPE CHAR2.
CONSTANTS : LS_PALNT TYPE MARC-WERKS VALUE 'US01'.

DATA : KWERT_TMP1 TYPE prcd_elements-KWERT.
DATA : KWERT_TMP2 TYPE prcd_elements-KWERT.
DATA : TMP_VAL1 TYPE prcd_elements-KWERT.
DATA : TMP_VAL2 TYPE prcd_elements-KWERT.


SELECTION-SCREEN:BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS:S_MATNR FOR VBRP-MATNR,
               s_WERKS FOR VBRP-WERKS OBLIGATORY DEFAULT 'US01'.
SELECTION-SCREEN:END OF BLOCK B1.


AT SELECTION-SCREEN.

  MONTH = SY-DATUM+04(02).
  IF MONTH GT 4.
    LS_FISCAL = SY-DATUM+0(04).
  ELSE.
    LS_FISCAL =  SY-DATUM+0(04) - 1.
  ENDIF.
  CLEAR : MONTH.

START-OF-SELECTION.

  YEAR = LS_FISCAL + 1.
  CONCATENATE 'Units Sold JAN'  YEAR INTO JAN_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold FEB'  YEAR INTO FEB_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold MAR'  YEAR INTO MAR_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold APR'  LS_FISCAL INTO APR_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold MAY'  LS_FISCAL INTO MAY_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold JUN'  LS_FISCAL INTO JUN_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold JUL'  LS_FISCAL INTO JUL_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold AUG'  LS_FISCAL INTO AUG_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold SEP'  LS_FISCAL INTO SEP_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold OCT'  LS_FISCAL INTO OCT_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold NOV'  LS_FISCAL INTO NOV_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold DEC'  LS_FISCAL INTO DEC_UN SEPARATED BY '/'.


  CONCATENATE 'Sales Price($) JAN'   YEAR INTO JAN_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) FEB'   YEAR INTO FEB_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) MAR'   YEAR INTO MAR_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) APR'   LS_FISCAL INTO APR_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) MAY'   LS_FISCAL INTO MAY_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) JUN'   LS_FISCAL INTO JUN_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) JUL'   LS_FISCAL INTO JUL_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) AUG'   LS_FISCAL INTO AUG_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) SEP'   LS_FISCAL INTO SEP_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) OCT'   LS_FISCAL INTO OCT_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) NOV'   LS_FISCAL INTO NOV_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) DEC'   LS_FISCAL INTO DEC_PR SEPARATED BY '/'.



  DELETE s_WERKS WHERE low = 'PL01'.
  DELETE s_WERKS WHERE high = 'PL01'.

  PERFORM DATA_GET_PROCESS.
  PERFORM FIELD_CAT.
  PERFORM DISPLAY_DATA.
*&---------------------------------------------------------------------*
*&      Form  DATA_GET_PROCESS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DATA_GET_PROCESS .

  SELECT  A~MATNR,   "<------for current year
          A~WRKST,
          A~MTART,
          A~MATKL,
          A~ERSDA,
          A~ZSERIES,
          A~ZSIZE,
          A~BRAND,
          A~MOC,
          A~TYPE,
          B~BWKEY,
          B~BKLAS,
          B~LFGJA
    INTO TABLE @DATA(LT_MAT_DATA)
    FROM MARA AS A
    INNER JOIN MBEW AS B ON A~MATNR = B~MATNR
    WHERE A~MATNR IN @S_MATNR
    AND   B~BWKEY IN @s_WERKS
    AND   B~LFGJA EQ @LS_FISCAL.


  IF NOT LT_MAT_DATA IS INITIAL.
    SELECT VBELN,                                       "#EC CI_NOFIELD
           POSNR,
           FKLMG,
           NETWR,
           MATNR
   INTO TABLE @DATA(LT_BILL_ITEM) FROM VBRP
   FOR ALL ENTRIES IN @LT_MAT_DATA
   WHERE MATNR = @LT_MAT_DATA-MATNR
   AND   WERKS EQ @LT_MAT_DATA-BWKEY." @LS_PALNT.
  ENDIF.


  IF NOT LT_BILL_ITEM IS INITIAL.
    SELECT VBELN,
           FKART,
           FKDAT,
           RFBSK,
           KNUMV
      FROM VBRK INTO TABLE @DATA(LT_BILL_HEAD)
      FOR ALL ENTRIES IN @LT_BILL_ITEM
      WHERE VBELN = @LT_BILL_ITEM-VBELN
      AND   FKART IN ( 'US01' ,'US02','US03','US07','US08','US10','US1','US03','US11','US05' ).
  ENDIF.


  SORT LT_BILL_HEAD BY FKDAT.


  SELECT  A~MATNR,   "<------for next year
          A~WRKST,
          A~MTART,
          A~MATKL,
          A~ERSDA,
          A~ZSERIES,
          A~ZSIZE,
          A~BRAND,
          A~MOC,
          A~TYPE,
          B~BWKEY,
          B~BKLAS,
          B~LFGJA
    INTO TABLE @DATA(LT_MAT_DATA2)
    FROM MARA AS A
    INNER JOIN MBEW AS B ON A~MATNR = B~MATNR
    WHERE A~MATNR IN @S_MATNR
    AND   B~BWKEY IN @S_WERKS
    AND   B~LFGJA EQ @YEAR.




  IF NOT LT_MAT_DATA2 IS INITIAL.
    SELECT VBELN,                                       "#EC CI_NOFIELD
           POSNR,
           FKLMG,
           NETWR,
           MATNR
   INTO TABLE @DATA(LT_BILL_ITEM2) FROM VBRP
   FOR ALL ENTRIES IN @LT_MAT_DATA2
   WHERE MATNR = @LT_MAT_DATA2-MATNR
   AND   WERKS IN @S_WERKS.  "@LS_PALNT.
  ENDIF.


  IF NOT LT_BILL_ITEM2 IS INITIAL.
    SELECT VBELN,
           FKART,
           FKDAT,
           RFBSK,
           KNUMV
      INTO TABLE @DATA(LT_BILL_HEAD2) FROM VBRK
      FOR ALL ENTRIES IN @LT_BILL_ITEM2
      WHERE VBELN = @LT_BILL_ITEM2-VBELN
      AND   FKART IN ( 'US01' ,'US02','US03','US07','US08','US10','US1','US03','US11','US05' ).
*      AND   RFBSK NE 'E'.
  ENDIF.

  SORT LT_BILL_HEAD2 BY FKDAT.

  APPEND LINES OF LT_MAT_DATA2  TO LT_MAT_DATA.
  APPEND LINES OF LT_BILL_ITEM2 TO LT_BILL_ITEM.
  APPEND LINES OF LT_BILL_HEAD2 TO LT_BILL_HEAD.

  IF LT_BILL_HEAD IS NOT INITIAL.
    SELECT KNUMV,
           KPOSN,
           KSCHL,
           KAWRT,
           KWERT
      INTO TABLE @DATA(LT_COND) FROM prcd_elements
      FOR ALL ENTRIES IN @LT_BILL_HEAD
      WHERE KNUMV = @LT_BILL_HEAD-KNUMV
        AND KSCHL = 'ZPR0'.

  ENDIF.



  LOOP AT LT_MAT_DATA INTO DATA(LS_MAT_DATA).

    LS_FINAL-MATNR    = LS_MAT_DATA-MATNR.
    LS_FINAL-WRKST    = LS_MAT_DATA-WRKST.
    SELECT SINGLE MAKTX FROM MAKT INTO LS_FINAL-MAKTX WHERE MATNR = LS_FINAL-MATNR.
    LS_FINAL-MTART    = LS_MAT_DATA-MTART.
    LS_FINAL-MATKL    = LS_MAT_DATA-MATKL.
    LS_FINAL-ERSDA    = LS_MAT_DATA-ERSDA.
    LS_FINAL-ZSERIES  = LS_MAT_DATA-ZSERIES.
    LS_FINAL-ZSIZE    = LS_MAT_DATA-ZSIZE.
    LS_FINAL-BRAND    = LS_MAT_DATA-BRAND.
    LS_FINAL-MOC      = LS_MAT_DATA-MOC  .
    LS_FINAL-TYPE     = LS_MAT_DATA-TYPE .
    LS_FINAL-BKLAS    = LS_MAT_DATA-BKLAS.

    LOOP AT LT_BILL_ITEM INTO DATA(LS_BILL_ITEM) WHERE MATNR = LS_MAT_DATA-MATNR.

      READ TABLE LT_BILL_HEAD INTO DATA(LS_BILL_HEAD) WITH KEY VBELN = LS_BILL_ITEM-VBELN.
      IF SY-SUBRC = 0.

        READ TABLE LT_COND INTO DATA(LS_COND) WITH KEY KNUMV = LS_BILL_HEAD-KNUMV KPOSN = LS_BILL_ITEM-POSNR .
        IF SY-SUBRC = 0.

        ENDIF.

        IF LS_BILL_HEAD-FKART = 'US1' OR LS_BILL_HEAD-FKART = 'US11' OR LS_BILL_HEAD-FKART = 'US03' OR LS_BILL_HEAD-FKART = 'US05'.
          CANCEL_QTY   = ( LS_BILL_ITEM-FKLMG * -1 ).
*          CANCEL_PRICE = ( LS_BILL_ITEM-NETWR * -1 ).
          CANCEL_PRICE = ( LS_COND-KWERT * -1 ).
        ENDIF.
        IF CANCEL_QTY IS NOT INITIAL .
          LS_BILL_ITEM-FKLMG = CANCEL_QTY.
        ENDIF.

        IF CANCEL_PRICE IS NOT INITIAL.
*          LS_BILL_ITEM-NETWR = CANCEL_PRICE.
          LS_COND-KWERT = CANCEL_PRICE.
        ENDIF.

*&============================COMMENTED ON DT. 09.01.2020 ( DHANANJAY KALE )====================================*&

** READ TABLE LT_BILL_HEAD INTO DATA(LS_BILL_HEAD) WITH KEY VBELN = LS_BILL_ITEM-VBELN.
**      IF SY-SUBRC = 0.
**
**        READ TABLE LT_cond INTO DATA(LS_cond) WITH KEY knumv = LS_BILL_HEAD-knumv kposn = LS_BILL_ITEM-posnr .
**          IF sy-subrc = 0.
**
**          ENDIF.
**
**        IF LS_BILL_HEAD-FKART = 'US1' OR LS_BILL_HEAD-FKART = 'US11' OR LS_BILL_HEAD-FKART = 'US03'.
**          CANCEL_QTY   = ( LS_BILL_ITEM-FKLMG * -1 ).
***          CANCEL_PRICE = ( LS_BILL_ITEM-NETWR * -1 ).
**           CANCEL_PRICE = ( LS_cond-kwert * -1 ).
**        ENDIF.
**        IF CANCEL_QTY IS NOT INITIAL .
**          LS_BILL_ITEM-FKLMG = CANCEL_QTY.
**        ENDIF.
**
**        IF CANCEL_PRICE IS NOT INITIAL.
***          LS_BILL_ITEM-NETWR = CANCEL_PRICE.
**          LS_cond-kwert = CANCEL_PRICE.
**        ENDIF.

*&============================START OF ADDED CODE FOR PRICE DIFFERENCE 09.01.2020 ( DHANANJAY KALE )====================================*&

        IF LS_BILL_HEAD-FKART = 'US01' OR LS_BILL_HEAD-FKART = 'US02' OR LS_BILL_HEAD-FKART = 'US07'
          OR LS_BILL_HEAD-FKART = 'US08' OR LS_BILL_HEAD-FKART = 'US10'.

          SELECT SINGLE VBELN, MATNR,POSNR FROM VBRP INTO  @DATA(LS_VBRP) WHERE VBELN EQ @LS_BILL_HEAD-VBELN
                                                                           AND   MATNR EQ @LS_MAT_DATA-MATNR.

          SELECT SINGLE VBELN,KNUMV FROM VBRK INTO @DATA(LS_VBRK) WHERE VBELN EQ @LS_BILL_HEAD-VBELN .

          SELECT KNUMV, KSCHL, KWERT FROM prcd_elements INTO TABLE @DATA(LT_KONV) WHERE KPOSN EQ @LS_VBRP-POSNR
                                                                         AND   KNUMV EQ @LS_VBRK-KNUMV.
          LOOP AT LT_KONV INTO DATA(LS_KONV).
            IF LS_KONV-KSCHL EQ 'UHF1'.
              KWERT_TMP1 = KWERT_TMP1 + LS_KONV-KWERT.
            ELSEIF LS_KONV-KSCHL EQ 'USC1'.
              KWERT_TMP1 = KWERT_TMP1 + LS_KONV-KWERT.
            ELSEIF LS_KONV-KSCHL EQ 'UMC1'.
              KWERT_TMP1 = KWERT_TMP1 + LS_KONV-KWERT.
            ENDIF.
          ENDLOOP.

          TMP_VAL1 = LS_BILL_ITEM-NETWR - KWERT_TMP1.

        ELSEIF LS_BILL_HEAD-FKART = 'US03' OR LS_BILL_HEAD-FKART = 'US1' OR LS_BILL_HEAD-FKART = 'US11'.

          SELECT SINGLE VBELN, MATNR,POSNR FROM VBRP INTO  @DATA(LS_VBRP1) WHERE VBELN EQ @LS_BILL_HEAD-VBELN
                                                                                     AND   MATNR EQ @LS_MAT_DATA-MATNR.

          SELECT SINGLE VBELN,KNUMV FROM VBRK INTO @DATA(LS_VBRK1) WHERE VBELN EQ @LS_BILL_HEAD-VBELN .

          SELECT KNUMV, KSCHL, KWERT FROM prcd_elements INTO TABLE @DATA(LT_KONV1) WHERE KPOSN EQ @LS_VBRP1-POSNR
                                                                         AND   KNUMV EQ @LS_VBRK1-KNUMV.
          LOOP AT LT_KONV1 INTO DATA(LS_KONV1).
            IF LS_KONV1-KSCHL EQ 'UHF1'.
              KWERT_TMP2 = KWERT_TMP1 + LS_KONV1-KWERT.
            ELSEIF LS_KONV-KSCHL EQ 'USC1'.
              KWERT_TMP2 = KWERT_TMP1 + LS_KONV1-KWERT.
            ELSEIF LS_KONV-KSCHL EQ 'UMC1'.
              KWERT_TMP2 = KWERT_TMP1 + LS_KONV1-KWERT.
            ENDIF.
          ENDLOOP.

          TMP_VAL2 = LS_BILL_ITEM-NETWR - KWERT_TMP2.

        ENDIF.

        LS_BILL_ITEM-NETWR = TMP_VAL1 - TMP_VAL2.

        CLEAR : TMP_VAL1,
                TMP_VAL2,
                LS_KONV,
                LS_KONV1,
                LS_VBRP,
                LS_VBRP1,
                LS_VBRK,
                LS_VBRK1,
                KWERT_TMP1,
                KWERT_TMP2.

        FREE : LT_KONV1.

*&============================END OF ADDED CODE FOR PRICE DIFFERENCE 09.01.2020 ( DHANANJAY KALE )====================================*&

        MONTH = LS_BILL_HEAD-FKDAT+04(02).

        IF LS_BILL_HEAD-FKDAT+00(04) = YEAR.
          IF MONTH = '01'.
            LS_FINAL-JAN     = LS_FINAL-JAN    + LS_BILL_ITEM-FKLMG.
            LS_FINAL-JAN_PR  = LS_FINAL-JAN_PR + LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ELSEIF MONTH = '02'.
            LS_FINAL-FEB     = LS_FINAL-FEB    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-FEB_PR  = LS_FINAL-FEB_PR + LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ELSEIF MONTH = '03'.
            LS_FINAL-MAR     = LS_FINAL-MAR    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-MAR_PR  = LS_FINAL-MAR_PR + LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ENDIF.
        ENDIF.


        IF LS_BILL_HEAD-FKDAT+00(04) = LS_FISCAL.
          IF MONTH = '04'.
            LS_FINAL-APR    = LS_FINAL-APR    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-APR_PR = LS_FINAL-APR_PR +  LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ELSEIF MONTH = '05'.
            LS_FINAL-MAY    = LS_FINAL-MAY    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-MAY_PR = LS_FINAL-MAY_PR +  LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ELSEIF MONTH = '06'.
            LS_FINAL-JUN    = LS_FINAL-JUN    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-JUN_PR = LS_FINAL-JUN_PR +  LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ELSEIF MONTH = '07'.
            LS_FINAL-JUL    = LS_FINAL-JUL    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-JUL_PR = LS_FINAL-JUL_PR + LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ELSEIF MONTH = '08'.
            LS_FINAL-AUG    = LS_FINAL-AUG    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-AUG_PR = LS_FINAL-AUG_PR +  LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.

          ELSEIF MONTH = '09'.
            LS_FINAL-SEP    = LS_FINAL-SEP    + LS_BILL_ITEM-FKLMG.
            LS_FINAL-SEP_PR = LS_FINAL-SEP_PR + LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.

          ELSEIF MONTH = '10'.
            LS_FINAL-OCT    = LS_FINAL-OCT    + LS_BILL_ITEM-FKLMG.
            LS_FINAL-OCT_PR = LS_FINAL-OCT_PR +  LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ELSEIF MONTH = '11'.
            LS_FINAL-NOV    = LS_FINAL-NOV    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-NOV_PR = LS_FINAL-NOV_PR +  LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ELSEIF MONTH = '12'.
            LS_FINAL-DEC    = LS_FINAL-DEC    +  LS_BILL_ITEM-FKLMG.
            LS_FINAL-DEC_PR = LS_FINAL-DEC_PR +  LS_COND-KWERT.     "LS_BILL_ITEM-NETWR.
          ENDIF.
        ENDIF.
      ENDIF.
      CLEAR : CANCEL_QTY,CANCEL_PRICE.
      CLEAR : MONTH.
      CLEAR : LS_BILL_ITEM,LS_BILL_HEAD.
    ENDLOOP.

    LS_FINAL-SALE_TOT = (  LS_FINAL-JAN + LS_FINAL-FEB + LS_FINAL-MAR + LS_FINAL-APR + LS_FINAL-MAY + LS_FINAL-JUN +
                           LS_FINAL-JUL + LS_FINAL-AUG + LS_FINAL-SEP + LS_FINAL-OCT + LS_FINAL-NOV + LS_FINAL-DEC  ).


    LS_FINAL-PRI_TOT  = (  LS_FINAL-JAN_PR + LS_FINAL-FEB_PR + LS_FINAL-MAR_PR + LS_FINAL-APR_PR + LS_FINAL-MAY_PR +
                           LS_FINAL-JUN_PR + LS_FINAL-JUL_PR + LS_FINAL-AUG_PR + LS_FINAL-SEP_PR + LS_FINAL-OCT_PR +
                           LS_FINAL-NOV_PR + LS_FINAL-DEC_PR ).



    APPEND LS_FINAL TO LT_FINAL.
    CLEAR : LS_FINAL.
    CLEAR : LS_MAT_DATA.

  ENDLOOP.

  SORT LT_FINAL.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELD_CAT .

  PERFORM FCAT USING :

*-----------------------Sales Data---------------------------------------------*

                         '1'  'MATNR'         'IT_FINAL'  'Material.No.'            '18'  'C110' ,
                         '2'  'WRKST'         'IT_FINAL'  'USA Code'                '18'  'C110' ,
                         '3'  'MAKTX'         'IT_FINAL'  'Material Desc.'          '18'  'C110' ,
                         '4'  'MTART'         'IT_FINAL'  'Material Type'           '18'  'C110' ,
                         '5'  'MATKL'         'IT_FINAL'  'Material Group'          '18'  'C110' ,
                         '6'  'ERSDA'         'IT_FINAL'  'Material Creat Date.'    '18'  'C110' ,
                         '7'  'BKLAS'         'IT_FINAL'  'Valuation Class'         '18'  'C110' ,
                         '8'  'ZSERIES'       'IT_FINAL'  'series '                 '18'  'C110' ,
                         '9'  'ZSIZE'         'IT_FINAL'  'Size'                    '18'  'C110' ,
                        '10'  'BRAND'         'IT_FINAL'  'Brand'                   '18'  'C110' ,
                        '11'  'MOC'           'IT_FINAL'  'Moc'                     '18'  'C110' ,
                        '12'  'TYPE'          'IT_FINAL'  'Type'                    '18'  'C110' ,
                        '13'  'APR'           'IT_FINAL'  APR_UN                    '18'  'C110' ,
                        '14'  'MAY'           'IT_FINAL'  MAY_UN                    '18'  'C310' ,
                        '15'  'JUN'           'IT_FINAL'  JUN_UN                    '18'  'C310' ,
                        '16'  'JUL'           'IT_FINAL'  JUL_UN                    '18'  'C310' ,
                        '17'  'AUG'           'IT_FINAL'  AUG_UN                    '18'  'C310' ,
                        '18'  'SEP'           'IT_FINAL'  SEP_UN                    '18'  'C310' ,
                        '19'  'OCT'           'IT_FINAL'  OCT_UN                    '18'  'C310' ,
                        '20'  'NOV'           'IT_FINAL'  NOV_UN                    '18'  'C310' ,
                        '21'  'DEC'           'IT_FINAL'  DEC_UN                    '18'  'C310' ,
                        '22'  'JAN'           'IT_FINAL'  JAN_UN                    '18'  'C310' ,
                        '23'  'FEB'           'IT_FINAL'  FEB_UN                    '18'  'C310' ,
                        '24'  'MAR'           'IT_FINAL'  MAR_UN                    '18'  'C310' ,
                        '25'  'SALE_TOT'      'IT_FINAL'  'Sales Total'             '18'  'C710' ,

*---------------------Sales Pricing -----------------------------------------------*

                        '26'  'APR_PR'           'IT_FINAL'  APR_PR     '18' 'C510',
                        '27'  'MAY_PR'           'IT_FINAL'  MAY_PR     '18' 'C510',
                        '28'  'JUN_PR'           'IT_FINAL'  JUN_PR     '18' 'C510',
                        '29'  'JUL_PR'           'IT_FINAL'  JUL_PR     '18' 'C510',
                        '30'  'AUG_PR'           'IT_FINAL'  AUG_PR     '18' 'C510',
                        '31'  'SEP_PR'           'IT_FINAL'  SEP_PR     '18' 'C510',
                        '32'  'OCT_PR'           'IT_FINAL'  OCT_PR     '18' 'C510',
                        '33'  'NOV_PR'           'IT_FINAL'  NOV_PR     '18' 'C510',
                        '34'  'DEC_PR'           'IT_FINAL'  DEC_PR     '18' 'C510',
                        '35'  'JAN_PR'           'IT_FINAL'  JAN_PR     '18' 'C510',
                        '36'  'FEB_PR'           'IT_FINAL'  FEB_PR     '18' 'C510',
                        '37'  'MAR_PR'           'IT_FINAL'  MAR_PR     '18' 'C510',
                        '38'  'PRI_TOT'          'IT_FINAL'  'Total Price'     '18'   'C710'.





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
FORM FCAT  USING    VALUE(P1)
                    VALUE(P2)
                    VALUE(P3)
                    VALUE(P4)
                    VALUE(P5)
                    VALUE(P6).
  WA_FCAT-COL_POS   = P1.
  WA_FCAT-FIELDNAME = P2.
  WA_FCAT-TABNAME   = P3.
  WA_FCAT-SELTEXT_L = P4.
*  wa_fcat-key       = .
  WA_FCAT-OUTPUTLEN   = P5.
  WA_FCAT-EMPHASIZE   = P6.

  APPEND WA_FCAT TO IT_FCAT.
  CLEAR WA_FCAT.

ENDFORM.


FORM FILL_LAYOUT .
  FS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.
  FS_LAYOUT-ZEBRA             = 'X'.
  FS_LAYOUT-DETAIL_POPUP      = 'X'.
  FS_LAYOUT-SUBTOTALS_TEXT    = 'DR'.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  DISPLAY_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY_DATA .

  IF LT_FINAL IS NOT INITIAL .


    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
      EXPORTING
        PERCENTAGE = '50'
        TEXT       = 'PREPARING OUTPUT LIST...'.
    WAIT UP TO 2 SECONDS.



    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        I_CALLBACK_PROGRAM     = SY-REPID
*       IS_LAYOUT              = LAYOUT
        I_HTML_HEIGHT_TOP      = 27
        I_CALLBACK_TOP_OF_PAGE = 'TOP_PAGE'
*       I_BACKGROUND_ID        = 'ALV_BACKGROUND'
        IT_FIELDCAT            = IT_FCAT
        I_SAVE                 = 'A'
      TABLES
        T_OUTTAB               = LT_FINAL
      EXCEPTIONS
        PROGRAM_ERROR          = 1
        OTHERS                 = 2.
    IF SY-SUBRC <> 0.
      MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ELSE.
    MESSAGE 'For the given selection criteria data not found' TYPE 'E' .
  ENDIF.

ENDFORM.



FORM TOP_PAGE.

  DATA: T_HEADER      TYPE SLIS_T_LISTHEADER,
        WA_HEADER     TYPE SLIS_LISTHEADER,
        T_LINE        LIKE WA_HEADER-INFO,
        LD_LINES      TYPE I,
        LD_LINESC(10) TYPE C,
        NAME          TYPE STRING.

  WA_HEADER-TYP  = 'H'.
  WA_HEADER-INFO = 'ITEM MASTER REPORT'.
  APPEND WA_HEADER TO T_HEADER.
  CLEAR WA_HEADER.


  DATA : SDATE TYPE STRING .
  DATA : EDATE TYPE STRING.
  DATA : STD TYPE STRING.
  DATA : LV_DATE TYPE STRING.
  DATA : LV_TIME TYPE STRING.



  CONCATENATE  SY-UZEIT+0(2) SY-UZEIT+2(2) SY-UZEIT+4(2) INTO LV_TIME SEPARATED BY ':'.
  WA_HEADER-TYP   = 'S'.
  WA_HEADER-KEY   = 'CURRANT TIME :'.
  WA_HEADER-INFO  = LV_TIME.

  APPEND WA_HEADER TO T_HEADER.
  CLEAR WA_HEADER.


  CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      INPUT  = SY-DATUM
    IMPORTING
      OUTPUT = STD.

  CONCATENATE  STD+0(2) STD+2(3) STD+5(4) INTO STD SEPARATED BY '-'.
  WA_HEADER-TYP   = 'S'.
  WA_HEADER-KEY   = 'CURRANT DATE :'.
  WA_HEADER-INFO  = STD.

  APPEND WA_HEADER TO T_HEADER.
  CLEAR WA_HEADER.

  DESCRIBE TABLE LT_FINAL LINES LD_LINES.
  LD_LINESC = LD_LINES.

  WA_HEADER-TYP  = 'S'.
  WA_HEADER-KEY   = 'TOTAL RECORDS :'.
  WA_HEADER-INFO = LD_LINESC .
  APPEND WA_HEADER TO T_HEADER.
  CLEAR: WA_HEADER, T_LINE.


  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      IT_LIST_COMMENTARY = T_HEADER
*     I_LOGO             =
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .
ENDFORM.

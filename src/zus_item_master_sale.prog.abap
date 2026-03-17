


REPORT ZUS_ITEM_MASTER_SALE.

TABLES : VBRP,VBRK.

TYPES : BEGIN OF ty_vbrk,
          vbeln     TYPE vbrk-vbeln,             " a~vbeln
          fkart     TYPE vbrk-fkart,              "a~fkart
          kunrg     TYPE vbrk-kunrg,              "a~kunrg
          fkdat     TYPE vbrk-fkdat,              "a~fkdat
          knumv     TYPE vbrk-knumv,              "a~knumv
          posnr     TYPE vbrp-posnr,
          matnr     TYPE vbrp-matnr,
          matkl     TYPE vbrp-matkl,
          werks     TYPE vbrp-werks,              "b~werks
          fkimg     TYPE vbrp-fkimg,              "b~werks
          fklmg     TYPE vbrp-fklmg,              "b~werks
          netwr     TYPE vbrp-netwr,              "b~netwr
          mwsbp     TYPE vbrp-mwsbp,              "b~netwr
        END OF ty_vbrk,

        BEGIN OF ty_mara,
         MATNR    TYPE mara-MATNR  ,
         WRKST    TYPE mara-WRKST  ,
         MTART    TYPE mara-MTART  ,
         MATKL    TYPE mara-MATKL  ,
         ERSDA    TYPE mara-ERSDA  ,
         ZSERIES  TYPE mara-ZSERIES,
         ZSIZE    TYPE mara-ZSIZE  ,
         BRAND    TYPE mara-BRAND  ,
         MOC      TYPE mara-MOC    ,
         TYPE     TYPE mara-TYPE   ,
         BWKEY    TYPE mbew-BWKEY  ,
         BKLAS    TYPE mbew-BKLAS  ,
         LFGJA    TYPE mbew-LFGJA  ,
       END OF ty_mara,

       BEGIN OF ty_konv,
         KNUMV TYPE prcd_elements-KNUMV,
         KPOSN TYPE prcd_elements-KPOSN,
         KSCHL TYPE prcd_elements-KSCHL,
         KINAK TYPE prcd_elements-KINAK,
         KAWRT TYPE prcd_elements-KAWRT,
         KWERT TYPE prcd_elements-KWERT,
       END OF ty_konv.




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

DATA : it_vbrk     TYPE TABLE OF ty_vbrk,
       wa_vbrk     TYPE ty_vbrk,

       it_mat     TYPE TABLE OF ty_vbrk,
       wa_mat     TYPE ty_vbrk.


DATA : it_mara TYPE TABLE OF ty_mara,
       wa_mara TYPE          ty_mara.

DATA : it_konv TYPE TABLE OF ty_konv,
       wa_konv TYPE          ty_konv.

DATA : LT_FINAL TYPE STANDARD TABLE OF TY_FINAL,
       wa_final TYPE TY_FINAL.

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

DATA : JAN_year TYPE char4,
       FEB_year TYPE char4,
       MAR_year TYPE char4,
       APR_year TYPE char4,
       MAY_year TYPE char4,
       JUN_year TYPE char4,
       JUL_year TYPE char4,
       AUG_year TYPE char4,
       SEP_year TYPE char4,
       OCT_year TYPE char4,
       NOV_year TYPE char4,
       DEC_year TYPE char4.




DATA : YEAR  TYPE CHAR4.
DATA : MONTH TYPE CHAR2.
DATA : YEAR2 TYPE CHAR2.
CONSTANTS : LS_PALNT TYPE MARC-WERKS VALUE 'US01'.

DATA : KWERT_TMP1 TYPE prcd_elements-KWERT.
DATA : KWERT_TMP2 TYPE prcd_elements-KWERT.
DATA : TMP_VAL1 TYPE prcd_elements-KWERT.
DATA : TMP_VAL2 TYPE prcd_elements-KWERT.

TYPES : BEGIN OF ty_date,
          sign(1) ,
          option(2),
          low(08),
          high(08),
        END OF ty_date.
DATA:  it_date     TYPE TABLE OF ty_date,
       wa_date     TYPE          ty_date.




SELECTION-SCREEN:BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS:S_MATNR FOR VBRP-MATNR.
PARAMETERS    :P_WERKS TYPE VBRP-WERKS OBLIGATORY DEFAULT 'US01',
*               p_year  TYPE vbrk-GJAHR OBLIGATORY .
               p_date  TYPE sy-datum OBLIGATORY DEFAULT sy-datum.
SELECTION-SCREEN:END OF BLOCK B1.


AT SELECTION-SCREEN.

DATA : low_date TYPE sy-datum.

low_date = p_date.

CALL FUNCTION 'SG_PS_GET_LAST_DAY_OF_MONTH'
  EXPORTING
    DAY_IN                 = p_date
 IMPORTING
   LAST_DAY_OF_MONTH       = low_date
* EXCEPTIONS
*   DAY_IN_NOT_VALID        = 1
*   OTHERS                  = 2
          .
CALL FUNCTION 'BKK_ADD_WORKINGDAY'
  EXPORTING
    I_DATE            = low_date
    I_DAYS            = '1'
*   I_CALENDAR1       =
*   I_CALENDAR2       =
 IMPORTING
   E_DATE            = low_date
*   E_RETURN          =
          .


CALL FUNCTION 'CCM_GO_BACK_MONTHS'
  EXPORTING
    CURRDATE         = low_date
    BACKMONTHS       = '012'
 IMPORTING
   NEWDATE          = low_date
          .

IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.




*LS_FISCAL = p_year.
*YEAR      = p_year + 1.
*  CONCATENATE year '03'  '31' INTO wa_date-high .
*  CONCATENATE LS_FISCAL  '04' '01' INTO wa_date-low.

  wa_date-low = low_date.
  wa_date-high = p_date.
  wa_date-sign = 'I'.
  wa_date-option = 'BT'.
  APPEND wa_date TO it_date.
  CLEAR wa_date.
*
*  MONTH = SY-DATUM+04(02).
*  IF MONTH GT 4.
*    LS_FISCAL = SY-DATUM+0(04).
*  ELSE.
*    LS_FISCAL =  SY-DATUM+0(04) - 1.
*  ENDIF.
*  CLEAR : MONTH.

START-OF-SELECTION.

*  YEAR = LS_FISCAL + 1.



  PERFORM DATA_GET_PROCESS.
  PERFORM col_heading.
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


BREAK primus.
  SELECT a~vbeln
         a~fkart
         a~kunrg
         a~fkdat
         a~knumv
         b~posnr
         b~matnr
         b~matkl
         b~werks
         b~fkimg
         b~fklmg
         b~netwr
         b~mwsbp
  FROM vbrk AS a
  INNER JOIN vbrp AS b
  ON a~vbeln = b~vbeln
  INTO TABLE it_vbrk
   WHERE b~MATNR IN S_MATNR
   AND   b~WERKS EQ P_WERKS
   AND   a~fkdat IN it_date
   AND   a~FKART IN ( 'US01' ,'US02','US03','US04','US05','US07','US08','US10','US11','US1','US2' ).




it_mat = it_vbrk.

SORT it_mat BY matnr .
DELETE ADJACENT DUPLICATES FROM it_mat COMPARING matnr.
SORT it_vbrk BY fkdat.

IF it_mat IS NOT INITIAL.

  SELECT a~MATNR
         a~WRKST
         a~MTART
         a~MATKL
         a~ERSDA
         a~ZSERIES
         a~ZSIZE
         a~BRAND
         a~MOC
         a~TYPE
         b~BWKEY
         b~BKLAS
         b~LFGJA
  FROM mara AS a
  INNER JOIN mbew AS b
  ON a~matnr = b~matnr
  INTO TABLE it_mara
  FOR ALL ENTRIES IN it_mat
   WHERE b~MATNR = it_mat-matnr
   AND   b~BWKEY = it_mat-werks.


ENDIF.
  IF it_vbrk IS NOT INITIAL.
    SELECT KNUMV
           KPOSN
           KSCHL
           KINAK
           KAWRT
           KWERT
      FROM prcd_elements INTO TABLE it_konv
      FOR ALL ENTRIES IN it_vbrk
      WHERE KNUMV = it_vbrk-KNUMV
        AND kposn = it_vbrk-posnr
        AND KSCHL = 'ZPR0'
        AND KINAK = ' '.


  ENDIF.





  LOOP AT it_mara INTO wa_mara.

    wa_FINAL-MATNR    = wa_mara-MATNR.
    wa_FINAL-WRKST    = wa_mara-WRKST.
    SELECT SINGLE MAKTX FROM MAKT INTO wa_final-MAKTX WHERE MATNR = wa_FINAL-MATNR.
    wa_FINAL-MTART    = wa_mara-MTART.
    wa_FINAL-MATKL    = wa_mara-MATKL.
    wa_FINAL-ERSDA    = wa_mara-ERSDA.
    wa_FINAL-ZSERIES  = wa_mara-ZSERIES.
    wa_FINAL-ZSIZE    = wa_mara-ZSIZE.
    wa_FINAL-BRAND    = wa_mara-BRAND.
    wa_FINAL-MOC      = wa_mara-MOC  .
    wa_FINAL-TYPE     = wa_mara-TYPE .
    wa_FINAL-BKLAS    = wa_mara-BKLAS.

    LOOP AT it_vbrk INTO wa_vbrk WHERE MATNR = wa_final-MATNR.


        READ TABLE it_konv INTO wa_konv WITH KEY KNUMV = wa_vbrk-KNUMV KPOSN = wa_vbrk-POSNR .
        IF SY-SUBRC = 0.

        ENDIF.

        IF wa_vbrk-FKART = 'US1' OR wa_vbrk-FKART = 'US11' OR wa_vbrk-FKART = 'US03'." OR wa_vbrk-FKART = 'US05'.
*          CANCEL_QTY   = ( wa_vbrk-FKLMG * -1 ).
*          CANCEL_PRICE = ( wa_konv-KWERT * -1 ).
           wa_vbrk-FKLMG = wa_vbrk-FKLMG * -1.
           wa_konv-KWERT = wa_konv-KWERT * -1.
        ENDIF.
*        IF CANCEL_QTY IS NOT INITIAL .
*          wa_vbrk-FKLMG = CANCEL_QTY.
*        ENDIF.
**
*        IF CANCEL_PRICE IS NOT INITIAL.
*
*          wa_konv-KWERT = CANCEL_PRICE.
*        ENDIF.

        IF wa_vbrk-FKART = 'US04'.
          wa_vbrk-fklmg = 0 ."wa_vbrk-fklmg * -1.
        ENDIF.

        IF wa_vbrk-FKART = 'US05' ."OR wa_vbrk-FKART = 'US08'.
          wa_konv-KWERT = wa_konv-KWERT * -1.
          wa_vbrk-fklmg = 0 .
        ENDIF.


     MONTH = wa_vbrk-FKDAT+04(02).


          IF MONTH = '01'.
            wa_FINAL-JAN     = wa_final-JAN    + wa_vbrk-FKLMG.
            wa_FINAL-JAN_PR  = wa_final-JAN_PR + wa_konv-KWERT.     "wa_vbrk-NETWR.
          ELSEIF MONTH = '02'.
            wa_FINAL-FEB     = wa_final-FEB    +  wa_vbrk-FKLMG.
            wa_FINAL-FEB_PR  = wa_final-FEB_PR + wa_konv-KWERT.     "wa_vbrk-NETWR.
          ELSEIF MONTH = '03'.
            wa_FINAL-MAR     = wa_final-MAR    +  wa_vbrk-FKLMG.
            wa_FINAL-MAR_PR  = wa_final-MAR_PR + wa_konv-KWERT.     "wa_vbrk-NETWR.
          ENDIF.

          IF MONTH = '04'.
            wa_final-APR    = wa_final-APR    +  wa_vbrk-FKLMG.
            wa_final-APR_PR = wa_final-APR_PR +  wa_konv-KWERT.     "wa_vbrk-NETWR.
          ELSEIF MONTH = '05'.
            wa_final-MAY    = wa_final-MAY    +  wa_vbrk-FKLMG.
            wa_final-MAY_PR = wa_final-MAY_PR +  wa_konv-KWERT.     "wa_vbrk-NETWR.
          ELSEIF MONTH = '06'.
            wa_final-JUN    = wa_final-JUN    +  wa_vbrk-FKLMG.
            wa_final-JUN_PR = wa_final-JUN_PR +  wa_konv-KWERT.     "wa_vbrk-NETWR.
          ELSEIF MONTH = '07'.
            wa_final-JUL    = wa_final-JUL    +  wa_vbrk-FKLMG.
            wa_final-JUL_PR = wa_final-JUL_PR + wa_konv-KWERT.     "wa_vbrk-NETWR.
          ELSEIF MONTH = '08'.
            wa_final-AUG    = wa_final-AUG    +  wa_vbrk-FKLMG.
            wa_final-AUG_PR = wa_final-AUG_PR +  wa_konv-KWERT.     "wa_vbrk-NETWR.

          ELSEIF MONTH = '09'.
            wa_final-SEP    = wa_final-SEP    + wa_vbrk-FKLMG.
            wa_final-SEP_PR = wa_final-SEP_PR + wa_konv-KWERT.     "wa_vbrk-NETWR.

          ELSEIF MONTH = '10'.
            wa_final-OCT    = wa_final-OCT    + wa_vbrk-FKLMG.
            wa_final-OCT_PR = wa_final-OCT_PR +  wa_konv-KWERT.     "wa_vbrk-NETWR.
          ELSEIF MONTH = '11'.
            wa_final-NOV    = wa_final-NOV    +  wa_vbrk-FKLMG.
            wa_final-NOV_PR = wa_final-NOV_PR +  wa_konv-KWERT.     "wa_vbrk-NETWR.
          ELSEIF MONTH = '12'.
            wa_final-DEC    = wa_final-DEC    +  wa_vbrk-FKLMG.
            wa_final-DEC_PR = wa_final-DEC_PR +  wa_konv-KWERT.     "wa_vbrk-NETWR.
          ENDIF.


       IF month = '01'.
         IF jan_year IS INITIAL.
           jan_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '02'.
         IF feb_year IS INITIAL.
           feb_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '03' .
         IF mar_year IS INITIAL.
           mar_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '04'.
         IF apr_year IS INITIAL.
           apr_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '05'.
         IF may_year IS INITIAL.
           may_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '06'.
         IF jun_year IS INITIAL.
           jun_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '07'.
         IF jul_year IS INITIAL.
           jul_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '08'.
         IF aug_year IS INITIAL.
           aug_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '09'.
         IF sep_year IS INITIAL.
           sep_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '10'.
         IF oct_year IS INITIAL.
           oct_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '11'.
         IF nov_year IS INITIAL.
           nov_year = wa_vbrk-FKDAT+00(04).
         ENDIF.
       ELSEIF month = '12'.
         IF dec_year IS INITIAL.
           dec_year = wa_vbrk-FKDAT+00(04).
         ENDIF.

       ENDIF.

      CLEAR : CANCEL_QTY,CANCEL_PRICE.
      CLEAR : MONTH.
      CLEAR : wa_vbrk,wa_konv.
    ENDLOOP.

    wa_final-SALE_TOT = (  wa_final-JAN + wa_final-FEB + wa_final-MAR + wa_final-APR + wa_final-MAY + wa_final-JUN +
                           wa_final-JUL + wa_final-AUG + wa_final-SEP + wa_final-OCT + wa_final-NOV + wa_final-DEC  ).


    wa_final-PRI_TOT  = (  wa_final-JAN_PR + wa_final-FEB_PR + wa_final-MAR_PR + wa_final-APR_PR + wa_final-MAY_PR +
                           wa_final-JUN_PR + wa_final-JUL_PR + wa_final-AUG_PR + wa_final-SEP_PR + wa_final-OCT_PR +
                           wa_final-NOV_PR + wa_final-DEC_PR ).



    APPEND wa_final TO LT_FINAL.
    CLEAR : wa_final.
    CLEAR : wa_MAT.

  ENDLOOP.


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
                        '13'  'JAN'           'IT_FINAL'  JAN_UN                    '18'  'C310' ,
                        '14'  'FEB'           'IT_FINAL'  FEB_UN                    '18'  'C310' ,
                        '15'  'MAR'           'IT_FINAL'  MAR_UN                    '18'  'C310' ,
                        '16'  'APR'           'IT_FINAL'  APR_UN                    '18'  'C110' ,
                        '17'  'MAY'           'IT_FINAL'  MAY_UN                    '18'  'C310' ,
                        '18'  'JUN'           'IT_FINAL'  JUN_UN                    '18'  'C310' ,
                        '19'  'JUL'           'IT_FINAL'  JUL_UN                    '18'  'C310' ,
                        '20'  'AUG'           'IT_FINAL'  AUG_UN                    '18'  'C310' ,
                        '21'  'SEP'           'IT_FINAL'  SEP_UN                    '18'  'C310' ,
                        '22'  'OCT'           'IT_FINAL'  OCT_UN                    '18'  'C310' ,
                        '23'  'NOV'           'IT_FINAL'  NOV_UN                    '18'  'C310' ,
                        '24'  'DEC'           'IT_FINAL'  DEC_UN                    '18'  'C310' ,
                        '25'  'SALE_TOT'      'IT_FINAL'  'Sales Total'             '18'  'C710' ,

*---------------------Sales Pricing -----------------------------------------------*
                        '26'  'JAN_PR'           'IT_FINAL'  JAN_PR     '18' 'C510',
                        '27'  'FEB_PR'           'IT_FINAL'  FEB_PR     '18' 'C510',
                        '28'  'MAR_PR'           'IT_FINAL'  MAR_PR     '18' 'C510',
                        '29'  'APR_PR'           'IT_FINAL'  APR_PR     '18' 'C510',
                        '30'  'MAY_PR'           'IT_FINAL'  MAY_PR     '18' 'C510',
                        '31'  'JUN_PR'           'IT_FINAL'  JUN_PR     '18' 'C510',
                        '32'  'JUL_PR'           'IT_FINAL'  JUL_PR     '18' 'C510',
                        '33'  'AUG_PR'           'IT_FINAL'  AUG_PR     '18' 'C510',
                        '34'  'SEP_PR'           'IT_FINAL'  SEP_PR     '18' 'C510',
                        '35'  'OCT_PR'           'IT_FINAL'  OCT_PR     '18' 'C510',
                        '36'  'NOV_PR'           'IT_FINAL'  NOV_PR     '18' 'C510',
                        '37'  'DEC_PR'           'IT_FINAL'  DEC_PR     '18' 'C510',

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
*&---------------------------------------------------------------------*
*&      Form  COL_HEADING
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM COL_HEADING .
CONCATENATE 'Units Sold JAN'    JAN_year INTO JAN_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold FEB'  FEB_year INTO FEB_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold MAR'  MAR_year INTO MAR_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold APR'  APR_year INTO APR_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold MAY'  MAY_year INTO MAY_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold JUN'  JUN_year INTO JUN_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold JUL'  JUL_year INTO JUL_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold AUG'  AUG_year INTO AUG_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold SEP'  SEP_year INTO SEP_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold OCT'  OCT_year INTO OCT_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold NOV'  NOV_year INTO NOV_UN SEPARATED BY '/'.
  CONCATENATE 'Units Sold DEC'  DEC_year INTO DEC_UN SEPARATED BY '/'.


  CONCATENATE 'Sales Price($) JAN'   JAN_year INTO JAN_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) FEB'   FEB_year INTO FEB_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) MAR'   MAR_year INTO MAR_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) APR'   APR_year INTO APR_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) MAY'   MAY_year INTO MAY_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) JUN'   JUN_year INTO JUN_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) JUL'   JUL_year INTO JUL_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) AUG'   AUG_year INTO AUG_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) SEP'   SEP_year INTO SEP_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) OCT'   OCT_year INTO OCT_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) NOV'   NOV_year INTO NOV_PR SEPARATED BY '/'.
  CONCATENATE 'Sales Price($) DEC'   DEC_year INTO DEC_PR SEPARATED BY '/'.
ENDFORM.

*&---------------------------------------------------------------------*
*& Report ZUS_CUSTOMER_MASTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_CUSTOMER_MASTER.


TABLES: KNB1.

TYPES: BEGIN OF TY_KNA1,
       KUNNR TYPE KNA1-KUNNR,
       KTOKD TYPE KNA1-KTOKD,
       ANRED TYPE KNA1-ANRED,
       NAME1 TYPE KNA1-NAME1,
       NAME2 TYPE KNA1-NAME2,
       LAND1 TYPE KNA1-LAND1,
       REGIO TYPE KNA1-REGIO,
       TELF2 TYPE KNA1-TELF2,
       ADRNR TYPE KNA1-ADRNR,
       STCD3 TYPE KNA1-STCD3,

       MCOD3 TYPE KNA1-MCOD3,
       PFACH TYPE KNA1-PFACH,
       PFORT TYPE KNA1-PFORT,
       PSTL2 TYPE KNA1-PSTL2,
       SPRAS TYPE KNA1-SPRAS,
       BRSCH TYPE KNA1-BRSCH,
       ERDAT TYPE KNA1-ERDAT,
       ernam type kna1-ernam,
       END OF TY_KNA1,

       BEGIN OF TY_KNB1,
       KUNNR TYPE KNB1-KUNNR,
       BUKRS TYPE KNB1-BUKRS,
       AKONT TYPE KNB1-AKONT,
       ZUAWA TYPE KNB1-ZUAWA,
       ZTERM TYPE KNB1-ZTERM,
       XVERR TYPE KNB1-XVERR,
       ZWELS TYPE KNB1-ZWELS,
       KNRZB TYPE KNB1-KNRZB,
       HBKID TYPE KNB1-HBKID,
       ALTKN TYPE KNB1-ALTKN,
       END OF TY_KNB1,

       BEGIN OF TY_KNVV,
       KUNNR TYPE KNVV-KUNNR,
       VKORG TYPE KNVV-VKORG,
       VTWEG TYPE KNVV-VTWEG,
       SPART TYPE KNVV-SPART,
       VKBUR TYPE KNVV-VKBUR,
       KDGRP TYPE KNVV-KDGRP,
       WAERS TYPE KNVV-WAERS,
       KALKS TYPE KNVV-KALKS,
       VERSG TYPE KNVV-VERSG,
       KVGR1 TYPE KNVV-KVGR1,
       LPRIO TYPE KNVV-LPRIO,
       VSBED TYPE KNVV-VSBED,
       VWERK TYPE KNVV-VWERK,
       INCO1 TYPE KNVV-INCO1,
       INCO2 TYPE KNVV-INCO2,
       ZTERM TYPE KNVV-ZTERM,
       KTGRD TYPE KNVV-KTGRD,

       BZIRK TYPE KNVV-BZIRK,
       AWAHR TYPE KNVV-AWAHR,
       VKGRP TYPE KNVV-VKGRP,
       KZAZU TYPE KNVV-KZAZU,
       ANTLF TYPE KNVV-ANTLF,

       END OF TY_KNVV,

       BEGIN OF TY_KNVT,
       KUNNR TYPE knvv-KUNNR,
       VKORG TYPE knvv-VKORG,
       VTWEG TYPE knvv-VTWEG,
       SPART TYPE knvv-SPART,
       END OF TY_KNVT,

       BEGIN OF TY_TINCT,
       SPRAS TYPE TINCT-SPRAS,
       INCO1 TYPE TINCT-INCO1,
       BEZEI TYPE TINCT-BEZEI,
       END OF TY_TINCT,

       BEGIN OF TY_ADRC,
       ADDRNUMBER TYPE ADRC-ADDRNUMBER,
       NAME1      TYPE ADRC-NAME1,
       NAME2      TYPE ADRC-NAME2,
       NAME3      TYPE ADRC-NAME3,
       SORT1      TYPE ADRC-SORT1,
       STREET     TYPE ADRC-STREET,
       HOUSE_NUM1 TYPE ADRC-HOUSE_NUM1,
       POST_CODE1 TYPE ADRC-POST_CODE1,
       CITY1      TYPE ADRC-CITY1,
       CITY2      TYPE ADRC-CITY2,
       COUNTRY    TYPE ADRC-COUNTRY,
       REGION     TYPE ADRC-REGION,
       LANGU      TYPE ADRC-LANGU,
       TEL_NUMBER TYPE ADRC-TEL_NUMBER,
       FAX_NUMBER TYPE ADRC-FAX_NUMBER,
       STR_SUPPL1 TYPE ADRC-STR_SUPPL1,
       STR_SUPPL2 TYPE ADRC-STR_SUPPL2,
       STR_SUPPL3 TYPE ADRC-STR_SUPPL3,
       END OF TY_ADRC,

       BEGIN OF TY_ADR6,
       ADDRNUMBER TYPE ADR6-ADDRNUMBER,
       CONSNUMBER TYPE ADR6-CONSNUMBER,
       SMTP_ADDR  TYPE ADR6-SMTP_ADDR,
       SMTP_SRCH  TYPE ADR6-SMTP_SRCH,
       END OF TY_ADR6,

       BEGIN OF TY_KNVI,
       KUNNR TYPE KNVI-KUNNR,
       TATYP TYPE KNVI-TATYP,
       TAXKD TYPE KNVI-TAXKD,
       END OF TY_KNVI,

*       BEGIN OF TY_KNVP,
*       KUNNR TYPE KNVP-KUNNR,
*       PARVW TYPE KNVP-PARVW,
*       END OF TY_KNVP,

         BEGIN OF ty_knvp,
         kunnr TYPE knvp-kunnr,
         vkorg TYPE knvp-vkorg,
         vtweg TYPE knvp-vtweg,
         spart TYPE knvp-spart,
         parvw TYPE knvp-parvw,
         parza TYPE knvp-parza,
         kunn2 TYPE knvp-kunn2,
         END OF ty_knvp,

       BEGIN OF TY_KNVK,
       KUNNR TYPE KNVK-KUNNR,
       NAME1 TYPE KNVK-NAME1,
       NAMEV TYPE KNVK-NAMEV,
       END OF TY_KNVK,

       BEGIN OF TY_KNKK, "PJ ON 13-08-21
       KUNNR TYPE KNKK-KUNNR,
       KLIMK TYPE KNKK-KLIMK,
       END OF TY_KNKK,

       BEGIN OF TY_T005U,
       SPRAS TYPE T005U-SPRAS,
       LAND1 TYPE T005U-LAND1,
       BLAND TYPE T005U-BLAND,
       BEZEI TYPE T005U-BEZEI,
       END OF TY_T005U,

       BEGIN OF TY_TZUNT,
       ZUAWA  TYPE TZUNT-ZUAWA,
       TTEXT  TYPE TZUNT-TTEXT,
       END OF TY_TZUNT,

       BEGIN OF TY_TVZBT,
       SPRAS  TYPE TVZBT-SPRAS,
       ZTERM  TYPE TVZBT-ZTERM,
       VTEXT  TYPE TVZBT-VTEXT,
       END OF TY_TVZBT,

       BEGIN OF TY_T005T,
       SPRAS TYPE T005T-SPRAS,
       LAND1 TYPE T005T-LAND1,
       LANDX TYPE T005T-LANDX,
       END OF TY_T005T,

       BEGIN OF TY_J_1IMOCUST,
       KUNNR      TYPE J_1IMOCUST-KUNNR,
       J_1IEXCD   TYPE J_1IMOCUST-J_1IEXCD,
       J_1IEXRN   TYPE J_1IMOCUST-J_1IEXRN,
       J_1IEXRG   TYPE J_1IMOCUST-J_1IEXRG,
       J_1IEXDI   TYPE J_1IMOCUST-J_1IEXDI,
       J_1IEXCO   TYPE J_1IMOCUST-J_1IEXCO,
       J_1IEXCICU TYPE J_1IMOCUST-J_1IEXCICU,
       J_1ICSTNO  TYPE J_1IMOCUST-J_1ICSTNO,
       J_1ISERN   TYPE J_1IMOCUST-J_1ISERN,
       J_1ILSTNO  TYPE J_1IMOCUST-J_1ILSTNO,
       J_1IPANNO  TYPE J_1IMOCUST-J_1IPANNO,
       J_1IPANREF TYPE J_1IMOCUST-J_1IPANREF,
       END OF TY_J_1IMOCUST,
*****************added by jyoti on 04.12.2024**************
       BEGIN OF ty_a900,"ucou
      KAPPL type a900-KAPPL,
      KSCHL type a900-KSCHL,
      KUNNR type a900-KUNNR,
      TAXK1 type a900-TAXK1,
      KNUMH type a900-KNUMH,
       end of ty_a900,

      BEGIN OF ty_a901,  "uloc
       KAPPL type a901-KAPPL,
       KSCHL type a901-KSCHL,
       KUNNR type a901-KUNNR,
       TAXK2 type a901-TAXK2,
       KNUMH type a901-KNUMH,
        end of ty_a901,

      BEGIN OF ty_a902,   "usta
       KAPPL type a902-KAPPL,
       KSCHL type a902-KSCHL,
       KUNNR type a902-KUNNR,
       TAXK3 type a902-TAXK3,
       KNUMH type a902-KNUMH,
        end of ty_a902,

      BEGIN OF ty_a903,
       KAPPL type a903-KAPPL,  "uoth
       KSCHL type a903-KSCHL,
       KUNNR type a903-KUNNR,
       TAXK4 type a903-TAXK4,
       KNUMH type a903-KNUMH,
        end of ty_a903,

       BEGIN OF ty_konp_UCOU,
      KNUMH type konp-KNUMH,
      kbetr  TYPE konp-kbetr,
      konwa  TYPE konp-konwa,
       END OF ty_konp_UCOU,

        BEGIN OF ty_konp_Usta,
      KNUMH type konp-KNUMH,
      kbetr  TYPE konp-kbetr,
      konwa  TYPE konp-konwa,
       END OF ty_konp_Usta,

        BEGIN OF ty_konp_Uoth,
      KNUMH type konp-KNUMH,
      kbetr  TYPE konp-kbetr,
      konwa  TYPE konp-konwa,
       END OF ty_konp_Uoth,

         BEGIN OF ty_konp_Uloc,
      KNUMH type konp-KNUMH,
      kbetr  TYPE konp-kbetr,
      konwa  TYPE konp-konwa,
       END OF ty_konp_Uloc,
* ***************************************************


       BEGIN OF TY_FINAL,
       KTOKD        TYPE KNA1-KTOKD,
       KUNNR        TYPE KNA1-KUNNR,
       BUKRS        TYPE KNB1-BUKRS,
       VKORG        TYPE knvv-VKORG,
       VTWEG        TYPE knvv-VTWEG,
       SPART        TYPE knvv-SPART,
       ANRED        TYPE KNA1-ANRED,
       NAME1        TYPE ADRC-NAME1,
       NAME2        TYPE ADRC-NAME2,
       NAME3        TYPE ADRC-NAME3,
       SORT1        TYPE ADRC-SORT1,
       STREET       TYPE ADRC-STREET,
       HOUSE_NUM1   TYPE ADRC-HOUSE_NUM1,
       STR_SUPPL1   TYPE ADRC-STR_SUPPL1,
       STR_SUPPL2   TYPE ADRC-STR_SUPPL2,
       STR_SUPPL3   TYPE ADRC-STR_SUPPL3,
       POST_CODE1   TYPE ADRC-POST_CODE1,
       CITY1        TYPE ADRC-CITY1,
       CITY2        TYPE ADRC-CITY2,
       COUNTRY      TYPE ADRC-COUNTRY,
       LANDX        TYPE T005T-LANDX,
       REGIO        TYPE KNA1-REGIO,
       REGION       TYPE ADRC-REGION,
       BEZEI        TYPE T005U-BEZEI,
       LANGU        TYPE ADRC-LANGU,
       TEL_NUMBER   TYPE ADRC-TEL_NUMBER,
       TELF2        TYPE KNA1-TELF1,
       FAX_NUMBER   TYPE ADRC-FAX_NUMBER,
       SMTP_ADDR    TYPE ADR6-SMTP_ADDR,
       AKONT        TYPE KNB1-AKONT,
       ZUAWA        TYPE KNB1-ZUAWA,
       TTEXT        TYPE TZUNT-TTEXT,
    FI_ZTERM        TYPE KNB1-ZTERM,
    FI_VTEXT        TYPE TVZBT-VTEXT,
       XVERR        TYPE KNB1-XVERR,
       ZWELS        TYPE KNB1-ZWELS,
       KNRZB        TYPE KNB1-KNRZB,
       HBKID        TYPE KNB1-HBKID,
       VKBUR        TYPE KNVV-VKBUR,
       KDGRP        TYPE KNVV-KDGRP,
       WAERS        TYPE KNVV-WAERS,
       KALKS        TYPE KNVV-KALKS,
       VERSG        TYPE KNVV-VERSG,
       KVGR1        TYPE KNVV-KVGR1,
       LPRIO        TYPE KNVV-LPRIO,
       VSBED        TYPE KNVV-VSBED,
       VWERK        TYPE KNVV-VWERK,
       INCO1        TYPE KNVV-INCO1,
       INCO_TEXT    TYPE TINCT-BEZEI,
       INCO2        TYPE KNVV-INCO2,
       ZTERM        TYPE KNVV-ZTERM,
       VTEXT        TYPE TVZBT-VTEXT,
       KTGRD        TYPE KNVV-KTGRD,
       UCOU         TYPE KNVI-TAXKD,
       ULOC         TYPE KNVI-TAXKD,
       USTA         TYPE KNVI-TAXKD,
       UOTH         TYPE KNVI-TAXKD,

*       kunnr        TYPE knvp-kunnr,
*       vkorg        TYPE knvp-vkorg,
*       vtweg        TYPE knvp-vtweg,
*       spart        TYPE knvp-spart,
       parvw        TYPE knvp-parvw,
       parza        TYPE knvp-parza,
       kunn2        TYPE knvp-kunn2,

*       PARVW        TYPE KNVP-PARVW,
       J_1IEXCD     TYPE J_1IMOCUST-J_1IEXCD,
       J_1IEXRN     TYPE J_1IMOCUST-J_1IEXRN,
       J_1IEXRG     TYPE J_1IMOCUST-J_1IEXRG,
       J_1IEXDI     TYPE J_1IMOCUST-J_1IEXDI,
       J_1IEXCO     TYPE J_1IMOCUST-J_1IEXCO,
       J_1IEXCICU   TYPE J_1IMOCUST-J_1IEXCICU,
       J_1ICSTNO    TYPE J_1IMOCUST-J_1ICSTNO,
       J_1ISERN     TYPE J_1IMOCUST-J_1ISERN,
       J_1ILSTNO    TYPE J_1IMOCUST-J_1ILSTNO,
       J_1IPANNO    TYPE J_1IMOCUST-J_1IPANNO,
       J_1IPANREF   TYPE J_1IMOCUST-J_1IPANREF,
       STCD3        TYPE KNA1-STCD3,
       kunn2_ag     TYPE knvp-kunn2,
       kunn2_re     TYPE knvp-kunn2,
       kunn2_rg     TYPE knvp-kunn2,
       kunn2_we     TYPE knvp-kunn2,

       MCOD3        TYPE KNA1-MCOD3,
       PFACH        TYPE KNA1-PFACH,
       PFORT        TYPE KNA1-PFORT,
       PSTL2        TYPE KNA1-PSTL2,
       SPRAS        TYPE KNA1-SPRAS,
       BRSCH        TYPE KNA1-BRSCH,

       CON_PER      TYPE KNVK-NAME1,
       NAMEV        TYPE KNVK-NAMEV,

       ALTKN        TYPE KNB1-ALTKN,


       BZIRK        TYPE KNVV-BZIRK,
       AWAHR        TYPE KNVV-AWAHR,
       VKGRP        TYPE KNVV-VKGRP,
       KZAZU        TYPE KNVV-KZAZU,
       ANTLF        TYPE KNVV-ANTLF,
       tax          TYPE KNVI-TAXKD,
       ERDAT        TYPE KNA1-ERDAT,
       text         TYPE char20,
       SMTP_ADDR1   TYPE ADR6-SMTP_ADDR,
       SMTP_ADDR2   TYPE ADR6-SMTP_ADDR,
       SMTP_ADDR3   TYPE ADR6-SMTP_ADDR,
       SMTP_ADDR4   TYPE ADR6-SMTP_ADDR,
       SMTP_ADDR5   TYPE ADR6-SMTP_ADDR,
       KLIMK        TYPE knKK-KLIMK,"PJ
       ernam        type kna1-ernam,
       UCOU_PERC    TYPE KONP-KBETR,"ADDED BY JYOTI ON 05.12.2024
       ULOC_PERC    TYPE KONP-KBETR,"ADDED BY JYOTI ON 05.12.2024
       USTA_PERC    TYPE KONP-KBETR,"ADDED BY JYOTI ON 05.12.2024
       UOTH_PERC    TYPE KONP-KBETR,"ADDED BY JYOTI ON 05.12.2024



       END OF TY_FINAL.

************************************************Dowanlod Str***************
TYPES :   BEGIN OF ITAB,
          KUNNR             TYPE CHAR15,
          BUKRS             TYPE CHAR10,
          VKORG             TYPE CHAR10,
          VTWEG             TYPE CHAR10,
          SPART             TYPE CHAR10,
          KTOKD             TYPE CHAR10,
          ANRED             TYPE CHAR20,
          NAME1             TYPE CHAR50,
          SORT1             TYPE CHAR30,
          NAME2             TYPE CHAR50,
          NAME3             TYPE CHAR50,
          STREET            TYPE CHAR50,
          PFACH             TYPE char10,
          CITY1             TYPE CHAR50,
          POST_CODE1        TYPE CHAR15,
          CITY2             TYPE CHAR50,
          PFORT             TYPE CHAR35,
          PSTL2             TYPE CHAR10,
          LANDX             TYPE CHAR30,
          BEZEI             TYPE CHAR30,
          LANGU             TYPE CHAR30,
          TEL_NUMBER        TYPE CHAR30,
          FAX_NUMBER        TYPE CHAR30,
          BRSCH             TYPE char04,
          CON_PER           TYPE CHAR35,
          NAMEV             TYPE CHAR35,
          AKONT             TYPE CHAR30,
          ALTKN             TYPE char10,
          BZIRK             TYPE char10,
          AWAHR             TYPE char03,
          VKBUR             TYPE CHAR30,
          VKGRP             TYPE char03,
          KDGRP             TYPE CHAR30,
          WAERS             TYPE CHAR20,
          KALKS             TYPE CHAR20,
          VERSG             TYPE CHAR20,
          LPRIO             TYPE CHAR20,
          KZAZU             TYPE char01,
          VSBED             TYPE CHAR20,
          VWERK             TYPE CHAR20,
          ANTLF             TYPE char01,
          INCO1             TYPE CHAR20,
          INCO_TEXT         TYPE CHAR50,
          INCO2             TYPE CHAR20,
          ZTERM             TYPE CHAR50,
          VTEXT             TYPE CHAR50,
          KTGRD             TYPE CHAR20,
          UCOU              TYPE CHAR10,
          ULOC              TYPE CHAR10,
          USTA              TYPE CHAR10,
          REF               TYPE char15,
          tax               TYPE char1,
          ERDAT             TYPE char11,
          text              TYPE char20,
          UOTH              TYPE CHAR10,
          SMTP_ADDR         TYPE char100,
          SMTP_ADDR1   TYPE ADR6-SMTP_ADDR,
          SMTP_ADDR2   TYPE ADR6-SMTP_ADDR,
          SMTP_ADDR3   TYPE ADR6-SMTP_ADDR,
          SMTP_ADDR4   TYPE ADR6-SMTP_ADDR,
          SMTP_ADDR5   TYPE ADR6-SMTP_ADDR,
          KLIMK             TYPE string, "PJ
          ernam             TYPE kna1-ernam,
          UCOU_PERC    TYPE STRING, "ADDED BY JYOTI ON 05.12.2024
          ULOC_PERC    TYPE STRING,"ADDED BY JYOTI ON 05.12.2024
          USTA_PERC    TYPE STRING,"ADDED BY JYOTI ON 05.12.2024
          UOTH_PERC    TYPE STRING,"ADDED BY JYOTI ON 05.12.2024
        END OF ITAB.

DATA : LT_FINAL TYPE TABLE OF ITAB,
       LS_FINAL TYPE          ITAB.
************************************************end itab*******************************************
DATA : IT_KNA1 TYPE TABLE OF TY_KNA1,
       WA_KNA1 TYPE          TY_KNA1,

       it_a900 TYPE TABLE OF ty_a900,  "UCOU
       wa_a900 TYPE ty_a900,

        it_a901 TYPE TABLE OF ty_a901,  "ULOC
       wa_a901 TYPE ty_a901,

       it_a902 TYPE TABLE OF ty_a902,  "USTA
       wa_a902 TYPE ty_a902,

        it_a903 TYPE TABLE OF ty_a903,  "UOTH
       wa_a903 TYPE ty_a903,

       IT_KONP_UCOU TYPE TABLE OF TY_KONP_UCOU,
       WA_KONP_UCOU TYPE TY_KONP_UCOU,

       IT_KONP_Uloc TYPE TABLE OF TY_KONP_ULOC,
       WA_KONP_Uloc TYPE TY_KONP_ULOC,

       IT_KONP_USTA TYPE TABLE OF TY_KONP_USTA,
       WA_KONP_USTA TYPE TY_KONP_USTA,

       IT_KONP_UOTH TYPE TABLE OF TY_KONP_UOTH,
       WA_KONP_UOTH TYPE TY_KONP_UOTH,

       IT_KNB1 TYPE TABLE OF TY_KNB1,
       WA_KNB1 TYPE          TY_KNB1,

       IT_KNVV TYPE TABLE OF TY_KNVV,
       WA_KNVV TYPE          TY_KNVV,

       IT_KNVT TYPE TABLE OF TY_KNVT,
       WA_KNVT TYPE          TY_KNVT,

       IT_ADRC TYPE TABLE OF TY_ADRC,
       WA_ADRC TYPE          TY_ADRC,

       IT_ADR6 TYPE TABLE OF TY_ADR6,
       WA_ADR6 TYPE          TY_ADR6,

       IT_TINCT TYPE TABLE OF TY_TINCT,
       WA_TINCT TYPE          TY_TINCT,

       IT_KNVP TYPE TABLE OF TY_KNVP,
       WA_KNVP TYPE          TY_KNVP,

       IT_KNVK TYPE TABLE OF TY_KNVK,
       WA_KNVK TYPE          TY_KNVK,

       IT_KNKK TYPE TABLE OF TY_KNKK, "PJ ON 13-08-21
       WA_KNKK TYPE TY_KNKK,

       IT_KNVI TYPE TABLE OF TY_KNVI,
       WA_KNVI TYPE          TY_KNVI,

       IT_T005U TYPE TABLE OF TY_T005U,
       WA_T005U TYPE          TY_T005U,

       IT_T005T TYPE TABLE OF TY_T005T,
       WA_T005T TYPE          TY_T005T,

       IT_FI_TVZBT TYPE TABLE OF TY_TVZBT,
       WA_FI_TVZBT TYPE          TY_TVZBT,

       IT_TVZBT  TYPE TABLE OF TY_TVZBT,
       WA_TVZBT  TYPE          TY_TVZBT,

       IT_TZUNT TYPE TABLE OF TY_TZUNT,
       WA_TZUNT TYPE          TY_TZUNT,

       IT_J_1IMOCUST TYPE TABLE OF TY_J_1IMOCUST,
       WA_J_1IMOCUST TYPE          TY_J_1IMOCUST,

       IT_FINAL TYPE TABLE OF TY_FINAL,
       WA_FINAL TYPE          TY_FINAL.

DATA: it_fcat type slis_t_fieldcat_alv,
      wa_fcat like line of it_fcat.

SELECTION-SCREEN: BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: S_KUNNR FOR KNB1-KUNNR,
                  S_BUKRS FOR KNB1-BUKRS NO INTERVALS OBLIGATORY DEFAULT 'US00'.
SELECTION-SCREEN: END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-002 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT  '/Delval/USA'."USA'."USA'."usa'.
SELECTION-SCREEN END OF BLOCK B2.

SELECTION-SCREEN :BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
  SELECTION-SCREEN  COMMENT /1(60) TEXT-004.
SELECTION-SCREEN: END OF BLOCK B3.


START-OF-SELECTION.
PERFORM GET_DATA.
PERFORM SORT_DATA.
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
FORM get_data .
SELECT KUNNR
       BUKRS
       AKONT
       ZUAWA
       ZTERM
       XVERR
       ZWELS
       KNRZB
       HBKID
       ALTKN FROM KNB1 INTO TABLE IT_KNB1
       WHERE KUNNR IN S_KUNNR
       AND   BUKRS IN S_BUKRS.

IF IT_KNB1 IS NOT INITIAL.
  SELECT KUNNR
         KTOKD
         ANRED
         NAME1
         NAME2
         LAND1
         REGIO
         TELF2
         ADRNR
         STCD3
         MCOD3
         PFACH
         PFORT
         PSTL2
         SPRAS
         BRSCH
         ERDAT
         ernam FROM KNA1 INTO TABLE IT_KNA1
         FOR ALL ENTRIES IN IT_KNB1
         WHERE KUNNR = IT_KNB1-KUNNR.

   SELECT ZUAWA
          TTEXT FROM TZUNT INTO TABLE IT_TZUNT
          FOR ALL ENTRIES IN IT_KNB1
          WHERE ZUAWA = IT_KNB1-ZUAWA.

   SELECT SPRAS
          ZTERM
          VTEXT FROM TVZBT INTO TABLE IT_FI_TVZBT
          FOR ALL ENTRIES IN IT_KNB1
          WHERE ZTERM = IT_KNB1-ZTERM
          AND   SPRAS = 'E'.

* ******************ADDED BY JYOTIO N 04.12.2024
***************BELOW LOGIC FOR SALES TAX****************
  SELECT KAPPL
         KSCHL
         KUNNR
         TAXK1
         KNUMH
         FROM A900 INTO TABLE IT_A900
         FOR ALL ENTRIES IN IT_KNB1
         WHERE KUNNR  = IT_KNB1-KUNNR
           AND KAPPL = 'V'
           AND KSCHL = 'UCOU'.
*           AND KSCHL IN ('UCOU', 'ULOC', 'UOTH', 'USTA' ).

    SELECT KNUMH
           KBETR
           KONWA
           FROM KONP INTO TABLE IT_KONP_UCOU
           FOR ALL ENTRIES IN IT_A900
         WHERE KNUMH = IT_A900-KNUMH.

      SELECT KAPPL
         KSCHL
         KUNNR
         TAXK2
         KNUMH
         FROM A901 INTO TABLE IT_A901
         FOR ALL ENTRIES IN IT_KNB1
         WHERE KUNNR  = IT_KNB1-KUNNR
           AND KAPPL = 'V'
           AND KSCHL = 'ULOC'.
*           AND KSCHL IN ('UCOU', 'ULOC', 'UOTH', 'USTA' ).

    SELECT KNUMH
           KBETR
           KONWA
           FROM KONP INTO TABLE IT_KONP_ULOC
           FOR ALL ENTRIES IN IT_A901
         WHERE KNUMH = IT_A901-KNUMH.

  SELECT KAPPL
         KSCHL
         KUNNR
         TAXK3
         KNUMH
         FROM A902 INTO TABLE IT_A902
         FOR ALL ENTRIES IN IT_KNB1
         WHERE KUNNR  = IT_KNB1-KUNNR
           AND KAPPL = 'V'
           AND KSCHL = 'USTA'.
*           AND KSCHL IN ('UCOU', 'ULOC', 'UOTH', 'USTA' ).

    SELECT KNUMH
           KBETR
           KONWA
           FROM KONP INTO TABLE IT_KONP_USTA
           FOR ALL ENTRIES IN IT_A902
         WHERE KNUMH = IT_A902-KNUMH.

       SELECT KAPPL
         KSCHL
         KUNNR
         TAXK4
         KNUMH
         FROM A903 INTO TABLE IT_A903
         FOR ALL ENTRIES IN IT_KNB1
         WHERE KUNNR  = IT_KNB1-KUNNR
           AND KAPPL = 'V'
           AND KSCHL = 'UOTH'.
*           AND KSCHL IN ('UCOU', 'ULOC', 'UOTH', 'USTA' ).

    SELECT KNUMH
           KBETR
           KONWA
           FROM KONP INTO TABLE IT_KONP_UOTH
           FOR ALL ENTRIES IN IT_A903
         WHERE KNUMH = IT_A903-KNUMH.

****************************************************************
ENDIF.

IF IT_KNA1 IS NOT INITIAL.
  SELECT KUNNR
         VKORG
         VTWEG
         SPART
         VKBUR
         KDGRP
         WAERS
         KALKS
         VERSG
         KVGR1
         LPRIO
         VSBED
         VWERK
         INCO1
         INCO2
         ZTERM
         KTGRD
         BZIRK
         AWAHR
         VKGRP
         KZAZU
         ANTLF
         FROM KNVV INTO TABLE IT_KNVV
         FOR ALL ENTRIES IN IT_KNA1
         WHERE KUNNR = IT_KNA1-KUNNR.

  SELECT KUNNR
         VKORG
         VTWEG
         SPART FROM knvv INTO TABLE IT_KNVT
         FOR ALL ENTRIES IN IT_KNA1
         WHERE KUNNR = IT_KNA1-KUNNR.

  SELECT ADDRNUMBER
         NAME1
         NAME2
         NAME3
         SORT1
         STREET
         HOUSE_NUM1
         POST_CODE1
         CITY1
         CITY2
         COUNTRY
         REGION
         LANGU
         TEL_NUMBER
         FAX_NUMBER
         STR_SUPPL1
         STR_SUPPL2
         STR_SUPPL3 FROM ADRC INTO TABLE IT_ADRC
         FOR ALL ENTRIES IN IT_KNA1
         WHERE ADDRNUMBER = IT_KNA1-ADRNR.

   SELECT KUNNR
          TATYP
          TAXKD FROM KNVI INTO TABLE IT_KNVI
          FOR ALL ENTRIES IN IT_KNA1
          WHERE KUNNR = IT_KNA1-KUNNR.

  SELECT kunnr
         vkorg
         vtweg
         spart
         parvw
         parza
         kunn2
         FROM KNVP INTO TABLE IT_KNVP
         FOR ALL ENTRIES IN IT_KNA1
         WHERE KUNNR = IT_KNA1-KUNNR.

   SELECT KUNNR
          NAME1
          NAMEV FROM KNVK INTO TABLE IT_KNVK
          FOR ALL ENTRIES IN IT_KNA1
          WHERE KUNNR = IT_KNA1-KUNNR.

  SELECT KUNNR
         J_1IEXCD
         J_1IEXRN
         J_1IEXRG
         J_1IEXDI
         J_1IEXCO
         J_1IEXCICU
         J_1ICSTNO
         J_1ISERN
         J_1ILSTNO
         J_1IPANNO
         J_1IPANREF  FROM J_1IMOCUST INTO TABLE IT_J_1IMOCUST
         FOR ALL ENTRIES IN IT_KNA1
         WHERE KUNNR = IT_KNA1-KUNNR.
************************PJ ON 13-08-21********************************

    SELECT KUNNR KLIMK FROM KNKK INTO TABLE IT_KNKK
      FOR ALL ENTRIES IN IT_KNA1
      WHERE KUNNR = IT_KNA1-KUNNR.

********************************************************


ENDIF.

IF IT_KNVV IS NOT INITIAL.
  SELECT SPRAS
           INCO1
           BEZEI FROM TINCT INTO TABLE IT_TINCT
           FOR ALL ENTRIES IN IT_KNVV
           WHERE INCO1 = IT_KNVV-INCO1
           AND   SPRAS = 'E'.

  SELECT SPRAS
          ZTERM
          VTEXT FROM TVZBT INTO TABLE IT_TVZBT
          FOR ALL ENTRIES IN IT_KNVV
          WHERE ZTERM = IT_KNVV-ZTERM
          AND   SPRAS = 'E'.
ENDIF.

IF IT_ADRC IS NOT INITIAL.

  SELECT ADDRNUMBER
         CONSNUMBER
         SMTP_ADDR
         SMTP_SRCH FROM ADR6 INTO TABLE IT_ADR6
         FOR ALL ENTRIES IN IT_ADRC
         WHERE ADDRNUMBER = IT_ADRC-ADDRNUMBER.

  SELECT SPRAS
           LAND1
           BLAND
           BEZEI FROM T005U INTO TABLE IT_T005U
           FOR ALL ENTRIES IN IT_ADRC
           WHERE SPRAS = IT_ADRC-LANGU
           AND   LAND1 = IT_ADRC-COUNTRY
           AND   BLAND = IT_ADRC-REGION.

  SELECT SPRAS
         LAND1
         LANDX FROM T005T INTO TABLE IT_T005T
         FOR ALL ENTRIES IN IT_ADRC
         WHERE SPRAS = IT_ADRC-LANGU
         AND   LAND1 = IT_ADRC-COUNTRY.
ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SORT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM sort_data .
*  BREAK PRIMUS.
LOOP AT IT_KNA1 INTO WA_KNA1.
  WA_FINAL-KUNNR   =   WA_KNA1-KUNNR.


  WA_FINAL-KTOKD   =   WA_KNA1-KTOKD.
  WA_FINAL-ANRED   =   WA_KNA1-ANRED.
*  WA_FINAL-LAND1   =   WA_KNA1-LAND1.
  WA_FINAL-REGIO   =   WA_KNA1-REGIO.
  WA_FINAL-TELF2   =   WA_KNA1-TELF2.
  WA_FINAL-STCD3   =   WA_KNA1-STCD3.

  WA_FINAL-MCOD3   =   WA_KNA1-MCOD3.
  WA_FINAL-PFACH   =   WA_KNA1-PFACH.
  WA_FINAL-PFORT   =   WA_KNA1-PFORT.
  WA_FINAL-PSTL2   =   WA_KNA1-PSTL2.
  WA_FINAL-SPRAS   =   WA_KNA1-SPRAS.
  WA_FINAL-BRSCH   =   WA_KNA1-BRSCH.
  WA_FINAL-ERDAT   =   WA_KNA1-ERDAT.
  WA_FINAL-ernam   =  wa_kna1-ernam.

SELECT SINGLE BRTXT INTO wa_final-text FROM t016t WHERE spras = 'E' AND BRSCH = wa_final-BRSCH.

READ TABLE IT_KNB1 INTO WA_KNB1 WITH KEY KUNNR = WA_KNA1-KUNNR.
  IF SY-SUBRC = 0.
    WA_FINAL-BUKRS      = WA_KNB1-BUKRS.
    WA_FINAL-AKONT      = WA_KNB1-AKONT.
    WA_FINAL-ZUAWA      = WA_KNB1-ZUAWA.
    WA_FINAL-FI_ZTERM   = WA_KNB1-ZTERM.
    WA_FINAL-XVERR      = WA_KNB1-XVERR.
    WA_FINAL-ZWELS      = WA_KNB1-ZWELS.
    WA_FINAL-KNRZB      = WA_KNB1-KNRZB.
    WA_FINAL-HBKID      = WA_KNB1-HBKID.
    WA_FINAL-ALTKN      = WA_KNB1-ALTKN.
  ENDIF.

READ TABLE IT_TZUNT INTO WA_TZUNT WITH KEY ZUAWA = WA_KNB1-ZUAWA.
  IF SY-SUBRC = 0.
    WA_FINAL-TTEXT = WA_TZUNT-TTEXT.

  ENDIF.

READ TABLE IT_KNVV INTO WA_KNVV WITH KEY KUNNR = WA_KNA1-KUNNR.
  IF SY-SUBRC = 0.
    WA_FINAL-VKBUR   = WA_KNVV-VKBUR.
    WA_FINAL-VKORG   = WA_KNVV-VKORG.
    WA_FINAL-VTWEG   = WA_KNVV-VTWEG.
    WA_FINAL-SPART   = WA_KNVV-SPART.
    WA_FINAL-KDGRP   = WA_KNVV-KDGRP.
    WA_FINAL-WAERS   = WA_KNVV-WAERS.
    WA_FINAL-KALKS   = WA_KNVV-KALKS.
    WA_FINAL-VERSG   = WA_KNVV-VERSG.
    WA_FINAL-KVGR1   = WA_KNVV-KVGR1.
    WA_FINAL-LPRIO   = WA_KNVV-LPRIO.
    WA_FINAL-VSBED   = WA_KNVV-VSBED.
    WA_FINAL-VWERK   = WA_KNVV-VWERK.
    WA_FINAL-INCO1   = WA_KNVV-INCO1.
    WA_FINAL-INCO2   = WA_KNVV-INCO2.
    WA_FINAL-ZTERM   = WA_KNVV-ZTERM.
    WA_FINAL-KTGRD   = WA_KNVV-KTGRD.

    WA_FINAL-BZIRK   = WA_KNVV-BZIRK.
    WA_FINAL-AWAHR   = WA_KNVV-AWAHR.
    WA_FINAL-VKGRP   = WA_KNVV-VKGRP.
    WA_FINAL-KZAZU   = WA_KNVV-KZAZU.
    WA_FINAL-ANTLF   = WA_KNVV-ANTLF.

  ENDIF.

READ TABLE IT_TINCT INTO WA_TINCT WITH KEY INCO1 = WA_KNVV-INCO1
                                           SPRAS = 'E'.
  IF SY-SUBRC = 0.
    WA_FINAL-INCO_TEXT  =   WA_TINCT-BEZEI.

  ENDIF.

READ TABLE it_knvk INTO wa_knvk WITH KEY kunnr = wa_kna1-kunnr.
IF sy-subrc = 0.
  wa_final-con_per = wa_knvk-name1.
  wa_final-namev   = wa_knvk-namev.

ENDIF.

READ TABLE IT_ADRC INTO WA_ADRC WITH KEY ADDRNUMBER = WA_KNA1-ADRNR.
  IF SY-SUBRC = 0.
    WA_FINAL-NAME1       = WA_ADRC-NAME1     .
    WA_FINAL-NAME2       = WA_ADRC-NAME2     .
    WA_FINAL-NAME3       = WA_ADRC-NAME3     .
    WA_FINAL-SORT1       = WA_ADRC-SORT1     .
    WA_FINAL-STREET      = WA_ADRC-STREET    .
    WA_FINAL-HOUSE_NUM1  = WA_ADRC-HOUSE_NUM1.
    WA_FINAL-POST_CODE1  = WA_ADRC-POST_CODE1.
    WA_FINAL-CITY1       = WA_ADRC-CITY1     .
    WA_FINAL-CITY2       = WA_ADRC-CITY2     .
    WA_FINAL-COUNTRY     = WA_ADRC-COUNTRY   .
    WA_FINAL-REGION      = WA_ADRC-REGION    .
    WA_FINAL-LANGU       = WA_ADRC-LANGU     .
    WA_FINAL-TEL_NUMBER  = WA_ADRC-TEL_NUMBER.
    WA_FINAL-FAX_NUMBER  = WA_ADRC-FAX_NUMBER.
    WA_FINAL-STR_SUPPL1  = WA_ADRC-STR_SUPPL1.
    WA_FINAL-STR_SUPPL2  = WA_ADRC-STR_SUPPL2.
    WA_FINAL-STR_SUPPL3  = WA_ADRC-STR_SUPPL3.

  ENDIF.

LOOP AT IT_KNVI INTO WA_KNVI WHERE KUNNR = WA_KNA1-KUNNR.
  CASE WA_KNVI-TATYP.
    WHEN 'UCOU'.
      WA_FINAL-UCOU = WA_KNVI-TAXKD.
    WHEN 'ULOC'.
      WA_FINAL-ULOC = WA_KNVI-TAXKD.
    WHEN 'USTA'.
      WA_FINAL-USTA = WA_KNVI-TAXKD.
    WHEN 'UOTH'.
      WA_FINAL-UOTH = WA_KNVI-TAXKD.
  ENDCASE.

ENDLOOP.
CLEAR WA_KNVI.
*************************ADDED BY JYOTI ON 05.12.2024***************************
READ TABLE IT_A900 INTO WA_A900 WITH KEY KUNNR = WA_KNA1-KUNNR.
IF SY-SUBRC IS INITIAL.
  READ TABLE IT_KONP_UCOU INTO WA_KONP_UCOU WITH KEY KNUMH = WA_A900-KNUMH.
  IF SY-SUBRC IS INITIAL.
     WA_FINAL-UCOU_PERC =  WA_KONP_UCOU-KBETR / 10 .
  ENDIF.
ENDIF.
READ TABLE IT_A901 INTO WA_A901 WITH KEY KUNNR = WA_KNA1-KUNNR.
IF SY-SUBRC IS INITIAL.
  READ TABLE IT_KONP_ULOC INTO WA_KONP_ULOC WITH KEY KNUMH = WA_A901-KNUMH.
  IF SY-SUBRC IS INITIAL.
     WA_FINAL-ULOC_PERC =  WA_KONP_ULOC-KBETR / 10 .
  ENDIF.
ENDIF.
READ TABLE IT_A902 INTO WA_A902 WITH KEY KUNNR = WA_KNA1-KUNNR.
IF SY-SUBRC IS INITIAL.
  READ TABLE IT_KONP_USTA INTO WA_KONP_USTA WITH KEY KNUMH = WA_A902-KNUMH.
  IF SY-SUBRC IS INITIAL.
     WA_FINAL-USTA_PERC =  WA_KONP_USTA-KBETR / 10 .
  ENDIF.
ENDIF.
READ TABLE IT_A903 INTO WA_A903 WITH KEY KUNNR = WA_KNA1-KUNNR.
IF SY-SUBRC IS INITIAL.
  READ TABLE IT_KONP_UOTH INTO WA_KONP_UOTH WITH KEY KNUMH = WA_A903-KNUMH.
  IF SY-SUBRC IS INITIAL.
     WA_FINAL-UOTH_PERC =  WA_KONP_UOTH-KBETR / 10 .
  ENDIF.
ENDIF.
***********************************************************************8

READ TABLE IT_KNVI INTO WA_KNVI WITH KEY KUNNR = WA_KNA1-KUNNR TAXKD = '1'.
IF sy-subrc = 0.
  wa_final-tax = 'X'.
ENDIF.

*READ TABLE it_knvp INTO wa_knvp WITH KEY KUNNR = wa_KNA1-KUNNR.              " add subodh 19 feb 2018
*if wa_knvp-parvw = 'AG'.
*wa_final-kunn2_ag = wa_knvp-kunn2.
*ELSEIF wa_knvp-parvw = 'RE'.
*wa_final-kunn2_re = wa_knvp-kunn2.
*ELSEIF wa_knvp-parvw = 'RG'.
*wa_final-kunn2_rg = wa_knvp-kunn2.
*ELSEIF wa_knvp-parvw = 'WE'.
*wa_final-kunn2_we = wa_knvp-kunn2.
*ENDIF.

LOOP AT it_knvp INTO wa_knvp WHERE KUNNR = wa_KNA1-KUNNR.

CASE wa_knvp-parvw.
  WHEN 'AG'.
    wa_final-kunn2_ag = wa_knvp-kunn2.
  WHEN 'RE'.
    wa_final-kunn2_re = wa_knvp-kunn2.
  WHEN 'RG'.
    wa_final-kunn2_rg = wa_knvp-kunn2.
  WHEN 'WE'.
    wa_final-kunn2_we = wa_knvp-kunn2.
ENDCASE.
ENDLOOP.




READ TABLE IT_T005U INTO WA_T005U WITH KEY SPRAS = WA_ADRC-LANGU
                                           LAND1 = WA_ADRC-COUNTRY
                                           BLAND = WA_ADRC-REGION.
  IF SY-SUBRC = 0.
    WA_FINAL-BEZEI   =  WA_T005U-BEZEI.

  ENDIF.

READ TABLE IT_T005T INTO WA_T005T WITH KEY SPRAS = WA_ADRC-LANGU
                                           LAND1 = WA_ADRC-COUNTRY.
IF SY-SUBRC = 0.
  WA_FINAL-LANDX  =    WA_T005T-LANDX.

ENDIF.

READ TABLE IT_FI_TVZBT INTO WA_FI_TVZBT WITH KEY ZTERM = WA_KNB1-ZTERM
                                                 SPRAS = 'E'.
IF SY-SUBRC = 0.
  WA_FINAL-FI_VTEXT   = WA_FI_TVZBT-VTEXT.

ENDIF.


READ TABLE IT_TVZBT INTO WA_TVZBT WITH KEY ZTERM = WA_KNVV-ZTERM
                                                 SPRAS = 'E'.
IF SY-SUBRC = 0.
  WA_FINAL-VTEXT   = WA_TVZBT-VTEXT.

ENDIF.




*READ TABLE IT_ADR6 INTO WA_ADR6 WITH KEY ADDRNUMBER = WA_ADRC-ADDRNUMBER.
LOOP AT IT_ADR6 INTO WA_ADR6 WHERE ADDRNUMBER = WA_ADRC-ADDRNUMBER..
  CASE wa_adr6-CONSNUMBER.
    WHEN '1'.
      WA_FINAL-SMTP_ADDR  =  WA_ADR6-SMTP_ADDR.
    WHEN '2'.
      WA_FINAL-SMTP_ADDR1  =  WA_ADR6-SMTP_ADDR.
    WHEN '3'.
      WA_FINAL-SMTP_ADDR2  =  WA_ADR6-SMTP_ADDR.
    WHEN '4'.
      WA_FINAL-SMTP_ADDR3  =  WA_ADR6-SMTP_ADDR.
    WHEN '5'.
      WA_FINAL-SMTP_ADDR4  =  WA_ADR6-SMTP_ADDR.
    WHEN '6'.
      WA_FINAL-SMTP_ADDR5  =  WA_ADR6-SMTP_ADDR.
  ENDCASE.
ENDLOOP.
*  IF SY-SUBRC = 0.
*    WA_FINAL-SMTP_ADDR  =  WA_ADR6-SMTP_ADDR.
*    WA_FINAL-SMTP_SRCH  =  WA_ADR6-SMTP_SRCH.

*  ENDIF.

READ TABLE IT_J_1IMOCUST INTO WA_J_1IMOCUST WITH KEY KUNNR = WA_KNA1-KUNNR.
  IF SY-SUBRC = 0.
    WA_FINAL-J_1IEXCD    =  WA_J_1IMOCUST-J_1IEXCD   .
    WA_FINAL-J_1IEXRN    =  WA_J_1IMOCUST-J_1IEXRN   .
    WA_FINAL-J_1IEXRG    =  WA_J_1IMOCUST-J_1IEXRG   .
    WA_FINAL-J_1IEXDI    =  WA_J_1IMOCUST-J_1IEXDI   .
    WA_FINAL-J_1IEXCO    =  WA_J_1IMOCUST-J_1IEXCO   .
    WA_FINAL-J_1IEXCICU  =  WA_J_1IMOCUST-J_1IEXCICU .
    WA_FINAL-J_1ICSTNO   =  WA_J_1IMOCUST-J_1ICSTNO  .
    WA_FINAL-J_1ISERN    =  WA_J_1IMOCUST-J_1ISERN   .
    WA_FINAL-J_1ILSTNO   =  WA_J_1IMOCUST-J_1ILSTNO  .
    WA_FINAL-J_1IPANNO   =  WA_J_1IMOCUST-J_1IPANNO  .
    WA_FINAL-J_1IPANREF  =  WA_J_1IMOCUST-J_1IPANREF .

  ENDIF.

*******************************************PJ ON 13-08-21**********************************

READ TABLE it_KNKK INTO wa_KNKK WITH KEY kunnr = wa_kna1-kunnr.
IF sy-subrc = 0.
  wa_final-KLIMK = wa_knKK-KLIMK.
ENDIF.

********************************************************************************************



***********************************************8SORT DATA FOR DOWANLOAD FILE***********************************
LS_FINAL-KTOKD                 =          WA_FINAL-KTOKD     .
LS_FINAL-KUNNR                 =          WA_FINAL-KUNNR     .
LS_FINAL-BUKRS                 =          WA_FINAL-BUKRS     .
LS_FINAL-VKORG                 =          WA_FINAL-VKORG     .
LS_FINAL-VTWEG                 =          WA_FINAL-VTWEG     .
LS_FINAL-SPART                 =          WA_FINAL-SPART     .
LS_FINAL-ANRED                 =          WA_FINAL-ANRED     .
LS_FINAL-NAME1                 =          WA_FINAL-NAME1     .
LS_FINAL-NAME2                 =          WA_FINAL-NAME2     .
LS_FINAL-NAME3                 =          WA_FINAL-NAME3     .
LS_FINAL-SORT1                 =          WA_FINAL-SORT1     .
LS_FINAL-STREET                =          WA_FINAL-STREET    .
LS_FINAL-POST_CODE1            =          WA_FINAL-POST_CODE1.
LS_FINAL-CITY2                 =          WA_FINAL-CITY2     .
LS_FINAL-CITY1                 =          WA_FINAL-CITY1     .
LS_FINAL-LANDX                 =          WA_FINAL-LANDX     .
LS_FINAL-BEZEI                 =          WA_FINAL-BEZEI     .
LS_FINAL-LANGU                 =          WA_FINAL-LANGU     .
LS_FINAL-TEL_NUMBER            =          WA_FINAL-TEL_NUMBER.
LS_FINAL-FAX_NUMBER            =          WA_FINAL-FAX_NUMBER.
LS_FINAL-AKONT                 =          WA_FINAL-AKONT     .
LS_FINAL-VKBUR                 =          WA_FINAL-VKBUR     .
LS_FINAL-KDGRP                 =          WA_FINAL-KDGRP     .
LS_FINAL-WAERS                 =          WA_FINAL-WAERS     .
LS_FINAL-KALKS                 =          WA_FINAL-KALKS     .
LS_FINAL-VERSG                 =          WA_FINAL-VERSG     .
LS_FINAL-LPRIO                 =          WA_FINAL-LPRIO     .
LS_FINAL-VSBED                 =          WA_FINAL-VSBED     .
LS_FINAL-VWERK                 =          WA_FINAL-VWERK     .
LS_FINAL-INCO1                 =          WA_FINAL-INCO1     .
LS_FINAL-INCO_TEXT             =          WA_FINAL-INCO_TEXT .
LS_FINAL-INCO2                 =          WA_FINAL-INCO2     .
LS_FINAL-ZTERM                 =          WA_FINAL-ZTERM     .
LS_FINAL-VTEXT                 =          WA_FINAL-VTEXT     .
LS_FINAL-KTGRD                 =          WA_FINAL-KTGRD     .
LS_FINAL-UCOU                  =          WA_FINAL-UCOU     .
LS_FINAL-ULOC                  =          WA_FINAL-ULOC     .
LS_FINAL-USTA                  =          WA_FINAL-USTA     .
LS_FINAL-UOTH                  =          WA_FINAL-UOTH     .
LS_FINAL-TAX                   =          WA_FINAL-TAX     .
Ls_final-ref                   =          sy-datum.
Ls_final-ERDAT                 =        wa_final-ERDAT.
Ls_final-text                  =        wa_final-text.
Ls_final-SMTP_ADDR             =        wa_final-SMTP_ADDR.
Ls_final-SMTP_ADDR1            =        wa_final-SMTP_ADDR1.
Ls_final-SMTP_ADDR2            =        wa_final-SMTP_ADDR2.
Ls_final-SMTP_ADDR3            =        wa_final-SMTP_ADDR3.
Ls_final-SMTP_ADDR4            =        wa_final-SMTP_ADDR4.
Ls_final-SMTP_ADDR5            =        wa_final-SMTP_ADDR5.
LS_FINAL-ernam                 =        WA_FINAL-ernam.
*********************************ADDED BY JYOTI ON 05.12.2024
LS_FINAL-UCOU_PERC             =        WA_FINAL-UCOU_PERC.
LS_FINAL-ULOC_PERC             =        WA_FINAL-ULOC_PERC.
LS_FINAL-USTA_PERC             =        WA_FINAL-USTA_PERC.
LS_FINAL-UOTH_PERC             =        WA_FINAL-UOTH_PERC.

DATA : v_klimk TYPE string.
v_klimk = wa_final-KLIMK.
replace ',' with '' into v_klimk.
Ls_final-KLIMK                 =       v_klimk.
CLEAR v_klimk.

***************************************************************************************************************
IF wa_final-ERDAT IS NOT INITIAL.
CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = wa_final-ERDAT
   IMPORTING
     OUTPUT         = Ls_final-ERDAT
            .
CONCATENATE Ls_final-ERDAT+0(2) Ls_final-ERDAT+2(3) Ls_final-ERDAT+5(4)
                INTO Ls_final-ERDAT SEPARATED BY '-'.
ENDIF.


 CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = ls_final-ref
   IMPORTING
     OUTPUT        = ls_final-ref
            .
CONCATENATE ls_final-ref+0(2) ls_final-ref+2(3) ls_final-ref+5(4)
                INTO ls_final-ref SEPARATED BY '-'.
********************************************************END ********************************



  APPEND LS_FINAL TO LT_FINAL.
  APPEND WA_FINAL TO IT_FINAL.
  CLEAR WA_FINAL.
  CLEAR : WA_FINAL-FI_ZTERM,WA_FINAL-FI_VTEXT,WA_FINAL-INCO_TEXT,WA_FINAL-UCOU,WA_FINAL-ULOC,WA_FINAL-USTA, LS_FINAL.
ENDLOOP.
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
PERFORM FCAT USING :
                     '1'  'KUNNR '                 'IT_FINAL'  'Customer Code'                    '18',
                     '2'  'BUKRS '                 'IT_FINAL'  'Company Code'                     '18' ,
                     '3'  'VKORG '                 'IT_FINAL'  'Sales Org.'                       '18' ,
                     '4'  'VTWEG '                 'IT_FINAL'  'Dist. Chan.'                      '10' ,
                     '5'  'SPART '                 'IT_FINAL'  'Division'                         '30' ,
                     '6'  'KTOKD '                 'IT_FINAL'  'A/C Group'                        '18' ,
                     '7'  'ANRED '                 'IT_FINAL'  'Title'                            '30' ,
                     '8'  'NAME1 '                 'IT_FINAL'  'Name 1'                           '10' ,
                     '9'  'SORT1 '                 'IT_FINAL'  'Search Term'                      '10' ,
                    '10'  'NAME2 '                 'IT_FINAL'  'Name 2'                           '10' ,
                    '11'  'NAME3 '                 'IT_FINAL'  'Name 3'                           '10' ,
                    '12'  'STREET    '             'IT_FINAL'  'Street'                           '30' ,
                    '13'  'PFACH'                  'IT_FINAL'   'Po Box'                          '12',
                    '14'  'CITY1   '               'IT_FINAL'  'City'                             '18' ,
                    '15'  'POST_CODE1'             'IT_FINAL'  'City postal code'                 '18' ,
                    '16'  'CITY2     '             'IT_FINAL'  'District'                         '18' ,
                    '17'  'PFORT'                  'IT_FINAL'  'PO Box City'                      '18',
                    '18'  'PSTL2'                  'IT_FINAL'  'PO Box Code'                      '18',
                    '19'  'LANDX '                 'IT_FINAL'  'Country'                          '18' ,
                    '20'  'BEZEI'                  'IT_FINAL'  'Region'                           '18' ,
                    '21'  'LANGU     '             'IT_FINAL'  'Language'                         '10' ,
                    '22'  'TEL_NUMBER'             'IT_FINAL'  'Telephone NO'                     '10' ,
                    '23'  'FAX_NUMBER'             'IT_FINAL'  'Fax no'                           '10' ,
                    '24'  'BRSCH'                  'IT_FINAL'  'Industry Key'                           '18' ,
                    '25'  'CON_PER'                'IT_FINAL'  'Contact Person'                           '18' ,
                    '26'  'NAMEV '                 'IT_FINAL'  'First Name'                           '18' ,
                    '27'  'AKONT '                 'IT_FINAL'  'Recon A/C'                        '18' ,
                    '28'  'ALTKN '                 'IT_FINAL'  'Pre A/C No'                        '18' ,
                    '29'  'BZIRK '                 'IT_FINAL'  'Sales District'                        '18' ,
                    '30'  'AWAHR '                 'IT_FINAL'  'Order Prob.'                        '18' ,
                    '31'  'VKBUR '                 'IT_FINAL'  'Sales Office'                     '18' ,
                    '32'  'VKGRP '                 'IT_FINAL'  'Sales Group'                     '18' ,
                    '33'  'KDGRP '                 'IT_FINAL'  'Customer GRP'                     '18' ,
                    '34'  'WAERS '                 'IT_FINAL'  'Currency'                         '18' ,
                    '35'  'KALKS '                 'IT_FINAL'  'Cust pricing'                     '18' ,
                    '36'  'VERSG '                 'IT_FINAL'  'Cust.Stats.Grp'                   '18' ,
                    '37'  'LPRIO '                 'IT_FINAL'  'Delivery Priority'                '18' ,
                    '38'  'KZAZU '                 'IT_FINAL'  'Order Combination'                '18' ,
                    '39'  'VSBED '                 'IT_FINAL'  'Shipping Cond'                    '18' ,
                    '40'  'VWERK '                 'IT_FINAL'  'Delivering Plant'                 '18' ,
                    '41'  'ANTLF '                 'IT_FINAL'  'Max Part Delivery'                 '18' ,
                    '42'  'INCO1 '                 'IT_FINAL'  'INCO1'                            '18' ,
                    '43'  'INCO_TEXT'              'IT_FINAL'  'Desc.INCO1'                       '18' ,
                    '44'  'INCO2 '                 'IT_FINAL'  'INCO2'                            '18' ,
                    '45'  'ZTERM '                 'IT_FINAL'  'Terms of Payment'                 '18' ,
                    '46'  'VTEXT'                 'IT_FINAL'   'Terms of Payment'                 '18' ,
                    '47'  'KTGRD '                 'IT_FINAL'  'Acct assgmt grp'                  '18' ,
                    '48'  'UCOU '                  'IT_FINAL'  'TAX UCOU'                         '18' ,
                    '49'  'ULOC '                  'IT_FINAL'  'TAX ULOC'                         '18' ,
                    '50'  'USTA '                  'IT_FINAL'  'TAX USTA'                         '18' ,
                    '51'  'UOTH '                  'IT_FINAL'  'TAX UOTH'                         '18' ,
                    '52'  'TAX '                   'IT_FINAL'  'TAX Applicable'                   '18' ,
                    '53'  'ERDAT'                  'IT_FINAL'  'Created Date'                     '18' ,
                    '54'  'TEXT'                   'IT_FINAL'   'Industry Sector'                   '18' ,
                    '55'  'SMTP_ADDR'              'IT_FINAL'   'Email Address'                   '18' ,
                    '56'  'SMTP_ADDR1'             'IT_FINAL'   'Email Add.2'                     '18' ,
                    '57'  'SMTP_ADDR2'             'IT_FINAL'   'Email Add.3'                     '18' ,
                    '58'  'SMTP_ADDR3'             'IT_FINAL'   'Email Add.4'                     '18' ,
                    '59'  'SMTP_ADDR4'             'IT_FINAL'   'Email Add.5'                     '18' ,
                    '60'  'SMTP_ADDR5'             'IT_FINAL'   'Email Add.6'                        '18' ,
                    '61'  'KLIMK'                  'IT_FINAL'   'Customer Credit limit'               '18',
                    '62'  'ERNAM'                  'IT_FINAL'   'Created by'                          '18',
*************************************************Added by jyoti on 05.12.2024******************************************
                    '63'  'UCOU_PERC'              'IT_FINAL'   'UCOU %'                     '18',
                    '64'  'ULOC_PERC'              'IT_FINAL'   'ULOC %'                     '18',
                    '65'  'USTA_PERC'              'IT_FINAL'   'USTA %'                     '18',
                    '66'  'UOTH_PERC'              'IT_FINAL'   'UOTH %'                     '18'.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_1203   text
*      -->P_1204   text
*      -->P_1205   text
*      -->P_1206   text
*      -->P_1207   text
*----------------------------------------------------------------------*
FORM fcat  USING     VALUE(p1)
                    VALUE(p2)
                    VALUE(p3)
                    VALUE(p4)
                    VALUE(p5).
wa_fcat-col_pos   = p1.
wa_fcat-fieldname = p2.
wa_fcat-tabname   = p3.
wa_fcat-seltext_l = p4.
*wa_fcat-key       = .
wa_fcat-outputlen   = p5.

append wa_fcat to it_fcat.
CLEAR wa_fcat.

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
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
     I_CALLBACK_PROGRAM                = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
*     I_GRID_TITLE                      =
*     I_GRID_SETTINGS                   =
*     IS_LAYOUT                         =
     IT_FIELDCAT                       = it_fcat
*     IT_EXCLUDING                      =
*     IT_SPECIAL_GROUPS                 =
*     IT_SORT                           =
*     IT_FILTER                         =
*     IS_SEL_HIDE                       =
*     I_DEFAULT                         = 'X'
      I_SAVE                            = 'X'
*     IS_VARIANT                        =
*     IT_EVENTS                         =
*     IT_EVENT_EXIT                     =
*     IS_PRINT                          =
*     IS_REPREP_ID                      =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS                   =
*     IT_HYPERLINK                      =
*     IT_ADD_FIELDCAT                   =
*     IT_EXCEPT_QINFO                   =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab                          = it_final
*   EXCEPTIONS
*     PROGRAM_ERROR                     = 1
*     OTHERS                            = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  IF p_down = 'X'.

    PERFORM download.
    PERFORM gui_download.
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
*BREAK primus.
  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = LT_FINAL
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
  lv_file = 'ZUS_CUST_MASTER.TXT'.

  CONCATENATE p_folder '/' lv_file
    INTO lv_fullfile.
*BREAK primus.
  WRITE: / 'ZUS CUSTOMER MASTER started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1416 TYPE string.
DATA lv_crlf_1416 TYPE string.
lv_crlf_1416 = cl_abap_char_utilities=>cr_lf.
lv_string_1416 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1416 lv_crlf_1416 wa_csv INTO lv_string_1416.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_1854 TO lv_fullfile.
TRANSFER lv_string_1416 TO lv_fullfile.
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
  CONCATENATE 'Customer Code'
              'Company Code'
              'Sales Org.'
              'Dist. Chan.'
              'Division'
              'A/C Group'
              'Title'
              'Name 1'
              'Search Term'
              'Name 2'
              'Name 3'
              'Street'
              'Po Box'
              'City'
              'City postal code'
              'District'
              'PO Box City'
              'PO Box Code'
              'Country'
              'Region'
              'Language'
              'Telephone NO'
              'Fax no'
              'Industry Key'
              'Contact Person'
              'First Name'
              'Recon A/C'
              'Pre A/C No'
              'Sales District'
              'Order Prob.'
              'Sales Office'
              'Sales Group'
              'Customer GRP'
              'Currency'
              'Cust pricing'
              'Cust.Stats.Grp'
              'Delivery Priority'
              'Order Combination'
              'Shipping Cond'
              'Delivering Plant'
              'Max Part Delivery'
              'INCO1'
              'Desc.INCO1'
              'INCO2'
              'Terms of Payment'
              'Terms of Payment'
              'Acct assgmt grp'
              'TAX UCOU'
              'TAX ULOC'
              'TAX USTA'
              'Refresh Date'
              'TAX Applicable'
              'Created Date'
              'Industry Sector'
              'TAX UOTH'
              'Email Address'
              'Email Add.2'
              'Email Add.3'
              'Email Add.4'
              'Email Add.5'
              'Email Add.6'
              'Customer Credit limit'
              'Created By'
*********************addedby jyoti on 05.12.2024**************
              'UCOU %'
              'ULOC %'
              'USTA %'
              'UOTH %'

              INTO pd_csv
              SEPARATED BY l_field_seperator.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GUI_DOWNLOAD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM gui_download .
  TYPES : BEGIN OF ls_fieldname,
            field_name(25),
          END OF ls_fieldname.

  DATA : it_fieldname TYPE TABLE OF ls_fieldname.
  DATA : wa_fieldname TYPE ls_fieldname.
*----------------Fieldnames---------------------------------------------------------
  wa_fieldname-field_name = 'Customer Code'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Company Code'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Sales Org.'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Dist. Chan.'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Division'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'A/C Group'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Title'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.


  wa_fieldname-field_name = 'Name 1'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Search Term'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Name 2'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Name 3'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Street'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.


  wa_fieldname-field_name = 'Po Box'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'City'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'City postal code'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'District'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'PO Box City'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.
**--------------------------------------------------------------------*
  wa_fieldname-field_name = 'PO Box Code'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Country'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Region'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Language'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.
*--------------------------------------------------------------------*
  wa_fieldname-field_name = 'Telephone NO'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

  wa_fieldname-field_name = 'Fax no'.
  APPEND wa_fieldname TO it_fieldname.
  CLEAR wa_fieldname.

*--------------------------------------------------------------------*
wa_fieldname-field_name = 'Industry Key'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Contact Person'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'First Name'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Recon A/C'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Pre A/C No'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Sales District'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Order Prob.'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Sales Office'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Sales Group'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Customer GRP'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Currency'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Cust pricing'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.



wa_fieldname-field_name = 'Cust.Stats.Grp'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Delivery Priority'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Order Combination'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Shipping Cond'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Delivering Plant'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Max Part Delivery'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'INCO1'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Desc.INCO1'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'INCO2'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Terms of Payment'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Terms of Payment'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Acct assgmt grp'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'TAX UCOU'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'TAX ULOC'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'TAX USTA'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Refresh Date'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.

wa_fieldname-field_name = 'Created By'.
APPEND wa_fieldname TO it_fieldname.
CLEAR wa_fieldname.



  DATA file TYPE string VALUE 'C:\ZUS_CUST_MASTER.TXT'.

    CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
*     BIN_FILESIZE            =
      filename                = file
      filetype                = 'ASC'
*     APPEND                  = ' '
      write_field_separator   = 'X'
*     HEADER                  = '00'
*     TRUNC_TRAILING_BLANKS   = ' '
*     WRITE_LF                = 'X'
*     COL_SELECT              = ' '
*     COL_SELECT_MASK         = ' '
*     DAT_MODE                = ' '
*     CONFIRM_OVERWRITE       = ' '
*     NO_AUTH_CHECK           = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
*     REPLACEMENT             = '#'
*     WRITE_BOM               = ' '
*     TRUNC_TRAILING_BLANKS_EOL       = 'X'
*     WK1_N_FORMAT            = ' '
*     WK1_N_SIZE              = ' '
*     WK1_T_FORMAT            = ' '
*     WK1_T_SIZE              = ' '
*     WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*     SHOW_TRANSFER_STATUS    = ABAP_TRUE
*     VIRUS_SCAN_PROFILE      = '/SCET/GUI_DOWNLOAD'
* IMPORTING
*     FILELENGTH              =
    TABLES
      data_tab                = lt_final
      fieldnames              = it_fieldname
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      OTHERS                  = 22.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.

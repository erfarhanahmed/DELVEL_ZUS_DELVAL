*&---------------------------------------------------------------------*
*& Report ZUS_VENDOR_MASTER_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_VENDOR_MASTER_REPORT.

TYPE-POOLS: slis.
TABLES: LFB1.


TYPES: BEGIN OF TY_LFA1,
       LIFNR TYPE LFA1-LIFNR,
       KTOKK TYPE LFA1-KTOKK,
       KUNNR TYPE LFA1-KUNNR,
       ADRNR TYPE LFA1-ADRNR,
       NAME1 TYPE LFA1-NAME1,
       NAME2 TYPE LFA1-NAME2,
       SORTL TYPE LFA1-SORTL,
       ANRED TYPE LFA1-ANRED,
       STCD3 TYPE LFA1-STCD3,
       ernam type lfa1-ernam,
       END OF TY_LFA1,

       BEGIN OF TY_ADRC,
       ADDRNUMBER TYPE ADRC-ADDRNUMBER,
       STR_SUPPL1 TYPE ADRC-STR_SUPPL1,
       STR_SUPPL2 TYPE ADRC-STR_SUPPL2,
       STR_SUPPL3 TYPE ADRC-STR_SUPPL3,
       STREET     TYPE ADRC-STREET,
       COUNTRY    TYPE ADRC-COUNTRY,
       HOUSE_NUM1 TYPE ADRC-HOUSE_NUM1,
       CITY1      TYPE ADRC-CITY1,
       CITY2      TYPE ADRC-CITY2,
       POST_CODE1 TYPE ADRC-POST_CODE1,
       REGION     TYPE ADRC-REGION,
       PO_BOX     TYPE ADRC-PO_BOX,
       LANGU      TYPE ADRC-LANGU,
       TEL_NUMBER TYPE ADRC-TEL_NUMBER,
       FAX_NUMBER TYPE ADRC-FAX_NUMBER,
       NAME_CO    TYPE ADRC-NAME_CO,
       END OF TY_ADRC,

       BEGIN OF TY_ADR6,
       ADDRNUMBER TYPE ADR6-ADDRNUMBER,
       SMTP_ADDR  TYPE ADR6-SMTP_ADDR,
       END OF TY_ADR6,

       BEGIN OF TY_LFBK,
       LIFNR TYPE LFBK-LIFNR,
       BANKS TYPE LFBK-BANKS,
       BANKL TYPE LFBK-BANKL,
       BANKN TYPE LFBK-BANKN,
       KOINH TYPE LFBK-KOINH,
       END OF TY_LFBK,

       BEGIN OF TY_BNKA,
       BANKS TYPE BNKA-BANKS,
       BANKL TYPE BNKA-BANKL,
       BANKA TYPE BNKA-BANKA,
       ADRNR TYPE BNKA-ADRNR,
       BRNCH TYPE BNKA-BRNCH,
       PROVZ TYPE BNKA-PROVZ,
       STRAS TYPE BNKA-STRAS,
       ORT01 TYPE BNKA-ORT01,
       SWIFT TYPE BNKA-SWIFT,
       END OF TY_BNKA,


       BEGIN OF TY_LFB1,
       LIFNR TYPE LFB1-LIFNR,
       BUKRS TYPE LFB1-BUKRS,
       ERDAT TYPE LFB1-ERDAT,
       ERNAM TYPE LFB1-ERNAM,
       ZUAWA TYPE LFB1-ZUAWA,
       AKONT TYPE LFB1-AKONT,
       ZTERM TYPE LFB1-ZTERM,
       REPRF TYPE LFB1-REPRF,

       END OF TY_LFB1,

       BEGIN OF TY_LFM1,
       LIFNR TYPE LFM1-LIFNR,
       EKORG TYPE LFM1-EKORG,
       WAERS TYPE LFM1-WAERS,
       ZTERM TYPE LFM1-ZTERM,
       INCO1 TYPE LFM1-INCO1,
       INCO2 TYPE LFM1-INCO2,
       WEBRE TYPE LFM1-WEBRE,
       LEBRE TYPE LFM1-LEBRE,
       KZABS TYPE LFM1-KZABS,
       END OF TY_LFM1,

       BEGIN OF TY_J_1IMOVEND,
       LIFNR     TYPE J_1IMOVEND-LIFNR,
       J_1ICSTNO TYPE J_1IMOVEND-J_1ICSTNO,
       J_1ILSTNO TYPE J_1IMOVEND-J_1ILSTNO,
       J_1ISERN  TYPE J_1IMOVEND-J_1ISERN,
       J_1IEXCD  TYPE J_1IMOVEND-J_1IEXCD,
       J_1IEXRN  TYPE J_1IMOVEND-J_1IEXRN,
       J_1IEXRG  TYPE J_1IMOVEND-J_1IEXRG,
       J_1IEXDI  TYPE J_1IMOVEND-J_1IEXDI,
       J_1IEXCO  TYPE J_1IMOVEND-J_1IEXCO,
       J_1IVTYP  TYPE J_1IMOVEND-J_1IVTYP,
       J_1IPANNO TYPE J_1IMOVEND-J_1IPANNO,
       END OF TY_J_1IMOVEND,

       BEGIN OF TY_LFBW,
       LIFNR     TYPE LFBW-LIFNR,
       WT_WITHCD TYPE LFBW-WT_WITHCD,
       WT_SUBJCT TYPE LFBW-WT_SUBJCT,
       END OF TY_LFBW,

       BEGIN OF TY_T005U,
       SPRAS TYPE T005U-SPRAS,
       LAND1 TYPE T005U-LAND1,
       BLAND TYPE T005U-BLAND,
       BEZEI TYPE T005U-BEZEI,
       END OF TY_T005U,

       BEGIN OF TY_TINCT,
       SPRAS TYPE TINCT-SPRAS,
       INCO1 TYPE TINCT-INCO1,
       BEZEI TYPE TINCT-BEZEI,
       END OF TY_TINCT,

       BEGIN OF TY_TVZBT,
       SPRAS TYPE TVZBT-SPRAS,
       ZTERM TYPE TVZBT-ZTERM,
       VTEXT TYPE TVZBT-VTEXT,
       END OF TY_TVZBT,

       BEGIN OF TY_T059U,
       SPRAS TYPE T059U-SPRAS,
       LAND1 TYPE T059U-LAND1,
       WITHT TYPE T059U-WITHT,
       TEXT40 TYPE T059U-TEXT40,
       END OF TY_T059U,

       BEGIN OF ty_t052u,
       SPRAS TYPE t052u-SPRAS,
       ZTERM TYPE t052u-ZTERM,
       ztagg TYPE t052u-ztagg,
       text1 TYPE t052u-text1,
       END OF ty_t052u,

       BEGIN OF TY_FINAL,
       LIFNR      TYPE LFA1-LIFNR,
       BUKRS      TYPE LFB1-BUKRS,
       EKORG      TYPE LFM1-EKORG,
       KTOKK      TYPE LFA1-KTOKK,
       ANRED      TYPE LFA1-ANRED,
       NAME1      TYPE LFA1-NAME1,
       NAME2      TYPE LFA1-NAME2,
       SORTL      TYPE LFA1-SORTL,
       STR_SUPPL1 TYPE ADRC-STR_SUPPL1,
       STR_SUPPL2 TYPE ADRC-STR_SUPPL2,
       STR_SUPPL3 TYPE ADRC-STR_SUPPL3,
       STREET     TYPE ADRC-STREET,
       HOUSE_NUM1 TYPE ADRC-HOUSE_NUM1,
       CITY2      TYPE ADRC-CITY2,
       POST_CODE1 TYPE ADRC-POST_CODE1,
       CITY1      TYPE ADRC-CITY1,
       COUNTRY    TYPE ADRC-COUNTRY,
       REGION     TYPE ADRC-REGION,
       BEZEI      TYPE T005U-BEZEI,
       PO_BOX     TYPE ADRC-PO_BOX,
       LANGU      TYPE ADRC-LANGU,
       TEL_NUMBER TYPE ADRC-TEL_NUMBER,
       FAX_NUMBER TYPE ADRC-FAX_NUMBER,
       SMTP_ADDR  TYPE ADR6-SMTP_ADDR,
       BANKS      TYPE LFBK-BANKS,
       BANKL      TYPE LFBK-BANKL,
       BANKN      TYPE LFBK-BANKN,
       KOINH      TYPE LFBK-KOINH,
       BANKA      TYPE BNKA-BANKA,
       BRNCH      TYPE BNKA-BRNCH,
       PROVZ      TYPE BNKA-PROVZ,
       STRAS      TYPE BNKA-STRAS,
       ORT01      TYPE BNKA-ORT01,
       SWIFT      TYPE BNKA-SWIFT,
       AKONT      TYPE LFB1-AKONT,
       ZUAWA      TYPE LFB1-ZUAWA,
       ZTERM1     TYPE LFB1-ZTERM,
       VTEXT1     TYPE TVZBT-VTEXT,
       REPRF      TYPE LFB1-REPRF,
       WAERS      TYPE LFM1-WAERS,
       ZTERM      TYPE LFM1-ZTERM,
       VTEXT      TYPE TVZBT-VTEXT,
       INCO1      TYPE LFM1-INCO1,
       INCO_TEXT  TYPE TINCT-BEZEI,
       INCO2      TYPE LFM1-INCO2,
       WEBRE      TYPE LFM1-WEBRE,
       LEBRE      TYPE LFM1-LEBRE,
       KZABS      TYPE LFM1-KZABS,
       KUNNR      TYPE LFA1-KUNNR,
       J_1ICSTNO  TYPE J_1IMOVEND-J_1ICSTNO,
       J_1ILSTNO  TYPE J_1IMOVEND-J_1ILSTNO,
       J_1ISERN   TYPE J_1IMOVEND-J_1ISERN,
       J_1IEXCD   TYPE J_1IMOVEND-J_1IEXCD,
       J_1IEXRN   TYPE J_1IMOVEND-J_1IEXRN,
       J_1IEXRG   TYPE J_1IMOVEND-J_1IEXRG,
       J_1IEXDI   TYPE J_1IMOVEND-J_1IEXDI,
       J_1IEXCO   TYPE J_1IMOVEND-J_1IEXCO,
       J_1IVTYP   TYPE J_1IMOVEND-J_1IVTYP,
       J_1IPANNO  TYPE J_1IMOVEND-J_1IPANNO,
       WT_WITHCD  TYPE LFBW-WT_WITHCD,
       TEXT40     TYPE T059U-TEXT40,
       WT_SUBJCT  TYPE LFBW-WT_SUBJCT,
       STCD3      TYPE LFA1-STCD3,
       NAME_CO    TYPE ADRC-NAME_CO,
       ernam      type LFA1-ernam,
       decri      TYPE char50,
       decri1     TYPE char50,
       END OF TY_FINAL.

********************************************Structure For Download file************************************
TYPES : BEGIN OF ITAB,
       LIFNR      TYPE CHAR15,
       BUKRS      TYPE CHAR10,
       EKORG      TYPE CHAR10,
       KTOKK      TYPE CHAR10,
       ANRED      TYPE CHAR15,
       NAME1      TYPE CHAR50,
       NAME2      TYPE CHAR50,
       SORTL      TYPE CHAR15,
       STR_SUPPL1 TYPE CHAR50,
       STR_SUPPL2 TYPE CHAR50,
       STR_SUPPL3 TYPE CHAR50,
       STREET     TYPE CHAR70,
       HOUSE_NUM1 TYPE CHAR15,
       CITY2      TYPE CHAR50,
       POST_CODE1 TYPE CHAR15,
       CITY1      TYPE CHAR50,
       COUNTRY    TYPE CHAR10,
       REGION     TYPE CHAR10,
       BEZEI      TYPE CHAR20,
       PO_BOX     TYPE CHAR15,
       LANGU      TYPE CHAR5,
       TEL_NUMBER TYPE CHAR50,
       FAX_NUMBER TYPE CHAR50,
       SMTP_ADDR  TYPE CHAR250,
       BANKS      TYPE CHAR10,
       BANKL      TYPE CHAR15,
       BANKN      TYPE CHAR20,
       KOINH      TYPE CHAR100,
       BANKA      TYPE CHAR100,
       BRNCH      TYPE CHAR50,
       PROVZ      TYPE CHAR10,
       STRAS      TYPE CHAR50,
       ORT01      TYPE CHAR50,
       SWIFT      TYPE CHAR15,
       AKONT      TYPE CHAR15,
       ZUAWA      TYPE CHAR10,
       ZTERM1     TYPE CHAR10,
       VTEXT1     TYPE CHAR50,
       REPRF      TYPE CHAR10,
       WAERS      TYPE CHAR10,
       ZTERM      TYPE CHAR10,
       VTEXT      TYPE CHAR50,
       INCO1      TYPE CHAR10,
       INCO_TEXT  TYPE CHAR50,
       INCO2      TYPE CHAR50,
       WEBRE      TYPE CHAR10,
       LEBRE      TYPE CHAR10,
       KZABS      TYPE CHAR10,
       KUNNR      TYPE CHAR20,
       J_1ICSTNO  TYPE CHAR80,
       J_1ILSTNO  TYPE CHAR50,
       J_1ISERN   TYPE CHAR50,
       J_1IEXCD   TYPE CHAR50,
       J_1IEXRN   TYPE CHAR50,
       J_1IEXRG   TYPE CHAR80,
       J_1IEXDI   TYPE CHAR80,
       J_1IEXCO   TYPE CHAR80,
       J_1IVTYP   TYPE CHAR10,
       J_1IPANNO  TYPE CHAR50,
       WT_WITHCD  TYPE CHAR10,
       TEXT40     TYPE CHAR50,
       WT_SUBJCT  TYPE CHAR10,
       STCD3      TYPE CHAR20,
       REF        TYPE CHAR15,
       NAME_CO    TYPE CHAR50,
       ernam     type LFA1-ernam,
       END OF ITAB.

DATA : LT_FINAL TYPE TABLE OF ITAB,
       LS_FINAL TYPE          ITAB.
********************************************************************************************************************


DATA : IT_LFA1 TYPE TABLE OF TY_LFA1,
       WA_LFA1 TYPE          TY_LFA1,

       IT_LFB1 TYPE TABLE OF TY_LFB1,
       WA_LFB1 TYPE          TY_LFB1,

       IT_LFM1 TYPE TABLE OF TY_LFM1,
       WA_LFM1 TYPE          TY_LFM1,

       IT_ADRC TYPE TABLE OF TY_ADRC,
       WA_ADRC TYPE          TY_ADRC,

       IT_ADR6 TYPE TABLE OF TY_ADR6,
       WA_ADR6 TYPE          TY_ADR6,

       IT_LFBK TYPE TABLE OF TY_LFBK,
       WA_LFBK TYPE          TY_LFBK,

       IT_LFBW TYPE TABLE OF TY_LFBW,
       WA_LFBW TYPE          TY_LFBW,

       IT_BNKA TYPE TABLE OF TY_BNKA,
       WA_BNKA TYPE          TY_BNKA,

       IT_T005U TYPE TABLE OF TY_T005U,
       WA_T005U TYPE          TY_T005U,

       IT_TINCT TYPE TABLE OF TY_TINCT,
       WA_TINCT TYPE          TY_TINCT,

       IT_MM_TVZBT TYPE TABLE OF TY_TVZBT,
       WA_MM_TVZBT TYPE          TY_TVZBT,

       IT_FI_TVZBT TYPE TABLE OF TY_TVZBT,
       WA_FI_TVZBT TYPE          TY_TVZBT,

       IT_T059U    TYPE TABLE OF TY_T059U,
       WA_T059U    TYPE          TY_T059U,

       it_t052u TYPE TABLE OF ty_t052u,
       wa_t052u TYPE          ty_t052u,

       IT_J_1IMOVEND TYPE TABLE OF TY_J_1IMOVEND,
       WA_J_1IMOVEND TYPE          TY_J_1IMOVEND,

       IT_FINAL TYPE TABLE OF TY_FINAL,
       WA_FINAL TYPE          TY_FINAL.

DATA: it_fcat type slis_t_fieldcat_alv,
      wa_fcat like line of it_fcat.

SELECTION-SCREEN: BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: S_LIFNR FOR LFB1-LIFNR,

                  S_ERNAM FOR LFB1-ERNAM,
                  S_ERDAT FOR LFB1-ERDAT NO INTERVALS,
                  S_BUKRS FOR LFB1-BUKRS OBLIGATORY NO INTERVALS.
SELECTION-SCREEN: END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-002 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT '/Delval/USA'."USA'."USA'."usa'.
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
    SELECT LIFNR
           BUKRS
           ERDAT
           ERNAM
           ZUAWA
           AKONT
           ZTERM
           REPRF FROM LFB1 INTO TABLE IT_LFB1
           WHERE LIFNR IN S_LIFNR
           AND   BUKRS IN S_BUKRS
           AND   ERNAM IN S_ERNAM
           AND   ERDAT IN S_ERDAT.

IF  IT_LFB1 IS NOT INITIAL.
    SELECT LIFNR
           KTOKK
           KUNNR
           ADRNR
           NAME1
           NAME2
           SORTL
           ANRED
           STCD3
           ERNAM FROM LFA1 INTO TABLE IT_LFA1
           FOR ALL ENTRIES IN IT_LFB1
           WHERE LIFNR = IT_LFB1-LIFNR.

ENDIF.

IF IT_LFA1 IS NOT INITIAL.
    SELECT ADDRNUMBER
           STR_SUPPL1
           STR_SUPPL2
           STR_SUPPL3
           STREET
           COUNTRY
           HOUSE_NUM1
           CITY1
           CITY2
           POST_CODE1
           REGION
           PO_BOX
           LANGU
           TEL_NUMBER
           FAX_NUMBER
           NAME_CO
           FROM ADRC INTO TABLE IT_ADRC
           FOR ALL ENTRIES IN IT_LFA1
           WHERE ADDRNUMBER = IT_LFA1-ADRNR.

    SELECT LIFNR
           BANKS
           BANKL
           BANKN
           KOINH FROM LFBK INTO TABLE IT_LFBK
           FOR ALL ENTRIES IN IT_LFA1
           WHERE LIFNR = IT_LFA1-LIFNR.

    SELECT LIFNR
           EKORG
           WAERS
           ZTERM
           INCO1
           INCO2
           WEBRE
           LEBRE
           KZABS FROM LFM1 INTO TABLE IT_LFM1
           FOR ALL ENTRIES IN IT_LFA1
           WHERE LIFNR = IT_LFA1-LIFNR.

    SELECT LIFNR
           J_1ICSTNO
           J_1ILSTNO
           J_1ISERN
           J_1IEXCD
           J_1IEXRN
           J_1IEXRG
           J_1IEXDI
           J_1IEXCO
           J_1IVTYP
           J_1IPANNO FROM J_1IMOVEND INTO TABLE IT_J_1IMOVEND
           FOR ALL ENTRIES IN IT_LFA1
           WHERE LIFNR = IT_LFA1-LIFNR.

    SELECT LIFNR
           WT_WITHCD
           WT_SUBJCT FROM LFBW INTO TABLE IT_LFBW
           FOR ALL ENTRIES IN IT_LFA1
           WHERE LIFNR = IT_LFA1-LIFNR.


ENDIF.

IF IT_LFBK IS NOT INITIAL .
    SELECT BANKS
           BANKL
           BANKA
           ADRNR
           BRNCH
           PROVZ
           STRAS
           ORT01
           SWIFT FROM BNKA INTO TABLE IT_BNKA
           FOR ALL ENTRIES IN IT_LFBK
           WHERE BANKS = IT_LFBK-BANKS
           AND   BANKL = IT_LFBK-BANKL.
ENDIF.
IF IT_ADRC IS NOT INITIAL.

    SELECT ADDRNUMBER
           SMTP_ADDR  FROM ADR6 INTO TABLE IT_ADR6
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
ENDIF.

IF IT_LFM1 IS NOT INITIAL .

    SELECT SPRAS
           INCO1
           BEZEI FROM TINCT INTO TABLE IT_TINCT
           FOR ALL ENTRIES IN IT_LFM1
           WHERE INCO1 = IT_LFM1-INCO1
           AND   SPRAS = 'E'.

    SELECT SPRAS
           ZTERM
           VTEXT FROM TVZBT INTO TABLE IT_MM_TVZBT
           FOR ALL ENTRIES IN IT_LFM1
           WHERE ZTERM = IT_LFM1-ZTERM
           AND   SPRAS = 'E'.

ENDIF.

IF IT_LFB1 IS NOT INITIAL .
    SELECT SPRAS
           ZTERM
           VTEXT FROM TVZBT INTO TABLE IT_FI_TVZBT
           FOR ALL ENTRIES IN IT_LFB1
           WHERE ZTERM = IT_LFB1-ZTERM
           AND   SPRAS = 'E'.

ENDIF.

IF IT_LFBW IS NOT INITIAL .

   SELECT SPRAS
          LAND1
          WITHT
          TEXT40 FROM T059U INTO TABLE IT_T059U
          FOR ALL ENTRIES IN IT_LFBW
          WHERE WITHT = IT_LFBW-WT_WITHCD
          AND   SPRAS = 'E'
          AND   LAND1 = 'IN'.

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
  LOOP AT IT_LFA1 INTO WA_LFA1.
    WA_FINAL-LIFNR  = WA_LFA1-LIFNR .
    WA_FINAL-KTOKK  = WA_LFA1-KTOKK .
    WA_FINAL-ANRED  = WA_LFA1-ANRED .
    WA_FINAL-NAME1  = WA_LFA1-NAME1 .
    WA_FINAL-NAME2  = WA_LFA1-NAME2 .
    WA_FINAL-SORTL  = WA_LFA1-SORTL .
    WA_FINAL-KUNNR  = WA_LFA1-KUNNR .
    WA_FINAL-STCD3  = WA_LFA1-STCD3 .
    WA_FINAL-ERNAM  = WA_lfa1-ernam .

READ TABLE IT_LFB1 INTO WA_LFB1 WITH KEY LIFNR = WA_LFA1-LIFNR.
  IF  SY-SUBRC = 0.
    WA_FINAL-BUKRS = WA_LFB1-BUKRS.
    WA_FINAL-AKONT = WA_LFB1-AKONT.
    WA_FINAL-ZUAWA = WA_LFB1-ZUAWA.
    WA_FINAL-REPRF = WA_LFB1-REPRF.
    WA_FINAL-ZTERM1 = WA_LFB1-ZTERM.
  ENDIF.

READ TABLE IT_ADRC INTO WA_ADRC WITH KEY ADDRNUMBER = WA_LFA1-ADRNR.
  IF SY-SUBRC = 0.
    WA_FINAL-STR_SUPPL1   = WA_ADRC-STR_SUPPL1 .
    WA_FINAL-STR_SUPPL2   = WA_ADRC-STR_SUPPL2 .
    WA_FINAL-STR_SUPPL3   = WA_ADRC-STR_SUPPL3 .
    WA_FINAL-STREET       = WA_ADRC-STREET     .
    WA_FINAL-HOUSE_NUM1   = WA_ADRC-HOUSE_NUM1 .
    WA_FINAL-CITY2        = WA_ADRC-CITY2      .
    WA_FINAL-POST_CODE1   = WA_ADRC-POST_CODE1 .
    WA_FINAL-CITY1        = WA_ADRC-CITY1      .
    WA_FINAL-COUNTRY      = WA_ADRC-COUNTRY    .
    WA_FINAL-REGION       = WA_ADRC-REGION     .
    WA_FINAL-PO_BOX       = WA_ADRC-PO_BOX     .
    WA_FINAL-LANGU        = WA_ADRC-LANGU      .
    WA_FINAL-TEL_NUMBER   = WA_ADRC-TEL_NUMBER .
    WA_FINAL-FAX_NUMBER   = WA_ADRC-FAX_NUMBER .
    WA_FINAL-NAME_CO      = WA_ADRC-NAME_CO .
  ENDIF.
READ TABLE IT_LFBK INTO WA_LFBK WITH KEY LIFNR = WA_LFA1-LIFNR.
  IF SY-SUBRC = 0.
    WA_FINAL-BANKS = WA_LFBK-BANKS.
    WA_FINAL-BANKL = WA_LFBK-BANKL.
    WA_FINAL-BANKN = WA_LFBK-BANKN.
    WA_FINAL-KOINH = WA_LFBK-KOINH.

  ENDIF.
READ TABLE IT_LFM1 INTO WA_LFM1 WITH KEY LIFNR = WA_LFA1-LIFNR.
  IF SY-SUBRC = 0.
    WA_FINAL-EKORG = WA_LFM1-EKORG.
    WA_FINAL-WAERS = WA_LFM1-WAERS.
    WA_FINAL-ZTERM = WA_LFM1-ZTERM.
    WA_FINAL-INCO1 = WA_LFM1-INCO1.
    WA_FINAL-INCO2 = WA_LFM1-INCO2.
    WA_FINAL-WEBRE = WA_LFM1-WEBRE.
    WA_FINAL-LEBRE = WA_LFM1-LEBRE.
    WA_FINAL-KZABS = WA_LFM1-KZABS.
  ENDIF.

READ TABLE IT_J_1IMOVEND INTO WA_J_1IMOVEND WITH KEY LIFNR = WA_LFA1-LIFNR.
  IF SY-SUBRC = 0.
    WA_FINAL-J_1ICSTNO = WA_J_1IMOVEND-J_1ICSTNO.
    WA_FINAL-J_1ILSTNO = WA_J_1IMOVEND-J_1ILSTNO.
    WA_FINAL-J_1ISERN  = WA_J_1IMOVEND-J_1ISERN .
    WA_FINAL-J_1IEXCD  = WA_J_1IMOVEND-J_1IEXCD .
    WA_FINAL-J_1IEXRN  = WA_J_1IMOVEND-J_1IEXRN .
    WA_FINAL-J_1IEXRG  = WA_J_1IMOVEND-J_1IEXRG .
    WA_FINAL-J_1IEXDI  = WA_J_1IMOVEND-J_1IEXDI .
    WA_FINAL-J_1IEXCO  = WA_J_1IMOVEND-J_1IEXCO .
    WA_FINAL-J_1IVTYP  = WA_J_1IMOVEND-J_1IVTYP .
    WA_FINAL-J_1IPANNO = WA_J_1IMOVEND-J_1IPANNO.

  ENDIF.

READ TABLE IT_LFBW INTO WA_LFBW WITH KEY LIFNR = WA_LFA1-LIFNR.
  IF  SY-SUBRC = 0.
    WA_FINAL-WT_WITHCD = WA_LFBW-WT_WITHCD.
    WA_FINAL-WT_SUBJCT = WA_LFBW-WT_SUBJCT.

  ENDIF.

READ TABLE IT_BNKA INTO WA_BNKA WITH KEY BANKS = WA_LFBK-BANKS
                                         BANKL = WA_LFBK-BANKL.
  IF SY-SUBRC = 0.
    WA_FINAL-BANKA  = WA_BNKA-BANKA.
    WA_FINAL-BRNCH  = WA_BNKA-BRNCH.
    WA_FINAL-PROVZ  = WA_BNKA-PROVZ.
    WA_FINAL-STRAS  = WA_BNKA-STRAS.
    WA_FINAL-ORT01  = WA_BNKA-ORT01.
    WA_FINAL-SWIFT  = WA_BNKA-SWIFT.

  ENDIF.

READ TABLE IT_ADR6 INTO WA_ADR6 WITH KEY ADDRNUMBER = WA_ADRC-ADDRNUMBER.
  IF SY-SUBRC = 0.
    WA_FINAL-SMTP_ADDR = WA_ADR6-SMTP_ADDR.

  ENDIF.

READ TABLE IT_T005U INTO WA_T005U WITH KEY SPRAS = WA_ADRC-LANGU
                                           LAND1 = WA_ADRC-COUNTRY
                                           BLAND = WA_ADRC-REGION.
  IF SY-SUBRC = 0.
    WA_FINAL-BEZEI   =  WA_T005U-BEZEI.

  ENDIF.

READ TABLE IT_TINCT INTO WA_TINCT WITH KEY INCO1 = WA_LFM1-INCO1
                                           SPRAS = 'E'.
IF SY-SUBRC = 0.
  WA_FINAL-INCO_TEXT  =   WA_TINCT-BEZEI.

ENDIF.

READ TABLE IT_MM_TVZBT INTO WA_MM_TVZBT WITH KEY ZTERM = WA_LFM1-ZTERM
                                                 SPRAS = 'E'.

IF SY-SUBRC = 0.
  WA_FINAL-VTEXT   = WA_MM_TVZBT-VTEXT.

ENDIF.

IF wa_final-vtext IS INITIAL.
SELECT SINGLE TEXT1 INTO wa_t052u-text1 FROM t052u WHERE ZTERM = WA_LFM1-ZTERM
                                                     AND SPRAS = 'E'.
  wa_final-decri = wa_t052u-text1.
ENDIF.

READ TABLE IT_FI_TVZBT INTO WA_FI_TVZBT WITH KEY ZTERM = WA_LFB1-ZTERM
                                                 SPRAS = 'E'.

IF SY-SUBRC = 0.
  WA_FINAL-VTEXT1   = WA_FI_TVZBT-VTEXT.

ENDIF.

IF WA_FINAL-VTEXT1 IS INITIAL.
SELECT SINGLE TEXT1 INTO WA_t052u-text1 FROM t052u WHERE ZTERM = WA_LFB1-ZTERM
                                                      AND SPRAS = 'E'.
wa_final-decri1 = wa_t052u-text1.
else.
  wa_final-decri1 = wa_final-vtext1.
ENDIF.



READ TABLE IT_T059U INTO WA_T059U WITH KEY WITHT = WA_LFBW-WT_WITHCD
                                           SPRAS = 'E'
                                           LAND1 = 'IN'.
IF SY-SUBRC = 0.
  WA_FINAL-TEXT40    =    WA_T059U-TEXT40.

ENDIF.
"BREAK-POINT.
if wa_t052u-text1 is INITIAL.
  WA_FINAL-decri =   WA_FINAL-VTEXT.
endif.
***********************************************Dowanload Data*********************************************
        LS_FINAL-LIFNR                 =                    WA_FINAL-LIFNR    .
        LS_FINAL-KTOKK                 =                    WA_FINAL-KTOKK .
        LS_FINAL-ANRED                 =                    WA_FINAL-ANRED .
        LS_FINAL-NAME1                 =                    WA_FINAL-NAME1 .
        LS_FINAL-NAME2                 =                    WA_FINAL-NAME2 .
        LS_FINAL-SORTL                 =                    WA_FINAL-SORTL .
        LS_FINAL-KUNNR                 =                    WA_FINAL-KUNNR .
        LS_FINAL-BUKRS                 =                    WA_FINAL-BUKRS.
        LS_FINAL-AKONT                 =                    WA_FINAL-AKONT.
        LS_FINAL-ZUAWA                 =                    WA_FINAL-ZUAWA.
        LS_FINAL-REPRF                 =                    WA_FINAL-REPRF.
        LS_FINAL-ZTERM1                =                    WA_FINAL-ZTERM1.
        LS_FINAL-STR_SUPPL1            =                    WA_FINAL-STR_SUPPL1.
        LS_FINAL-STR_SUPPL2            =                    WA_FINAL-STR_SUPPL2.
        LS_FINAL-STR_SUPPL3            =                    WA_FINAL-STR_SUPPL3.
        LS_FINAL-STREET                =                    WA_FINAL-STREET    .
        LS_FINAL-HOUSE_NUM1            =                    WA_FINAL-HOUSE_NUM1.
        LS_FINAL-CITY2                 =                    WA_FINAL-CITY2     .
        LS_FINAL-POST_CODE1            =                    WA_FINAL-POST_CODE1.
        LS_FINAL-CITY1                 =                    WA_FINAL-CITY1     .
        LS_FINAL-COUNTRY               =                    WA_FINAL-COUNTRY   .
        LS_FINAL-REGION                =                    WA_FINAL-REGION    .
        LS_FINAL-PO_BOX                =                    WA_FINAL-PO_BOX    .
        LS_FINAL-LANGU                 =                    WA_FINAL-LANGU     .
        LS_FINAL-TEL_NUMBER            =                    WA_FINAL-TEL_NUMBER.
        LS_FINAL-FAX_NUMBER            =                    WA_FINAL-FAX_NUMBER.
        LS_FINAL-BANKS                 =                    WA_FINAL-BANKS.
        LS_FINAL-BANKL                 =                    WA_FINAL-BANKL.
        LS_FINAL-BANKN                 =                    WA_FINAL-BANKN.
        LS_FINAL-KOINH                 =                    WA_FINAL-KOINH.
        LS_FINAL-EKORG                 =                    WA_FINAL-EKORG.
        LS_FINAL-WAERS                 =                    WA_FINAL-WAERS.
        LS_FINAL-ZTERM                 =                    WA_FINAL-ZTERM.
        LS_FINAL-INCO1                 =                    WA_FINAL-INCO1.
        LS_FINAL-INCO2                 =                    WA_FINAL-INCO2.
        LS_FINAL-WEBRE                 =                    WA_FINAL-WEBRE.
        LS_FINAL-LEBRE                 =                    WA_FINAL-LEBRE.
        LS_FINAL-KZABS                 =                    WA_FINAL-KZABS.
        LS_FINAL-J_1ICSTNO             =                    WA_FINAL-J_1ICSTNO.
        LS_FINAL-J_1ILSTNO             =                    WA_FINAL-J_1ILSTNO.
        LS_FINAL-J_1ISERN              =                    WA_FINAL-J_1ISERN .
        LS_FINAL-J_1IEXCD              =                    WA_FINAL-J_1IEXCD .
        LS_FINAL-J_1IEXRN              =                    WA_FINAL-J_1IEXRN .
        LS_FINAL-J_1IEXRG              =                    WA_FINAL-J_1IEXRG .
        LS_FINAL-J_1IEXDI              =                    WA_FINAL-J_1IEXDI .
        LS_FINAL-J_1IEXCO              =                    WA_FINAL-J_1IEXCO .
        LS_FINAL-J_1IVTYP              =                    WA_FINAL-J_1IVTYP .
        LS_FINAL-J_1IPANNO             =                    WA_FINAL-J_1IPANNO.
        LS_FINAL-WT_WITHCD             =                    WA_FINAL-WT_WITHCD.
        LS_FINAL-WT_SUBJCT             =                    WA_FINAL-WT_SUBJCT.
        LS_FINAL-BANKA                 =                    WA_FINAL-BANKA.
        LS_FINAL-BRNCH                 =                    WA_FINAL-BRNCH.
        LS_FINAL-PROVZ                 =                    WA_FINAL-PROVZ.
        LS_FINAL-STRAS                 =                     WA_FINAL-STRAS.
        LS_FINAL-ORT01                 =                    WA_FINAL-ORT01.
        LS_FINAL-SWIFT                 =                    WA_FINAL-SWIFT.
        LS_FINAL-SMTP_ADDR             =                    WA_FINAL-SMTP_ADDR.
        LS_FINAL-STCD3                 =                    WA_FINAL-STCD3.
        LS_FINAL-BEZEI                 =                    WA_T005U-BEZEI.
        LS_FINAL-INCO_TEXT             =                    WA_FINAL-INCO_TEXT.
        "LS_FINAL-VTEXT                 =                    WA_FINAL-VTEXT.
        LS_FINAL-vtext                 =                    WA_FINAL-decri.
       " LS_FINAL-VTEXT1                =                    WA_FINAL-VTEXT1.
        LS_FINAL-VTEXT1                =                    WA_FINAL-decri1.
        LS_FINAL-TEXT40                =                    WA_FINAL-TEXT40.
        LS_FINAL-NAME_CO               =                    WA_FINAL-NAME_CO.
        ls_final-ref                   =                    sy-datum.
        LS_FINAL-ernam                 =                    WA_FINAL-ernam.
 CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
    EXPORTING
      input         = ls_final-ref
   IMPORTING
     OUTPUT        = ls_final-ref
            .

CONCATENATE ls_final-ref+0(2) ls_final-ref+2(3) ls_final-ref+5(4)
                INTO ls_final-ref SEPARATED BY '-'.




APPEND LS_FINAL TO LT_FINAL.
APPEND WA_FINAL TO IT_FINAL.
CLEAR:WA_FINAL,WA_T059U,WA_LFA1,WA_LFB1,WA_LFM1,WA_ADRC,WA_ADR6,WA_LFBK,WA_LFBW,WA_BNKA,WA_T005U,WA_TINCT,WA_MM_TVZBT,WA_FI_TVZBT,WA_J_1IMOVEND .
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
PERFORM FCAT USING :  '1'  'LIFNR '          'IT_FINAL'  'Number of Vendor'           '18' ,
                      '2'  'BUKRS '          'IT_FINAL'  'Company Code'               '18',
                      '3'  'EKORG '          'IT_FINAL'  'Pur.Org'                    '18' ,
                      '4'  'KTOKK '          'IT_FINAL'  'Ven.ac.group'               '18' ,
                      '5'  'ANRED '          'IT_FINAL'  'Title'                      '10' ,
                      '6'  'NAME1 '          'IT_FINAL'  'Name 1'                     '30' ,
                      '7'  'NAME2 '          'IT_FINAL'  'Name 2'                     '30' ,
                      '8'  'SORTL '          'IT_FINAL'  'Sort field'                 '10' ,
                      '9'  'STR_SUPPL1'      'IT_FINAL'  'Street 1'                   '30' ,
                     '10'  'STR_SUPPL2'      'IT_FINAL'  'Street 2'                   '30' ,
                     '11'  'STR_SUPPL3'      'IT_FINAL'  'Street 3'                   '30' ,
                     '12'  'STREET    '      'IT_FINAL'  'Street'                     '30' ,
                     '13'  'HOUSE_NUM1'      'IT_FINAL'  'House NO'                   '10' ,
                     '14'  'CITY2     '     'IT_FINAL'  'District'                   '18' ,
                     '15'  'POST_CODE1'     'IT_FINAL'  'City postal code'           '18' ,
                     '16'  'CITY1   '       'IT_FINAL'  'City'                       '18' ,
                     '17'  'COUNTRY '       'IT_FINAL'  'Country Key'                '18' ,
                     '18'  'REGION  '       'IT_FINAL'  'Region'                     '18' ,
                     '19'  'BEZEI  '        'IT_FINAL'  'Reg.Desc'                   '18' ,
                     '20'  'PO_BOX  '       'IT_FINAL'  'PO Box'                     '10' ,
                     '21'  'LANGU     '     'IT_FINAL'  'Language'                   '10' ,
                     '22'  'TEL_NUMBER'     'IT_FINAL'  'Telephone NO'               '10' ,
                     '23'  'FAX_NUMBER'     'IT_FINAL'  'Fax no'                     '10' ,
                     '24'  'SMTP_ADDR '     'IT_FINAL'  'E-Mail'                     '18' ,
                     '25'  'BANKS     '     'IT_FINAL'  'Bank '                      '18' ,
                     '26'  'BANKL     '     'IT_FINAL'  'Bank Keys'                  '18' ,
                     '27'  'BANKN'          'IT_FINAL'  'Bank A/C.No'                '18' ,
                     '28'  'KOINH'          'IT_FINAL'  'A/C Holder Name'            '18' ,
                     '29'  'BANKA'          'IT_FINAL'  'Name of bank'               '18' ,
                     '30'  'BRNCH'          'IT_FINAL'  'Bank Branch'                '18' ,
                     '31'  'PROVZ'          'IT_FINAL'  'Region'                     '18' ,
                     '32'  'STRAS'          'IT_FINAL'  'House Number'               '18' ,
                     '33'  'ORT01'          'IT_FINAL'  'City'                       '18' ,
                     '34'  'SWIFT'          'IT_FINAL'  'International Payment'      '18' ,
                     '35'  'AKONT '         'IT_FINAL'  'Recon.AC Gen.Ledger'        '18' ,
                     '36'  'ZUAWA '         'IT_FINAL'  'Assig. No'                  '18' ,
                     '37'  'ZTERM1'         'IT_FINAL'  'FI Terms of Payment'        '18' ,
                     '38'  'DECRI1'         'IT_FINAL'  'Desc.Terms of Payment'      '50' ,
                     '39'  'REPRF '         'IT_FINAL'  'Invoices Flag'              '18' ,
                     '40'  'WAERS '         'IT_FINAL'  'Pur.order Curren'           '18' ,
                     '41'  'ZTERM'          'IT_FINAL'  'MM Terms of Payment'        '18' ,
                     '42'  'DECRI'          'IT_FINAL'  'Desc.Terms of Payment'      '50' ,
                     '43'  'INCO1'          'IT_FINAL'  'Incoterms1'                 '18' ,
                     '44'  'INCO_TEXT'      'IT_FINAL'  'INCO1 TEXT'                 '20' ,
                     '45'  'INCO2'          'IT_FINAL'  'Incoterms2'                 '18' ,
                     '46'  'WEBRE'          'IT_FINAL'  'GR-Based Inv'               '18' ,
                     '47'  'LEBRE'          'IT_FINAL'  'Service-Based Inv'          '18' ,
                     '48'  'KZABS'          'IT_FINAL'  'Ackn.Req'                   '18' ,
                     '49'  'KUNNR'          'IT_FINAL'  'Customer No'                '18' ,
                     '50'  'J_1ICSTNO'      'IT_FINAL'  'Central Sales Tax No'       '18' ,
                     '51'  'J_1ILSTNO'      'IT_FINAL'  'Local Sales Tax No'         '18' ,
                     '52'  'J_1ISERN '      'IT_FINAL'  'Serv.Tax Regi No'           '18' ,
                     '53'  'J_1IEXCD '      'IT_FINAL'  'ECC No'                     '18' ,
                     '54'  'J_1IEXRN '      'IT_FINAL'  'Excise Regi.No'             '18' ,
                     '55'  'J_1IEXRG '      'IT_FINAL'  'Excise Range'               '18' ,
                     '56'  'J_1IEXDI '      'IT_FINAL'  'Excise Divi'                '18' ,
                     '57'  'J_1IEXCO '      'IT_FINAL'  'Excise Commis.rate'         '18' ,
                     '58'  'J_1IVTYP '      'IT_FINAL'  'Type of Vendor'             '18' ,
                     '59'  'J_1IPANNO'      'IT_FINAL'  'PAN No'                     '18' ,
                     '60'  'WT_WITHCD'      'IT_FINAL'  'Withholding tax code'       '18' ,
                     '61'  'TEXT40'         'IT_FINAL'  'Desc.WitH.tax code'         '20' ,
                     '62'  'WT_SUBJCT'      'IT_FINAL'  'withholding tax indi'       '18' ,
                     '63'  'STCD3'          'IT_FINAL'  'GSTIN No'                   '18' ,
                     '64'  'NAME_CO'        'IT_FINAL'  'C/O name'                   '20' ,
                     '65'  'ernam'          'IT_FINAL'  'Created by'                 '20'.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_1013   text
*      -->P_1014   text
*      -->P_1015   text
*      -->P_1016   text
*      -->P_1017   text
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
  lv_file = 'ZUS_VENDOR_MASTER.TXT'.

  CONCATENATE p_folder '/' lv_file
    INTO lv_fullfile.
*BREAK primus.
  WRITE: / 'ZVENDOR_MASTER started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1015 TYPE string.
DATA lv_crlf_1015 TYPE string.
lv_crlf_1015 = cl_abap_char_utilities=>cr_lf.
lv_string_1015 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1015 lv_crlf_1015 wa_csv INTO lv_string_1015.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_1854 TO lv_fullfile.
TRANSFER lv_string_1015 TO lv_fullfile.
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
  CONCATENATE 'Number of Vendor'
              'Company Code'
              'Pur.Org'
              'Ven.ac.group'
              'Title'
              'Name 1'
              'Name 2'
              'Sort field'
              'Street 1'
              'Street 2'
              'Street 3'
              'Street'
              'House NO'
              'District'
              'City postal code'
              'City'
              'Country Key'
              'Region'
              'Reg.Desc'
              'PO Box'
              'Language'
              'Telephone NO'
              'Fax no'
              'E-Mail'
              'Bank '
              'Bank Keys'
              'Bank A/C.No'
              'A/C Holder Name'
              'Name of bank'
              'Bank Branch'
              'Region'
              'House Number'
              'City'
              'International Payment'
              'Recon.AC Gen.Ledger'
              'Assig. No'
              'FI Terms of Payment'
              'Desc.Terms of Payment'
              'Invoices Flag'
              'Pur.order Curren'
              'MM Terms of Payment'
              'Desc.Terms of Payment'
              'Incoterms1'
              'INCO1 TEXT'
              'Incoterms2'
              'GR-Based Inv'
              'Service-Based Inv'
              'Ackn.Req'
              'Customer No'
              'Central Sales Tax No'
              'Local Sales Tax No'
              'Serv.Tax Regi No'
              'ECC No'
              'Excise Regi.No'
              'Excise Range'
              'Excise Divi'
              'Excise Commis.rate'
              'Type of Vendor'
              'PAN No'
              'Withholding tax code'
              'Desc.WitH.tax code'
              'withholding tax indi'
              'GSTIN No'
              'Refresh Date'
              'C/O name'
              'Created By' INTO pd_csv
              SEPARATED BY l_field_seperator.
ENDFORM.

*&---------------------------------------------------------------------*
*&  Include           ZUS_AP_PUR_REGISTER_01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GET_DATA .

  DATA:
    LT_BSEG        TYPE TT_BSEG,
    LT_BSEG1       TYPE TT_BSEG,
    LS_BSEG        TYPE T_BSEG,
    LT_MAT_MAST    TYPE TT_MAT_MAST,
    LS_MAT_MAST    TYPE T_MAT_MAST,
    LT_ADRC        TYPE TT_ADRC,
    LS_ADRC        TYPE T_ADRC,
    LT_DD07T       TYPE TT_DD07T,
    LS_DD07T       TYPE T_DD07T,
    LT_ZGST_REGION TYPE TT_ZGST_REGION,
    LS_ZGST_REGION TYPE T_ZGST_REGION,
    LT_SKAT        TYPE TT_SKAT,
    LS_SKAT        TYPE T_SKAT,
    LT_MARC        TYPE TT_MARC,
    LS_MARC        TYPE T_MARC,
    LT_EKET        TYPE TT_EKET,
    LS_EKET        TYPE T_EKET,
    LT_T007S       TYPE TT_T007S,
    LS_T007S       TYPE T_T007S,
    LT_QALS        TYPE TT_QALS,
    LS_QALS        TYPE T_QALS,
    LT_QAMB        TYPE TT_QAMB,
    LS_QAMB        TYPE T_QAMB,
    LT_MSEG        TYPE TT_MSEG,
    LS_MSEG        TYPE T_MSEG,
    LT_T163Y       TYPE TT_T163Y,
    LS_T163Y       TYPE T_T163Y,
    LT_RSEG        LIKE GT_RSEG OCCURS 0 WITH HEADER LINE.

  DATA:
    LV_INDEX TYPE SY-TABIX,
    LV_ID    TYPE THEAD-TDNAME,
    LT_LINES TYPE STANDARD TABLE OF TLINE,
    LS_LINES TYPE TLINE.

  DATA:
    LV_CGST TYPE BSET-HWSTE,
    LV_SGST TYPE BSET-HWSTE,
    LV_IGST TYPE BSET-HWSTE.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      TEXT       = 'Reading data...'(i01)
      PERCENTAGE = 1.

*Get Data from BKPF Table 'RE' Docs
*break primus.
  SELECT BUKRS
         BELNR
         GJAHR
         BLART
         BLDAT
         BUDAT
         XBLNR
         WAERS
         KURSF
         AWKEY
         TCODE
         XBLNR_ALT
  FROM BKPF
  INTO TABLE GT_BKPF
  WHERE GJAHR IN S_GJAHR "bukrs IN s_bukrs
*    AND gjahr IN s_gjahr
    AND BUDAT IN S_BUDAT
    AND BLART IN ('RE','RL','KG','KR','RX')
    AND BUKRS = 'US00'.

  SORT GT_BKPF BY BELNR BLART.
  LOOP AT GT_BKPF.
    GT_BKPF-G_BELNR = GT_BKPF-AWKEY+0(10).
    GT_BKPF-G_GJAHR = GT_BKPF-AWKEY+10(4).
    IF SY-SUBRC EQ 0.
      MODIFY GT_BKPF TRANSPORTING G_BELNR G_GJAHR.
    ENDIF.
  ENDLOOP.


*** Getting MIGO no.
  IF GT_BKPF[] IS NOT INITIAL .


    SELECT BELNR
           GJAHR
           LIFNR
           BLART
           BLDAT
           XRECH
           STBLG
           ZUONR
           BKTXT

    FROM RBKP
    INTO TABLE GT_RBKP
    FOR ALL ENTRIES IN GT_BKPF
    WHERE BELNR = GT_BKPF-G_BELNR
      AND GJAHR = GT_BKPF-G_GJAHR
      AND TCODE IN ('MIRO','MIR7')
      AND RBSTAT = '5'
      AND LIFNR IN S_LIFNR. " avinash bhagat

    IF NOT GT_RBKP[] IS INITIAL.
      SELECT LIFNR
             NAME1
             REGIO
             ORT01
             LAND1
             ADRNR
             STCD3
        FROM LFA1
        INTO TABLE GT_LFA1
        FOR ALL ENTRIES IN GT_RBKP
        WHERE LIFNR = GT_RBKP-LIFNR
        AND LIFNR IN S_LIFNR. " avinash bhagat

      IF GT_LFA1[] IS NOT INITIAL.
        SELECT LIFNR AKONT
          FROM LFB1
          INTO TABLE GT_LFB1
          FOR ALL ENTRIES IN GT_LFA1
          WHERE LIFNR = GT_LFA1-LIFNR
          AND LIFNR IN S_LIFNR. "avinash bhagat
*            AND bukrs IN s_bukrs.

      ENDIF.
*break primus.
      SELECT BELNR
             GJAHR
             BUZEI
             EBELN
             EBELP
             MATNR
             BUKRS
             WRBTR
             MENGE
             MEINS
             SHKZG
             MWSKZ
             BKLAS
             BNKAN
             KSCHL
             LFBNR
             LFGJA
             LFPOS
             WERKS
             STUNR
             EXKBE
             PSTYP
             XEKBZ
      FROM RSEG
      INTO TABLE GT_RSEG
      FOR ALL ENTRIES IN GT_RBKP
      WHERE BELNR = GT_RBKP-BELNR
        AND GJAHR = GT_RBKP-GJAHR
        AND WERKS IN S_WERKS
        AND EBELN IN S_EBELN.
*        and lifnr in s_lifnr.   " avinash bhagat
*        and bustw = 'RE01'.        " Added to Remove Auto Parked Invoices and not Posted
    ENDIF.
  ENDIF.
*********** Changing Document Item Numbering in RSEG based on BSET ***********

  GT_RSEG_V1[] = GT_RSEG[].
  LT_RSEG[] = GT_RSEG[].
  SORT GT_RSEG_V1 BY BELNR GJAHR.
  DELETE ADJACENT DUPLICATES FROM GT_RSEG_V1 COMPARING BELNR GJAHR.

  SORT GT_RSEG BY BELNR GJAHR BUZEI ASCENDING.
  DELETE LT_RSEG WHERE LFBNR IS INITIAL.
  IF NOT LT_RSEG[] IS INITIAL .
    LOOP AT LT_RSEG.
      CONCATENATE LT_RSEG-LFBNR LT_RSEG-LFGJA
             INTO LT_RSEG-AWKEY.
      IF SY-SUBRC EQ 0.
        MODIFY LT_RSEG TRANSPORTING AWKEY.
      ENDIF.
    ENDLOOP.

  ENDIF.
  DATA  : LV_BUZEI TYPE BUZEI.

  LOOP AT GT_RSEG_V1.
    CLEAR : LV_BUZEI.
    LOOP AT GT_RSEG WHERE BELNR = GT_RSEG_V1-BELNR
                      AND GJAHR = GT_RSEG_V1-GJAHR .
      LV_BUZEI      = LV_BUZEI + 1.
      GT_RSEG-BUZEI = LV_BUZEI.
      MODIFY GT_RSEG TRANSPORTING BUZEI.
    ENDLOOP.
  ENDLOOP.

  CLEAR : LV_BUZEI, GT_RSEG_V1[].
*******************************************

  GT_RSEG_V1[] = GT_RSEG[].
  SORT GT_RSEG_V1 BY BELNR GJAHR EBELN EBELP.
  SORT GT_RSEG BY BELNR GJAHR EBELN EBELP.
  DELETE ADJACENT DUPLICATES FROM GT_RSEG_V1 COMPARING BELNR GJAHR EBELN EBELP.

  DATA:
    LV_IND   TYPE SY-TABIX,
    LV_MENGE TYPE MSEG-MENGE.

  IF GT_RSEG_V1[] IS NOT INITIAL.
    LOOP AT GT_RSEG_V1.
      READ TABLE GT_RSEG WITH KEY BELNR = GT_RSEG_V1-BELNR
                                  GJAHR = GT_RSEG_V1-GJAHR
                                  EBELN = GT_RSEG_V1-EBELN
                                  EBELP = GT_RSEG_V1-EBELP.

      IF SY-SUBRC IS INITIAL AND GT_RSEG-LFBNR IS NOT INITIAL.
        LV_IND = SY-TABIX.
        LOOP AT GT_RSEG FROM LV_IND.
          IF GT_RSEG-BELNR = GT_RSEG_V1-BELNR AND GT_RSEG-GJAHR = GT_RSEG_V1-GJAHR AND GT_RSEG-LFBNR IS NOT INITIAL
          AND GT_RSEG-EBELN = GT_RSEG_V1-EBELN AND GT_RSEG-EBELP = GT_RSEG_V1-EBELP.
            LV_MENGE = LV_MENGE + GT_RSEG-MENGE.
          ELSE.
            EXIT.
          ENDIF.

        ENDLOOP.
        GT_RSEG_V1-MENGE = LV_MENGE.
        CLEAR LV_MENGE.
      ENDIF.
      CONCATENATE GT_RSEG_V1-LFBNR GT_RSEG_V1-LFGJA
             INTO GT_RSEG_V1-AWKEY.
      IF SY-SUBRC EQ 0.
        MODIFY GT_RSEG_V1 TRANSPORTING AWKEY MENGE.
      ENDIF.
    ENDLOOP.

    SELECT BUKRS
           BELNR
           GJAHR
           BLART
           BLDAT
           BUDAT
           XBLNR
           WAERS
           KURSF
           AWKEY
           TCODE
    FROM BKPF
    INTO TABLE GT_BKPF_WE
    FOR ALL ENTRIES IN GT_RSEG_V1
    WHERE AWKEY = GT_RSEG_V1-AWKEY.

    IF NOT LT_RSEG IS INITIAL.
      SELECT BUKRS
             BELNR
             GJAHR
             BLART
             BLDAT
             BUDAT
             XBLNR
             WAERS
             KURSF
             AWKEY
             TCODE
             XBLNR_ALT
      FROM BKPF
      APPENDING TABLE GT_BKPF_WE
      FOR ALL ENTRIES IN LT_RSEG
      WHERE AWKEY = LT_RSEG-AWKEY.
    ENDIF.
    IF NOT GT_BKPF_WE[] IS INITIAL.
      SELECT BUKRS
             BELNR
             GJAHR
             BUZEI
             SHKZG
             DMBTR
             KTOSL
             ANLN1
             ANLN2
             HKONT
             EBELN
             EBELP
        FROM BSEG
        INTO TABLE LT_BSEG
        FOR ALL ENTRIES IN GT_BKPF_WE
        WHERE BUKRS = GT_BKPF_WE-BUKRS
        AND   BELNR = GT_BKPF_WE-BELNR
        AND   GJAHR = GT_BKPF_WE-GJAHR.
    ENDIF.
  ENDIF.


********** Processing SERVICE ENTRY SHEETS

  GT_RSEG_SES[] = GT_RSEG[].
  SORT GT_RSEG_SES BY PSTYP.
  DELETE GT_RSEG_SES WHERE PSTYP NE '9'.
  SORT GT_RSEG_SES BY BELNR GJAHR LFBNR LFGJA EBELN EBELP.
  DELETE ADJACENT DUPLICATES FROM GT_RSEG_SES COMPARING BELNR GJAHR LFBNR LFGJA EBELN EBELP.

  IF GT_RSEG_SES[] IS NOT INITIAL.
    SELECT EBELN
           EBELP
           GJAHR
           BELNR
           XBLNR
           LFGJA
           LFBNR
           LFPOS
           LSMNG
    FROM EKBE
    INTO TABLE GT_EKBE
    FOR ALL ENTRIES IN GT_RSEG_SES
    WHERE EBELN EQ GT_RSEG_SES-EBELN
      AND EBELP EQ GT_RSEG_SES-EBELP
      AND LFGJA EQ GT_RSEG_SES-LFGJA
      AND LFBNR EQ GT_RSEG_SES-LFBNR
      AND BEWTP EQ 'E'
      AND BWART EQ '101'.

  ENDIF.

***DATA:
**   ls_ekbe LIKE gt_ekbe.
  IF GT_EKBE[] IS NOT INITIAL.
    SORT GT_EKBE.
    LOOP AT GT_EKBE.
****      READ TABLE gt_ekbe INTO ls_ekbe INDEX sy-tabix + 1.
****      IF gt_ekbe-belnr = ls_ekbe-belnr AND gt_ekbe-ebeln = ls_ekbe-belnr AND gt_ekbe-ebelp = ls_ekbe-ebelp.
****        gt_ekbe-lsmng = gt_ekbe-lsmng +
****      ENDIF.
      CONCATENATE GT_EKBE-BELNR GT_EKBE-GJAHR
             INTO GT_EKBE-AWKEY.
      IF SY-SUBRC EQ 0.
        MODIFY GT_EKBE TRANSPORTING AWKEY.
      ENDIF.
    ENDLOOP.

    SELECT BUKRS
           BELNR
           GJAHR
           BLART
           BLDAT
           BUDAT
           XBLNR
           WAERS
           KURSF
           AWKEY
           TCODE
           XBLNR_ALT
    FROM BKPF
    INTO TABLE GT_BKPF_SES
    FOR ALL ENTRIES IN GT_EKBE
    WHERE GJAHR = GT_EKBE-GJAHR
      AND AWKEY = GT_EKBE-AWKEY.


    IF NOT GT_BKPF_SES[] IS INITIAL.
      SELECT BUKRS
             BELNR
             GJAHR
             BUZEI
             SHKZG
             DMBTR
             KTOSL
             ANLN1
             ANLN2
             HKONT
             EBELN
             EBELP
        FROM BSEG
        APPENDING TABLE LT_BSEG
        FOR ALL ENTRIES IN GT_BKPF_SES
        WHERE BUKRS = GT_BKPF_SES-BUKRS
        AND   BELNR = GT_BKPF_SES-BELNR
        AND   GJAHR = GT_BKPF_SES-GJAHR.
    ENDIF.
  ENDIF.

********** Processing IMPORT PO's

  GT_RSEG_IMP[] = GT_RSEG[].
  SORT GT_RSEG_IMP BY LFBNR.
  DELETE GT_RSEG_IMP WHERE LFBNR IS NOT INITIAL.
  SORT GT_RSEG_IMP BY EBELN EBELP.
  DELETE ADJACENT DUPLICATES FROM GT_RSEG_IMP COMPARING EBELN EBELP.

  IF GT_RSEG_IMP[] IS NOT INITIAL.
    SELECT EBELN
           EBELP
           GJAHR
           BELNR
           XBLNR
           LFGJA
           LFBNR
           LFPOS
           LSMNG
    FROM EKBE
    INTO TABLE GT_EKBE_IMP
    FOR ALL ENTRIES IN GT_RSEG_IMP
    WHERE EBELN EQ GT_RSEG_IMP-EBELN
      AND EBELP EQ GT_RSEG_IMP-EBELP
      AND BEWTP EQ 'E'
      AND BWART EQ '101'.
  ENDIF.
  SORT GT_EKBE_IMP BY BELNR DESCENDING EBELN EBELP.
  DELETE ADJACENT DUPLICATES FROM GT_EKBE_IMP COMPARING BELNR EBELN EBELP.


  IF GT_EKBE_IMP[] IS NOT INITIAL.

    LOOP AT GT_EKBE_IMP.
      CONCATENATE GT_EKBE_IMP-BELNR GT_EKBE_IMP-GJAHR
             INTO GT_EKBE_IMP-AWKEY.
      IF SY-SUBRC EQ 0.
        MODIFY GT_EKBE_IMP TRANSPORTING AWKEY.
      ENDIF.
    ENDLOOP.



  ENDIF.

  SELECT BUKRS
         BELNR
         GJAHR
         BLART
         BLDAT
         BUDAT
         XBLNR
         WAERS
         KURSF
         AWKEY
         TCODE
         XBLNR_ALT
  FROM BKPF
  INTO TABLE GT_BKPF_IMP
  FOR ALL ENTRIES IN GT_EKBE_IMP
  WHERE AWKEY = GT_EKBE_IMP-AWKEY.
*  ENDIF.

  IF NOT GT_BKPF_IMP[] IS INITIAL.
    SELECT BUKRS
           BELNR
           GJAHR
           BUZEI
           SHKZG
           DMBTR
           KTOSL
           ANLN1
           ANLN2
           HKONT
           EBELN
           EBELP
      FROM BSEG
      APPENDING TABLE LT_BSEG
      FOR ALL ENTRIES IN GT_BKPF_IMP
      WHERE BUKRS = GT_BKPF_IMP-BUKRS
      AND   BELNR = GT_BKPF_IMP-BELNR
      AND   GJAHR = GT_BKPF_IMP-GJAHR.
  ENDIF.

  SELECT BUKRS
         BELNR
         GJAHR
         TXGRP
         SHKZG
         MWSKZ
         HWBAS
         HWSTE
         KTOSL
         KSCHL
         KBETR
         BUZEI
         HKONT
         KNUMH
  FROM BSET
  INTO TABLE GT_BSET
  FOR ALL ENTRIES IN GT_BKPF
  WHERE BUKRS = GT_BKPF-BUKRS
    AND BELNR = GT_BKPF-BELNR
    AND GJAHR = GT_BKPF-GJAHR .



  IF GT_LFA1[] IS NOT INITIAL .
    SELECT * FROM T005U
    INTO TABLE GT_T005U
    FOR ALL ENTRIES IN GT_LFA1
    WHERE SPRAS = SY-LANGU
      AND LAND1 = GT_LFA1-LAND1
      AND BLAND = GT_LFA1-REGIO.

    SELECT GST_REGION
           BEZEI
      FROM ZGST_REGION
      INTO TABLE LT_ZGST_REGION
      FOR ALL ENTRIES IN GT_T005U
      WHERE BEZEI = GT_T005U-BEZEI.

    SELECT ADDRNUMBER
           NAME1
           CITY2
           POST_CODE1
           STREET
           STR_SUPPL3
           LOCATION
           COUNTRY
      FROM ADRC
      INTO TABLE LT_ADRC
      FOR ALL ENTRIES IN GT_LFA1
      WHERE ADDRNUMBER = GT_LFA1-ADRNR.

    SELECT LIFNR
           J_1ILSTNO
           J_1IPANNO
           J_1ISERN
           J_1ICSTNO
           J_1IEXCD
           VEN_CLASS
      FROM J_1IMOVEND
      INTO TABLE GT_J_1IMOVEND
      FOR ALL ENTRIES IN GT_LFA1
      WHERE LIFNR EQ GT_LFA1-LIFNR.
  ENDIF.
  IF NOT GT_J_1IMOVEND[] IS INITIAL.
    SELECT VALPOS
           DDTEXT
           DOMVALUE_L
      FROM DD07T
      INTO TABLE LT_DD07T
      FOR ALL ENTRIES IN GT_J_1IMOVEND
      WHERE DOMNAME    = 'J_1IGTAXKD'
      AND   DOMVALUE_L = GT_J_1IMOVEND-VEN_CLASS
      AND   DDLANGUAGE = SY-LANGU.


  ENDIF.
  IF GT_RSEG[] IS NOT INITIAL .
    SELECT MBLNR
           MJAHR
           ZEILE
           BWART
           LGORT
           INSMK
           EBELN
           EBELP
           MENGE
           LSMNG
      FROM MSEG
      INTO TABLE LT_MSEG
      FOR ALL ENTRIES IN GT_RSEG
      WHERE MJAHR = GT_RSEG-LFGJA
      AND   MBLNR = GT_RSEG-LFBNR
      AND   ZEILE = GT_RSEG-LFPOS
      AND   BWART = '101'
      AND   LGORT = 'RM01'.
*      AND   insmk = space.

    SELECT PRUEFLOS
             EBELN
             EBELP
             MJAHR
             MBLNR
             ZEILE
        FROM QALS
        INTO TABLE LT_QALS
        FOR ALL ENTRIES IN GT_RSEG
        WHERE MJAHR = GT_RSEG-LFGJA
        AND   MBLNR = GT_RSEG-LFBNR
        AND   ZEILE = GT_RSEG-LFPOS.
    IF NOT LT_QALS IS INITIAL.
      SELECT PRUEFLOS
             MBLNR
             MJAHR
             ZEILE
        FROM QAMB
        INTO TABLE LT_QAMB
        FOR ALL ENTRIES IN LT_QALS
        WHERE PRUEFLOS = LT_QALS-PRUEFLOS
        AND   TYP = '3'.

      IF NOT LT_QAMB IS INITIAL.
        SELECT MBLNR
               MJAHR
               ZEILE
               BWART
               LGORT
               INSMK
               EBELN
               EBELP
               MENGE
               LSMNG
          FROM MSEG
          APPENDING TABLE LT_MSEG
          FOR ALL ENTRIES IN LT_QAMB
          WHERE MBLNR = LT_QAMB-MBLNR
          AND   MJAHR = LT_QAMB-MJAHR
*          AND   zeile = lt_qamb-zeile
          AND   BWART = '321'
          AND   XAUTO = 'X'.

      ENDIF.
    ENDIF.
    SELECT MATNR
           MAKTX
      FROM MAKT
      INTO TABLE GT_MAKT
      FOR ALL ENTRIES IN GT_RSEG
      WHERE MATNR = GT_RSEG-MATNR
      AND SPRAS = 'EN'.

    SELECT MATNR
           MTART
           MEINS
           WRKST
           ZSERIES
           ZSIZE
           BRAND
           MOC
           TYPE
      FROM MARA
      INTO TABLE LT_MAT_MAST
      FOR ALL ENTRIES IN GT_RSEG
      WHERE MATNR = GT_RSEG-MATNR.

    SELECT MATNR
           BWKEY
           BKLAS
           FROM MBEW INTO TABLE LT_MBEW
           FOR ALL ENTRIES IN GT_RSEG
           WHERE MATNR = GT_RSEG-MATNR
             AND BWKEY = GT_RSEG-WERKS.

    SELECT MWSKZ
           TEXT1
      FROM T007S
      INTO TABLE LT_T007S
      FOR ALL ENTRIES IN GT_RSEG
      WHERE MWSKZ = GT_RSEG-MWSKZ
      AND   KALSM = 'ZTAXIN'.

    SELECT MATNR
           WERKS
           STEUC
      FROM MARC
      INTO TABLE LT_MARC
      FOR ALL ENTRIES IN GT_RSEG
      WHERE MATNR = GT_RSEG-MATNR
      AND   WERKS = GT_RSEG-WERKS.

    SELECT EBELN
           EKORG
           EKGRP
           BSART
           AEDAT
           REVNO
    FROM EKKO
    INTO TABLE GT_EKKO
     FOR ALL ENTRIES IN GT_RSEG
    WHERE EBELN = GT_RSEG-EBELN.

    SELECT EBELN
           EBELP
           MATNR
           WERKS
           MENGE
           NETPR
           PEINH
           NETWR
           MWSKZ
           PSTYP
           KNTTP
    FROM EKPO
    INTO TABLE GT_EKPO
     FOR ALL ENTRIES IN GT_RSEG
    WHERE EBELN = GT_RSEG-EBELN
      AND EBELP = GT_RSEG-EBELP.

    SELECT EBELN
           EBELP
           ETENR
           EINDT
      FROM EKET
      INTO TABLE LT_EKET
      FOR ALL ENTRIES IN GT_EKPO
      WHERE EBELN = GT_EKPO-EBELN
      AND   EBELP = GT_EKPO-EBELP.

    SELECT PSTYP
           EPSTP
      FROM T163Y
      INTO TABLE LT_T163Y
      FOR ALL ENTRIES IN GT_EKPO
      WHERE SPRAS = SY-LANGU
      AND PSTYP = GT_EKPO-PSTYP.

    SORT GT_EKPO BY KNTTP.
    LOOP AT GT_EKPO WHERE KNTTP = 'A'  .
      MOVE-CORRESPONDING GT_EKPO TO GT_EKPO1.
      APPEND GT_EKPO1.
      CLEAR  GT_EKPO1.
    ENDLOOP.
    SORT GT_EKPO BY EBELN EBELP KNTTP.
  ENDIF.

  IF GT_EKPO1[] IS NOT INITIAL.
    SELECT EBELN EBELP ANLN1 ANLN2 SAKTO
      FROM EKKN
      INTO TABLE GT_EKKN
      FOR ALL ENTRIES IN GT_EKPO1
      WHERE EBELN = GT_EKPO1-EBELN
        AND EBELP = GT_EKPO1-EBELP.

    IF GT_EKKN[] IS NOT INITIAL.
      SELECT ANLN1
             ANLN2
             INVNR
             TXT50
        FROM ANLA
        INTO TABLE GT_ANLA
        FOR ALL ENTRIES IN GT_EKKN
        WHERE ANLN1 = GT_EKKN-ANLN1"bukrs IN s_bukrs
*          AND anln1 = gt_ekkn-anln1
          AND ANLN2 = GT_EKKN-ANLN2.
    ENDIF.
  ENDIF.

*** Populating FINAL TABLE

  SORT GT_RSEG_V1 BY BELNR EBELN EBELP.
  SORT GT_RSEG    BY BELNR EBELN EBELP.

****** New Code for BSET
  LOOP AT GT_RSEG.
    READ TABLE GT_BKPF WITH KEY G_BELNR = GT_RSEG-BELNR
                                G_GJAHR = GT_RSEG-GJAHR.
    IF SY-SUBRC = 0.
      LOOP AT GT_BSET WHERE BELNR = GT_BKPF-BELNR
                        AND TXGRP = GT_RSEG-BUZEI.
        MOVE-CORRESPONDING GT_BSET TO GT_BSET1.
        GT_BSET1-EBELN = GT_RSEG-EBELN.
        GT_BSET1-EBELP = GT_RSEG-EBELP.
        APPEND GT_BSET1.
        CLEAR  GT_BSET1.
      ENDLOOP.
*    APPEND gt_rseg.
    ENDIF.
  ENDLOOP.
****** End of New Code for BSET


  CLEAR : GT_FINAL[].

  SORT GT_BKPF    BY G_BELNR G_GJAHR.
  SORT GT_RSEG_V1 BY BELNR GJAHR EBELN EBELP.
  SORT GT_BSET1   BY BELNR EBELN EBELP.
  SORT LT_BSEG BY BELNR GJAHR BUZEI.
  DELETE ADJACENT DUPLICATES FROM LT_BSEG.
  SORT LT_QALS BY PRUEFLOS MBLNR MJAHR EBELN EBELP.
  SORT LT_QAMB BY PRUEFLOS.

  IF NOT LT_BSEG IS INITIAL.
    SELECT SAKNR
           TXT20
      FROM SKAT
      INTO TABLE LT_SKAT
      FOR ALL ENTRIES IN LT_BSEG
      WHERE SAKNR = LT_BSEG-HKONT
      AND   SPRAS = SY-LANGU
      AND   KTOPL = '1000'.
  ENDIF.



  LT_BSEG1 = LT_BSEG.
***  DELETE lt_bseg1 WHERE ktosl NE 'BSX'.
***  DELETE lt_bseg2 WHERE ktosl NE 'FRL'.
  SORT LT_BSEG1 BY BELNR GJAHR EBELN EBELP.
  SORT LT_MSEG BY MBLNR MJAHR EBELN EBELP.
*BREAK primus.
  LOOP AT GT_RSEG_V1.
    READ TABLE GT_BKPF WITH KEY G_BELNR = GT_RSEG_V1-BELNR
                                G_GJAHR = GT_RSEG_V1-GJAHR.

    IF SY-SUBRC = 0.
      READ TABLE GT_RBKP WITH KEY BELNR = GT_BKPF-G_BELNR
                                  GJAHR = GT_BKPF-G_GJAHR.
      IF SY-SUBRC = 0.
        GT_FINAL-MIRO_AC_DOC = GT_BKPF-BELNR.     " MIRO A/C Doc No
        GT_FINAL-BLART       = GT_BKPF-BLART.     " FI Doc Type


*            IF gt_rbkp-bldat IS NOT INITIAL.
*
*
*                CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*                  EXPORTING
*                    input  = gt_rbkp-bldat
*                  IMPORTING
*                    output = gt_final-bldat.
*
*                CONCATENATE gt_final-bldat+0(2) gt_final-bldat+2(3) gt_final-bldat+5(4)
*                           INTO gt_final-bldat SEPARATED BY '-'.
*
*            ENDIF.
*        IF NOT gt_bkpf-budat IS INITIAL.
*          CONCATENATE gt_bkpf-budat+6(2) gt_bkpf-budat+4(2) gt_bkpf-budat+0(4) INTO  gt_final-bill_dt SEPARATED BY '-'.
*        ELSE.
*          gt_final-bill_dt = 'NULL' .
*        ENDIF.
        GT_FINAL-BILL_DT    = GT_BKPF-BUDAT.
        GT_FINAL-BLDAT       = GT_BKPF-BUDAT.
        GT_FINAL-AWKEY       = GT_BKPF-G_BELNR.   " Bill Booking No.
        GT_FINAL-INV_NO      = GT_BKPF-XBLNR.     " Inv/Bill No.
        GT_FINAL-XBLNR_ALT   = GT_BKPF-XBLNR_ALT. " ODN.

*        IF NOT gt_bkpf-bldat IS INITIAL.
**          CONCATENATE gt_bkpf-bldat+6(2) gt_bkpf-bldat+4(2) gt_bkpf-bldat+0(4) INTO  gt_final-inv_dt SEPARATED BY '-'.
*        ELSE.
*          gt_final-inv_dt = 'NULL' .
*        ENDIF.
        GT_FINAL-TCODE       = GT_BKPF-TCODE.     " T-Code
        GT_FINAL-WAERS       = GT_BKPF-WAERS.     " Document Currency
        GT_FINAL-KURSF       = GT_BKPF-KURSF.     " Exchange rate
        GT_FINAL-LIFNR = GT_RBKP-LIFNR.      " Vendor
        GT_FINAL-ZUONR = GT_RBKP-ZUONR.      " Original Inv No.
        GT_FINAL-STBLG = GT_RBKP-STBLG.
        IF GT_FINAL-STBLG IS NOT INITIAL .
          SELECT SINGLE BUDAT INTO GT_FINAL-BKTXT FROM RBKP WHERE BELNR = GT_FINAL-STBLG." Original Inv Dt
        ENDIF.

*        gt_final-bktxt = gt_rbkp-bktxt.      " Original Inv Dt
*        REPLACE ALL OCCURRENCES OF '.' IN gt_final-bktxt WITH '-'.
        READ TABLE GT_LFA1 WITH KEY LIFNR = GT_RBKP-LIFNR.
        IF SY-SUBRC = 0.
          GT_FINAL-NAME1 = GT_LFA1-NAME1.    " Vendor Name
          GT_FINAL-STCD3 = GT_LFA1-STCD3.
          GT_FINAL-REGIO = GT_LFA1-REGIO.
          READ TABLE GT_T005U WITH KEY BLAND = GT_LFA1-REGIO.
          IF SY-SUBRC = 0.
            GT_FINAL-BEZEI = GT_T005U-BEZEI. " State
          ENDIF.
*          READ TABLE lt_zgst_region INTO ls_zgst_region WITH KEY bezei = gt_t005u-bezei.
*          IF sy-subrc IS INITIAL.
*            gt_final-gst_region = ls_zgst_region-gst_region.
*          ENDIF.
          READ TABLE LT_ADRC INTO LS_ADRC WITH KEY ADDRNUMBER = GT_LFA1-ADRNR.
          IF SY-SUBRC IS INITIAL.
            IF NOT LS_ADRC-STREET IS INITIAL.
              CONCATENATE GT_FINAL-ADDRESS LS_ADRC-STREET INTO GT_FINAL-ADDRESS.
            ENDIF.

            IF NOT LS_ADRC-STR_SUPPL3 IS INITIAL.
              CONCATENATE GT_FINAL-ADDRESS LS_ADRC-STR_SUPPL3 INTO GT_FINAL-ADDRESS SEPARATED BY ','.
            ENDIF.
            IF NOT LS_ADRC-LOCATION IS INITIAL.
              CONCATENATE GT_FINAL-ADDRESS LS_ADRC-LOCATION INTO GT_FINAL-ADDRESS SEPARATED BY ','.
            ENDIF.

            IF NOT LS_ADRC-CITY2 IS INITIAL.
              CONCATENATE GT_FINAL-ADDRESS LS_ADRC-CITY2 INTO GT_FINAL-ADDRESS SEPARATED BY ','.
            ENDIF.
            IF NOT LS_ADRC-POST_CODE1 IS INITIAL.
              CONCATENATE GT_FINAL-ADDRESS 'PIN:' LS_ADRC-POST_CODE1 INTO GT_FINAL-ADDRESS SEPARATED BY ','.
            ENDIF.
            CONDENSE GT_FINAL-ADDRESS.

          ENDIF.
          READ TABLE GT_J_1IMOVEND WITH KEY LIFNR = GT_LFA1-LIFNR.
          IF SY-SUBRC = 0.
            GT_FINAL-TIN_NO =   GT_J_1IMOVEND-J_1ICSTNO.
            GT_FINAL-LST_NO =   GT_J_1IMOVEND-J_1ILSTNO.
          ENDIF.
          READ TABLE LT_DD07T INTO LS_DD07T WITH KEY DOMVALUE_L = GT_J_1IMOVEND-VEN_CLASS.
          IF SY-SUBRC IS INITIAL.
            GT_FINAL-GST_TXT = LS_DD07T-DDTEXT.
          ENDIF.
          READ TABLE GT_LFB1 WITH KEY LIFNR = GT_LFA1-LIFNR.
          IF SY-SUBRC = 0.
            GT_FINAL-AKONT = GT_LFB1-AKONT.
          ENDIF.
        ENDIF.


        READ TABLE GT_BKPF_WE WITH KEY AWKEY = GT_RSEG_V1-AWKEY.
        IF SY-SUBRC = 0.

          GT_FINAL-BUDAT = GT_BKPF_WE-BUDAT.
*          IF NOT gt_bkpf_we-budat IS INITIAL.
*           CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = gt_bkpf_we-budat
*          IMPORTING
*            output = gt_final-budat.
*
*        CONCATENATE gt_final-budat+0(2) gt_final-budat+2(3) gt_final-budat+5(4)
*                   INTO gt_final-budat SEPARATED BY '-'.
*
*
**            CONCATENATE gt_bkpf_we-budat+6(2) gt_bkpf_we-budat+4(2) gt_bkpf_we-budat+0(4) INTO  gt_final-budat SEPARATED BY '-'.
*          ELSE.
*            gt_final-budat = 'NULL' .
*          ENDIF.

          GT_FINAL-BELNR = GT_BKPF_WE-BELNR.    " FI document No.
          READ TABLE LT_BSEG1 INTO LS_BSEG WITH KEY BUKRS = GT_BKPF_WE-BUKRS
                                                    BELNR = GT_BKPF_WE-BELNR
                                                    GJAHR = GT_BKPF_WE-GJAHR
                                                    EBELP = GT_RSEG_V1-EBELP
                                                    KTOSL = 'BSX'.
          IF SY-SUBRC IS INITIAL.
            LV_INDEX = SY-TABIX.
            GT_FINAL-HKONT   = LS_BSEG-HKONT.
            LOOP AT LT_BSEG1 INTO LS_BSEG FROM LV_INDEX.
              IF LS_BSEG-BUKRS = GT_BKPF_WE-BUKRS AND LS_BSEG-BELNR = GT_BKPF_WE-BELNR AND LS_BSEG-KTOSL = 'BSX'
                AND LS_BSEG-GJAHR = GT_BKPF_WE-GJAHR AND LS_BSEG-EBELP = GT_RSEG_V1-EBELP.
                IF LS_BSEG-SHKZG = 'S'.
                  GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT + LS_BSEG-DMBTR.
                ELSE.
                  GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT - LS_BSEG-DMBTR.
                ENDIF.

              ENDIF.
            ENDLOOP.

          ELSE.
            READ TABLE LT_BSEG1 INTO LS_BSEG WITH KEY BUKRS = GT_BKPF_WE-BUKRS
                                                      BELNR = GT_BKPF_WE-BELNR
                                                      GJAHR = GT_BKPF_WE-GJAHR
                                                      EBELP = GT_RSEG_V1-EBELP
                                                      KTOSL = 'FRL'.
            IF SY-SUBRC IS INITIAL.
              LV_INDEX = SY-TABIX.
              GT_FINAL-HKONT   = LS_BSEG-HKONT.
              LOOP AT LT_BSEG1 INTO LS_BSEG FROM LV_INDEX.
                IF LS_BSEG-BUKRS = GT_BKPF_WE-BUKRS AND LS_BSEG-BELNR = GT_BKPF_WE-BELNR AND LS_BSEG-KTOSL = 'FRL'
                  AND LS_BSEG-GJAHR = GT_BKPF_WE-GJAHR AND LS_BSEG-EBELP = GT_RSEG_V1-EBELP.
                  GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT + LS_BSEG-DMBTR.
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ELSE.
          READ TABLE LT_RSEG WITH KEY BELNR = GT_RSEG_V1-BELNR
                                      GJAHR = GT_RSEG_V1-GJAHR
                                      EBELN = GT_RSEG_V1-EBELN
                                      EBELP = GT_RSEG_V1-EBELP.
          IF SY-SUBRC IS INITIAL.
            CLEAR GT_BKPF_WE.
            READ TABLE GT_BKPF_WE WITH KEY AWKEY = LT_RSEG-AWKEY.
            IF SY-SUBRC = 0.
              GT_FINAL-BUDAT = GT_BKPF_WE-BUDAT .   " MIGO Date.
              GT_FINAL-BELNR = GT_BKPF_WE-BELNR.    " FI document No.
            ENDIF.
          ENDIF.
          READ TABLE LT_BSEG1 INTO LS_BSEG WITH KEY BUKRS = GT_BKPF_WE-BUKRS
                                                    BELNR = GT_BKPF_WE-BELNR
                                                    GJAHR = GT_BKPF_WE-GJAHR
                                                    EBELP = GT_RSEG_V1-EBELP
                                                    KTOSL = 'BSX'.
          IF SY-SUBRC IS INITIAL.
            LV_INDEX = SY-TABIX.
            GT_FINAL-HKONT   = LS_BSEG-HKONT.
            LOOP AT LT_BSEG1 INTO LS_BSEG FROM LV_INDEX.
              IF LS_BSEG-BUKRS = GT_BKPF_WE-BUKRS AND LS_BSEG-BELNR = GT_BKPF_WE-BELNR AND LS_BSEG-KTOSL = 'BSX'
                AND LS_BSEG-GJAHR = GT_BKPF_WE-GJAHR AND LS_BSEG-EBELP = GT_RSEG_V1-EBELP.
                GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT + LS_BSEG-DMBTR.
              ENDIF.
            ENDLOOP.
          ELSE.
            READ TABLE LT_BSEG1 INTO LS_BSEG WITH KEY BUKRS = GT_BKPF_WE-BUKRS
                                                    BELNR = GT_BKPF_WE-BELNR
                                                    GJAHR = GT_BKPF_WE-GJAHR
                                                    EBELP = GT_RSEG_V1-EBELP
                                                    KTOSL = 'FRL'.
            IF SY-SUBRC IS INITIAL.
              LV_INDEX = SY-TABIX.
              GT_FINAL-HKONT   = LS_BSEG-HKONT.
              LOOP AT LT_BSEG1 INTO LS_BSEG FROM LV_INDEX.
                IF LS_BSEG-BUKRS = GT_BKPF_WE-BUKRS AND LS_BSEG-BELNR = GT_BKPF_WE-BELNR AND LS_BSEG-KTOSL = 'FRL'
                  AND LS_BSEG-GJAHR = GT_BKPF_WE-GJAHR AND LS_BSEG-EBELP = GT_RSEG_V1-EBELP.
                  GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT + LS_BSEG-DMBTR.
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDIF.
        GT_FINAL-EBELP = GT_RSEG_V1-EBELP.     " PO item
        GT_FINAL-EBELN = GT_RSEG_V1-EBELN.     " PO No.

        READ TABLE LT_EKET INTO LS_EKET WITH KEY EBELN = GT_FINAL-EBELN
                                                 EBELP = GT_FINAL-EBELP.
        IF SY-SUBRC IS INITIAL.
          GT_FINAL-EINDT = LS_EKET-EINDT.
*          IF NOT ls_eket-eindt IS INITIAL.
*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = ls_eket-eindt
*          IMPORTING
*            output = gt_final-eindt.
*
*        CONCATENATE gt_final-eindt+0(2) gt_final-eindt+2(3) gt_final-eindt+5(4)
*                   INTO gt_final-eindt SEPARATED BY '-'.
*
**            CONCATENATE ls_eket-eindt+6(2) ls_eket-eindt+4(2) ls_eket-eindt+0(4) INTO gt_final-eindt SEPARATED BY '-'.
*          ELSE.
*            gt_final-eindt = 'NULL' .
*          ENDIF.
*        ELSE.
*          gt_final-eindt = 'NULL' .
        ENDIF.
****** New Code for BSET
        CLEAR: LV_CGST,LV_SGST,LV_IGST.
        LOOP AT GT_BSET1 WHERE BELNR = GT_BKPF-BELNR
                           AND EBELN = GT_RSEG_V1-EBELN
                           AND EBELP = GT_RSEG_V1-EBELP.
          "and gjahr = gt_bkpf-gjahr .

**          IF gt_bset1-kschl = 'JEC1' OR gt_bset1-kschl = 'JEC2' .
***          gt_final-ecs = gt_final-ecs + gt_bset-hwste.
***            gt_final-ecs = gt_final-ecs + gt_bset1-hwste.
**          ENDIF.
**          IF gt_bset1-kschl = 'JSEP' OR gt_bset1-kschl = 'JSEI' .
***          gt_final-hcess = gt_final-hcess + gt_bset-hwste.
**            gt_final-hcess = gt_final-hcess + gt_bset1-hwste.
**          ENDIF.

          IF GT_BSET1-KSCHL = 'JVCS'.
*          gt_final-cst_tax = gt_final-cst_tax + gt_bset-hwste.
            GT_FINAL-CST_TAX = GT_FINAL-CST_TAX + GT_BSET1-HWSTE.
            GT_FINAL-CST     = GT_BSET1-KBETR / 10.
            IF GT_FINAL-MWSKZ IS INITIAL AND GT_BSET1-HWSTE IS NOT INITIAL.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.
          IF GT_BSET1-KSCHL = 'JMOP' OR GT_BSET1-KSCHL = 'JMOQ' .
*          gt_final-bed = gt_final-bed + gt_bset-hwste.
            GT_FINAL-BED = GT_FINAL-BED + GT_BSET1-HWSTE.
            IF GT_FINAL-MWSKZ IS INITIAL AND GT_BSET1-HWSTE IS NOT INITIAL.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.
          IF GT_BSET1-KSCHL = 'JAOP' OR GT_BSET1-KSCHL = 'JAOQ' .
*          gt_final-aed = gt_final-aed + gt_bset-hwste.
            GT_FINAL-AED =  GT_FINAL-AED + GT_BSET1-HWSTE.
            IF GT_FINAL-MWSKZ IS INITIAL AND GT_BSET1-HWSTE IS NOT INITIAL.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.
          IF GT_BSET1-KSCHL = 'JVRD' OR GT_BSET1-KSCHL = 'JVRN'.
*          gt_final-vat_tax = gt_final-vat_tax + gt_bset-hwste.
            GT_FINAL-VAT_TAX = GT_FINAL-VAT_TAX + GT_BSET1-HWSTE.
            GT_FINAL-VAT     = GT_BSET1-KBETR / 10.
            IF GT_FINAL-MWSKZ IS INITIAL AND GT_BSET1-HWSTE IS NOT INITIAL.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.

          IF GT_BSET1-KSCHL = 'JICG' OR GT_BSET1-KSCHL = 'JICN'
          OR GT_BSET1-KSCHL = 'JICR' OR GT_BSET1-KSCHL = 'ZCRN'.
            IF GT_BSET1-SHKZG = 'H'.
              LV_CGST = LV_CGST - GT_BSET1-HWSTE.
            ELSE.
              LV_CGST = LV_CGST + GT_BSET1-HWSTE.
            ENDIF.

          ENDIF.

          IF GT_BSET1-KSCHL = 'JICG' OR GT_BSET1-KSCHL = 'JICN'.
*            OR gt_bset1-kschl = 'JICR' OR gt_bset1-kschl = 'ZCRN'.                               "CGST
            GT_FINAL-CGST_TAX = GT_FINAL-CGST_TAX + GT_BSET1-HWSTE.

            IF NOT GT_BSET1-KBETR IS INITIAL AND GT_BSET1-KSCHL = 'JICG'.
              GT_FINAL-CGST     = GT_BSET1-KBETR / 10.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.
          IF GT_BSET1-KSCHL = 'JISG' OR GT_BSET1-KSCHL = 'JISN'.
*            OR gt_bset1-kschl = 'JISR' OR gt_bset1-kschl = 'ZSRN'.                               "SGST
            GT_FINAL-SGST_TAX = GT_FINAL-SGST_TAX + GT_BSET1-HWSTE.

            IF NOT GT_BSET1-KBETR IS INITIAL AND GT_BSET1-KSCHL = 'JISG'.
              GT_FINAL-SGST  = GT_BSET1-KBETR / 10.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.

          ENDIF.

          IF GT_BSET1-KSCHL = 'JISG' OR GT_BSET1-KSCHL = 'JISN'
          OR GT_BSET1-KSCHL = 'JISR' OR GT_BSET1-KSCHL = 'ZSRN'.
            IF GT_BSET1-SHKZG = 'H'.
              LV_SGST = LV_SGST - GT_BSET1-HWSTE.
            ELSE.
              LV_SGST = LV_SGST + GT_BSET1-HWSTE.
            ENDIF.
          ENDIF.

          IF GT_BSET1-KSCHL = 'JIIG' OR GT_BSET1-KSCHL = 'JIIN'
            OR GT_BSET1-KSCHL = 'JIMD' .                               "IGST
            GT_FINAL-IGST_TAX = GT_FINAL-IGST_TAX + GT_BSET1-HWSTE.

            IF NOT GT_BSET1-KBETR IS INITIAL AND GT_BSET1-KSCHL = 'JIIG'.
              GT_FINAL-IGST     = GT_BSET1-KBETR / 10.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.
          IF GT_BSET1-KSCHL = 'JIIG' OR GT_BSET1-KSCHL = 'JIIN'
          OR GT_BSET1-KSCHL = 'ZIRN' OR GT_BSET1-KSCHL = 'JIMD'.
            IF GT_BSET1-SHKZG = 'H'.
              LV_IGST = LV_IGST - GT_BSET1-HWSTE.
            ELSE.
              LV_IGST = LV_IGST + GT_BSET1-HWSTE.
            ENDIF.
          ENDIF.

          IF GT_BSET1-KSCHL = 'JSER' OR GT_BSET1-KSCHL = 'JSVD' OR GT_BSET1-KSCHL = 'JSV2'.

            IF GT_BSET1-SHKZG = 'S'.
*            gt_final-ser_val_dr = gt_final-ser_val_dr + gt_bset-hwste.
              GT_FINAL-SER_VAL_DR = GT_FINAL-SER_VAL_DR + GT_BSET1-HWSTE.
            ELSEIF GT_BSET1-SHKZG = 'H'.
*            gt_final-ser_val_cr = gt_final-ser_val_cr + gt_bset-hwste.
              GT_FINAL-SER_VAL_DR = GT_FINAL-SER_VAL_DR - GT_BSET1-HWSTE.
            ENDIF.
            IF GT_FINAL-MWSKZ IS INITIAL.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.

          IF GT_BSET1-KSCHL = 'JSSB'.

            IF GT_BSET1-SHKZG = 'S'.
*            gt_final-sbc_dr = gt_final-sbc_dr + gt_bset-hwste.
              GT_FINAL-SBC_DR = GT_FINAL-SBC_DR + GT_BSET1-HWSTE.
            ELSEIF GT_BSET1-SHKZG = 'H'.
*            gt_final-sbc_cr = gt_final-sbc_cr + gt_bset-hwste.
              GT_FINAL-SBC_DR = GT_FINAL-SBC_DR - GT_BSET1-HWSTE.
            ENDIF.
            IF GT_FINAL-MWSKZ IS INITIAL.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.

          IF GT_BSET1-KSCHL = 'JKKP' OR GT_BSET1-KSCHL = 'ZKKR' OR GT_BSET1-KSCHL = 'JKKN' OR GT_BSET1-KSCHL = 'JSKK'
          OR GT_BSET1-KSCHL = 'JKK1' OR GT_BSET1-KSCHL = 'JKK2' OR GT_BSET1-KSCHL = 'JKK3' OR GT_BSET1-KSCHL = 'JKK4' .
            IF GT_BSET1-SHKZG = 'S'.
*            gt_final-kkc_dr = gt_final-kkc_dr + gt_bset-hwste.
              GT_FINAL-KKC_DR = GT_FINAL-KKC_DR + GT_BSET1-HWSTE.
            ELSEIF GT_BSET-SHKZG = 'H'.
*            gt_final-kkc_cr = gt_final-kkc_cr + gt_bset-hwste.
              GT_FINAL-KKC_DR = GT_FINAL-KKC_DR - GT_BSET1-HWSTE.
            ENDIF.
            IF GT_FINAL-MWSKZ IS INITIAL AND GT_BSET1-HWSTE IS NOT INITIAL.
              GT_FINAL-MWSKZ = GT_BSET1-MWSKZ.
            ENDIF.
          ENDIF.

        ENDLOOP.


**********          Service entry Sheet's MIGO No.
        IF GT_RSEG_V1-PSTYP = '9'.
          READ TABLE GT_EKBE WITH KEY EBELN = GT_RSEG_V1-EBELN
                                      EBELP = GT_RSEG_V1-EBELP
                                      LFBNR = GT_RSEG_V1-LFBNR .
          IF SY-SUBRC = 0.
            GT_FINAL-LFBNR = GT_EKBE-BELNR.   " MIGO No.
            CLEAR GT_BKPF_SES.
            READ TABLE GT_BKPF_SES WITH KEY GJAHR = GT_EKBE-GJAHR
                                            AWKEY = GT_EKBE-AWKEY.
            IF SY-SUBRC = 0.
              GT_FINAL-BUDAT = GT_BKPF_SES-BUDAT .   " MIGO Date.
              GT_FINAL-BELNR = GT_BKPF_SES-BELNR.    " FI document No.


              READ TABLE LT_BSEG1 INTO LS_BSEG WITH KEY BUKRS = GT_BKPF_SES-BUKRS
                                                        BELNR = GT_BKPF_SES-BELNR
                                                        GJAHR = GT_BKPF_SES-GJAHR
                                                        EBELP = GT_RSEG_V1-EBELP
                                                        KTOSL = 'KBS'.
              IF SY-SUBRC IS INITIAL.
                LV_INDEX = SY-TABIX.
                GT_FINAL-HKONT   = LS_BSEG-HKONT.
                LOOP AT LT_BSEG1 INTO LS_BSEG FROM LV_INDEX.
                  IF LS_BSEG-BUKRS = GT_BKPF_SES-BUKRS AND LS_BSEG-BELNR = GT_BKPF_SES-BELNR AND LS_BSEG-KTOSL = 'KBS'
                    AND LS_BSEG-GJAHR = GT_BKPF_SES-GJAHR AND LS_BSEG-EBELP = GT_RSEG_V1-EBELP.

                    IF LS_BSEG-SHKZG = 'S'.
                      GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT + LS_BSEG-DMBTR.
                    ELSE.
                      GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT - LS_BSEG-DMBTR.
                    ENDIF.

                  ENDIF.
                ENDLOOP.
**              ELSE.
**                READ TABLE lt_bseg2 INTO ls_bseg WITH KEY bukrs = gt_bkpf_ses-bukrs
**                                                        belnr = gt_bkpf_ses-belnr
**                                                        gjahr = gt_bkpf_ses-gjahr
**                                                        ebelp = gt_rseg_v1-ebelp.
**                IF sy-subrc IS INITIAL.
**                  lv_index = sy-tabix.
**                  gt_final-hkont   = ls_bseg-hkont.
**                  LOOP AT lt_bseg1 INTO ls_bseg FROM lv_index.
**                    IF ls_bseg-bukrs = gt_bkpf_ses-bukrs AND ls_bseg-belnr = gt_bkpf_ses-belnr
**                      AND ls_bseg-gjahr = gt_bkpf_ses-gjahr AND ls_bseg-ebelp = gt_rseg_v1-ebelp.
**
**                      IF ls_bseg-shkzg = 'S'.
**                        gt_final-grn_amt = gt_final-grn_amt + ls_bseg-dmbtr.
**                      ELSE.
**                        gt_final-grn_amt = gt_final-grn_amt - ls_bseg-dmbtr.
**                      ENDIF.
**
**                    ENDIF.
**                  ENDLOOP.
**              ENDIF.
              ENDIF.

            ENDIF.
          ENDIF.
        ELSE.
          READ TABLE LT_RSEG WITH KEY BELNR = GT_RSEG_V1-BELNR
                                      GJAHR = GT_RSEG_V1-GJAHR
                                      EBELN = GT_RSEG_V1-EBELN
                                      EBELP = GT_RSEG_V1-EBELP.
          IF SY-SUBRC IS INITIAL.

*          gt_final-lfbnr = gt_rseg_v1-lfbnr.     " MIGO No.
            GT_FINAL-LFBNR = LT_RSEG-LFBNR.     " MIGO No.


            READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LT_RSEG-LFBNR
                                                       MJAHR = LT_RSEG-LFGJA
                                                       EBELN = LT_RSEG-EBELN
                                                       EBELP = LT_RSEG-EBELP
                                                       LGORT = 'RM01'
                                                       BWART = '101'.


            IF SY-SUBRC IS INITIAL.
              LV_INDEX = SY-TABIX.
              LOOP AT LT_MSEG INTO LS_MSEG FROM LV_INDEX.
                IF LS_MSEG-MBLNR = LT_RSEG-LFBNR AND LS_MSEG-MJAHR = LT_RSEG-LFGJA AND LS_MSEG-EBELN = LT_RSEG-EBELN
                  AND LS_MSEG-EBELP = LT_RSEG-EBELP AND LS_MSEG-LGORT = 'RM01' AND LS_MSEG-BWART = '101'.
*                    gt_final-acc_qty = gt_final-acc_qty + ls_mseg-menge .
                  GT_FINAL-LSMNG   = GT_FINAL-LSMNG + LS_MSEG-LSMNG.
                ENDIF.
              ENDLOOP.

            ENDIF.

            READ TABLE LT_QALS INTO LS_QALS WITH KEY MBLNR = LT_RSEG-LFBNR
                                                     MJAHR = LT_RSEG-LFGJA
                                                     EBELN = GT_RSEG_V1-EBELN
                                                     EBELP = GT_RSEG_V1-EBELP.
            IF SY-SUBRC IS INITIAL.
              LV_IND = SY-TABIX.
              LOOP AT LT_QALS INTO LS_QALS FROM LV_IND.
                IF LS_QALS-MBLNR = LT_RSEG-LFBNR AND LS_QALS-MJAHR = LT_RSEG-LFGJA
                AND LS_QALS-EBELN = GT_RSEG_V1-EBELN AND LS_QALS-EBELP = GT_RSEG_V1-EBELP.
                  READ TABLE LT_QAMB INTO LS_QAMB WITH KEY PRUEFLOS = LS_QALS-PRUEFLOS.
                  IF SY-SUBRC IS INITIAL.
                    LV_INDEX = SY-TABIX.
                    LOOP AT LT_QAMB INTO LS_QAMB FROM LV_INDEX.
                      IF LS_QAMB-PRUEFLOS = LS_QALS-PRUEFLOS.
                        READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LS_QAMB-MBLNR
                                                                 MJAHR = LS_QAMB-MJAHR
                                                                 EBELN = LT_RSEG-EBELN
                                                                 EBELP = LT_RSEG-EBELP
*                                                       zeile = gt_rseg_v1-lfpos
                                                                 LGORT = 'RM01'.
                        IF SY-SUBRC IS INITIAL.
                          GT_FINAL-ACC_QTY = GT_FINAL-ACC_QTY + LS_MSEG-MENGE.

                        ENDIF.

                        READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LS_QAMB-MBLNR
                                                                 MJAHR = LS_QAMB-MJAHR
                                                                 EBELN = GT_RSEG_V1-EBELN
                                                                 EBELP = GT_RSEG_V1-EBELP
*                                                       zeile = gt_rseg_v1-lfpos
                                                                 LGORT = 'RJ01'.
                        IF SY-SUBRC IS INITIAL.
                          GT_FINAL-REJ_QTY = GT_FINAL-REJ_QTY + LS_MSEG-MENGE.
*                          gt_final-lsmng   = gt_final-lsmng + ls_mseg-lsmng.
                        ENDIF.

                        READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LS_QAMB-MBLNR
                                                                 MJAHR = LS_QAMB-MJAHR
                                                                 EBELN = GT_RSEG_V1-EBELN
                                                                 EBELP = GT_RSEG_V1-EBELP
*                                                       zeile = gt_rseg_v1-lfpos
                                                                 LGORT = 'SCR1'.
                        IF SY-SUBRC IS INITIAL.
                          GT_FINAL-SCP_QTY = GT_FINAL-SCP_QTY + LS_MSEG-MENGE.
*                          gt_final-lsmng   = gt_final-lsmng + ls_mseg-lsmng.
                        ENDIF.

                        READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LS_QAMB-MBLNR
                                                                 MJAHR = LS_QAMB-MJAHR
                                                                 EBELN = GT_RSEG_V1-EBELN
                                                                 EBELP = GT_RSEG_V1-EBELP
*                                                       zeile = gt_rseg_v1-lfpos
                                                                 LGORT = 'RWK1'.
                        IF SY-SUBRC IS INITIAL.
                          GT_FINAL-REW_QTY = GT_FINAL-REW_QTY + LS_MSEG-MENGE.
*                          gt_final-lsmng   = gt_final-lsmng + ls_mseg-lsmng.
                        ENDIF.
                      ELSE.
                        EXIT.

                      ENDIF.
                    ENDLOOP.
                  ELSE.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDLOOP.
            ELSE.
              READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LT_RSEG-LFBNR
                                                       MJAHR = LT_RSEG-LFGJA
                                                       EBELN = LT_RSEG-EBELN
                                                       EBELP = LT_RSEG-EBELP
                                                       LGORT = 'RM01'
                                                       BWART = '101'.


              IF SY-SUBRC IS INITIAL.
                LV_INDEX = SY-TABIX.
                LOOP AT LT_MSEG INTO LS_MSEG FROM LV_INDEX.
                  IF LS_MSEG-MBLNR = LT_RSEG-LFBNR AND LS_MSEG-MJAHR = LT_RSEG-LFGJA AND LS_MSEG-EBELN = LT_RSEG-EBELN
                    AND LS_MSEG-EBELP = LT_RSEG-EBELP AND LS_MSEG-LGORT = 'RM01' AND LS_MSEG-BWART = '101'.
                    GT_FINAL-ACC_QTY = GT_FINAL-ACC_QTY + LS_MSEG-MENGE .
*                    gt_final-lsmng   = gt_final-lsmng + ls_mseg-lsmng.
                  ENDIF.
                ENDLOOP.

              ENDIF.

            ENDIF.


          ENDIF.
        ENDIF.
**********          Import PO's  MIGO No.
        IF GT_FINAL-LFBNR IS INITIAL AND GT_RSEG_V1-XEKBZ NE 'X'.
          READ TABLE GT_EKBE_IMP WITH KEY EBELN = GT_RSEG_V1-EBELN
                                          EBELP = GT_RSEG_V1-EBELP.
          IF SY-SUBRC = 0.
            GT_FINAL-LFBNR = GT_EKBE_IMP-BELNR.   " MIGO No.
            GT_FINAL-LSMNG = GT_EKBE_IMP-LSMNG.   " MIGO No.
            READ TABLE LT_QALS INTO LS_QALS WITH KEY MBLNR = GT_EKBE_IMP-LFBNR
                                                     MJAHR = GT_EKBE_IMP-LFGJA
                                                     EBELN = GT_RSEG_V1-EBELN
                                                     EBELP = GT_RSEG_V1-EBELP.
            IF SY-SUBRC IS INITIAL.
              LV_IND = SY-TABIX.
              LOOP AT LT_QALS INTO LS_QALS FROM LV_IND.
                IF LS_QALS-MBLNR = LT_RSEG-LFBNR AND LS_QALS-MJAHR = LT_RSEG-LFGJA
                AND LS_QALS-EBELN = GT_RSEG_V1-EBELN AND LS_QALS-EBELP = GT_RSEG_V1-EBELP.
                  IF SY-SUBRC IS INITIAL.
                    LV_INDEX = SY-TABIX.
                    LOOP AT LT_QAMB INTO LS_QAMB FROM LV_INDEX.
                      IF LS_QAMB-PRUEFLOS = LS_QALS-PRUEFLOS.
                        READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LS_QAMB-MBLNR
                                                             MJAHR = LS_QAMB-MJAHR
                                                             EBELN = GT_RSEG_V1-EBELN
                                                             EBELP = GT_RSEG_V1-EBELP
*                                                       zeile = gt_rseg_v1-lfpos
                                                             LGORT = 'RM01'.
                        IF SY-SUBRC IS INITIAL.
                          GT_FINAL-ACC_QTY = GT_FINAL-ACC_QTY + LS_MSEG-MENGE.
                          GT_FINAL-LSMNG   = GT_FINAL-LSMNG + LS_MSEG-LSMNG.
                        ENDIF.

                        READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LS_QAMB-MBLNR
                                                                 MJAHR = LS_QAMB-MJAHR
                                                                 EBELN = GT_RSEG_V1-EBELN
                                                                 EBELP = GT_RSEG_V1-EBELP
*                                                       zeile = gt_rseg_v1-lfpos
                                                                 LGORT = 'RJ01'.
                        IF SY-SUBRC IS INITIAL.
                          GT_FINAL-REJ_QTY = GT_FINAL-REJ_QTY + LS_MSEG-MENGE.
*                          gt_final-lsmng   = gt_final-lsmng + ls_mseg-lsmng.
                        ENDIF.

                        READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LS_QAMB-MBLNR
                                                                 MJAHR = LS_QAMB-MJAHR
                                                                 EBELN = GT_RSEG_V1-EBELN
                                                                 EBELP = GT_RSEG_V1-EBELP
*                                                       zeile = gt_rseg_v1-lfpos
                                                                 LGORT = 'SCR1'.
                        IF SY-SUBRC IS INITIAL.
                          GT_FINAL-SCP_QTY = GT_FINAL-SCP_QTY + LS_MSEG-MENGE.
*                          gt_final-lsmng   = gt_final-lsmng + ls_mseg-lsmng.
                        ENDIF.

                        READ TABLE LT_MSEG INTO LS_MSEG WITH KEY MBLNR = LS_QAMB-MBLNR
                                                                 MJAHR = LS_QAMB-MJAHR
                                                                 EBELN = GT_RSEG_V1-EBELN
                                                                 EBELP = GT_RSEG_V1-EBELP
*                                                       zeile = gt_rseg_v1-lfpos
                                                                 LGORT = 'RWK1'.
                        IF SY-SUBRC IS INITIAL.
                          GT_FINAL-REW_QTY = GT_FINAL-REW_QTY + LS_MSEG-MENGE.
*                          gt_final-lsmng   = gt_final-lsmng + ls_mseg-lsmng.
                        ENDIF.
                      ELSE.
                        EXIT.

                      ENDIF.
                    ENDLOOP.
                  ELSE.
                    EXIT.

                  ENDIF.
                ENDIF.
              ENDLOOP.
*            ENDIF.
            ENDIF.
            CLEAR GT_BKPF_IMP.
            READ TABLE GT_BKPF_IMP WITH KEY ""gjahr = Gt_ekbe_imp-gjahr
                                            AWKEY = GT_EKBE_IMP-AWKEY.
            IF SY-SUBRC = 0.
              GT_FINAL-BUDAT = GT_BKPF_IMP-BUDAT.
*              IF NOT gt_bkpf_imp-budat IS INITIAL.
*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = gt_bkpf_imp-budat
*          IMPORTING
*            output = gt_final-budat.
*
*        CONCATENATE gt_final-budat+0(2) gt_final-budat+2(3) gt_final-budat+5(4)
*                   INTO gt_final-budat SEPARATED BY '-'.
*
**                CONCATENATE gt_bkpf_imp-budat+6(2) gt_bkpf_imp-budat+4(2) gt_bkpf_imp-budat+0(4) INTO  gt_final-budat SEPARATED BY '-'.
*              ELSE.
*                gt_final-budat = 'NULL' .   " MIGO Date.
*              ENDIF.


              GT_FINAL-BELNR = GT_BKPF_IMP-BELNR.    " FI document No.


              READ TABLE LT_BSEG1 INTO LS_BSEG WITH KEY BUKRS = GT_BKPF_IMP-BUKRS
                                                        BELNR = GT_BKPF_IMP-BELNR
                                                        GJAHR = GT_BKPF_IMP-GJAHR
                                                        EBELP = GT_RSEG_V1-EBELP
                                                        KTOSL = 'BSX'.
              IF SY-SUBRC IS INITIAL.
                LV_INDEX = SY-TABIX.
                GT_FINAL-HKONT   = LS_BSEG-HKONT.
                LOOP AT LT_BSEG1 INTO LS_BSEG FROM LV_INDEX.
                  IF LS_BSEG-BUKRS = GT_BKPF_IMP-BUKRS AND LS_BSEG-BELNR = GT_BKPF_IMP-BELNR AND LS_BSEG-KTOSL = 'BSX'
                    AND LS_BSEG-GJAHR = GT_BKPF_IMP-GJAHR AND LS_BSEG-EBELP = GT_RSEG_V1-EBELP.
                    IF LS_BSEG-SHKZG = 'S'.
                      GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT + LS_BSEG-DMBTR.
                    ELSE.
                      GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT - LS_BSEG-DMBTR.
                    ENDIF.
                  ENDIF.
                ENDLOOP.
              ELSE.
                READ TABLE LT_BSEG1 INTO LS_BSEG WITH KEY BUKRS = GT_BKPF_IMP-BUKRS
                                                        BELNR = GT_BKPF_IMP-BELNR
                                                        GJAHR = GT_BKPF_IMP-GJAHR
                                                        EBELP = GT_RSEG_V1-EBELP
                                                        KTOSL = 'FRL'.
                IF SY-SUBRC IS INITIAL.
                  LV_INDEX = SY-TABIX.
                  GT_FINAL-HKONT   = LS_BSEG-HKONT.
                  LOOP AT LT_BSEG1 INTO LS_BSEG FROM LV_INDEX.
                    IF LS_BSEG-BUKRS = GT_BKPF_IMP-BUKRS AND LS_BSEG-BELNR = GT_BKPF_IMP-BELNR AND LS_BSEG-KTOSL = 'FRL'
                      AND LS_BSEG-GJAHR = GT_BKPF_IMP-GJAHR AND LS_BSEG-EBELP = GT_RSEG_V1-EBELP.
                      IF LS_BSEG-SHKZG = 'S'.
                        GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT + LS_BSEG-DMBTR.
                      ELSE.
                        GT_FINAL-GRN_AMT = GT_FINAL-GRN_AMT - LS_BSEG-DMBTR.
                      ENDIF.
                    ENDIF.
                  ENDLOOP.
                ENDIF.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.

        READ TABLE LT_SKAT INTO LS_SKAT WITH KEY SAKNR = GT_FINAL-HKONT.
        IF SY-SUBRC IS INITIAL.
          GT_FINAL-TXT20 = LS_SKAT-TXT20.
        ENDIF.

        SHIFT GT_FINAL-HKONT LEFT DELETING LEADING '0'.
        IF GT_FINAL-MWSKZ IS INITIAL.
          GT_FINAL-MWSKZ = GT_RSEG_V1-MWSKZ.
        ENDIF.
        GT_FINAL-MATNR = GT_RSEG_V1-MATNR.
        GT_FINAL-MENGE = GT_RSEG_V1-MENGE.
        GT_FINAL-WERKS = GT_RSEG_V1-WERKS.

        READ TABLE LT_T007S INTO LS_T007S WITH KEY MWSKZ = GT_FINAL-MWSKZ."gt_rseg_v1-mwskz.
        IF SY-SUBRC IS INITIAL.
          GT_FINAL-TEXT1 = LS_T007S-TEXT1.
        ENDIF.
        READ TABLE GT_MAKT WITH KEY MATNR = GT_RSEG_V1-MATNR.
        IF SY-SUBRC = 0.
          GT_FINAL-MAKTX = GT_MAKT-MAKTX.
        ENDIF.
        "Material Long Text
        LV_ID = GT_FINAL-MATNR.
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
              REPLACE ALL OCCURRENCES OF '<&>' IN LS_LINES-TDLINE WITH '&'.
              CONCATENATE GT_FINAL-LONG_TXT LS_LINES-TDLINE INTO GT_FINAL-LONG_TXT SEPARATED BY SPACE.
            ENDIF.
          ENDLOOP.
          CONDENSE GT_FINAL-LONG_TXT.
        ENDIF.

        REPLACE ALL OCCURRENCES OF '<(>' IN GT_FINAL-LONG_TXT WITH SPACE.
        REPLACE ALL OCCURRENCES OF '<)>' IN GT_FINAL-LONG_TXT WITH SPACE.

        READ TABLE LT_MARC INTO LS_MARC WITH KEY MATNR = GT_RSEG_V1-MATNR
                                                 WERKS = GT_RSEG_V1-WERKS.
        IF SY-SUBRC IS INITIAL.
          GT_FINAL-STEUC = LS_MARC-STEUC.
        ENDIF.
        READ TABLE LT_MAT_MAST INTO LS_MAT_MAST WITH KEY MATNR = GT_RSEG_V1-MATNR.
        IF SY-SUBRC IS INITIAL.
          GT_FINAL-MTART = LS_MAT_MAST-MTART.
          GT_FINAL-MEINS = LS_MAT_MAST-MEINS.
          GT_FINAL-WRKST = LS_MAT_MAST-WRKST.
          GT_FINAL-ZSERIES = LS_MAT_MAST-ZSERIES.
          GT_FINAL-ZSIZE   = LS_MAT_MAST-ZSIZE.
          GT_FINAL-BRAND   = LS_MAT_MAST-BRAND.
          GT_FINAL-MOC     = LS_MAT_MAST-MOC.
          GT_FINAL-TYPE    = LS_MAT_MAST-TYPE.
        ENDIF.
        READ TABLE LT_MBEW INTO LS_MBEW WITH KEY MATNR = GT_RSEG_V1-MATNR
                                                 BWKEY = GT_RSEG_V1-WERKS.
        IF SY-SUBRC = 0.

          GT_FINAL-BKLAS   = LS_MBEW-BKLAS.

        ENDIF.


        READ TABLE GT_EKKO WITH KEY EBELN = GT_RSEG_V1-EBELN.
        IF SY-SUBRC = 0.
          GT_FINAL-EKORG = GT_EKKO-EKORG.
          GT_FINAL-AEDAT = GT_EKKO-AEDAT.
*          IF NOT gt_ekko-aedat IS INITIAL.
*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = gt_ekko-aedat
*          IMPORTING
*            output = gt_final-aedat.
*
*        CONCATENATE gt_final-aedat+0(2) gt_final-aedat+2(3) gt_final-aedat+5(4)
*                   INTO gt_final-aedat SEPARATED BY '-'.
*
**            CONCATENATE gt_ekko-aedat+6(2) gt_ekko-aedat+4(2) gt_ekko-aedat+0(4) INTO gt_final-aedat SEPARATED BY '-'.
*          ELSE.
*            gt_final-aedat = 'NULL'.
*          ENDIF.

        ENDIF.
        READ TABLE GT_EKPO WITH KEY EBELN = GT_RSEG_V1-EBELN
                                    EBELP = GT_RSEG_V1-EBELP .
        IF SY-SUBRC = 0.
          GT_FINAL-PO_QTY = GT_EKPO-MENGE.

          GT_FINAL-KNTTP = GT_EKPO-KNTTP.
          IF GT_EKPO-PEINH IS NOT INITIAL.
            GT_FINAL-RATE = GT_EKPO-NETPR / GT_EKPO-PEINH.
          ENDIF.

          READ TABLE LT_T163Y INTO LS_T163Y WITH KEY PSTYP = GT_EKPO-PSTYP.
          IF SY-SUBRC IS INITIAL.
            GT_FINAL-PSTYP = LS_T163Y-EPSTP.
          ENDIF.

*********   Asset no. & Sub Asset No.
          READ TABLE GT_EKKN WITH KEY EBELN = GT_EKPO-EBELN
                                      EBELP = GT_EKPO-EBELP .
          IF SY-SUBRC = 0.
            GT_FINAL-ANLN1 = GT_EKKN-ANLN1.
            GT_FINAL-ANLN2 = GT_EKKN-ANLN2.
            GT_FINAL-SAKTO = GT_EKKN-SAKTO.
            READ TABLE GT_ANLA WITH KEY ANLN1 = GT_EKKN-ANLN1
                                        ANLN2 = GT_EKKN-ANLN2.
            IF SY-SUBRC = 0.
              GT_FINAL-INVNR = GT_ANLA-INVNR.
              GT_FINAL-TXT50 = GT_ANLA-TXT50.
            ENDIF.
            READ TABLE LT_BSEG INTO LS_BSEG WITH KEY EBELN = GT_EKPO-EBELN
                                                     EBELP = GT_EKPO-EBELP
                                                     ANLN1 = GT_EKKN-ANLN1
                                                     ANLN2 = GT_EKKN-ANLN2.
            IF SY-SUBRC IS INITIAL.
              GT_FINAL-ASS_AMT = LS_BSEG-DMBTR.
            ENDIF.
          ENDIF.
        ENDIF.

        IF NOT GT_RBKP-STBLG IS INITIAL.
          GT_FINAL-ACC_QTY = 0.
          GT_FINAL-REJ_QTY = 0.
          GT_FINAL-SCP_QTY = 0.
          GT_FINAL-REW_QTY = 0.
          GT_FINAL-MENGE   = 0.
        ENDIF.
*BREAK primus.
        LOOP AT GT_RSEG WHERE BELNR = GT_RBKP-BELNR
                          AND GJAHR = GT_RBKP-GJAHR
                          AND EBELN = GT_RSEG_V1-EBELN
                          AND EBELP = GT_RSEG_V1-EBELP.


*****  BASIC
          IF GT_RSEG-KSCHL = ''.
            GT_FINAL-BASIC = GT_FINAL-BASIC + GT_RSEG-WRBTR.
          ENDIF.

*****  PACKING
          IF GT_RSEG-KSCHL = 'ZPFL' OR GT_RSEG-KSCHL = 'ZPC1' OR GT_RSEG-KSCHL = 'ZPFV'.
            GT_FINAL-PACKING = GT_FINAL-PACKING + GT_RSEG-WRBTR.
          ENDIF.

*****  DISCOUNT
          IF GT_RSEG-KSCHL = 'R001' OR GT_RSEG-KSCHL = 'R002' OR GT_RSEG-KSCHL = 'R003'.
            GT_FINAL-DISCOUNT = GT_FINAL-DISCOUNT + GT_RSEG-WRBTR.
          ENDIF.

***** Basic Customs
          IF GT_RSEG-KSCHL = 'JCDB'.
            GT_FINAL-BASIC_CUST = GT_FINAL-BASIC_CUST + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

***** CVD
          IF GT_RSEG-KSCHL = 'JCV1'.
            GT_FINAL-CVD = GT_FINAL-CVD + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

***** Customs ECess
          IF GT_RSEG-KSCHL = 'JECV' OR GT_RSEG-KSCHL = 'JCZ2'.
            GT_FINAL-CUST_CESS = GT_FINAL-CUST_CESS + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

***** Socila Welfare
          IF GT_RSEG-KSCHL = 'ZSWS' .
            GT_FINAL-WRBTR = GT_RSEG-WRBTR.
*            gt_final-cust_cess = gt_final-cust_cess + ( gt_rseg-wrbtr * gt_final-kursf ).
          ENDIF.

***** Customs HECess
          IF GT_RSEG-KSCHL = 'JCZ4'.
*          if gt_rseg-kschl = 'JSED'.""Gt_rseg-kschl = 'JSDB'.
            GT_FINAL-CUST_HCESS = GT_FINAL-CUST_HCESS + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

***** Add. CVD
          IF GT_RSEG-KSCHL = 'JADC'.
            GT_FINAL-ADD_CVD = GT_FINAL-ADD_CVD + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

***** Freight
          IF GT_RSEG-KSCHL = 'ZRB1' OR GT_RSEG-KSCHL = 'ZRC1' OR GT_RSEG-KSCHL = 'FRA1'.
*          OR gt_rseg-kschl = 'ZFR1' OR gt_rseg-kschl = 'JOFV' OR gt_rseg-kschl = 'JOFP'.
            GT_FINAL-FREIGHT = GT_FINAL-FREIGHT + GT_RSEG-WRBTR .
          ENDIF.

***** LBT
          IF GT_RSEG-KSCHL = 'JOCM'.
            GT_FINAL-LBT = GT_FINAL-LBT + GT_RSEG-WRBTR .
          ENDIF.

*****Inspection Charge
          IF GT_RSEG-KSCHL = 'ZINS'.
            GT_FINAL-INSP = GT_FINAL-INSP + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

*****Setting Charge
          IF GT_RSEG-KSCHL = 'ZSCV' OR GT_RSEG-KSCHL = 'ZSCQ'.
            GT_FINAL-SET_VAL = GT_FINAL-SET_VAL + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.


*****Insurance
          IF GT_RSEG-KSCHL = 'ZINR'.
            GT_FINAL-INS = GT_FINAL-INS + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

*****Devlopment Charges
          IF GT_RSEG-KSCHL = 'ZDV%' OR GT_RSEG-KSCHL = 'ZDVQ' OR GT_RSEG-KSCHL = 'ZDVV'.
            GT_FINAL-DEV_CH = GT_FINAL-DEV_CH + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

*****Other Charges
          IF GT_RSEG-KSCHL = 'ZOCV' OR GT_RSEG-KSCHL = 'ZOCQ' OR GT_RSEG-KSCHL = 'ZOC%'.
            GT_FINAL-OTH_CH = GT_FINAL-OTH_CH + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

*****Comp Cess %
          IF GT_RSEG-KSCHL = 'ZCES'.
            GT_FINAL-COM_P = GT_FINAL-COM_P + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.

*****Comp Cess Val
          IF GT_RSEG-KSCHL = 'ZCEV'.
            GT_FINAL-COM_V = GT_FINAL-COM_V + ( GT_RSEG-WRBTR * GT_FINAL-KURSF ).
          ENDIF.
***** FORWARDING
***        if gt_rseg-kschl = ''.
***          gt_final-forwarding = gt_final-forwarding + gt_rseg-wrbtr .
***        endif.

**** CLEARING
          IF GT_RSEG-KSCHL = 'JCFA' OR GT_RSEG-KSCHL = 'ZCFA' OR GT_RSEG-KSCHL = 'JFR2'.
            GT_FINAL-CLEARING = GT_FINAL-CLEARING + GT_RSEG-WRBTR .
          ENDIF.
        ENDLOOP.



****** Check if debit or Credit
**    read table gt_rseg with key  belnr = gt_bkpf-g_belnr
**                                 gjahr = gt_bkpf-g_gjahr.
**    if sy-subrc = 0.
        IF GT_RSEG_V1-SHKZG = 'H'.
          GT_FINAL-BASIC = GT_FINAL-BASIC * -1.
          GT_FINAL-PACKING = GT_FINAL-PACKING * -1.
          GT_FINAL-INSP = GT_FINAL-INSP * -1.
          GT_FINAL-SET_VAL = GT_FINAL-SET_VAL * -1.
          GT_FINAL-INS = GT_FINAL-INS * -1.
          GT_FINAL-DEV_CH = GT_FINAL-DEV_CH * -1.
          GT_FINAL-OTH_CH = GT_FINAL-OTH_CH * -1.
          GT_FINAL-DISCOUNT = GT_FINAL-DISCOUNT * -1.
          GT_FINAL-BED      = GT_FINAL-BED * -1.
          GT_FINAL-AED = GT_FINAL-AED * -1.
*          gt_final-ecs = gt_final-ecs * -1.
*          gt_final-hcess = gt_final-hcess * -1.
*          gt_final-ecs_cr = gt_final-ecs_cr * -1.       "Benz, 25.11.2016
*          gt_final-hcess_cr = gt_final-hcess_cr * -1.   "Benz, 25.11.2016
          GT_FINAL-VAT_TAX = GT_FINAL-VAT_TAX * -1.
          GT_FINAL-CST_TAX = GT_FINAL-CST_TAX * -1.
*          gt_final-ser_val_cr = gt_final-ser_val_cr * -1. "Benz, 25.11.2016
*          gt_final-sbc_cr = gt_final-sbc_cr * -1.
*          gt_final-kkc_cr = gt_final-kkc_cr * -1.
**** B.O.C Bency 06.12.2016
**          gt_final-sertaxcess_cr  = gt_final-sertaxcess_cr * -1.
*          gt_final-hsertaxcess_cr = gt_final-hsertaxcess_cr * -1.
**** E.O.C Bency 06.12.2016
          GT_FINAL-BASIC_CUST = GT_FINAL-BASIC_CUST * -1.
          GT_FINAL-CVD = GT_FINAL-CVD * -1.
          GT_FINAL-CUST_CESS = GT_FINAL-CUST_CESS * -1.
          GT_FINAL-CUST_HCESS = GT_FINAL-CUST_HCESS * -1.
          GT_FINAL-ADD_CVD = GT_FINAL-ADD_CVD * -1.
          GT_FINAL-FREIGHT = GT_FINAL-FREIGHT * -1.

          GT_FINAL-CGST_TAX     = GT_FINAL-CGST_TAX * -1.
          GT_FINAL-SGST_TAX     = GT_FINAL-SGST_TAX * -1.
          GT_FINAL-IGST_TAX     = GT_FINAL-IGST_TAX * -1.
          GT_FINAL-COM_P        = GT_FINAL-COM_P * -1.
          GT_FINAL-COM_V        = GT_FINAL-COM_V * -1.
        ENDIF.

*** NET TOTAL
        GT_FINAL-NET_TOTAL = GT_FINAL-BASIC
                           + GT_FINAL-PACKING
                           + GT_FINAL-INSP
                           + GT_FINAL-SET_VAL
                           + GT_FINAL-INS
                           + GT_FINAL-DEV_CH
                           + GT_FINAL-OTH_CH
*                           - gt_final-discount
                           + GT_FINAL-BED
                           + GT_FINAL-AED
                           + GT_FINAL-ECS
                           + GT_FINAL-HCESS.


*** GROSS TOTAL
        GT_FINAL-GROSS_TOT = GT_FINAL-NET_TOTAL
                           + GT_FINAL-VAT_TAX
                           + GT_FINAL-CST_TAX
                           - GT_FINAL-ECS_CR
                           - GT_FINAL-HCESS_CR
                           - GT_FINAL-SER_VAL_CR
*                           - gt_final-sbc_cr
*                           - gt_final-kkc_cr
*                           - gt_final-sertaxcess_cr     "Added by Bency 06.12.2016
*                           - gt_final-hsertaxcess_cr    "Added by Bency 06.12.2016
                           + GT_FINAL-ECS_DR
                           + GT_FINAL-HCESS_DR
                           + GT_FINAL-SER_VAL_DR
                           + GT_FINAL-SBC_DR
                           + GT_FINAL-KKC_DR
*                           + gt_final-sertaxcess_dr     "Added by Bency 06.12.2016
*                           + gt_final-hsertaxcess_dr    "Added by Bency 06.12.2016

                           + GT_FINAL-BASIC_CUST
                           + GT_FINAL-CVD
                           + GT_FINAL-CUST_CESS
                           + GT_FINAL-CUST_HCESS
                           + GT_FINAL-ADD_CVD
                           + GT_FINAL-FREIGHT
                           + GT_FINAL-LBT
**                           + gt_final-forwarding
**                           + gt_final-clearing
**                           + gt_final-tds_dc
                           + LV_CGST "gt_final-cgst_tax
                           + LV_SGST "gt_final-sgst_tax
                           + LV_IGST "gt_final-igst_tax
                           + GT_FINAL-COM_P
                           + GT_FINAL-COM_V.
**                           + gt_final-cgst_ns_tax
**                           + gt_final-sgst_ns_tax
**                           + gt_final-igst_ns_tax
**                           + gt_final-igst_tax_im.
**                           + gt_final-cgst_rc_tax
**                           + gt_final-sgst_rc_tax
**                           + gt_final-cgst_nrc_tax
**                           + gt_final-sgst_nrc_tax.

*** GROSS TOTAL WITHOUT TDS
        GT_FINAL-GROSS_TOT_TDS = GT_FINAL-GROSS_TOT - GT_FINAL-TDS_DC.

        IF GT_FINAL-BASIC IS NOT INITIAL.
          GT_FINAL-BASIC_LC = GT_FINAL-BASIC * GT_FINAL-KURSF.
        ENDIF.

        IF GT_FINAL-PACKING IS NOT INITIAL.
          GT_FINAL-PACKING_LC = GT_FINAL-PACKING * GT_FINAL-KURSF.
        ENDIF.

***        IF gt_final-discount IS NOT INITIAL.
***          gt_final-discount_lc = gt_final-discount * gt_final-kursf.
***        ENDIF.

        IF GT_FINAL-FREIGHT IS NOT INITIAL.
          GT_FINAL-FREIGHT_LC = GT_FINAL-FREIGHT * GT_FINAL-KURSF.
        ENDIF.

***        IF gt_final-forwarding IS NOT INITIAL.
***          gt_final-forwarding_lc = gt_final-forwarding * gt_final-kursf.
***        ENDIF.

**        IF gt_final-clearing IS NOT INITIAL.
**          gt_final-clearing_lc = gt_final-clearing * gt_final-kursf.
**        ENDIF.


        IF NOT GT_RBKP-STBLG IS INITIAL.
          GT_FINAL-BASIC_LC = 0.
          GT_FINAL-PACKING_LC = 0.
          GT_FINAL-INSP = 0.
          GT_FINAL-SET_VAL = 0.
          GT_FINAL-INS = 0.
          GT_FINAL-FREIGHT_LC = 0.
          GT_FINAL-DEV_CH = 0.
          GT_FINAL-OTH_CH = 0.
          GT_FINAL-BED = 0.
          GT_FINAL-AED = 0.
          GT_FINAL-ECS = 0.
          GT_FINAL-HCESS = 0.
          GT_FINAL-CGST_TAX = 0.
          GT_FINAL-SGST_TAX = 0.
          GT_FINAL-IGST_TAX = 0.
          GT_FINAL-COM_P = 0.
          GT_FINAL-COM_V = 0.
          GT_FINAL-VAT_TAX = 0.
          GT_FINAL-CST_TAX = 0.
          GT_FINAL-GROSS_TOT = 0.
          GT_FINAL-SER_VAL_DR = 0.
          GT_FINAL-SBC_DR = 0.
          GT_FINAL-KKC_DR = 0.
        ENDIF.

*** Assessable GST (LC)
        GT_FINAL-NET_TOTAL_LC = GT_FINAL-BASIC_LC
                           + GT_FINAL-PACKING_LC
                           + GT_FINAL-INSP
                           + GT_FINAL-SET_VAL
                           + GT_FINAL-INS
                           + GT_FINAL-FREIGHT_LC
                           + GT_FINAL-DEV_CH
                           + GT_FINAL-OTH_CH
*                           - gt_final-discount_lc
                           + GT_FINAL-BED
                           + GT_FINAL-AED
                           + GT_FINAL-ECS
                           + GT_FINAL-HCESS.

*****Tot GST Amt
        GT_FINAL-GST_AMT =
                GT_FINAL-CGST_TAX + GT_FINAL-SGST_TAX
                + GT_FINAL-IGST_TAX + GT_FINAL-COM_P + GT_FINAL-COM_V.

********Total Tax Amount
        GT_FINAL-TOT_TAX = "gt_final-gst_amt
                LV_CGST + LV_SGST + LV_IGST + GT_FINAL-BASIC_CUST + GT_FINAL-CUST_CESS + GT_FINAL-CUST_HCESS + GT_FINAL-ADD_CVD
                + GT_FINAL-VAT_TAX + GT_FINAL-CST_TAX + GT_FINAL-SER_VAL_DR + GT_FINAL-SBC_DR + GT_FINAL-KKC_DR.

*** GROSS TOTAL (LC)
        GT_FINAL-GROSS_TOT_LC = GT_FINAL-TOT_TAX + GT_FINAL-NET_TOTAL_LC.



*** GROSS TOTAL WITHOUT TDS (LC)
        GT_FINAL-GROSS_TOT_LC_TDS = GT_FINAL-GROSS_TOT_LC - GT_FINAL-TDS_LC.


        SHIFT GT_FINAL-XBLNR_ALT LEFT DELETING LEADING '0'.
        SHIFT GT_FINAL-BELNR LEFT DELETING LEADING '0'.
        SHIFT GT_FINAL-AWKEY LEFT DELETING LEADING '0'.
        SHIFT GT_FINAL-MIRO_AC_DOC LEFT DELETING LEADING '0'.
        SHIFT GT_FINAL-AKONT LEFT DELETING LEADING '0'.
*BREAK primus.

*------------------Refreshable Date / Shift negative sign to left logic ------------------------------------------
        DATA : VAL1 TYPE STRING.
        VAL1 = GT_FINAL-WRBTR.
        CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
          CHANGING
            VALUE = VAL1.
        GT_FINAL-WRBTR = VAL1.
        CLEAR VAL1.
        VAL1 = GT_FINAL-KWERT.
        CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
          CHANGING
            VALUE = VAL1.
        GT_FINAL-KWERT = VAL1.
        CLEAR VAL1.
        VAL1  = GT_FINAL-MENGE.
        CALL FUNCTION 'CLOI_PUT_SIGN_IN_FRONT'
          CHANGING
            VALUE = VAL1.
        GT_FINAL-MENGE = VAL1.

        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            INPUT  = SY-DATUM
          IMPORTING
            OUTPUT = GT_FINAL-REF_DATE.

        CONCATENATE GT_FINAL-REF_DATE+0(2) GT_FINAL-REF_DATE+2(3) GT_FINAL-REF_DATE+5(4)
                   INTO GT_FINAL-REF_DATE SEPARATED BY '-'.
*inv_dt


*        aedat
*        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = gt_final-aedat
*          IMPORTING
*            output = gt_final-AEDAT.

*        CONCATENATE gt_final-aedat+0(2) gt_final-aedat+2(3) gt_final-aedat+5(4)
*                    into gt_final-aedat SEPARATED BY '-'.

*        budat
*        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = gt_final-budat
*          IMPORTING
*            output = gt_final-budat.

*       CONCATENATE gt_final-budat+0(2) gt_final-budat+2(3) gt_final-budat+5(4)
*                   into gt_final-budat SEPARATED BY '-'.

*         bill_dt
*        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input = gt_final-bill_dt
*          IMPORTING
*            output = gt_final-bill_dt.

*        CONCATENATE gt_final-bill_dt+0(2) gt_final-bill_dt+2(3) gt_final-bill_dt+5(4)
*                    into gt_final-bill_dt SEPARATED BY '-'.

*       eindt
*        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input = gt_final-eindt
*          IMPORTING
*            output = gt_final-eindt.
*
*        CONCATENATE gt_final-eindt+0(2) gt_final-eindt+2(3) gt_final-eindt+5(4)
*                   into gt_final-eindt SEPARATED BY '-'.



        APPEND GT_FINAL.  "Commented 09.11.2016
*        CLEAR: gt_final,gt_rseg,lv_igst,lv_cgst,lv_igst.


        CLEAR :
          GT_FINAL, GT_WITH_ITEM, GT_RBKP, GT_LFA1,LV_IGST,LV_CGST,LV_IGST,GT_T005U, GT_J_1IMOVEND,LS_EKET,LS_BSEG,
          GT_RSEG_V1, GT_BKPF_WE,GT_RSEG, GT_EKBE_IMP, GT_BKPF_IMP, GT_MAKT,GT_EKKO, GT_EKPO, GT_BSET,LS_T163Y.



      ENDIF. "end gt_rbkp
    ENDIF. " end gt_bkpf   """  checking condn gt_rseg_v1
  ENDLOOP. "" *****      END RSEG
*BREAK primus.
  LOOP AT GT_FINAL.

    IT_FINAL-EKORG            = GT_FINAL-EKORG           .
    IT_FINAL-LIFNR            = GT_FINAL-LIFNR           .
    IT_FINAL-NAME1            = GT_FINAL-NAME1           .
    IT_FINAL-ADDRESS          = GT_FINAL-ADDRESS         .
    IT_FINAL-BEZEI            = GT_FINAL-BEZEI           .
    IT_FINAL-INV_NO           = GT_FINAL-INV_NO          .
    IT_FINAL-EBELN            = GT_FINAL-EBELN           .
*    it_final-aedat            = gt_final-aedat           .
    IF GT_FINAL-AEDAT IS NOT INITIAL  AND GT_FINAL-AEDAT NE '00000000'.
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          INPUT  = GT_FINAL-AEDAT
        IMPORTING
          OUTPUT = IT_FINAL-AEDAT.

      CONCATENATE IT_FINAL-AEDAT+0(2) IT_FINAL-AEDAT+2(3) IT_FINAL-AEDAT+5(4)
                 INTO IT_FINAL-AEDAT SEPARATED BY '-'.

    ENDIF.


    IT_FINAL-EBELP            = GT_FINAL-EBELP           .
    IT_FINAL-PSTYP            = GT_FINAL-PSTYP           .
    IT_FINAL-KNTTP            = GT_FINAL-KNTTP           .
    IT_FINAL-LFBNR            = GT_FINAL-LFBNR           .
*    it_final-budat            = gt_final-budat           .
    IF GT_FINAL-BUDAT IS NOT INITIAL AND GT_FINAL-BUDAT NE '00000000'.
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          INPUT  = GT_FINAL-BUDAT
        IMPORTING
          OUTPUT = IT_FINAL-BUDAT.

      CONCATENATE IT_FINAL-BUDAT+0(2) IT_FINAL-BUDAT+2(3) IT_FINAL-BUDAT+5(4)
                 INTO IT_FINAL-BUDAT SEPARATED BY '-'.

    ENDIF.




    IT_FINAL-BELNR            = GT_FINAL-BELNR           .
    IT_FINAL-GRN_AMT          = GT_FINAL-GRN_AMT         .

    """ added by NC """"""""""""""
   IF IT_FINAL-GRN_AMT < 0 .
       CONDENSE IT_FINAL-GRN_AMT NO-GAPS  .
       REPLACE all OCCURRENCES OF '-' IN IT_FINAL-GRN_AMT WITH space .
       CONCATENATE '-' IT_FINAL-GRN_AMT  INTO IT_FINAL-GRN_AMT  .
    ENDIF.

    CONDENSE IT_FINAL-GRN_AMT NO-GAPS.
    """""""""""""""""""
*    it_final-bktxt            = gt_final-bktxt           .
    IF GT_FINAL-BKTXT IS NOT INITIAL AND GT_FINAL-BKTXT NE '00000000' .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          INPUT  = GT_FINAL-BKTXT
        IMPORTING
          OUTPUT = IT_FINAL-BKTXT.

      CONCATENATE IT_FINAL-BKTXT+0(2) IT_FINAL-BKTXT+2(3) IT_FINAL-BKTXT+5(4)
                 INTO IT_FINAL-BKTXT SEPARATED BY '-'.

    ENDIF.


    IT_FINAL-AWKEY            = GT_FINAL-AWKEY           .
    IT_FINAL-MIRO_AC_DOC      = GT_FINAL-MIRO_AC_DOC     .
    IT_FINAL-BLART            = GT_FINAL-BLART           .
*    it_final-bill_dt          = gt_final-bill_dt         .
    IF GT_FINAL-BILL_DT IS NOT INITIAL AND GT_FINAL-BILL_DT NE '00000000' .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          INPUT  = GT_FINAL-BILL_DT
        IMPORTING
          OUTPUT = IT_FINAL-BILL_DT.

      CONCATENATE IT_FINAL-BILL_DT+0(2) IT_FINAL-BILL_DT+2(3) IT_FINAL-BILL_DT+5(4)
                 INTO IT_FINAL-BILL_DT SEPARATED BY '-'.

    ENDIF.




    IT_FINAL-HKONT            = GT_FINAL-HKONT           .
    IT_FINAL-TXT20            = GT_FINAL-TXT20           .
    IT_FINAL-MATNR            = GT_FINAL-MATNR           .
    IT_FINAL-LONG_TXT         = GT_FINAL-LONG_TXT        .
    IT_FINAL-MTART            = GT_FINAL-MTART           .
*    it_final-eindt            = gt_final-eindt           .
    IF GT_FINAL-EINDT IS NOT INITIAL AND GT_FINAL-EINDT NE '00000000' .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          INPUT  = GT_FINAL-EINDT
        IMPORTING
          OUTPUT = IT_FINAL-EINDT.

      CONCATENATE IT_FINAL-EINDT+0(2) IT_FINAL-EINDT+2(3) IT_FINAL-EINDT+5(4)
                 INTO IT_FINAL-EINDT SEPARATED BY '-'.

    ENDIF.

    IT_FINAL-PO_QTY           = GT_FINAL-PO_QTY          .
    IT_FINAL-MENGE            = GT_FINAL-MENGE           .
    IT_FINAL-ACC_QTY          = GT_FINAL-ACC_QTY         .
    IT_FINAL-REJ_QTY          = GT_FINAL-REJ_QTY         .
    IT_FINAL-SCP_QTY          = GT_FINAL-SCP_QTY         .
    IT_FINAL-REW_QTY          = GT_FINAL-REW_QTY         .
    IT_FINAL-RATE             = GT_FINAL-RATE            .
    IT_FINAL-BASIC            = GT_FINAL-BASIC           .

    IF  GT_FINAL-BASIC < 0.   """""""""""""" NC
       CONDENSE IT_FINAL-BASIC NO-GAPS  .
       REPLACE all OCCURRENCES OF '-' IN IT_FINAL-BASIC WITH space .
       CONCATENATE '-' IT_FINAL-BASIC  INTO IT_FINAL-BASIC  .
    ENDIF.


    IT_FINAL-GROSS_TOT        = GT_FINAL-GROSS_TOT    .

    IF  GT_FINAL-GROSS_TOT  < 0.   """""""""""""" NC
       CONDENSE IT_FINAL-GROSS_TOT NO-GAPS  .
       REPLACE all OCCURRENCES OF '-' IN IT_FINAL-GROSS_TOT WITH space .
       CONCATENATE '-' IT_FINAL-GROSS_TOT  INTO IT_FINAL-GROSS_TOT  .
    ENDIF.


    IT_FINAL-ANLN1            = GT_FINAL-ANLN1           .
    IT_FINAL-ANLN2            = GT_FINAL-ANLN2           .
    IT_FINAL-INVNR            = GT_FINAL-INVNR           .
    IT_FINAL-TXT50            = GT_FINAL-TXT50           .
    IT_FINAL-SAKTO            = GT_FINAL-SAKTO           .
    IT_FINAL-ASS_AMT          = GT_FINAL-ASS_AMT         .


    IF  IT_FINAL-ASS_AMT < 0.   """""""""""""" NC
       CONDENSE IT_FINAL-ASS_AMT NO-GAPS  .
       REPLACE all OCCURRENCES OF '-' IN IT_FINAL-ASS_AMT WITH space .
       CONCATENATE '-' IT_FINAL-ASS_AMT  INTO IT_FINAL-ASS_AMT  .
    ENDIF.


    IT_FINAL-ZSERIES          = GT_FINAL-ZSERIES         .
    IT_FINAL-ZSIZE            = GT_FINAL-ZSIZE           .
    IT_FINAL-BRAND            = GT_FINAL-BRAND           .
    IT_FINAL-MOC              = GT_FINAL-MOC             .
    IT_FINAL-TYPE             = GT_FINAL-TYPE            .

*    it_final-ref_date         = gt_final-ref_date        .
    CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
      EXPORTING
        INPUT  = SY-DATUM
      IMPORTING
        OUTPUT = IT_FINAL-REF_DATE.

    CONCATENATE IT_FINAL-REF_DATE+0(2) IT_FINAL-REF_DATE+2(3) IT_FINAL-REF_DATE+5(4)
               INTO IT_FINAL-REF_DATE SEPARATED BY '-'.


*    it_final-bldat         = gt_final-bldat        .

    IF GT_FINAL-BLDAT IS NOT INITIAL AND GT_FINAL-BLDAT NE '00000000' .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          INPUT  = GT_FINAL-BLDAT
        IMPORTING
          OUTPUT = IT_FINAL-BLDAT.

      CONCATENATE IT_FINAL-BLDAT+0(2) IT_FINAL-BLDAT+2(3) IT_FINAL-BLDAT+5(4)
                 INTO IT_FINAL-BLDAT SEPARATED BY '-'.

    ENDIF.



    IT_FINAL-MEINS         = GT_FINAL-MEINS        .
    IT_FINAL-WRKST         = GT_FINAL-WRKST        .
    IT_FINAL-BKLAS         = GT_FINAL-BKLAS        .
    IT_FINAL-WERKS         = GT_FINAL-WERKS        .

    APPEND IT_FINAL.
    CLEAR IT_FINAL.
  ENDLOOP.



  PERFORM F_LISTHEADER.
  PERFORM F_FIELDCATALOG.
  PERFORM F_LAYOUT.
  PERFORM F_DISPLAYGRID.

ENDFORM.                    " GET_DATA


*&---------------------------------------------------------------------*
*&      Form  f_listheader
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM F_LISTHEADER .

  DATA : FRMDT(10) TYPE C,
         TODT(10)  TYPE C,
         V_STR     TYPE STRING.


  GT_LISTHEADER-TYP = 'H'.
  GT_LISTHEADER-KEY = ' '.
  GT_LISTHEADER-INFO = 'Purchase Register'.
  APPEND GT_LISTHEADER.

  IF S_BUDAT-LOW NE '00000000' AND  S_BUDAT-HIGH NE '00000000'      .
    WRITE S_BUDAT-LOW  TO FRMDT USING EDIT MASK '__.__.____'.
    WRITE S_BUDAT-HIGH TO TODT  USING EDIT MASK '__.__.____'.
    CONCATENATE 'FROM'
                 FRMDT
                 'TO'
                 TODT
           INTO V_STR SEPARATED BY SPACE.
  ELSEIF S_BUDAT-LOW NE '00000000' AND  S_BUDAT-HIGH EQ '00000000'      .
    WRITE S_BUDAT-LOW  TO FRMDT USING EDIT MASK '__.__.____'.
    CONCATENATE 'ON'
                 FRMDT
           INTO V_STR SEPARATED BY SPACE.
  ELSEIF S_BUDAT-LOW EQ '00000000' AND  S_BUDAT-HIGH NE '00000000'      .
    WRITE S_BUDAT-HIGH  TO TODT USING EDIT MASK '__.__.____'.
    CONCATENATE 'ON'
                 TODT
           INTO V_STR SEPARATED BY SPACE.
  ENDIF.
  GT_LISTHEADER-TYP = 'S'.
  GT_LISTHEADER-KEY = ' '.
  GT_LISTHEADER-INFO = V_STR.
  APPEND GT_LISTHEADER.


ENDFORM. " f_listheader

*&---------------------------------------------------------------------*
*&      Form  f_fieldcatalog
*&---------------------------------------------------------------------*

FORM F_FIELDCATALOG .

****Purchase Org
  GT_FIELDCATALOG-FIELDNAME = 'EKORG'.
  GT_FIELDCATALOG-SELTEXT_L = 'Purchase Org'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 12. Vendor No.
  GT_FIELDCATALOG-FIELDNAME = 'LIFNR'.
  GT_FIELDCATALOG-SELTEXT_L = 'Vendor'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '10'.
  GT_FIELDCATALOG-NO_ZERO   = 'X'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 13. Vendor Name
  GT_FIELDCATALOG-FIELDNAME = 'NAME1'.
  GT_FIELDCATALOG-SELTEXT_L = 'Vendor Name'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '35'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 13. Vendor Address
  GT_FIELDCATALOG-FIELDNAME = 'ADDRESS'.
  GT_FIELDCATALOG-SELTEXT_L = 'Address'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '35'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 13. Vendor GSTIN
*  gt_fieldcatalog-fieldname = 'STCD3'.
*  gt_fieldcatalog-seltext_l = 'GSTIN No.'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '35'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 13. Vendor GSTIN Regd.
*  gt_fieldcatalog-fieldname = 'GST_TXT'.
*  gt_fieldcatalog-seltext_l = 'REGD/URD /Comp'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '35'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 11. Vendor State
  GT_FIELDCATALOG-FIELDNAME = 'REGIO'.
  GT_FIELDCATALOG-SELTEXT_L = 'State Code'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '25'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 11. Vendor State
  GT_FIELDCATALOG-FIELDNAME = 'BEZEI'.
  GT_FIELDCATALOG-SELTEXT_L = 'Vendor State'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '25'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 7. Inv/Bill No.
*  gt_fieldcatalog-fieldname = 'XBLNR_ALT'.
*  gt_fieldcatalog-seltext_l = 'Invoice No.'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
**  gt_fieldcatalog-key       = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 7. Inv/Bill No.
  GT_FIELDCATALOG-FIELDNAME = 'INV_NO'.
  GT_FIELDCATALOG-SELTEXT_L = 'Vendor Inv.No.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 8. INV DATE TIME
*  gt_fieldcatalog-fieldname = 'INV_DT'.
*  gt_fieldcatalog-seltext_l = 'Invoice Date'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 10. PO No.
  GT_FIELDCATALOG-FIELDNAME = 'EBELN'.
  GT_FIELDCATALOG-SELTEXT_L = 'PO No.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  GT_FIELDCATALOG-HOTSPOT   = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 9. PO Date
  GT_FIELDCATALOG-FIELDNAME = 'AEDAT'.
  GT_FIELDCATALOG-SELTEXT_L = 'PO Date'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 9. PO Line Item
  GT_FIELDCATALOG-FIELDNAME = 'EBELP'.
  GT_FIELDCATALOG-SELTEXT_L = 'PO Line Item'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 9. Item Category
  GT_FIELDCATALOG-FIELDNAME = 'PSTYP'.
  GT_FIELDCATALOG-SELTEXT_L = 'Item Category'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 9. Account Assignment Category
  GT_FIELDCATALOG-FIELDNAME = 'KNTTP'.
  GT_FIELDCATALOG-SELTEXT_L = 'Acc.Assign.Category'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 1. Migo number
  GT_FIELDCATALOG-FIELDNAME = 'LFBNR'.
  GT_FIELDCATALOG-SELTEXT_L = 'GRN No.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 2. Migo Date
  GT_FIELDCATALOG-FIELDNAME = 'BUDAT'.
  GT_FIELDCATALOG-SELTEXT_L = 'GRN Date'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 3. FI document No.
  GT_FIELDCATALOG-FIELDNAME = 'BELNR'.
  GT_FIELDCATALOG-SELTEXT_L = 'GRN FI Doc No.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  GT_FIELDCATALOG-HOTSPOT       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 3. FI document No.
  GT_FIELDCATALOG-FIELDNAME = 'GRN_AMT'.
  GT_FIELDCATALOG-SELTEXT_L = 'GRN FI Doc.No.Amt'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.


****>>> 4. Bill Booking No.
  GT_FIELDCATALOG-FIELDNAME = 'AWKEY'.
  GT_FIELDCATALOG-SELTEXT_L = 'Miro No.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 5. MIRO A/c Doc No.
  GT_FIELDCATALOG-FIELDNAME = 'MIRO_AC_DOC'.
  GT_FIELDCATALOG-SELTEXT_L = 'FI Doc No.'.
  GT_FIELDCATALOG-HOTSPOT       = 'X'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 3. FI document No.
*  gt_fieldcatalog-fieldname = 'ZUONR'.
  GT_FIELDCATALOG-FIELDNAME = 'STBLG'.
  GT_FIELDCATALOG-SELTEXT_L = 'Rejection Inv.No.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 3. FI document No.
  GT_FIELDCATALOG-FIELDNAME = 'BKTXT'.
  GT_FIELDCATALOG-SELTEXT_L = 'Rejection Inv.Dt.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.


****>>> 5. MIRO A/c Doc No.
  GT_FIELDCATALOG-FIELDNAME = 'BLART'.
  GT_FIELDCATALOG-SELTEXT_L = 'FI Doc.Type'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-key       = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 6. Bill Booking Date
  GT_FIELDCATALOG-FIELDNAME = 'BILL_DT'.
  GT_FIELDCATALOG-SELTEXT_L = 'FI Doc Date'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> GR Ledger Code
  GT_FIELDCATALOG-FIELDNAME = 'HKONT'.
  GT_FIELDCATALOG-SELTEXT_L = 'GR Ledger Code'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> GR Ledger Description
  GT_FIELDCATALOG-FIELDNAME = 'TXT20'.
  GT_FIELDCATALOG-SELTEXT_L = 'GR Ledger Description'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> GR Ledger Description
*  gt_fieldcatalog-fieldname = 'STEUC'.
*  gt_fieldcatalog-seltext_l = 'HSN/SAC Code'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 15. Material
  GT_FIELDCATALOG-FIELDNAME = 'MATNR'.
  GT_FIELDCATALOG-SELTEXT_L = 'Item Code'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '18'.
  GT_FIELDCATALOG-NO_ZERO = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 16. Material Description
  GT_FIELDCATALOG-FIELDNAME = 'LONG_TXT'.
  GT_FIELDCATALOG-SELTEXT_L = 'Item Description (100 char)'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '40'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> Material Type
  GT_FIELDCATALOG-FIELDNAME = 'MTART'.
  GT_FIELDCATALOG-SELTEXT_L = 'Material Type'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '40'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> Delivery Date
  GT_FIELDCATALOG-FIELDNAME = 'EINDT'.
  GT_FIELDCATALOG-SELTEXT_L = 'Delivery Date'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '40'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> PO Qty
  GT_FIELDCATALOG-FIELDNAME = 'PO_QTY'.
  GT_FIELDCATALOG-SELTEXT_L = 'PO Qty'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '40'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 17. Quantity
*  gt_fieldcatalog-fieldname = 'LSMNG'.
*  gt_fieldcatalog-seltext_l = 'Challan Qty.'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 17. Quantity
  GT_FIELDCATALOG-FIELDNAME = 'MENGE'.
  GT_FIELDCATALOG-SELTEXT_L = 'Recpt.Qty.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 17. ACC Quantity
  GT_FIELDCATALOG-FIELDNAME = 'ACC_QTY'.
  GT_FIELDCATALOG-SELTEXT_L = 'Acc.Qty.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 17. Rej Quantity
  GT_FIELDCATALOG-FIELDNAME = 'REJ_QTY'.
  GT_FIELDCATALOG-SELTEXT_L = 'Rejected Qty.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 17. Scrap Quantity
  GT_FIELDCATALOG-FIELDNAME = 'SCP_QTY'.
  GT_FIELDCATALOG-SELTEXT_L = 'Scrap Qty.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 17. Rewrk Quantity
  GT_FIELDCATALOG-FIELDNAME = 'Rew_QTY'.
  GT_FIELDCATALOG-SELTEXT_L = 'Rework Qty.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 20. Document Currency
*  gt_fieldcatalog-fieldname = 'WAERS'.
*  gt_fieldcatalog-seltext_l = 'PO.Currency'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '5'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 21. Exchange Rate
*  gt_fieldcatalog-fieldname = 'KURSF'.
*  gt_fieldcatalog-seltext_l = 'Exchange Rate'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

***>>> 63. Rate Per Qty
  GT_FIELDCATALOG-FIELDNAME = 'RATE'.
  GT_FIELDCATALOG-SELTEXT_L = 'Rate'.
  APPEND  GT_FIELDCATALOG.
  CLEAR  GT_FIELDCATALOG.

****>>> 22. Basic (DC)
  GT_FIELDCATALOG-FIELDNAME = 'BASIC'.
  GT_FIELDCATALOG-SELTEXT_L = 'Basic(DC)'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  GT_FIELDCATALOG-DO_SUM = 'X'.
  GT_FIELDCATALOG-DO_SUM = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 23. Basic (LC)
*  gt_fieldcatalog-fieldname = 'BASIC_LC'.
*  gt_fieldcatalog-seltext_l = 'Basic(LC)'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 25. Packing (LC)
*  gt_fieldcatalog-fieldname = 'PACKING_LC'.
*  gt_fieldcatalog-seltext_l = 'Packing'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 25. Packing (LC)
*  gt_fieldcatalog-fieldname = 'INSP'.
*  gt_fieldcatalog-seltext_l = 'Insp.Charge'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 25. Packing (LC)
*  gt_fieldcatalog-fieldname = 'SET_VAL'.
*  gt_fieldcatalog-seltext_l = 'Setting Charge'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 50. Freight(LC)
*  gt_fieldcatalog-fieldname = 'FREIGHT_LC'.
*  gt_fieldcatalog-seltext_l = 'Freight'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 25. Insurance (LC)
*  gt_fieldcatalog-fieldname = 'INS'.
*  gt_fieldcatalog-seltext_l = 'Insurance'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 25. Other Charges (LC)
*  gt_fieldcatalog-fieldname = 'OTH_CH'.
*  gt_fieldcatalog-seltext_l = 'Other Charges'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 25. Development Charges (LC)
*  gt_fieldcatalog-fieldname = 'DEV_CH'.
*  gt_fieldcatalog-seltext_l = 'Development Charges'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 33. Assessable GST
*  gt_fieldcatalog-fieldname = 'NET_TOTAL_LC'.
*  gt_fieldcatalog-seltext_l = 'Assessable Value (GST)'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 14. Tax code
*  gt_fieldcatalog-fieldname = 'MWSKZ'.
*  gt_fieldcatalog-seltext_l = 'Tax Code'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '7'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 14. Tax code Description
*  gt_fieldcatalog-fieldname = 'TEXT1'.
*  gt_fieldcatalog-seltext_l = 'Tax Code Description'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '7'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 28. Basic Excise Duty
*  gt_fieldcatalog-fieldname = 'BED'.
*  gt_fieldcatalog-seltext_l = 'Basic Excise Duty'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 29. Addl.Excise Duty
*  gt_fieldcatalog-fieldname = 'AED'.
*  gt_fieldcatalog-seltext_l = 'Addl.Excise Duty'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 35. VAT
*  gt_fieldcatalog-fieldname = 'VAT'.
*  gt_fieldcatalog-seltext_l = 'VAT'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 34. VAT Tax
*  gt_fieldcatalog-fieldname = 'VAT_TAX'.
*  gt_fieldcatalog-seltext_l = 'VAT Tax'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 37. CST
*  gt_fieldcatalog-fieldname = 'CST'.
*  gt_fieldcatalog-seltext_l = 'CST'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 36. CST Tax
*  gt_fieldcatalog-fieldname = 'CST_TAX'.
*  gt_fieldcatalog-seltext_l = 'CST Tax'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 41. Service Tax (Dr)
*  gt_fieldcatalog-fieldname = 'SER_VAL_DR'.
*  gt_fieldcatalog-seltext_l = 'Service Tax'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 42. Swach Bharat Cess (Dr)
*  gt_fieldcatalog-fieldname = 'SBC_DR'.
*  gt_fieldcatalog-seltext_l = 'Swach Bharat Cess(Dr)'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*
*****>>> 43. Krishi Kalyan Cess (Dr)
*  gt_fieldcatalog-fieldname = 'KKC_DR'.
*  gt_fieldcatalog-seltext_l = 'Krishi Kalyan Cess(Dr)'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*
*
*****>>> 44. Basic Customs
*  gt_fieldcatalog-fieldname = 'BASIC_CUST'.
*  gt_fieldcatalog-seltext_l = 'Custom Duty Value'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 45. CVD
*  gt_fieldcatalog-fieldname = 'CVD'.
*  gt_fieldcatalog-seltext_l = 'CVD'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*
*****>>> 46. Customs ECess
*  gt_fieldcatalog-fieldname = 'CUST_CESS'.
*  gt_fieldcatalog-seltext_l = 'Customs ECess'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*
*****>>> 47. Customs HECess
*  gt_fieldcatalog-fieldname = 'CUST_HCESS'.
*  gt_fieldcatalog-seltext_l = 'Customs HECess'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
****>>>Social Welfare
*  gt_fieldcatalog-fieldname = 'WRBTR'.
*  gt_fieldcatalog-seltext_l = 'Social Welfare'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
**  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 45. CVD
*  gt_fieldcatalog-fieldname = 'ADD_CVD'.
*  gt_fieldcatalog-seltext_l = 'Add.Custom Duty'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 72. CGST
*  gt_fieldcatalog-fieldname = 'CGST'.
*  gt_fieldcatalog-seltext_l = 'CGST'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 71. CGST Tax
*  gt_fieldcatalog-fieldname = 'CGST_TAX'.
*  gt_fieldcatalog-seltext_l = 'CGST Tax'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 74. SGST
*  gt_fieldcatalog-fieldname = 'SGST'.
*  gt_fieldcatalog-seltext_l = 'SGST'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
****>>> 73. SGST Tax
*  gt_fieldcatalog-fieldname = 'SGST_TAX'.
*  gt_fieldcatalog-seltext_l = 'SGST Tax'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 76. IGST
*  gt_fieldcatalog-fieldname = 'IGST'.
*  gt_fieldcatalog-seltext_l = 'IGST'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> 75. IGST Tax
*  gt_fieldcatalog-fieldname = 'IGST_TAX'.
*  gt_fieldcatalog-seltext_l = 'IGST Tax'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> Comm Cess %
*  gt_fieldcatalog-fieldname = 'COM_P'.
*  gt_fieldcatalog-seltext_l = 'Comp. Cess %'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> Comm Cess Val
*  gt_fieldcatalog-fieldname = 'COM_V'.
*  gt_fieldcatalog-seltext_l = 'Comp. Cess Value'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.
*
*****>>> GST Total
*  gt_fieldcatalog-fieldname = 'GST_AMT'.
*  gt_fieldcatalog-seltext_l = 'Total GST'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> Total Tax Amt
*  gt_fieldcatalog-fieldname = 'TOT_TAX'.
*  gt_fieldcatalog-seltext_l = 'Total Tax Amt.'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.


****>>> 58. GROSS TOTAL (DC)
  GT_FIELDCATALOG-FIELDNAME = 'GROSS_TOT'.
  GT_FIELDCATALOG-SELTEXT_L = 'Gross Total(DC)'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  GT_FIELDCATALOG-DO_SUM = 'X'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

****>>> 59. GROSS TOTAL (LC)
*  gt_fieldcatalog-fieldname = 'GROSS_TOT_LC'.
*  gt_fieldcatalog-seltext_l = 'Gross Total(LC)'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

****>>> 65. Main Asset Number
  GT_FIELDCATALOG-FIELDNAME = 'ANLN1'.
  GT_FIELDCATALOG-SELTEXT_L = 'Main Asset Number'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND  GT_FIELDCATALOG.
  CLEAR   GT_FIELDCATALOG.

****>>> 66. Asset Subnumber
  GT_FIELDCATALOG-FIELDNAME = 'ANLN2'.
  GT_FIELDCATALOG-SELTEXT_L = 'Asset Subnumber'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '10'.
  APPEND  GT_FIELDCATALOG.
  CLEAR   GT_FIELDCATALOG.

****>>> 66. Asset Inventory No
  GT_FIELDCATALOG-FIELDNAME = 'INVNR'.
  GT_FIELDCATALOG-SELTEXT_L = 'Asset Inventory No.'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '10'.
  APPEND  GT_FIELDCATALOG.
  CLEAR   GT_FIELDCATALOG.

****>>> 67. Asset description
  GT_FIELDCATALOG-FIELDNAME = 'TXT50'.
  GT_FIELDCATALOG-SELTEXT_L = 'Asset description'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '25'.
  APPEND  GT_FIELDCATALOG.
  CLEAR   GT_FIELDCATALOG.

****>>> 68. Reconciliation Account in General Ledger
  GT_FIELDCATALOG-FIELDNAME = 'SAKTO'.
  GT_FIELDCATALOG-SELTEXT_L = 'Reconciliation G/L Account'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND  GT_FIELDCATALOG.
  CLEAR   GT_FIELDCATALOG.

****>>> 68. Reconciliation Account in General Ledger
  GT_FIELDCATALOG-FIELDNAME = 'ASS_AMT'.
  GT_FIELDCATALOG-SELTEXT_L = 'Gross Asset Amount'.
  GT_FIELDCATALOG-DO_SUM = 'X'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND  GT_FIELDCATALOG.
  CLEAR   GT_FIELDCATALOG.
  GT_FIELDCATALOG-FIELDNAME = 'MOC'.
  GT_FIELDCATALOG-SELTEXT_L = 'MOC'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

  GT_FIELDCATALOG-FIELDNAME = 'BRAND'.
  GT_FIELDCATALOG-SELTEXT_L = 'Brand'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

  GT_FIELDCATALOG-FIELDNAME = 'ZSIZE'.
  GT_FIELDCATALOG-SELTEXT_L = 'Size'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

  GT_FIELDCATALOG-FIELDNAME = 'ZSERIES'.
  GT_FIELDCATALOG-SELTEXT_L = 'Series'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

  GT_FIELDCATALOG-FIELDNAME = 'TYPE'.
  GT_FIELDCATALOG-SELTEXT_L = 'Type'.
  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

  GT_FIELDCATALOG-FIELDNAME = 'BLDAT'.
  GT_FIELDCATALOG-SELTEXT_L = 'Ref.Doc.Date'.
  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.
*

  GT_FIELDCATALOG-FIELDNAME = 'MEINS'.
  GT_FIELDCATALOG-SELTEXT_L = 'Unit of Measure'.

  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.
*
  GT_FIELDCATALOG-FIELDNAME = 'WRKST'.
  GT_FIELDCATALOG-SELTEXT_L = 'USA Code'.

  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.

  GT_FIELDCATALOG-FIELDNAME = 'BKLAS'.
  GT_FIELDCATALOG-SELTEXT_L = 'Valuation Class'.

  GT_FIELDCATALOG-FIELDNAME = 'WERKS'.
  GT_FIELDCATALOG-SELTEXT_L = 'Plant'.

  APPEND GT_FIELDCATALOG.
  CLEAR GT_FIELDCATALOG.
*
****>>>Social Welfare
*  gt_fieldcatalog-fieldname = 'WRBTR'.
*  gt_fieldcatalog-seltext_l = 'Social Welfare'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
**  gt_fieldcatalog-do_sum    = 'X'.
*  APPEND gt_fieldcatalog.
*  CLEAR gt_fieldcatalog.

********* Changes by Bency, Req No. DEVK903608 ************
***
*******>>> 51. LBT
***  gt_fieldcatalog-fieldname = 'LBT'.
***  gt_fieldcatalog-seltext_l = 'LBT'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

*******>>> 18. Plant
***  gt_fieldcatalog-fieldname = 'WERKS'.
***  gt_fieldcatalog-seltext_l = 'Plant'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '7'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.


******>>> 24. Packing (DC)
**  gt_fieldcatalog-fieldname = 'PACKING'.
**  gt_fieldcatalog-seltext_l = 'Packing(DC)'.
**  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
**  gt_fieldcatalog-do_sum = 'X'.
**  APPEND gt_fieldcatalog.
**  CLEAR gt_fieldcatalog.


******>>> 26. Discount (DC)
**  gt_fieldcatalog-fieldname = 'DISCOUNT'.
**  gt_fieldcatalog-seltext_l = 'Discount'.
**  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
**  gt_fieldcatalog-do_sum = 'X'.
**  APPEND gt_fieldcatalog.
**  CLEAR gt_fieldcatalog.

*******>>> 27. Discount (LC)
***  gt_fieldcatalog-fieldname = 'DISCOUNT_LC'.
***  gt_fieldcatalog-seltext_l = 'Discount'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

***
*******>>> 30. Edu.Excise
***  gt_fieldcatalog-fieldname = 'ECS_CR'.
***  gt_fieldcatalog-seltext_l = 'Edu.Excise(Cr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 31. HCESS
***  gt_fieldcatalog-fieldname = 'HCESS_CR'.
***  gt_fieldcatalog-seltext_l = 'Higher Edu.Excise(Cr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

*******>>>  Edu.Excise
***  gt_fieldcatalog-fieldname = 'ECS_DR'.
***  gt_fieldcatalog-seltext_l = 'Edu.Excise(Dr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

****>>>  HCESS
***  gt_fieldcatalog-fieldname = 'HCESS_DR'.
***  gt_fieldcatalog-seltext_l = 'Higher Edu.Excise(Dr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

****>>> 30. Edu.Excise
***  gt_fieldcatalog-fieldname = 'ECS'.
***  gt_fieldcatalog-seltext_l = 'Edu.Excise'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 31. HCESS
***  gt_fieldcatalog-fieldname = 'HCESS'.
***  gt_fieldcatalog-seltext_l = 'Higher Edu.Excise'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

********* End of Changes by Bency, Req No. DEVK903608 ************

******>>> 32. Net Total (DC)
**  gt_fieldcatalog-fieldname = 'NET_TOTAL'.
**  gt_fieldcatalog-seltext_l = 'Net Total(DC)'.
**  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
**  gt_fieldcatalog-do_sum    = 'X'.
**  APPEND gt_fieldcatalog.
**  CLEAR gt_fieldcatalog.


*******>>> 77. CGST Tax NS
***  gt_fieldcatalog-fieldname = 'CGST_NS_TAX'.
***  gt_fieldcatalog-seltext_l = 'CGST Tax (NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 78. CGST NS
***  gt_fieldcatalog-fieldname = 'CGST_NS'.
***  gt_fieldcatalog-seltext_l = 'CGST (NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 79. SGST Tax NS
***  gt_fieldcatalog-fieldname = 'SGST_NS_TAX'.
***  gt_fieldcatalog-seltext_l = 'SGST Tax (NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 80. SGST NS
***  gt_fieldcatalog-fieldname = 'SGST_NS'.
***  gt_fieldcatalog-seltext_l = 'SGST (NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 81. IGST Tax NS
***  gt_fieldcatalog-fieldname = 'IGST_NS_TAX'.
***  gt_fieldcatalog-seltext_l = 'IGST Tax (NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 82. IGST NS
***  gt_fieldcatalog-fieldname = 'IGST_NS'.
***  gt_fieldcatalog-seltext_l = 'IGST (NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 83. IGST Tax IMP
***  gt_fieldcatalog-fieldname = 'IGST_TAX_IM'.
***  gt_fieldcatalog-seltext_l = 'IGST Tax (IMP)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 84. IGST IMP
***  gt_fieldcatalog-fieldname = 'IGST_IM'.
***  gt_fieldcatalog-seltext_l = 'IGST (IMP)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
*******>>> 38. Service Tax (Cr)
***  gt_fieldcatalog-fieldname = 'SER_VAL_CR'.
***  gt_fieldcatalog-seltext_l = 'Service Tax(Cr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.


****>>> 39. Swach Bharat Cess (Cr)
***  gt_fieldcatalog-fieldname = 'SBC_CR'.
***  gt_fieldcatalog-seltext_l = 'Swach Bharat Cess(Cr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
***
*******>>> 40. Krishi Kalyan Cess (Cr)
***  gt_fieldcatalog-fieldname = 'KKC_CR'.
***  gt_fieldcatalog-seltext_l = 'Krishi Kalyan Cess(Cr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

*******>>> 48. Add.CVD
***  gt_fieldcatalog-fieldname = 'ADD_CVD'.
***  gt_fieldcatalog-seltext_l = 'Add.CVD'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

*******>>> 49. Freight (DC)
***  gt_fieldcatalog-fieldname = 'FREIGHT'.
***  gt_fieldcatalog-seltext_l = 'Freight(DC)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.


**** B.O.C Bency 06.12.2016
*******>>>  Serv tax cess credit
***  gt_fieldcatalog-fieldname = 'SERTAXCESS_CR'.
***  gt_fieldcatalog-seltext_l = 'Service tax Cess(Cr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

*******>>>  Higher Serv tax cess credit
***  gt_fieldcatalog-fieldname = 'HSERTAXCESS_CR'.
***  gt_fieldcatalog-seltext_l = 'Higher Service tax Cess(Cr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>>  Serv tax cess debit
***  gt_fieldcatalog-fieldname = 'SERTAXCESS_DR'.
***  gt_fieldcatalog-seltext_l = 'Service tax Cess(Dr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>>  Higher Serv tax cess debit
***  gt_fieldcatalog-fieldname = 'HSERTAXCESS_DR'.
***  gt_fieldcatalog-seltext_l = 'Higher Service tax Cess(Dr)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
**** E.O.C Bency 06.12.2016

****>>> 52. FORWARDING (DC)
*  gt_fieldcatalog-fieldname = 'FORWARDING'.
*  gt_fieldcatalog-seltext_l = 'Forwarding(DC)'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  append gt_fieldcatalog.
*  clear gt_fieldcatalog.

****>>> 53. FORWARDING (LC)
*  gt_fieldcatalog-fieldname = 'FORWARDING_LC'.
*  gt_fieldcatalog-seltext_l = 'Forwarding(LC)'.
*  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
*  gt_fieldcatalog-do_sum    = 'X'.
*  append gt_fieldcatalog.
*  clear gt_fieldcatalog.

******>>> 54. CLEARING
**  gt_fieldcatalog-fieldname = 'CLEARING'.
**  gt_fieldcatalog-seltext_l = 'Clearing'.
**  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
**  gt_fieldcatalog-do_sum    = 'X'.
**  APPEND gt_fieldcatalog.
**  CLEAR gt_fieldcatalog.

*******>>> 55. CLEARING (LC)
***  gt_fieldcatalog-fieldname = 'CLEARING_LC'.
***  gt_fieldcatalog-seltext_l = 'Clearing'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

*******>>> 56. TDS (DC)
***  gt_fieldcatalog-fieldname = 'TDS_DC'.
***  gt_fieldcatalog-seltext_l = 'TDS(DC)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

***
*******>>> 57. TDS (LC)
***  gt_fieldcatalog-fieldname = 'TDS_LC'.
***  gt_fieldcatalog-seltext_l = 'TDS(LC)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

******>>> 61. TIN No.
**  gt_fieldcatalog-fieldname = 'TIN_NO'.
**  gt_fieldcatalog-seltext_l = 'TIN No.'.
**  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '10'.
**  APPEND gt_fieldcatalog.
**
******>>> 62. LST No.
**  gt_fieldcatalog-fieldname = 'LST_NO'.
**  gt_fieldcatalog-seltext_l = 'LST No.'.
**  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '10'.
**  APPEND gt_fieldcatalog.
**  CLEAR gt_fieldcatalog.
**
******>>> 64. T-Code
**  gt_fieldcatalog-fieldname = 'TCODE'.
**  gt_fieldcatalog-seltext_l = 'T-Code'.
**  APPEND  gt_fieldcatalog.
**  CLEAR   gt_fieldcatalog.

*******>>> 69. GROSS TOTAL WITHOUT TDS (DC)
***  gt_fieldcatalog-fieldname = 'GROSS_TOT_TDS'.
***  gt_fieldcatalog-seltext_l = 'Gross Total Without TDS(DC)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
***
*******>>> 70. GROSS TOTAL WITHOUT TDS (LC)
***  gt_fieldcatalog-fieldname = 'GROSS_TOT_LC_TDS'.
***  gt_fieldcatalog-seltext_l = 'Gross Total Without TDS(LC)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.

***
*******>>> 85. CGST Tax RC
***  gt_fieldcatalog-fieldname = 'CGST_RC_TAX'.
***  gt_fieldcatalog-seltext_l = 'CGST Tax (RCM)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 86. CGST RCM
***  gt_fieldcatalog-fieldname = 'CGST_RC'.
***  gt_fieldcatalog-seltext_l = 'CGST (RCM)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 87. SGST Tax RC
***  gt_fieldcatalog-fieldname = 'SGST_RC_TAX'.
***  gt_fieldcatalog-seltext_l = 'SGST Tax (RCM)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 88. SGST RCM
***  gt_fieldcatalog-fieldname = 'SGST_RC'.
***  gt_fieldcatalog-seltext_l = 'SGST (RCM)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 89. CGST Tax RC NS
***  gt_fieldcatalog-fieldname = 'CGST_NRC_TAX'.
***  gt_fieldcatalog-seltext_l = 'CGST Tax (RCM NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 90. CGST RCM NS
***  gt_fieldcatalog-fieldname = 'CGST_NRC'.
***  gt_fieldcatalog-seltext_l = 'CGST (RCM NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 91. SGST Tax RC NS
***  gt_fieldcatalog-fieldname = 'SGST_NRC_TAX'.
***  gt_fieldcatalog-seltext_l = 'SGST Tax (RCM NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  gt_fieldcatalog-do_sum    = 'X'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.
***
*******>>> 92. SGST RCM NS
***  gt_fieldcatalog-fieldname = 'SGST_NRC'.
***  gt_fieldcatalog-seltext_l = 'SGST (RCM NS)'.
***  "  gt_fieldcatalog-fieldname = 'SGST_NRC'. = '15'.
***  APPEND gt_fieldcatalog.
***  CLEAR gt_fieldcatalog.


ENDFORM. " f_fieldcatalog



*&---------------------------------------------------------------------*
*&      Form  f_layout
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM F_LAYOUT .

  GT_EVENT-NAME = SLIS_EV_TOP_OF_PAGE.
  GT_EVENT-FORM = 'TOP_OF_PAGE'.
  APPEND GT_EVENT.
  GT_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.
ENDFORM. " f_layout

*&---------------------------------------------------------------------*
*&      Form  f_displaygrid
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM F_DISPLAYGRID .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      I_CALLBACK_PROGRAM      = SY-REPID
      I_CALLBACK_USER_COMMAND = 'USER_CMD'
      I_CALLBACK_TOP_OF_PAGE  = 'TOP_OF_PAGE'
      IS_LAYOUT               = GT_LAYOUT
      IT_FIELDCAT             = GT_FIELDCATALOG[]
      IT_SORT                 = GT_SORT[]
      IT_EVENTS               = GT_EVENT[]
      I_SAVE                  = 'A'
    TABLES
      T_OUTTAB                = GT_FINAL
    EXCEPTIONS
      PROGRAM_ERROR           = 1
      OTHERS                  = 2.
  IF SY-SUBRC <> 0.

* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.
*  BREAK primus.
  IF P_DOWN = 'X'.

    PERFORM DOWNLOAD.
    PERFORM GUI_DOWNLOAD.
  ENDIF.
ENDFORM. " f_displaygrid

*&---------------------------------------------------------------------*
*&      Form  top_of_page
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

FORM TOP_OF_PAGE.
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      IT_LIST_COMMENTARY = GT_LISTHEADER[].

ENDFORM. "top_of_page

*&---------------------------------------------------------------------*
*&      Form  USER_CMD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

FORM USER_CMD USING R_UCOMM LIKE SY-UCOMM
                    RS_SELFIELD TYPE SLIS_SELFIELD.
  DATA:
     LV_BUKRS TYPE BKPF-BUKRS VALUE 'US00'   .
  CASE R_UCOMM.
    WHEN '&IC1'. "for double click
      IF RS_SELFIELD-FIELDNAME = 'MIRO_AC_DOC'.
        SET PARAMETER ID 'BLN' FIELD RS_SELFIELD-VALUE.
        SET PARAMETER ID 'BUK' FIELD LV_BUKRS.
        SET PARAMETER ID 'GJR' FIELD S_GJAHR-LOW.
        CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.
      ENDIF.
      IF RS_SELFIELD-FIELDNAME = 'BELNR'.
        SET PARAMETER ID 'BLN' FIELD RS_SELFIELD-VALUE.
        SET PARAMETER ID 'BUK' FIELD LV_BUKRS.
        SET PARAMETER ID 'GJR' FIELD S_GJAHR-LOW.
        CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.
      ENDIF.
      IF RS_SELFIELD-FIELDNAME = 'EBELN'.
        SET PARAMETER ID 'BES' FIELD RS_SELFIELD-VALUE.
        CALL TRANSACTION 'ME23N' AND SKIP FIRST SCREEN.
      ENDIF.
  ENDCASE.
ENDFORM.                    "USER_CMD
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
*  BREAK primus.
  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      I_TAB_SAP_DATA       = IT_FINAL "gt_final
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
  LV_FILE = 'ZUSPURCHASE_REG.TXT'.

  CONCATENATE P_FOLDER '/' SY-DATUM SY-UZEIT LV_FILE
    INTO LV_FULLFILE.

  WRITE: / 'Purchase Download started on', SY-DATUM, 'at', SY-UZEIT.
  OPEN DATASET LV_FULLFILE
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
*  IF sy-subrc = 0.
*    TRANSFER hd_csv TO lv_fullfile.
*    LOOP AT it_csv INTO wa_csv.
*      IF sy-subrc = 0.
*        TRANSFER wa_csv TO lv_fullfile.
*
*      ENDIF.
*    ENDLOOP.
*  ENDIF.
*  CLOSE DATASET lv_fullfile.
*  CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
*  MESSAGE lv_msg TYPE 'S'.


  IF SY-SUBRC = 0.
    DATA LV_STRING_263 TYPE STRING.
    DATA LV_CRLF_263 TYPE STRING.

*    TRANSFER hd_csv TO lv_fullfile.

    LV_CRLF_263   = CL_ABAP_CHAR_UTILITIES=>CR_LF.
    LV_STRING_263 = HD_CSV.

    LOOP AT IT_CSV INTO WA_CSV.
      CONCATENATE LV_STRING_263  LV_CRLF_263   WA_CSV INTO LV_STRING_263 .
      CLEAR: WA_CSV.
    ENDLOOP.

    TRANSFER LV_STRING_263 TO LV_FULLFILE.
    CONCATENATE 'File' LV_FULLFILE 'downloaded' INTO LV_MSG SEPARATED BY SPACE.
    MESSAGE LV_MSG TYPE 'S'.
  ENDIF.

******************************************New File Sql Uload **********************
  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      I_TAB_SAP_DATA       = IT_FINAL "gt_final
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
  LV_FILE = 'ZUSPURCHASE_REG.TXT'.

  CONCATENATE P_FOLDER '/'  LV_FILE
    INTO LV_FULLFILE.

  WRITE: / 'Purchase Download started on', SY-DATUM, 'at', SY-UZEIT.
  OPEN DATASET LV_FULLFILE
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.


  IF SY-SUBRC = 0.
    CLEAR: LV_STRING_263 ,LV_CRLF_263  .

*    TRANSFER hd_csv TO lv_fullfile.

    LV_CRLF_263   = CL_ABAP_CHAR_UTILITIES=>CR_LF.
    LV_STRING_263 = HD_CSV.

    LOOP AT IT_CSV INTO WA_CSV.
      CONCATENATE LV_STRING_263  LV_CRLF_263   WA_CSV INTO LV_STRING_263 .
      CLEAR: WA_CSV.
    ENDLOOP.

    TRANSFER LV_STRING_263 TO LV_FULLFILE.
    CONCATENATE 'File' LV_FULLFILE 'downloaded' INTO LV_MSG SEPARATED BY SPACE.
    MESSAGE LV_MSG TYPE 'S'.
  ENDIF.



*  IF sy-subrc = 0.
*    TRANSFER hd_csv TO lv_fullfile.
*    LOOP AT it_csv INTO wa_csv.
*      IF sy-subrc = 0.
*        TRANSFER wa_csv TO lv_fullfile.
*
*      ENDIF.
*    ENDLOOP.
*  ENDIF.
*  CLOSE DATASET lv_fullfile.
*  CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
*  MESSAGE lv_msg TYPE 'S'.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CVS_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_HD_CSV  text
*----------------------------------------------------------------------*
FORM CVS_HEADER  USING     PD_CSV.
  DATA: L_FIELD_SEPERATOR.
  L_FIELD_SEPERATOR = CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB.
  CONCATENATE 'Purchase Org'
              'Vendor'
              'Vendor Name'
              'Address'
              'State Code'
              'Vendor State'
              'Vendor Inv.No.'
              'PO No.'
              'PO Date'
              'PO Line Item'
              'Item Category'
              'Acc.Assign.Category'
              'GRN No.'
              'GRN Date'
              'GRN FI Doc No.'
              'GRN FI Doc.No.Amt'
              'Miro No.'
              'FI Doc No.'
              'Rejection Inv.No.'
              'Rejection Inv.Dt.'
              'FI Doc.Type'
              'FI Doc Date'
              'GR Ledger Code'
              'GR Ledger Description'
              'Item Code'
              'Item Description (100 char)'
              'Material Type'
              'Delivery Date'
              'PO Qty'
              'Recpt.Qty.'
              'Acc.Qty.'
              'Rejected Qty.'
              'Scrap Qty.'
              'Rework Qty.'
              'Rate'
              'Basic(DC)'
              'Gross Total(DC)'
              'Main Asset Number'
              'Asset Subnumber'
              'Asset Inventory No.'
              'Asset description'
              'Reconciliation G/L Account'
              'Gross Asset Amount'
              'MOC'
              'Brand'
              'Size'
              'Series'
              'Type'
              'Ref.Doc.Date'
              'Unit of Measure'
              'USA Code'
              'Valuation Class'
              'Refreshable On'
              'Plant'

              INTO PD_CSV
  SEPARATED BY L_FIELD_SEPERATOR.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GUI_DOWNLOAD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM GUI_DOWNLOAD .
*  DATA file TYPE string VALUE 'D:\ZPURCHASE_REG.TXT'.
*  TYPES : BEGIN OF LS_FIELDNAME,
*          FIELD_NAME(25),
*          END OF LS_FIELDNAME.
*  DATA : IT_FIELDNAME TYPE TABLE OF LS_FIELDNAME.
*  DATA : WA_FIELDNAME TYPE LS_FIELDNAME.
**------------Heading------------------------
*  WA_FIELDNAME-FIELD_NAME = 'Purchase Order'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Vendor'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Vendor Name'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Address'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GSTIN No'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'REGD/URD/Comp'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'State Code'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'State'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Invoice No'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Vendor Inv.No'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Inv. Dt.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'PO No.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*   WA_FIELDNAME-FIELD_NAME = 'PO Date'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'PO Line Item'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Item Category'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Acc.Assgn.Category'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GRN No.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GRN Dt'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GRN FI Doc'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GRN FI Doc Amt'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Original Inv.No'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Original Inv.No Dt'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'MIRO No.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'FI Doc No'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'FI Doc Type'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'FI Doc.Dt.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GR Ledger Code'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GR Ledger Description'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'HSN/SAC Code'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Item Code'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Long Description'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Material Type'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Delivery Date'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'PO Qty.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Challan Qty'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Recpt.Qty'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Accpt.Qty.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Rejected Qty'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Scrap Qty.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Rework Qty'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'PO Currency'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Exchange Rate'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Rate'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Basic (DC).'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Basic (LC).'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Packing'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Inspection Charge'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*   WA_FIELDNAME-FIELD_NAME = 'Setting Charge'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Freight'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Insurance'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Other Charge'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Development Charge'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Assessable Value(GST)'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
* WA_FIELDNAME-FIELD_NAME = 'Tax Code'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
* WA_FIELDNAME-FIELD_NAME = 'Tax Code Description'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Basic Excise Duty'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Add.Exc.Duty'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'VAT'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*   WA_FIELDNAME-FIELD_NAME = 'VAT TAX'.  " bY NAKUL 09.04.2018
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*    WA_FIELDNAME-FIELD_NAME = 'CST'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*   WA_FIELDNAME-FIELD_NAME = 'CST Tax'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Service Tax'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'SBC'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'KKC'.        "" **
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'BASIC CUSTOME'.           " BY NAKUL 04.09.2018 (Changed by Abhishek Pisolkar (10.04.2018))
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*   WA_FIELDNAME-FIELD_NAME = 'CVD'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Customs Ecess'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Customs HEcess'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Social Welfare'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*   WA_FIELDNAME-FIELD_NAME = 'Add.Custom Duty'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
**  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*  WA_FIELDNAME-FIELD_NAME = 'CGST%'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'CGST'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'SGST%'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'SGST'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'IGST%'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'IGST'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Com.Cess'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Com.Cess Val.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Total GST Amt'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
**  WA_FIELDNAME-FIELD_NAME = 'Basic Custom.'.      "" **
**  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Total Tax Amount'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GROSS TOTAL(DC)'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'GROSS TOTAL(LC)'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Main Asset Number'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Asset Subnumber'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Asset Inventory No.'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*   WA_FIELDNAME-FIELD_NAME = 'Asset description'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Reconciliation Account'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Asset Gross Amount'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'MOC'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Brand'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Size'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Series'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Type'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Refreshable Date'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Invoice Date'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*  WA_FIELDNAME-FIELD_NAME = 'Unit Of Measure'.
*  APPEND WA_FIELDNAME TO IT_FIELDNAME.
*
*
*
**--------------------------------------------------------------------*
*  CALL FUNCTION 'GUI_DOWNLOAD'
*    EXPORTING
**     BIN_FILESIZE            =
*      filename                = file
*      filetype                = 'ASC'
**     APPEND                  = ' '
*      write_field_separator   = 'X'
*    TABLES
*     data_tab                = it_final
*     FIELDNAMES              = it_fieldname
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
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.

ENDFORM.

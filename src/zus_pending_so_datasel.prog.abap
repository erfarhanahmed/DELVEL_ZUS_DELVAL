*&---------------------------------------------------------------------*
*&  Include           ZUS_SD_PEND_SO_DATASEL
*&---------------------------------------------------------------------*


DATA:
    ls_exch_rate TYPE bapi1093_0.

START-OF-SELECTION.


  IF open_so = 'X'.
BREAK primus.
    SELECT a~vbeln a~posnr
    INTO TABLE it_data
    FROM  vbap AS a
    JOIN  vbup AS b ON ( b~vbeln = a~vbeln  AND b~posnr = a~posnr )
*    JOIN  lipsup AS c ON ( c~vgbel = a~vbeln  AND c~vgpos = a~posnr )
    WHERE a~erdat  IN s_date
    AND   a~matnr  IN s_matnr
    AND   a~werks  IN s_werks
    AND   a~vbeln  IN s_vbeln
    AND   a~CUSTDELDATE IN s_DDATE
    AND   b~lfsta  NE 'C'.
*    AND   b~lfgsa  NE 'C'
*    AND   b~fksta  NE 'C'
*     AND   b~lfsta  = 'C'
*     AND   b~lfgsa  NE 'C'." OR c~gbsta NE 'C'.

*    AND   b~gbsta  NE 'C'.

 SELECT a~vbeln a~posnr
*    INTO TABLE it_data
    APPENDING TABLE it_data
    FROM  vbap AS a
*    JOIN  vbup AS b ON ( b~vbeln = a~vbeln  AND b~posnr = a~posnr )
    JOIN  lipsup AS c ON ( c~vgbel = a~vbeln  AND c~vgpos = a~posnr )
    WHERE a~erdat  IN s_date
    AND   a~matnr  IN s_matnr
    AND   a~werks  IN s_werks
    AND   a~vbeln  IN s_vbeln
    AND   a~CUSTDELDATE IN s_DDATE
*    AND   b~lfsta  NE 'C'
*    AND   b~lfgsa  NE 'C'
*    AND   b~fksta  NE 'C'
*     AND   b~lfsta  = 'C'
*     AND   b~lfgsa  NE 'C'
     AND c~gbsta NE 'C'.


    IF it_data IS NOT INITIAL ."sy-subrc = 0.
     SELECT vbeln
            ERDAT
            AUART
            WAERK
            VKBUR
            KNUMV
            VDATU
            BSTDK
            BNAME
            KUNNR
            ZLDFROMDATE
            ZLDPERWEEK
            ZLDMAX
            FROM vbak INTO TABLE it_vbak FOR ALL ENTRIES IN it_data WHERE vbeln = it_data-vbeln AND
                                                                             kunnr IN s_kunnr.          " SHREYAS.

DELETE s_werks WHERE low = 'PL01'.
DELETE s_werks WHERE high = 'PL01'.
     IF s_werks NE 'PL01'.


      PERFORM fill_tables.
      PERFORM process_for_output.
      IF p_down IS   INITIAL.
        PERFORM alv_for_output.
      ELSE.

        PERFORM down_set.
      ENDIF.

    ELSE .
     MESSAGE 'This Report valid For US01 & US02 Plant' TYPE 'S'.

    ENDIF.
    ENDIF.

  ELSEIF all_so = 'X'.

    SELECT vbeln posnr
    FROM  vbap
    INTO TABLE it_data
    WHERE erdat  IN s_date
    AND   matnr  IN s_matnr
    AND   werks  IN s_werks
    AND   vbeln  IN s_vbeln
    AND   CUSTDELDATE IN s_DDATE.


  IF it_data IS NOT INITIAL.


    SELECT  vbeln
            ERDAT
            AUART
            WAERK
            VKBUR
            KNUMV
            VDATU
            BSTDK
            BNAME
            KUNNR
            ZLDFROMDATE
            ZLDPERWEEK
            ZLDMAX
            FROM vbak INTO TABLE it_vbak FOR ALL ENTRIES IN it_data
                                                WHERE
                                                vbeln = it_data-vbeln AND
                                                kunnr IN s_kunnr.
    IF sy-subrc = 0.

    IF s_werks NE 'PL01'.


      PERFORM fill_tables.
      PERFORM process_for_output.
      IF p_down IS   INITIAL.
        PERFORM alv_for_output.
      ELSE.
        BREAK primus.
        PERFORM down_set_all.
      ENDIF.
    ELSE.

      MESSAGE 'This Report valid For US01 & US02 Plant' TYPE 'S'.

    ENDIF.
    ENDIF.
  ENDIF.
  ELSE.

  ENDIF.
*ENDIF.
*&---------------------------------------------------------------------*
*&      Form  FILL_TABLES
*&---------------------------------------------------------------------*

FORM fill_tables .

  IF open_so = 'X'.
   SELECT vbeln
          posnr
          matnr
          abgru
          KDMAT
          ARKTX
          WAERK
          KWMENG
          WERKS
          OBJNR
          HOLDDATE
          HOLDRELDATE
          CANCELDATE
          DELDATE
          CUSTDELDATE
          FROM vbap INTO TABLE it_vbap FOR ALL ENTRIES IN it_data WHERE vbeln = it_data-vbeln
                                                                       AND posnr = it_data-posnr.
  ELSE.
    SELECT vbeln
           posnr
           matnr
           abgru
           KDMAT
           ARKTX
           WAERK
           KWMENG
           WERKS
           OBJNR
           HOLDDATE
           HOLDRELDATE
           CANCELDATE
           DELDATE
           CUSTDELDATE
           FROM vbap INTO TABLE it_vbap FOR ALL ENTRIES IN it_vbak WHERE vbeln = it_vbak-vbeln.
  ENDIF.
  IF it_vbap[] IS NOT INITIAL.

      SELECT vbeln
             kunnr
             parvw
        FROM vbpa
        INTO TABLE it_vbpa
        FOR ALL ENTRIES IN it_vbap
        WHERE vbeln = it_vbap-vbeln.

    SELECT VBELN
           POSNR
           ETENR
           ETTYP
           EDATU
           FROM VBEP INTO TABLE IT_VBEP
           FOR ALL ENTRIES IN IT_VBAP WHERE VBELN = IT_VBAP-VBELN
                                       AND  POSNR = IT_VBAP-POSNR.
    SORT it_vbep BY vbeln posnr etenr.

    SELECT VBELN
           POSNR
           ETENR
           ETTYP
           EDATU
           FROM VBEP INTO TABLE LT_VBEP
           FOR ALL ENTRIES IN IT_VBAP WHERE VBELN = IT_VBAP-VBELN
                                       AND  POSNR = IT_VBAP-POSNR
                                       AND  ETENR = '0001'
                                       AND  ETTYP = 'CP'.

      SORT lt_vbep BY vbeln posnr etenr.

   SELECT VBELN
          INCO1
          INCO2
          ZTERM
          KURSK
          BSTKD
          FROM VBKD INTO TABLE IT_VBKD
          FOR ALL ENTRIES IN IT_VBAP
          WHERE VBELN = IT_VBAP-VBELN.




   SELECT MATNR
            WERKS
            LGORT
            VBELN
            POSNR
            KALAB
            KAINS
            FROM MSKA INTO TABLE IT_MSKA
            FOR ALL ENTRIES IN IT_VBAP
            WHERE VBELN = IT_VBAP-VBELN
              AND POSNR = IT_VBAP-POSNR
              AND MATNR = IT_VBAP-MATNR
              AND WERKS = IT_VBAP-WERKS.

*    SELECT * FROM konv INTO TABLE it_konv FOR ALL ENTRIES IN it_vbak WHERE knumv = it_vbak-knumv
*                                                                       AND kschl IN s_kschl.

      SELECT VBELV
             POSNV
             VBELN
             VBTYP_N
             FROM VBFA INTO TABLE IT_VBFA
             FOR ALL ENTRIES IN IT_VBAK
             WHERE VBELV = IT_VBAK-VBELN
               AND ( VBTYP_N = 'J' OR  VBTYP_N = 'M' ).


    SELECT * FROM jest INTO TABLE it_jest FOR ALL ENTRIES IN it_vbap WHERE objnr = it_vbap-objnr
                                                                       AND stat IN s_stat
                                                                       AND inact NE 'X'.
    IF it_jest IS NOT INITIAL.
      SELECT * FROM tj30 INTO TABLE it_tj30t FOR ALL ENTRIES IN it_jest WHERE estat = it_jest-stat
                                                                       AND stsma  = 'OR_ITEM'.
    ENDIF.





  ENDIF.
  IF IT_VBFA IS NOT INITIAL.
      SELECT VBELN
             FKART
             FKTYP
             VKORG
             VTWEG
             FKDAT
             FKSTO
             FROM VBRK INTO TABLE IT_VBRK
             FOR ALL ENTRIES IN IT_VBFA
             WHERE VBELN = IT_VBFA-VBELN
               AND FKSTO NE 'X'.
  ENDIF.

    IF IT_VBRK IS NOT INITIAL.
      SELECT VBELN
             POSNR
             FKIMG
             AUBEL
             AUPOS
             MATNR
             WERKS
             FROM VBRP INTO TABLE IT_VBRP
             FOR ALL ENTRIES IN IT_VBRK
             WHERE VBELN = IT_VBRK-VBELN.
    ENDIF.
  IF it_vbkd IS NOT INITIAL.
    SELECT * FROM tvzbt INTO TABLE it_tvzbt FOR ALL ENTRIES IN it_vbkd WHERE spras = 'EN' and zterm = it_vbkd-zterm.
  ENDIF.

  IF it_vbak IS NOT INITIAL.
  SELECT KUNNR
         NAME1
         ADRNR
         brsch
         FROM KNA1 INTO TABLE IT_KNA1
         FOR ALL ENTRIES IN IT_VBAK
         WHERE KUNNR = IT_VBAK-KUNNR.
  ENDIF.


  IF it_kna1 IS NOT INITIAL.
        SELECT kunnr
               kdgrp
               bzirk
               vkbur FROM knvv INTO TABLE it_knvv
               FOR ALL ENTRIES IN it_kna1
               WHERE kunnr = it_kna1-kunnr.

        SELECT spras
               brsch
               brtxt FROM t016t INTO TABLE it_t016t
               FOR ALL ENTRIES IN it_kna1
               WHERE brsch = it_kna1-brsch.


  ENDIF.
  IF it_knvv IS NOT INITIAL.
        SELECT spras
               kdgrp
               ktext FROM t151t INTO TABLE it_t151t
               FOR ALL ENTRIES IN it_knvv
               WHERE spras = 'E'
                AND  kdgrp = it_knvv-kdgrp.
  ENDIF.
  IF it_vbpa IS NOT INITIAL .

      SELECT kunnr
             name1
             adrnr
             brsch
             FROM kna1 INTO TABLE it_partner
             FOR ALL ENTRIES IN it_vbpa
             WHERE kunnr = it_vbpa-kunnr.

      SELECT  KUNNR
              NAME1
              STRAS
              PSTLZ
              ORT01
              REGIO
              LAND1 FROM kna1 INTO TABLE it_ship
              FOR ALL ENTRIES IN it_vbpa
              WHERE kunnr = it_vbpa-kunnr.

  ENDIF.

  IF it_ship IS NOT INITIAL.
    SELECT spras
           land1
           bland
           bezei FROM t005u INTO TABLE it_t005u
           FOR ALL ENTRIES IN it_ship
           WHERE spras = 'EN'
            AND  land1 = it_ship-land1
            AND  bland = it_ship-regio.

     SELECT spras
            land1
            landx FROM t005t INTO TABLE it_t005t
            FOR ALL ENTRIES IN it_ship
            WHERE spras = 'EN'
             AND  land1 = it_ship-land1.


  ENDIF.



ENDFORM.                    " FILL_TABLES
*&---------------------------------------------------------------------*
*&      Form  PROCESS_FOR_OUTPUT
*&---------------------------------------------------------------------*

FORM process_for_output .
  DATA:
    lv_ratio TYPE resb-enmng,
    lv_qty   TYPE resb-enmng,
    lv_index TYPE sy-tabix.
  IF it_vbap[] IS NOT INITIAL.
    CLEAR: wa_vbap, wa_vbak, wa_vbep, wa_mska,
           wa_vbrp, wa_konv, wa_kna1.
    SORT it_vbap BY vbeln posnr matnr werks.
    SORT it_mska BY vbeln posnr matnr werks.
    SORT it_afpo BY kdauf kdpos matnr.
    SORT lt_resb BY aufnr kdauf kdpos.

    LOOP AT it_vbap INTO wa_vbap.

      wa_output-werks       = wa_vbap-werks.           "PLANT
      wa_output-holddate    = wa_vbap-holddate.        "Statsu
      wa_output-reldate     = wa_vbap-holdreldate.     "Release date
      wa_output-canceldate  = wa_vbap-canceldate.      "Cancel date
      wa_output-deldate     = wa_vbap-deldate.         "delivary date
      wa_output-CUSTDELDATE     = wa_vbap-CUSTDELDATE.         "customer del. date
      wa_output-matnr       = wa_vbap-matnr.           "Material
      wa_output-posnr       = wa_vbap-posnr.           "item
      wa_output-arktx       = wa_vbap-arktx.           "item short description
      wa_output-kwmeng      = wa_vbap-kwmeng.          "sales order qty
      wa_output-vbeln       = wa_vbap-vbeln.




      READ TABLE it_vbak INTO wa_vbak WITH KEY vbeln = wa_output-vbeln.
      IF sy-subrc = 0.
        wa_output-auart       = wa_vbak-auart.           "ORDER TYPE
        wa_output-bname       = wa_vbak-bname.           "contact person.
        wa_output-vkbur       = wa_vbak-vkbur.           "Sales Office
        wa_output-erdat       = wa_vbak-erdat.           "Sales Order date
        wa_output-vdatu       = wa_vbak-vdatu.           "Req del date
        wa_output-bstdk       = wa_vbak-bstdk.
      ENDIF.

      READ TABLE it_vbep INTO wa_vbep WITH KEY vbeln = wa_output-vbeln
                                               posnr = wa_output-posnr
                                               etenr = '0001'.
      IF sy-subrc = 0.
          wa_output-ettyp       = wa_vbep-ettyp.           "So Status
          wa_output-edatu       = wa_vbep-edatu.           "delivary Date
          wa_output-etenr       = wa_vbep-etenr.           "Schedule line no.
      ENDIF.

      READ TABLE lt_vbep INTO ls_vbep WITH KEY vbeln = wa_output-vbeln
                                               posnr = wa_output-posnr
                                               etenr = '0001'
                                               ettyp = 'CP'.

      READ TABLE it_vbkd INTO wa_vbkd WITH KEY vbeln = wa_output-vbeln.
*                                               posnr = wa_vbap-posnr.
      IF sy-subrc = 0.
        wa_output-bstkd       = wa_vbkd-bstkd.           "Cust Ref No.
        wa_output-zterm       = wa_vbkd-zterm.           "payment terms
        wa_output-inco1       = wa_vbkd-inco1.           "inco terms
        wa_output-inco2       = wa_vbkd-inco2.           "inco terms description
      ENDIF.

      READ TABLE it_tvzbt INTO wa_tvzbt WITH KEY zterm = wa_output-zterm.
      IF sy-subrc = 0.
         wa_output-text1       = wa_tvzbt-text1.          "payment terms description
      ENDIF.

      READ TABLE it_vbrp INTO wa_vbrp WITH KEY vbeln = wa_output-vbeln
                                               posnr = wa_output-posnr.
      IF sy-subrc = 0.

      ENDIF.




**TPI TEXT

      CLEAR: lv_lines, wa_lines.
      REFRESH lv_lines.
      lv_name = wa_output-vbeln.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U001'
          language                = 'E'
          name                    = lv_name
          object                  = 'VBBK'
        TABLES
          lines                   = lv_lines
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

      READ TABLE lv_lines INTO wa_lines INDEX 1.



*LD Req Text
      CLEAR: lv_lines, wa_ln_ld.
      REFRESH lv_lines.
      lv_name = wa_output-vbeln.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U005'
          language                = 'E'
          name                    = lv_name
          object                  = 'VBBK'
        TABLES
          lines                   = lv_lines
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

      READ TABLE lv_lines INTO wa_ln_ld INDEX 1.

**********
*Tag Required
      CLEAR: lv_lines, wa_tag_rq.
      REFRESH lv_lines.
      lv_name = wa_output-vbeln.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U006'
          language                = 'E'
          name                    = lv_name
          object                  = 'VBBK'
        TABLES
          lines                   = lv_lines
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

      READ TABLE lv_lines INTO wa_tag_rq INDEX 1.


**********
*Material text
* Added by Shreyas
      CLEAR: lv_lines, ls_itmtxt.
      REFRESH lv_lines.
      CONCATENATE wa_output-vbeln wa_output-posnr INTO lv_name.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = '0001'
          language                = sy-langu
          name                    = lv_name
          object                  = 'VBBP'
        TABLES
          lines                   = lv_lines
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
      READ TABLE lv_lines INTO ls_itmtxt INDEX 1.

*Sales text

      CLEAR: lv_lines, ls_mattxt.
      REFRESH lv_lines.
      lv_name = wa_output-matnr.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'GRUN'
          language                = sy-langu
          name                    = lv_name
          object                  = 'MATERIAL'
        TABLES
          lines                   = lv_lines
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.
      READ TABLE lv_lines INTO ls_mattxt INDEX 1.

*konv data
      CLEAR: wa_konv.


      SELECT SINGLE KNUMV
                    KPOSN
                    KSCHL
                    KBETR
                    WAERS
                    FROM prcd_elements INTO wa_konv WHERE  knumv = wa_vbak-knumv
                                             AND   kposn = wa_output-posnr
                                             AND   kschl = 'ZPR0'.


      wa_output-kbetr       = wa_konv-kbetr.           "Rate

      CLEAR: wa_konv .

      SELECT SINGLE KNUMV
                    KPOSN
                    KSCHL
                    KBETR
                    WAERS
                    FROM prcd_elements INTO wa_konv WHERE knumv = wa_vbak-knumv
                                             AND   kposn = wa_output-posnr
                                             AND   kschl = 'VPRS'.
      IF wa_vbap-waerk <> 'INR'.
        IF wa_konv-waers <> 'INR'.
          wa_konv-kbetr = wa_konv-kbetr * wa_vbkd-kursk.
        ENDIF.
      ENDIF.


      CLEAR: wa_konv .
      SELECT SINGLE KNUMV
                    KPOSN
                    KSCHL
                    KBETR
                    WAERS
                    FROM prcd_elements INTO wa_konv WHERE knumv = wa_vbak-knumv
                                             AND   kposn = wa_output-posnr
                                             AND  kschl = 'ZESC'.
      IF wa_vbap-waerk <> 'INR'.
        IF wa_konv-waers <> 'INR'.
          wa_konv-kbetr = wa_konv-kbetr * wa_vbkd-kursk.
        ENDIF.
      ENDIF.



      CLEAR wa_kna1.
      READ TABLE it_kna1 INTO wa_kna1 WITH KEY kunnr = wa_vbak-kunnr.
      IF sy-subrc = 0.
        wa_output-name1       = wa_kna1-name1.           "Cust Name
      ENDIF.

      CLEAR wa_jest1.
      READ TABLE it_jest INTO wa_jest1 WITH KEY objnr = wa_vbap-objnr.
      IF sy-subrc = 0.
        SELECT SINGLE * FROM tj30t INTO wa_tj30t  WHERE estat = wa_jest1-stat
                                                AND stsma  = 'OR_ITEM'
                                                AND spras  = 'EN'.
         IF wa_tj30t IS NOT INITIAL.
            wa_output-status      = wa_tj30t-txt30.          "Hold/Unhold
         ENDIF.
      ENDIF.

      CLEAR : wa_mska.

      CLEAR: wa_vbfa, wa_lfimg, wa_lfimg_sum.
      LOOP AT it_vbfa INTO wa_vbfa WHERE vbelv = wa_output-vbeln
                                   AND posnv = wa_output-posnr
                                   AND vbtyp_n = 'J'.

        CLEAR wa_lfimg.
        SELECT SINGLE lfimg FROM lips INTO  wa_lfimg  WHERE vbeln = wa_vbfa-vbeln
                                                      AND   pstyv = 'ZTAN'
                                                      AND   vgbel = wa_output-vbeln
                                                      AND   vgpos = wa_output-posnr.
        wa_lfimg_sum = wa_lfimg_sum + wa_lfimg .

      ENDLOOP.

*INVOICE QTY
      CLEAR: wa_vbfa, wa_fkimg, wa_fkimg_sum.
      LOOP AT it_vbfa INTO wa_vbfa WHERE vbelv = wa_output-vbeln
                                     AND posnv = wa_output-posnr
                                     AND vbtyp_n = 'M'.

        CLEAR wa_vbrk.
        READ TABLE it_vbrk INTO wa_vbrk WITH KEY   vbeln = wa_vbfa-vbeln.
        IF sy-subrc = 0.


        CLEAR wa_fkimg.
        SELECT SINGLE fkimg FROM vbrp INTO  wa_fkimg  WHERE vbeln = wa_vbrk-vbeln
                                                      AND   aubel = wa_output-vbeln
                                                      AND   aupos = wa_output-posnr.
        wa_fkimg_sum = wa_fkimg_sum + wa_fkimg .
        ENDIF.
      ENDLOOP.

****
      CLEAR wa_mbew.
      SELECT SINGLE * FROM mbew INTO wa_mbew WHERE matnr = wa_output-matnr
                                               AND bwkey = wa_output-werks.

      CLEAR wa_mara.
      SELECT SINGLE * FROM mara INTO wa_mara WHERE matnr = wa_output-matnr.


      SELECT SINGLE dispo FROM marc INTO wa_output-dispo WHERE matnr = wa_output-matnr.
      """""""""""""""""""""""""""""""""""""""""""""""""""
*currency conversion
      REFRESH ls_fr_curr.
      CLEAR ls_fr_curr.
      ls_fr_curr-sign   = 'I'.
      ls_fr_curr-option = 'EQ'.
      ls_fr_curr-low = wa_vbak-waerk.
      APPEND ls_fr_curr.
      CLEAR: ls_ex_rate,lv_ex_rate, ls_return.
      REFRESH: ls_ex_rate, ls_return.
      IF ls_to_curr-low <> ls_fr_curr-low.

*        CALL FUNCTION 'BAPI_EXCHRATE_GETCURRENTRATES'
*          EXPORTING
*            date             = sy-datum
*            date_type        = 'V'
*            rate_type        = 'B'
*          TABLES
*            from_curr_range  = ls_fr_curr
*            to_currncy_range = ls_to_curr
*            exch_rate_list   = ls_ex_rate
*            return           = ls_return.
*
*        CLEAR lv_ex_rate.
*        READ TABLE ls_ex_rate INTO lv_ex_rate INDEX 1.
      ELSE.
        lv_ex_rate-exch_rate = 1.
      ENDIF.

*Latest Estimated cost

      REFRESH: it_konh.
      CLEAR:   it_konh.

*  FOR ZESC
      SELECT * FROM konh INTO TABLE it_konh WHERE kotabnr = '508'
                                              AND kschl  = 'ZESC'
                                              AND knumh = wa_output-matnr
                                              AND datab <= sy-datum
                                              AND datbi >= sy-datum .

      SORT  it_konh DESCENDING BY knumh .
      CLEAR wa_konh.
      READ TABLE it_konh INTO wa_konh INDEX 1.

      CLEAR wa_konp.
      SELECT SINGLE * FROM konp INTO wa_konp WHERE knumh = wa_konh-knumh
                                              AND kschl  = 'ZESC'.

*MRP DATE

      CLEAR wa_cdpos.
      DATA tabkey type cdpos-tabkey.
      CONCATENATE sy-mandt wa_vbep-vbeln wa_vbep-posnr wa_vbep-etenr into tabkey.
      SELECT * FROM cdpos INTO TABLE it_cdpos WHERE tabkey = tabkey

**                                               AND value_new = 'CP'
**                                               AND value_old = 'CN'
                                               and tabname = 'VBEP' and fname = 'ETTYP'.
      SORT it_cdpos by changenr DESCENDING.
       READ TABLE it_cdpos INTO wa_cdpos INDEX 1.
       IF Wa_CDPOS-value_new = 'CP' .
       SELECT SINGLE * FROM cdhdr INTO wa_cdhdr WHERE changenr = wa_cdpos-changenr.
         wa_output-mrp_dt      = WA_cdhdr-udate.           "MRP date EDATU to TDDAT changed by Pranav Khadatkar
       ENDIF.
      CLEAR wa_cdhdr.

      clear wa_tvagt.
    SELECT SINGLE
      spras
      abgru
      bezei
       FROM tvagt INTO  wa_tvagt  WHERE abgru = wa_vbap-abgru AND spras = 'E'.


      READ TABLE it_vbpa INTO wa_vbpa WITH KEY vbeln = wa_vbap-vbeln parvw = 'UR'.
      IF sy-subrc = 0.
        wa_output-partner = wa_vbpa-kunnr.
      ENDIF.

      READ TABLE it_partner INTO wa_partner WITH KEY kunnr = wa_output-partner.
      IF sy-subrc = 0.
        wa_output-part_name = wa_partner-name1.

      ENDIF.

      READ TABLE it_vbpa INTO wa_vbpa WITH KEY vbeln = wa_vbap-vbeln parvw = 'WE'.
      IF sy-subrc = 0.
        READ TABLE it_ship INTO wa_ship WITH KEY kunnr = wa_vbpa-kunnr.
        IF sy-subrc = 0.
          wa_output-ship_name = wa_ship-name1.
          wa_output-stras     = wa_ship-stras.
          wa_output-pstlz     = wa_ship-pstlz.
          wa_output-ort01     = wa_ship-ort01.

        ENDIF.

      ENDIF.

      READ TABLE it_t005u INTO wa_t005u WITH KEY spras = 'EN' land1 = wa_ship-land1 bland = wa_ship-regio.
      IF sy-subrc = 0.
        wa_output-ship_rig = wa_t005u-bezei.
      ENDIF.

      READ TABLE it_t005t INTO wa_t005t WITH KEY spras = 'EN' land1 = wa_ship-land1 .
      IF sy-subrc = 0.
        wa_output-ship_land = wa_t005t-landx.
      ENDIF.

      READ TABLE it_knvv INTO wa_knvv WITH KEY kunnr = wa_kna1-kunnr.
      IF sy-subrc = 0.
        wa_output-kdgrp      = wa_knvv-kdgrp.

      ENDIF.

      READ TABLE it_t151t INTO wa_t151t WITH KEY kdgrp = wa_knvv-kdgrp.
        IF sy-subrc = 0.
          wa_output-ktext = wa_t151t-ktext.

       ENDIF.
     READ TABLE it_t016t INTO wa_t016t WITH KEY brsch = wa_kna1-brsch.
      IF sy-subrc = 0.
        wa_output-brsch = wa_t016t-brsch.
        wa_output-brtxt = wa_t016t-brtxt.

      ENDIF.



      CLEAR wa_text.
      wa_text = wa_tag_rq-tdline(20).
      TRANSLATE wa_text TO UPPER CASE .       "tag Required
      wa_output-tag_req     = wa_text.

      wa_output-lfimg       = wa_lfimg_sum.                "del qty
      wa_output-fkimg       = wa_fkimg_sum.                "inv qty
      wa_output-pnd_qty     = wa_output-kwmeng - wa_output-fkimg.  "Pending Qty

      if wa_tvagt-abgru IS INITIAL.
        wa_output-abgru           =  '-'.
     else.
        wa_output-abgru           =  wa_tvagt-abgru.
     endif.
     if wa_tvagt-bezei IS INITIAL.
       wa_output-bezei           =  '-'.
     else.
       wa_output-bezei           =  wa_tvagt-bezei.
     endif.

      IF wa_output-auart = 'US03'.
        wa_output-pnd_qty = wa_output-pnd_qty * -1.
      ENDIF.


      CONCATENATE wa_output-vbeln wa_output-posnr wa_output-etenr
        INTO wa_output-schid(25).

      DATA lv_qmqty TYPE mska-kains.
      CLEAR lv_qmqty.

      READ TABLE it_mska INTO wa_mska WITH KEY vbeln = wa_vbap-vbeln
                                               posnr = wa_vbap-posnr
                                               matnr = wa_vbap-matnr
                                               werks = wa_vbap-werks.
      IF sy-subrc IS INITIAL.
        lv_index = sy-tabix.
        LOOP AT it_mska INTO wa_mska FROM lv_index.
          IF wa_mska-vbeln = wa_vbap-vbeln AND wa_mska-posnr = wa_vbap-posnr
           AND wa_mska-matnr = wa_vbap-matnr AND wa_mska-werks = wa_vbap-werks.
            lv_qmqty = wa_mska-kains - lv_qmqty.
          ELSE.
            CLEAR lv_index.
            EXIT.
          ENDIF.
        ENDLOOP.
      ENDIF.

      wa_output-mattxt = ls_mattxt-tdline.

      CLEAR wa_text.
      wa_text = wa_lines-tdline.
      TRANSLATE wa_text TO UPPER CASE .
      wa_output-tpi         = wa_text.     "TPI Required
      CLEAR wa_text.
      wa_text = wa_ln_ld-tdline.     "wa_ln_ld ld_req
      TRANSLATE wa_text TO UPPER CASE .
      wa_output-ld_txt         = wa_text.     "lD Required
      wa_output-kunnr        = wa_vbak-kunnr.
      wa_output-waerk        = wa_vbap-waerk.           "Currency

      IF lv_ex_rate-exch_rate IS NOT INITIAL.
        wa_output-amont       = wa_output-pnd_qty * wa_output-kbetr *
                                lv_ex_rate-exch_rate.    "Amount
        wa_output-ordr_amt    = wa_output-kwmeng * wa_output-kbetr *
                                lv_ex_rate-exch_rate.    "Ordr Amount
      ELSEIF lv_ex_rate-exch_rate IS INITIAL.
        wa_output-amont       = wa_output-pnd_qty * wa_output-kbetr .
        wa_output-ordr_amt    = wa_output-kwmeng * wa_output-kbetr .
      ENDIF.

      wa_output-st_cost     = wa_mbew-stprs .          "Standard Cost
      wa_output-bklas       = wa_mbew-bklas.
      wa_output-zseries     = wa_mara-zseries.         "series
      wa_output-zsize       = wa_mara-zsize.           "size
      wa_output-brand       = wa_mara-brand.           "Brand
      wa_output-moc         = wa_mara-moc.             "MOC
      wa_output-type        = wa_mara-type.            "TYPE
      wa_output-mtart        = wa_mara-mtart.          " Material TYPE
      wa_output-wrkst       = wa_mara-wrkst.




**ECCN
     CLEAR: lv_lines, wa_lines.
      REFRESH lv_lines.
      lv_name = wa_vbak-vbeln.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'U002'
          language                = 'E'
          name                    = lv_name
          object                  = 'VBBK'
        TABLES
          lines                   = lv_lines
        EXCEPTIONS
          id                      = 1
          language                = 2
          name                    = 3
          not_found               = 4
          object                  = 5
          reference_check         = 6
          wrong_access_to_archive = 7
          OTHERS                  = 8.
      IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      ENDIF.

*      READ TABLE lv_lines INTO wa_lines INDEX 1.

      LOOP AT lv_lines INTO wa_lines.
        IF NOT wa_lines-tdline IS INITIAL..


        CONCATENATE wa_output-eccn wa_lines-tdline  INTO wa_output-eccn SEPARATED BY space.

      ENDIF.
      ENDLOOP.





      REFRESH : it_jest2 , it_jest2[] .
      CLEAR : wa_afpo , wa_caufv.

      wa_output-ref_dt = sy-datum.
*   IF open_so = 'X'.
*     IF wa_output-KWMENG NE wa_output-fkimg.
*      APPEND wa_output TO it_output.
*     ENDIF.
*      CLEAR ls_vbep.CLEAR wa_output.
*   ELSE.
   APPEND wa_output TO it_output.
   CLEAR ls_vbep.CLEAR wa_output.
*      clear:wa_output-stock_qty .
*   ENDIF .
    ENDLOOP.


  ENDIF.

  """"""""""""""""""        Added By KD on 05.05.2017                 """""""""""""
  IF it_output[] IS NOT INITIAL.
    REFRESH : it_oauto , it_oauto[] , it_mast , it_mast[] , it_stko , it_stko[] ,
              it_stpo , it_stpo[] , it_mara , it_mara[] , it_makt , it_makt[] .

    it_oauto[] = it_output[] .

    DELETE it_oauto WHERE dispo NE 'AUT' .
    DELETE it_oauto WHERE mtart NE 'FERT'.

    SELECT matnr werks stlan stlnr stlal FROM mast INTO TABLE it_mast
                                            FOR ALL ENTRIES IN it_oauto
                                                  WHERE matnr = it_oauto-matnr
                                                    AND stlan = 1.

    SELECT stlty stlnr stlal stkoz FROM stko INTO TABLE it_stko
                                      FOR ALL ENTRIES IN it_mast
                                                  WHERE stlnr = it_mast-stlnr
                                                    AND stlal = it_mast-stlal.

    SELECT stlty stlnr stlkn stpoz idnrk FROM stpo INTO TABLE it_stpo
                                            FOR ALL ENTRIES IN it_stko
                                                        WHERE stlnr = it_stko-stlnr
                                                          AND stpoz = it_stko-stkoz .

    SELECT * FROM mara INTO TABLE it_mara FOR ALL ENTRIES IN it_stpo
                                                    WHERE matnr = it_stpo-idnrk
                                                      AND mtart = 'FERT' .

    SELECT * FROM makt INTO TABLE it_makt FOR ALL ENTRIES IN it_mara
                                                      WHERE matnr = it_mara-matnr
                                                        AND spras = 'EN'.

    CLEAR wa_output .
    LOOP AT it_makt INTO wa_makt .
      READ TABLE it_stpo INTO wa_stpo WITH KEY idnrk = wa_makt-matnr .
      IF sy-subrc = 0.
        READ TABLE it_stko INTO wa_stko WITH KEY stlnr = wa_stpo-stlnr stkoz = wa_stpo-stpoz .
        IF sy-subrc = 0.
          READ TABLE it_mast INTO wa_mast WITH KEY stlnr = wa_stko-stlnr stlal = wa_stko-stlal.
          IF sy-subrc = 0.
            wa_output-matnr = wa_mast-matnr.
*            wa_output-scmat = wa_makt-matnr.
            wa_output-arktx = wa_makt-maktx.


              APPEND wa_output TO it_output.
            CLEAR wa_output .
          ENDIF.
        ENDIF.
      ENDIF.
      CLEAR : wa_mast , wa_stko , wa_stpo , wa_makt.
    ENDLOOP.

  ENDIF.
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

ENDFORM.                    " PROCESS_FOR_OUTPUT
*&---------------------------------------------------------------------*
*&      Form  ALV_FOR_OUTPUT
*&---------------------------------------------------------------------*
FORM alv_for_output .
*ADDING TOP OF PAGE FEATURE
  PERFORM stp3_eventtab_build   CHANGING gt_events[].
  PERFORM comment_build         CHANGING i_list_top_of_page[].
  PERFORM top_of_page.
  PERFORM layout_build          CHANGING wa_layout.
****************************************************************************************

  PERFORM build_fieldcat USING 'WERKS'          'X' '1'   'Plant'.                        "(003).
  PERFORM build_fieldcat USING 'AUART'          'X' '2'   'Order Type'.                   "(004).
  PERFORM build_fieldcat USING 'BSTKD'          'X' '3'   'Customer PO No'.               "(005).
  PERFORM build_fieldcat USING 'BSTDK'          'X' '4'   'Customer PO Date'.             "(005).
  PERFORM build_fieldcat USING 'KUNNR'          'X' '5'   'Customer Code'.
  PERFORM build_fieldcat USING 'NAME1'          'X' '6'   'Customer'.                     "(006).
  PERFORM build_fieldcat USING 'PARTNER'        'X' '7'   'Sales Rep. No'.                " (006).
  PERFORM build_fieldcat USING 'PART_NAME'      'X' '8'   'Sales Rep. Name'.              "(006).
  PERFORM build_fieldcat USING 'KDGRP'          'X' '9'   'Customer Group'.               "(006).
  PERFORM build_fieldcat USING 'KTEXT'          'X' '10'   'Customer Group Desc'.         "(006).
  PERFORM build_fieldcat USING 'BRSCH'          'X' '11'   'Industry Sector'.             "(006).
  PERFORM build_fieldcat USING 'BRTXT'          'X' '12'   'Industry Sector Desc'.        "(006).
  PERFORM build_fieldcat USING 'VKBUR'          'X' '13'   'Sales Office'.                "(007).
  PERFORM build_fieldcat USING 'VBELN'          'X' '14'   'Sales Doc No'.                "(008).
  PERFORM build_fieldcat USING 'ERDAT'          'X' '15'   'So Date'.                     "(009).
  PERFORM build_fieldcat USING 'VDATU'          'X' '16'   'Required Delivery Dt'.        "(010).
  PERFORM build_fieldcat USING 'STATUS'         'X' '17'   'Hold/Unhold'.                 "(011).
  PERFORM build_fieldcat USING 'HOLDDATE'       'X' '18'  'Hold Date'.                    "(012).
  PERFORM build_fieldcat USING 'RELDATE'        'X' '19'  'Release Date'.                 "(013).
  PERFORM build_fieldcat USING 'CANCELDATE'     'X' '20'  'Cancelled Date'.               "(014).
  PERFORM build_fieldcat USING 'DELDATE'        'X' '21'  'Delivery Date'.                "(015).
  PERFORM build_fieldcat USING 'TPI'            'X' '22'  'Shipping Method'.               "(044).
  PERFORM build_fieldcat USING 'TAG_REQ'        'X' '23'  'Service Charge'.               "  (049).
  PERFORM build_fieldcat USING 'LD_TXT'         'X' '24'  'Remark'.                       "(050).
  PERFORM build_fieldcat USING 'MATNR'          'X' '25'   'Item Code' .                 "(016).
  PERFORM build_fieldcat USING 'WRKST'          'X' '26'   'USA Code'.                    "(016).
  PERFORM build_fieldcat USING 'BKLAS'          'X' '27'   'Valuation Class'.               "(016).
  PERFORM build_fieldcat USING 'POSNR'          'X' '28'   'Line Item'.                   "(017).
  PERFORM build_fieldcat USING 'ARKTX'          'X' '29'   'Item Description'.              "(018).
  PERFORM build_fieldcat USING 'MATTXT'         'X' '30'   'Material long Text'.
  PERFORM build_fieldcat USING 'KWMENG'         'X' '31'   'SO QTY'.                        " (019).
  PERFORM build_fieldcat USING 'LFIMG'          'X' '32'   'Delivary Qty'.                  "(021).
  PERFORM build_fieldcat USING 'FKIMG'          'X' '33'   'Invoice Quantity'.              "(022).
  PERFORM build_fieldcat USING 'PND_QTY'        'X' '34'   'Pending Qty'.                   " (023).
  PERFORM build_fieldcat USING 'ETTYP'          'X' '35'   'SO Status'.                     "(024).
  PERFORM build_fieldcat USING 'MRP_DT'         'X' '36'   'MRP Inclusion Date'.              "(045).
  PERFORM build_fieldcat USING 'EDATU'          'X' '37'   'Int Production date'.   "'Posting Date'(025).
  PERFORM build_fieldcat USING 'KBETR'          'X' '38'   'Rate'.                            "(026).
  PERFORM build_fieldcat USING 'WAERK'          'X' '39'   'Currency Type'.                     "(027).
  PERFORM build_fieldcat USING 'AMONT'          'X' '40'   'Pending SO Amount'.
  PERFORM build_fieldcat USING 'ORDR_AMT'       'X' '41'   'Order Amount'.
  PERFORM build_fieldcat USING 'ST_COST'         'X' '42'   'Standard Cost'.
  PERFORM build_fieldcat USING 'ZSERIES'         'X' '43'   'Series'.
  PERFORM build_fieldcat USING 'ZSIZE'           'X' '44'   'Size'.
  PERFORM build_fieldcat USING 'BRAND'           'X' '45'   'Brand'.
  PERFORM build_fieldcat USING 'MOC'             'X' '46'   'MOC'.
  PERFORM build_fieldcat USING 'TYPE'            'X' '47'   'Type'.
  PERFORM build_fieldcat USING 'DISPO'            'X' '48'   'MRP Controller'.
  PERFORM build_fieldcat USING 'MTART'            'X' '49'   'MAT TYPE'.
  PERFORM build_fieldcat USING 'ETENR'            'X' '50'   'Schedule No'.
  PERFORM build_fieldcat USING 'SCHID'            'X' '51'   'Schedule Id'.
  PERFORM build_fieldcat USING 'ZTERM'            'X' '52'   'Payment Terms'.
  PERFORM build_fieldcat USING 'TEXT1'            'X' '53'   'Payment Terms Text'.
  PERFORM build_fieldcat USING 'INCO1'            'X' '54'   'Inco Terms'.
  PERFORM build_fieldcat USING 'INCO2'            'X' '55'   'Inco Terms Descr'.
  PERFORM build_fieldcat USING 'CUSTDELDATE'      'X' '56'  'Customer Delivery Date'.
  PERFORM build_fieldcat USING 'BNAME'            'X' '57'  'Contact Person'.
  PERFORM build_fieldcat USING 'ECCN'             'X' '58'  'ECCN'.
  PERFORM build_fieldcat USING 'ABGRU'            'X' '59'  'Rejection Reason Code'.   "
  PERFORM build_fieldcat USING 'BEZEI'            'X' '60'  'Rejection Reason Description'.
  PERFORM build_fieldcat USING 'SHIP_NAME'        'X' '61'  'Ship To Party Name'.
  PERFORM build_fieldcat USING 'STRAS'            'X' '62'  'Ship To Party House No'.
  PERFORM build_fieldcat USING 'PSTLZ'            'X' '63'  'Ship To Party Postal Code'.
  PERFORM build_fieldcat USING 'ORT01'            'X' '64'  'Ship To Party City'.
  PERFORM build_fieldcat USING 'SHIP_RIG'         'X' '65'  'Ship To Party Region'.
  PERFORM build_fieldcat USING 'SHIP_LAND'        'X' '66'  'Ship To Party Country'.




  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      i_structure_name   = 'OUTPUT'
      is_layout          = wa_layout
      it_fieldcat        = it_fcat
      it_sort            = i_sort
      i_default          = 'A'
      i_save             = 'A'
      it_events          = gt_events[]
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
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = it_output
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  REFRESH it_output.
ENDFORM.                    " ALV_FOR_OUTPUT
*&---------------------------------------------------------------------*
*&      Form  STP3_EVENTTAB_BUILD
*&---------------------------------------------------------------------*

FORM stp3_eventtab_build  CHANGING p_gt_events TYPE slis_t_event.

  DATA: lf_event TYPE slis_alv_event. "WORK AREA

  CALL FUNCTION 'REUSE_ALV_EVENTS_GET'
    EXPORTING
      i_list_type     = 0
    IMPORTING
      et_events       = p_gt_events
    EXCEPTIONS
      list_type_wrong = 1
      OTHERS          = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
  MOVE c_formname_top_of_page TO lf_event-form.
  MODIFY p_gt_events  FROM  lf_event INDEX 3 TRANSPORTING form."TO P_I_EVENTS .



ENDFORM.                    " STP3_EVENTTAB_BUILD
*&---------------------------------------------------------------------*
*&      Form  COMMENT_BUILD
*&---------------------------------------------------------------------*
FORM comment_build CHANGING i_list_top_of_page TYPE slis_t_listheader.
  DATA: lf_line       TYPE slis_listheader. "WORK AREA
*--LIST HEADING -  TYPE H
  CLEAR lf_line.
  lf_line-typ  = c_h.
  lf_line-info =  'Pending Sales Order'(042).
  APPEND lf_line TO i_list_top_of_page.
*--HEAD INFO: TYPE S
  CLEAR lf_line.
  lf_line-typ  = c_s.
  lf_line-key  = TEXT-043.
  lf_line-info = sy-datum.
  WRITE sy-datum TO lf_line-info USING EDIT MASK '__.__.____'.
  APPEND lf_line TO i_list_top_of_page.

ENDFORM.                    " COMMENT_BUILD
*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM top_of_page .

*** THIS FM IS USED TO CREATE ALV HEADER
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = i_list_top_of_page[]. "INTERNAL TABLE WITH


ENDFORM.                    " TOP_OF_PAGE
*&---------------------------------------------------------------------*
*&      Form  LAYOUT_BUILD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_WA_LAYOUT  text
*----------------------------------------------------------------------*
FORM layout_build  CHANGING p_wa_layout TYPE slis_layout_alv.

*        IT_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.
  wa_layout-zebra          = 'X'.
*        P_WA_LAYOUT-INFO_FIELDNAME = 'C51'.
  p_wa_layout-zebra          = 'X'.
  p_wa_layout-no_colhead        = ' '.
*  WA_LAYOUT-BOX_FIELDNAME     = 'BOX'.
*  WA_LAYOUT-BOX_TABNAME       = 'IT_FINAL_ALV'.


ENDFORM.                    " LAYOUT_BUILD
*&---------------------------------------------------------------------*
*&      Form  BUILD_FIELDCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

FORM build_fieldcat  USING    v1  v2 v3 v4.
  wa_fcat-fieldname   = v1 ." 'VBELN'.
  wa_fcat-tabname     = 'IT_FINAL_NEW'.
* WA_FCAT-_ZEBRA      = 'X'.
  wa_fcat-key         =  v2 ."  'X'.
  wa_fcat-seltext_m   =  v4.
  wa_fcat-outputlen   =  18.
  wa_fcat-ddictxt     =  'M'.
  wa_fcat-col_pos     =  v3.
  APPEND wa_fcat TO it_fcat.
  CLEAR wa_fcat.

ENDFORM.                    " BUILD_FIELDCAT
*&---------------------------------------------------------------------*
*&      Form  DOWN_SET
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM down_set .

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
      i_tab_sap_data       = it_output
    CHANGING
      i_tab_converted_data = it_csv
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  PERFORM cvs_header USING hd_csv.

*  lv_folder = 'D:\usr\sap\DEV\D00\work'.                "added for check
  lv_file = 'ZUSPSO.TXT'.

  CONCATENATE p_folder '\' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUSPENDSO Download started on', sy-datum, 'at', sy-uzeit.
  IF open_so IS NOT INITIAL.
    WRITE: / 'Open Sales Orders'.
  ELSE.
    WRITE: / 'All Sales Orders'.
  ENDIF.
  WRITE: / 'Sales Order Dt. From', s_date-low, 'To', s_date-high.
  WRITE: / 'Material code   From', s_matnr-low, 'To', s_matnr-high.
  WRITE: / 'Dest. File:', lv_fullfile.

  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
    TRANSFER hd_csv TO lv_fullfile.
    LOOP AT it_csv INTO wa_csv.
      IF sy-subrc = 0.
        TRANSFER wa_csv TO lv_fullfile.

      ENDIF.
    ENDLOOP.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.


******************************************************new file zpendso **********************************
  PERFORM new_file.

  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = gt_final
    CHANGING
      i_tab_converted_data = it_csv
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  PERFORM cvs_header USING hd_csv.

*  lv_folder = 'D:\usr\sap\DEV\D00\work'.       "added for check
  lv_file = 'ZUSPSO.TXT'.

  CONCATENATE p_folder '\' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZPENDSO Download started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
    TRANSFER hd_csv TO lv_fullfile.
    LOOP AT it_csv INTO wa_csv.
      IF sy-subrc = 0.
        TRANSFER wa_csv TO lv_fullfile.

      ENDIF.
    ENDLOOP.
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

  CONCATENATE
          'Plant'
          'Order Type'
          'Customer PO No'
          'Customer PO Date'
          'Customer Code'
          'Customer'
          'Sales Rep. No'
          'Sales Rep. Name'
          'Customer Group'
          'Customer Group Desc'
          'Industry Sector'
          'Industry Sector Desc'
          'Sales Office'
          'Sales Doc No'
          'So Date'
          'Required Delivery Dt'
          'Hold/Unhold'
          'Hold Date'
          'Release Date'
          'Cancelled Date'
          'Delivery Date'
          'Shipping Method'
          'Service Charge'
          'Remark'
          'Item Code'
          'USA Code'
          'Valuation Class'
          'Line Item'
          'Item Description'
          'Material long Text'
          'SO QTY'
          'Delivary Qty'
          'Invoice Quantity'
          'Pending Qty'
          'SO Status'
          'MRP Inclusion Date'
          'Int Production date'
          'Rate'
          'Currency Type'
          'Pending SO Amount'
          'Order Amount'
          'Standard Cost'
          'Series'
          'Size'
          'Brand'
          'MOC'
          'Type'
          'MRP Controller'
          'MAT TYPE'
          'Schedule No'
          'Schedule Id'
          'Payment Terms'
          'Payment Terms Text'
          'Inco Terms'
          'Inco Terms Descr'
          'Customer Delivery Date'
          'Contact Person'
          'ECCN'
          'Rejection Reason Code'
          'Rejection Reason Description'
          'File Created Date'
          'Ship To Party Name'
          'Ship To Party House No'
          'Ship To Party Postal Code'
          'Ship To Party City'
          'Ship To Party Region'
          'Ship To Party Country'



  INTO pd_csv
  SEPARATED BY l_field_seperator.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  NEW_FILE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM new_file .
  DATA:
    ls_final TYPE t_final.
  LOOP AT it_output INTO wa_output.
    ls_final-werks       = wa_output-werks.
    ls_final-auart       = wa_output-auart.
    ls_final-bstkd       = wa_output-bstkd.
*    ls_final-bstdk       = wa_output-bstdk.
    ls_final-kunnr       = wa_output-kunnr.
    ls_final-name1       = wa_output-name1.
    ls_final-partner     = wa_output-partner.
    ls_final-part_name   = wa_output-part_name.
    ls_final-kdgrp       = wa_output-kdgrp.
    ls_final-ktext       = wa_output-ktext.
    ls_final-brsch       = wa_output-brsch.
    ls_final-brtxt       = wa_output-brtxt.
    ls_final-vkbur       = wa_output-vkbur.
    ls_final-vbeln       = wa_output-vbeln.
    IF wa_output-erdat IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-erdat
        IMPORTING
          output = ls_final-erdat.
      CONCATENATE ls_final-erdat+0(2) ls_final-erdat+2(3) ls_final-erdat+5(4)
                     INTO ls_final-erdat SEPARATED BY '-'.
    ENDIF.

    IF wa_output-bstdk IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-bstdk
        IMPORTING
          output = ls_final-bstdk.
      CONCATENATE ls_final-bstdk+0(2) ls_final-bstdk+2(3) ls_final-bstdk+5(4)
                     INTO ls_final-bstdk SEPARATED BY '-'.
    ENDIF.








    IF wa_output-vdatu IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-vdatu
        IMPORTING
          output = ls_final-vdatu.
      CONCATENATE ls_final-vdatu+0(2) ls_final-vdatu+2(3) ls_final-vdatu+5(4)
                     INTO ls_final-vdatu SEPARATED BY '-'.
    ENDIF.


    ls_final-status      = wa_output-status.


    IF wa_output-holddate IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-holddate
        IMPORTING
          output = ls_final-holddate.
      CONCATENATE ls_final-holddate+0(2) ls_final-holddate+2(3) ls_final-holddate+5(4)
                     INTO ls_final-holddate SEPARATED BY '-'.
    ENDIF.

    IF wa_output-reldate IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-reldate
        IMPORTING
          output = ls_final-reldate.
      CONCATENATE ls_final-reldate+0(2) ls_final-reldate+2(3) ls_final-reldate+5(4)
                     INTO ls_final-reldate SEPARATED BY '-'.
    ENDIF.

    IF wa_output-canceldate IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-canceldate
        IMPORTING
          output = ls_final-canceldate.
      CONCATENATE ls_final-canceldate+0(2) ls_final-canceldate+2(3) ls_final-canceldate+5(4)
                     INTO ls_final-canceldate SEPARATED BY '-'.
    ENDIF.

    IF wa_output-deldate IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-deldate
        IMPORTING
          output = ls_final-deldate.
      CONCATENATE ls_final-deldate+0(2) ls_final-deldate+2(3) ls_final-deldate+5(4)
                     INTO ls_final-deldate SEPARATED BY '-'.
    ENDIF.


    ls_final-tpi         = wa_output-tpi.
    ls_final-tag_req     = wa_output-tag_req.
    ls_final-ld_txt      = wa_output-ld_txt.
    ls_final-matnr       = wa_output-matnr.
    ls_final-wrkst       = wa_output-wrkst.
    ls_final-ABGRU       = wa_output-ABGRU.
    ls_final-BEZEI       = wa_output-BEZEI.
    ls_final-bklas       = wa_output-bklas.
    ls_final-posnr       = wa_output-posnr.
    ls_final-arktx       = wa_output-arktx.
    ls_final-kwmeng      = abs( wa_output-kwmeng ).
    ls_final-lfimg       = abs( wa_output-lfimg ).
    ls_final-fkimg       = abs( wa_output-fkimg ).
    ls_final-pnd_qty     = abs( wa_output-pnd_qty ).
    ls_final-ettyp       = wa_output-ettyp.
    IF wa_output-mrp_dt IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-mrp_dt
        IMPORTING
          output = ls_final-mrp_dt.
      CONCATENATE ls_final-mrp_dt+0(2) ls_final-mrp_dt+2(3) ls_final-mrp_dt+5(4)
                     INTO ls_final-mrp_dt SEPARATED BY '-'.
    ENDIF.

    IF wa_output-edatu IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-edatu
        IMPORTING
          output = ls_final-edatu.
      CONCATENATE ls_final-edatu+0(2) ls_final-edatu+2(3) ls_final-edatu+5(4)
                     INTO ls_final-edatu SEPARATED BY '-'.
    ENDIF.


    ls_final-kbetr       = wa_output-kbetr.
    ls_final-waerk       = wa_output-waerk.
    ls_final-amont       = abs( wa_output-amont ).
    ls_final-ordr_amt    = abs( wa_output-ordr_amt ).
    ls_final-st_cost     = abs( wa_output-st_cost ).

*    ls_final-est_cost    = abs( wa_output-est_cost ).

    ls_final-zseries     = wa_output-zseries.
    ls_final-zsize       = wa_output-zsize.
    ls_final-brand       = wa_output-brand.
    ls_final-moc         = wa_output-moc.
    ls_final-type        = wa_output-type.
    ls_final-dispo       = wa_output-dispo.
    ls_final-mtart       = wa_output-mtart.
    ls_final-mattxt      = wa_output-mattxt.
    REPLACE ALL OCCURRENCES OF '<(>&<)>' IN ls_final-mattxt WITH ' & '.
    ls_final-etenr       = wa_output-etenr.
    ls_final-schid       = wa_output-schid.
    ls_final-zterm       = wa_output-zterm.
    ls_final-inco1       = wa_output-inco1.
    ls_final-inco2       = wa_output-inco2.
    ls_final-text1       = wa_output-text1.
    IF wa_output-custdeldate IS NOT INITIAL .
      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
        EXPORTING
          input  = wa_output-custdeldate
        IMPORTING
          output = ls_final-custdeldate.
      CONCATENATE ls_final-custdeldate+0(2) ls_final-custdeldate+2(3) ls_final-custdeldate+5(4)
                     INTO ls_final-custdeldate SEPARATED BY '-'.
    ENDIF.


    ls_final-bname       = wa_output-bname.
    ls_final-eccn        = wa_output-eccn.

    CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
      EXPORTING
        input  = sy-datum
      IMPORTING
        output = ls_final-ref_dt.
    CONCATENATE ls_final-ref_dt+0(2) ls_final-ref_dt+2(3) ls_final-ref_dt+5(4)
                   INTO ls_final-ref_dt SEPARATED BY '-'.


     ls_final-ship_name   =     wa_output-ship_name.
     ls_final-stras       =     wa_output-stras    .
     ls_final-pstlz       =     wa_output-pstlz    .
     ls_final-ort01       =     wa_output-ort01    .
     ls_final-ship_rig    =     wa_output-ship_rig.
     ls_final-ship_land   =     wa_output-ship_land.












*    IF wa_output-zldfromdate IS NOT INITIAL .
*      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*        EXPORTING
*          input  = wa_output-zldfromdate
*        IMPORTING
*          output = ls_final-zldfromdate.
*      CONCATENATE ls_final-zldfromdate+0(2) ls_final-zldfromdate+2(3) ls_final-zldfromdate+5(4)
*                     INTO ls_final-zldfromdate SEPARATED BY '-'.
*    ENDIF.



*
*    IF wa_output-in_pr_dt IS NOT INITIAL .
*      CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*        EXPORTING
*          input  = wa_output-in_pr_dt
*        IMPORTING
*          output = ls_final-in_pr_dt.
*      CONCATENATE ls_final-in_pr_dt+0(2) ls_final-in_pr_dt+2(3) ls_final-in_pr_dt+5(4)
*                     INTO ls_final-in_pr_dt SEPARATED BY '-'.
*    ENDIF.
*

    CONDENSE ls_final-kwmeng.
    IF wa_output-kwmeng < 0.
      CONCATENATE '-' ls_final-kwmeng INTO ls_final-kwmeng.
    ENDIF.

    CONDENSE ls_final-lfimg.
    IF wa_output-lfimg < 0.
      CONCATENATE '-' ls_final-lfimg INTO ls_final-lfimg.
    ENDIF.

    CONDENSE ls_final-fkimg.
    IF wa_output-fkimg < 0.
      CONCATENATE '-' ls_final-fkimg INTO ls_final-fkimg.
    ENDIF.

    CONDENSE ls_final-pnd_qty.
    IF wa_output-pnd_qty < 0.
      CONCATENATE '-' ls_final-pnd_qty INTO ls_final-pnd_qty.
    ENDIF.

*    CONDENSE ls_final-qmqty.
*    IF wa_output-qmqty < 0.
*      CONCATENATE '-' ls_final-qmqty INTO ls_final-qmqty.
*    ENDIF.

    CONDENSE ls_final-kbetr.
    IF wa_output-kbetr < 0.
      CONCATENATE '-' ls_final-kbetr INTO ls_final-kbetr.
    ENDIF.

*    CONDENSE ls_final-kalab.
*    IF ls_final-kalab < 0.
*      CONCATENATE '-' ls_final-kalab INTO ls_final-kalab.
*    ENDIF.

*    CONDENSE ls_final-so_exc.
*    IF ls_final-so_exc < 0.
*      CONCATENATE '-' ls_final-so_exc INTO ls_final-so_exc.
*    ENDIF.

    CONDENSE ls_final-amont.
    IF wa_output-amont < 0.
      CONCATENATE '-' ls_final-amont INTO ls_final-amont.
    ENDIF.

    CONDENSE ls_final-ordr_amt.
    IF wa_output-ordr_amt < 0.
      CONCATENATE '-' ls_final-ordr_amt INTO ls_final-ordr_amt.
    ENDIF.


*    CONDENSE ls_final-in_price.
*    IF wa_output-in_price < 0.
*      CONCATENATE '-' ls_final-in_price INTO ls_final-in_price.
*    ENDIF.

*    CONDENSE ls_final-est_cost.
*    IF wa_output-est_cost < 0.
*      CONCATENATE '-' ls_final-est_cost INTO ls_final-est_cost.
*    ENDIF.

*    CONDENSE ls_final-latst_cost.
*    IF wa_output-latst_cost < 0.
*      CONCATENATE '-' ls_final-latst_cost INTO ls_final-latst_cost.
*    ENDIF.

    CONDENSE ls_final-st_cost.
    IF wa_output-st_cost < 0.
      CONCATENATE '-' ls_final-st_cost INTO ls_final-st_cost.
    ENDIF.

*    CONDENSE ls_final-wip.
*    IF ls_final-wip < 0.
*      CONCATENATE '-' ls_final-wip INTO ls_final-wip.
*
*    ENDIF.

    APPEND ls_final TO gt_final.
    CLEAR:
      ls_final,wa_output.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DOWN_SET_ALL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM down_set_all .

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
      i_tab_sap_data       = it_output
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
  lv_file = 'ZUSPENDSOALL.TXT'.

  CONCATENATE p_folder '\' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUSPENDSO Download started on', sy-datum, 'at', sy-uzeit.
  IF open_so IS NOT INITIAL.
    WRITE: / 'Open Sales Orders'.
  ELSE.
    WRITE: / 'All Sales Orders'.
  ENDIF.
  WRITE: / 'Sales Order Dt. From', s_date-low, 'To', s_date-high.
  WRITE: / 'Material code   From', s_matnr-low, 'To', s_matnr-high.
  WRITE: / 'Dest. File:', lv_fullfile.

  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
    TRANSFER hd_csv TO lv_fullfile.
    LOOP AT it_csv INTO wa_csv.
      IF sy-subrc = 0.
        TRANSFER wa_csv TO lv_fullfile.

      ENDIF.
    ENDLOOP.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.


******************************************************new file zpendso **********************************
  PERFORM new_file.
  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = gt_final
    CHANGING
      i_tab_converted_data = it_csv
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  PERFORM cvs_header USING hd_csv.

*

*lv_folder = 'D:\usr\sap\DEV\D00\work'.
  lv_file = 'ZUSPENDSOALL.TXT'.

  CONCATENATE p_folder '\' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUSPENDSO Download started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
    TRANSFER hd_csv TO lv_fullfile.
    LOOP AT it_csv INTO wa_csv.
      IF sy-subrc = 0.
        TRANSFER wa_csv TO lv_fullfile.

      ENDIF.
    ENDLOOP.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.




ENDFORM.

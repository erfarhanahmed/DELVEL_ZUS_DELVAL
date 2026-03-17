
REPORT zus_stock_planning_fi.

TABLES : mara,mard,mseg,ekpo,eket,vbbe,msku.

TYPES : BEGIN OF ty_mara,
          matnr   TYPE mara-matnr,
          zseries TYPE mara-zseries,
          zsize   TYPE mara-zsize,
          brand   TYPE mara-brand,
          moc     TYPE mara-moc,
          type    TYPE mara-type,
          wrkst   TYPE mara-wrkst,
*          bwart   TYPE mara-bwart,
        END OF ty_mara.

DATA : it_mara TYPE STANDARD TABLE OF ty_mara,
       wa_mara TYPE ty_mara.

TYPES : BEGIN OF ty_vbbe,
          matnr TYPE vbbe-matnr,
          werks TYPE vbbe-werks,
          omeng TYPE vbbe-omeng,
        END OF ty_vbbe.

DATA : it_vbbe TYPE STANDARD TABLE OF ty_vbbe,
       wa_vbbe TYPE ty_vbbe.

TYPES : BEGIN OF ty_mard,
          matnr TYPE mard-matnr,
          lgort TYPE mard-lgort,
          werks TYPE mard-werks,
          labst TYPE mard-labst,
        END OF ty_mard.

DATA : it_mard TYPE STANDARD TABLE OF ty_mard,
       wa_mard TYPE ty_mard.

TYPES : BEGIN OF ty_msku,
          matnr TYPE msku-matnr,
          werks TYPE msku-werks,
          kulab TYPE msku-kulab,
        END OF ty_msku.

DATA : it_msku TYPE STANDARD TABLE OF ty_msku,
       wa_msku TYPE ty_msku.

TYPES : BEGIN OF ty_mseg,
          matnr    TYPE mseg-matnr,
          mblnr    TYPE mseg-mblnr,
          ZEILE    TYPE mseg-ZEILE,
          bwart    TYPE mseg-bwart,
          werks    TYPE mseg-werks,
          vbeln_im TYPE mseg-vbeln_im,
          vbelp_im TYPE mseg-vbelp_im,
          menge    TYPE mseg-menge,
          ebeln    TYPE mseg-ebeln,
          ebelp    TYPE mseg-ebelp,
        END OF ty_mseg.

DATA : it_mseg TYPE STANDARD TABLE OF ty_mseg,
       wa_mseg TYPE ty_mseg.

TYPES: BEGIN OF ty_transit,
       ebeln TYPE ekpo-ebeln,
       ebelp TYPE ekpo-ebelp,
       matnr TYPE ekpo-matnr,
       werks TYPE ekpo-werks,
       netpr TYPE ekpo-netpr,
       END OF ty_transit.

DATA: it_transit TYPE TABLE OF ty_transit,
      wa_transit TYPE          ty_transit.


TYPES: BEGIN OF ty_konv,
       knumv TYPE PRCD_ELEMENTS-knumv,
       kposn TYPE PRCD_ELEMENTS-kposn,
       kschl TYPE PRCD_ELEMENTS-kschl,
       kbetr TYPE PRCD_ELEMENTS-kbetr,
       END OF ty_konv.

DATA: it_konv TYPE TABLE OF ty_konv,
      wa_konv TYPE          ty_konv.

TYPES : BEGIN OF ty_rev,
          mblnr   TYPE mseg-mblnr,
          zeile   TYPE mseg-zeile,
          line_id TYPE mseg-line_id,
          bwart   TYPE mseg-bwart,
          matnr   TYPE mseg-matnr,
          werks   TYPE mseg-werks,
          menge   TYPE mseg-menge,
          smbln   TYPE mseg-smbln,
        END OF ty_rev.

DATA : it_rev TYPE STANDARD TABLE OF ty_rev,
       wa_rev TYPE ty_rev.

DATA : it_rev1 TYPE STANDARD TABLE OF ty_rev,
       wa_rev1 TYPE ty_rev.

DATA : it_mseg_105 TYPE STANDARD TABLE OF ty_mseg,
       wa_mseg_105 TYPE ty_mseg.

TYPES : BEGIN OF ty_grn,
          matnr    TYPE mseg-matnr,
          mblnr    TYPE mseg-mblnr,
          ZEILE    TYPE mseg-ZEILE,
          bwart    TYPE mseg-bwart,
          werks    TYPE mseg-werks,
          vbeln_im TYPE mseg-vbeln_im,
          vbelp_im TYPE mseg-vbelp_im,
          menge    TYPE mseg-menge,
          dmbtr    TYPE mseg-dmbtr,
          kzbew    TYPE mseg-kzbew,
          smbln    TYPE mseg-smbln,
        END OF ty_grn.

DATA : it_grn TYPE TABLE OF ty_grn,
       wa_grn TYPE ty_grn.

DATA : it_grn_rev TYPE TABLE OF ty_grn,
       wa_grn_rev TYPE          ty_grn.


TYPES: BEGIN OF ty_ekpo,
         matnr TYPE ekpo-matnr,
         ebeln TYPE ekpo-ebeln,
         ebelp TYPE ekpo-ebelp,
         menge TYPE ekpo-menge,
         loekz TYPE ekpo-loekz,
         elikz TYPE ekpo-elikz,
         werks TYPE ekpo-werks,
         retpo TYPE ekpo-retpo,
         brtwr TYPE ekpo-brtwr,
       END OF ty_ekpo.
*
*DATA : it_ekpo TYPE STANDARD TABLE OF ty_ekpo,
*       wa_ekpo TYPE ty_ekpo.
*
DATA : it_ekpo1 TYPE STANDARD TABLE OF ty_ekpo,
       wa_ekpo1 TYPE ty_ekpo.

TYPES : BEGIN OF ty_ekpo_eket,

          ebeln TYPE ekpo-ebeln,
          ebelp TYPE ekpo-ebelp,
          matnr TYPE ekpo-matnr,
          menge TYPE ekpo-menge,
          loekz TYPE ekpo-loekz,
          elikz TYPE ekpo-elikz,
          werks TYPE ekpo-werks,
          retpo TYPE ekpo-retpo,
          brtwr TYPE ekpo-brtwr,
          wemng TYPE eket-wemng,
        END OF ty_ekpo_eket.

DATA : it_ekpo_eket TYPE STANDARD TABLE OF ty_ekpo_eket,
       wa_ekpo_eket TYPE ty_ekpo_eket.

TYPES : BEGIN OF ty_vbap,
          vbeln  TYPE vbap-vbeln,
          posnr  TYPE vbap-posnr,
          matnr  TYPE vbap-matnr,
          werks  TYPE vbap-werks,
          kwmeng TYPE vbap-kwmeng,
        END OF ty_vbap.

DATA: it_vbap TYPE TABLE OF ty_vbap,
      wa_vbap TYPE          ty_vbap.

TYPES :BEGIN OF ty_vbup,
         vbeln TYPE vbup-vbeln,
         posnr TYPE vbup-posnr,
         lfgsa TYPE vbup-lfgsa,
       END OF ty_vbup.

DATA :it_vbup TYPE TABLE OF ty_vbup,
      wa_vbup TYPE          ty_vbup.

TYPES : BEGIN OF ty_lips,
          vbeln TYPE lips-vbeln,
          posnr TYPE lips-posnr,
          vgbel TYPE lips-vgbel,
          vgpos TYPE lips-vgpos,
          matnr TYPE lips-matnr,
          werks TYPE lips-werks,
          lfimg TYPE lips-lfimg,
        END OF ty_lips.

DATA: it_lips TYPE TABLE OF ty_lips,
      wa_lips TYPE          ty_lips.


TYPES : BEGIN OF ty_mara_mard,
          matnr   TYPE mara-matnr,
          zseries TYPE mara-zseries,
          zsize   TYPE mara-zsize,
          brand   TYPE mara-brand,
          moc     TYPE mara-moc,
          type    TYPE mara-type,
          wrkst   TYPE mara-wrkst,
          werks   TYPE mard-werks,
        END OF ty_mara_mard.

DATA : it_mara_mard TYPE STANDARD TABLE OF ty_mara_mard,
       wa_mara_mard TYPE ty_mara_mard.

TYPES : BEGIN OF ty_vbak,
          vbeln TYPE vbak-vbeln,
          vbtyp TYPE vbak-vbtyp,
          knumv TYPE vbak-knumv,
        END OF ty_vbak.

DATA : it_vbak TYPE TABLE OF ty_vbak,
       wa_vbak TYPE ty_vbak.

TYPES: BEGIN OF ty_mbew,
       matnr TYPE mbew-matnr,
       bwkey TYPE mbew-bwkey,
       salk3 TYPE mbew-salk3,
       vprsv TYPE mbew-vprsv,
       verpr TYPE mbew-verpr,
       stprs TYPE mbew-stprs,
       END OF ty_mbew.

DATA: it_mbew TYPE TABLE OF ty_mbew,
      wa_mbew TYPE          ty_mbew.

TYPES: BEGIN OF ty_data,
         vbeln  TYPE vbeln,
         posnr  TYPE posnr,
         matnr  TYPE matnr,
         werks  TYPE werks,
         kwmeng TYPE kwmeng,
         abgru  TYPE abgru,

       END OF ty_data.

DATA: it_data TYPE STANDARD TABLE OF ty_data,
      wa_data TYPE ty_data.

TYPES: BEGIN OF ty_open_inv,
       vbeln TYPE lips-vbeln,
       posnr TYPE lips-posnr,
       matnr TYPE lips-matnr,
       werks TYPE lips-werks,
       lfimg TYPE lips-lfimg,
       vkbur TYPE lips-vkbur,
       fksta TYPE vbup-fksta,
       END OF ty_open_inv.

DATA: it_open_inv TYPE TABLE OF ty_open_inv,
      wa_open_inv TYPE          ty_open_inv.
TYPES : BEGIN OF ty_final,
          matnr       TYPE mara-matnr,
          zseries     TYPE mara-zseries,
          zsize       TYPE mara-zsize,
          brand       TYPE mara-brand,
          moc         TYPE mara-moc,
          type        TYPE mara-type,
          wrkst       TYPE mara-wrkst,

          vbeln       TYPE vbap-vbeln,
          posnr       TYPE vbap-posnr,
          lfgsa       TYPE vbup-lfgsa,

          vgbel       TYPE lips-vgbel,
          vgpos       TYPE lips-vgpos,
          lfimg       TYPE lips-lfimg,

          werks       TYPE mard-werks,
          labst       TYPE p DECIMALS 0,

          omeng       TYPE vbbe-omeng,

          kulab       TYPE p DECIMALS 0,

          bwart       TYPE mseg-bwart,
          vbeln_im    TYPE mseg-vbeln_im,
          vbelp_im    TYPE mseg-vbelp_im,
          mseg_menge  TYPE mseg-menge,
          mseg_menge1 TYPE mseg-menge,
          mblnr       TYPE mseg-mblnr,
          smbln       TYPE mseg-smbln,

          ebeln       TYPE ekpo-ebeln,
          ebelp       TYPE ekpo-ebelp,
          menge       TYPE ekpo-menge,
          loekz       TYPE ekpo-loekz,
          elikz       TYPE ekpo-elikz,

          wemng       TYPE eket-wemng,
*          lv_desc     TYPE tdline,
          mattxt      TYPE text100,
          free_stock  TYPE p DECIMALS 0,
          tran_qty    TYPE p DECIMALS 0,
          so_fall_qty TYPE p DECIMALS 0,
          menge2      TYPE string,
          menge3      TYPE string,
          menge4      TYPE string,
*          pend_po_qty TYPE string,
          pend_po_qty TYPE p DECIMALS 0,
          indent_qty  TYPE p DECIMALS 0,
          open_qty    TYPE p DECIMALS 0,
          vbap_qty    TYPE vbrp-fkimg,
          lips_qty    TYPE vbrp-fkimg,
          retpo       TYPE ekpo-retpo,
          neg         TYPE string,
          open_inv    TYPE p DECIMALS 0,
          value       TYPE mseg-dmbtr,
          OPEN_QTY_V      TYPE mseg-dmbtr,
          LABST_V         TYPE mseg-dmbtr,
          KULAB_V         TYPE mseg-dmbtr,
          FREE_STOCK_V    TYPE mseg-dmbtr,
          TRAN_QTY_V      TYPE mseg-dmbtr,
          SO_FALL_QTY_V   TYPE mseg-dmbtr,
          PEND_PO_QTY_V   TYPE mseg-dmbtr,
          INDENT_QTY_V    TYPE mseg-dmbtr,
          OPEN_INV_V      TYPE mseg-dmbtr,
          amount          TYPE mseg-dmbtr,
          price           TYPE mseg-dmbtr,
          po_val          TYPE ekpo-brtwr,
          po_val1         TYPE ekpo-brtwr,
          po_val2         TYPE ekpo-brtwr,
          po_value        TYPE ekpo-brtwr,
          grn_value       TYPE mseg-dmbtr,
          un_qty          TYPE p DECIMALS 0,
          un_Val          TYPE mseg-dmbtr,
*          LABST_V     TYPE mseg-dmbtr,

        END OF ty_final.

DATA : it_final TYPE STANDARD TABLE OF ty_final,
       wa_final TYPE ty_final.

TYPES : BEGIN OF ty_final_download,
          matnr         TYPE mara-matnr,
          mattxt        TYPE text100,
          wrkst         TYPE mara-wrkst,
          brand         TYPE mara-brand,
          zseries       TYPE mara-zseries,
          zsize         TYPE mara-zsize,
          moc           TYPE mara-moc,
          type          TYPE mara-type,
          open_qty      TYPE char15,
          price         TYPE char15,
          un_qty        TYPE char15,
          un_Val        TYPE char15,
          OPEN_QTY_V    TYPE char15,
          labst         TYPE char15,
          LABST_V       TYPE char15,
          kulab         TYPE char15,
          KULAB_V       TYPE char15,
          free_stock    TYPE char15,
          FREE_STOCK_V  TYPE char15,
          tran_qty      TYPE char15,
          TRAN_QTY_V    TYPE char15,
          so_fall_qty   TYPE char15,
          SO_FALL_QTY_V TYPE char15,
          pend_po_qty   TYPE char15,
          po_value      TYPE char15,
*          indent_qty    TYPE char15,
*          INDENT_QTY_V  TYPE char15,
          open_inv      TYPE char15,
          amount        TYPE char15,
          value         TYPE char15,
          ref           TYPE char15,

        END OF ty_final_download.

DATA : lt_final TYPE TABLE OF ty_final_download,
       ls_final TYPE ty_final_download.

DATA  : gt_fieldcat TYPE slis_t_fieldcat_alv,
        gs_fieldcat TYPE slis_fieldcat_alv.

DATA : gt_lines TYPE TABLE OF tline,
       ls_lines TYPE tline.

DATA : lv_desc TYPE tline.

DATA : pr_count TYPE i.

DATA : neg TYPE string.
DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt TYPE tline,
      ls_mattxt TYPE tline.

SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS : mat FOR mara-matnr.
PARAMETERS: plant LIKE mard-werks DEFAULT 'US01'.
SELECTION-SCREEN : END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT 'E:\delval\usa'.
SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.
IF PLANT NE 'PL01'.
  PERFORM get_data.
  PERFORM process_data.
*  PERFORM get_matdesc.
  PERFORM fcat.
  PERFORM display_data.
else.
  MESSAGE 'This Report valid For US01 & US02 Plant' TYPE 'S'.
  ENDIF.
FORM get_data .

  SELECT
    a~matnr
    a~zseries
    a~zsize
    a~brand
    a~moc
    a~type
    a~wrkst
    b~werks
    INTO TABLE it_mara_mard
    FROM mara AS a
    INNER JOIN mard AS b ON b~matnr = a~matnr
    WHERE a~matnr IN mat AND b~werks EQ plant.

  DELETE ADJACENT DUPLICATES FROM it_mara_mard COMPARING matnr.


  SELECT a~vbeln a~posnr a~matnr a~werks a~kwmeng a~abgru
      INTO TABLE it_data
      FROM  vbap AS a
      JOIN  vbup AS b ON ( b~vbeln = a~vbeln  AND b~posnr = a~posnr )
      FOR ALL ENTRIES IN it_mara_mard
      WHERE a~matnr = it_mara_mard-matnr
      AND   a~werks  = it_mara_mard-werks
      AND   a~abgru = ''
      AND   b~lfsta  NE 'C'.


  SELECT a~vbeln a~posnr a~matnr a~werks a~lfimg a~vkbur b~fksta
      INTO TABLE it_open_inv
      FROM  lips AS a
      JOIN  vbup AS b ON ( b~vbeln = a~vbeln  AND b~posnr = a~posnr )
      FOR ALL ENTRIES IN it_mara_mard
      WHERE a~matnr = it_mara_mard-matnr
      AND   a~werks  = it_mara_mard-werks
      AND   a~vkbur  = 'US01'
      AND   b~fksta  NE 'C'.

  SELECT
    vbeln
    vbtyp
    knumv
    FROM vbak
    INTO TABLE it_vbak
    FOR ALL ENTRIES IN it_data
    WHERE vbeln = it_data-vbeln
    AND   vbtyp IN ( 'C' , 'I' , 'H' ).


IF it_vbak IS NOT INITIAL.
SELECT knumv
       kposn
       kschl
       kbetr FROM PRCD_ELEMENTS INTO TABLE it_konv
       FOR ALL ENTRIES IN it_vbak
       WHERE knumv = it_vbak-knumv
        AND  kschl = 'ZPR0'.
ENDIF.

  SELECT
    vbeln
    posnr
    vgbel
    vgpos
    matnr
    werks
    lfimg
    FROM lips
    INTO TABLE it_lips
           FOR ALL ENTRIES IN it_data
           WHERE vgbel = it_data-vbeln
            AND  vgpos = it_data-posnr.

  IF it_mara_mard IS NOT INITIAL.
    SELECT matnr
           zseries
           zsize
           brand
           moc
           type
           wrkst   FROM mara INTO TABLE it_mara
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr.


    SELECT
            matnr
            lgort
            werks
            labst
            FROM mard
            INTO TABLE it_mard
            FOR ALL ENTRIES IN it_mara_mard
            WHERE matnr = it_mara_mard-matnr
            AND werks = it_mara_mard-werks.

    SELECT matnr
           bwkey
           salk3
           vprsv
           verpr
           stprs FROM mbew INTO TABLE it_mbew
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND bwkey = it_mara_mard-werks.


  ENDIF.

  IF it_mara_mard IS NOT INITIAL.
    SELECT
      matnr
      werks
      omeng
      FROM vbbe
      INTO TABLE it_vbbe
      FOR ALL ENTRIES IN it_mara_mard
      WHERE matnr EQ it_mara_mard-matnr AND werks EQ it_mara_mard-werks.
  ENDIF.

  IF it_mara_mard IS NOT INITIAL .
    SELECT
      matnr
      werks
      kulab
      FROM msku
      INTO TABLE it_msku
      FOR ALL ENTRIES IN it_mara_mard
      WHERE matnr EQ it_mara_mard-matnr.
  ENDIF.

IF it_mara_mard IS NOT INITIAL .
  SELECT ebeln
         ebelp
         matnr
         werks
         netpr FROM ekpo INTO TABLE it_transit
         FOR ALL ENTRIES IN it_mara_mard
         WHERE matnr = it_mara_mard-matnr
         AND   werks = it_mara_mard-werks.
 ENDIF.



  IF it_transit IS NOT INITIAL .
    SELECT
      matnr
      mblnr
      ZEILE
      bwart
      werks
      vbeln_im
      vbelp_im
      menge
      ebeln
      ebelp
      FROM mseg
      INTO TABLE it_mseg
      FOR ALL ENTRIES IN it_transit
      WHERE matnr = it_transit-matnr
      AND   werks = it_transit-werks
      AND   ebeln = it_transit-ebeln
      AND   ebelp = it_transit-ebelp
      AND bwart = '103'.
  ENDIF.

  IF it_transit IS NOT INITIAL .
    SELECT
      matnr
      mblnr
      ZEILE
      bwart
      werks
      vbeln_im
      vbelp_im
      menge
      ebeln
      ebelp
      FROM mseg
      INTO TABLE it_mseg_105
      FOR ALL ENTRIES IN it_transit
      WHERE matnr = it_transit-matnr
      AND   werks = it_transit-werks
      AND   ebeln = it_transit-ebeln
      AND   ebelp = it_transit-ebelp
      AND bwart = '105'.
  ENDIF.

  IF it_mara_mard IS NOT INITIAL.

   SELECT matnr
          mblnr
          ZEILE
          bwart
          werks
          vbeln_im
          vbelp_im
          menge
          dmbtr
          kzbew
          smbln  FROM mseg
          INTO TABLE it_grn
          FOR ALL ENTRIES IN it_mara_mard
          WHERE matnr = it_mara_mard-matnr
          AND   werks = it_mara_mard-werks
          AND bwart IN ( '101' , '105' )
          AND kzbew NE 'F'.

  ENDIF.

  IF it_grn IS NOT INITIAL.
   SELECT matnr
          mblnr
          ZEILE
          bwart
          werks
          vbeln_im
          vbelp_im
          menge
          dmbtr
          kzbew
          smbln  FROM mseg
          INTO TABLE it_grn_rev
          FOR ALL ENTRIES IN it_grn
          WHERE smbln = it_grn-mblnr
           AND  matnr = it_grn-matnr.


  ENDIF.

 SORT it_grn DESCENDING BY mblnr.

  IF it_mseg IS NOT INITIAL.
    SELECT mblnr
           zeile
           line_id
           bwart
           matnr
           werks
           menge
           smbln  FROM mseg INTO TABLE it_rev
           FOR ALL ENTRIES IN it_mseg
           WHERE smbln = it_mseg-mblnr
            AND  matnr = it_mseg-matnr.
  ENDIF.

  IF it_mseg_105 IS NOT INITIAL.
    SELECT mblnr
           zeile
           line_id
           bwart
           matnr
           werks
           menge
           smbln
      FROM mseg INTO TABLE it_rev1
           FOR ALL ENTRIES IN it_mseg_105
           WHERE smbln = it_mseg_105-mblnr
            AND  matnr = it_mseg_105-matnr.
  ENDIF.


  SELECT a~ebeln
         a~ebelp
         a~matnr
         a~menge
         a~loekz
         a~elikz
         a~werks
         a~retpo
         a~brtwr
         b~wemng
         INTO TABLE it_ekpo_eket
         FROM ekpo AS a
         INNER JOIN eket AS b
         ON a~ebeln = b~ebeln
         AND a~ebelp = b~ebelp
         FOR ALL ENTRIES IN it_mara_mard
         WHERE a~matnr EQ it_mara_mard-matnr AND a~werks EQ it_mara_mard-werks
         AND a~loekz NE 'L' AND a~retpo NE 'X'.



  IF it_mara_mard IS NOT INITIAL .
   SELECT matnr
          ebeln
          ebelp
          menge
          loekz
          elikz
          werks
          retpo
          brtwr
          FROM ekpo
          INTO TABLE it_ekpo1
          FOR ALL ENTRIES IN it_mara_mard
          WHERE matnr EQ it_mara_mard-matnr
          AND werks EQ it_mara_mard-werks
          AND retpo EQ 'X'.
          ENDIF.

ENDFORM.

FORM process_data .

  SORT it_ekpo1 .

LOOP AT it_mara INTO wa_mara.

    READ TABLE it_mara_mard INTO wa_mara_mard WITH KEY matnr = wa_mara-matnr.
    IF sy-subrc = 0.
     wa_final-matnr   = wa_mara_mard-matnr  .
     wa_final-zseries = wa_mara_mard-zseries.
     wa_final-zsize   = wa_mara_mard-zsize  .
     wa_final-brand   = wa_mara_mard-brand  .
     wa_final-moc     = wa_mara_mard-moc    .
     wa_final-type    = wa_mara_mard-type   .
     wa_final-wrkst   = wa_mara_mard-wrkst  .

    ENDIF.

    READ TABLE it_mbew INTO wa_mbew WITH KEY matnr = wa_mara_mard-matnr  bwkey = wa_mara_mard-werks.
    IF sy-subrc = 0.
      IF wa_mbew-VPRSV = 'V'.
         wa_final-value = wa_mbew-verpr.
      ELSE .
         wa_final-value = wa_mbew-stprs.
      ENDIF.
     wa_final-labst_v = wa_mbew-salk3.
     wa_final-un_val  = wa_mbew-salk3.
    ENDIF.


    CLEAR wa_final-labst.
    LOOP AT it_mard INTO wa_mard WHERE matnr = wa_mara_mard-matnr AND werks = wa_mara_mard-werks.
      wa_final-labst = wa_final-labst + wa_mard-labst.
      wa_final-un_qty = wa_final-un_qty + wa_mard-labst.
    ENDLOOP.

    CLEAR wa_vbap.
    CLEAR wa_vbup.
    CLEAR wa_lips.
    CLEAR wa_final-vbap_qty.
    CLEAR wa_vbap-kwmeng.

     LOOP AT it_open_inv INTO wa_open_inv WHERE matnr = wa_mara_mard-matnr AND werks = wa_mara_mard-werks..
       wa_final-open_inv = wa_final-open_inv + wa_open_inv-lfimg.
     ENDLOOP.

    CLEAR wa_vbak.
    CLEAR wa_final-lips_qty.
    CLEAR wa_lips-lfimg.

DATA:qty TYPE vbap-kwmeng,
     del TYPE vbap-kwmeng,
     pending TYPE vbap-kwmeng,
     price TYPE PRCD_ELEMENTS-kbetr.
    CLEAR: qty,price.

    LOOP AT it_data INTO wa_data WHERE matnr = wa_mara_mard-matnr AND werks = wa_mara_mard-werks.
    CLEAR: qty,price,pending,del.
      wa_final-vbeln = wa_data-vbeln.
      wa_final-posnr = wa_data-posnr.
      READ TABLE it_vbak INTO wa_vbak WITH KEY vbeln = wa_data-vbeln.
      IF sy-subrc = 0.
        wa_final-vbap_qty = wa_final-vbap_qty + wa_data-kwmeng.
        qty = qty + wa_data-kwmeng.
      ENDIF.

      READ TABLE it_konv INTO wa_konv WITH KEY knumv = wa_vbak-knumv kposn = wa_data-posnr.
      IF sy-subrc = 0.

      ENDIF.


        LOOP AT it_lips INTO wa_lips WHERE vgbel = wa_final-vbeln AND  vgpos = wa_final-posnr.
        wa_final-lips_qty = wa_final-lips_qty + wa_lips-lfimg.
        del = del + wa_lips-lfimg.
        ENDLOOP.
        pending = qty - del.
        price = pending * wa_konv-kbetr.
        wa_final-price = wa_final-price + price.
    ENDLOOP.



    CLEAR wa_final-open_qty.

    wa_final-open_qty = wa_final-vbap_qty - wa_final-lips_qty .


    READ TABLE it_msku INTO wa_msku WITH KEY matnr = wa_mara_mard-matnr.
    IF sy-subrc = 0.
      wa_final-kulab = wa_msku-kulab.
    ENDIF.

*********************** GRN Amount ********************************

    READ TABLE it_grn INTO wa_grn WITH KEY matnr = wa_mara_mard-matnr werks = wa_mara_mard-werks.
    IF sy-subrc = 0.
      wa_final-amount = wa_grn-dmbtr / wa_grn-menge .
    ENDIF.

    LOOP AT it_grn INTO wa_grn WHERE matnr = wa_mara_mard-matnr AND werks = wa_mara_mard-werks.
     READ TABLE it_grn_rev INTO wa_grn_rev WITH KEY smbln = wa_grn-mblnr matnr = wa_grn-matnr.
      IF sy-subrc = 4.
        wa_final-grn_value = wa_final-grn_value + wa_grn-dmbtr.
      ENDIF.
    ENDLOOP.



DATA:tran_val TYPE mseg-dmbtr,
     tran_qty TYPE mseg-menge,
     mseg_qty TYPE mseg-menge,
     mseg_qty1 TYPE mseg-menge.


LOOP AT it_transit INTO wa_transit WHERE matnr = wa_mara_mard-matnr AND werks = wa_mara_mard-werks..
CLEAR: tran_val,tran_qty,mseg_qty ,mseg_qty1.
    LOOP AT it_mseg INTO wa_mseg WHERE ebeln = wa_transit-ebeln AND ebelp = wa_transit-ebelp AND
                                       matnr = wa_transit-matnr AND werks = wa_transit-werks .

      READ TABLE it_rev INTO wa_rev WITH KEY smbln = wa_mseg-mblnr matnr = wa_mseg-matnr.
      IF sy-subrc = 4.
        wa_final-mseg_menge = wa_final-mseg_menge  + wa_mseg-menge.
        mseg_qty   = mseg_qty  + wa_mseg-menge.
      ENDIF.
    ENDLOOP.

    LOOP AT it_mseg_105 INTO wa_mseg_105 WHERE  ebeln = wa_transit-ebeln AND ebelp = wa_transit-ebelp AND
                                                matnr = wa_transit-matnr AND werks = wa_transit-werks .

      READ TABLE it_rev1 INTO wa_rev1 WITH KEY smbln = wa_mseg_105-mblnr matnr = wa_mseg_105-matnr.
      IF sy-subrc = 4.
        wa_final-mseg_menge1 = wa_final-mseg_menge1  + wa_mseg_105-menge.
        mseg_qty1 = mseg_qty1  + wa_mseg_105-menge.
      ENDIF.
    ENDLOOP.



    tran_qty = mseg_qty - mseg_qty1.
    tran_val = tran_qty * wa_transit-netpr.
    wa_final-tran_qty_v = wa_final-tran_qty_v + tran_val.

ENDLOOP.
CLEAR wa_final-tran_qty.
wa_final-tran_qty = wa_final-mseg_menge - wa_final-mseg_menge1.
    CLEAR wa_final-menge2.
    CLEAR wa_final-menge3.
    CLEAR wa_final-menge4.

    CLEAR wa_ekpo1-menge.
    CLEAR wa_ekpo_eket.



    LOOP AT it_ekpo_eket INTO wa_ekpo_eket WHERE matnr = wa_mara_mard-matnr AND werks = wa_mara_mard-werks.
      IF wa_ekpo_eket-elikz NE 'X' OR wa_ekpo_eket-wemng NE 0.

        wa_final-menge2 = wa_final-menge2 + wa_ekpo_eket-menge.
        wa_final-po_val = wa_final-po_val + wa_ekpo_eket-brtwr.

      ENDIF.

      wa_final-menge3 = wa_final-menge3 + wa_ekpo_eket-wemng.
    ENDLOOP.

    LOOP AT it_ekpo1 INTO wa_ekpo1 WHERE matnr = wa_mara_mard-matnr AND werks = wa_mara_mard-werks.

      wa_final-menge4 = wa_final-menge4 + wa_ekpo1-menge.
      wa_final-po_val1 = wa_final-po_val1 + wa_ekpo1-brtwr.

    ENDLOOP.

    CLEAR wa_final-pend_po_qty.
    wa_final-pend_po_qty = wa_final-menge2 - wa_final-menge3 - wa_final-menge4.
    wa_final-po_val2 =  wa_final-po_val - wa_final-po_val1.

    wa_final-po_value = wa_final-po_val2 - wa_final-grn_value.

    IF wa_final-pend_po_qty LT 0.
      wa_final-pend_po_qty = 0.
    ENDIF.

    IF wa_final-po_value LT 0.
      wa_final-po_value = 0.
    ENDIF.

    CLEAR wa_final-free_stock.
    wa_final-free_stock =  wa_final-labst -  wa_final-open_qty.
    IF wa_final-free_stock LT 0.
      wa_final-free_stock = 0.
    ENDIF.

    CLEAR wa_final-so_fall_qty.
    wa_final-so_fall_qty =  wa_final-open_qty - wa_final-labst - wa_final-tran_qty .
    IF wa_final-so_fall_qty LT 0.
      wa_final-so_fall_qty = 0.
    ENDIF.

    CLEAR wa_final-indent_qty.
    wa_final-indent_qty =  wa_final-open_qty - ( wa_final-labst + wa_final-pend_po_qty ).

    IF wa_final-indent_qty LT 0.
      wa_final-indent_qty = 0.
    ENDIF.


    CLEAR: lv_lines, ls_mattxt.
    REFRESH lv_lines.
    lv_name = wa_mara_mard-matnr.
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
* IMPLEMENT SUITABLE ERROR HANDLING HERE
    ENDIF.
    IF NOT lv_lines IS INITIAL.
      LOOP AT lv_lines INTO wa_lines.
        IF NOT wa_lines-tdline IS INITIAL.
          CONCATENATE wa_final-mattxt wa_lines-tdline INTO wa_final-mattxt SEPARATED BY space.
        ENDIF.
      ENDLOOP.
      CONDENSE wa_final-mattxt.
    ENDIF.

    wa_final-OPEN_QTY_V     = wa_final-OPEN_QTY    * wa_final-value.
    wa_final-KULAB_V        = wa_final-KULAB       * wa_final-value.
    wa_final-FREE_STOCK_V   = wa_final-FREE_STOCK  * wa_final-value.
*    wa_final-TRAN_QTY_V     = wa_final-TRAN_QTY    * wa_final-value.
    wa_final-SO_FALL_QTY_V  = wa_final-SO_FALL_QTY * wa_final-value.
    wa_final-PEND_PO_QTY_V  = wa_final-PEND_PO_QTY * wa_final-value.
    wa_final-INDENT_QTY_V   = wa_final-INDENT_QTY  * wa_final-value.
    wa_final-OPEN_INV_V     = wa_final-OPEN_INV    * wa_final-value.
    wa_final-UN_QTY  = wa_final-UN_QTY + wa_final-KULAB.
*    wa_final-UN_VAL  = wa_final-UN_VAL + wa_final-KULAB_V.





    APPEND wa_final TO it_final.
    CLEAR : wa_final,ls_final,wa_data.
  ENDLOOP.

  IF p_down = 'X'.
    LOOP AT it_final INTO wa_final.
      ls_final-matnr       = wa_final-matnr  .
      ls_final-mattxt      = wa_final-mattxt.
      ls_final-wrkst       = wa_final-wrkst  .
      ls_final-brand       = wa_final-brand  .
      ls_final-zseries     = wa_final-zseries.
      ls_final-zsize       = wa_final-zsize  .
      ls_final-moc         = wa_final-moc    .
      ls_final-type        = wa_final-type   .
      ls_final-open_qty    = wa_final-open_qty.
      ls_final-price       = wa_final-price     .
      ls_final-OPEN_QTY_V  = wa_final-OPEN_QTY_V     .
      ls_final-labst       = wa_final-labst.
      ls_final-LABST_V     = wa_final-LABST_V        .
      ls_final-kulab       = wa_final-kulab.
      ls_final-KULAB_V     = wa_final-KULAB_V        .
      ls_final-free_stock  = wa_final-free_stock.
      ls_final-FREE_STOCK_V  = wa_final-FREE_STOCK_V   .
      ls_final-tran_qty      = wa_final-tran_qty.
      ls_final-TRAN_QTY_V    = wa_final-TRAN_QTY_V     .
      ls_final-so_fall_qty   = wa_final-so_fall_qty.
      ls_final-SO_FALL_QTY_V = wa_final-SO_FALL_QTY_V  .
      ls_final-pend_po_qty   = wa_final-pend_po_qty.
      ls_final-po_value      = wa_final-po_value  .
      ls_final-open_inv      = wa_final-open_inv.
      ls_final-amount        = wa_final-amount   .
      ls_final-value         = wa_final-value   .

      ls_final-ref = sy-datum.


    CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
      EXPORTING
        input  = ls_final-ref
      IMPORTING
        output = ls_final-ref.

    CONCATENATE ls_final-ref+0(2) ls_final-ref+2(3) ls_final-ref+5(4)
                    INTO ls_final-ref SEPARATED BY '-'.




      APPEND ls_final TO lt_final.
      CLEAR ls_final.
    ENDLOOP.
  ENDIF.
ENDFORM.

FORM fcat .

  PERFORM build_fc USING  '1' pr_count 'MATNR'                 'Material Code'             'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'MATTXT'                'Material Description'      'IT_FINAL'  '50' .
  PERFORM build_fc USING  '1' pr_count 'WRKST'                 'USA Material Code'         'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'BRAND'                 'Brand'                     'IT_FINAL'  '5'.
  PERFORM build_fc USING  '1' pr_count 'ZSERIES'               'Series'                    'IT_FINAL'  '5'.
  PERFORM build_fc USING  '1' pr_count 'ZSIZE'                 'Size'                      'IT_FINAL'  '5'.
  PERFORM build_fc USING  '1' pr_count 'MOC'                   'MOC'                       'IT_FINAL'  '5'.
  PERFORM build_fc USING  '1' pr_count 'TYPE'                  'Type'                      'IT_FINAL'  '5'.
  PERFORM build_fc USING  '1' pr_count 'OPEN_QTY'              'Pending SO '               'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'PRICE'                 'Pending So Value'          'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'UN_QTY'                'Unrestricted Quantity'     'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'UN_VAL'                'Unrestricted Value'          'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'OPEN_QTY_V'            'Pending So Sales Total'    'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'LABST'                 'Stock In Hand'             'IT_FINAL'  '15'.
  PERFORM build_fc USING  '1' pr_count 'LABST_V'               'Stock In Hand Value'       'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'KULAB'                 'Consignment Stock'         'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'KULAB_V'               'Consignment Stock Value'   'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'FREE_STOCK'            'Free Stock'                'IT_FINAL'  '15'.
  PERFORM build_fc USING  '1' pr_count 'FREE_STOCK_V'          'Free Stock Value'          'IT_FINAL'  '15'.
  PERFORM build_fc USING  '1' pr_count 'TRAN_QTY'              'Transit Qty'               'IT_FINAL'  '15'.
  PERFORM build_fc USING  '1' pr_count 'TRAN_QTY_V'            'Transit Value'             'IT_FINAL'  '15'.
  PERFORM build_fc USING  '1' pr_count 'SO_FALL_QTY'           'SO Short Fall Qty'         'IT_FINAL'  '20'.
*  PERFORM build_fc USING  '1' pr_count 'SO_FALL_QTY_V'         'SO Short Fall Qty Value'   'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'PEND_PO_QTY'           'Pending PO Qty'            'IT_FINAL'  '20'.
*  PERFORM build_fc USING  '1' pr_count 'PO_VALUE'              'Pending PO Amount'         'IT_FINAL'  '20'.
*  PERFORM build_fc USING  '1' pr_count 'INDENT_QTY'            'Indent Qty'                'IT_FINAL'  '20'.
*  PERFORM build_fc USING  '1' pr_count 'INDENT_QTY_V'          'Indent Qty Value'          'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'OPEN_INV'              'Open Invoice Qty'          'IT_FINAL'  '20'.
*  PERFORM build_fc USING  '1' pr_count 'OPEN_INV_V'            'Open Invoice Qty Value'    'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'AMOUNT'                'Last Item Price'           'IT_FINAL'  '20'.
  PERFORM build_fc USING  '1' pr_count 'VALUE'                 'Moving Price'              'IT_FINAL'  '20'.


ENDFORM.

FORM display_data.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program     = sy-repid
      i_callback_top_of_page = 'TOP-OF-PAGE'
      it_fieldcat            = gt_fieldcat
      i_save                 = 'X'
    TABLES
      t_outtab               = it_final
*   EXCEPTIONS
*     PROGRAM_ERROR          = 1
*     OTHERS                 = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
  IF p_down = 'X'.

    PERFORM download.
*    PERFORM gui_download.
  ENDIF.
ENDFORM.

FORM build_fc  USING        pr_row TYPE i
                            pr_count TYPE i
                            pr_fname TYPE string
                            pr_title TYPE string
                            pr_table TYPE slis_tabname
                            pr_length TYPE string.

  pr_count = pr_count + 1.
  gs_fieldcat-row_pos   = pr_row.
  gs_fieldcat-col_pos   = pr_count.
  gs_fieldcat-fieldname = pr_fname.
  gs_fieldcat-seltext_l = pr_title.
  gs_fieldcat-tabname   = pr_table.
  gs_fieldcat-outputlen = pr_length.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR gs_fieldcat.

ENDFORM.

FORM top-of-page.

*  ALV Header declarations
  DATA: t_header      TYPE slis_t_listheader,
        wa_header     TYPE slis_listheader,
        t_line        LIKE wa_header-info,
        ld_lines      TYPE i,
        ld_linesc(10) TYPE c.

*  Title
  wa_header-typ  = 'H'.
  wa_header-info = 'Stock Bank Report '.
  APPEND wa_header TO t_header.
  CLEAR wa_header.



*  Date
*  wa_header-typ  = 'S'.
*  wa_header-key  = 'Run Date : '.
*  CONCATENATE wa_header-info sy-datum+6(2) '.' sy-datum+4(2) '.'
*                      sy-datum(4) INTO wa_header-info.
*  APPEND wa_header TO t_header.
*  CLEAR: wa_header.
*
**  Time
*  wa_header-typ  = 'S'.
*  wa_header-key  = 'Run Time: '.
*  CONCATENATE wa_header-info sy-timlo(2) ':' sy-timlo+2(2) ':'
*                      sy-timlo+4(2) INTO wa_header-info.
*  APPEND wa_header TO t_header.
*  CLEAR: wa_header.

*   Total No. of Records Selected
  DESCRIBE TABLE it_final LINES ld_lines.
  ld_linesc = ld_lines.

  CONCATENATE 'Total No. of Records Selected: ' ld_linesc
     INTO t_line SEPARATED BY space.

  wa_header-typ  = 'A'.
  wa_header-info = t_line.
  APPEND wa_header TO t_header.
  CLEAR: wa_header, t_line.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = t_header.
ENDFORM.                    " top-of-page



*****************************************Download logic***************************************************

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

  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = lt_final
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

*  IF plant = 'US01'.
  lv_file = 'ZUS_STOCK_BANK_US01.TXT'.
*  ENDIF.

  CONCATENATE p_folder '\' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'Material Stock Bank Report started on', sy-datum, 'at', sy-uzeit.
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


**********************************SQL UPLOAD FILE*************************************

  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = lt_final
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

*  IF plant = 'US01'.
  lv_file = 'ZUS_STOCK_BANK_US01.TXT'.
*  ENDIF.

  CONCATENATE p_folder '\' lv_file
    INTO lv_fullfile.

  WRITE: / 'Material Stock Bank Report started on', sy-datum, 'at', sy-uzeit.
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
  CONCATENATE 'Material Code'
              'Material Description'
              'USA Material Code'
              'Brand'
              'Series'
              'Size'
              'MOC'
              'Type'
              'Pending SO'
              'Pending So Value'
              'Pending So Purchase Cost'
              'Stock In Hand'
              'Stock In Hand Value'
              'Consignment Stock'
              'Consignment Stock Value'
              'Free Stock'
              'Free Stock Value'
              'Transit Qty'
              'Transit Value'
              'SO Short Fall Qty'
              'SO Short Fall Qty Value'
              'Pending PO Qty'
              'Pending PO Amount'
              'Open Invoice Qty'
              'Last Item Price'
              'Moving Price'
              'Refresh File Date'

               INTO pd_csv
               SEPARATED BY l_field_seperator.

ENDFORM.


**********************************************************************************************************

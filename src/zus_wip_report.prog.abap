*&---------------------------------------------------------------------*
*& Report ZUS_WIP_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zus_wip_report.

TABLES:afpo.

TYPES: BEGIN OF ty_aufk,
         aufnr TYPE aufk-aufnr,
         auart TYPE aufk-auart,
         autyp TYPE aufk-autyp,
         refnr TYPE aufk-refnr,
         erdat TYPE aufk-erdat,
         bukrs TYPE aufk-bukrs,
         werks TYPE aufk-werks,
         kdauf TYPE aufk-kdauf,
         kdpos TYPE aufk-kdpos,
         ernam TYPE aufk-ernam, "added by jyoti on 29.04.2024
         aenam TYPE aufk-aenam, "ADDED by jyoti on21.06.2024    " add by supriya on 21.06.2024
         aedat TYPE aufk-aedat, "ADDED by jyoti on21.06.2024    " add by supriya on 21.06.2024
         csono TYPE char40,      "added by supriya on 26.06.2024
       END OF ty_aufk,

       BEGIN OF ty_resb,
         rsnum TYPE resb-rsnum,
         rspos TYPE resb-rspos,
         rsart TYPE resb-rsart,
         bdart TYPE resb-bdart,
         matnr TYPE resb-matnr,
         werks TYPE resb-werks,
         lgort TYPE resb-lgort,
         sobkz TYPE resb-sobkz,
         bdmng TYPE resb-bdmng,
         enmng TYPE resb-enmng,
         aufnr TYPE resb-aufnr,
         baugr TYPE resb-baugr,
         afpos TYPE resb-afpos,
         csono TYPE char40,      "added by supriya on 26.06.2024
       END OF ty_resb,

       BEGIN OF ty_mara,
         matnr   TYPE mara-matnr,
         wrkst   TYPE mara-wrkst,
         zseries TYPE mara-zseries,
         zsize   TYPE mara-zsize,
         brand   TYPE mara-brand,
         moc     TYPE mara-moc,
         type    TYPE mara-type,
         mtart   TYPE mara-mtart, "ADDED BY JYOTI O 29.04.2024
       END OF ty_mara,


       BEGIN OF ty_makt,
         matnr TYPE makt-matnr,
         maktx TYPE makt-maktx,
       END OF ty_makt,

       BEGIN OF ty_mard,
         matnr TYPE mard-matnr,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
         labst TYPE mard-labst,
       END OF ty_mard,

       BEGIN OF ty_mbew,
         matnr TYPE mbew-matnr,
         bwkey TYPE mbew-bwkey,
         vprsv TYPE mbew-vprsv,
         verpr TYPE mbew-verpr,
         stprs TYPE mbew-stprs,
         bklas TYPE mbew-bklas,

       END OF ty_mbew,

       BEGIN OF ty_afko,
         aufnr TYPE afko-aufnr,
         gamng TYPE afko-gamng,
         igmng TYPE afko-igmng,
       END OF ty_afko,

       BEGIN OF ty_afpo,
         aufnr TYPE afpo-aufnr,
         posnr TYPE afpo-posnr,
         kdauf TYPE afpo-kdauf,
         kdpos TYPE afpo-kdpos,
         matnr TYPE afpo-matnr,
         dwerk TYPE afpo-dwerk,
         dauat TYPE afpo-dauat,
         objnr TYPE jest-objnr,
       END OF ty_afpo,

       BEGIN OF ty_vbak,
         vbeln TYPE vbak-vbeln,
         kunnr TYPE vbak-kunnr,
       END OF ty_vbak,

       BEGIN OF ty_kna1,
         kunnr TYPE kna1-kunnr,
         name1 TYPE kna1-name1,
       END OF ty_kna1,

       BEGIN OF ty_mseg,
         mblnr TYPE mseg-mblnr,
         bwart TYPE mseg-bwart,
         matnr TYPE mseg-matnr,
         menge TYPE mseg-menge,
         aufnr TYPE mseg-aufnr,
         rspos TYPE mseg-rspos,
       END OF ty_mseg,

       BEGIN OF ty_jest,
         objnr TYPE jest-objnr,
         stat  TYPE jest-stat,
         inact TYPE jest-inact,
       END OF ty_jest,



       BEGIN OF ty_final,
         erdat     TYPE aufk-erdat,
         kdauf     TYPE aufk-kdauf,
         kdpos     TYPE aufk-kdpos,
         aufnr     TYPE aufk-aufnr,
         auart     TYPE aufk-auart,
         name1     TYPE kna1-name1,
         baugr     TYPE resb-baugr,
         wrkst1    TYPE mara-wrkst,
         maktx     TYPE char250,
         matnr     TYPE resb-matnr,
         wrkst     TYPE mara-wrkst,
         compo     TYPE char250,
         bdmng     TYPE resb-bdmng,
         enmng     TYPE resb-enmng,
         short_qty TYPE mard-labst,
         gamng     TYPE afko-gamng,
         igmng     TYPE afko-igmng,
         wip_qty   TYPE mard-labst,
         bklas     TYPE mbew-bklas,
         vprsv     TYPE mbew-vprsv,
         stprs     TYPE mbew-stprs,
         verpr     TYPE mbew-verpr,
         price     TYPE mbew-stprs,
         zseries   TYPE mara-zseries,
         zsize     TYPE mara-zsize,
         brand     TYPE mara-brand,
         moc       TYPE mara-moc,
         type      TYPE mara-type,
*         ref_date  TYPE sy-datum,
         dwerk     TYPE afpo-dwerk,
*         un_stock  TYPE mard-labst,
         ernam     TYPE aufk-ernam, "ADDED BY JYOTI ON 29.04.2024
         mtart     TYPE mara-mtart, "ADDED BY JYOTI ON 29.04.2024
         status    TYPE char255, "ADDED BY JYOTI ON 29.04.2024
         ref_date  TYPE char11, "sy-datum,"ADDED BY JYOTI ON 29.04.2024
         ref_time  TYPE char15, "ADDED BY JYOTI ON 29.04.2024
         aenam     TYPE aufk-aenam , " ADDED BY SUPRIYA ON 21.06.2024
         aedat     TYPE  AUFK-aedat,"char11, " ADDED BY SUPRIYA ON 21.06.2024
         csono TYPE char40,      "added by supriya on 26.06.2024
*         PO_LONGTEXT TYPE CHAR250,"ADDED BY JYOTI ON 15.11.2024
       END OF ty_final,

            BEGIN OF ty_final_new,
         erdat     TYPE char11,
         kdauf     TYPE aufk-kdauf,
         kdpos     TYPE aufk-kdpos,
         aufnr     TYPE aufk-aufnr,
         auart     TYPE aufk-auart,
         name1     TYPE kna1-name1,
         baugr     TYPE resb-baugr,
         wrkst1    TYPE mara-wrkst,
         maktx     TYPE char250,
         matnr     TYPE resb-matnr,
         wrkst     TYPE mara-wrkst,
         compo     TYPE char250,
         bdmng     TYPE resb-bdmng,
         enmng     TYPE resb-enmng,
         short_qty TYPE mard-labst,
         gamng     TYPE afko-gamng,
         igmng     TYPE afko-igmng,
         wip_qty   TYPE mard-labst,
         bklas     TYPE mbew-bklas,
         vprsv     TYPE mbew-vprsv,
         stprs     TYPE mbew-stprs,
         verpr     TYPE mbew-verpr,
         price     TYPE mbew-stprs,
         zseries   TYPE mara-zseries,
         zsize     TYPE mara-zsize,
         brand     TYPE mara-brand,
         moc       TYPE mara-moc,
         type      TYPE mara-type,
*         ref_date  TYPE sy-datum,
         dwerk     TYPE afpo-dwerk,
*         un_stock  TYPE mard-labst,
         ernam     TYPE aufk-ernam, "ADDED BY JYOTI ON 29.04.2024
         mtart     TYPE mara-mtart, "ADDED BY JYOTI ON 29.04.2024
         status    TYPE char255, "ADDED BY JYOTI ON 29.04.2024
         ref_date  TYPE char11, "sy-datum,"ADDED BY JYOTI ON 29.04.2024
         ref_time  TYPE char15, "ADDED BY JYOTI ON 29.04.2024
         aenam     TYPE aufk-aenam , " ADDED BY SUPRIYA ON 21.06.2024
         aedat     TYPE  char11,"char11, " ADDED BY SUPRIYA ON 21.06.2024
         csono TYPE char40,      "added by supriya on 26.06.2024
*         PO_LONGTEXT TYPE CHAR250,"ADDED BY JYOTI ON 15.11.2024
       END OF ty_final_new,


       BEGIN OF ty_str,
         erdat     TYPE char11,
         kdauf     TYPE char15,
         kdpos     TYPE char15,
         aufnr     TYPE char15,
         auart     TYPE char15,
         name1     TYPE char50,
         baugr     TYPE char20,
         wrkst1    TYPE char50,
         maktx     TYPE char250,
         matnr     TYPE char20,
         wrkst     TYPE char50,
         compo     TYPE char250,
         bdmng     TYPE char20,
         enmng     TYPE char20,
         short_qty TYPE char20,
         gamng     TYPE char20,
         igmng     TYPE char20,
         wip_qty   TYPE char20,
         bklas     TYPE mbew-bklas,
         vprsv     TYPE mbew-vprsv,
         stprs     TYPE char20,
         verpr     TYPE char20,
         price     TYPE char20,
         zseries   TYPE mara-zseries,
         zsize     TYPE mara-zsize,
         brand     TYPE mara-brand,
         moc       TYPE mara-moc,
         type      TYPE mara-type,
         dwerk     TYPE afpo-dwerk,
*         un_stock  TYPE mard-labst,
         ernam     TYPE char40, "ADDED BY JYOTI ON 29.04.2024
         mtart     TYPE mara-mtart, "ADDED BY JYOTI ON 29.04.2024
         status    TYPE char255,      "ADDED BY JYOTI ON 29.04.2024
         ref_date  TYPE char11,      "ADDED BY JYOTI ON 29.04.2024
         ref_time  TYPE char15,      "ADDED BY JYOTI ON 29.04.2024
         aenam     TYPE aufk-aenam , " ADDED BY SUPRIYA ON 21.06.2024
         aedat     TYPE  char11, " ADDED BY SUPRIYA ON 21.06.2024
         csono TYPE char40,      "added by supriya on 26.06.2024
custsono type char20,
       END OF ty_str.


DATA: it_aufk     TYPE TABLE OF ty_aufk,
      wa_aufk     TYPE          ty_aufk,

      it_afko     TYPE TABLE OF ty_afko,
      wa_afko     TYPE          ty_afko,

      it_afpo     TYPE TABLE OF ty_afpo,
      wa_afpo     TYPE          ty_afpo,

      it_resb     TYPE TABLE OF ty_resb,
      wa_resb     TYPE          ty_resb,

      it_makt     TYPE TABLE OF ty_makt,
      wa_makt     TYPE          ty_makt,

      it_makt1    TYPE TABLE OF ty_makt,
      wa_makt1    TYPE          ty_makt,

      it_mbew     TYPE TABLE OF ty_mbew,
      wa_mbew     TYPE          ty_mbew,

      it_mard     TYPE TABLE OF ty_mard,
      wa_mard     TYPE          ty_mard,

      it_mara     TYPE TABLE OF ty_mara,
      wa_mara     TYPE          ty_mara,

      it_mara1    TYPE TABLE OF ty_mara,
      wa_mara1    TYPE          ty_mara,

      it_mseg     TYPE TABLE OF ty_mseg,
      wa_mseg     TYPE          ty_mseg,

      it_vbak     TYPE TABLE OF ty_vbak,
      wa_vbak     TYPE          ty_vbak,

      it_kna1     TYPE TABLE OF ty_kna1,
      wa_kna1     TYPE          ty_kna1,

      it_jest     TYPE TABLE OF ty_jest,
      wa_jest     TYPE          ty_jest,

      it_jest_new TYPE TABLE OF ty_jest, "added by jyoti on 30.04.2024
      wa_jest_new TYPE          ty_jest, "added by jyoti on 30.04.2024


      it_final    TYPE TABLE OF ty_final,
      wa_final    TYPE          ty_final,

      it_final_new    TYPE TABLE OF ty_final_new,
      wa_final_new    TYPE          ty_final_new,

      it_down     TYPE TABLE OF ty_str,
      wa_down     TYPE          ty_str.


DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt TYPE tline,
      ls_mattxt TYPE tline.

DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat LIKE LINE OF it_fcat.
DATA:stock    TYPE mard-labst,
     constant TYPE mard-labst,
     qty      TYPE mseg-menge.

DATA: i_sort             TYPE slis_t_sortinfo_alv, " SORT
      gt_events          TYPE slis_t_event,        " EVENTS
      i_list_top_of_page TYPE slis_t_listheader,   " TOP-OF-PAGE
      wa_layout          TYPE  slis_layout_alv..            " LAYOUT WORKAREA
DATA t_sort TYPE slis_t_sortinfo_alv WITH HEADER LINE.


SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_aufnr FOR afpo-aufnr,
                s_matnr FOR afpo-matnr,
                s_dauat FOR afpo-dauat ,
                p_dwerk FOR afpo-dwerk OBLIGATORY DEFAULT 'US01'.
*PARAMETERS: p_dwerk TYPE afpo-dwerk OBLIGATORY DEFAULT 'US01'.

SELECTION-SCREEN:END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE abc .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder TYPE rlgrap-filename DEFAULT '/Delval/USA'."USA'."USA'."USA'."usa'.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN :BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-002.
SELECTION-SCREEN  COMMENT /1(60) TEXT-003.
*                     COMMENT 1(70) TEXT-004.
SELECTION-SCREEN COMMENT /1(70) TEXT-004.
SELECTION-SCREEN: END OF BLOCK b3.



LOOP AT p_dwerk.
  IF p_dwerk-low = 'PL01'.
    p_dwerk-low = ' '.
  ENDIF.
  IF p_dwerk-high = 'PL01'.
    p_dwerk-high = ' '.
  ENDIF.
  MODIFY p_dwerk.
ENDLOOP.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM get_fcat.
  PERFORM get_display.

*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .
*BREAK primus.
  SELECT aufnr
         posnr
         kdauf
         kdpos
         matnr
         dwerk
         dauat FROM   afpo INTO TABLE it_afpo
         WHERE aufnr IN s_aufnr
           AND matnr IN s_matnr
           AND dauat IN s_dauat
           AND dwerk IN p_dwerk.

  LOOP AT it_afpo INTO wa_afpo.
    CONCATENATE 'OR' wa_afpo-aufnr INTO wa_afpo-objnr.
    MODIFY it_afpo FROM wa_afpo TRANSPORTING objnr.
  ENDLOOP.

  DELETE it_afpo WHERE dwerk = 'PL01'.
  IF it_afpo IS NOT INITIAL.

    SELECT objnr
           stat
           inact FROM jest INTO TABLE it_jest
           FOR ALL ENTRIES IN it_afpo
           WHERE objnr = it_afpo-objnr
             AND stat IN ( 'I0045', 'I0076' ) "I0076 IS ADDED BY JYOTI ON21.06.2024
             AND inact NE 'X'.

***********added by jyoti on 29.04.2024
    SELECT objnr
           stat
           inact FROM jest INTO TABLE it_jest_new
           FOR ALL ENTRIES IN it_afpo
           WHERE objnr = it_afpo-objnr
*             AND stat = 'I0045'
             AND inact NE 'X'.
    SELECT * FROM tj02t
      INTO TABLE @DATA(it_tj02)
      FOR ALL ENTRIES IN @it_jest_new
      WHERE istat = @it_jest_new-stat
      AND spras = 'E'.
**************************************************************

    SELECT aufnr
           gamng
           igmng FROM afko INTO TABLE it_afko
           FOR ALL ENTRIES IN it_afpo
           WHERE aufnr = it_afpo-aufnr.

    SELECT aufnr
           auart
           autyp
           refnr
           erdat
           bukrs
           werks
           kdauf
           kdpos
           ernam
           aenam   " ADDED BY SUPRIYA ON 21.06.2024
           aedat   " ADDED BY SUPRIYA ON 21.06.2024

       FROM aufk INTO TABLE it_aufk
           FOR ALL ENTRIES IN it_afpo
           WHERE aufnr = it_afpo-aufnr
             AND werks = it_afpo-dwerk.


    SELECT rsnum
           rspos
           rsart
           bdart
           matnr
           werks
           lgort
           sobkz
           bdmng
           enmng
           aufnr
           baugr
           afpos FROM resb INTO TABLE it_resb
           FOR ALL ENTRIES IN it_afpo
           WHERE aufnr = it_afpo-aufnr
*           AND AFPOS = IT_AFPO-POSNR
             AND werks = it_afpo-dwerk.

  ENDIF.

  IF it_resb IS NOT INITIAL.

    SELECT mblnr
           bwart
           matnr
           menge
           aufnr
           rspos FROM mseg INTO TABLE it_mseg
           FOR ALL ENTRIES IN it_resb
           WHERE aufnr = it_resb-aufnr
            AND matnr = it_resb-matnr
            AND  bwart IN ( '532', '262' ).



  ENDIF.


  IF it_aufk IS NOT INITIAL.
    SELECT vbeln
           kunnr FROM vbak INTO TABLE it_vbak
           FOR ALL ENTRIES IN it_aufk
           WHERE vbeln = it_aufk-kdauf.


  ENDIF.

  IF it_vbak IS NOT INITIAL.
    SELECT kunnr
           name1 FROM kna1 INTO TABLE it_kna1
           FOR ALL ENTRIES IN it_vbak
           WHERE kunnr = it_vbak-kunnr.

  ENDIF.

  IF it_resb IS NOT INITIAL.

    SELECT matnr
           werks
           lgort
           labst FROM mard INTO TABLE it_mard
           FOR ALL ENTRIES IN it_resb
           WHERE matnr = it_resb-matnr
             AND werks = it_resb-werks
             AND  lgort NE 'RJ' AND lgort NE'SCR' AND lgort NE'SLR'.

    SELECT matnr
           bwkey
           vprsv
           verpr
           stprs
           bklas FROM mbew INTO TABLE it_mbew
           FOR ALL ENTRIES IN it_resb
           WHERE matnr = it_resb-matnr
             AND bwkey = it_resb-werks.

    SELECT matnr
           wrkst
           zseries
           zsize
           brand
           moc
           type
           mtart FROM mara INTO TABLE it_mara
           FOR ALL ENTRIES IN it_resb
           WHERE matnr = it_resb-baugr.

    SELECT matnr
           wrkst
           zseries
           zsize
           brand
           moc
           type
           mtart FROM mara INTO TABLE it_mara1
           FOR ALL ENTRIES IN it_resb
           WHERE matnr = it_resb-matnr.


    SELECT matnr
           maktx FROM makt INTO TABLE it_makt
           FOR ALL ENTRIES IN it_resb
           WHERE matnr = it_resb-baugr.

    SELECT matnr
           maktx FROM makt INTO TABLE it_makt1
           FOR ALL ENTRIES IN it_resb
           WHERE matnr = it_resb-matnr.

  ENDIF.




  LOOP AT it_resb INTO wa_resb.
    READ TABLE it_afpo INTO wa_afpo WITH KEY  aufnr = wa_resb-aufnr .
    IF sy-subrc = 0.
      wa_final-dwerk = wa_afpo-dwerk.
    ENDIF.

***********************ADDED BY JYOTI ON 03.05.2024***********************8
    DATA objnr             TYPE jest-objnr.
    DATA line              TYPE bsvx-sttxt.

    objnr = wa_afpo-objnr.

    CALL FUNCTION 'STATUS_TEXT_EDIT'
      EXPORTING
        client           = sy-mandt
*       FLG_USER_STAT    = ' '
        objnr            = objnr
*       ONLY_ACTIVE      = 'X'
        spras            = 'E'
*       BYPASS_BUFFER    = ' '
      IMPORTING
*       ANW_STAT_EXISTING       = ANW_STAT_EXISTING
*       E_STSMA          = E_STSMA
        line             = line
*       USER_LINE        = USER_LINE
*       STONR            = STONR
      EXCEPTIONS
        object_not_found = 1
        OTHERS           = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    wa_final-status = line.
*****************************************************************************8

*    READ TABLE it_jest_new INTO wa_jest_new WITH KEY objnr = wa_afpo-objnr.
*   loop at it_jest_new INTO wa_jest_new WHERE objnr = wa_afpo-objnr.
*    LOOP AT it_tj02 INTO DATA(wa_tj02) WHERE istat = wa_jest_new-stat.
**    wa_final-stat = wa_jest_new-stat."added by jyoti on 29.04.2024
*      IF wa_tj02-txt04 = 'TECO'.
*        DATA(gv_teco) =  wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'REL'.
*        DATA(gv_rel) =  wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'PRT'.
*        DATA(gv_prt) =  wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'PCNF'.
*        DATA(gv_pcnf) = wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'DLV'.
*        DATA(gv_dlv) = wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'PRC'.
*        DATA(gv_prc) = wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'GMPS'.
*        DATA(gv_gmps) = wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'MACM'.
*        DATA(gv_macm) = wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'CRTD'.
*        DATA(gv_crtd) = wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'MSPT'.
*        DATA(gv_mspt) = wa_tj02-txt04.
**      ELSEIF wa_jest_new-txt04 = 'PRC'.
**         dATA(GV_TECO) =  wa_jest_new-TXT30.
*      ELSEIF wa_tj02-txt04 = 'CSER'.
*        DATA(gv_cser) = wa_tj02-txt04.
*      ELSEIF wa_tj02-txt04 = 'SETC'.
*        DATA(gv_setc) = wa_tj02-txt04.
*      ENDIF.
*
*
*
*    ENDLOOP.
*    ENDLOOP.
*    CONCATENATE gv_teco gv_rel gv_prt gv_pcnf gv_dlv gv_prc gv_gmps
*    gv_macm gv_crtd gv_mspt gv_cser gv_setc INTO wa_final-status
*    SEPARATED BY space.
    READ TABLE it_jest INTO wa_jest WITH KEY objnr = wa_afpo-objnr.

    IF sy-subrc = 4.
      wa_final-baugr = wa_resb-baugr.
      wa_final-matnr = wa_resb-matnr.
      wa_final-bdmng = wa_resb-bdmng.
      wa_final-enmng = wa_resb-enmng.



      READ TABLE it_afko INTO wa_afko WITH KEY aufnr = wa_afpo-aufnr.
      IF sy-subrc = 0.
        wa_final-gamng = wa_afko-gamng.
        wa_final-igmng = wa_afko-igmng.

      ENDIF.

      READ TABLE it_aufk INTO wa_aufk WITH KEY  aufnr = wa_afpo-aufnr.
      IF sy-subrc = 0.
        wa_final-aufnr = wa_aufk-aufnr.
        wa_final-auart = wa_aufk-auart.
        wa_final-erdat = wa_aufk-erdat.
        wa_final-kdauf = wa_aufk-kdauf.
        wa_final-kdpos = wa_aufk-kdpos.
        wa_final-ernam = wa_aufk-ernam.     "added by jyoti on 29.04.2024
        wa_final-aenam = wa_aufk-aenam.     " added by supriya jagtap 21.06.2024
        wa_final-aedat = wa_aufk-aedat.     " added by supriya jagtap 21.06.2024
      ENDIF.

      READ TABLE it_vbak INTO wa_vbak WITH KEY vbeln = wa_aufk-kdauf.
      IF sy-subrc = 0.
        READ TABLE it_kna1 INTO wa_kna1 WITH KEY kunnr = wa_vbak-kunnr.
        IF sy-subrc = 0.
          wa_final-name1 = wa_kna1-name1.

        ENDIF.
      ENDIF.

      READ TABLE it_mara INTO wa_mara WITH KEY matnr = wa_resb-baugr.
      IF sy-subrc = 0.
        wa_final-wrkst1 = wa_mara-wrkst.
        wa_final-zseries = wa_mara-zseries.
        wa_final-zsize   = wa_mara-zsize  .
        wa_final-brand   = wa_mara-brand  .
        wa_final-moc     = wa_mara-moc    .
        wa_final-type    = wa_mara-type   .
        wa_final-mtart    = wa_mara-mtart   ."added by jyoti on 29.04.2024


      ENDIF.

      READ TABLE it_mara1 INTO wa_mara1 WITH KEY matnr = wa_resb-matnr.
      IF sy-subrc = 0.
        wa_final-wrkst = wa_mara1-wrkst.

      ENDIF.

      LOOP AT it_mseg INTO wa_mseg WHERE aufnr = wa_resb-aufnr  AND matnr = wa_resb-matnr.
        qty = qty + wa_mseg-menge.
      ENDLOOP.


* READ TABLE IT_MAKT INTO WA_MAKT WITH KEY MATNR = WA_RESB-BAUGR.
*  IF SY-SUBRC = 0.
*    WA_FINAL-MAKTX = WA_MAKT-MAKTX.
*
*  ENDIF.


      CLEAR: lv_lines, ls_mattxt.
      REFRESH lv_lines.
      lv_name = wa_resb-baugr.
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
      IF NOT lv_lines IS INITIAL.
        LOOP AT lv_lines INTO wa_lines.
          IF NOT wa_lines-tdline IS INITIAL.
            CONCATENATE wa_final-maktx wa_lines-tdline INTO wa_final-maktx SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        CONDENSE wa_final-maktx.
      ENDIF.

*      lv_name = wa_resb-aufnr.
**********************************************************************************************
*
* READ TABLE IT_MAKT1 INTO WA_MAKT1 WITH KEY MATNR = WA_RESB-MATNR.
*  IF SY-SUBRC = 0.
*    WA_FINAL-COMPO = WA_MAKT1-MAKTX.
*
*  ENDIF.

      CLEAR: lv_lines, ls_mattxt.
      REFRESH lv_lines.
      lv_name = wa_resb-matnr.
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
      IF NOT lv_lines IS INITIAL.
        LOOP AT lv_lines INTO wa_lines.
          IF NOT wa_lines-tdline IS INITIAL.
            CONCATENATE wa_final-compo wa_lines-tdline INTO wa_final-compo SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        CONDENSE wa_final-compo.
      ENDIF.

*      wa_final-ref_date = sy-datum.

*
* LOOP AT IT_MARD INTO WA_MARD WHERE MATNR = WA_RESB-MATNR.
*
*  WA_FINAL-UN_STOCK = WA_FINAL-UN_STOCK + WA_MARD-LABST.
*
* ENDLOOP.
****************************************************************************************
 CLEAR: lv_lines, ls_mattxt.          " Added by supriya on 26.06.2024
      REFRESH lv_lines.
      CONCATENATE SY-MANDT wa_final-aufnr INTO LV_NAME.
*      lv_name = wa_final-aufnr.
*break primusabap.
      CALL FUNCTION 'READ_TEXT'
        EXPORTING
          client                  = sy-mandt
          id                      = 'KOPF'
          language                = sy-langu
          name                    = lv_name
          object                  = 'AUFK'
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

*    READ TABLE lv_lines INTO wa_lines INDEX 1.            "added by supriya 26.06.2024
*    IF wa_lines IS NOT INITIAL.
*      wa_final-aufnr = wa_lines-tdline.
*    ENDIF.


      IF NOT lv_lines IS INITIAL.                  "added by supriya 26.06.2024
        LOOP AT lv_lines INTO wa_lines.
          IF NOT wa_lines-tdline IS INITIAL.
            CONCATENATE wa_final-CSONO wa_lines-tdline INTO wa_final-CSONO SEPARATED BY space.
          ENDIF.
        ENDLOOP.
        CONDENSE wa_final-CSONO.
      ENDIF.

***************************************************************************************
**************************** Logic pending issue QTY ************************************
      wa_final-enmng = wa_final-enmng - qty.
      wa_final-short_qty = wa_final-bdmng - wa_final-enmng.



      IF wa_final-short_qty < 0.
        wa_final-short_qty = 0.
      ENDIF.
************************************************************************************

**************************** Logic for WIP QTY **************************************
      constant = wa_final-bdmng / wa_final-gamng.
      wa_final-wip_qty = wa_final-enmng - ( constant * wa_final-igmng ).

*************************************************************************************

      READ TABLE it_mbew INTO wa_mbew WITH KEY matnr = wa_resb-matnr.
      IF sy-subrc = 0.
        wa_final-stprs = wa_mbew-stprs.
        wa_final-verpr = wa_mbew-verpr.
        wa_final-bklas = wa_mbew-bklas.
        wa_final-vprsv = wa_mbew-vprsv.
      ENDIF.

      IF wa_mbew-vprsv = 'V'.
        wa_final-price = wa_mbew-verpr * wa_final-wip_qty.
      ELSE.
        wa_final-price = wa_mbew-stprs * wa_final-wip_qty.
      ENDIF.

      IF wa_final-gamng NE wa_final-igmng ."AND WA_FINAL-ENMNG NE 0 AND WA_FINAL-WIP_QTY NE 0.

*        IF wa_final-erdat IS NOT INITIAL.
*          CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*            EXPORTING
*              input  = wa_final-erdat
*            IMPORTING
*              output = wa_final-erdat.
*
*          CONCATENATE wa_final-erdat+0(2) wa_final-erdat+2(3) wa_final-erdat+5(4)
*                          INTO wa_final-erdat SEPARATED BY '-'.
*
*        ENDIF.




        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            input  = sy-datum
          IMPORTING
            output = wa_final-ref_date.

        CONCATENATE  wa_final-ref_date+0(2)  wa_final-ref_date+2(3)  wa_final-ref_date+5(4)
                        INTO  wa_final-ref_date SEPARATED BY '-'.


        wa_final-ref_time = sy-uzeit. "added by jyoti on 29.04.2024
        CONCATENATE wa_final-ref_time+0(2) ':' wa_final-ref_time+2(2)  INTO wa_final-ref_time.

* **********************************added by jyoti on 24.06.2024
        if wa_final-aedat = '00000000'.

           CLEAR :  wa_final-aedat.
        endif.
*         IF wa_final-aedat IS NOT INITIAL.
*          CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*            EXPORTING
*              input  = wa_final-aedat
*            IMPORTING
*              output = wa_final-aedat.
*
*          CONCATENATE wa_final-aedat+0(2) wa_final-aedat+2(3) wa_final-aedat+5(4)
*                          INTO wa_final-aedat SEPARATED BY '-'.
*
*
*        ENDIF.
********************************************************************

        APPEND wa_final TO it_final.

      ENDIF.


      CLEAR:wa_final,stock,constant,qty.
    ENDIF.
  ENDLOOP.

  IF p_down = 'X'.
    LOOP AT it_final INTO wa_final.
*wa_down-erdat     = wa_final-erdat    .
      IF wa_final-erdat IS NOT INITIAL.
        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            input  = wa_final-erdat
          IMPORTING
            output = wa_down-erdat.

        CONCATENATE wa_down-erdat+0(2) wa_down-erdat+2(3) wa_down-erdat+5(4)
                        INTO wa_down-erdat SEPARATED BY '-'.

      ENDIF.


*      wa_down-erdat      = wa_final-erdat.

      wa_down-kdauf     = wa_final-kdauf    .
      wa_down-dwerk     = wa_final-dwerk    .
      wa_down-kdpos     = wa_final-kdpos    .
      wa_down-aufnr     = wa_final-aufnr    .
      wa_down-auart     = wa_final-auart    .
      wa_down-name1     = wa_final-name1    .
      wa_down-baugr     = wa_final-baugr    .
      wa_down-wrkst1    = wa_final-wrkst1   .
      wa_down-maktx     = wa_final-maktx    .
      wa_down-matnr     = wa_final-matnr    .
      wa_down-wrkst     = wa_final-wrkst    .
      wa_down-compo     = wa_final-compo    .
      wa_down-bdmng     = wa_final-bdmng    .
      wa_down-enmng     = wa_final-enmng    .
      wa_down-short_qty = wa_final-short_qty.
      wa_down-gamng     = wa_final-gamng    .
      wa_down-igmng     = wa_final-igmng    .
      wa_down-wip_qty   = wa_final-wip_qty  .
      wa_down-bklas     = wa_final-bklas    .
      wa_down-vprsv     = wa_final-vprsv    .
      wa_down-stprs     = wa_final-stprs    .
      wa_down-verpr     = wa_final-verpr    .
      wa_down-price     = wa_final-price    .
      wa_down-zseries   = wa_final-zseries  .
      wa_down-zsize     = wa_final-zsize    .
      wa_down-brand       = wa_final-brand     .
      wa_down-moc         = wa_final-moc       .
      wa_down-type        = wa_final-type      .
*wa_down-ref         = wa_final-ref       .
      wa_down-ernam  = wa_final-ernam.    "added by jyoti on 29.04.2024
      wa_down-mtart  = wa_final-mtart.    "added by jyoti on 29.04.2024
      wa_down-status   = wa_final-status. "added by jyoti on29.04.2024
      wa_down-ref_date = wa_final-ref_date."added by jyoti on29.04.2024
      wa_down-aenam   = wa_final-aenam.    "added by supriya:102423: on 21.06 2024
*      wa_down-aedat = wa_final-aeDAT.      "added by supriya :102423:on 21.06 2024

       IF wa_final-aedat IS NOT INITIAL.
          CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
            EXPORTING
              input  = wa_final-aedat
            IMPORTING
              output = wa_down-aedat.

          CONCATENATE wa_down-aedat+0(2) wa_down-aedat+2(3) wa_down-aedat+5(4)
                          INTO wa_down-aedat SEPARATED BY '-'.


        ENDIF.





      wa_down-csono = wa_final-csono.   "added by supriya : 102423 : on 26.06.2024
*      IF wa_final-ref_date IS NOT INITIAL.
*        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = wa_final-ref_date
*          IMPORTING
*            output = wa_down-ref_date.
*
*        CONCATENATE wa_down-ref_date+0(2) wa_down-ref_date+2(3) wa_down-ref_date+5(4)
*                        INTO wa_down-ref_date SEPARATED BY '-'.
*
*      ENDIF.
      wa_down-ref_time = sy-uzeit. "added by jyoti on 29.04.2024
      CONCATENATE wa_down-ref_time+0(2) ':' wa_down-ref_time+2(2)  INTO wa_down-ref_time.


      APPEND wa_down TO it_down.

      CLEAR wa_down.
    EnDLOOP.

     LOOP AT it_final INTO wa_final.

         IF wa_final-erdat IS NOT INITIAL.
        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
          EXPORTING
            input  = wa_final-erdat
          IMPORTING
            output = wa_final_new-erdat.

        CONCATENATE wa_final_new-erdat+0(2) wa_final_new-erdat+2(3) wa_final_new-erdat+5(4)
                        INTO wa_final_new-erdat SEPARATED BY '-'.

      ENDIF.


*      wa_down-erdat      = wa_final-erdat.

      wa_final_new-kdauf     = wa_final-kdauf    .
      wa_final_new-dwerk     = wa_final-dwerk    .
      wa_final_new-kdpos     = wa_final-kdpos    .
      wa_final_new-aufnr     = wa_final-aufnr    .
      wa_final_new-auart     = wa_final-auart    .
      wa_final_new-name1     = wa_final-name1    .
      wa_final_new-baugr     = wa_final-baugr    .
      wa_final_new-wrkst1    = wa_final-wrkst1   .
      wa_final_new-maktx     = wa_final-maktx    .
      wa_final_new-matnr     = wa_final-matnr    .
      wa_final_new-wrkst     = wa_final-wrkst    .
      wa_final_new-compo     = wa_final-compo    .
      wa_final_new-bdmng     = wa_final-bdmng    .
      wa_final_new-enmng     = wa_final-enmng    .
      wa_final_new-short_qty = wa_final-short_qty.
      wa_final_new-gamng     = wa_final-gamng    .
      wa_final_new-igmng     = wa_final-igmng    .
      wa_final_new-wip_qty   = wa_final-wip_qty  .
      wa_final_new-bklas     = wa_final-bklas    .
      wa_final_new-vprsv     = wa_final-vprsv    .
      wa_final_new-stprs     = wa_final-stprs    .
      wa_final_new-verpr     = wa_final-verpr    .
      wa_final_new-price     = wa_final-price    .
      wa_final_new-zseries   = wa_final-zseries  .
      wa_final_new-zsize     = wa_final-zsize    .
      wa_final_new-brand       = wa_final-brand     .
      wa_final_new-moc         = wa_final-moc       .
       wa_final_new-type        = wa_final-type      .
*wa_down-ref         = wa_final-ref       .
       wa_final_new-ernam  = wa_final-ernam.    "added by jyoti on 29.04.2024
       wa_final_new-mtart  = wa_final-mtart.    "added by jyoti on 29.04.2024
       wa_final_new-status   = wa_final-status. "added by jyoti on29.04.2024
       wa_final_new-ref_date = wa_final-ref_date."added by jyoti on29.04.2024
       wa_final_new-aenam   = wa_final-aenam.    "added by supriya:102423: on 21.06 2024
*      wa_down-aedat = wa_final-aeDAT.      "added by supriya :102423:on 21.06 2024

       IF wa_final-aedat IS NOT INITIAL.
          CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
            EXPORTING
              input  = wa_final-aedat
            IMPORTING
              output =  wa_final_new-aedat.

          CONCATENATE  wa_final_new-aedat+0(2)  wa_final_new-aedat+2(3)  wa_final_new-aedat+5(4)
                          INTO  wa_final_new-aedat SEPARATED BY '-'.


        ENDIF.





       wa_final_new-csono = wa_final-csono.   "added by supriya : 102423 : on 26.06.2024
*      IF wa_final-ref_date IS NOT INITIAL.
*        CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*          EXPORTING
*            input  = wa_final-ref_date
*          IMPORTING
*            output = wa_down-ref_date.
*
*        CONCATENATE wa_down-ref_date+0(2) wa_down-ref_date+2(3) wa_down-ref_date+5(4)
*                        INTO wa_down-ref_date SEPARATED BY '-'.
*
*      ENDIF.
       wa_final_new-ref_time = sy-uzeit. "added by jyoti on 29.04.2024
      CONCATENATE  wa_final_new-ref_time+0(2) ':'  wa_final_new-ref_time+2(2)  INTO  wa_final_new-ref_time.

         APPEND wa_final_new TO it_final_new.

      CLEAR wa_final_new.
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
FORM get_fcat .
  PERFORM fcat USING : '1'  'ERDAT '          'IT_FINAL'  'Production Order Creation Date'           '18' ,
                       '2'  'KDAUF '          'IT_FINAL'  'Sales Order Number'                       '18' ,
                       '3'  'KDPOS '          'IT_FINAL'  'Item Number'                              '18' ,
                       '4'  'AUFNR '          'IT_FINAL'  'Production Order Number'                  '18' ,
                       '5'  'AUART '          'IT_FINAL'  'Order Type'                               '18' ,
                       '6'  'NAME1 '          'IT_FINAL'  'Customer Name'                            '18' ,
                       '7'  'BAUGR '          'IT_FINAL'  'Material'                                 '18' ,
                       '8'  'WRKST1'          'IT_FINAL'  'USA Code'                                 '18' ,
                       '9'  'MAKTX '          'IT_FINAL'  'Material Desc.'                           '18' ,
                      '10'  'MATNR '          'IT_FINAL'  'Component'                                '18' ,
                      '11'  'WRKST '          'IT_FINAL'  'USA Code'                                 '18' ,
                      '12'  'COMPO '          'IT_FINAL'  'Component Description'                    '18' ,
                      '13'  'BDMNG '          'IT_FINAL'  'Reqmt Qty'                                '18' ,
                      '14'  'ENMNG '          'IT_FINAL'  'Issue Qty.'                               '18' ,
*                    '14'  'UN_STOCK '       'IT_FINAL'  'Unrestricted Stock.'           '18' ,
                      '15'  'SHORT_QTY '      'IT_FINAL'  'Pending Issue Qty.'                      ' 18' ,
                      '16'  'GAMNG '          'IT_FINAL'  'Production Order Quantity'                '18' ,
                      '17'  'IGMNG '          'IT_FINAL'  'Confirmation Qty.'                        '18' ,
                      '18'  'WIP_QTY '        'IT_FINAL'  'WIP Qty.'                                 '18' ,
                      '19'  'BKLAS '          'IT_FINAL'  'Valuation Class'                          '18' ,
                      '20'  'VPRSV '          'IT_FINAL'  'Price Indicator'                          '18' ,
                      '21'  'STPRS '          'IT_FINAL'  'Standard Price'                           '18' ,
                      '22'  'VERPR '          'IT_FINAL'  'Moving Average Price'                     '18' ,
                      '23'  'PRICE '          'IT_FINAL'  'WIP Value'                                '18' ,
                      '24'  'ZSERIES '        'IT_FINAL'  'Series'                                   '18' ,
                      '25'  'ZSIZE   '        'IT_FINAL'  'Size'                                     '18' ,
                      '26'  'BRAND   '        'IT_FINAL'  'Brand'                                    '18' ,
                      '27'  'MOC     '        'IT_FINAL'  'Moc'                                      '18' ,
                      '28'  'TYPE    '        'IT_FINAL'  'Type'                                     '18' ,
                      '29'  'DWERK    '       'IT_FINAL'  'Plant'                                   '18' ,
                      '30'  'ERNAM'           'IT_FINAL'  'Production Order created By'             '20',"added by jyoti on 29.04.2024
                      '31'  'MTART'           'IT_FINAL'  'Material Type'                           '15',"added by jyoti on 29.04.2024
                      '32'  'STATUS'          'IT_FINAL'  'Order Status'                           '55',"added by jyoti on 29.04.2024
                      '33'  'AENAM '          'IT_FINAL'  'Changd by'                              '30', " added by supriya 21.06.2024
                      '34'  'AEDAT'           'IT_FINAL'  'Changed date'                           '15', " added by supriya 21.06.2024
                      '35'  'CSONO'           'IT_FINAL'  'Customer SO NO./Name'                   '20'.  " added by supriya 26.06.2024

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0746   text
*      -->P_0747   text
*      -->P_0748   text
*      -->P_0749   text
*      -->P_0750   text
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

  APPEND wa_fcat TO it_fcat.
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
*     I_INTERFACE_CHECK      = ' '
*     I_BYPASSING_BUFFER     = ' '
*     I_BUFFER_ACTIVE        = ' '
      i_callback_program     = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
      i_callback_top_of_page = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME       =
*     I_BACKGROUND_ID        = ' '
*     I_GRID_TITLE           =
*     I_GRID_SETTINGS        =
      is_layout              = wa_layout
      it_fieldcat            = it_fcat
*     IT_EXCLUDING           =
*     IT_SPECIAL_GROUPS      =
*     IT_SORT                =
*     IT_FILTER              =
*     IS_SEL_HIDE            =
*     I_DEFAULT              = 'X'
*     I_SAVE                 = ' '
*     IS_VARIANT             =
*     IT_EVENTS              =
*     IT_EVENT_EXIT          =
*     IS_PRINT               =
*     IS_REPREP_ID           =
*     I_SCREEN_START_COLUMN  = 0
*     I_SCREEN_START_LINE    = 0
*     I_SCREEN_END_COLUMN    = 0
*     I_SCREEN_END_LINE      = 0
*     I_HTML_HEIGHT_TOP      = 0
*     I_HTML_HEIGHT_END      = 0
*     IT_ALV_GRAPHICS        =
*     IT_HYPERLINK           =
*     IT_ADD_FIELDCAT        =
*     IT_EXCEPT_QINFO        =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER =
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
  ENDIF.


ENDFORM.


FORM top-of-page.
*ALV HEADER DECLARATIONS
  DATA: lt_header     TYPE slis_t_listheader,
        ls_header     TYPE slis_listheader,
        lt_line       LIKE ls_header-info,
        ld_lines      TYPE i,
        ld_linesc(10) TYPE c.

* TITLE
  ls_header-typ  = 'H'.
  ls_header-info = 'WIP Report'.
  APPEND ls_header TO lt_header.
  CLEAR ls_header.

* DATE
  ls_header-typ  = 'S'.
  ls_header-key  = 'RUN DATE :'.
  CONCATENATE ls_header-info sy-datum+6(2) '.' sy-datum+4(2) '.' sy-datum(4) INTO ls_header-info.
  APPEND ls_header TO lt_header.
  CLEAR: ls_header.

*TIME
  ls_header-typ  = 'S'.
  ls_header-key  = 'RUN TIME :'.
  CONCATENATE ls_header-info sy-timlo(2) ':' sy-timlo+2(2) ':' sy-timlo+4(2) INTO ls_header-info.
  APPEND ls_header TO lt_header.
  CLEAR: ls_header.

* TOTAL NO. OF RECORDS SELECTED
  DESCRIBE TABLE it_final LINES ld_lines.
  ld_linesc = ld_lines.
  CONCATENATE 'TOTAL NO. OF RECORDS SELECTED: ' ld_linesc
     INTO lt_line SEPARATED BY space.


  ls_header-typ  = 'A'.
  ls_header-info = lt_line.
  APPEND ls_header TO lt_header.
  CLEAR: ls_header, lt_line.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header.
ENDFORM.                    " TOP-OF-PAGE
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

  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = it_final_new
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
  lv_file = 'ZUSWIP.TXT'.

  CONCATENATE p_folder '/' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUSWIP Download started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1343 TYPE string.
DATA lv_crlf_1343 TYPE string.
lv_crlf_1343 = cl_abap_char_utilities=>cr_lf.
lv_string_1343 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1343 lv_crlf_1343 wa_csv INTO lv_string_1343.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_1216 TO lv_fullfile.
*TRANSFER lv_string_1216 TO lv_fullfile.
TRANSFER lv_string_1343 TO lv_fullfile.
    CONCATENATE 'File' lv_fullfile 'downloaded' INTO lv_msg SEPARATED BY space.
    MESSAGE lv_msg TYPE 'S'.
  ENDIF.

*************************************************SECOND FILE ***************************************


  CALL FUNCTION 'SAP_CONVERT_TO_TXT_FORMAT'
*   EXPORTING
*     I_FIELD_SEPERATOR          =
*     I_LINE_HEADER              =
*     I_FILENAME                 =
*     I_APPL_KEEP                = ' '
    TABLES
      i_tab_sap_data       = it_down
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
  lv_file = 'ZUSWIP.TXT'.

  CONCATENATE p_folder '/' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUSWIP Download started on', sy-datum, 'at', sy-uzeit.
  OPEN DATASET lv_fullfile
    FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.  "NON-UNICODE.
  IF sy-subrc = 0.
DATA lv_string_1380 TYPE string.
DATA lv_crlf_1380 TYPE string.
lv_crlf_1380 = cl_abap_char_utilities=>cr_lf.
lv_string_1380 = hd_csv.
LOOP AT it_csv INTO wa_csv.
CONCATENATE lv_string_1380 lv_crlf_1380 wa_csv INTO lv_string_1380.
  CLEAR: wa_csv.
ENDLOOP.
*TRANSFER lv_string_1216 TO lv_fullfile.
*TRANSFER lv_string_1216 TO lv_fullfile.
TRANSFER lv_string_1380 TO lv_fullfile.
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
  CONCATENATE   'Production Order Creation Date'
                'Sales Order Number'
                'Item Number'
                'Production Order Number'
                'Order Type'
                'Customer Name'
                'Material'
                'USA Code'
                'Material Desc.'
                'Component'
                'USA Code'
                'Component Description'
                'Reqmt Qty'
                'Issue Qty.'
                'Pending Issue Qty.'
                'Production Order Quantity'
                'Confirmation Qty.'
                'WIP Qty.'
                'Valuation Class'
                'Price Indicator'
                'Standard Price'
                'Moving Average Price'
                'WIP Value'
                'Series'
                'Size'
                'Brand'
                'Moc'
                'Type'
                'Plant'
                'Production Order created By' "added by jyoti on 29.04.2024
                'Material Type'      "added by jyoti on 29.04.2024
                'Order Status' "added by jyoti on 29.04.2024
                'Refresh Date'"added by jyoti on 29.04.2024
                'Refresh Time' "added by jyoti on 29.04.2024
                'Changd by'   "added by jyoti on 24.06.2024
                'Changed date'"added by jyoti on 24.06.2024
                'Customer SO NO./Name' " added by supriya on 26.06.2024
              INTO pd_csv
              SEPARATED BY l_field_seperator.

ENDFORM.

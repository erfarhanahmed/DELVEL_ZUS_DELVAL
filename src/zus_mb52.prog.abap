*&---------------------------------------------------------------------*
*& Report ZUS_MB52
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zus_mb52.

TABLES:mard,mara.

TYPES: BEGIN OF ty_mara,
         matnr   TYPE mara-matnr,
         zseries TYPE mara-zseries,
         zsize   TYPE mara-zsize,
         brand   TYPE mara-brand,
         moc     TYPE mara-moc,
         type    TYPE mara-type,
         wrkst   TYPE mara-wrkst,


       END OF ty_mara,

       BEGIN OF ty_mara_mard,
         matnr TYPE mard-matnr,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
         lgpbe TYPE mard-lgpbe,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,
       END OF ty_mara_mard,

       BEGIN OF ty_mard,
         matnr TYPE mard-matnr,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
         labst TYPE mard-labst,
         umlme TYPE mard-umlme,
         insme TYPE mard-insme,
         einme TYPE mard-einme,
         speme TYPE mard-speme,
         retme TYPE mard-retme,
         vmlab TYPE mard-vmlab,
         vmuml TYPE mard-vmuml,
         vmins TYPE mard-vmins,
         vmein TYPE mard-vmein,
         vmspe TYPE mard-vmspe,
         vmret TYPE mard-vmret,
       END OF ty_mard,




       BEGIN OF ty_makt,
         matnr TYPE makt-matnr,
         maktx TYPE makt-maktx,
       END OF ty_makt,

       BEGIN OF ty_mbew,
         matnr TYPE mbew-matnr,
         bwkey TYPE mbew-bwkey,
         lbkum TYPE mbew-lbkum,
         salk3 TYPE mbew-salk3,
         vprsv TYPE mbew-vprsv,
         verpr TYPE mbew-verpr,
         stprs TYPE mbew-stprs,
         bklas TYPE mbew-bklas,
       END OF ty_mbew,

       BEGIN OF ty_ebew,
         matnr TYPE ebew-matnr,
         bwkey TYPE ebew-bwkey,
         vbeln TYPE ebew-vbeln,
         posnr TYPE ebew-posnr,
         lbkum TYPE ebew-lbkum,
         salk3 TYPE ebew-salk3,
         vprsv TYPE ebew-vprsv,
         verpr TYPE ebew-verpr,
         stprs TYPE ebew-stprs,
       END OF ty_ebew,



       BEGIN OF ty_mska,
         matnr TYPE mska-matnr,
         werks TYPE mska-werks,
         lgort TYPE mska-lgort,
         sobkz TYPE mska-sobkz,
         vbeln TYPE mska-vbeln,
         posnr TYPE mska-posnr,
         kalab TYPE mska-kalab,
         kains TYPE mska-kains,
         kaspe TYPE mska-kaspe,
         kavla TYPE mska-kavla,
         kavin TYPE mska-kavin,
         kavsp TYPE mska-kavsp,
         kavei TYPE mska-kavei,
       END OF ty_mska,

       BEGIN OF ty_mslb,
         matnr TYPE mslb-matnr,
         werks TYPE mslb-werks,
         lblab TYPE mslb-lblab,
         lbins TYPE mslb-lbins,
         lbvla TYPE mslb-lbvla,
         lbvei TYPE mslb-lbvei,
         lbuml TYPE mslb-lbuml,
       END OF ty_mslb,

       BEGIN OF ty_msku,
         matnr TYPE msku-matnr,
         werks TYPE msku-werks,
         charg TYPE msku-charg,
         sobkz TYPE msku-sobkz,
         kunnr TYPE msku-kunnr,
         kulab TYPE msku-kulab,
       END OF ty_msku,

       BEGIN OF ty_mseg,
         mblnr   TYPE mseg-mblnr,
         zeile   TYPE mseg-zeile,
         line_id TYPE mseg-line_id,
         bwart   TYPE mseg-bwart,
         matnr   TYPE mseg-matnr,
         werks   TYPE mseg-werks,
         menge   TYPE mseg-menge,
         smbln   TYPE mseg-smbln,
       END OF ty_mseg,




       BEGIN OF ty_final,
         matnr    TYPE mard-matnr,
         mattxt   TYPE text255,
         wrkst    TYPE mara-wrkst,
         brand    TYPE mara-brand,
         zseries  TYPE mara-zseries,
         zsize    TYPE mara-zsize,
         moc      TYPE mara-moc,
         type     TYPE mara-type,
         mtart    TYPE mara-mtart,
         matkl    TYPE mara-matkl,
         werks    TYPE mard-werks,
         labst    TYPE mard-labst,
         umlme    TYPE mard-umlme,
         insme    TYPE mard-insme,
         kulab    TYPE msku-kulab,
         kalab    TYPE mska-kalab,
         speme    TYPE mard-speme,
         retme    TYPE mard-retme,
         total    TYPE mseg-menge,
         menge    TYPE mseg-menge,
         ref      TYPE char15,
         salk3    TYPE mbew-salk3,
       END OF ty_final,

       BEGIN OF ty_str,
         matnr    TYPE mard-matnr,
         mattxt   TYPE text255,
         wrkst    TYPE mara-wrkst,
         brand    TYPE mara-brand,
         zseries  TYPE mara-zseries,
         zsize    TYPE mara-zsize,
         moc      TYPE mara-moc,
         type     TYPE mara-type,
         mtart    TYPE mara-mtart,
         matkl    TYPE mara-matkl,
         werks    TYPE mard-werks,
         labst    TYPE char15,
         umlme    TYPE char15,
         insme    TYPE char15,
         kulab    TYPE char15,
         kalab    TYPE char15,
         speme    TYPE char15,
         retme    TYPE char15,
         total    TYPE char15,
         menge    TYPE char15,
         ref      TYPE char15,
         salk3    TYPE char15,
       END OF ty_str.





DATA:it_mara      TYPE TABLE OF ty_mara,
     wa_mara      TYPE          ty_mara,

     it_makt      TYPE TABLE OF ty_makt,
     wa_makt      TYPE          ty_makt,

     it_mard      TYPE TABLE OF ty_mard,
     wa_mard      TYPE          ty_mard,

     it_mara_mard TYPE TABLE OF ty_mara_mard,
     wa_mara_mard TYPE          ty_mara_mard,

     it_mbew      TYPE TABLE OF ty_mbew,
     wa_mbew      TYPE          ty_mbew,

     it_ebew      TYPE TABLE OF ty_ebew,
     wa_ebew      TYPE          ty_ebew,

     it_mska      TYPE TABLE OF ty_mska,
     wa_mska      TYPE          ty_mska,

     it_msku      TYPE TABLE OF ty_msku,
     wa_msku      TYPE          ty_msku,

     it_mslb      TYPE TABLE OF ty_mslb,
     wa_mslb      TYPE          ty_mslb,

     it_mseg      TYPE TABLE OF ty_mseg,
     wa_mseg      TYPE          ty_mseg,

     it_mseg1     TYPE TABLE OF ty_mseg,
     wa_mseg1     TYPE          ty_mseg,

     it_mseg2     TYPE TABLE OF ty_mseg,
     wa_mseg2     TYPE          ty_mseg,

     it_rev       TYPE TABLE OF ty_mseg,
     wa_rev       TYPE          ty_mseg,

     it_rev1      TYPE TABLE OF ty_mseg,
     wa_rev1      TYPE          ty_mseg,

     it_rev2      TYPE TABLE OF ty_mseg,
     wa_rev2      TYPE          ty_mseg,

     it_final     TYPE TABLE OF ty_final,
     wa_final     TYPE          ty_final,

     lt_final     TYPE TABLE OF ty_str,
     ls_final     TYPE          ty_str.



DATA: it_fcat TYPE slis_t_fieldcat_alv,
      wa_fcat LIKE LINE OF it_fcat.

DATA: i_sort             TYPE slis_t_sortinfo_alv, " SORT
      gt_events          TYPE slis_t_event,        " EVENTS
      i_list_top_of_page TYPE slis_t_listheader,   " TOP-OF-PAGE
      wa_layout          TYPE  slis_layout_alv..            " LAYOUT WORKAREA
DATA t_sort TYPE slis_t_sortinfo_alv WITH HEADER LINE.



DATA: lv_name   TYPE thead-tdname,
      lv_lines  TYPE STANDARD TABLE OF tline,
      wa_lines  LIKE tline,
      ls_itmtxt TYPE tline,
      ls_mattxt TYPE tline.



SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR mard-matnr,
*                s_lgort FOR mard-lgort,
*                s_lgpbe FOR mard-lgpbe,
                s_mtart FOR mara-mtart,
                s_werks FOR mard-werks OBLIGATORY DEFAULT 'US01'.
*PARAMETERS :
SELECTION-SCREEN:END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT 'E:\delval\usa'.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN :BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
  SELECTION-SCREEN  COMMENT /1(60) TEXT-004.
  SELECTION-SCREEN COMMENT /1(70) TEXT-005.
SELECTION-SCREEN: END OF BLOCK B3.

LOOP AT s_werks.
IF s_werks-low = 'PL01'.
   s_werks-low = ' '.
ENDIF.
IF s_werks-high = 'PL01'.
   s_werks-high = ' '.
ENDIF.
MODIFY s_werks.
ENDLOOP.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM sort_data.
  PERFORM det_fcat.
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
  SELECT a~matnr
           a~werks
           a~lgort
           a~lgpbe
           b~mtart
           b~matkl
           INTO TABLE it_mara_mard FROM mard AS a
           INNER JOIN mara AS b ON b~matnr = a~matnr
           WHERE a~matnr IN s_matnr
*          AND  a~lgort IN s_lgort
*          AND  a~lgpbe IN s_lgpbe
            AND  a~werks IN S_werks
            AND  b~mtart IN s_mtart.

SORT it_mara_mard BY matnr werks.
DELETE ADJACENT DUPLICATES FROM it_mara_mard COMPARING matnr werks.
DELETE it_mara_mard WHERE werks = 'PL01'.
  IF  it_mara_mard IS NOT INITIAL .
    SELECT matnr
           werks
           lgort
           labst
           umlme
           insme
           einme
           speme
           retme
           vmlab
           vmuml
           vmins
           vmein
           vmspe
           vmret FROM mard INTO TABLE it_mard
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND   lgort NE 'RJ' AND lgort NE 'SCR'
           AND   werks = it_mara_mard-werks.


    SELECT matnr
           werks
           lgort
           sobkz
           vbeln
           posnr
           kalab
           kains
           kaspe
           kavla
           kavin
           kavsp
           kavei FROM mska INTO TABLE it_mska
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND   lgort = it_mara_mard-lgort
           AND   werks = it_mara_mard-werks.
*           AND   SOBKZ = 'E'.

    SELECT matnr
           werks
           charg
           sobkz
           kunnr
           kulab FROM msku INTO TABLE it_msku
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND   werks = it_mara_mard-werks.





    SELECT matnr
           werks
           lblab
           lbins
           lbvla
           lbvei
           lbuml FROM mslb INTO TABLE it_mslb
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND   werks = it_mara_mard-werks.


    SELECT matnr
           maktx FROM makt INTO TABLE it_makt
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr.


    SELECT matnr
           zseries
           zsize
           brand
           moc
           type
           wrkst    FROM mara INTO TABLE it_mara
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr.




    SELECT matnr
           bwkey
           lbkum
           salk3
           vprsv
           verpr
           stprs
           bklas FROM mbew INTO TABLE it_mbew
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND   bwkey = it_mara_mard-werks.

*   SELECT matnr
*           bwkey
*           lbkum
*           salk3
*           vprsv
*           verpr
*           stprs FROM ebew INTO TABLE it_ebew
*           FOR ALL ENTRIES IN it_mara_mard
*           WHERE matnr = it_mara_mard-matnr
*           AND   bwkey = it_mara_mard-werks.

    SELECT mblnr
           zeile
           line_id
           bwart
           matnr
           werks
           menge
           smbln  FROM mseg INTO TABLE it_mseg
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND   werks = it_mara_mard-werks
           AND   bwart = '103'.

    SELECT mblnr
           zeile
           line_id
           bwart
           matnr
           werks
           menge
           smbln  FROM mseg INTO TABLE it_mseg1
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND   werks = it_mara_mard-werks
           AND   bwart = '105'.

    SELECT mblnr
           zeile
           line_id
           bwart
           matnr
           werks
           menge
           smbln  FROM mseg INTO TABLE it_mseg2
           FOR ALL ENTRIES IN it_mara_mard
           WHERE matnr = it_mara_mard-matnr
           AND   werks = it_mara_mard-werks
           AND   bwart = '104'.


  ENDIF.

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

  IF it_mseg1 IS NOT INITIAL.
    SELECT mblnr
           zeile
           line_id
           bwart
           matnr
           werks
           menge
           smbln  FROM mseg INTO TABLE it_rev1
           FOR ALL ENTRIES IN it_mseg1
           WHERE smbln = it_mseg1-mblnr
            AND  matnr = it_mseg1-matnr.


  ENDIF.

  IF it_mska IS NOT INITIAL.
    SELECT matnr
           bwkey
           vbeln
           posnr
           lbkum
           salk3
           vprsv
           verpr
           stprs FROM ebew INTO TABLE it_ebew
           FOR ALL ENTRIES IN it_mska
           WHERE matnr = it_mska-matnr
           AND   bwkey = it_mska-werks
           AND   vbeln = it_mska-vbeln
           AND   posnr = it_mska-posnr.

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
*  LOOP AT it_mara INTO wa_mara.
  LOOP AT it_mara_mard INTO wa_mara_mard.
      wa_final-mtart = wa_mara_mard-mtart.
      wa_final-matkl = wa_mara_mard-matkl.
      wa_final-werks = wa_mara_mard-werks.

    READ TABLE it_mara INTO wa_mara WITH KEY matnr = wa_mara_mard-matnr .
    IF sy-subrc = 0.
      wa_final-matnr       = wa_mara-matnr.
      wa_final-zseries     = wa_mara-zseries .
      wa_final-zsize       = wa_mara-zsize   .
      wa_final-brand       = wa_mara-brand   .
      wa_final-moc         = wa_mara-moc     .
      wa_final-type        = wa_mara-type    .
      wa_final-wrkst       = wa_mara-wrkst   .
    ENDIF.

    READ TABLE it_mbew INTO wa_mbew WITH KEY matnr = wa_mara_mard-matnr bwkey = wa_mara_mard-werks.
    IF sy-subrc = 0.
      wa_final-salk3 = wa_mbew-salk3.
    ENDIF.

    LOOP AT it_mard INTO wa_mard WHERE matnr = wa_mara_mard-matnr AND  werks = wa_mara_mard-werks.
      wa_final-labst = wa_final-labst + wa_mard-labst.
      wa_final-umlme = wa_final-umlme + wa_mard-umlme.
      wa_final-insme = wa_final-insme + wa_mard-insme.
      wa_final-speme = wa_final-speme + wa_mard-speme.
      wa_final-retme = wa_final-retme + wa_mard-retme.
    ENDLOOP.

    LOOP AT it_mska INTO wa_mska WHERE matnr = wa_mara_mard-matnr AND  werks = wa_mara_mard-werks.
      wa_final-kalab = wa_final-kalab + wa_mska-kalab.
    ENDLOOP.

    LOOP AT it_msku INTO wa_msku WHERE matnr = wa_mara_mard-matnr AND  werks = wa_mara_mard-werks.
      wa_final-kulab = wa_final-kulab + wa_msku-kulab.
    ENDLOOP.

    LOOP AT it_mseg INTO wa_mseg WHERE matnr = wa_mara-matnr AND  werks = wa_mara_mard-werks..
      READ TABLE it_rev INTO wa_rev WITH KEY smbln = wa_mseg-mblnr matnr = wa_mseg-matnr.
      IF sy-subrc = 4.
        wa_final-menge = wa_final-menge  + wa_mseg-menge.
      ENDIF.
      wa_final-werks = wa_mseg-werks.

    ENDLOOP.

    LOOP AT it_mseg1 INTO wa_mseg1 WHERE matnr = wa_mara-matnr AND  werks = wa_mara_mard-werks.
* wa_final-werks = wa_mseg-werks.
      READ TABLE it_rev1 INTO wa_rev1 WITH KEY smbln = wa_mseg1-mblnr matnr = wa_mseg1-matnr.
      IF sy-subrc = 4.
      wa_final-menge = wa_final-menge  - wa_mseg1-menge.
      ENDIF.
    ENDLOOP.




    CLEAR: lv_lines, ls_mattxt.
    REFRESH lv_lines.
    lv_name = wa_final-matnr.
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
          CONCATENATE wa_final-mattxt wa_lines-tdline INTO wa_final-mattxt SEPARATED BY space.
        ENDIF.
      ENDLOOP.
      CONDENSE wa_final-mattxt.
    ENDIF.

    wa_final-total = wa_final-LABST + wa_final-UMLME + wa_final-INSME + wa_final-KULAB
                     + wa_final-KALAB + wa_final-SPEME + wa_final-RETME.

    wa_final-ref = sy-datum.


    CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
      EXPORTING
        input  = wa_final-ref
      IMPORTING
        output = wa_final-ref.

    CONCATENATE wa_final-ref+0(2) wa_final-ref+2(3) wa_final-ref+5(4)
                    INTO wa_final-ref SEPARATED BY '-'.




    APPEND wa_final TO it_final.
    CLEAR wa_final.
  ENDLOOP.

IF  p_down = 'X'.
  LOOP AT it_final INTO wa_final.
    ls_final-matnr    = wa_final-matnr   .
    ls_final-mattxt   = wa_final-mattxt  .
    ls_final-wrkst    = wa_final-wrkst   .
    ls_final-brand    = wa_final-brand   .
    ls_final-zseries  = wa_final-zseries .
    ls_final-zsize    = wa_final-zsize   .
    ls_final-moc      = wa_final-moc     .
    ls_final-type     = wa_final-type    .
    ls_final-mtart    = wa_final-mtart   .
    ls_final-matkl    = wa_final-matkl   .
    ls_final-werks    = wa_final-werks   .
    ls_final-labst    = wa_final-labst   .
    ls_final-umlme    = wa_final-umlme   .
    ls_final-insme    = wa_final-insme   .
    ls_final-kulab    = wa_final-kulab   .
    ls_final-kalab    = wa_final-kalab   .
    ls_final-speme    = wa_final-speme   .
    ls_final-retme    = wa_final-retme   .
    ls_final-total    = wa_final-total   .
    ls_final-menge    = wa_final-menge   .
    ls_final-ref      = wa_final-ref     .
    ls_final-salk3    = wa_final-salk3     .
    APPEND ls_final TO lt_final.
    CLEAR ls_final.
  ENDLOOP.

ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DET_FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM det_fcat .
  PERFORM fcat USING :
                         '1'  'MATNR'         'IT_FINAL'  'Material.No.'                                     '18' ,
                         '2'  'MATTXT'        'IT_FINAL'  'Material Desc'                                    '18',
                         '3'  'WRKST'         'IT_FINAL'  'USA Code'                                         '18' ,
                         '4'  'BRAND  '       'IT_FINAL'  'Brand'                                            '10',
                         '5'  'ZSERIES'       'IT_FINAL'  'Series'                                           '10',
                         '6'  'ZSIZE  '       'IT_FINAL'  'Size'                                             '10',
                         '7'  'MOC    '       'IT_FINAL'  'MOC'                                              '10',
                         '8'  'TYPE   '       'IT_FINAL'  'Type'                                             '10',
                         '9'  'MTART'         'IT_FINAL'  'Material Type'                                    '18',
                        '10'  'MATKL'         'IT_FINAL'  'Material Group'                                   '18',
                        '11'  'WERKS'         'IT_FINAL'  'Plant'                                            '10',
                        '12'  'LABST'         'IT_FINAL'  'Unrestricted-Use Stock'                           '18',
                        '13'  'SALK3'         'IT_FINAL'  'Unrestricted-Use Stock Value'                     '20',
                        '14'  'UMLME'         'IT_FINAL'  'Stock in transfer '                               '18',
                        '15'  'INSME'         'IT_FINAL'  'Stock in Quality Inspection'                      '18',
                        '16'  'KULAB'         'IT_FINAL'  'Consignment Stock'                                '18',
                        '17'  'KALAB'         'IT_FINAL'  'SO Allocated Stock'                               '18',
                        '18'  'SPEME'         'IT_FINAL'  'Blocked Stock'                                   '18',
                        '19'  'RETME'         'IT_FINAL'  'Blocked Stock Returns'                           '18',
                        '20'  'TOTAL'         'IT_FINAL'  'Total Stock '                                  '18',
                        '21'  'MENGE'         'IT_FINAL'  'In Transit Block'                                      '15'.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_1435   text
*      -->P_1436   text
*      -->P_1437   text
*      -->P_1438   text
*      -->P_1439   text
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
*  wa_fcat-key       = .
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
*     I_INTERFACE_CHECK       = ' '
*     I_BYPASSING_BUFFER      = ' '
*     I_BUFFER_ACTIVE         = ' '
      i_callback_program      = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
      i_callback_user_command = 'USER_CMD'
      i_callback_top_of_page  = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME        =
*     I_BACKGROUND_ID         = ' '
*     I_GRID_TITLE            =
*     I_GRID_SETTINGS         =
      is_layout               = wa_layout
      it_fieldcat             = it_fcat
*     IT_EXCLUDING            =
*     IT_SPECIAL_GROUPS       =
      it_sort                 = t_sort[]
*     IT_FILTER               =
*     IS_SEL_HIDE             =
*     I_DEFAULT               = 'X'
      i_save                  = 'X'
*     IS_VARIANT              =
*     IT_EVENTS               =
*     IT_EVENT_EXIT           =
*     IS_PRINT                =
*     IS_REPREP_ID            =
*     I_SCREEN_START_COLUMN   = 0
*     I_SCREEN_START_LINE     = 0
*     I_SCREEN_END_COLUMN     = 0
*     I_SCREEN_END_LINE       = 0
*     I_HTML_HEIGHT_TOP       = 0
*     I_HTML_HEIGHT_END       = 0
*     IT_ALV_GRAPHICS         =
*     IT_HYPERLINK            =
*     IT_ADD_FIELDCAT         =
*     IT_EXCEPT_QINFO         =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER =
*     ES_EXIT_CAUSED_BY_USER  =
    TABLES
      t_outtab                = it_final
*   EXCEPTIONS
*     PROGRAM_ERROR           = 1
*     OTHERS                  = 2
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
  ls_header-info = 'MB52 Report'.
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
  CONCATENATE ls_header-info sy-timlo(2) '.' sy-timlo+2(2) '.' sy-timlo+4(2) INTO ls_header-info.
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


    lv_file = 'ZUS_MB52.TXT'.


  CONCATENATE p_folder '\' sy-datum sy-uzeit lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUS_MB52 REPORT started on', sy-datum, 'at', sy-uzeit.
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
*********************************************SQL UPLOAD FILE *****************************************
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


    lv_file = 'ZUS_MB52.TXT'.


  CONCATENATE p_folder '\' lv_file
    INTO lv_fullfile.

  WRITE: / 'ZUS_MB52 REPORT started on', sy-datum, 'at', sy-uzeit.
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
CONCATENATE 'Material.No.'
            'Material Desc'
            'USA Code'
            'Brand'
            'Series'
            'Size'
            'MOC'
            'Type'
            'Material Type'
            'Material Group'
            'Plant'
            'Unrestricted-Use Stock'
            'Stock in transfer '
            'Stock in Quality Inspection'
            'Consignment Stock'
            'SO Allocated Stock'
            'Blocked Stock'
            'Blocked Stock Returns'
            'Total Stock '
            'In Transit Block'
            'Refresh File Date'
            'Unrestricted-Use Stock Value'
              INTO pd_csv
              SEPARATED BY l_field_seperator.


ENDFORM.

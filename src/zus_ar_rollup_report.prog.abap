*&---------------------------------------------------------------------*
*& Report ZFI_AR_ROLL_UP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zus_ar_rollup_report.

TYPE-POOLS: slis.

*Table declaration
TABLES: bsad, bsid.
TYPES : BEGIN OF ty_bkpf,
          bukrs TYPE bukrs,
          belnr TYPE belnr_d,
          gjahr TYPE gjahr,
          blart TYPE blart,
          budat TYPE budat,
        END OF ty_bkpf,

        BEGIN OF ty_bseg,
          bukrs TYPE bukrs,
          belnr TYPE belnr_d,
          gjahr TYPE gjahr,
          shkzg TYPE shkzg,
          dmbtr TYPE dmbtr,
          hkont TYPE hkont,
        END OF ty_bseg.

DATA : lt_bkpf TYPE TABLE OF ty_bkpf,
       ls_bkpf TYPE ty_bkpf,
       lt_bseg TYPE TABLE OF ty_bseg,
       ls_bseg TYPE ty_bseg.

DATA: it_bsad  TYPE TABLE OF bsad,
      it_bsad1 TYPE TABLE OF bsad,
      it_bsad2 TYPE TABLE OF bsad,
      wa_bsad  TYPE bsad,
      wa_bsad1 TYPE bsad,
      wa_bsad2 TYPE bsad,
      it_bsid  TYPE TABLE OF bsid,
      it_bsid1 TYPE TABLE OF bsid,
      wa_bsid  TYPE bsid,
      wa_bsid1 TYPE bsid.

DATA: lt_keybalance TYPE TABLE OF bapi3007_3 WITH HEADER LINE,
      lt_return     TYPE bapireturn,
      lv_date       TYPE datum,
      lv_dmbtr TYPE bsad-dmbtr,
      lv_dmbtr1 TYPE bsad-dmbtr.


TYPES: BEGIN OF ty_budat,
         budat TYPE bsad-budat,
       END OF ty_budat.

DATA: it_budat TYPE TABLE OF ty_budat,
      wa_budat TYPE ty_budat.

TYPES: BEGIN OF ty_kunnr,
         kunnr TYPE knb1-kunnr,
       END OF ty_kunnr.

DATA: it_kunnr TYPE TABLE OF ty_kunnr,
      wa_kunnr TYPE ty_kunnr.

TYPES: BEGIN OF ty_final,
         budat         TYPE bsad-budat,
         invoice       TYPE bsad-dmbtr,
         credit_memo   TYPE bsad-dmbtr,
         adv_pmt       TYPE bsad-dmbtr,
         cust_refund   TYPE bsad-dmbtr,
         cash_rec      TYPE bsad-dmbtr,
         discount      TYPE bsad-dmbtr,
         other_deposit TYPE bsad-dmbtr,
         total_deposit TYPE bsad-dmbtr,
         opening_bal   TYPE bsad-dmbtr,
         closing_bal   TYPE bsad-dmbtr,
       END OF ty_final.

DATA: it_final TYPE TABLE OF ty_final,
      wa_final TYPE ty_final.
DATA: gl_balan TYPE dmbtr.
DATA: lv_end TYPE bsad-dmbtr.
DATA: v_fieldcat  TYPE slis_fieldcat_alv,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gt_layout   TYPE slis_layout_alv,
      gt_sort     TYPE slis_sortinfo_alv,
      fieldcat    LIKE LINE OF gt_fieldcat.

DATA: wa_bseg TYPE bseg.

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_bukrs TYPE bsad-bukrs OBLIGATORY.
SELECT-OPTIONS: s_budat FOR bsad-budat OBLIGATORY.
SELECTION-SCREEN: END OF BLOCK b1.


START-OF-SELECTION.
  PERFORM get_data.
  PERFORM write_data.
  PERFORM fill_fieldcatalog.
  PERFORM final_display.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .

  SELECT kunnr
         FROM knb1 INTO TABLE it_kunnr
       WHERE bukrs = p_bukrs.

  SELECT *
    FROM bsad
    INTO TABLE it_bsad
    WHERE bukrs EQ p_bukrs
    AND budat IN s_budat.

  SELECT *
    FROM bsid
    INTO TABLE it_bsid
    WHERE bukrs EQ p_bukrs
    AND   budat IN s_budat.

  SELECT *
   FROM bsad
   INTO TABLE it_bsad1
   WHERE bukrs EQ p_bukrs
   AND   augdt IN s_budat.

  SELECT bukrs belnr
       gjahr blart
       budat
       FROM bkpf
       INTO TABLE lt_bkpf
       WHERE bukrs = p_bukrs
       AND blart = 'SA'
       AND budat IN s_budat
       AND stblg = ' '.



  IF lt_bkpf IS NOT INITIAL.
    SELECT bukrs belnr
           gjahr shkzg
           dmbtr hkont
           FROM bseg
           INTO TABLE lt_bseg
           FOR ALL ENTRIES IN lt_bkpf
           WHERE belnr = lt_bkpf-belnr
           AND gjahr = lt_bkpf-gjahr
           AND bukrs = lt_bkpf-bukrs
           AND hkont = '0000010021'.

  ENDIF.


  LOOP AT it_bsad INTO wa_bsad.
    wa_budat-budat = wa_bsad-budat.
    APPEND wa_budat TO it_budat.
  ENDLOOP.
  LOOP AT it_bsid INTO wa_bsid.
    wa_budat-budat = wa_bsid-budat.
    APPEND wa_budat TO it_budat.
  ENDLOOP.

  LOOP AT lt_bkpf INTO ls_bkpf.
    wa_budat-budat = ls_bkpf-budat.
    APPEND wa_budat TO it_budat.
    CLEAR : ls_bkpf,wa_budat.
  ENDLOOP.



  SORT it_budat BY budat.
  DELETE ADJACENT DUPLICATES FROM it_budat COMPARING budat.



ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  WRITE_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM write_data .

  LOOP AT it_budat INTO wa_budat.

    wa_final-budat = wa_budat-budat.

    LOOP AT it_bsad INTO wa_bsad WHERE budat EQ wa_budat-budat.
        lv_dmbtr = wa_bsad-dmbtr.
      IF  wa_bsad-bschl = '19' .
      IF wa_bsad-shkzg = 'S'.
        lv_dmbtr = lv_dmbtr * -1.
      ENDIF.

      ENDIF.
       IF wa_bsad-rebzg IS NOT INITIAL AND  wa_bsad-blart = 'DZ'  ."IS NOT INITIAL
         wa_final-cash_rec =   wa_final-cash_rec + wa_bsad-dmbtr.
       ENDIF.
*       IF wa_bsad-blart = 'DZ'  ."IS NOT INITIAL
*         wa_final-cash_rec =   wa_final-cash_rec + wa_bsad-dmbtr.
*       ENDIF.

*       IF wa_bsad-rebzg EQ ' ' AND  wa_bsad-blart = 'SA'  ."IS NOT INITIAL
*         wa_final-cash_rec =   wa_final-cash_rec + wa_bsad-dmbtr.
*       ENDIF.

      IF wa_bsad-shkzg EQ 'H'.
        wa_bsad-dmbtr = wa_bsad-dmbtr * -1.
      ENDIF.
      IF wa_bsad-bschl EQ '01'.     " INVOICE AMOUNT
        wa_final-invoice = wa_final-invoice + wa_bsad-dmbtr.
      ENDIF.

      IF wa_bsad-bschl EQ '12'.     " INVOICE AMOUNT
        wa_final-invoice = wa_final-invoice + wa_bsad-dmbtr.
      ENDIF.

      IF wa_bsad-bschl EQ '11'.     " CREDIT MEMO AMOUNT
        wa_final-credit_memo = wa_final-credit_memo + wa_bsad-dmbtr.
      ENDIF.

      IF wa_bsad-bschl EQ '02'.     " CREDIT MEMO AMOUNT
        wa_final-credit_memo = wa_final-credit_memo + wa_bsad-dmbtr.
      ENDIF.

      IF wa_bsad-bschl EQ '19' AND  wa_bsad-augdt >= wa_bsad-budat.
        wa_final-other_deposit = wa_final-other_deposit +  lv_dmbtr.              "wa_bsad-dmbtr.
      ENDIF.

*      IF wa_bsad-bschl EQ '17'AND  wa_bsad-augdt >= wa_bsad-budat.
*        wa_final-other_deposit = wa_final-other_deposit + wa_bsad-dmbtr.
*      ENDIF.

      CLEAR : wa_bsad,lv_dmbtr.

*      IF wa_bsad-bschl EQ '09' OR wa_bsad-bschl EQ '19' OR wa_bsad-bschl EQ '17' OR wa_bsad-bschl EQ '07' .
*        wa_final-cash_rec = wa_final-cash_rec + wa_bsad-dmbtr.
*
*      ENDIF.
*                IF ( WA_BSAD-BSCHL EQ '09' OR WA_BSAD-BSCHL EQ '19' ).        " OTHER DEPOSIT commented by swati on 08.02.19
*                  WA_FINAL-OTHER_DEPOSIT = WA_FINAL-OTHER_DEPOSIT + WA_BSAD-DMBTR.
*                ENDIF.
    ENDLOOP.


    LOOP AT it_bsid INTO wa_bsid WHERE budat EQ wa_budat-budat.
      lv_dmbtr = wa_bsid-dmbtr.
      IF wa_bsid-bschl = '19'.
        IF wa_bsid-shkzg = 'S'.
          lv_dmbtr = lv_dmbtr * -1.
        ENDIF.
      ENDIF.

****Added 28.06.19.
      lv_dmbtr1 = wa_bsid-dmbtr.
      IF wa_bsid-blart = 'DZ' AND wa_bsid-umskz = 'A' AND wa_bsid-bschl = '09'.
        lv_dmbtr1 = lv_dmbtr1 * -1.
      ENDIF.

      IF wa_bsid-rebzg IS NOT INITIAL AND  wa_bsid-blart = 'DZ'  .
         wa_final-cash_rec =   wa_final-cash_rec +  lv_dmbtr1.
*        wa_final-cash_rec = wa_final-cash_rec + wa_bsid-dmbtr.   " CASH RECEIPT
      ENDIF.
      CLEAR lv_dmbtr1.

      IF wa_bsid-shkzg EQ 'H'.
        wa_bsid-dmbtr = wa_bsid-dmbtr * -1.
      ENDIF.




      IF wa_bsid-bschl EQ '01'.         " INVOICE AMOUNT
        wa_final-invoice = wa_final-invoice + wa_bsid-dmbtr.
      ENDIF.

      IF wa_bsid-bschl EQ '12'.     " INVOICE AMOUNT
        wa_final-invoice = wa_final-invoice + wa_bsid-dmbtr.
      ENDIF.


      IF wa_bsid-bschl EQ '11'.        " CREDIT MEMO
        wa_final-credit_memo = wa_final-credit_memo + wa_bsid-dmbtr.
      ENDIF.

      IF wa_bsid-bschl EQ '02'.     " CREDIT MEMO AMOUNT
        wa_final-credit_memo = wa_final-credit_memo + wa_bsid-dmbtr.
      ENDIF.

      IF wa_bsid-bschl EQ '19' .      "OR wa_bsid-bschl EQ '09'  .        " OTHER DEPOSIT
        wa_final-other_deposit = wa_final-other_deposit +  lv_dmbtr.    " wa_bsid-dmbtr.
      ENDIF.


*      IF wa_bsid-bschl EQ '09' AND wa_bsid-blart = 'AB'.
*        wa_final-adv_pmt = wa_final-adv_pmt + wa_bsid-dmbtr.
*      ENDIF.

*      IF wa_bsid-blart = 'DZ' AND wa_bsid-umskz = 'A' AND wa_bsid-bschl = '09'.
*        wa_final-adv_pmt = wa_final-adv_pmt + wa_bsid-dmbtr.
*      ENDIF.


      CLEAR : wa_bsid,lv_dmbtr.

    ENDLOOP.

    it_bsad2 = it_bsad1.
    LOOP AT it_bsad1 INTO wa_bsad1 WHERE augdt EQ wa_budat-budat.


***Added on 27.02.19
      IF  wa_bsad1-blart = 'DZ' AND  wa_bsad1-umskz IS INITIAL AND wa_bsad1-rebzg IS INITIAL.
        wa_final-cash_rec = wa_final-cash_rec + wa_bsad1-dmbtr.
      ENDIF.

      IF wa_bsad1-bschl = '02'.
        wa_final-cash_rec =   wa_final-cash_rec - wa_bsad1-dmbtr.
      ENDIF.
      IF  wa_bsad1-bschl = '11'.
         wa_final-cash_rec =   wa_final-cash_rec + wa_bsad1-dmbtr.

      ENDIF.
      IF wa_bsad1-bschl = '05'.
         wa_final-cash_rec =   wa_final-cash_rec - wa_bsad1-dmbtr.
      ENDIF.
*
   CLEAR wa_bsad2.
      lv_dmbtr = wa_bsad1-dmbtr.
      IF wa_bsad1-bschl = '09'.
        IF wa_bsad1-shkzg = 'S'.
          lv_dmbtr = lv_dmbtr * -1.
        ENDIF.
      ENDIF.
***************************End**************************

      IF wa_bsad1-shkzg EQ 'H'.
        wa_bsad1-dmbtr = wa_bsad1-dmbtr * -1.
        IF wa_bsad1-sknto IS NOT INITIAL.
          wa_bsad1-sknto = wa_bsad1-sknto.
        ENDIF.
      ENDIF.

*

      IF wa_bsad1-bschl EQ '11'.        " CUSTOMER REFUND
        wa_final-cust_refund = wa_final-cust_refund + wa_bsad1-dmbtr.
      ENDIF.

      IF wa_bsad1-bschl EQ '02'.        " CUSTOMER REFUND
        wa_final-cust_refund = wa_final-cust_refund + wa_bsad1-dmbtr.
      ENDIF.

*      IF wa_bsad1-bschl EQ '01'.         " CASH RECEIPT AMOUNT   "commented on 27.02.19 by swati
*        wa_final-cash_rec = wa_final-cash_rec + wa_bsad1-dmbtr.
*      ENDIF.

*      IF wa_bsad1-bschl EQ '12'.         " CASH RECEIPT AMOUNT
*        wa_final-cash_rec = wa_final-cash_rec + wa_bsad1-dmbtr.
*      ENDIF.

*      IF wa_bsad1-bschl EQ '09' AND wa_bsad1-blart = 'AB'.         " CASH RECEIPT AMOUNT
**        wa_final-cash_rec = wa_final-cash_rec + wa_bsad1-dmbtr.
*        wa_final-adv_pmt = wa_final-adv_pmt + wa_bsad1-dmbtr.
*      ENDIF.

      CLEAR wa_bseg.
      IF wa_bsad1-blart = 'DZ'.         "DISCOUNT
      SELECT SINGLE * FROM bseg INTO wa_bseg WHERE belnr = wa_bsad1-belnr AND augdt = wa_bsad1-augdt.
        IF wa_bseg-shzuz IS INITIAL.
        wa_final-discount = wa_final-discount + wa_bsad1-sknto.
        ENDIF.
      ENDIF.

      CLEAR wa_bseg.
      IF wa_bsad1-blart = 'DZ'.         "DISCOUNT
      SELECT SINGLE * FROM bseg INTO  wa_bseg WHERE belnr = wa_bsad1-belnr AND augdt = wa_bsad1-augdt.
        IF wa_bseg-shzuz IS NOT INITIAL.
        wa_final-discount = wa_final-discount - wa_bsad1-sknto.
        ENDIF.
      ENDIF.

      IF ( wa_bsad1-bschl EQ '09' ) AND wa_bsad1-blart = 'DA'.        " OTHER DEPOSIT   COMMENTED ON 26.02.2019


        wa_final-other_deposit = wa_final-other_deposit + lv_dmbtr.          "wa_bsad1-dmbtr.

      ENDIF.

*      IF wa_bsad1-bschl EQ '17' AND wa_bsad1-blart = 'AB' .
*        READ TABLE it_bsad2 INTO wa_bsad2 WITH  KEY belnr = wa_bsad1-belnr bschl = '09' augdt = wa_bsad1-augdt .
*        IF sy-subrc = 0.
**          wa_final-cash_rec = wa_final-cash_rec + wa_bsad1-dmbtr.
*          wa_final-adv_pmt = wa_final-adv_pmt + wa_bsad1-dmbtr.
*        ENDIF.
*
*      ENDIF.

      CLEAR : wa_bsad1,wa_bsad2,lv_dmbtr.

    ENDLOOP.


    LOOP AT lt_bkpf INTO ls_bkpf WHERE budat = wa_budat-budat.
      LOOP AT lt_bseg INTO ls_bseg WHERE belnr = ls_bkpf-belnr AND gjahr = ls_bkpf-gjahr.
*        IF ls_bseg-shkzg  = 'H'.
*          ls_bseg-dmbtr = ls_bseg-dmbtr * -1.
*        ENDIF.
        wa_final-other_deposit = wa_final-other_deposit + ls_bseg-dmbtr.
        CLEAR : ls_bseg.
      ENDLOOP.
      CLEAR : ls_bkpf.
    ENDLOOP.
    wa_final-cash_rec = wa_final-cash_rec - wa_final-discount.
    wa_final-total_deposit = wa_final-cust_refund + wa_final-cash_rec + wa_final-other_deposit.

    IF wa_budat-budat = '20181231' AND  wa_final-total_deposit IS NOT INITIAL.
      wa_final-total_deposit = wa_final-total_deposit - 510.
    ENDIF.

    IF sy-tabix EQ '1'.

      LOOP AT it_kunnr INTO wa_kunnr.

        lv_date = wa_final-budat - 1.
        CALL FUNCTION 'BAPI_AR_ACC_GETKEYDATEBALANCE'
          EXPORTING
            companycode = p_bukrs
            customer    = wa_kunnr-kunnr
            keydate     = lv_date
          IMPORTING
            return      = lt_return
          TABLES
            keybalance  = lt_keybalance.
        READ TABLE  lt_keybalance WITH KEY currency = 'USD'.
        wa_final-opening_bal = wa_final-opening_bal + lt_keybalance-lc_bal.


        CALL FUNCTION 'BAPI_AR_ACC_GETKEYDATEBALANCE'
          EXPORTING
            companycode  = p_bukrs
            customer     = wa_kunnr-kunnr
            keydate      = lv_date
            balancespgli = 'X'
*           NOTEDITEMS   = 'X'
          IMPORTING
            return       = lt_return
          TABLES
            keybalance   = lt_keybalance.



        READ TABLE  lt_keybalance WITH KEY currency = 'USD' sp_gl_ind = 'A' .
        IF sy-subrc = 0.

          gl_balan = gl_balan - lt_keybalance-lc_bal.

        ENDIF.



      ENDLOOP.

      wa_final-opening_bal = wa_final-opening_bal + gl_balan.
    ENDIF.

    IF sy-tabix NE '1'.
      wa_final-opening_bal = lv_end.
      CLEAR: lv_end.
    ENDIF.


    wa_final-closing_bal = wa_final-opening_bal + wa_final-invoice + wa_final-credit_memo - wa_final-cust_refund - wa_final-cash_rec
                                                                                  - wa_final-discount. "- wa_final-adv_pmt . " + wa_final-other_deposit  commented on 08.02.19 by swati
    lv_end = wa_final-closing_bal.
*    IF wa_final-cash_rec < 0.
*      wa_final-cash_rec = wa_final-cash_rec * -1.
*    ENDIF.
    APPEND wa_final TO it_final.

    CLEAR: wa_final,wa_bsad, wa_bsid, wa_bsad1.

  ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FILL_FIELDCATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fill_fieldcatalog .

  CLEAR v_fieldcat.
  v_fieldcat-col_pos = 1.
  v_fieldcat-fieldname = 'BUDAT'.
  v_fieldcat-seltext_m = 'POSTING DATE'.
  v_fieldcat-outputlen = '25'.
  APPEND v_fieldcat TO gt_fieldcat.

*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 2.
*  v_fieldcat-fieldname = 'OPENING_BAL'.
*  v_fieldcat-seltext_m = 'OPENING BALANCE'.
*  v_fieldcat-outputlen = '25'.
*  APPEND v_fieldcat TO gt_fieldcat.
*
*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 3.
*  v_fieldcat-fieldname = 'INVOICE'.
*  v_fieldcat-seltext_m = 'INVOICES'.
*  v_fieldcat-outputlen = '25'.
*  v_fieldcat-do_sum = 'X'.
*  APPEND v_fieldcat TO gt_fieldcat.
*
*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 4.
*  v_fieldcat-fieldname = 'CREDIT_MEMO'.
*  v_fieldcat-seltext_m = 'CREDIT MEMO'.
*  v_fieldcat-outputlen = '25'.
*  v_fieldcat-do_sum = 'X'.
*  APPEND v_fieldcat TO gt_fieldcat.
*
*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 5.
*  v_fieldcat-fieldname = 'ADV_PMT'.
*  v_fieldcat-seltext_m = 'ADV.PMT.APPLIED'.
*  v_fieldcat-outputlen = '25'.
*  v_fieldcat-do_sum = 'X'.
*  APPEND v_fieldcat TO gt_fieldcat.
*
*
*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 6.
*  v_fieldcat-fieldname = 'CUST_REFUND'.
*  v_fieldcat-seltext_m = 'CUSTOMER REFUND'.
*  v_fieldcat-outputlen = '25'.
*  v_fieldcat-do_sum = 'X'.
*  APPEND v_fieldcat TO gt_fieldcat.
*
*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 7.
*  v_fieldcat-fieldname = 'CASH_REC'.
*  v_fieldcat-seltext_m = 'CASH RECEIPT'.
*  v_fieldcat-outputlen = '25'.
*  v_fieldcat-do_sum = 'X'.
*  APPEND v_fieldcat TO gt_fieldcat.
*
*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 8.
*  v_fieldcat-fieldname = 'DISCOUNT'.
*  v_fieldcat-seltext_m = 'DISCOUNT'.
*  v_fieldcat-outputlen = '25'.
*  v_fieldcat-do_sum = 'X'.
*  APPEND v_fieldcat TO gt_fieldcat.
*
*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 9.
**  v_fieldcat-no_sign = 'X'.
*  v_fieldcat-fieldname = 'OTHER_DEPOSIT'.
*  v_fieldcat-seltext_m = 'OTHER DEPOSITS'.
*  v_fieldcat-outputlen = '25'.
*  v_fieldcat-do_sum = 'X'.
*  APPEND v_fieldcat TO gt_fieldcat.
*
*  CLEAR v_fieldcat.
*  v_fieldcat-col_pos = 10.
*  v_fieldcat-fieldname = 'TOTAL_DEPOSIT'.
*  v_fieldcat-seltext_m = 'TOTAL DEPOSITS'.
*  v_fieldcat-outputlen = '25'.
*  v_fieldcat-do_sum = 'X'.
*  APPEND v_fieldcat TO gt_fieldcat.


  CLEAR v_fieldcat.
  v_fieldcat-col_pos = 11.
  v_fieldcat-fieldname = 'CLOSING_BAL'.
  v_fieldcat-seltext_m = 'CLOSING BALANCE'.
  v_fieldcat-outputlen = '25'.
  APPEND v_fieldcat TO gt_fieldcat.

  CLEAR v_fieldcat.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM top_of_page .

*ALV Header declarations
  DATA: t_header      TYPE slis_t_listheader,
        wa_header     TYPE slis_listheader,
        t_line        LIKE wa_header-info,
        ld_lines      TYPE i,
        ld_linesc(10) TYPE c,
        l_period_from TYPE char10,
        l_period_to   TYPE char10.
  .

  DATA : date TYPE sy-datum,
         time TYPE sy-uzeit.
*  Title
  wa_header-typ  = 'H'.
  wa_header-info = 'A/R Rollforward'.
  APPEND wa_header TO t_header.
  CLEAR wa_header.

*  Date
  wa_header-typ  = 'S'.
  wa_header-key  = 'Date: '.

  date = sy-datum.
  CONCATENATE wa_header-info date+6(2) '.' date+4(2) '.' date(4) INTO wa_header-info.
  APPEND wa_header TO t_header.
  CLEAR: wa_header.

  PERFORM convert_date_to_external
          USING    s_budat-low
          CHANGING l_period_from.

  PERFORM convert_date_to_external
          USING    s_budat-high
          CHANGING l_period_to.

  wa_header-typ  = 'S'.
  wa_header-key  = 'Run Period: '.
  CONCATENATE l_period_from 'to'(049) l_period_to INTO wa_header-info SEPARATED BY space.
  APPEND  wa_header TO t_header.
  CLEAR: wa_header.

***************time *************


  DATA it_list_commentary TYPE slis_t_listheader.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = t_header
*     i_logo             = 'CORP'
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .

ENDFORM.                    " TOP_OF_PAGE

FORM final_display .

  CLEAR gt_layout.
*  gt_layout-zebra = 'X'.
  gt_layout-colwidth_optimize = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK       = ' '
*     I_BYPASSING_BUFFER      = ' '
*     I_BUFFER_ACTIVE         = ' '
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND'
      i_callback_top_of_page  = 'TOP_OF_PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME        =
*     I_BACKGROUND_ID         = ' '
*     I_GRID_TITLE            =
*     I_GRID_SETTINGS         =
      is_layout               = gt_layout
      it_fieldcat             = gt_fieldcat[]
*     IT_EXCLUDING            =
*     IT_SPECIAL_GROUPS       =
*     IT_SORT                 =
*     IT_FILTER               =
*     IS_SEL_HIDE             =
*     I_DEFAULT               = 'X'
     I_SAVE                  = 'A'
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
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER =
*     ES_EXIT_CAUSED_BY_USER  =
    TABLES
      t_outtab                = it_final
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM. " final_display

*&---------------------------------------------------------------------*
*&      Form  CONVERT_DATE_TO_EXTERNAL
*&---------------------------------------------------------------------*
*       Convert Internal date to external format
*----------------------------------------------------------------------*
*      -->U_DATE  Internal Date
*      <--C_DATE  External Date
*----------------------------------------------------------------------*
FORM convert_date_to_external
     USING    u_date TYPE datum
     CHANGING c_date TYPE char10.

  CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
    EXPORTING
      date_internal            = u_date
    IMPORTING
      date_external            = c_date
    EXCEPTIONS
      date_internal_is_invalid = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

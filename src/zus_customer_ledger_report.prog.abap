*&---------------------------------------------------------------------*
*& Report ZUS_CUSTOMER_LEDGER_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCUSTOMER_LEDGER_REPORT.

TYPE-POOLS : slis.
TABLES : bsid,bsad,kna1,bkpf.

************************************* structure declration*************************
TYPES: BEGIN OF ty_bsid,

       bukrs type bsid-bukrs,
       kunnr type bsid-kunnr,
       budat type bsid-budat,
       belnr type bsid-belnr,
       buzei TYPE bsid-buzei,
       blart type bsid-blart,
       dmbtr type bsid-dmbtr,
       shkzg TYPE bsid-shkzg,
       bschl TYPE bsid-bschl,
       umskz TYPE bsid-umskz,
       rebzg TYPE bsid-rebzg,
END OF ty_bsid.

TYPES: BEGIN OF ty_bsad,

       bukrs type bsad-bukrs,
       kunnr type bsad-kunnr,
       augbl type bsad-augbl,
       budat type bsad-budat,
       belnr type bsad-belnr,
       buzei TYPE bsad-buzei,
       blart type bsad-blart,
       dmbtr type bsad-dmbtr,
       sknto type bsad-sknto,
       shkzg TYPE bsad-shkzg,
       bschl TYPE bsid-bschl,
       umskz TYPE bsid-umskz,
END OF ty_bsad.


TYPES: BEGIN OF ty_kna1,
       kunnr  type kna1-kunnr,
       name1  type kna1-name1,
END OF ty_kna1.

TYPES: BEGIN OF ty_bkpf,
       bukrs type bkpf-bukrs,
       belnr type bkpf-belnr,
       budat type bkpf-budat,
       stblg type bkpf-stblg,
       blart type bkpf-blart,
END OF ty_bkpf.

TYPES : BEGIN OF ty_linetype,
          sign(1)   TYPE c,
          option(2) TYPE c,
          low       TYPE bsid-kunnr,
          high      TYPE bsid-kunnr,
        END OF ty_linetype.

TYPES: BEGIN OF ty_final,
       belnr          type bsid-belnr,
       budat          type bsid-budat,
       buzei          TYPE bsid-buzei,
       blart          TYPE bsid-blart,
       kunnr          type kna1-kunnr,
       name1          type kna1-name1,
       debit          type dmbtr,
       credit         type dmbtr,
       opening_bal    type dmbtr,
       sales_bal      type dmbtr,
       credit_bal     type dmbtr,
       cust_ref       type dmbtr,
       cash_rec       type dmbtr,
       discount       TYPE dmbtr,
       total_amt      TYPE dmbtr,
       end_bal        type dmbtr,
       tot_dep        type dmbtr,
       variance       type dmbtr,
       other_dep      type dmbtr,
END OF ty_final.

TYPES: BEGIN OF final,

       budat          type bsid-budat,
       debit          type dmbtr,
       credit         type dmbtr,
       opening_bal    type dmbtr,
       sales_bal      type dmbtr,
       credit_bal     type dmbtr,
       cust_ref       type dmbtr,
       cash_rec       type dmbtr,
       discount       TYPE dmbtr,
       total_amt      TYPE dmbtr,
       end_bal        type dmbtr,
       tot_dep        type dmbtr,
       other_dep      type dmbtr,
END OF final.


DATA: gl_balan TYPE dmbtr.

TYPES: BEGIN OF ty_knb1,
        kunnr TYPE knb1-kunnr,
        bukrs TYPE knb1-bukrs,

END OF ty_knb1.

******************************************structure completed***********************

************************Internal table declaration*************************************

DATA:  lt_bsid type TABLE OF ty_bsid,
       ls_bsid type   ty_bsid,

       lt_bsid1 type TABLE OF ty_bsid,
       ls_bsid1 type   ty_bsid,

       lt_sales type TABLE OF ty_bsid,
       lt_collection TYPE TABLE OF ty_bsid,
       lt_drcrnote   type TABLE OF ty_bsid,

       lt_credit type TABLE OF ty_bsid,
       ls_credit TYPE          ty_bsid,

       lt_refund type TABLE OF ty_bsid,
       ls_refund TYPE          ty_bsid,

       lt_cash type TABLE OF ty_bsid,
       ls_cash TYPE          ty_bsid,

       lt_cash_bsid type TABLE OF ty_bsid,
       ls_cash_bsid TYPE          ty_bsid,

       lt_cash_bsid1 type TABLE OF ty_bsid,
       ls_cash_bsid1 TYPE          ty_bsid,

       lt_cash_bsad type TABLE OF ty_bsad,
       ls_cash_bsad type   ty_bsad,

       lt_bsad type TABLE OF ty_bsad,
       ls_bsad type   ty_bsad,

       lt_other type TABLE OF ty_bsid,
       ls_other type   ty_bsid,

       lt_other_bsid type TABLE OF ty_bsid,
       ls_other_bsid TYPE          ty_bsid,

       lt_other_bsad type TABLE OF ty_bsad,
       ls_other_bsad type   ty_bsad,

       lt_sales1 type TABLE OF ty_bsid,
       lt_collection1 TYPE TABLE OF ty_bsid,
       lt_drcrnote1   type TABLE OF ty_bsid,

       ls_sales      type ty_bsid,
       ls_collection TYPE ty_bsid,
       ls_drcrnote   type ty_bsid,


       ls_sales1      type ty_bsid,
       ls_collection1 TYPE ty_bsid,
       ls_drcrnote1   type ty_bsid,

       lt_kna1 TYPE TABLE OF ty_kna1,
       ls_kna1  type ty_kna1,

       lt_bkpf type TABLE OF ty_bkpf,
       ls_bkpf  type ty_bkpf,

       lt_final TYPE TABLE OF ty_final,
       ls_final type ty_final,

       it_final TYPE TABLE OF final,
       wa_final type final,

       t_final TYPE TABLE OF final,
       l_final type final,

       lt_knb1 TYPE TABLE OF ty_knb1,
       ls_knb1 TYPE ty_knb1.

DATA : lv_tabix TYPE sy-tabix,
       lv_end TYPE dmbtr,
       lv_open TYPE dmbtr.

data: lt_keybalance type table of BAPI3007_3 WITH HEADER LINE,
      it_keybalance type table of BAPI3007_3 WITH HEADER LINE,
      lt_return     type bapireturn,
      lv_date type datum,


       lt_kunnr   TYPE TABLE OF ty_linetype WITH HEADER LINE.

DATA : lt_fcat   TYPE slis_t_fieldcat_alv,
       ls_fcat   TYPE slis_fieldcat_alv,
       ls_layout TYPE slis_layout_alv.
ls_layout-zebra = 'X'.

ls_layout-colwidth_optimize = 'X'.

************************* ***************************************************************

************************************************************************
*     S E L E C T I O N - S C R E E N
************************************************************************

SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS : s_bukrs TYPE bsid-bukrs  DEFAULT 'US00' OBLIGATORY.
*SELECT-OPTIONS : s_kunnr FOR bsid-kunnr." OBLIGATORY.
SELECT-OPTIONS : s_budat FOR bsid-budat OBLIGATORY.
SELECTION-SCREEN : END OF BLOCK b1.
*
*SELECTION-SCREEN : BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
*  PARAMETERS : chk AS CHECKBOX .
*SELECTION-SCREEN : END OF BLOCK b2.

START-OF-SELECTION .
perform fetch_Daata.
PERFORM read_data.
*IF chk = 'X'.
PERFORM summery.
PERFORM field.
*ELSE.

*perform fieldctlog.
*perform display_data.
*ENDIF.
*&---------------------------------------------------------------------*
*&      Form  FETCH_DAATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FETCH_DAATA .
*BREAK primus.
SELECT kunnr
       bukrs FROM knb1 INTO TABLE lt_knb1
       WHERE bukrs = s_bukrs.

select bukrs
       kunnr
       budat
       belnr
       buzei
       blart
       dmbtr
       shkzg
       bschl
       umskz
       rebzg from bsid into TABLE lt_bsid
       WHERE bukrs = s_bukrs  and budat in s_budat
       AND blart in ('RV','DZ','AB','DR','DG','DA','UE').


select bukrs
       kunnr
       budat
       belnr
       buzei
       blart
       dmbtr
       shkzg
       bschl
       umskz
       rebzg from bsad APPENDING CORRESPONDING FIELDS OF TABLE lt_bsid
       WHERE bukrs = s_bukrs
       and budat in s_budat and blart in ('RV','DZ','AB','DR','DG','DA','UE').



select kunnr
       name1 from kna1 into TABLE lt_kna1
       FOR ALL ENTRIES IN lt_bsid
       where kunnr = lt_bsid-kunnr.

select bukrs
       belnr
       budat
       stblg
       blart from bkpf INTO TABLE lt_bkpf
       FOR ALL ENTRIES IN lt_bsid
       where bukrs = lt_bsid-bukrs
       and belnr = lt_bsid-belnr  .



move lt_bsid to lt_refund.
move lt_bsid to lt_cash.
move lt_bsid to lt_other.

DELETE lt_other WHERE blart NE 'DZ' AND blart NE 'UE'." AND blart NE 'AB' AND blart NE 'DA' .
delete lt_refund where blart NE 'DZ'  .
delete lt_cash where blart NE 'DZ' AND blart NE 'DA'. "AND blart NE 'AB'  .

IF lt_refund IS NOT INITIAL.
 SELECT bukrs
        kunnr
        augbl
        budat
        belnr
        buzei
        blart
        dmbtr
        sknto
        shkzg
        bschl
        umskz FROM bsad INTO TABLE lt_bsad
        FOR ALL ENTRIES IN lt_refund
        WHERE augbl = lt_refund-belnr.
*          AND buzei = lt_refund-buzei.


ENDIF.

IF lt_cash IS NOT INITIAL.

SELECT bukrs
        kunnr
        augbl
        budat
        belnr
        buzei
        blart
        dmbtr
        sknto
        shkzg
        bschl
        umskz FROM bsad INTO TABLE lt_cash_bsad
        FOR ALL ENTRIES IN lt_cash
        WHERE augbl = lt_cash-belnr.
*          AND umskz NE ' '.
*          AND buzei = lt_cash-buzei.

select bukrs
       kunnr
       budat
       belnr
       buzei
       blart
       dmbtr
       shkzg
       bschl
       umskz
       rebzg from bsid into TABLE lt_cash_bsid
       FOR ALL ENTRIES IN lt_cash
       WHERE belnr = lt_cash-belnr
         AND buzei = lt_cash-buzei
         AND  blart = 'DZ'.

ENDIF.

IF lt_cash_bsid IS NOT INITIAL.
select bukrs
       kunnr
       budat
       belnr
       buzei
       blart
       dmbtr
       shkzg
       bschl
       umskz
       rebzg from bsid into TABLE lt_cash_bsid1
       FOR ALL ENTRIES IN lt_cash_bsid
       WHERE belnr = lt_cash_bsid-rebzg.
*         AND buzei = lt_cash_bsid-buzei.

ENDIF.


IF lt_other IS NOT INITIAL.

SELECT bukrs
        kunnr
        augbl
        budat
        belnr
        buzei
        blart
        dmbtr
        sknto
        shkzg
        bschl
        umskz FROM bsad INTO TABLE lt_other_bsad
        FOR ALL ENTRIES IN lt_other
        WHERE augbl = lt_other-belnr
*          AND buzei = lt_other-buzei
          AND umskz NE ' '.


select bukrs
       kunnr
       budat
       belnr
       buzei
       blart
       dmbtr
       shkzg
       bschl
       umskz from bsid into TABLE lt_other_bsid
       FOR ALL ENTRIES IN lt_other
       WHERE belnr = lt_other-belnr
*         AND buzei = lt_other-buzei
         AND umskz NE ' '.


ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  READ_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM READ_DATA .

lv_Date = s_budat-low - 1 .
move lt_bsid to lt_sales.
move lt_bsid to lt_credit.
delete lt_sales where blart NE 'RV' AND blart NE 'DR' AND blart NE 'UE'.
delete lt_credit where blart NE 'DG' AND blart NE 'UE' .

delete lt_sales where bschl NE '01'.
delete lt_credit where bschl NE '11' .

LOOP AT lt_knb1 INTO ls_knb1.

CALL FUNCTION 'BAPI_AR_ACC_GETKEYDATEBALANCE'
  EXPORTING
    COMPANYCODE        = s_bukrs
    CUSTOMER           = ls_knb1-kunnr
    KEYDATE            = lv_date
*   BALANCESPGLI       = 'X'
*   NOTEDITEMS         = 'X'
 IMPORTING
   RETURN              = lt_return
  TABLES
    KEYBALANCE         = lt_keybalance
          .
*BREAK primus.
 read table  lt_keybalance with KEY currency = 'USD'.
 IF sy-subrc = 0.
   ls_final-opening_bal = ls_final-opening_bal + lt_keybalance-lc_bal.

 ENDIF.


CALL FUNCTION 'BAPI_AR_ACC_GETKEYDATEBALANCE'
  EXPORTING
    COMPANYCODE        = s_bukrs
    CUSTOMER           = ls_knb1-kunnr
    KEYDATE            = lv_date
   BALANCESPGLI       = 'X'
*   NOTEDITEMS         = 'X'
 IMPORTING
   RETURN              = lt_return
  TABLES
    KEYBALANCE         = it_keybalance
          .



read table  it_keybalance with KEY currency = 'USD' SP_GL_IND = 'A' .
IF sy-subrc = 0.

   gl_balan = gl_balan - it_keybalance-lc_bal.

ENDIF.



ENDLOOP.

ls_final-opening_bal = ls_final-opening_bal + gl_balan.

lv_open = ls_final-opening_bal.

SORT lt_bsad ASCENDING by augbl.
SORT lt_bsid ASCENDING by budat belnr.

LOOP AT lt_bsid INTO ls_bsid .
lv_tabix = sy-tabix.
  ls_final-belnr = ls_bsid-belnr.
  ls_final-buzei = ls_bsid-buzei.
  ls_final-kunnr = ls_bsid-kunnr.
  ls_final-budat = ls_bsid-budat.
  ls_final-blart = ls_bsid-blart.

CASE ls_bsid-shkzg.
  WHEN 'S'.
    ls_final-debit = ls_bsid-dmbtr.
    ls_final-total_amt = ls_bsid-dmbtr.
  WHEN 'H'.
    ls_final-credit = ls_bsid-dmbtr.
    ls_final-total_amt = - ls_bsid-dmbtr.

ENDCASE.

*IF ls_bsid-umskz = 'A'.
*  CASE ls_bsid-shkzg.
*    WHEN 'S'.
*      ls_final-other_dep = ls_bsid-dmbtr.
*    WHEN 'H'.
*      ls_final-other_dep = - ls_bsid-dmbtr.
*
*  ENDCASE.
*
*ENDIF.

READ TABLE lt_sales INTO ls_sales WITH KEY belnr = ls_bsid-belnr." buzei = ls_bsid-buzei .
IF sy-subrc = 0.
  READ TABLE lt_bkpf INTO ls_bkpf WITH KEY belnr = ls_sales-belnr.
  IF ls_bkpf-stblg IS INITIAL.

    ls_final-sales_bal = ls_sales-dmbtr.

  ENDIF.

ENDIF.

READ TABLE lt_credit INTO ls_credit WITH KEY belnr = ls_bsid-belnr." buzei = ls_bsid-buzei .
IF sy-subrc = 0.
  READ TABLE lt_bkpf INTO ls_bkpf WITH KEY belnr = ls_credit-belnr.
  IF ls_bkpf-stblg IS INITIAL.
    IF ls_credit-shkzg = 'H'.
      ls_final-credit_bal = - ls_credit-dmbtr.
    ELSE.
      ls_final-credit_bal =  ls_credit-dmbtr.
    ENDIF.


  ENDIF.
ENDIF.
********************************Customer Refund & Discount ****************************
READ TABLE lt_refund INTO ls_refund WITH KEY belnr = ls_bsid-belnr." buzei = ls_bsid-buzei .
IF sy-subrc = 0.
  READ TABLE lt_bkpf INTO ls_bkpf WITH KEY belnr = ls_refund-belnr.
  IF ls_bkpf-stblg IS INITIAL.
    LOOP AT lt_bsad INTO ls_bsad WHERE augbl = ls_refund-belnr." AND  buzei = ls_refund-buzei .
     IF ls_bsad-blart = 'DG' OR ls_bsad-blart = 'UE'." AND ls_bsad-bschl = '11'.

       IF ls_bsad-bschl = '11'.
         IF ls_bsad-shkzg = 'H'.
         ls_final-cust_ref = - ls_bsad-dmbtr + ls_final-cust_ref.
         ELSE.
         ls_final-cust_ref = ls_bsad-dmbtr + ls_final-cust_ref.
         ENDIF.
       ENDIF.

     ENDIF.
     IF ls_bsad-blart = 'DZ'.
       ls_final-discount = ls_final-discount + ls_bsad-sknto.
     ENDIF.

    ENDLOOP.

*  READ TABLE lt_bsad INTO ls_bsad WITH KEY augbl = ls_refund-belnr.
*  IF sy-subrc = 0.
*    ls_final-discount = ls_bsad-sknto.
*
*  ENDIF.
  ENDIF.
ENDIF.
*************************************************************************


***************************************	Cash Receipts  **********************************



READ TABLE lt_cash INTO ls_cash WITH KEY belnr = ls_bsid-belnr." buzei = ls_bsid-buzei.
IF sy-subrc = 0.
  READ TABLE lt_bkpf INTO ls_bkpf WITH KEY belnr = ls_cash-belnr.
  IF ls_bkpf-stblg IS INITIAL.

  LOOP AT lt_cash_bsad INTO ls_cash_bsad WHERE augbl = ls_cash-belnr." AND buzei = ls_cash-buzei.
   IF sy-subrc = 0.
   IF ls_cash_bsad-blart = 'DR' OR ls_cash_bsad-blart = 'RV' OR ls_cash_bsad-blart = 'UE'." AND ls_cash_bsad-bschl = '01'.

    IF ls_cash_bsad-bschl = '01'.
      IF ls_cash_bsad-shkzg = 'H'.
       ls_final-cash_rec = - ls_cash_bsad-dmbtr + ls_final-cash_rec.
      ELSE.
        ls_final-cash_rec = ls_cash_bsad-dmbtr + ls_final-cash_rec.
      ENDIF.
    ENDIF.

    ENDIF.

   ENDIF.
  ENDLOOP.

  LOOP AT lt_cash_bsid INTO ls_cash_bsid WHERE belnr = ls_cash-belnr AND buzei = ls_bsid-buzei ."AND buzei = ls_cash-buzei.
    IF ls_cash_bsid-rebzg IS NOT INITIAL.
      IF ls_cash_bsid-shkzg = 'H'.
       ls_final-cash_rec = - ls_cash_bsid-dmbtr .
      ELSE.
       ls_final-cash_rec = ls_cash_bsid-dmbtr .
      ENDIF.
    ENDIF.

*  LOOP AT lt_cash_bsid INTO ls_cash_bsid WHERE belnr = ls_cash-belnr ."AND buzei = ls_cash-buzei.
*    IF ls_cash_bsid-rebzg IS NOT INITIAL.
*      IF ls_cash_bsid-shkzg = 'H'.
*       ls_final-cash_rec = - ls_cash_bsid-dmbtr + ls_final-cash_rec.
*      ELSE.
*       ls_final-cash_rec = ls_cash_bsid-dmbtr + ls_final-cash_rec.
*      ENDIF.
*    ENDIF.
*   LOOP AT lt_cash_bsid1 INTO ls_cash_bsid1 WHERE belnr = ls_cash_bsid-rebzg." AND buzei = ls_cash_bsid-buzei.
*
*
*   IF ls_cash_bsid1-blart = 'DR' OR ls_cash_bsid1-blart = 'RV' OR ls_cash_bsid1-blart = 'UE'." AND ls_cash_bsid1-bschl = '01'.
*     IF ls_cash_bsid1-bschl = '01'.
*       IF ls_cash_bsid1-shkzg = 'H'.
*       ls_final-cash_rec = - ls_cash_bsid1-dmbtr + ls_final-cash_rec.
*       ELSE.
*       ls_final-cash_rec = ls_cash_bsid1-dmbtr + ls_final-cash_rec.
*       ENDIF.
*     ENDIF.
*
*   ENDIF.
*   ENDLOOP.
  ENDLOOP.

  ENDIF.
*  IF ls_final-cash_rec IS INITIAL.
*   IF ls_cash-umskz IS INITIAL.
*
*
*    IF ls_cash-shkzg = 'H'.
*      ls_final-cash_rec = - ls_cash-dmbtr.
*    ELSE.
*      ls_final-cash_rec =  ls_cash-dmbtr.
*    ENDIF.
*   ENDIF.
*  ENDIF.

ENDIF.
*BREAK-POINT.

IF ls_bsid-blart = 'DZ' AND ls_bsid-umskz = 'A'." AND ls_bsad-bschl NE '09' AND ls_bsad-bschl NE '01'.
      ls_final-cash_rec = ls_bsid-dmbtr." - ls_final-cash_rec.
ENDIF.


ls_final-cash_rec = ls_final-cash_rec - ls_final-discount.
***********************************************************************************

**************************************Other Deposits******************************

READ TABLE lt_other INTO ls_other WITH KEY belnr = ls_bsid-belnr." buzei = ls_bsid-buzei.
IF sy-subrc = 0.
  LOOP AT lt_other_bsid INTO ls_other_bsid WHERE belnr = ls_other-belnr." AND buzei = ls_other-buzei.
*   IF ls_other_bsid-blart = 'DZ' OR ls_other_bsid-blart = 'UE'." AND ls_other_bsid-bschl = '19'.

     IF ls_other_bsid-bschl = '19'.
       IF ls_other_bsid-shkzg = 'H'.
       ls_final-other_dep = - ls_other_bsid-dmbtr + ls_final-other_dep.
       ELSE.
       ls_final-other_dep =  ls_other_bsid-dmbtr + ls_final-other_dep.
       ENDIF.
     ENDIF.

*   ENDIF.

*   IF ls_other_bsid-blart = 'DZ' OR ls_other_bsid-blart = 'DA'." AND ls_other_bsid-bschl = '9'.
*
*     IF ls_other_bsid-bschl = '09'.
*       IF ls_other_bsid-shkzg = 'H'.
*       ls_final-other_dep = - ls_other_bsid-dmbtr + ls_final-other_dep.
*       ELSE.
*       ls_final-other_dep =  ls_other_bsid-dmbtr + ls_final-other_dep.
*       ENDIF.
*     ENDIF.

*   ENDIF.

  ENDLOOP.
*
*  LOOP AT lt_other_bsad INTO ls_other_bsad WHERE augbl = ls_other-belnr.
*    IF ls_other_bsad-blart = 'AB' OR ls_other_bsad-blart = 'DA'." AND ls_other_bsad-bschl = '09'.
*
*     IF ls_other_bsad-bschl = '09'.
*       IF ls_other_bsad-shkzg = 'H'.
*       ls_final-other_dep = - ls_other_bsad-dmbtr + ls_final-other_dep.
*       ELSE.
*       ls_final-other_dep =  ls_other_bsad-dmbtr + ls_final-other_dep.
*       ENDIF.
*     ENDIF.
*
*
*    ENDIF.
*  ENDLOOP.
ENDIF.


**********************************************************************************

IF lv_tabix NE 1.
ls_final-opening_bal = lv_end.
ENDIF.

  ls_final-end_bal = ls_final-opening_bal + ls_final-sales_bal + ls_final-credit_bal
                      - ls_final-cust_ref - ls_final-cash_rec - ls_final-discount.

  ls_final-tot_dep = ls_final-cust_ref + ls_final-cash_rec + ls_final-other_dep.

  ls_final-variance = ls_final-cust_ref + ls_final-cash_rec - ls_final-tot_dep.

*IF lv_tabix = 1.
*ls_final-opening_bal = ls_final-opening_bal.
*ENDIF.
*on change of ls_final-belnr.
*IF lv_tabix N  E 1.
**IF sy-index = 2.
*ls_final-opening_bal = lv_end.
*ENDIF.
lv_end = ls_final-end_bal.
*endon.
APPEND ls_final TO lt_final.
CLEAR: ls_final,ls_cash,ls_bsid,ls_cash_bsad,ls_cash_bsid.
ENDLOOP.




ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM FIELDCTLOG .

DATA lv_pos TYPE i VALUE 1.

  ls_fcat-col_pos     = lv_pos.
  ls_fcat-fieldname   = 'KUNNR'.
  ls_fcat-seltext_l   = 'Customer Code'.
  ls_fcat-outputlen   = '10'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'BLART'.
  ls_fcat-seltext_l   = 'Document Type'.
  ls_fcat-outputlen   = '10'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'BELNR'.
  ls_fcat-seltext_l   = 'Document No'.
  ls_fcat-outputlen   = '10'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.


  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'BUZEI'.
  ls_fcat-seltext_l   = 'Item No'.
  ls_fcat-outputlen   = '10'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'BUDAT'.
  ls_fcat-seltext_l   = 'Posting Date'.
  ls_fcat-outputlen   = '10'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.


  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'NAME1'.
  ls_fcat-seltext_l   = 'Customer Name'.
  ls_fcat-outputlen   = '35'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

   ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'OPENING_BAL'.
  ls_fcat-seltext_l   = 'Opening Balance'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.


  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'TOTAL_AMT'.
  ls_fcat-seltext_l   = 'Total Amount'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'DEBIT'.
  ls_fcat-seltext_l   = 'Debit Amount'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'CREDIT'.
  ls_fcat-seltext_l   = 'Credit Amount'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

 ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'SALES_BAL'.
  ls_fcat-seltext_l   = 'Sales'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'CREDIT_BAL'.
  ls_fcat-seltext_l   = 'Credit Memo'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'CUST_REF'.
  ls_fcat-seltext_l   = 'Customer Refund'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'CASH_REC'.
  ls_fcat-seltext_l   = 'Cash Receipts'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'DISCOUNT'.
  ls_fcat-seltext_l   = 'Discount'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'END_BAL'.
  ls_fcat-seltext_l   = 'Calculating end bal'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'TOT_DEP'.
  ls_fcat-seltext_l   = 'Total Deposits'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'VARIANCE'.
  ls_fcat-seltext_l   = 'Variance'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'OTHER_DEP'.
  ls_fcat-seltext_l   = 'Other Deposits'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.



ENDFORM.


FORM DISPLAY_DATA .

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
   I_CALLBACK_PROGRAM                = sy-repid
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
   IS_LAYOUT                         = ls_layout
   IT_FIELDCAT                       = lt_fcat
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
   I_DEFAULT                         = 'X'
   I_SAVE                            = 'A'
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    T_OUTTAB                          = lt_final
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SUMMERY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM summery .


LOOP AT lt_final INTO ls_final.
  wa_final-budat = ls_final-budat.
  wa_final-debit = ls_final-debit.
  wa_final-credit = ls_final-credit.
*  wa_final-credit = ls_final-credit.
  wa_final-sales_bal = ls_final-sales_bal.
  wa_final-credit_bal = ls_final-credit_bal.
  wa_final-cust_ref = ls_final-cust_ref.
  wa_final-cash_rec = ls_final-cash_rec.
  wa_final-discount = ls_final-discount.
  wa_final-total_amt = ls_final-total_amt.
  wa_final-tot_dep = ls_final-tot_dep.
  wa_final-other_dep = ls_final-other_dep.

COLLECT wa_final INTO it_final.
ENDLOOP.

LOOP AT it_final INTO wa_final.
   wa_final-opening_bal = lv_open.
   wa_final-end_bal = wa_final-opening_bal + wa_final-sales_bal + wa_final-credit_bal
                      - wa_final-cust_ref - wa_final-cash_rec - wa_final-discount.
lv_open = wa_final-end_bal.
modify it_final FROM wa_final.
ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM field .
DATA lv_pos TYPE i VALUE 1.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'BUDAT'.
  ls_fcat-seltext_l   = 'Posting Date'.
  ls_fcat-outputlen   = '10'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.


   ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'OPENING_BAL'.
  ls_fcat-seltext_l   = 'Opening Balance'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.


  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'TOTAL_AMT'.
  ls_fcat-seltext_l   = 'Total Amount'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'DEBIT'.
  ls_fcat-seltext_l   = 'Debit Amount'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'CREDIT'.
  ls_fcat-seltext_l   = 'Credit Amount'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

 ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'SALES_BAL'.
  ls_fcat-seltext_l   = 'Sales'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'CREDIT_BAL'.
  ls_fcat-seltext_l   = 'Credit Memo'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'CUST_REF'.
  ls_fcat-seltext_l   = 'Customer Refund'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'CASH_REC'.
  ls_fcat-seltext_l   = 'Cash Receipts'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'DISCOUNT'.
  ls_fcat-seltext_l   = 'Discount'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'END_BAL'.
  ls_fcat-seltext_l   = 'Calculating end bal'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'OTHER_DEP'.
  ls_fcat-seltext_l   = 'Other Deposits'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

  ls_fcat-col_pos     = lv_pos + 1.
  ls_fcat-fieldname   = 'TOT_DEP'.
  ls_fcat-seltext_l   = 'Total Deposits'.
  ls_fcat-outputlen   = '13'.
  APPEND ls_fcat TO lt_fcat.
  CLEAR  ls_fcat.

*  ls_fcat-col_pos     = lv_pos + 1.
*  ls_fcat-fieldname   = 'VARIANCE'.
*  ls_fcat-seltext_l   = 'Variance'.
*  ls_fcat-outputlen   = '13'.
*  APPEND ls_fcat TO lt_fcat.
*  CLEAR  ls_fcat.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
   I_CALLBACK_PROGRAM                = sy-repid
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
   IS_LAYOUT                         = ls_layout
   IT_FIELDCAT                       = lt_fcat
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
   I_DEFAULT                         = 'X'
   I_SAVE                            = 'A'
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    T_OUTTAB                          = it_final
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.


ENDFORM.

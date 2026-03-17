*&---------------------------------------------------------------------*
*& Report ZUS_CASHFLOW_PERIOD_RPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_CASHFLOW_PERIOD_RPORT.

*&*========================================================================*
*&* TYPE GROUP
*&*========================================================================*
TYPE-POOLS:slis.
*&*========================================================================*
*&* TABLES
*&*========================================================================*
TABLES:t001,bsas,bkpf.
TYPES: ty_mem_tab TYPE abaplist.

*&*========================================================================*
*&* TYPES & INTERNAL TABLE DECLERATION
*&*========================================================================*
TYPES: BEGIN OF ts_alv,
         particulars TYPE char120,
         descr       TYPE char50,
         amount1     TYPE p DECIMALS 2,
         amount2     TYPE p DECIMALS 2,
         amount4     TYPE p DECIMALS 2,
         amount3     TYPE char20,
         celltab     TYPE lvc_t_styl,
         cellcolor   TYPE slis_t_specialcol_alv, "lvc_t_scol,
       END OF ts_alv,
       tt_alv TYPE TABLE OF ts_alv.
DATA: gt_alv TYPE tt_alv,
      gs_alv TYPE ts_alv.

DATA: wa_skat TYPE skat.

DATA:cellcolor TYPE slis_specialcol_alv.

FIELD-SYMBOLS:<fs_alv> TYPE ts_alv.
ASSIGN gs_alv TO <fs_alv>.

TYPES : BEGIN OF ty_final ,
          year     TYPE bkpf-gjahr,
          item(10),
          head(10),
          descr    TYPE char50,
          amt1     TYPE p DECIMALS 2,
          amt2     TYPE p DECIMALS 2,
        END OF ty_final .

DATA : lt TYPE TABLE OF ty_final,
       ls TYPE ty_final.
DATA : lt1 TYPE TABLE OF ty_final,
       ls1 TYPE ty_final.

DATA : lt_celltab TYPE lvc_t_styl.
DATA : ls_celltab TYPE lvc_s_styl.

DATA: gt_fieldcat TYPE lvc_t_fcat,
      gs_fieldcat TYPE lvc_s_fcat,
      gs_variant  TYPE disvariant,
      gs_layout   TYPE lvc_s_layo.
DATA : year1 TYPE bsas-gjahr .



RANGES : l_gl1 FOR ska1-saknr .
RANGES : l_gl2 FOR ska1-saknr .
RANGES : l_gl3 FOR ska1-saknr .
RANGES : l_gl4 FOR ska1-saknr .
RANGES : l_gl5 FOR ska1-saknr .
RANGES : s_ktopl FOR ska1-ktopl .

TYPES: BEGIN OF ty_asci_tab,
         text(500),
       END OF ty_asci_tab.
DATA: asci_tab TYPE STANDARD TABLE OF ty_asci_tab INITIAL SIZE 0,
      asci_wa  TYPE ty_asci_tab.

DATA: asci_tab1 TYPE STANDARD TABLE OF ty_asci_tab INITIAL SIZE 0,
      asci_wa1  TYPE ty_asci_tab.

DATA : l_bukrs    TYPE skb1-bukrs,
       l_gl       TYPE ska1-saknr,
       l_text     TYPE char20,
       l_bcal(20),"    type RR_UMSAV,
       l_bp(20),"      type FIGLQ_PREVM_BAL ,
       l_dr(20),"     type FIGLQ_PREVM_BAL ,
       l_cr(20),"   type FIGLQ_PREVM_BAL ,
       l_ab(20)."   type FIGLQ_PREVM_BAL .
DATA :  l_len        TYPE i.




DATA : mem_tab       TYPE STANDARD TABLE OF ty_mem_tab INITIAL SIZE 0.
DATA : mem_tab_new   TYPE STANDARD TABLE OF ty_mem_tab INITIAL SIZE 0.
DATA : mem_tab1       TYPE STANDARD TABLE OF ty_mem_tab INITIAL SIZE 0.

DATA: gt_gl TYPE TABLE OF ZUS_CASHFLOW.
DATA: ls_gl TYPE  ZUS_CASHFLOW.

*&*========================================================================*
*&* SELECTION SCREEN
*&*========================================================================*
SELECTION-SCREEN:BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS:bukrs FOR t001-bukrs NO INTERVALS NO-EXTENSION OBLIGATORY,
               gjahr FOR bsas-gjahr NO INTERVALS NO-EXTENSION OBLIGATORY,
               period FOR bkpf-monat  OBLIGATORY.
SELECTION-SCREEN:END OF BLOCK b1.
*&*========================================================================*
*&* INITIALIZATION
*&*========================================================================*
INITIALIZATION.
*&*========================================================================*
*&* AT SELECTION-SCREEN
*&*========================================================================*
AT SELECTION-SCREEN.
  "  validation
*&*========================================================================*
*&* AT SELECTION-SCREEN OUTPUT
*&*========================================================================*
AT SELECTION-SCREEN OUTPUT.
*  auth test division
*  PERFORM auth_check_trans.
*&*========================================================================*
*&* START-OF-SELECTION
*&*========================================================================*
START-OF-SELECTION.

  "  get data

  PERFORM get_data .
  PERFORM get_alv_data TABLES bukrs gjahr.

*&*========================================================================*
*&* END-OF-SELECTION
*&*========================================================================*
END-OF-SELECTION.

  PERFORM gernerate_ouput TABLES gt_alv.
*&---------------------------------------------------------------------*
*& Form GET_ALV_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> BUKRS
*&      --> GJAHR
*&---------------------------------------------------------------------*
FORM get_alv_data  TABLES    p_bukrs
                            p_gjahr.



  <fs_alv>-particulars = 'CASH FLOWS FROM OPERATING ACTIVITIES'.
  ls_celltab-style = '00000121'.                            "00000121
  INSERT ls_celltab INTO TABLE lt_celltab.
  <fs_alv>-amount3 = 'P01'.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '4'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour
*  <fs_alv>-cellcolor = 'C411'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  REFRESH:lt_celltab,<fs_alv>-celltab[].
  DATA : t_pl TYPE p DECIMALS 2.
  DATA : TOT TYPE p DECIMALS 2.
  DATA : TOT2 TYPE p DECIMALS 2.
  DATA : t_pl2 TYPE p DECIMALS 2,
           cross TYPE p DECIMALS 2,
         cross1 TYPE p DECIMALS 2,
         net TYPE p DECIMALS 2,
         net1 TYPE p DECIMALS 2.
*BREAK-POINT .BREAK primus.

  LOOP AT lt INTO ls WHERE head =  'P01' .
*    IF ls-year EQ gjahr-low .
      <fs_alv>-amount1 = ls-amt1 + <fs_alv>-amount1.
*    ELSE.
      <fs_alv>-amount2 = ls-amt2 +  <fs_alv>-amount2.
      <fs_alv>-amount4 =  ls-amt2 - ls-amt1.
*    ENDIF.
ENDLOOP .
  IF <fs_alv>-amount1 LT 0 .
    <fs_alv>-amount1 = <fs_alv>-amount1 * -1 .
*  ELSE.
*    <fs_alv>-amount1 = <fs_alv>-amount1 * -1 .
  ENDIF.
  IF <fs_alv>-amount2 LT 0 .
    <fs_alv>-amount2 = <fs_alv>-amount2 * -1 .
*  ELSE .
*    <fs_alv>-amount2 = <fs_alv>-amount2 * -1 .
  ENDIF.

  IF <fs_alv>-amount4 LT 0 .
    <fs_alv>-amount4 = <fs_alv>-amount4 * -1 .
  ENDIF.

  t_pl = <fs_alv>-amount1 .
  t_pl2 = <fs_alv>-amount2 .

  <fs_alv>-particulars = 'NET INCOME'.
  <fs_alv>-amount1 =  <fs_alv>-amount1.
  <fs_alv>-amount2 =   <fs_alv>-amount2.
 <fs_alv>-amount3 = '101'.

  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '3'.
  cellcolor-color-int = '0'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '0'.  "1 = text colour, 0 = background colour

  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = ' '.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-amount4.

  REFRESH:lt_celltab,<fs_alv>-celltab[].
  APPEND INITIAL LINE TO gt_alv.
  APPEND INITIAL LINE TO gt_alv.

  <fs_alv>-particulars = 'ADJUSTMENTS TO RECONSILE NET INCOME TO NET CASH PROVIDED BY OPERATING ACTIVITIES'."'Increase/decrease In Working Capital'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.                            "00000121

  INSERT ls_celltab INTO TABLE lt_celltab.
  <fs_alv>-amount1 = ''.
  ls_celltab-fieldname = 'AMOUNT1'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  <fs_alv>-amount2 = ''.
  ls_celltab-fieldname = 'AMOUNT2'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  <fs_alv>-amount3 = 'P02'.
  ls_celltab-fieldname = 'AMOUNT3'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '4'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour

  APPEND cellcolor TO <fs_alv>-cellcolor.
*  <fs_alv>-cellcolor = 'C411'.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].
  REFRESH:lt_celltab,<fs_alv>-celltab[].


  DELETE lt WHERE item = '101' .
  DELETE lt WHERE item = '102' .
  DELETE  lt WHERE item = '104' .
  DELETE  lt WHERE item = '105' .
*SORT lt by item.
******************************************P02*********************************
  LOOP AT lt INTO ls WHERE head =  'P02' .
  CLEAR:wa_skat.

  SELECT SINGLE * FROM skat INTO wa_skat WHERE SPRAS = 'E' AND ktopl = '1000' AND saknr = ls-item.
      IF sy-subrc = 0.
        <fs_alv>-descr = wa_skat-txt50.
      ENDIF.
**
*    IF ls-year EQ gjahr-low.
**      <fs_alv>-amount1 =  <fs_alv>-amount1 + ( ls-amt1 - ls-amt2 ).
*      <fs_alv>-amount1 =   ls-amt1." - ls-amt2 .
*    ELSE.
**      <fs_alv>-amount2 = <fs_alv>-amount2 + ( ls-amt2 - ls-amt1 ).
*      <fs_alv>-amount2 =  ls-amt2." - ls-amt1 .
*    ENDIF.
   <fs_alv>-amount1 =   ls-amt1." - ls-amt2 .
   <fs_alv>-amount2 =  ls-amt2." - ls-amt1 .
   <fs_alv>-particulars = ls-item.
   <fs_alv>-amount4 =  ls-amt2 - ls-amt1.
*  ENDLOOP .
*IF <fs_alv>-amount1 LT 0 .
*    <fs_alv>-amount1 = <fs_alv>-amount1 * -1 .
*  ELSE.
*    <fs_alv>-amount1 = <fs_alv>-amount1 * -1 .
*  ENDIF.
*  IF <fs_alv>-amount2 LT 0 .
*    <fs_alv>-amount2 = <fs_alv>-amount2 * -1 .
*  ELSE .
*    <fs_alv>-amount2 = <fs_alv>-amount2 * -1 .
*
*  ENDIF.
  """""""""""""""""""""""""""""""
  TOT =  TOT + <fs_alv>-amount1 .
  TOT2 =   TOT2 + <fs_alv>-amount2  .

  """"""""""""""""""""""""""""""""""'

  <fs_alv>-particulars = <fs_alv>-particulars."'(Increase)/Decrease In Trade Receivables'.
  <fs_alv>-amount1 = <fs_alv>-amount1.
  <fs_alv>-amount2 = <fs_alv>-amount2.
  <fs_alv>-amount4 = <fs_alv>-amount4.
   <fs_alv>-amount3 = '201'.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '3'.
  cellcolor-color-int = '0'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '0'.  "1 = text colour, 0 = background colour

  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = ' '.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].


*  APPEND INITIAL LINE TO gt_alv.
endloop.

  """""""""""""""""'
  T_PL = T_PL + TOT .
  T_PL2 = T_PL2 + TOT2.

  """""""""""""""'
  <fs_alv>-particulars = 'TOTAL ADJUSTMENTS'."INCREASE/DECREASE IN WORKING CAPITAL'.
  <fs_alv>-amount1 = TOT.
  <fs_alv>-amount2 = TOT2.
  <fs_alv>-amount4 = tot2 - tot.
  <fs_alv>-descr   = ''.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '6'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour
*  <fs_alv>-cellcolor = 'C411'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.

  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].
CLEAR : TOT , TOT2 .
  APPEND INITIAL LINE TO gt_alv.
  APPEND INITIAL LINE TO gt_alv.

**********************************************P03****************************************

  <fs_alv>-particulars = 'CASH FLOW FROM INVESTING ACTIVITIES'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.                            "00000121
  INSERT ls_celltab INTO TABLE lt_celltab.
*  <fs_alv>-amount1 = 'Amount'.
  ls_celltab-fieldname = 'AMOUNT1'.
  INSERT ls_celltab INTO TABLE lt_celltab.
*  <fs_alv>-amount2 = 'Amount'.
  ls_celltab-fieldname = 'AMOUNT2'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  <fs_alv>-amount3 = 'P03'.
  ls_celltab-fieldname = 'AMOUNT3'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '4'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour

  APPEND cellcolor TO <fs_alv>-cellcolor.

  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor,ls_celltab.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].


  DELETE lt WHERE   item = '201' .
  DELETE lt WHERE item = '202' .
  DELETE  lt WHERE item = '203' .
  DELETE  lt WHERE item = '204' .
  DELETE  lt WHERE item = '205' .
  DELETE  lt WHERE item = '206' .
  DELETE  lt WHERE item = '207' .
  DELETE  lt WHERE item = '208' .
  DELETE  lt WHERE item = '209' .
  DELETE  lt WHERE item = '210' .
  DELETE  lt WHERE item = '211' .

  LOOP AT lt INTO ls WHERE head =  'P03' .
  CLEAR:wa_skat.

  SELECT SINGLE * FROM skat INTO wa_skat WHERE SPRAS = 'E' AND ktopl = '1000' AND saknr = ls-item.
      IF sy-subrc = 0.
        <fs_alv>-descr = wa_skat-txt50.
      ENDIF.

*    IF ls-year EQ gjahr-low.
*      <fs_alv>-amount1 =  <fs_alv>-amount1 +  ls-amt1 .
      <fs_alv>-amount1 =    ls-amt1 .
*    ELSE.
*      <fs_alv>-amount2 = <fs_alv>-amount2 +  ls-amt2 .
      <fs_alv>-amount2 =  ls-amt2 .
      <fs_alv>-amount4 =  ls-amt2 - ls-amt1.
*    ENDIF.
    <fs_alv>-particulars = ls-item.
*  ENDLOOP .
*   IF <fs_alv>-amount1 LT 0 .
*    <fs_alv>-amount1 = <fs_alv>-amount1 * -1 .
*  ELSE.
*    <fs_alv>-amount1 = <fs_alv>-amount1 * -1 .
*  ENDIF.
*  IF <fs_alv>-amount2 LT 0 .
*    <fs_alv>-amount2 = <fs_alv>-amount2 * -1 .
*  ELSE .
*    <fs_alv>-amount2 = <fs_alv>-amount2 * -1 .
*
*  ENDIF.

  """""""""""""""""""""""""""""""
  TOT =  TOT + <fs_alv>-amount1 .
  TOT2 =   TOT2 + <fs_alv>-amount2  .

  """"""""""""""""""""""""""""""""""'
  <fs_alv>-particulars = <fs_alv>-particulars.  "'Increase/(Decrease) In Share Capital'.
  <fs_alv>-amount1 = <fs_alv>-amount1.
  <fs_alv>-amount2 = <fs_alv>-amount2.
  <fs_alv>-amount4 = <fs_alv>-amount4.
  <fs_alv>-amount3 = '301'.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '3'.
  cellcolor-color-int = '0'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '0'.  "1 = text colour, 0 = background colour

  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = ' '.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor,ls_celltab.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].




*  APPEND INITIAL LINE TO gt_alv.
ENDLOOP.



  T_PL = T_PL + TOT .
  T_PL2 = T_PL2 + TOT2 .

  """""""""""""""'
  <fs_alv>-particulars = 'TOTAL CASH FLOW FROM INVESTING ACTIVITIES'.
  <fs_alv>-amount1 = TOT.
  <fs_alv>-amount2 = TOT2.
  <fs_alv>-amount4 = tot2 - tot.
*  <fs_alv>-descr   = ''.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '6'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour
*  <fs_alv>-cellcolor = 'C411'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.

  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].
CLEAR : TOT ,TOT2 .

  APPEND INITIAL LINE TO gt_alv.
  APPEND INITIAL LINE TO gt_alv.
****************************************P04*************************************

  <fs_alv>-particulars = 'CASH FLOW FROM FINANCIAL ACTIVITIES'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.                            "00000121
  INSERT ls_celltab INTO TABLE lt_celltab.
*  <fs_alv>-amount1 = ''.
  ls_celltab-fieldname = 'AMOUNT1'.
  INSERT ls_celltab INTO TABLE lt_celltab.
*  <fs_alv>-amount2 = ''.
  ls_celltab-fieldname = 'AMOUNT2'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  <fs_alv>-amount3 = 'P04'.
  ls_celltab-fieldname = 'AMOUNT3'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '4'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour

  APPEND cellcolor TO <fs_alv>-cellcolor.
*  <fs_alv>-cellcolor = 'C411'.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor,ls_celltab.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].



  DELETE lt WHERE   item = '301' .
  DELETE lt WHERE item = '302' .
  DELETE  lt WHERE item = '303' .
  DELETE  lt WHERE item = '304' .
  DELETE  lt WHERE item = '305' .
  DELETE  lt WHERE item = '306' .
  DELETE  lt WHERE item = '307' .
  DELETE  lt WHERE item = '308' .
  DELETE  lt WHERE item = '309' .
  DELETE  lt WHERE item = '310' .
  DELETE  lt WHERE item = '311' .

  LOOP AT lt INTO ls WHERE head =  'P04' .

  CLEAR:wa_skat.

  SELECT SINGLE * FROM skat INTO wa_skat WHERE SPRAS = 'E' AND ktopl = '1000' AND saknr = ls-item.
      IF sy-subrc = 0.
        <fs_alv>-descr = wa_skat-txt50.
      ENDIF.

*    IF ls-year EQ gjahr-low.
*      <fs_alv>-amount1 =  <fs_alv>-amount1 + ls-amt1 .
      <fs_alv>-amount1 =   ls-amt1 .
*    ELSE.
*      <fs_alv>-amount2 = <fs_alv>-amount2 +  ls-amt2 .
      <fs_alv>-amount2 = ls-amt2 .
      <fs_alv>-amount4 =  ls-amt2 - ls-amt1.
*    ENDIF.
   <fs_alv>-particulars = ls-item.

*   IF <fs_alv>-amount1 LT 0 .
*    <fs_alv>-amount1 = <fs_alv>-amount1 * -1 .
*  ELSE.
*    <fs_alv>-amount1 = <fs_alv>-amount1 * -1 .
*  ENDIF.
*  IF <fs_alv>-amount2 LT 0 .
*    <fs_alv>-amount2 = <fs_alv>-amount2 * -1 .
*  ELSE .
*    <fs_alv>-amount2 = <fs_alv>-amount2 * -1 .
*
*  ENDIF.

    """""""""""""""""""""""""""""""
  TOT =  TOT + <fs_alv>-amount1 .
  TOT2 =   TOT2 + <fs_alv>-amount2  .

  """"""""""""""""""""""""""""""""""'

  <fs_alv>-particulars = <fs_alv>-particulars."'(Increase)/Decrease Repayment Of Sales Tax Deffered Liabilities'.
  <fs_alv>-amount1 = <fs_alv>-amount1.
  <fs_alv>-amount2 = <fs_alv>-amount2.
  <fs_alv>-amount4 = <fs_alv>-amount4.
  <fs_alv>-amount3 = '401'.

  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '3'.
  cellcolor-color-int = '0'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '0'.  "1 = text colour, 0 = background colour

  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = ' '.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].





ENDLOOP .

  """""""""""""""""'
   T_PL = T_PL + TOT .
  T_PL2 = T_PL2 + TOT2 .

  """""""""""""""'
  <fs_alv>-particulars = 'TOTAL CASH FLOW FROM FINANCING ACTIVITIES'.
  <fs_alv>-amount1 = TOT.
  <fs_alv>-amount2 = TOT2.
  <fs_alv>-amount4 = tot2 - tot.
  <fs_alv>-descr   = ''.

  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '6'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour
*  <fs_alv>-cellcolor = 'C411'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.

  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].
  CLEAR : TOT , TOT2 .

  APPEND INITIAL LINE TO gt_alv.
  APPEND INITIAL LINE TO gt_alv.

  net = T_PL.
  net1 = T_PL2.

  <fs_alv>-particulars = 'Net Increase/decrease In Cash & Cash Equivalents'.
  .
  <fs_alv>-amount1 = T_PL.
  <fs_alv>-amount2 = T_PL2.
  <fs_alv>-amount4 = t_pl2 - t_pl.

  <fs_alv>-amount3 = 'P05'.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '4'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.
  ls_celltab-fieldname = 'PARTICULARS'.
 ls_celltab-style = '00000121'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  ls_celltab-fieldname = 'AMOUNT3'.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2,<fs_alv>-descr,<fs_alv>-amount3,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].
CLEAR : T_PL , T_PL2 .
*  APPEND INITIAL LINE TO gt_alv.
*  APPEND INITIAL LINE TO gt_alv.
"""""""""""""""""""""""""""""""""'

  LOOP AT lt INTO ls WHERE head =  'P05' ..
   CLEAR:wa_skat.

  SELECT SINGLE * FROM skat INTO wa_skat WHERE SPRAS = 'E' AND ktopl = '1000' AND saknr = ls-item.
      IF sy-subrc = 0.
        <fs_alv>-descr = wa_skat-txt50.
      ENDIF.

*    IF ls-year EQ gjahr-low.
*      <fs_alv>-amount1 =  <fs_alv>-amount1 +  ls-amt2." - ls-amt2 ).
      <fs_alv>-amount1 =  ls-amt1." - ls-amt2 ).
*    ELSE.
      <fs_alv>-amount2 =  ls-amt2 ."- ls-amt1 ).
      <fs_alv>-amount4 =  ls-amt2 - ls-amt1.
*      <fs_alv>-amount2 = <fs_alv>-amount2 +  ls-amt1 ."- ls-amt1 ).
*    ENDIF.
    <fs_alv>-particulars = ls-item.

T_PL = T_PL + <fs_alv>-amount1 .
T_PL2 = T_PL2 + <fs_alv>-amount2.

  """""""""""""""""""""""""""""""
  <fs_alv>-particulars = <fs_alv>-particulars."'Opening Balance Of Cash & Cash Equivalents'.
  <fs_alv>-amount1 = <fs_alv>-amount1.
  <fs_alv>-amount2 = <fs_alv>-amount2.
  <fs_alv>-amount4 = <fs_alv>-amount4.
  <fs_alv>-amount3 = '501'.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '3'.
  cellcolor-color-int = '0'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '0'.  "1 = text colour, 0 = background colour

  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = ' '.
  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2 ,  <fs_alv>-amount3,<fs_alv>-descr,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].

""""""""""""""""""""""""""""""""""""""""'''

*  APPEND INITIAL LINE TO gt_alv.
*  APPEND INITIAL LINE TO gt_alv.
  ENDLOOP .
"""""""""""""""""""""""""""""""""""""""""""""""""""""

<fs_alv>-particulars = 'CLOSING BALANCE OF CASH & CASH EQUIVALENTS'.
  <fs_alv>-amount1 = T_PL.
  <fs_alv>-amount2 = T_PL2.
  <fs_alv>-amount4 = t_pl2 - t_pl.
  cross = net + T_PL.
    cross1 = net1 + T_PL2.
  <fs_alv>-descr   = ''.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '4'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour
*  <fs_alv>-cellcolor = 'C411'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.

  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2 ,  <fs_alv>-amount3 ,<fs_alv>-descr,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].
  CLEAR : T_PL , T_PL2 .
*ENDLOOP .
*  UNASSIGN <fs_alv>.

  <fs_alv>-particulars = 'CROSS CHECK'.
  <fs_alv>-amount1 = cross.
  <fs_alv>-amount2 = cross1.
  <fs_alv>-amount4 = cross1 - cross.
  <fs_alv>-descr   = ''.
  cellcolor-fieldname = 'PARTICULARS'.
  cellcolor-color-col = '4'.
  cellcolor-color-int = '1'.  "1 = Intensified on, 0 = Intensified off
  cellcolor-color-inv = '1'.  "1 = text colour, 0 = background colour
*  <fs_alv>-cellcolor = 'C411'.
  ls_celltab-fieldname = 'PARTICULARS'.
  ls_celltab-style = '00000121'.

  INSERT ls_celltab INTO TABLE lt_celltab.
  MOVE lt_celltab[] TO <fs_alv>-celltab[].

  APPEND cellcolor TO <fs_alv>-cellcolor.
  APPEND <fs_alv> TO gt_alv.
  CLEAR:<fs_alv>-cellcolor, cellcolor.
  CLEAR:<fs_alv>-amount1 , <fs_alv>-amount2 ,  <fs_alv>-amount3 ,<fs_alv>-descr,<fs_alv>-amount4.
  REFRESH:lt_celltab,<fs_alv>-celltab[].
  CLEAR : T_PL , T_PL2 .
*ENDLOOP .
*  UNASSIGN <fs_alv>.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GERNERATE_OUPUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_ALV
*&---------------------------------------------------------------------*
FORM gernerate_ouput  TABLES   p_gt_alv STRUCTURE gs_alv.

  PERFORM fieldcat_alv CHANGING gt_fieldcat.

  PERFORM alv_layout CHANGING gs_layout.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER =
*     I_BUFFER_ACTIVE    =
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = 'ALV_BACKGROUND'
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fieldcat
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS_LVC             =
*     IT_SORT_LVC        =
*     IT_FILTER_LVC      =
*     IT_HYPERLINK       =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
     I_SAVE             = 'X'
*     IS_VARIANT         =
*     IT_EVENTS          =
*     IT_EVENT_EXIT      =
*     IS_PRINT_LVC       =
*     IS_REPREP_ID_LVC   =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  =
*     I_HTML_HEIGHT_END  =
*     IT_ALV_GRAPHICS    =
*     IT_EXCEPT_QINFO_LVC               =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = gt_alv
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form FIELDCAT_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GT_FIELDCAT
*&---------------------------------------------------------------------*
FORM fieldcat_alv  CHANGING p_gt_fieldcat TYPE lvc_t_fcat.

  DATA count TYPE i.

  count = count + 1 .
  gs_fieldcat-col_pos   = '1'.
  gs_fieldcat-fieldname = 'PARTICULARS'.
  gs_fieldcat-tabname   = 'GT_ALV'.
  gs_fieldcat-scrtext_l = 'Particulars'.
  gs_fieldcat-no_zero   = 'X'.
*  gs_fieldcat-emphasize   = 'X'.
  gs_fieldcat-outputlen  = '55'.
*  gs_fieldcat-style  = '000002AE'.
  APPEND gs_fieldcat TO p_gt_fieldcat.
  CLEAR gs_fieldcat .

  count = count + 1 .
  gs_fieldcat-col_pos   = count.
  gs_fieldcat-fieldname = 'DESCR'.
  gs_fieldcat-tabname   = 'GT_ALV'.
  gs_fieldcat-scrtext_l = 'GL Description'.
  gs_fieldcat-no_zero   = 'X'.
*  gs_fieldcat-emphasize   = 'X'.
  gs_fieldcat-outputlen  = '55'.
*  gs_fieldcat-style  = '000002AE'.
  APPEND gs_fieldcat TO p_gt_fieldcat.
  CLEAR gs_fieldcat .

  count = count + 1 .
  gs_fieldcat-col_pos   = count.
  gs_fieldcat-fieldname = 'AMOUNT1'.
  gs_fieldcat-tabname   = 'GT_ALV'.
  gs_fieldcat-scrtext_l = period-low. "gjahr-low.
  gs_fieldcat-no_zero   = 'X'.
*  gs_fieldcat-emphasize   = 'X'.
  gs_fieldcat-outputlen  = 'X'.
  APPEND gs_fieldcat TO p_gt_fieldcat.
  CLEAR gs_fieldcat .

*


  count = count + 1 .
  gs_fieldcat-col_pos   = count.
  gs_fieldcat-fieldname = 'AMOUNT2'.
  gs_fieldcat-tabname   = 'GT_ALV'.
  gs_fieldcat-scrtext_l = period-high."gjahr-low - 1.
  gs_fieldcat-no_zero   = 'X'.
*    gs_fieldcat-emphasize   = 'X'.
  gs_fieldcat-outputlen  = 'X'.
  APPEND gs_fieldcat TO p_gt_fieldcat.
  CLEAR gs_fieldcat .

  count = count + 1 .
  gs_fieldcat-col_pos   = count.
  gs_fieldcat-fieldname = 'AMOUNT4'.
  gs_fieldcat-tabname   = 'GT_ALV'.
  gs_fieldcat-scrtext_l = 'Difference'.
  gs_fieldcat-no_zero   = 'X'.
*    gs_fieldcat-emphasize   = 'X'.
  gs_fieldcat-outputlen  = 'X'.
  APPEND gs_fieldcat TO p_gt_fieldcat.
  CLEAR gs_fieldcat .

    count = count + 1 .
  gs_fieldcat-col_pos   = count.
  gs_fieldcat-fieldname = 'AMOUNT3'.
  gs_fieldcat-tabname   = 'GT_ALV'.
  gs_fieldcat-scrtext_l = 'Item Code'.
  gs_fieldcat-no_zero   = 'X'.
*    gs_fieldcat-emphasize   = 'X'.
  gs_fieldcat-outputlen  = 'X'.
  APPEND gs_fieldcat TO p_gt_fieldcat.
  CLEAR gs_fieldcat .
ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- GS_LAYOUT
*&---------------------------------------------------------------------*
FORM alv_layout  CHANGING p_gs_layout TYPE lvc_s_layo.


  p_gs_layout-stylefname = 'CELLTAB'.
  p_gs_layout-ctab_fname = 'CELLCOLOR'.
  p_gs_layout-cwidth_opt = 'X'.
*  p_gs_layout-zebra = 'X'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .


  SELECT * FROM ZUS_CASHFLOW INTO TABLE gt_gl
    WHERE bukrs IN bukrs

    AND indirect EQ 'X'.

  LOOP AT gt_gl INTO ls_gl.
    IF ls_gl-head =  'P01'.
      l_gl1-low = ls_gl-saknr.
      l_gl1-sign = 'I'.
      l_gl1-option = 'EQ'.
      APPEND l_gl1.

      s_ktopl-low = ls_gl-ktopl.
      s_ktopl-sign = 'I'.
      s_ktopl-option = 'EQ'.
      APPEND s_ktopl.


    ENDIF.

    IF ls_gl-head =  'P02'.
      l_gl2-low = ls_gl-saknr.
      l_gl2-sign = 'I'.
      l_gl2-option = 'EQ'.
      APPEND l_gl2.

      s_ktopl-low = ls_gl-ktopl.
      s_ktopl-sign = 'I'.
      s_ktopl-option = 'EQ'.
      APPEND s_ktopl.
    ENDIF.

    IF ls_gl-head =  'P03'.
      l_gl3-low = ls_gl-saknr.
      l_gl3-sign = 'I'.
      l_gl3-option = 'EQ'.
      APPEND l_gl3.

      s_ktopl-low = ls_gl-ktopl.
      s_ktopl-sign = 'I'.
      s_ktopl-option = 'EQ'.
      APPEND s_ktopl.
    ENDIF.

    IF ls_gl-head =  'P04'.
      l_gl4-low = ls_gl-saknr.
      l_gl4-sign = 'I'.
      l_gl4-option = 'EQ'.
      APPEND l_gl4.

      s_ktopl-low = ls_gl-ktopl.
      s_ktopl-sign = 'I'.
      s_ktopl-option = 'EQ'.
      APPEND s_ktopl.
    ENDIF.

  IF ls_gl-head =  'P05'.
      l_gl5-low = ls_gl-saknr.
      l_gl5-sign = 'I'.
      l_gl5-option = 'EQ'.
      APPEND l_gl5.

      s_ktopl-low = ls_gl-ktopl.
      s_ktopl-sign = 'I'.
      s_ktopl-option = 'EQ'.
      APPEND s_ktopl.
    ENDIF.
  ENDLOOP .
*BREAK primus.
  PERFORM pa01.

  PERFORM pa02.
  PERFORM pa03.
  PERFORM pa04.
  PERFORM pa05.




ENDFORM.
*&---------------------------------------------------------------------*
*& Form PA01
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM pa01 .
  """""""""""""""""""""'for current year """"""""""""""""""
*  LOOP AT l_gl1.


  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr IN l_gl1
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-low
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl

                               l_bcal
*                                     L_bP
*                                     L_DR
*                                     L_CR
                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl ."item = '101'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low.
      ls-item = l_gl .
      ls-head = 'P01' .
      ls-amt1 = l_ab + ls-amt1 .
*      ls-amt2 = l_bcal + ls-amt2 .



*      APPEND ls TO lt .

*      CLEAR ls.
    ENDIF .


  ENDLOOP.
  CLEAR :  l_ab , l_bcal.
  """""""""""""""""""""""for last year

  """""""""""""""""""""'for current year """"""""""""""""""
  year1 = gjahr-low - 1 .

  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr IN l_gl1
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-high
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl
                               l_ab
                               l_bcal.
*                                     L_bP
*                                     L_DR
*                                     L_CR
*                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl." item = '101'.
    IF sy-subrc EQ 0 .
*      ls-year =  gjahr-low - 1.
*      ls-item = l_gl .
*      ls-head = 'P01' .
*      ls-amt1 = l_ab + ls-amt1 .
      ls-amt2 = l_bcal + ls-amt2 .


*      MODIFY lt FROM ls TRANSPORTING item.
*      APPEND ls TO lt .

*      CLEAR ls.
    ENDIF .


  ENDLOOP.
  CLEAR :  l_ab , l_bcal.
  APPEND ls TO lt .
  CLEAR ls.
*ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form PA02
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM pa02 .

  """""""""""""""""""""""""""""""FOR PA02 """"""""""""""""""""

  """""""""""""""""""""'for current year """"""""""""""""""
  LOOP AT l_gl2.

  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr = l_gl2-low   " IN l_gl2
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-low
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl

                               l_bcal
*                                     L_bP
*                                     L_DR
*                                     L_CR
                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl ."item = '201'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low.
      ls-item = l_gl .
      ls-head = 'P02' .
      ls-amt1 = l_ab + ls-amt1 .
*      ls-amt2 = l_bcal + ls-amt2 .

*      APPEND ls TO lt .
*      CLEAR :ls.
    ENDIF .


  ENDLOOP.
  CLEAR :  l_ab , l_bcal.
  """""""""""""""""""""""for last year

  """""""""""""""""""""'for current year """"""""""""""""""
  year1 = gjahr-low - 1 .

  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr = l_gl2-low "IN l_gl2
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-high
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl
                               l_ab
                               l_bcal.
*                                     L_bP
*                                     L_DR
*                                     L_CR
*                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl ."item = '201'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low.
      ls-item = l_gl .
      ls-head = 'P02' .
*      ls-amt1 = l_ab + ls-amt1 .
      ls-amt2 = l_bcal + ls-amt2 .


*      APPEND ls TO lt .

*      CLEAR: ls.
    ENDIF .


  ENDLOOP.
APPEND ls TO lt .
CLEAR ls.
ENDLOOP.
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
  CLEAR :  l_ab , l_bcal.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form PA03
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM pa03 .
  """""""""""""""""""""""""""""""FOR PA03 """"""""""""""""""""

  """""""""""""""""""""'for current year """"""""""""""""""

  LOOP AT l_gl3.


  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr = l_gl3-low
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-low
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl

                               l_bcal
*                                     L_bP
*                                     L_DR
*                                     L_CR
                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl ."item = '301'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low.
      ls-item = l_gl .
      ls-head = 'P03' .
      ls-amt1 = l_ab + ls-amt1 .
*      ls-amt2 = l_bcal + ls-amt2 .
*
*      APPEND ls TO lt .
*      CLEAR ls.
    ENDIF .


  ENDLOOP.
  CLEAR :  l_ab , l_bcal.
  """""""""""""""""""""""for last year

  """""""""""""""""""""'for current year """"""""""""""""""
  year1 = gjahr-low - 1 .

  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr = l_gl3-low
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-high
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl
                               l_ab
                               l_bcal.
*                                     L_bP
*                                     L_DR
*                                     L_CR
*                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl ."item = '301'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low.
      ls-item = l_gl .
      ls-head = 'P03' .
*      ls-amt1 = l_ab + ls-amt1 .
      ls-amt2 = l_bcal + ls-amt2 .

*      APPEND ls TO lt .
*      CLEAR ls.
    ENDIF .



  ENDLOOP.

APPEND ls TO lt .
CLEAR ls.
ENDLOOP.
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
  CLEAR :  l_ab , l_bcal.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form PA04
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM pa04 .
  """""""""""""""""""""""""""""""FOR PA04 """"""""""""""""""""

  """""""""""""""""""""'for current year """"""""""""""""""
  LOOP AT l_gl4.


  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr = l_gl4-low
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-low
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl

                               l_bcal
*                                     L_bP
*                                     L_DR
*                                     L_CR
                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl." item = '401'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low.
      ls-item = l_gl .
      ls-head = 'P04' .
      ls-amt1 = l_ab + ls-amt1 .
*      ls-amt2 = l_bcal + ls-amt2 .

*      APPEND ls TO lt .
*      CLEAR ls.
    ENDIF .



  ENDLOOP.
  CLEAR: l_ab , l_bcal .
  """""""""""""""""""""""for last year

  """""""""""""""""""""'for current year """"""""""""""""""
  year1 = gjahr-low - 1 .

  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr = l_gl4-low
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-high
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl
                               l_ab
                               l_bcal.
*                                     L_bP
*                                     L_DR
*                                     L_CR
*                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl." item = '401'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low.
      ls-item = l_gl .
      ls-head = 'P04' .
*      ls-amt1 = l_ab + ls-amt1 .
      ls-amt2 = l_bcal + ls-amt2 .

*      APPEND ls TO lt .
*      CLEAR ls.
    ENDIF .





  ENDLOOP.
APPEND ls TO lt .
CLEAR ls.
ENDLOOP.
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
  CLEAR :  l_ab , l_bcal.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form PA05
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM pa05 .
"""""""""""""""""""""""""""""""FOR PA05 """"""""""""""""""""

  """""""""""""""""""""'for current year """"""""""""""""""
LOOP AT l_gl5.


  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr = l_gl5-low
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-low
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl

                               l_bcal
*                                     L_bP
*                                     L_DR
*                                     L_CR
                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl." item = '501'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low.
      ls-item = l_gl .
      ls-head = 'P05' .
      ls-amt1 = l_ab + ls-amt1 .
*      ls-amt2 = l_bcal + ls-amt2 .

*      APPEND ls TO lt .
*      CLEAR ls.
    ENDIF .





  ENDLOOP.
  CLEAR: l_ab , l_bcal .
  """""""""""""""""""""""for last year

  """""""""""""""""""""'for current year """"""""""""""""""
  year1 = gjahr-low - 1 .

  SUBMIT rfssld00   WITH sd_ktopl IN  s_ktopl
                    WITH sd_saknr = l_gl5-low
                   WITH sd_bukrs IN bukrs
                   WITH b_monate = period-high
                                    WITH sd_gjahr IN gjahr
                                    WITH par_var1 EQ 'ZCASH'
                                    WITH par_var2 EQ ' '
                                     EXPORTING LIST TO MEMORY
                   AND RETURN.

  REFRESH :mem_tab  .
  CALL FUNCTION 'LIST_FROM_MEMORY'
    TABLES
      listobject = mem_tab
    EXCEPTIONS
      not_found  = 1
      OTHERS     = 2.

  REFRESH asci_tab.
  CALL FUNCTION 'LIST_TO_ASCI'
    EXPORTING
      list_index         = -1
      with_line_break    = ' '
    TABLES
      listasci           = asci_tab
      listobject         = mem_tab
    EXCEPTIONS
      empty_list         = 1
      list_index_invalid = 2
      OTHERS             = 3.
  CHECK asci_tab[] IS NOT INITIAL.

  DELETE asci_tab FROM 1 TO 5.
*  DELETE asci_tab FROM 18.
*  DELETE asci_tab FROM 14.
*  BREAK-POINT .
  LOOP AT asci_tab INTO asci_wa .

    l_len = strlen( asci_wa ) - 1.
    asci_wa+0(1) = space.
    asci_wa+l_len = space.
    CONDENSE asci_wa.

    SPLIT asci_wa AT ' ' INTO: l_bukrs
                               l_gl
                               l_ab
                               l_bcal.
*                                     L_bP
*                                     L_DR
*                                     L_CR
*                               l_ab.

    REPLACE ALL OCCURRENCES OF ',' IN l_bcal WITH space.
    REPLACE ALL OCCURRENCES OF ',' IN  l_ab WITH space.

    CONDENSE :  l_ab , l_bcal.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = l_gl
      IMPORTING
        output = l_gl.

    READ TABLE gt_gl INTO ls_gl WITH KEY saknr = l_gl ."item = '501'.
    IF sy-subrc EQ 0 .
      ls-year =  gjahr-low .
      ls-item = l_gl .
      ls-head = 'P05' .
*      ls-amt1 = l_ab + ls-amt1 .
      ls-amt2 = l_bcal + ls-amt2 .

*      APPEND ls TO lt .
*      CLEAR ls.
    ENDIF .



  ENDLOOP.
APPEND ls TO lt .
CLEAR ls.
ENDLOOP.
  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""''
  CLEAR :  l_ab , l_bcal.
ENDFORM.

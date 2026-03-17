*BREAK primus.
*
*""""added by pankaj 23.09.2021
*
"commented by pankaj 29.09.2021"""""""""
*
*CALL FUNCTION 'CONVERSION_EXIT_SDATE_OUTPUT'
*EXPORTING
*INPUT = IS_VBDKA-AUDAT
*IMPORTING
*OUTPUT = GV_SALE_DATE.
*
***TRANSLATE GV_SALE_DATE+2(1) TO LOWER CASE.
*CONCATENATE  GV_SALE_DATE+2(3) GV_SALE_DATE+0(2)
*             GV_SALE_DATE+5(4)
*             INTO GV_SALE_DATE SEPARATED BY '.'.
**
*
*CALL FUNCTION 'CONVERSION_EXIT_SDATE_OUTPUT'
*EXPORTING
*INPUT = WA_VBAK-VDATU
*IMPORTING
*OUTPUT = GV_SHIP_DATE.

*""""""""""added by pankaj 29.09.2021 """""""""""


**CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
**  EXPORTING
**    input  = is_vbdka-audat
**  IMPORTING
**    output = gv_sale_date.

*TRANSLATE gv_sale_date+1(2) TO LOWER CASE.    "COMMENTED BY DH

*CONCATENATE  gv_sale_date+0(3) gv_sale_date+3(2)
*             gv_sale_date+5(4)
*                INTO gv_sale_date SEPARATED BY '.'.

"TRANSLATE gv_sale_date+3(2) TO LOWER CASE.
*gv_sale_date = is_vbdka-audat.
*CALL FUNCTION 'CONVERSION_EXIT_SDATE_OUTPUT'
*EXPORTING
*INPUT = IS_VBDKA-AUDAT
*IMPORTING
*OUTPUT = GV_SALE_DATE.
*
***TRANSLATE GV_SALE_DATE+2(1) TO LOWER CASE.

CONCATENATE IS_VBDKA-AUDAT+4(2) IS_VBDKA-AUDAT+6(2)
            IS_VBDKA-AUDAT+0(4)
             INTO GV_SALE_DATE SEPARATED BY '.'.
*
*CONCATENATE  IS_VBDKA-AUDAT+3(3) IS_VBDKA-AUDAT+0(2)
*             IS_VBDKA-AUDAT+7(4)
*             INTO GV_SALE_DATE SEPARATED BY '.'.

*IS_VBDKA-AUDAT
**
*CONCATENATE  gv_sale_date+4(2) gv_sale_date+6(2)
*             gv_sale_date+0(4)
*                INTO gv_sale_date SEPARATED BY '.'.



*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*  EXPORTING
*    input  = wa_vbak-vdatu
*  IMPORTING
*    output = gv_ship_date.
*.
"TRANSLATE gv_ship_date+1(2) TO LOWER CASE
gv_ship_date = wa_vbak-vdatu.
CONCATENATE  gv_ship_date+4(2) gv_ship_date+6(2)
             gv_ship_date+0(4)
                INTO gv_ship_date SEPARATED BY '.'.


""""""""""""""""""""""""""""""""""""""""""""""""
*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = IS_VBDKA-AUDAT
*   IMPORTING
*     OUTPUT        = GV_SALE_DATE
*            .
**TRANSLATE GV_SALE_DATE+1(2) TO LOWER CASE.
**TRANSLATE GV_SALE_DATE+2(1) TO UPPER CASE.
*CONCATENATE  GV_SALE_DATE+0(3) GV_SALE_DATE+3(2)
*GV_SALE_DATE+5(4)
*                INTO GV_SALE_DATE SEPARATED BY '.'.
*
*
*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = WA_VBAK-VDATU
*   IMPORTING
*     OUTPUT        = GV_SHIP_DATE.
**            .
*TRANSLATE GV_SHIP_DATE+1(2) TO LOWER CASE.
**TRANSLATE GV_SHIP_DATE+2(1) TO UPPER CASE.
*CONCATENATE  GV_SHIP_DATE+0(3) GV_SHIP_DATE+3(2) GV_SHIP_DATE+5(4)
*                INTO GV_SHIP_DATE SEPARATED BY '.'.
*

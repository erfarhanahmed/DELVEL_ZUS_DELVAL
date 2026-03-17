*&---------------------------------------------------------------------*
*& Report ZUS_CHECK_PRINT
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Report ZUS_CHECK_PRINT                                             *
* 1.PROGRAM OWNER           : PRIMUS TECHSYSTEMS PVT LTD.              *
* 2.PROJECT                 : SMARTFORM FOR check print
* 3.PROGRAM NAME            : ZUS_CHECK_PRINT                       *
* 4.TRANS CODE              : ZUS_CHECK_PRINT                                  *
* 5.MODULE NAME             : FI.                                 *
* 6.REQUEST NO              : DEVK905677   PRIMUS:ABAP:GP: ZUS CHECK PRINTING SMARTFORM : 11.02.2019
* 7.CREATION DATE           : 11.02.2019.                              *
* 8.CREATED BY              : GANGA PHALAKE.                          *
* 9.FUNCTIONAL CONSULTANT   : SUBODH HINGWE.                                   *
* 10.BUSINESS OWNER         : DELVAL USA.
* 11.DESCRIPTION            : PRINT CHECK              *
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_CHECK_PRINT.

TABLES : BSAK,PAYR,LFA1,ADRC,T005U.


*****************BSAK STRUCTURE DECLARATION******************************
TYPES : BEGIN OF TY_BSAK,
        AUGBL TYPE BSAK-AUGBL,
        BLART TYPE BSAK-BLART,
        BELNR TYPE BSAK-BELNR,
        BUDAT TYPE BSAK-BUDAT,
        DMBTR TYPE BSAK-DMBTR,
        LIFNR TYPE BSAK-LIFNR,
*        BELNR TYPE BSAK-BELNR,
        END OF TY_BSAK.

DATA : IT_BSAK TYPE TABLE OF TY_BSAK,          "INTERNAL TABLE & WA DECLARATION
       WA_BSAK TYPE TY_BSAK.

*****************Bkpf STRUCTURE DECLARATION******************************
TYPES : BEGIN OF TY_BKPF,
        BELNR TYPE BKPF-BELNR,
        XBLNR TYPE BKPF-XBLNR,
        BUDAT TYPE BKPF-BUDAT,
        GJAHR TYPE BKPF-GJAHR,
        END OF TY_BKPF.

DATA : IT_BKPF TYPE TABLE OF TY_BKPF,          "INTERNAL TABLE & WA DECLARATION
       WA_BKPF TYPE TY_BKPF.

*****************BSIK STRUCTURE DECLARATION******************************
TYPES : BEGIN OF TY_BSIK,
        BELNR  TYPE BSIK-BELNR,
        LIFNR  TYPE BSIK-LIFNR,
        BUDAT1 TYPE BSIK-BUDAT,
        DMBTR1 TYPE BSIK-DMBTR,
        REBZG1 TYPE BSIK-REBZG,
        BLART  TYPE BSAK-BLART,
        REBZJ  TYPE BSAK-REBZJ,
        END OF TY_BSIK.

DATA : IT_BSIK TYPE TABLE OF TY_BSIK,          "INTERNAL TABLE & WA DECLARATION
       WA_BSIK TYPE TY_BSIK.

*****************PAYR STRUCTURE DECLARATION******************************
TYPES : BEGIN OF TY_PAYR,
        VBLNR TYPE PAYR-VBLNR,
        CHECT TYPE PAYR-CHECT,
        LIFNR TYPE PAYR-LIFNR,
        RWBTR TYPE PAYR-RWBTR,
        ZBUKR TYPE PAYR-ZBUKR,
        LAUFD TYPE PAYR-LAUFD,
        ZALDT TYPE PAYR-ZALDT,
        CHECV TYPE PAYR-CHECV,
        END OF TY_PAYR.

DATA : IT_PAYR TYPE TABLE OF TY_PAYR,          "INTERNAL TABLE & WA DECLARATION
       WA_PAYR TYPE TY_PAYR.

*****************LFA1 STRUCTURE DECLARATION******************************
TYPES : BEGIN OF TY_LFA1,
        LIFNR TYPE LFA1-LIFNR,
        NAME1 TYPE LFA1-NAME1,
        ADRNR TYPE LFA1-ADRNR,
        END OF TY_LFA1.

DATA : IT_LFA1 TYPE TABLE OF TY_LFA1,             "INTERNAL TABLE & WA DECLARATION
       WA_LFA1 TYPE TY_LFA1.

*****************ADRC STRUCTURE DECLARATION******************************
TYPES : BEGIN OF TY_ADRC,
        ADDRNUMBER TYPE ADRC-ADDRNUMBER,
        STREET     TYPE ADRC-STREET,
        STR_SUPPL3 TYPE ADRC-STR_SUPPL3,
        MC_CITY1   TYPE ADRC-MC_CITY1,
        POST_CODE1 TYPE ADRC-POST_CODE1,
        COUNTRY    TYPE ADRC-COUNTRY,
        REGION     TYPE ADRC-REGION ,
        CITY1      TYPE ADRC-CITY1 ,
        PO_BOX     TYPE ADRC-PO_BOX,
        POST_CODE2 TYPE ADRC-POST_CODE2,
        PO_BOX_LOC TYPE ADRC-PO_BOX_LOC,
        PO_BOX_REG TYPE ADRC-PO_BOX_REG,
        END OF TY_ADRC.

DATA : IT_ADRC TYPE TABLE OF TY_ADRC,            "INTERNAL TABLE & WA DECLARATION
       WA_ADRC TYPE TY_ADRC.

*****************T005U STRUCTURE DECLARATION******************************
TYPES : BEGIN OF TY_T005U,
        LAND1 TYPE T005U-LAND1,
        BLAND TYPE T005U-BLAND,
        BEZEI TYPE T005U-BEZEI,
        END OF TY_T005U.

DATA : IT_T005U TYPE TABLE OF TY_T005U,          "INTERNAL TABLE & WA DECLARATION
       WA_T005U TYPE TY_T005U.


*****************FINAL STRUCTURE DECLARATION******************************
TYPES : BEGIN OF TY_FINAL,
        AUGBL      TYPE BSAK-AUGBL,
        BLART      TYPE BSAK-BLART,
        BELNR      TYPE BSAK-BELNR,
        BUDAT(10)  TYPE c,      "BSAK-BUDAT,
        DMBTR(15)  TYPE c,       "BSAK-DMBTR,
        LIFNR      TYPE BSAK-LIFNR,
        XBLNR      TYPE BKPF-XBLNR,
        GJAHR      TYPE BKPF-GJAHR,
        BUDAT1     TYPE BSIK-BUDAT,
        DMBTR1(15) TYPE c,
        REBZG1     TYPE BSIK-REBZG,
        REBZJ      TYPE BSAK-REBZJ,
        VBLNR      TYPE PAYR-VBLNR,
        CHECT      TYPE PAYR-CHECT,
        RWBTR      TYPE PAYR-RWBTR,
        ZALDT(10)  TYPE c,           "PAYR-ZALDT,
        NAME1      TYPE LFA1-NAME1,
        ADRNR      TYPE LFA1-ADRNR,
        ADDRNUMBER TYPE ADRC-ADDRNUMBER,
        STREET     TYPE ADRC-STREET,
        STR_SUPPL3 TYPE ADRC-STR_SUPPL3,
        MC_CITY1   TYPE ADRC-MC_CITY1,
        POST_CODE1 TYPE ADRC-POST_CODE1,
        BLAND      TYPE T005U-BLAND,
        BEZEI      TYPE T005U-BEZEI,
        CITY1      TYPE ADRC-CITY1 ,
        REGION     TYPE ADRC-REGION,
        END OF TY_FINAL.

DATA : IT_FINAL TYPE TABLE OF TY_FINAL,                  "INTERNAL TABLE & WA DECLARATION
       WA_FINAL TYPE TY_FINAL.

data : gv_date(10) TYPE c.    " bsak-budat.
data: year(4) type c,
      month(2) type c,
      day(2) type c.

DATA : v_form_name TYPE rs38l_fnam.


**********************SELECTION SCREEN******************************************************
SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
PARAMETERS : CMP_CODE  TYPE BSAK-BUKRS.
PARAMETERS : DOC_NUM   TYPE BSAK-AUGBL.
PARAMETERS : DATE      TYPE BSAK-AUGDT DEFAULT sy-datum.
SELECTION-SCREEN : END OF BLOCK B1.


START-OF-SELECTION.
PERFORM GET_DATA.
PERFORM PRINT_DATA.
PERFORM DISPLAY_SF.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .

**********************************FULL PAYMENT*******************************************
SELECT AUGBL
       BLART
       BELNR
       BUDAT
       DMBTR
       LIFNR
       FROM BSAK
       INTO TABLE IT_BSAK
       WHERE BUKRS EQ CMP_CODE
       AND   AUGBL EQ DOC_NUM
       AND   AUGDT EQ DATE.

  IF IT_BSAK IS NOT INITIAL.
  SELECT
       BELNR
       XBLNR
       BUDAT
       GJAHR FROM BKPF
       INTO TABLE IT_BKPF
       FOR ALL ENTRIES IN IT_BSAK
       WHERE BELNR = IT_BSAK-BELNR
       AND   BUDAT = IT_BSAK-BUDAT.
  ENDIF.

*  ***************************PARTIAL PAYMENT*****************************************

SELECT BELNR
       lifnr
       BUDAT
       DMBTR
       REBZG
       blart
       REBZJ
       FROM BSIK
       INTO TABLE IT_BSIK
       WHERE BUKRS EQ CMP_CODE
       AND   BELNR EQ DOC_NUM
       AND   BUDAT EQ DATE.

  IF IT_BSIK IS NOT INITIAL.
  SELECT
       BELNR
       XBLNR
       BUDAT
       GJAHR
       FROM BKPF
       APPENDING TABLE IT_BKPF
       FOR ALL ENTRIES IN IT_BSIK
       WHERE BELNR = IT_BSIK-REBZG1
       AND   GJAHR = IT_BSIK-REBZJ.
  ENDIF.

********************************COMMON FOR FULL AND PARTIAL PAYMENT**************************************

  SELECT VBLNR
         CHECT
         LIFNR
         RWBTR
         ZBUKR
         LAUFD
         ZALDT
         CHECV
       FROM PAYR
       INTO TABLE IT_PAYR
       WHERE VBLNR EQ DOC_NUM
       AND   ZBUKR EQ CMP_CODE.
*       AND   LAUFD EQ DATE.


  IF IT_PAYR IS NOT INITIAL.
  SELECT LIFNR
         NAME1
         ADRNR
       FROM LFA1
       INTO TABLE IT_LFA1
       FOR ALL ENTRIES IN IT_PAYR
       WHERE LIFNR EQ IT_PAYR-LIFNR.

  ENDIF.

  IF IT_LFA1 IS NOT INITIAL.
  SELECT ADDRNUMBER
         STREET
         STR_SUPPL3
         MC_CITY1
         POST_CODE1
         COUNTRY
         REGION
         CITY1
         PO_BOX
         POST_CODE2
         PO_BOX_LOC
         PO_BOX_REG
       FROM ADRC
       INTO TABLE IT_ADRC
       FOR ALL ENTRIES IN IT_LFA1
       WHERE ADDRNUMBER EQ IT_LFA1-ADRNR.
    ENDIF.


    IF IT_ADRC IS NOT INITIAL.
  SELECT LAND1
         BLAND
         BEZEI
       FROM T005U
       INTO TABLE IT_T005U
       FOR ALL ENTRIES IN IT_ADRC
       WHERE LAND1 EQ IT_ADRC-COUNTRY
       AND   BLAND EQ IT_ADRC-REGION.

  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PRINT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM print_data .


loop at it_bsak into wa_bsak.

  wa_final-AUGBL = wa_bsak-AUGBL.
  wa_final-BLART = wa_bsak-BLART.
  wa_final-BELNR = wa_bsak-BELNR.
  wa_final-DMBTR = wa_bsak-DMBTR.
  wa_final-LIFNR = wa_bsak-LIFNR.

READ TABLE IT_BKPF INTO WA_BKPF WITH KEY BELNR = WA_BSAK-BELNR
                                         BUDAT = WA_BSAK-BUDAT.
  IF SY-SUBRC = 0.

    wa_final-XBLNR = wa_BKPF-XBLNR.                                  "DISPLAY DOCUMENT NUMBER

if wa_BKPF-budat IS NOT INITIAL.
   CONCATENATE wa_BKPF-BUDAT+4(2) wa_BKPF-BUDAT+6(2) wa_BKPF-BUDAT(4) INTO gv_date SEPARATED BY '-'.         "TO GIVE DATE FORMAT AS 27-12-2018
   wa_final-BUDAT = gv_date.
endif.

    ENDIF.

  READ TABLE IT_PAYR INTO WA_PAYR WITH KEY VBLNR = DOC_NUM                  "DISPLAY CHEQUE DETAILS
                                           ZBUKR = CMP_CODE.
*                                           LAUFD = DATE.
  IF SY-SUBRC = 0.
     wa_final-VBLNR = wa_PAYR-VBLNR.
   IF WA_PAYR-CHECV IS INITIAL.
     wa_final-CHECT = wa_PAYR-CHECT.                                         "CHEQUE NUMBER
   ELSE.
      wa_final-CHECT = wa_PAYR-CHECV.                                         "CHEQUE NUMBER
   ENDIF.
     wa_final-RWBTR = wa_PAYR-RWBTR * -1.                                    "TO AVOID NEGATIVE AMOUNT
     wa_final-LIFNR = wa_PAYR-LIFNR.                                         "VENDOR(MEMO)

     if wa_payr-zaldt IS NOT INITIAL.
   CONCATENATE wa_payr-ZALDT+4(2) wa_payr-ZALDT+6(2) wa_payr-ZALDT(4) INTO gv_date SEPARATED BY '-'. "TO GIVE DATE FORMAT AS 27-12-2018
   wa_final-zaldt = gv_date.
endif.

    ENDIF.

    READ TABLE IT_LFA1 INTO WA_LFA1 WITH KEY LIFNR = WA_PAYR-LIFNR.
  IF SY-SUBRC = 0.
     wa_final-LIFNR = wa_LFA1-LIFNR.                                  "VENDOR
     wa_final-NAME1 = wa_LFA1-NAME1.                                  "NAME
     wa_final-ADRNR = wa_LFA1-ADRNR.
    ENDIF.

    READ TABLE IT_ADRC INTO WA_ADRC WITH KEY ADDRNUMBER = WA_LFA1-ADRNR.             "DISPLAY ADDRESS ON CHEQUE
  IF SY-SUBRC = 0.
    IF wa_adrc-po_box IS INITIAL.

     wa_final-ADDRNUMBER = wa_ADRC-ADDRNUMBER.
     wa_final-STREET     = wa_ADRC-STREET.                                "Street
     wa_final-STR_SUPPL3 = wa_ADRC-STR_SUPPL3.                            "Street 4
     wa_final-MC_CITY1   = wa_ADRC-MC_CITY1.                              "City name
     wa_final-POST_CODE1 = wa_ADRC-POST_CODE1.                            "City postal code
     wa_final-city1      = wa_ADRC-city1.                                 "city
     wa_final-REGION     = wa_ADRC-REGION.                                 "REGION
    ELSE.
     wa_final-STREET     = wa_ADRC-po_box.                                "Street
     wa_final-city1      = wa_ADRC-po_box_loc.
     wa_final-REGION     = wa_ADRC-po_box_reg.
     wa_final-POST_CODE1 = wa_ADRC-POST_CODE2.
    ENDIF.
    ENDIF.

     READ TABLE IT_T005U INTO WA_T005U WITH KEY LAND1 = WA_ADRC-COUNTRY            "DISPLAY STATE AND COUNTRY KEY
                                                BLAND = WA_ADRC-REGION.


  IF SY-SUBRC = 0.
     wa_final-BLAND = wa_T005U-BLAND.                                   "Region (State, Province, County)
     wa_final-BEZEI = wa_T005U-BEZEI.                                   "Description

    ENDIF.


APPEND WA_FINAL TO IT_FINAL.
CLEAR WA_FINAL.
ENDLOOP.


*****************************for partial payment*********************************

 if it_bsik is NOT INITIAL.
loop at it_bsik into wa_bsik.

  wa_final-belnr = wa_bsik-rebzg1.
  wa_final-DMBTR = wa_bsik-DMBTR1.

READ TABLE IT_BKPF INTO WA_BKPF WITH KEY BELNR = WA_BSiK-rebzg1
                                         gjahr = wa_bsik-rebzj.
  IF SY-SUBRC = 0.

     wa_final-XBLNR = wa_BKPF-XBLNR.                                        "DISPLAY DOCUMENT NUMBER

      if wa_bkpf-budat IS NOT INITIAL.
   CONCATENATE wa_bkpf-BUDAT+4(2) wa_BKPF-BUDAT+6(2) wa_BKPF-BUDAT(4) INTO gv_date SEPARATED BY '-'.           "TO GIVE DATE FORMAT AS 27-12-2018
   wa_final-BUDAT = gv_date.
endif.
    ENDIF.


  READ TABLE IT_PAYR INTO WA_PAYR WITH KEY VBLNR = doc_num                         "DISPLAY CHEQUE DETAILS
                                           zbukr = cmp_code.
*                                           laufd = date.
  IF SY-SUBRC = 0.
     wa_final-VBLNR = wa_PAYR-VBLNR.
     IF WA_PAYR-CHECV IS INITIAL.
     wa_final-CHECT = wa_PAYR-CHECT.                                         "CHEQUE NUMBER
   ELSE.
      wa_final-CHECT = wa_PAYR-CHECV.                                         "CHEQUE NUMBER
   ENDIF.
     wa_final-RWBTR = wa_PAYR-RWBTR * -1.                              "TO AVOID NEGATIVE AMOUNT
     wa_final-LIFNR = wa_PAYR-LIFNR.                                   "VENDOR(MEMO)

     if wa_payr-zaldt IS NOT INITIAL.
   CONCATENATE wa_payr-ZALDT+4(2) wa_payr-ZALDT+6(2) wa_payr-ZALDT(4) INTO gv_date SEPARATED BY '-'.            "TO GIVE DATE FORMAT AS 27-12-2018
   wa_final-zaldt = gv_date.
endif.


    ENDIF.

    READ TABLE IT_LFA1 INTO WA_LFA1 WITH KEY LIFNR = WA_PAYR-LIFNR.
  IF SY-SUBRC = 0.
     wa_final-LIFNR = wa_LFA1-LIFNR.                                 "VENDOR
     wa_final-NAME1 = wa_LFA1-NAME1.                                 "NAME
     wa_final-ADRNR = wa_LFA1-ADRNR.
    ENDIF.

    READ TABLE IT_ADRC INTO WA_ADRC WITH KEY ADDRNUMBER = WA_FINAL-ADRNR.                            "DISPLAY ADDRESS ON CHEQUE
  IF SY-SUBRC = 0.
     wa_final-ADDRNUMBER = wa_ADRC-ADDRNUMBER.
     wa_final-STREET     = wa_ADRC-STREET.                               "Street
     wa_final-STR_SUPPL3 = wa_ADRC-STR_SUPPL3.                           "Street 4
     wa_final-MC_CITY1   = wa_ADRC-MC_CITY1.                             "City name
     wa_final-POST_CODE1 = wa_ADRC-POST_CODE1.                           "City postal code
     wa_final-city1      = wa_ADRC-city1.                                "city
     wa_final-REGION     = wa_ADRC-REGION.                                 "REGION
    ENDIF.

READ TABLE IT_T005U INTO WA_T005U WITH KEY LAND1 = WA_ADRC-COUNTRY                         "DISPLAY STATE AND COUNTRY KEY
                                           BLAND = WA_ADRC-REGION.

  IF SY-SUBRC = 0.
     wa_final-BLAND = wa_T005U-BLAND.                                    "Region (State, Province, County)
     wa_final-BEZEI = wa_T005U-BEZEI.                                    "Description
  ENDIF.

APPEND WA_FINAL TO IT_FINAL.
CLEAR WA_FINAL.
ENDLOOP.

endif.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_SF
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_sf .

  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname                 = 'ZUS_CHECK_PRINT_SF'                  "SMARTFORM NAME
*     VARIANT                  = ' '
*     DIRECT_CALL              = ' '
   IMPORTING
     FM_NAME                   =  v_form_name
   EXCEPTIONS
     NO_FORM                  = 1
     NO_FUNCTION_MODULE       = 2
     OTHERS                   = 3
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


CALL FUNCTION   v_form_name    "'/1BCDWB/SF00000102'
  EXPORTING
    bukrs                      = CMP_CODE
    augbl                      = DOC_NUM
    augdt                      = DATE
  TABLES
    it_final                   = IT_FINAL.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.



ENDFORM.

*************************************************************************
*** Project	        : DELVAL
*** PROGRAM TITLE   : ZUS_CONV_FI_GL_FS00
*** MODULE          : FI
*** PROGRAM TYPE    : BDC
*** Description     : This development is about System shall able to
***                   Upload Deatils for GL account create company level FSS0
*** INPUT           : Gayatri Shirke
*** Author          : Sagar Dev
*** CREATION DATE   : 30.07.2018
***----------------------------------------------------------------------
*** Modification History:
***----------------------------------------------------------------------
***   Date           |  Author    | Changes        | Trans Request No.
***----------------------------------------------------------------------
*** 30.07.2018       | Sagar Dev  | Intial Version |   DEVK904698
***----------------------------------------------------------------------
*************************************************************************
REPORT ZUS_CONV_FI_GL_FS00
         NO STANDARD PAGE HEADING LINE-SIZE 255.
*----------------------------------------------------------------------*
*                   T Y P E S                                          *
*----------------------------------------------------------------------*

TYPES: truxs_fileformat        TYPE trtm_format.
TYPES: truxs_t_text_data(4096) TYPE c OCCURS 0.
DATA : it_raw                  TYPE truxs_t_text_data.
DATA : bdcdata                 TYPE STANDARD TABLE OF bdcdata WITH HEADER LINE.
DATA : count                   TYPE i VALUE 0.
DATA : filename                TYPE string.
DATA : f_file                  TYPE string,
       wa_bdcmsgcoll           TYPE bdcmsgcoll,
       it_bdcmsgcoll           TYPE STANDARD TABLE OF bdcmsgcoll.

DATA : BEGIN OF itab OCCURS 0,
        saknr(10),      "G/L Acct
        bukrs(4),       "Comp Code
*        KTOKS(4),       "Act. Group
*        XPLACCT(1),     "P&L Act
*        XBILK(1),       "BL Act
*        TXT20(20),      "Sht Txt
*        TXT50(50),        "Lng Txt
        waers(4),       "Curr
        xsalh(1),       "ONLY BALANCE
        mwskz(2),       "Tax Catgry
        xmwno(1),       "W/O Tax
        mitkz(10),      "Rec Act
        xopvw(1),       "Opn Item
        xkres(1),       "LineItm
        zuawa(3),       "Sort Key
        fstag(4),       "Fld Stat Grp
        xintb(1),       "Indicator: Is account only posted to automatically?
*        fdlev(2),       "PLANNING LEVEL
*        xgkon(1),       "Cash receipt account / cash disbursement account
*        hbkid(10),      "HOUSE BANK
*        hktid(10),      "ACCOUNT ID
       END OF itab.

*----------------------------------------------------------------------*
*                 Selection Screen                                     *
*----------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE text001.
PARAMETERS   p_fname   LIKE ibipparms-path OBLIGATORY.
PARAMETERS   ctu_mode  LIKE ctu_params-dismode DEFAULT 'E'.
SELECTION-SCREEN END OF BLOCK blk1.

INITIALIZATION.
  text001 = 'GL Account Creation FS00'.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.
  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
      field_name    = ' '
    IMPORTING
      file_name     = p_fname.

*----------------------------------------------------------------------*
*                        START  OF    SELECTION                        *
*----------------------------------------------------------------------*

START-OF-SELECTION.
  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
  EXPORTING
*   I_FIELD_SEPERATOR          =
*   I_LINE_HEADER              =
    i_tab_raw_data             = it_raw
    i_filename                 = p_fname
  TABLES
    i_tab_converted_data       = itab
 EXCEPTIONS
   conversion_failed          = 1
   OTHERS                     = 2
          .
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


  LOOP AT itab.
    REFRESH bdcdata.

    PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=ACC_CRE'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'GLACCOUNT_SCREEN_KEY-BUKRS'.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_KEY-SAKNR'
                                  itab-saknr.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_KEY-BUKRS'
                                  itab-bukrs.

    PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=2102_GROUP'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'GLACCOUNT_SCREEN_COA-KTOKS'.
*    PERFORM BDC_FIELD       USING 'GLACCOUNT_SCREEN_COA-KTOKS'
*                                  ITAB-KTOKS.
*    PERFORM BDC_FIELD       USING 'GLACCOUNT_SCREEN_COA-XPLACCT'
*                                  ITAB-XPLACCT.
*    PERFORM BDC_FIELD       USING 'GLACCOUNT_SCREEN_COA-XBILK'
*                                  ITAB-XBILK.
    PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.

    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=2102_BS_PL'.
*perform bdc_field       using 'BDC_CURSOR'
*                              'GLACCOUNT_SCREEN_COA-XPLACCT'.
*perform bdc_field       using 'GLACCOUNT_SCREEN_COA-KTOKS'
*                              'PL'.
*perform bdc_field       using 'GLACCOUNT_SCREEN_COA-XPLACCT'
*                              'X'.

    PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=TAB02'.
*perform bdc_field       using 'GLACCOUNT_SCREEN_COA-KTOKS'
*                              'PL'.
*perform bdc_field       using 'GLACCOUNT_SCREEN_COA-XPLACCT'
*                              'X'.
*    PERFORM BDC_FIELD       USING 'GLACCOUNT_SCREEN_COA-TXT20_ML'
*                                  ITAB-TXT20.
*    PERFORM BDC_FIELD       USING 'GLACCOUNT_SCREEN_COA-TXT50_ML'
*                                  ITAB-TXT50.

    PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=TAB03'.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-WAERS'
                                  itab-waers.

*    **** start --- arti
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-XSALH'
                                  itab-xsalh.
*    **** end --- arti
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-MWSKZ'
                                  itab-mwskz.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-XMWNO'
                                  itab-xmwno.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-MITKZ'
                                  itab-mitkz.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-XOPVW'
                                  itab-xopvw.

    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-XKRES'
                                 itab-xkres.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-ZUAWA'
                                  itab-zuawa.

    PERFORM bdc_dynpro      USING 'SAPLGL_ACCOUNT_MASTER_MAINTAIN' '2001'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=SAVE'.

    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-FSTAG'
                                  itab-fstag.
    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-XINTB'
                                  itab-xintb.
*    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-FDLEV'
*                                 itab-fdlev.

    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'GLACCOUNT_SCREEN_CCODE-XGKON'.
*    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-XGKON'
*                                  itab-xgkon.
*    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-HBKID'
*                                   itab-hbkid.
*    PERFORM bdc_field       USING 'GLACCOUNT_SCREEN_CCODE-HKTID'
*                                  itab-hktid.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'GLACCOUNT_SCREEN_CCODE-HBKID'.
    CALL TRANSACTION 'FS00' USING bdcdata MODE ctu_mode
                                          UPDATE 'S'.

    count = count + 1.

*       REFRESH bdcdata.
  ENDLOOP.

  WRITE : / 'No of successfuly records inserted ' , count.

**----------------------------------------------------------------------*
**        Start new screen                                              *
**----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
  CLEAR bdcdata.
  bdcdata-program  = program.
  bdcdata-dynpro   = dynpro.
  bdcdata-dynbegin = 'X'.
  APPEND bdcdata.
ENDFORM.                    "BDC_DYNPRO

**----------------------------------------------------------------------*
**        Insert field                                                  *
**----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
*  IF FVAL <> SPACE.
  CLEAR bdcdata.
  bdcdata-fnam = fnam.
  bdcdata-fval = fval.
  APPEND bdcdata.
*  ENDIF.
ENDFORM.                    "BDC_FIELD

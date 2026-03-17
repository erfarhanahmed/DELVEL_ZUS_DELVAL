*&---------------------------------------------------------------------*
*& Report ZUS_MIGO_POST_F02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_MIGO_POST_F02.

DATA:IT_MSEG TYPE STANDARD TABLE OF  MSEG.
IMPORT IT_MSEG = IT_MSEG FROM MEMORY ID 'ID'.
BREAK PRIMUS.
TYPES: BEGIN OF ty_vbrk,
       vbeln TYPE vbrk-vbeln,
       knumv TYPE vbrk-knumv,
       END OF ty_vbrk,
       BEGIN OF ty_vbrp,
       vbeln TYPE vbrp-vbeln,
       posnr TYPE vbrp-posnr,
       vgbel TYPE vbrp-vgbel,
       vgpos TYPE vbrp-vgpos,
       END OF ty_vbrp,
       BEGIN OF ty_konv,
       knumv TYPE prcd_elements-knumv,
       kposn TYPE prcd_elements-kposn,
       kschl TYPE prcd_elements-kschl,
       kwert TYPE prcd_elements-kwert,
       END OF ty_konv,

       BEGIN OF ty_final,
       vbeln TYPE vbrp-vbeln,
       posnr TYPE vbrp-posnr,
       knumv TYPE prcd_elements-knumv,
       kschl TYPE prcd_elements-kschl,
       kwert TYPE prcd_elements-kwert,
       END OF ty_final.

DATA:amt TYPE prcd_elements-kwert.
DATA: it_vbrk TYPE TABLE OF ty_vbrk,
      wa_vbrk TYPE          ty_vbrk,

      it_vbrp TYPE TABLE OF ty_vbrp,
      wa_vbrp TYPE          ty_vbrp,

      it_konv TYPE TABLE OF ty_konv,
      wa_konv TYPE          ty_konv,

      it_final TYPE TABLE OF ty_final,
      wa_final TYPE          ty_final.

DATA : it_bdcdata TYPE TABLE OF bdcdata ,
       wa_bdcdata TYPE          bdcdata.
DATA : bdcdata       TYPE STANDARD TABLE OF bdcdata WITH HEADER LINE.
SELECT vbeln
       posnr
       vgbel
       vgpos FROM vbrp INTO TABLE it_vbrp
       FOR ALL ENTRIES IN it_mseg
       WHERE vgbel = it_mseg-XBLNR_MKPF+0(10).

IF it_vbrp IS NOT INITIAL.
  SELECT vbeln
         knumv FROM vbrk INTO TABLE it_vbrk
         FOR ALL ENTRIES IN it_vbrp
         WHERE vbeln = it_vbrp-vbeln.
ENDIF.
IF it_vbrk IS NOT INITIAL.
 SELECT knumv
        kposn
        kschl
        kwert FROM prcd_elements INTO TABLE it_konv
        FOR ALL ENTRIES IN it_vbrk
        WHERE knumv = it_vbrk-knumv
          AND kschl = 'ZPR0'.

ENDIF.

LOOP AT it_konv INTO wa_konv.
  amt = amt + wa_konv-kwert.

ENDLOOP.

BREAK primusabap.
perform bdc_dynpro      using 'SAPMF05A' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BKPF-BLDAT'
                              '28.12.2018'.
perform bdc_field       using 'BKPF-BLART'
                              'TR'.
perform bdc_field       using 'BKPF-BUKRS'
                              'US00'.
perform bdc_field       using 'BKPF-BUDAT'
                              '28.12.2018'.
*perform bdc_field       using 'BKPF-MONAT'
*                              '9'.
perform bdc_field       using 'BKPF-WAERS'
                              'USD'.
perform bdc_field       using 'BKPF-XBLNR'
                              'test 2'.
perform bdc_field       using 'FS006-DOCID'
                              '*'.
perform bdc_field       using 'RF05A-NEWBS'
                              '31'.
perform bdc_field       using 'RF05A-NEWKO'
                              '1000019'.
perform bdc_dynpro      using 'SAPMF05A' '0302'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWKO'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BSEG-WRBTR'
                              '1000'.
perform bdc_field       using 'BSEG-MWSKZ'
                              '**'.
*perform bdc_field       using 'BSEG-ZTERM'
*                              'U101'.
*perform bdc_field       using 'BSEG-ZBD1T'
*                              '15'.
perform bdc_field       using 'BSEG-ZFBDT'
                              '28.12.2018'.
perform bdc_field       using 'RF05A-NEWBS'
                              '40'.
perform bdc_field       using 'RF05A-NEWKO'
                              '12051'.
perform bdc_dynpro      using 'SAPMF05A' '0300'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-ZUONR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ZK'.
perform bdc_field       using 'BSEG-WRBTR'
                              '1000'.
perform bdc_field       using 'BSEG-MWSKZ'
                              'V0'.
perform bdc_field       using 'DKACB-FMORE'
                              'X'.
perform bdc_dynpro      using 'SAPLKACB' '0002'.
perform bdc_field       using 'BDC_CURSOR'
                              'COBL-PRCTR'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTE'.
perform bdc_field       using 'COBL-PRCTR'
                              'PRUS02_10'.
perform bdc_dynpro      using 'SAPMF05A' '0330'.
perform bdc_field       using 'BDC_CURSOR'
                              'BSEG-DMBE2'.
perform bdc_field       using 'BDC_OKCODE'
                              '=BS'.
*perform bdc_field       using 'BSEG-DMBE2'
*                              '70,000.00'.
perform bdc_dynpro      using 'SAPMF05A' '0700'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF05A-NEWBS'.
perform bdc_field       using 'BDC_OKCODE'
                              '=BU'.
perform bdc_field       using 'BKPF-XBLNR'
                              'TEST 2'.
CALL TRANSACTION 'F-02' USING bdcdata UPDATE 'S'.

FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.
*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
*  IF FVAL <> NODATA.
    CLEAR BDCDATA.
    BDCDATA-FNAM = FNAM.
    BDCDATA-FVAL = FVAL.
    APPEND BDCDATA.
*  ENDIF.
ENDFORM.

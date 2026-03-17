report ZUS_AUTO_PRICE_VK11
       no standard page heading line-size 255.

*include bdcrecx1.
TYPES : BEGIN OF ty_ekpo,
        ebeln TYPE ekko-ebeln,
        EBELP TYPE ekpo-EBELP,
        MATNR TYPE ekpo-MATNR,

        END OF ty_ekpo,

        BEGIN OF ty_ekko,
        EBELN TYPE ekko-ebeln,
        BUKRS TYPE ekko-BUKRS,
        AEDAT TYPE ekko-AEDAT,
        LIFNR TYPE ekko-LIFNR,
        EKORG TYPE ekko-EKORG,
        END OF ty_ekko,

        BEGIN OF ty_po,
        EBELN TYPE ekko-ebeln,
        BUKRS TYPE ekko-BUKRS,
        AEDAT TYPE ekko-AEDAT,
        LIFNR TYPE ekko-LIFNR,
        EKORG TYPE ekko-EKORG,
        MATNR TYPE ekpo-MATNR,
        END OF ty_po,




        BEGIN OF ty_a017,
        KSCHL TYPE a017-KSCHL,
        LIFNR TYPE a017-LIFNR,
        MATNR TYPE a017-MATNR,
        EKORG TYPE a017-EKORG,
        DATBI TYPE a017-DATBI,
        DATAB TYPE a017-DATAB,
        KNUMH TYPE a017-KNUMH,
        END OF ty_a017,

        BEGIN OF ty_konp,
        KNUMH TYPE konp-KNUMH,
        KSCHL TYPE konp-KSCHL,
        KBETR TYPE konp-KBETR,
        END OF ty_konp,

        BEGIN OF ty_final,
        MATNR TYPE a017-MATNR,
        DATBI TYPE a017-DATBI,
        DATAB TYPE a017-DATAB,
        KBETR(016),
        END OF ty_final.

DATA :
       it_ekpo TYPE TABLE OF ty_ekpo,
       wa_ekpo TYPE          ty_ekpo,

       it_ekko TYPE TABLE OF ty_ekko,
       wa_ekko TYPE          ty_ekko,

       it_a017 TYPE TABLE OF ty_a017,
       wa_a017 TYPE          ty_a017,

       it_konp TYPE TABLE OF ty_konp,
       wa_konp TYPE          ty_konp,

       it_po TYPE TABLE OF ty_po,
       wa_po TYPE          ty_po,

       date TYPE ekko-aedat,

       it_final TYPE TABLE OF ty_final,
       wa_final TYPE          ty_final.

DATA: BEGIN OF bdcdata OCCURS 100.
        INCLUDE STRUCTURE bdcdata.
DATA: END OF bdcdata.

start-of-selection.
date = sy-datum.



SELECT ebeln
       bukrs
       AEDAT
       LIFNR
       EKORG FROM ekko INTO TABLE it_ekko
       WHERE lifnr = '0001100000'
        AND  AEDAT = date
        AND ekorg = 'US00'
        AND bukrs = 'US00'.
IF it_ekko IS NOT INITIAL.
  SELECT ebeln
         EBELP
         MATNR FROM ekpo INTO TABLE it_ekpo
         FOR ALL ENTRIES IN it_ekko
         WHERE ebeln = it_ekko-ebeln.

ENDIF.

IF it_ekpo IS NOT INITIAL.
SELECT KSCHL
       LIFNR
       MATNR
       EKORG
       DATBI
       DATAB
       KNUMH FROM a017 INTO TABLE it_a017
       FOR ALL ENTRIES IN it_ekpo
       WHERE matnr = it_ekpo-matnr
        AND  lifnr = '0001100000'
        AND  EKORG = 'US00'.

ENDIF.

IF  it_a017 IS NOT INITIAL.
  SELECT KNUMH
         KSCHL
         KBETR FROM konp INTO TABLE it_konp
         FOR ALL ENTRIES IN it_a017
         WHERE KNUMH = it_a017-KNUMH
           AND KSCHL IN ('PB00','P000').

ENDIF.

LOOP AT it_a017 INTO wa_a017.
  wa_final-matnr = wa_a017-matnr.
  wa_final-DATBI = wa_a017-DATBI.
  wa_final-DATAB = wa_a017-DATAB.

READ TABLE it_konp INTO wa_konp WITH KEY knumh = wa_a017-KNUMH.
  IF sy-subrc = 0.
    wa_final-kbetr = wa_konp-kbetr.
  ENDIF.

APPEND wa_final TO it_final.
Clear wa_final.
ENDLOOP.


LOOP AT IT_FINAL INTO WA_FINAL.
    CLEAR: bdcdata.
    REFRESH: bdcdata.
CONCATENATE wa_final-datbi+6(2) wa_final-datbi+4(2) wa_final-datbi+0(4)
INTO wa_final-datbi.

CONCATENATE wa_final-datab+6(2) wa_final-datab+4(2) wa_final-datab+0(4)
INTO wa_final-datab.
*
*perform open_group.
*
perform bdc_dynpro      using 'SAPMV13A' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'RV13A-KSCHL'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'RV13A-KSCHL'
                              'ZPR0'.
perform bdc_dynpro      using 'SAPLV14A' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'RV130-SELKZ(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=WEIT'.
perform bdc_dynpro      using 'SAPMV13A' '1005'.
perform bdc_field       using 'BDC_CURSOR'
                              'RV13A-DATBI(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'KOMG-VKORG'
                              '1000'.
perform bdc_field       using 'KOMG-VTWEG'
                              '30'.
perform bdc_field       using 'KOMG-KUNNR'
                              '300000'.
perform bdc_field       using 'KOMG-MATNR(01)'
                               wa_final-matnr.  "                     '48'.
perform bdc_field       using 'KONP-KBETR(01)'
                              wa_final-kbetr.                     "'             125'.
perform bdc_field       using 'RV13A-DATAB(01)'
                              wa_final-datab.                       "'22.12.2018'.
perform bdc_field       using 'RV13A-DATBI(01)'
                              wa_final-datbi.                "'22.12.2019'.
perform bdc_field       using 'KONP-KONWA(01)'
                              'USD'.
perform bdc_dynpro      using 'SAPMV13A' '1005'.
perform bdc_field       using 'BDC_CURSOR'
                              'KOMG-MATNR(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=SICH'.
CALL TRANSACTION 'VK11' USING bdcdata
                                 MODE 'E'
                                 UPDATE 'S'.
*
*perform close_group.

  ENDLOOP.

*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM bdc_dynpro USING program dynpro.
  CLEAR bdcdata.
  bdcdata-program  = program.
  bdcdata-dynpro   = dynpro.
  bdcdata-dynbegin = 'X'.
  APPEND bdcdata.
ENDFORM.                    "BDC_DYNPRO

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.

  CLEAR bdcdata.
  bdcdata-fnam = fnam.
  bdcdata-fval = fval.
  APPEND bdcdata.

ENDFORM.                    "BDC_FIELD

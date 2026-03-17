
*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = wa_hdr-DLV_DATE
*   IMPORTING
*     OUTPUT        = GV_DEL_DATE.
*TRANSLATE GV_DEL_DATE+1(2) TO LOWER CASE.
*TRANSLATE GV_DEL_DATE+2(1) TO UPPER CASE.
CONCATENATE  wa_hdr-DLV_DATE+4(2) wa_hdr-DLV_DATE+6(2)
 wa_hdr-DLV_DATE+0(4)
                INTO GV_DEL_DATE SEPARATED BY '.'.


*CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = wa_likp-bldat
*   IMPORTING
*     OUTPUT        = GV_doc_date.
*            .
*TRANSLATE GV_Doc_DATE+1(2) TO LOWER CASE.
*TRANSLATE GV_DEL_DATE+2(1) TO UPPER CASE.
*  gv_doc_date = wa_likp-bldat.      "Y
*BREAK-POINT.
*  CALL FUNCTION 'CONVERSION_EXIT_IDATE_OUTPUT'
*    EXPORTING
*      input         = wa_likp-bldat
*   IMPORTING
*     OUTPUT        = GV_DEL_DATE.

CONCATENATE  wa_likp-bldat+4(2) wa_likp-bldat+6(2)
wa_likp-bldat+0(4) "Y
                INTO GV_Doc_DATE SEPARATED BY '.'.





















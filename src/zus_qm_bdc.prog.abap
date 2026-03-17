*&---------------------------------------------------------------------*
*& Report ZUS_QM_BDC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_QM_BDC.



SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
  PARAMETERS     : A1 RADIOBUTTON GROUP r,
                   A2 RADIOBUTTON GROUP r.
*                   A3 RADIOBUTTON GROUP r,
*                   A4 RADIOBUTTON GROUP r.

SELECTION-SCREEN : END OF BLOCK B1.


IF A1 EQ 'X'.
  SUBMIT ZUS_QM_INSPECTION_PLAN  VIA SELECTION-SCREEN AND RETURN.
*ELSEIF A2 EQ 'X'.
*  SUBMIT ZPP_ROUTING_UPLOAD VIA SELECTION-SCREEN AND RETURN.



ENDIF.

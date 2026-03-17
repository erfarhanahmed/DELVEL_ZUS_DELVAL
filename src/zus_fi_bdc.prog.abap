*&---------------------------------------------------------------------*
*& Report ZUS_FI_BDC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_FI_BDC.



SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
  PARAMETERS     : A1 RADIOBUTTON GROUP r,
                   A2 RADIOBUTTON GROUP r,
                   A3 RADIOBUTTON GROUP r,
                   A4 RADIOBUTTON GROUP r.

SELECTION-SCREEN : END OF BLOCK B1.


IF A1 EQ 'X'.
  SUBMIT ZUS_FI_VENDOR_OPEN_ITEM VIA SELECTION-SCREEN AND RETURN.
ELSEIF A2 EQ 'X'.
  SUBMIT ZUS_FI_CUSTOMER_OPEN_ITEM VIA SELECTION-SCREEN AND RETURN.
ELSEIF A3 EQ 'X'.
  SUBMIT ZUS_FI_GL_BAL_UPLOAD VIA SELECTION-SCREEN AND RETURN.
ELSEIF A4 EQ 'X'.
  SUBMIT ZUS_FI_COSTCENTER_CRE VIA SELECTION-SCREEN AND RETURN.

ENDIF.

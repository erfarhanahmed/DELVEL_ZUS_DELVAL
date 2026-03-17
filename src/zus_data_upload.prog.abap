*&---------------------------------------------------------------------*
*& Report ZUS_DATA_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_DATA_UPLOAD.


SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE GITL."  TEXT-001.
  PARAMETERS     : A1 RADIOBUTTON GROUP r,      "MM
                   A2 RADIOBUTTON GROUP r,      "SD
                   A3 RADIOBUTTON GROUP r,      "FI
                   A4 RADIOBUTTON GROUP r,      "PP
                   A5 RADIOBUTTON GROUP r.      "QM
*                   A7 RADIOBUTTON GROUP r,      "QM
*                   A8 RADIOBUTTON GROUP r.      "QM
SELECTION-SCREEN : END OF BLOCK B1.



INITIALIZATION.
  GITL = 'Delval Flow Control'.

AT SELECTION-SCREEN.


IF A1 EQ 'X'.
  SUBMIT ZUS_MM_BDC VIA SELECTION-SCREEN AND RETURN.
ELSEIF A2 EQ 'X'.
  SUBMIT ZUS_SD_BDC VIA SELECTION-SCREEN AND RETURN.
ELSEIF A3 EQ 'X'.
  SUBMIT ZUS_FI_BDC VIA SELECTION-SCREEN AND RETURN.
ELSEIF A4 EQ 'X'.
  SUBMIT ZUS_PP_BDC VIA SELECTION-SCREEN AND RETURN.
ELSEIF A5 EQ 'X'.
  SUBMIT ZUS_QM_BDC VIA SELECTION-SCREEN AND RETURN.
ENDIF.

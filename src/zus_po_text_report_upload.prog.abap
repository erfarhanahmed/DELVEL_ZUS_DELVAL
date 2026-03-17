*&---------------------------------------------------------------------*
*& Report ZUS_PO_TEXT_REPORT_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_PO_TEXT_REPORT_UPLOAD.


SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE GITL."  TEXT-001.
  PARAMETERS     : A1 RADIOBUTTON GROUP r,
                   A2 RADIOBUTTON GROUP r.

SELECTION-SCREEN : END OF BLOCK B1.




AT SELECTION-SCREEN.
IF A1 EQ 'X'.
  SUBMIT ZUS_PO_ITEM_TEXT_REPORT VIA SELECTION-SCREEN AND RETURN.
ELSEIF A2 EQ 'X'.
  SUBMIT ZUS_PO_ITEM_TEXT_CHANGE VIA SELECTION-SCREEN AND RETURN.
ENDIF.

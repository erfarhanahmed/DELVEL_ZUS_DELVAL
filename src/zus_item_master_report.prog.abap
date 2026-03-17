*&---------------------------------------------------------------------*
*& Report ZUS_ITEM_MASTER_REPORT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_ITEM_MASTER_REPORT.

SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE GITL."  TEXT-001.
PARAMETERS     : A1 RADIOBUTTON GROUP R,      "Purchase
                 A2 RADIOBUTTON GROUP R.      "Sales

SELECTION-SCREEN : END OF BLOCK B1.


IF A1 EQ 'X'.
  SUBMIT ZUS_ITEM_MASTER_PURCHASE VIA SELECTION-SCREEN AND RETURN.
ELSEIF A2 EQ 'X'.
  SUBMIT ZUS_ITEM_MASTER VIA SELECTION-SCREEN AND RETURN. "<--------ADD NEW REPORT ON DATE 27.12.2019 BY AMAR POLEKAR.
*  SUBMIT ZUS_ITEM_MASTER_SALES VIA SELECTION-SCREEN AND RETURN. "<--------HIDE ON DATE 27.12.2019 BY AMAR POLEKAR.
ENDIF.

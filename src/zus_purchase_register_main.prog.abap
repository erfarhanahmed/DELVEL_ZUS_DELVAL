*&---------------------------------------------------------------------*
*& Report ZUS_PURCHASE_REGISTER_MAIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_PURCHASE_REGISTER_MAIN.

SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE xyz.
PARAMETERS: r1 RADIOBUTTON GROUP abc DEFAULT 'X',
            r2 RADIOBUTTON GROUP abc.
SELECTION-SCREEN: END OF BLOCK b1.

INITIALIZATION.
  xyz = 'Select Register'(tt1).

AT SELECTION-SCREEN.
  IF r1 = 'X'.
    SUBMIT ZUS_AP_PURCHASE_REGISTER VIA SELECTION-SCREEN AND RETURN.
  ELSEIF r2 = 'X'.
    SUBMIT ZUS_PURCHASE_REGISTER_FI VIA SELECTION-SCREEN AND RETURN.
  ENDIF.

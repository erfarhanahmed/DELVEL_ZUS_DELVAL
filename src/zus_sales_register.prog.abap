*&---------------------------------------------------------------------*
*& Report ZUS_SALES_REGISTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_SALES_REGISTER.

SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE xyz.
PARAMETERS: r1 RADIOBUTTON GROUP abc DEFAULT 'X',
            r2 RADIOBUTTON GROUP abc.
SELECTION-SCREEN: END OF BLOCK b1.

INITIALIZATION.
xyz = 'Select Register'(tt1).
AT SELECTION-SCREEN.
  IF r1 = 'X'.
    SUBMIT ZUS_SALES_REGISTER_REF_SO_N2 VIA SELECTION-SCREEN AND RETURN.
  ELSEIF r2 = 'X'.
*    SUBMIT ZUS_FI_SALES_REGISTER VIA SELECTION-SCREEN AND RETURN.
    SUBMIT ZUS_SALES_REGISTER_FI VIA SELECTION-SCREEN AND RETURN.
  ENDIF.

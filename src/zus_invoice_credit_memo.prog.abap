*&---------------------------------------------------------------------*
*& Report ZUS_INVOICE_CREDIT_MEMO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_INVOICE_CREDIT_MEMO.


SELECTION-SCREEN:BEGIN OF BLOCK B1 WITH FRAME TITLE txt.
  PARAMETERS: r1 RADIOBUTTON GROUP rg,
              r2 RADIOBUTTON GROUP rg.

SELECTION-SCREEN:END OF BLOCK B1.


INITIALIZATION.
  txt = 'Invoice & Credit Memo'.


AT SELECTION-SCREEN.

IF R1 EQ 'X'.
  SUBMIT ZUS_FI_INVOICE VIA SELECTION-SCREEN AND RETURN.
ELSEIF R2 EQ 'X'.
  SUBMIT ZUS_FI_CREDIT_MEMO VIA SELECTION-SCREEN AND RETURN.
ENDIF.

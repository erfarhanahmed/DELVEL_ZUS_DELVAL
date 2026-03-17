*&---------------------------------------------------------------------*
*& Report ZUS_CFR_INFO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_CFR_INFO.



SELECTION-SCREEN :BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.

PARAMETERS: R1 RADIOBUTTON GROUP rad1 user-command rad.
PARAMETERS: r7 RADIOBUTTON GROUP rad1.
PARAMETERS: r8 RADIOBUTTON GROUP rad1.
PARAMETERS: r2 RADIOBUTTON GROUP rad1.

PARAMETERS: r3 RADIOBUTTON GROUP rad1.

PARAMETERS: r4 RADIOBUTTON GROUP rad1.
PARAMETERS: r5 RADIOBUTTON GROUP rad1.
PARAMETERS: r6 RADIOBUTTON GROUP rad1.

SELECTION-SCREEN : END OF BLOCK B1 .



START-OF-SELECTION .

IF R1 = 'X' .

  CALL TRANSACTION  'ZUS_CFR' .

  ENDIF.

  IF R2 = 'X' .

  CALL TRANSACTION  'ZUS_CASH_HEAD' .

  ENDIF.

  IF R3 = 'X' .

  CALL TRANSACTION  'ZUS_CASH_ITEM' .

  ENDIF.


  IF R4 = 'X' .

  CALL TRANSACTION  'ZUS_CASHFLOW' .

  ENDIF.

  IF R5 = 'X' .

  CALL TRANSACTION  'ZUS_BDC_CASHFLOW'.
*  SUBMIT ZBDC_CASHFLOW AND RETURN. .

  ENDIF.

    IF R6 = 'X' .

   CALL TRANSACTION 'ZUS_GL_INFO' .


   endif.

   IF R7 = 'X' .

   CALL TRANSACTION 'ZUS_CFR_PERIOD' .


   endif.

   IF R8 = 'X' .

   CALL TRANSACTION 'ZUS_CFR_PER_ALL' .


   endif.

*&---------------------------------------------------------------------*
*& Report ZUS_CONV_PROG_FI
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_CONV_PROG_FI.
************************************************************************
*SELECTION SCREEN
************************************************************************


SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.   "TEXT_POOL
PARAMETERS : p_conv1 RADIOBUTTON GROUP g1 DEFAULT 'X',
             p_conv2 RADIOBUTTON GROUP g1,
             p_conv3 RADIOBUTTON GROUP g1,
             p_conv4 RADIOBUTTON GROUP g1,
             p_conv5 RADIOBUTTON GROUP g1,
             p_conv6 RADIOBUTTON GROUP g1,
             p_conv7 RADIOBUTTON GROUP g1,
             p_conv8 RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b2.
************************************************************************
*END OF SELECTION-SCREEN
************************************************************************

START-OF-SELECTION.


  IF p_conv1 = 'X'.                "Create the General ledger account to chart of account.
     SUBMIT ZUS_CONV_FI_fspo AND RETURN.
  ELSEIF p_conv2 = 'X'.            "Extend the General ledger account to company code.
     SUBMIT ZUS_CONV_FI_GL_FS00 AND RETURN.
  ELSEIF p_conv3 = 'X'.            "Create the general ledger account to company code (with assign the alternative account).
     SUBMIT ZUS_CONV_FI_GL_ALT_FS00 AND RETURN.
  ELSEIF p_conv4 = 'X'.
     SUBMIT ZUS_FI_COSTCENTER_CRE VIA SELECTION-SCREEN AND RETURN.
  ELSEIF p_conv5 = 'X'.
     SUBMIT ZUS_FI_VENDOR_OPEN_ITEM VIA SELECTION-SCREEN AND RETURN.
  ELSEIF p_conv6 = 'X'.
     SUBMIT ZUS_FI_CUSTOMER_OPEN_ITEM VIA SELECTION-SCREEN AND RETURN.
  ELSEIF p_conv7 = 'X'.
     SUBMIT ZUS_FI_GL_BAL_UPLOAD VIA SELECTION-SCREEN AND RETURN.
  ELSEIF p_conv8 = 'X'.
     SUBMIT ZUS_FI_CUST_DOWNPAY_UPLOAD VIA SELECTION-SCREEN AND RETURN.
  ENDIF.

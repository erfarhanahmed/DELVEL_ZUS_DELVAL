
CLEAR ls_konv.
READ TABLE xtkomv INTO ls_konv WITH KEY knumv = wa_hdr-knumv kposn = wa_item-ebelp
 kschl = 'P000'.
IF sy-subrc = 0.
unit = ls_konv-kbetr.
ENDIF.

CLEAR ls_konv.
READ TABLE xtkomv INTO ls_konv WITH KEY knumv = wa_hdr-knumv kposn = wa_item-ebelp
 kschl = 'ZCH%' .
IF sy-subrc = 0.
  ls_konv-kbetr = ls_konv-kbetr / 10.
zch = ls_konv-kbetr.
zch_amt = zch_amt + ls_konv-kwert.
ENDIF.
CLEAR ls_konv.
READ TABLE xtkomv INTO ls_konv WITH KEY knumv = wa_hdr-knumv kposn = wa_item-ebelp
 kschl = 'ZCH1' .
IF sy-subrc = 0.
zch1_amt = zch1_amt + ls_konv-kwert.
ENDIF.

CLEAR ls_konv.
READ TABLE xtkomv INTO ls_konv WITH KEY kschl = 'HB01' kposn = wa_item-ebelp.
IF sy-subrc = 0.
IF ls_konv-kbetr IS NOT INITIAL.
GV_DAMT = GV_DAMT + ls_konv-kbetr.
ENDIF.
ENDIF.

CLEAR ls_konv.
READ TABLE xtkomv INTO ls_konv WITH KEY kschl = 'R000' kposn = wa_item-ebelp.
IF sy-subrc = 0.
  IF ls_konv-kwert IS NOT INITIAL.
    GV_DAMT = GV_DAMT + ls_konv-kwert.
  ENDIF.
  IF ls_konv-kbetr IS NOT INITIAL.
    gv_dis = ls_konv-kbetr / 10.
  ENDIF.
  endif.

**************  Avinash Bhagat
*  break primus.
  CLEAR ls_konv.
READ TABLE xtkomv INTO ls_konv WITH KEY kschl = 'ZEXP' kposn = wa_item-ebelp.
IF sy-subrc = 0.
  IF ls_konv-kwert IS NOT INITIAL.
    gv_zexp = gv_zexp + ls_konv-kwert.
  ENDIF.
*  IF ls_konv-kbetr IS NOT INITIAL.
*    gv_dis = ls_konv-kbetr / 10.
  ENDIF.

    CLEAR ls_konv.
READ TABLE xtkomv INTO ls_konv WITH KEY kschl = 'ZAFR' kposn = wa_item-ebelp.
IF sy-subrc = 0.
  IF ls_konv-kwert IS NOT INITIAL.
    GV_AFR = GV_AFR + ls_konv-kwert.
  ENDIF.
*  IF ls_konv-kbetr IS NOT INITIAL.
*    gv_dis = ls_konv-kbetr / 10.
  ENDIF.

****************  End Avinash Bhagat

IF gv_afr IS NOT INITIAL.
    lv_flag1 = 'X'.
ENDIF.

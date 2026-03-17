

clear:gv_usa.

SELECT SINGLE * FROM mara INTO gv_mara
  WHERE matnr = wa_item-matnr.
IF wa_item-matnr NE gv_mara-wrkst .


IF gv_mara-wrkst IS NOT INITIAL.
CONCATENATE  '(' gv_mara-wrkst ')' INTO gv_usa.
ENDIF.

ENDIF.














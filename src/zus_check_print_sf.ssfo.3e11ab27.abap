
*BREAK-POINT.

GV_NO = GV_NO + 1.

DATA : LV TYPE I.
LV = GV_NO MOD 10.
IF LV = 0.
  GV_FLAG = 'X'.
  ELSE.
  GV_FLAG = ' '.
  ENDIF.





















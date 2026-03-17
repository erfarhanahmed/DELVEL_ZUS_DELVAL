

IF ls_bseg-SHKZG = 'S'.
  total = total + ls_bseg-dmbtr.
ENDIF.
IF ls_bseg-SHKZG = 'H'..
  total = total - ls_bseg-dmbtr.
ENDIF.

IF ls_bseg-SHKZG = 'H'.
ls_bseg-dmbtr =  ls_bseg-dmbtr * -1.
ENDIF.























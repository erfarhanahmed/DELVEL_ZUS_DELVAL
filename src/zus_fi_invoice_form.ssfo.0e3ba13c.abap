*READ TABLE it_bseg INTO ls_bseg WITH KEY shkzg = 'H'.
SELECT SINGLE * FROM bseg INTO lv_bseg WHERE
  belnr = wa_bseg-belnr AND shkzg = 'S'.

SELECT SINGLE * FROM t052u INTO wa_t052u WHERE
  spras = 'E' AND zterm = lv_bseg-zterm.























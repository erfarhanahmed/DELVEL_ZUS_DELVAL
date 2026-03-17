SELECT SINGLE * FROM vbap INTO wa_vbap
  WHERE VBELN = IS_VBDKA-VBELN
    AND posnr = wa_final-posnr
    AND matnr = wa_final-matnr.

if wa_vbap-custdeldate is not INITIAL.
gv_req_date = wa_vbap-custdeldate."added by jyoti on 14.11.2024
CONCATENATE gv_req_date+4(2) gv_req_date+6(2) gv_req_date+0(4)
                INTO gv_req_date SEPARATED BY '-'.
ENDIF.




















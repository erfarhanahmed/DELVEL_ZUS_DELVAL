
SELECT SINGLE sgtxt INTO gv_remark FROM bseg
    WHERE belnr = wa_bseg-belnr
     AND  shkzg = 'H'
     AND  gjahr = wa_bseg-gjahr
     AND  bukrs = 'US00'.

*IF total < 0.
* total = total * -1.
*ENDIF.



















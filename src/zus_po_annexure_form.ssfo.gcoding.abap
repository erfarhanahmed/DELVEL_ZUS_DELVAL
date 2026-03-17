
SELECT ebeln
       ebelp
       loekz
       matnr
       werks
       menge
       meins FROM ekpo INTO TABLE it_ekpo
       WHERE ebeln   = wa_ekko-ebeln
        AND  matnr  = 'CTBG'
        AND  loekz NE 'L'.



SORT it_ekpo BY ebelp.






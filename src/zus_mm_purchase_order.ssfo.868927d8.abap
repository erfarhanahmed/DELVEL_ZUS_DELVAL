
CLEAR wa_eskl.
select SINGLE * from eskl into wa_eskl where HPACKNO =  wa_item-packno.

SELECT SINGLE * FROM esll INTO wa_esll WHERE PACKNO = wa_item-packno.

SELECT SINGLE * FROM esll INTO wa_serv WHERE PACKNO = wa_esll-SUB_PACKNO.






















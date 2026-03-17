


*SELECT SINGLE * FROM konv INTO wa_konv
*  WHERE KNUMV = IS_VBDKA-KNUMV
*    AND posnr = wa_final-posnr
*    AND kschl = 'ZPR0'.
READ TABLE IT_KONV INTO WA_KONV WITH KEY kposn = wa_final-posnr
                                         kschl = 'ZPR0'.


GV_SUBTOT = GV_SUBTOT + WA_KONV-KWERT.

GV_TOT = GV_SUBTOT + GV_SALE + GV_HANDLING
         + GV_SERVICE + GV_MOUNTING .










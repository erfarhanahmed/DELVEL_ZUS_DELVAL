SELECT ebeln
       inco2
  from ekko
  into TABLE it_ekko1
  where ebeln = WA_HDR-EBELN.

  loop at it_ekko1 into wa_ekko1.

    wa_item-inco2 = wa_ekko1-inco2.
    ENDLOOP.


























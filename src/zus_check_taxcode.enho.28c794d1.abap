"Name: \PR:SAPMV45A\FO:USEREXIT_SAVE_DOCUMENT\SE:BEGIN\EI
ENHANCEMENT 0 ZUS_CHECK_TAXCODE.

IF VBAK-BUKRS_VF = 'US00'.
DATA: it_komv type table of komv,
      wa_komv TYPE komv,
      lt_komv type table of komv,
      ls_komv TYPE komv.

CLEAR :it_komv,
       lt_komv.

it_komv[] = xkomv[] .
lt_komv[] = xkomv[] .

if vbak-vtweg NE '30'.
IF VBAK-AUART NE 'US02' .


DELETE  lt_komv WHERE kschl NE 'ULOC' and kschl NE 'USTA' and kschl NE 'UCOU' and kschl NE 'UOTH'.

CLEAR wa_komv.

IF lt_komv IS INITIAL.
  READ TABLE it_komv INTO wa_komv WITH KEY kschl = 'UDNI'.
    IF sy-subrc = 4.
       MESSAGE 'Maintain Condition Type UDNI' TYPE 'E'.
    ENDIF.
ENDIF.

ENDIF.
endif.

CLEAR wa_komv.
LOOP AT it_komv INTO wa_komv.
IF wa_komv-kschl = 'UDNI' AND wa_komv-MWSK1 NE 'U2'.
Message 'Wrong Tax Code maintain For Condition type UDNI' type 'E'.
ENDIF.

IF wa_komv-kschl = 'UENI' AND wa_komv-MWSK1 NE 'U1'.
Message 'Wrong Tax Code maintain For Condition type UENI' type 'E'.
ENDIF.

ENDLOOP.

ENDIF.

ENDENHANCEMENT.

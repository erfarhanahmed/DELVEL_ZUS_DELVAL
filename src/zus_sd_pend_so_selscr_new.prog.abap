*&---------------------------------------------------------------------*
*&  Include           ZUS_SD_PEND_SO_SELSCR
*&---------------------------------------------------------------------*
IF SY-TCODE = 'ZUS_PENDSO'.

   IF sy-repid = 'ZUS_SD_PEND_SO_NEW' .



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME .
SELECT-OPTIONS   :  s_date FOR wa_vbak-erdat OBLIGATORY ,
                    s_matnr FOR wa_vbap-matnr,
                    s_kunnr FOR wa_vbak-kunnr,
                    s_vbeln FOR wa_vbap-vbeln,
                    s_DDATE FOR wa_vbap-CUSTDELDATE.
PARAMETERS : s_werks TYPE vbap-werks OBLIGATORY DEFAULT 'US01'.
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-002.
PARAMETERS open_so  RADIOBUTTON GROUP code DEFAULT 'X' USER-COMMAND codegen.
PARAMETERS all_so  RADIOBUTTON GROUP code.
SELECTION-SCREEN END OF BLOCK b3.

SELECT-OPTIONS:  s_kschl   FOR  wa_konv-kschl NO-DISPLAY .
SELECT-OPTIONS:  s_stat   FOR  wa_jest1-stat NO-DISPLAY .

SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE TEXT-074 .
PARAMETERS p_down AS CHECKBOX.
PARAMETERS p_folder LIKE rlgrap-filename DEFAULT '/delval/usa' ."'E:/delval/usa130'.
SELECTION-SCREEN END OF BLOCK b5.

DATA wa_kschl LIKE s_kschl.
DATA wa_jest LIKE s_stat.
DATA wa_werks like s_werks.
CLEAR: wa_kschl , wa_jest.

wa_kschl-sign = 'I'.
wa_kschl-option = 'EQ'.
wa_kschl-low = 'ZPRO'.
APPEND wa_kschl TO s_kschl.

wa_kschl-sign = 'I'.
wa_kschl-option = 'EQ'.
wa_kschl-low = 'VPRS'.
APPEND wa_kschl TO s_kschl.

wa_jest-sign = 'I'.
wa_jest-option = 'EQ'.
wa_jest-low = 'E0001'.
APPEND wa_jest TO s_stat.

wa_jest-sign = 'I'.
wa_jest-option = 'EQ'.
wa_jest-low = 'E0002'.
APPEND wa_jest TO s_stat.

wa_jest-sign = 'I'.
wa_jest-option = 'EQ'.
wa_jest-low = 'E0003'.
APPEND wa_jest TO s_stat.

 MESSAGE 'This Tcode is discontinued. Kindly use ZUS_NEW_PENDSO Tcode' TYPE 'E'.
   ENDIF.

   endif.

*&---------------------------------------------------------------------*
*& Report ZUS_SD_PEND_SO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*



REPORT ZUS_SD_PEND_SO_NEW.

IF SY-TCODE = 'ZUS_PENDSO'.

  " IF sy-repid = 'ZUS_SD_PEND_SO_NEW' .
      MESSAGE 'This Tcode is discontinued. Kindly use ZUS_NEW_PENDSO Tcode' TYPE 'E'.
  " ENDIF.
 ENDIF.



INCLUDE ZUS_SD_PEND_SO_TOP_NEW.
*INCLUDE zus_sd_pend_so_top.

INCLUDE ZUS_SD_PEND_SO_SELSCR_NEW.
*INCLUDE zus_sd_pend_so_selscr.

INCLUDE ZUS_SD_PEND_SO_DATASEL_NEW.
*INCLUDE zus_sd_pend_so_datasel.

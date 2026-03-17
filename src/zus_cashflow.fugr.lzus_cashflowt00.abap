*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZUS_CASHFLOW....................................*
DATA:  BEGIN OF STATUS_ZUS_CASHFLOW                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUS_CASHFLOW                  .
CONTROLS: TCTRL_ZUS_CASHFLOW
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZUS_CASHFLOW                  .
TABLES: ZUS_CASHFLOW                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

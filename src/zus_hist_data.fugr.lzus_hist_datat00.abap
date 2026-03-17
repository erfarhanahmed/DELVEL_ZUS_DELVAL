*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZUS_HIST_DATA...................................*
DATA:  BEGIN OF STATUS_ZUS_HIST_DATA                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUS_HIST_DATA                 .
CONTROLS: TCTRL_ZUS_HIST_DATA
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZUS_HIST_DATA                 .
TABLES: ZUS_HIST_DATA                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

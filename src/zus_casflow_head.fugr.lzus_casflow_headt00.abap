*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZUS_CASFLOW_HEAD................................*
DATA:  BEGIN OF STATUS_ZUS_CASFLOW_HEAD              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUS_CASFLOW_HEAD              .
CONTROLS: TCTRL_ZUS_CASFLOW_HEAD
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZUS_CASFLOW_HEAD              .
TABLES: ZUS_CASFLOW_HEAD               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

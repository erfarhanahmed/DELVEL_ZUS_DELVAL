*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZUS_CASFLOW_ITEM................................*
DATA:  BEGIN OF STATUS_ZUS_CASFLOW_ITEM              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUS_CASFLOW_ITEM              .
CONTROLS: TCTRL_ZUS_CASFLOW_ITEM
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZUS_CASFLOW_ITEM              .
TABLES: ZUS_CASFLOW_ITEM               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

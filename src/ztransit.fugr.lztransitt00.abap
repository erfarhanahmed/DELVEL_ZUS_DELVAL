*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTRANSIT........................................*
DATA:  BEGIN OF STATUS_ZTRANSIT                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTRANSIT                      .
CONTROLS: TCTRL_ZTRANSIT
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTRANSIT                      .
TABLES: ZTRANSIT                       .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

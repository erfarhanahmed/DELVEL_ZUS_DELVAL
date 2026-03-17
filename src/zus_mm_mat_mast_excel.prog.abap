*&---------------------------------------------------------------------*
*& Report ZUS_MM_MAT_MAST_EXCEL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_MM_MAT_MAST_EXCEL.


INCLUDE ZUS_MAT_MAST_EXCEL_FORMAT.

START-OF-SELECTION.
  PERFORM fill_data.
  PERFORM download_data.
  PERFORM modify_cells.
  PERFORM cell_border.

*&---------------------------------------------------------------------*
*&      Form  FILL_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fill_data .
***START OF COLUMN NUMBERS

  wa_data-field1  = 'Industry sector'.
  wa_data-field2  = 'External Material No.'.
  wa_data-field3  = 'Material Type'.
  wa_data-field4  = 'Plant'.
  wa_data-field5  = 'Storage Location'.
  wa_data-field6  = 'Sales Organization'.
  wa_data-field7  = 'Distribution Channel'.
  wa_data-field8  = 'Material Description (Short Text)'.
  wa_data-field9  = 'Base Unit of Measure'.
  wa_data-FIELD10 = 'Old Mat No'.
  wa_data-FIELD11 = 'Alt UOM'.
  wa_data-FIELD12 = 'Conv Factor'.
  wa_data-FIELD13 = 'Conv Factor'.
  wa_data-FIELD14 = 'BRAND'.
  wa_data-FIELD15 = 'SERIES'.
  wa_data-FIELD16 = 'SIZE'.
  wa_data-FIELD17 = 'MOC'.
  wa_data-FIELD18 = 'Type'.
  wa_data-FIELD19 = 'External Material Group'.
  wa_data-FIELD20 = 'Material Group'.
  wa_data-FIELD21 = 'Division'.
  wa_data-FIELD22 = 'Gross Weight'.
  wa_data-FIELD23 = 'Net Weight'.
  wa_data-FIELD24 = 'Tax classification material'.
  wa_data-FIELD25 = 'Tax classification material'.
  wa_data-FIELD26 = 'Tax classification material'.
  wa_data-FIELD27 = 'Tax classification material'.
  wa_data-FIELD28 = 'Delivering Plant (Own or External)'.
  wa_data-FIELD29 = 'Matl statistics grp'.
  wa_data-FIELD30 = 'Account assignment group for this material'.
  wa_data-FIELD31 = 'General item category group'.
  wa_data-FIELD32 = 'Item category group from material master'.
  wa_data-FIELD33 = 'Availability Check'.
  wa_data-FIELD34 = 'Transportation Group'.
  wa_data-FIELD35 = 'Loading Group'.
  wa_data-FIELD36 = 'Matl Grp Pack.Matls'.
  wa_data-FIELD37 = 'Profit Center'.
  wa_data-FIELD38 = 'Serial No Profile'.
  wa_data-FIELD39 = 'Purchase Order Unit'.
  wa_data-FIELD40 = 'Purchasing Group'.
  wa_data-FIELD41 = 'MRP type'.
  wa_data-FIELD42 = 'MRP Controller'.
  wa_data-FIELD43 = 'Minimum Order Quantity'.
  wa_data-FIELD44 = 'Lot Size'.
  wa_data-FIELD45 = 'Procurement Type'.
  wa_data-FIELD46 = 'Special Procurement Type'.
  wa_data-FIELD47 = 'Replinishment Lead Time'.
  wa_data-FIELD48 = 'Planned Delivery Time'.
  wa_data-FIELD49 = 'Scheduling Margin Key.'.
  wa_data-FIELD50 = 'Strategy group'.
  wa_data-FIELD51 = 'Consumption mode'.
  wa_data-FIELD52 = 'Consumption period: backward'.
  wa_data-FIELD53 = 'Consumption period: forward'.
  wa_data-FIELD54 = 'Individual/Coll'.
  wa_data-FIELD55 = 'Production Scheduler'.
  wa_data-FIELD56 = 'Prod Sched Profile'.
  wa_data-FIELD57 = 'In-house production time'.
  wa_data-FIELD58 = 'Unit of issue'.
  wa_data-FIELD59 = 'Valuation Class'.
  wa_data-FIELD60 = 'Price control indicator'.
  wa_data-FIELD61 = 'Moving Average Price/Periodic Unit Price'.
  wa_data-FIELD62 = 'Standard Price'.
  wa_data-FIELD63 = 'With Qty Structure'.
  wa_data-FIELD64 = 'Costing Lot Size'.
  wa_data-FIELD65 = 'Class'.
  wa_data-FIELD66 = 'Characteristic1'.
  wa_data-FIELD67 = 'Characteristic2'.
  wa_data-FIELD68 = 'Characteristic3'.
  wa_data-FIELD69 = 'Characteristic4'.
  wa_data-FIELD70 = 'Characteristic5'.
  wa_data-FIELD71 = 'Characteristic6'.
  wa_data-FIELD72 = 'Characteristic7'.
  wa_data-FIELD73 = 'Characteristic8'.
  wa_data-FIELD74 = 'Characteristic9'.
  wa_data-FIELD75 = 'Storage Bin'.
  wa_data-FIELD76 = 'Storage Condition '.
  wa_data-FIELD77 = 'Chapter ID'.
  wa_data-FIELD78 = 'No of GR per EI'.
  wa_data-FIELD79 = 'Material Can be sent to subcon'.
  wa_data-FIELD80 = 'Material Type'.
  wa_data-FIELD81 = 'Output Material'.
  wa_data-FIELD82 = 'Assessable Value'.
  wa_data-FIELD83 = 'Long text'.
  wa_data-FIELD84 = 'QM proc active'.
  wa_data-FIELD85 = 'QM Control Key'.
  wa_data-FIELD86 = 'Inspection Type'.
  wa_data-FIELD87 = 'QA Control Key'.
  wa_data-FIELD88 = 'Maintenance status'.
  wa_data-FIELD89 = 'Mixed_mrp Ind.'.
  wa_data-FIELD90 = 'Document'.
  wa_data-FIELD91 = 'Document Version'.
  wa_data-FIELD92 = 'Basic Material'.


  APPEND wa_data TO it_data.

  CREATE OBJECT application 'EXCEL.APPLICATION'.
  SET PROPERTY OF application 'VISIBLE' = 1.
  CALL METHOD OF
    application
      'WORKBOOKS' = workbook.

* CREATE NEW WORKSHEET
  SET PROPERTY OF application 'SHEETSINNEWWORKBOOK' = 1.
  CALL METHOD OF
    workbook
    'ADD'.

* CREATE FIRST EXCEL SHEET
  CALL METHOD OF
  application
  'WORKSHEETS' = sheet
  EXPORTING
    #1           = 1.
  CALL METHOD OF
    sheet
    'ACTIVATE'.
  SET PROPERTY OF sheet 'NAME' = 'Info Record Create'.


ENDFORM.                    " FILL_DATA
*&---------------------------------------------------------------------*
*&      Form  DOWNLOAD_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM download_data .

***********************************************
* DOWNLOAD COLUMN NUMBERS DATA TO EXCEL SPREADSHEET   *
***********************************************

  ld_rowindx = 1. "START AT ROW 1 FOR COLUMN NUMBERS
  LOOP AT it_data INTO wa_data.
    ld_rowindx = sy-tabix . "START AT ROW 3 (LEAVE 1ST FOR FOR COLUMN NUMBER , 2ND FOR HEADING & 3RD FOR SUB-HEADING

*   FILL COLUMNS FOR CURRENT ROW
    CLEAR ld_colindx.
    DO.
      ASSIGN COMPONENT sy-index OF STRUCTURE wa_data TO <fs>.
      IF sy-subrc NE 0.
        EXIT.
      ENDIF.
      ld_colindx = sy-index.
      CALL METHOD OF
      sheet
      'CELLS' = cells
      EXPORTING
        #1      = ld_rowindx
        #2      = ld_colindx.
      SET PROPERTY OF cells 'VALUE' = <fs>.
    ENDDO.
  ENDLOOP.

ENDFORM.                    " DOWNLOAD_DATA
*&---------------------------------------------------------------------*
*&      Form  MODIFY_CELLS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM modify_cells .

***********************************************
****FORMATTING OF COLUMN NUMBER ROW ***********
***********************************************
  CALL METHOD OF
  application
  'CELLS'     = cell1
  EXPORTING
    #1          = 1     "DOWN
    #2          = 1.    "ACROSS
*END OF RANGE CELL
  CALL METHOD OF
  application
  'CELLS'     = cell2
  EXPORTING
    #1          = 1     "DOWN
    #2          = 51.   "ACROSS

  CALL METHOD OF
  application
  'RANGE'     = range
  EXPORTING
    #1          = cell1
    #2          = cell2.
***********************************************
* MODIFY PROPERTIES OF CELL RANGE             *
***********************************************
* SET FONT DETAILS OF RANGE

  GET PROPERTY OF range 'FONT' = font.
  SET PROPERTY OF font 'SIZE' = 12.

* SET CELL SHADING PROPERTIES OF RANGE
  CALL METHOD OF
    range
      'INTERIOR' = shading.
  SET PROPERTY OF shading 'COLORINDEX' = 0. "COLOUR - CHANGE NUMBER FOR DIFF COLOURS
  SET PROPERTY OF shading 'PATTERN' = 1. "PATTERN - SOLID, STRIPED ETC
  FREE OBJECT shading.

***********************************************
*****END OF FORMATTING OF COLUMN NUMBER ROW****
***********************************************



ENDFORM.                    " MODIFY_CELLS
*&---------------------------------------------------------------------*
*&      Form  CELL_BORDER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM cell_border .

*************************************************
*** MODIFY PROPERTIES OF CELL RANGE             *
*************************************************

  FREE range.
  CALL METHOD OF application 'CELLS' = cell1  "START CELL
  EXPORTING
    #1 = 1     "DOWN
    #2 = 1.    "ACROSS

  CALL METHOD OF application 'CELLS' = cell2 "END CELL
  EXPORTING
    #1 = 1    "DOWN
    #2 = 51.   "ACROSS

  CALL METHOD OF
  application
  'RANGE'     = range
  EXPORTING
    #1          = cell1
    #2          = cell2.


* SET BORDER PROPERTIES OF RANGE
  CALL METHOD OF
  range
  'BORDERS' = border
  EXPORTING
    #1        = '1'.  "LEFT
  SET PROPERTY OF border 'LINESTYLE' = '1'. "LINE STYLE SOLID, DASHED...
  SET PROPERTY OF border 'WEIGHT' = 1.                      "MAX = 4
  FREE OBJECT border.

  CALL METHOD OF
  range
  'BORDERS' = border
  EXPORTING
    #1        = '2'.  "RIGHT
  SET PROPERTY OF border 'LINESTYLE' = '1'.
  SET PROPERTY OF border 'WEIGHT' = 2.                      "MAX = 4
  FREE OBJECT border.

  CALL METHOD OF
  range
  'BORDERS' = border
  EXPORTING
    #1        = '3'.   "TOP
  SET PROPERTY OF border 'LINESTYLE' = '1'.
  SET PROPERTY OF border 'WEIGHT' = 2.                      "MAX = 4
  FREE OBJECT border.

  CALL METHOD OF
  range
  'BORDERS' = border
  EXPORTING
    #1        = '4'.   "BOTTOM
  SET PROPERTY OF border 'LINESTYLE' = '1'.
  SET PROPERTY OF border 'WEIGHT' = 2.                      "MAX = 4
  FREE OBJECT border.

* OVERWITES ALL CELL VALUES IN RANGE TO EQUAL 'TEST'
* SET PROPERTY OF RANGE    'VALUE' = 'TEST'.


***********************************************
* SET COLUMNS TO AUTO FIT TO WIDTH OF TEXT    *
***********************************************
  CALL METHOD OF
    application
      'COLUMNS' = column.
  CALL METHOD OF
    column
    'AUTOFIT'.

  FREE OBJECT column.

***********************************************
* SAVE EXCEL SPEADSHEET TO PARTICULAR FILENAME*
*************************************#*********
  CALL METHOD OF
    sheet
    'SAVEAS'
    EXPORTING
      #1 = 'D:\SAP_DATA\EmpVenodr.XLS'     "FILENAME
**       #1       = '/home/lalit/Upload_FERT_Finished_Material.XLS'     "FILENAME
      #2 = 1.                          "FILEFORMAT

  FREE OBJECT sheet.
  FREE OBJECT workbook.
  FREE OBJECT application.

ENDFORM.                    " CELL_BORDER

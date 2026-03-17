*&---------------------------------------------------------------------*
*& Report ZUS_SD_CUST_MASTER_EXCEL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_SD_CUST_MASTER_EXCEL.




DATA:  field1       TYPE c LENGTH 40 VALUE    'Company code',
       field2       TYPE c LENGTH 40 VALUE    'Sales organization',
       field3       TYPE c LENGTH 40 VALUE    'Distribution channel',
       field4       TYPE c LENGTH 40 VALUE    'Division',
       field5       TYPE c LENGTH 40 VALUE    'Account group',
       field6       TYPE c LENGTH 40 VALUE    'Title',
       field7       TYPE c LENGTH 40 VALUE    'Name',
       field8       TYPE c LENGTH 40 VALUE    'Search term',
       field9       TYPE c LENGTH 40 VALUE    'Name',
       field10      TYPE c LENGTH 40 VALUE    'Name',
       field11      TYPE c LENGTH 40 VALUE    'Name',
       field12      TYPE c LENGTH 40 VALUE    'Street',
       field13      TYPE c LENGTH 40 VALUE    'PO Box',
       field14      TYPE c LENGTH 40 VALUE    'City',
       field15      TYPE c LENGTH 40 VALUE    'Postal Code',
       FIELD16      TYPE c LENGTH 40 VALUE    'District',
       FIELD17      TYPE c LENGTH 40 VALUE    'P.O.Box city',
       FIELD18      TYPE c LENGTH 40 VALUE    'PO Box PCode',
       FIELD19      TYPE c LENGTH 40 VALUE    'Country',
       FIELD20      TYPE c LENGTH 40 VALUE    'Region',
       FIELD21      TYPE c LENGTH 40 VALUE    'Language Key',
       FIELD22      TYPE c LENGTH 40 VALUE    'Telephone 1',
       FIELD23      TYPE c LENGTH 40 VALUE    'Fax Number',
       FIELD24      TYPE c LENGTH 40 VALUE    'Email ',
       FIELD25      TYPE c LENGTH 40 VALUE    'Industry key',
       FIELD26      TYPE c LENGTH 40 VALUE    'Contact Person',
       FIELD27      TYPE c LENGTH 40 VALUE    'First Name',

       FIELD28      TYPE c LENGTH 40 VALUE    'Recon. account',
       FIELD29      TYPE c LENGTH 40 VALUE    'Prev.acct no.',
       FIELD30      TYPE c LENGTH 40 VALUE    'Sales district',
       FIELD31      TYPE c LENGTH 40 VALUE    'Order probab.',
       FIELD32      TYPE c LENGTH 40 VALUE    'Sales Office',
       FIELD33      TYPE c LENGTH 40 VALUE    'Sales Group',
       FIELD34      TYPE c LENGTH 40 VALUE    'Customer group',
       FIELD35      TYPE c LENGTH 40 VALUE    'Currency',
       FIELD36      TYPE c LENGTH 40 VALUE    'Cust.pric.proc.',
       FIELD37      TYPE c LENGTH 40 VALUE    'Cust.Stats.Grp',
       FIELD38      TYPE c LENGTH 40 VALUE    'Delivery Priority',
       FIELD39      TYPE c LENGTH 40 VALUE    'Order Combination',
       FIELD40      TYPE c LENGTH 40 VALUE    'Shipping Conditions',
       FIELD41      TYPE c LENGTH 40 VALUE    'Delivering Plant',
       FIELD42      TYPE c LENGTH 40 VALUE    'Max.Part.Deliveries',
       FIELD43      TYPE c LENGTH 40 VALUE    'Incoterms',
       FIELD44      TYPE c LENGTH 40 VALUE    'Incoterms description',
       FIELD45      TYPE c LENGTH 40 VALUE    'Payt Terms',
       FIELD46      TYPE c LENGTH 40 VALUE    'AcctAssgGr',
       FIELD47      TYPE c LENGTH 40 VALUE    'Tax Classification',
       FIELD48      TYPE c LENGTH 40 VALUE    'Tax Classification',
       FIELD49      TYPE c LENGTH 40 VALUE    'Tax Classification'.
*       FIELD49      TYPE c LENGTH 40 VALUE    'Tax Classification'.




INCLUDE ZCUST_MASTER_EXCEL_FORMAT.

START-OF-SELECTION.
  PERFORM FILL_DATA.
  PERFORM DOWNLOAD_DATA.
  PERFORM MODIFY_CELLS.
  PERFORM CELL_BORDER.

*&---------------------------------------------------------------------*
*&      Form  FILL_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FILL_DATA .
***START OF COLUMN NUMBERS


  WA_DATA-FIELD1  = field1.
  WA_DATA-FIELD2  = field2.
  WA_DATA-FIELD3  = field3.
  WA_DATA-FIELD4  = field4.
  WA_DATA-field5   = field5 .
  WA_DATA-field6   = field6 .
  WA_DATA-field7   = field7 .
  WA_DATA-field8   = field8 .
  WA_DATA-field9   = field9 .
  WA_DATA-field10  = field10.
  WA_DATA-field11  = field11.
  WA_DATA-field12  = field12.
  WA_DATA-field13  = field13.
  WA_DATA-field14  = field14.
  WA_DATA-field15  = field15.
  WA_DATA-FIELD16  = FIELD16.
  WA_DATA-FIELD17  = FIELD17.
  WA_DATA-FIELD18  = FIELD18.
  WA_DATA-FIELD19  = FIELD19.
  WA_DATA-FIELD20  = FIELD20.
  WA_DATA-FIELD21  = FIELD21.
  WA_DATA-FIELD22  = FIELD22.
  WA_DATA-FIELD23  = FIELD23.
  WA_DATA-FIELD24  = FIELD24.
  WA_DATA-FIELD25  = FIELD25.
  WA_DATA-FIELD26  = FIELD26.
  WA_DATA-FIELD27  = FIELD27.
  WA_DATA-FIELD28  = FIELD28.
  WA_DATA-FIELD29  = FIELD29.
  WA_DATA-FIELD30  = FIELD30.
  WA_DATA-FIELD31  = FIELD31.
  WA_DATA-FIELD32  = FIELD32.
  WA_DATA-FIELD33  = FIELD33.
  WA_DATA-FIELD34  = FIELD34.
  WA_DATA-FIELD35  = FIELD35.
  WA_DATA-FIELD36  = FIELD36.
  WA_DATA-FIELD37  = FIELD37.
  WA_DATA-FIELD38  = FIELD38.
  WA_DATA-FIELD39  = FIELD39.
  WA_DATA-FIELD40  = FIELD40.
  WA_DATA-FIELD41  = FIELD41.
  WA_DATA-FIELD42  = FIELD42.
  WA_DATA-FIELD43  = FIELD43.
  WA_DATA-FIELD44  = FIELD44.
  WA_DATA-FIELD45  = FIELD45.
  WA_DATA-FIELD46  = FIELD46.
  WA_DATA-FIELD47  = FIELD47.
  WA_DATA-FIELD48  = FIELD48.
  WA_DATA-FIELD49  = FIELD49.


APPEND WA_DATA TO IT_DATA.

  CREATE OBJECT APPLICATION 'EXCEL.APPLICATION'.
  SET PROPERTY OF APPLICATION 'VISIBLE' = 1.
  CALL METHOD OF
    APPLICATION
      'WORKBOOKS' = WORKBOOK.

* CREATE NEW WORKSHEET
  SET PROPERTY OF APPLICATION 'SHEETSINNEWWORKBOOK' = 1.
  CALL METHOD OF
    WORKBOOK
    'ADD'.

* CREATE FIRST EXCEL SHEET
  CALL METHOD OF
  APPLICATION
  'WORKSHEETS' = SHEET
  EXPORTING
    #1           = 1.
  CALL METHOD OF
    SHEET
    'ACTIVATE'.
  SET PROPERTY OF SHEET 'NAME' = 'CUSTOMER_MASTER'.


ENDFORM.                    " FILL_DATA
*&---------------------------------------------------------------------*
*&      Form  DOWNLOAD_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DOWNLOAD_DATA .

***********************************************
* DOWNLOAD COLUMN NUMBERS DATA TO EXCEL SPREADSHEET   *
***********************************************

  LD_ROWINDX = 1. "START AT ROW 1 FOR COLUMN NUMBERS
  LOOP AT IT_DATA INTO WA_DATA.
    LD_ROWINDX = SY-TABIX . "START AT ROW 3 (LEAVE 1ST FOR FOR COLUMN NUMBER , 2ND FOR HEADING & 3RD FOR SUB-HEADING

*   FILL COLUMNS FOR CURRENT ROW
    CLEAR LD_COLINDX.
    DO.
      ASSIGN COMPONENT SY-INDEX OF STRUCTURE WA_DATA TO <FS>.
      IF SY-SUBRC NE 0.
        EXIT.
      ENDIF.
      LD_COLINDX = SY-INDEX.
      CALL METHOD OF
      SHEET
      'CELLS' = CELLS
      EXPORTING
        #1      = LD_ROWINDX
        #2      = LD_COLINDX.
      SET PROPERTY OF CELLS 'VALUE' = <FS>.
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
FORM MODIFY_CELLS .

***********************************************
****FORMATTING OF COLUMN NUMBER ROW ***********
***********************************************
  CALL METHOD OF
  APPLICATION
  'CELLS'     = CELL1
  EXPORTING
    #1          = 1     "DOWN
    #2          = 1.    "ACROSS
*END OF RANGE CELL
  CALL METHOD OF
  APPLICATION
  'CELLS'     = CELL2
  EXPORTING
    #1          = 1     "DOWN
    #2          = 51.   "ACROSS

  CALL METHOD OF
  APPLICATION
  'RANGE'     = RANGE
  EXPORTING
    #1          = CELL1
    #2          = CELL2.
***********************************************
* MODIFY PROPERTIES OF CELL RANGE             *
***********************************************
* SET FONT DETAILS OF RANGE

  GET PROPERTY OF RANGE 'FONT' = FONT.
  SET PROPERTY OF FONT 'SIZE' = 12.

* SET CELL SHADING PROPERTIES OF RANGE
  CALL METHOD OF
    RANGE
      'INTERIOR' = SHADING.
  SET PROPERTY OF SHADING 'COLORINDEX' = 0. "COLOUR - CHANGE NUMBER FOR DIFF COLOURS
  SET PROPERTY OF SHADING 'PATTERN' = 1. "PATTERN - SOLID, STRIPED ETC
  FREE OBJECT SHADING.

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
FORM CELL_BORDER .

*************************************************
*** MODIFY PROPERTIES OF CELL RANGE             *
*************************************************

  FREE RANGE.
  CALL METHOD OF APPLICATION 'CELLS' = CELL1  "START CELL
  EXPORTING
    #1 = 1     "DOWN
    #2 = 1.    "ACROSS

  CALL METHOD OF APPLICATION 'CELLS' = CELL2 "END CELL
  EXPORTING
    #1 = 1    "DOWN
    #2 = 51.   "ACROSS

  CALL METHOD OF
  APPLICATION
  'RANGE'     = RANGE
  EXPORTING
    #1          = CELL1
    #2          = CELL2.


* SET BORDER PROPERTIES OF RANGE
  CALL METHOD OF
  RANGE
  'BORDERS' = BORDER
  EXPORTING
    #1        = '1'.  "LEFT
  SET PROPERTY OF BORDER 'LINESTYLE' = '1'. "LINE STYLE SOLID, DASHED...
  SET PROPERTY OF BORDER 'WEIGHT' = 1.                      "MAX = 4
  FREE OBJECT BORDER.

  CALL METHOD OF
  RANGE
  'BORDERS' = BORDER
  EXPORTING
    #1        = '2'.  "RIGHT
  SET PROPERTY OF BORDER 'LINESTYLE' = '1'.
  SET PROPERTY OF BORDER 'WEIGHT' = 2.                      "MAX = 4
  FREE OBJECT BORDER.

  CALL METHOD OF
  RANGE
  'BORDERS' = BORDER
  EXPORTING
    #1        = '3'.   "TOP
  SET PROPERTY OF BORDER 'LINESTYLE' = '1'.
  SET PROPERTY OF BORDER 'WEIGHT' = 2.                      "MAX = 4
  FREE OBJECT BORDER.

  CALL METHOD OF
  RANGE
  'BORDERS' = BORDER
  EXPORTING
    #1        = '4'.   "BOTTOM
  SET PROPERTY OF BORDER 'LINESTYLE' = '1'.
  SET PROPERTY OF BORDER 'WEIGHT' = 2.                      "MAX = 4
  FREE OBJECT BORDER.

* OVERWITES ALL CELL VALUES IN RANGE TO EQUAL 'TEST'
* SET PROPERTY OF RANGE    'VALUE' = 'TEST'.


***********************************************
* SET COLUMNS TO AUTO FIT TO WIDTH OF TEXT    *
***********************************************
  CALL METHOD OF
    APPLICATION
      'COLUMNS' = COLUMN.
  CALL METHOD OF
    COLUMN
    'AUTOFIT'.

  FREE OBJECT COLUMN.

***********************************************
* SAVE EXCEL SPEADSHEET TO PARTICULAR FILENAME*
*************************************#*********
  CALL METHOD OF
    SHEET
    'SAVEAS'
    EXPORTING
      #1 = 'D:\SAP_DATA\CUSTOMER_MASTER.XLS'     "FILENAME
      #2 = 1.                          "FILEFORMAT

  FREE OBJECT SHEET.
  FREE OBJECT WORKBOOK.
  FREE OBJECT APPLICATION.

ENDFORM.                    " CELL_BORDER

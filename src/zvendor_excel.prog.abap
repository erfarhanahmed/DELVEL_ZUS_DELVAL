*&---------------------------------------------------------------------*
*& Report ZVENDOR_EXCEL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZVENDOR_EXCEL.




DATA:  field1     TYPE c LENGTH 40 VALUE    'Company Code',
       field2     TYPE c LENGTH 40 VALUE    'Purchasing Org',
       field3     TYPE c LENGTH 40 VALUE    'Vendor AC group',
       field4     TYPE c LENGTH 40 VALUE    'Name 1',
       field5     TYPE c LENGTH 40 VALUE    'Search Term',
       field6     TYPE c LENGTH 40 VALUE    'Search Term 2',
       field7    TYPE  c LENGTH 40 VALUE    'Street',
       field8    TYPE c LENGTH 40 VALUE     'Street 4',
       field9    TYPE c LENGTH 40 VALUE     'Street 5',
       field10    TYPE c LENGTH 40 VALUE    'District',
       field11     TYPE c LENGTH 40 VALUE   'City postal code',
       field12    TYPE  c LENGTH 40 VALUE   'CITY1',
       field13    TYPE  c LENGTH 40 VALUE   'COUNTRY',            "---------------
       field14    TYPE c LENGTH 40 VALUE    'REGION',
       field15    TYPE c LENGTH 40 VALUE 'Telephone No.',
       field16    TYPE c LENGTH 40 VALUE 'Cell Phone Number',
       field17    TYPE c LENGTH 40 VALUE 'Fax no',
       field18    TYPE c LENGTH 40 VALUE 'E-Mail Address',
       field19    TYPE c LENGTH 40 VALUE 'ECC Number',
       field20    TYPE c LENGTH 40 VALUE 'Excise Registration Number',
       field21    TYPE c LENGTH 40 VALUE 'Excise Range',
       field22    TYPE c LENGTH 40 VALUE 'Excise Division',

       field23    TYPE c LENGTH 40 VALUE 'Excise Commissionerate',
       field24    TYPE c LENGTH 40 VALUE 'Type of Vendor',
       field25    TYPE c LENGTH 40 VALUE 'Excise tax indicator for vendor',
       field26    TYPE c LENGTH 40 VALUE 'Central Sales Tax Number',
       field27    TYPE c LENGTH 40 VALUE 'Local Sales Tax Number',
       field28    TYPE c LENGTH 40 VALUE 'Service Tax Registration Number',
       field29    TYPE c LENGTH 40 VALUE 'Permanent Account Number',
       field30    TYPE c LENGTH 40 VALUE 'Reconciliation Account in General Ledger',
       field31    TYPE c LENGTH 40 VALUE 'Terms of Payment Key',


       field32    TYPE c LENGTH 40 VALUE 'Purchase order currency',

*       field29    TYPE c LENGTH 40 VALUE 'Tax Classification',
       field33    TYPE c LENGTH 40 VALUE 'Incoterms',
       field34    TYPE c LENGTH 40 VALUE 'Incoterms',
       field35    TYPE c LENGTH 40 VALUE 'Group for Calculation Schema',




       field36    TYPE c LENGTH 40 VALUE 'Responsible Salesperson at Vendor Office',
       field37    TYPE c LENGTH 40 VALUE 'Vendor telephone number',


*       field31    TYPE c LENGTH 40 VALUE 'Tax Classification',
*       field32    TYPE c LENGTH 40 VALUE 'CGST',
*       field33    TYPE c LENGTH 40 VALUE 'SGST',
*       field34    TYPE c LENGTH 40 VALUE 'IGST',
*       field35    TYPE c LENGTH 40 VALUE 'Payment term',
       field38    TYPE c LENGTH 40 VALUE 'Indicator: GR-Based Invoice Verification',
       field39    TYPE c LENGTH 40 VALUE 'Indicator for Service-Based Invoice Verification'.
*       field40    TYPE c LENGTH 40 VALUE 'Vend_Pay_Term '.

*       field25    TYPE c LENGTH 40 VALUE 'Unit of measure for the standard value',
*       field26    TYPE c LENGTH 40 VALUE 'Standard Value'.


INCLUDE ZVEN_EXCEL_FORMAT.

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
  WA_DATA-FIELD5  = field5.
  WA_DATA-FIELD6  = field6.
  WA_DATA-FIELD7  = field7.
  WA_DATA-FIELD8  = field8.
  WA_DATA-FIELD9  = field9.
  WA_DATA-FIELD10 = field10.
  WA_DATA-FIELD11 = field11.
  WA_DATA-FIELD12 = field12.
  WA_DATA-FIELD13 = field13.
  WA_DATA-FIELD14 = field14.
  WA_DATA-FIELD15 = field15.
  WA_DATA-FIELD16 = field16.
  WA_DATA-FIELD17 = field17.
  WA_DATA-FIELD18 = field18.
  WA_DATA-FIELD19 = field19.
  WA_DATA-FIELD20 = field20.
  WA_DATA-FIELD21 = field21.
  WA_DATA-FIELD22 = field22.
  WA_DATA-FIELD23 = field23.
  WA_DATA-FIELD24 = field24.
  WA_DATA-FIELD25 = field25.
  WA_DATA-FIELD26 = field26.
  WA_DATA-FIELD27 = field27.
  WA_DATA-FIELD28 = field28.
  WA_DATA-FIELD29 = field29.
  WA_DATA-FIELD30 = field30.
  WA_DATA-FIELD31 = field31.
  WA_DATA-FIELD32 = field32.
  WA_DATA-FIELD33 = field33.
  WA_DATA-FIELD34 = field34.
  WA_DATA-FIELD35 = field35.
  WA_DATA-FIELD36 = field36.
  WA_DATA-FIELD37 = field37.
  WA_DATA-FIELD38 = field38.
  WA_DATA-FIELD39 = field39.
*  WA_DATA-FIELD40 = field40.
*  WA_DATA-FIELD37 = field37.
*  WA_DATA-FIELD38 = field38.

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
  SET PROPERTY OF SHEET 'NAME' = 'VENDOR_MASTER'.


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
      #1 = 'D:\SAP_DATA\VENDOR_MASTER.XLS'     "FILENAME
      #2 = 1.                          "FILEFORMAT

  FREE OBJECT SHEET.
  FREE OBJECT WORKBOOK.
  FREE OBJECT APPLICATION.

ENDFORM.                    " CELL_BORDER

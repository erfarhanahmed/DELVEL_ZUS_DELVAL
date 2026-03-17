

REPORT zus_po_create_bapi.

"Type declaration for Excel table data
TYPES:
  BEGIN OF ty_pur_ord_create,
    sr_no         TYPE i,
    doc_type      TYPE bapimepoheader-doc_type,


    vendor        TYPE bapimepoheader-vendor,
    PMNTTRMS        TYPE bapimepoheader-PMNTTRMS,
*    INCOTERMS1    TYPE bapimepoheader-INCOTERMS1,
*    INCOTERMS2    TYPE bapimepoheader-INCOTERMS2,
    doc_date      TYPE bapimepoheader-doc_date,
    purch_org     TYPE bapimepoheader-purch_org,
    pur_group     TYPE bapimepoheader-pur_group,
*    vper_start    TYPE char10,
*    vper_end      TYPE char10,
*    acctasscat    TYPE bapimepoitem-acctasscat,

    header_id     TYPE bapimepotextheader-text_id,
    header_text   TYPE bapimepotextheader-text_line,
    item          TYPE ekpo-ebelp,
    material      TYPE bapimepoitem-material,
*    short_text    TYPE bapimepoitem-short_text,
    item_id       TYPE bapimepotext-text_id,
    item_text     TYPE bapimepotext-text_line,

    quantity      TYPE bapimepoitem-quantity,
    matl_group    TYPE bapimepoitem-matl_group,
    stge_loc      TYPE bapimepoitem-stge_loc,
    delivery_date TYPE bapimeposchedule-delivery_date,
*    COND_VALUE    TYPE BAPIMEPOCOND-COND_VALUE,
    CONF_CTRL     TYPE bapimepoitem-CONF_CTRL,

*    preq_no       TYPE bapimepoitem-preq_no,
*    costcenter    TYPE bapimepoaccount-costcenter,
*    gl_account    TYPE bapimepoaccount-gl_account,
*    short_text_s  TYPE bapiesllc-short_text,
*    sr_quantity   TYPE bapiesllc-quantity,
*    gr_price      TYPE bapiesllc-gr_price,
*    base_uom      TYPE bapiesllc-base_uom,
*    as_quantity   TYPE bapimepoaccount-quantity,
*    asset_no      TYPE bapimepoaccount-asset_no,
*    cond_type     TYPE bapimepocond-cond_type,
*
*    item_id       TYPE bapimepotext-text_id,
*    item_text     TYPE bapimepotext-text_line,
  END OF ty_pur_ord_create,
  tt_pur_ord_create TYPE STANDARD TABLE OF ty_pur_ord_create,

  tt_bapi_return    TYPE STANDARD TABLE OF bapiret2.

"Final Table for excel data into sap format
DATA:
  gt_pur_ord_create TYPE tt_pur_ord_create    ##NEEDED.


*-----------------------------------------------------------------*
* Selection Screen                                                *
*-----------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS : p_file TYPE rlgrap-filename OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

"Get File

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM get_filename
     CHANGING p_file  ##PERF_GLOBAL_PAR_OK.
  "Upload data from excel



START-OF-SELECTION.
*BREAK PRIMUS.
  PERFORM upload_data
   CHANGING gt_pur_ord_create.

*&---------------------------------------------------------------------*
*&      Form  GET_FILENAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_filename
     CHANGING c_file TYPE rlgrap-filename.
  CALL FUNCTION 'F4_FILENAME'
* EXPORTING
*   PROGRAM_NAME        = SYST-CPROG
*   DYNPRO_NUMBER       = SYST-DYNNR
*   FIELD_NAME          = ' '
    IMPORTING
      file_name = c_file.

ENDFORM.                    " GET_FILENAME
*&---------------------------------------------------------------------*
*&      Form  UPLOAD_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM upload_data
    CHANGING  ct_pur_ord_create TYPE tt_pur_ord_create.

  TYPE-POOLS:
    truxs.

  DATA:
  lt_raw TYPE truxs_t_text_data.

  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
*     I_FIELD_SEPERATOR    =
      i_line_header        = 'X'
      i_tab_raw_data       = lt_raw
      i_filename           = p_file
    TABLES
      i_tab_converted_data = ct_pur_ord_create
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ELSE.
    "IF data is found create PO
    IF NOT gt_pur_ord_create IS INITIAL.
      PERFORM create_po
       USING ct_pur_ord_create.
    ELSE.
      MESSAGE 'NO DATA EXISTS in EXCEL FILE'(002) TYPE 'E'.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDIF.

ENDFORM.                    " UPLOAD_DATA
*&---------------------------------------------------------------------*
*&      Form  CREATE_PO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_CT_PUR_ORD_CREATE  text
*----------------------------------------------------------------------*
FORM create_po
        USING ut_pur_ord_create TYPE tt_pur_ord_create.
  DATA:
    "Duplicate table for header data.
    lt_pur_ord_create_1  TYPE tt_pur_ord_create,
    "Work area of Header Data
    ls_poheader          TYPE bapimepoheader,
    "Work area of Header Data (Change Parameter)
    ls_poheaderx         TYPE bapimepoheaderx,
    "Variable for Purchasing Document Number
    l_purchaseorder      TYPE bapimepoheader-po_number,
    "Internal table and Work area for  Return Parameter
    lt_return            TYPE tt_bapi_return,
    ls_return            TYPE bapiret2,
    lS_return_1          TYPE bapiret2,
    "Internal table and Work area for Item Data
    lt_poitem            TYPE TABLE OF bapimepoitem,
    ls_poitem            TYPE bapimepoitem,
    "Internal table and Work area for Item Data (Change Parameter)
    lt_poitemx           TYPE TABLE OF bapimepoitemx,
    ls_poitemx           TYPE bapimepoitemx,
    "Internal table and Work area for Delivery Schedule
    lt_poschedule        TYPE TABLE OF bapimeposchedule,
    ls_poschedule        TYPE bapimeposchedule,
    "Internal table and Work area for Delivery Schedule (Change Parameter)
    lt_poschedulex       TYPE TABLE OF bapimeposchedulx,
    ls_poschedulex       TYPE bapimeposchedulx,
    "Internal table and Work area for Account Assignment Fields
    lt_poaccount         TYPE TABLE OF bapimepoaccount,
    ls_poaccount         TYPE bapimepoaccount,
    "Internal table and Work area for Account Assignment Fields (Change Parameter)
    lt_poaccountx        TYPE TABLE OF bapimepoaccountx,
    ls_poaccountx        TYPE bapimepoaccountx,
    "Internal table and Work area for Conditions (Items)
    lt_pocond            TYPE TABLE OF bapimepocond,
    ls_pocond            TYPE bapimepocond,
    "Internal table and Work area for Conditions (Items, Change Parameter)
    lt_pocondx           TYPE TABLE OF bapimepocondx,
    ls_pocondx           TYPE bapimepocondx,
    "Internal table and Work area for External Services: Service Lines
    lt_poservices        TYPE TABLE OF bapiesllc,
    ls_poservices        TYPE bapiesllc,
    "Internal table for Header Texts
    lt_potextheader      TYPE TABLE OF bapimepotextheader,
    ls_potextheader      TYPE bapimepotextheader,
    lt_posrvaccessvalues TYPE TABLE OF bapiesklc,
    "Internal table for Item Texts
    lt_potextitem        TYPE TABLE OF bapimepotext,
    ls_potextitem        TYPE  bapimepotext,

    lt_polimits          TYPE TABLE OF bapiesuhc,
    ls_polimits          TYPE  bapiesuhc.



  FIELD-SYMBOLS:
    <lfs_pur_ord_create>   TYPE ty_pur_ord_create,
    <lfs_pur_ord_create_1> TYPE ty_pur_ord_create.


  MOVE-CORRESPONDING  ut_pur_ord_create TO lt_pur_ord_create_1.

  DELETE ADJACENT DUPLICATES FROM ut_pur_ord_create.

  "sort data in ascending order as per serial number
  SORT ut_pur_ord_create
     BY sr_no.

  SORT lt_pur_ord_create_1
     BY sr_no.
  DELETE ADJACENT DUPLICATES FROM ut_pur_ord_create COMPARING sr_no.
  " get data and create po accordingly.
  LOOP AT ut_pur_ord_create ASSIGNING <lfs_pur_ord_create>.

    "PO HEADAER DATA
    "Company Code
    ls_poheader-comp_code   = 'US00'.
    ls_poheaderx-comp_code  = abap_true.
    "Document Type
    ls_poheader-doc_type    = <lfs_pur_ord_create>-doc_type.
    ls_poheaderx-doc_type   = abap_true.
    "Vendor
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = <lfs_pur_ord_create>-vendor
      IMPORTING
        output = <lfs_pur_ord_create>-vendor.
    ls_poheader-vendor      = <lfs_pur_ord_create>-vendor.
    ls_poheaderx-vendor     = abap_true.


    ls_poheader-PMNTTRMS      = <lfs_pur_ord_create>-PMNTTRMS.
    ls_poheaderx-PMNTTRMS     = abap_true.

*    ls_poheader-INCOTERMS1      = <lfs_pur_ord_create>-INCOTERMS1.
*    ls_poheaderx-INCOTERMS1     = abap_true.
*
*    ls_poheader-INCOTERMS2      = <lfs_pur_ord_create>-INCOTERMS2.
*    ls_poheaderx-INCOTERMS2     = abap_true.


    "Document Data
    ls_poheader-doc_date    = <lfs_pur_ord_create>-doc_date."sy-datum.
    ls_poheaderx-doc_date   = 'X'."abap_true.
    "purchasing Organisation
    ls_poheader-purch_org   = <lfs_pur_ord_create>-purch_org.
    ls_poheaderx-purch_org  = abap_true.
    "Purchasing Group
    ls_poheader-pur_group   = <lfs_pur_ord_create>-pur_group.
    ls_poheaderx-pur_group  = abap_true.

    "Validity Start and End Date
*    IF NOT <lfs_pur_ord_create>-vper_start IS INITIAL.
*      ls_poheader-vper_start  = <lfs_pur_ord_create>-vper_start.
*      ls_poheaderx-vper_start = abap_true.
*      ls_poheader-vper_end    = <lfs_pur_ord_create>-vper_end.
*      ls_poheaderx-vper_end   = abap_true.
*    ENDIF.

    IF NOT <lfs_pur_ord_create>-header_text IS INITIAL.
      ls_potextheader-po_item   =  00000.
      ls_potextheader-text_id   =  <lfs_pur_ord_create>-header_id.
      ls_potextheader-text_form =  '*' .
      ls_potextheader-text_line  =  <lfs_pur_ord_create>-header_text.
      APPEND  ls_potextheader TO lt_potextheader.
    ENDIF.


    "Get Item data
    LOOP AT lt_pur_ord_create_1 ASSIGNING <lfs_pur_ord_create_1>
            WHERE sr_no = <lfs_pur_ord_create>-sr_no.
      "Plant
      ls_poitem-plant       = 'US01'.
      ls_poitemx-plant      = abap_true.
      "PO Item
      ls_poitem-po_item     = <lfs_pur_ord_create_1>-item.
      ls_poitemx-po_item    = <lfs_pur_ord_create_1>-item.
      "Material
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = <lfs_pur_ord_create_1>-material
        IMPORTING
          output = <lfs_pur_ord_create_1>-material.
      ls_poitem-material    = <lfs_pur_ord_create_1>-material.
      ls_poitemx-material   = abap_true.
      "Material Description
*      IF NOT <lfs_pur_ord_create_1>-short_text IS INITIAL.
*        ls_poitem-short_text  = <lfs_pur_ord_create_1>-short_text.
*        ls_poitemx-short_text = abap_true.
*      ENDIF.
      "PO Quantity

      ls_poitem-quantity    = <lfs_pur_ord_create_1>-quantity.
      ls_poitemx-quantity   = abap_true.
      "material Group
      ls_poitem-matl_group  = <lfs_pur_ord_create_1>-matl_group.
      ls_poitemx-matl_group = abap_true.
      "Storage Location
      ls_poitem-stge_loc    = <lfs_pur_ord_create_1>-stge_loc.
      ls_poitemx-stge_loc   = abap_true.
      "Confirmation Control Key
      ls_poitem-CONF_CTRL    = <lfs_pur_ord_create_1>-CONF_CTRL.
      ls_poitemx-CONF_CTRL   = abap_true.

*      "Net Price NET_PRICE
*      ls_poitem-NET_PRICE    = '123'."<lfs_pur_ord_create_1>-NET_PRICE.
*      ls_poitemx-NET_PRICE   = 'X'.

*      "PO_PRICE
*      ls_poitem-PRICE_UNIT    = '124'." <lfs_pur_ord_create_1>-PRICE_UNIT.
*      ls_poitemx-PRICE_UNIT   = 'X'.
      "purchase Req
*      IF NOT <lfs_pur_ord_create_1>-preq_no IS INITIAL.
*        ls_poitem-preq_no     = <lfs_pur_ord_create_1>-preq_no.
*        ls_poitemx-preq_no    = abap_true.
*      ENDIF.
      "Account Assigment
*      IF NOT <lfs_pur_ord_create_1>-acctasscat IS INITIAL.
*        "Account Assigmnt Po item
*        ls_poaccount-po_item   = <lfs_pur_ord_create_1>-item.
*        ls_poaccountx-po_item  = <lfs_pur_ord_create_1>-item.
*        "Account Assignment Category
*        ls_poitem-acctasscat  = <lfs_pur_ord_create_1>-acctasscat.
*        ls_poitemx-acctasscat = abap_true.
*        "GL account
*        ls_poaccount-gl_account   = <lfs_pur_ord_create_1>-gl_account.
*        ls_poaccountx-gl_account  = abap_true.
*
*        CASE <lfs_pur_ord_create_1>-acctasscat.
*          WHEN 'A'.
*            "Account Assignment Quantity
*            ls_poaccount-quantity  = <lfs_pur_ord_create_1>-as_quantity.
*            ls_poaccountx-quantity = abap_true.
*            "Account Assignment Number
*            ls_poaccount-asset_no     = <lfs_pur_ord_create_1>-asset_no.
*            ls_poaccountx-asset_no    = abap_true.
*          WHEN'K'.
*            "Cost Center
*            ls_poaccount-costcenter   = <lfs_pur_ord_create_1>-costcenter.
*            ls_poaccountx-costcenter  = abap_true.
*        ENDCASE.
*        APPEND ls_poaccount TO lt_poaccount.
*        APPEND ls_poaccountx TO lt_poaccountx.
*      ENDIF.

      "item Category
*      IF NOT <lfs_pur_ord_create_1>-item_cat IS INITIAL.
*        "Item category
*        ls_poitem-item_cat       = <lfs_pur_ord_create_1>-item_cat.
*        ls_poitemx-item_cat      = abap_true.
*        "Service Text
*        ls_poservices-short_text   =  <lfs_pur_ord_create_1>-short_text_s.
*        "Service Quantity
*        ls_poservices-quantity =  <lfs_pur_ord_create_1>-sr_quantity.
*        "gross Price
*        ls_poservices-gr_price    =  <lfs_pur_ord_create_1>-NET_PRICE.
*        ls_poservices-base_uom    =  <lfs_pur_ord_create_1>-base_uom.
*        ls_poservices-line_no    =  '10'.
*        ls_poitem-tax_code       = 'S1'.
*        ls_poitemx-tax_code      = abap_true.
*
*        APPEND ls_poservices TO lt_poservices.
*      ENDIF.

*      IF NOT <lfs_pur_ord_create_1>-cond_type IS INITIAL.
*        ls_pocond-itm_number  =  <lfs_pur_ord_create_1>-item.
*        ls_pocondx-itm_number =  abap_true.
*
*        ls_pocond-COND_VALUE  =  <lfs_pur_ord_create_1>-COND_VALUE.
*        ls_pocondx-COND_VALUE = 'X'.
*        ls_pocond-cond_type  =  'P000'."<lfs_pur_ord_create_1>-cond_type.
*        ls_pocondx-cond_type =  'X'.
*        APPEND ls_pocond TO lt_pocond.
*        APPEND ls_pocondx TO lt_pocondx.
*      ENDIF.


      IF NOT <lfs_pur_ord_create>-item_text IS INITIAL.
        ls_potextitem-po_item   = <lfs_pur_ord_create_1>-item.
        ls_potextitem-text_id   = <lfs_pur_ord_create_1>-item_id.
        ls_potextitem-text_form = '*'.
        ls_potextitem-text_line = <lfs_pur_ord_create_1>-item_text.
        APPEND ls_potextitem TO lt_potextitem.
      ENDIF.

      ls_poschedule-po_item        = <lfs_pur_ord_create_1>-item.
      ls_poschedulex-po_item       = <lfs_pur_ord_create_1>-item.
      ls_poschedule-delivery_date  =  <lfs_pur_ord_create_1>-delivery_date.
      ls_poschedulex-delivery_date =  abap_true.


      ls_polimits-no_limit   = abap_true.
      ls_polimits-limit    = 10.
      APPEND ls_polimits TO lt_polimits.

      APPEND ls_poitem TO lt_poitem.
      APPEND ls_poitemx TO lt_poitemx.

      APPEND ls_poschedule TO lt_poschedule.
      APPEND ls_poschedulex TO lt_poschedulex.

      " Clear all work area
      CLEAR:
        ls_poitem,
        ls_poitemx,
        ls_poaccount,
        ls_poaccountx,
        ls_pocond,
        ls_pocondx,
        ls_poschedule,
        ls_poschedulex,
        ls_poservices,
        ls_potextitem,
        ls_polimits.

    ENDLOOP.

    CALL FUNCTION 'BAPI_PO_CREATE1'
      EXPORTING
        poheader          = ls_poheader
        poheaderx         = ls_poheaderx
      IMPORTING
        exppurchaseorder  = l_purchaseorder
      TABLES
        return            = lt_return
        poitem            = lt_poitem
        poitemx           = lt_poitemx
        poschedule        = lt_poschedule
        poschedulex       = lt_poschedulex
        poaccount         = lt_poaccount
        poaccountx        = lt_poaccountx
        pocond            = lt_pocond
        pocondx           = lt_pocondx
        polimits          = lt_polimits
        poservices        = lt_poservices
        potextheader      = lt_potextheader
        posrvaccessvalues = lt_posrvaccessvalues
        potextitem        = lt_potextitem.

    DELETE lt_return WHERE type = 'W'.
*    MOVE-CORRESPONDING lt_return TO lt_return_1.

CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
* EXPORTING
*   WAIT          =
 IMPORTING
   RETURN        = LS_RETURN_1
          .


    "Clear all tables
    CLEAR:
     ls_poheader,
     ls_poheaderx,
     lt_poitem,
     lt_poitemx,
     lt_poschedule,
     lt_poschedulex,
     lt_poaccount,
     lt_poaccountx,
     lt_pocond,
     lt_pocondx,
     lt_poservices,
     lt_potextheader,
     lt_potextitem,
     lt_polimits.

    LOOP AT lt_return INTO ls_return.
      CASE ls_return-type.
        WHEN 'E'.
          WRITE:/ ls_return-message.
        WHEN 'S'.
          WRITE:/ l_purchaseorder,
                  ls_return-message.
      ENDCASE.

      CLEAR:
        ls_return.
    ENDLOOP.
    CLEAR
         lt_return.
  ENDLOOP.

ENDFORM.





*  CALL FUNCTION 'BAPI_PO_CREATE1'
*   EXPORTING
*      poheader                     = ls_poheader
*      poheaderx                    = ls_poheaderx
**   POADDRVENDOR                 =
**   TESTRUN                      =
**   MEMORY_UNCOMPLETE            =
**   MEMORY_COMPLETE              =
**   POEXPIMPHEADER               =
**   POEXPIMPHEADERX              =
**   VERSIONS                     =
**   NO_MESSAGING                 =
**   NO_MESSAGE_REQ               =
**   NO_AUTHORITY                 =
**   NO_PRICE_FROM_PO             =
**   PARK_COMPLETE                =
**   PARK_UNCOMPLETE              =
*  IMPORTING
*     exppurchaseorder             = l_purchaseorder
**   EXPHEADER                    =
**   EXPPOEXPIMPHEADER            =
*  TABLES
*     return                       = lt_return
*     poitem                       = lt_poitem
*     poitemx                      = lt_poitemx
**   POADDRDELIVERY               =
**   POSCHEDULE                   =
**   POSCHEDULEX                  =
**   POACCOUNT                    =
**   POACCOUNTPROFITSEGMENT       =
**   POACCOUNTX                   =
**   POCONDHEADER                 =
**   POCONDHEADERX                =
**   POCOND                       =
**   POCONDX                      =
**   POLIMITS                     =
**   POCONTRACTLIMITS             =
**   POSERVICES                   =
**   POSRVACCESSVALUES            =
**   POSERVICESTEXT               =
**   EXTENSIONIN                  =
**   EXTENSIONOUT                 =
**   POEXPIMPITEM                 =
**   POEXPIMPITEMX                =
**   POTEXTHEADER                 =
**   POTEXTITEM                   =
**   ALLVERSIONS                  =
**   POPARTNER                    =
**   POCOMPONENTS                 =
**   POCOMPONENTSX                =
**   POSHIPPING                   =
**   POSHIPPINGX                  =
**   POSHIPPINGEXP                =
**   SERIALNUMBER                 =
**   SERIALNUMBERX                =
**   INVPLANHEADER                =
**   INVPLANHEADERX               =
**   INVPLANITEM                  =
**   INVPLANITEMX                 =
*    .

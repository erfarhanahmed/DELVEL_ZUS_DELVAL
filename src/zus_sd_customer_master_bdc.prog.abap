*&---------------------------------------------------------------------*
*& Report  ZUS_SD_CUSTOMER_MASTER_BDC                                  *
*&---------------------------------------------------------------------*
*& Report  ZUS_SD_CUSTOMER_MASTER_BDC                                  *
*&  PROGRAMME NAME   : ZUS_SD_CUSTOMER_MASTER_BDC                      *
*&  REQUESTED BY     : Sachin Newde                                    *
*&  DEVELOPER        : Parag Nakhate                                   *
*&  COMPANY          : Primus TechSystems                              *                                           *
*&  MODULE           : SD                                              *
*&  DATE CREATED     : 11.08.2018                                      *
*&---------------------------------------------------------------------*

REPORT ZUS_SD_CUSTOMER_MASTER_BDC.

TABLES:SSCRFIELDS.

TYPES: BEGIN OF TY_DOMSTC,
BUKRS(4),         "Company code
VKORG(4),         "Sales organization
VTWEG(2),         "Distribution channel
SPART(2),         "Division
KTOKD(4),         "Account group
TITLE_MEDI(14),   "Title
NAME1(40),        "Name
SORT1(20),        "Search Term 1
NAME2(40),        "Name
NAME3(40),        "Name
NAME4(40),        "Name
STREET(40),       "STREET
PO_BOX(10),       "PO Box
CITY1(40),        "City
POST_CODE1(10),   "City postal code
CITY2(40),        "District
PO_BOX_LOC(40),   "PO Box city
POST_CODE2(10),   "PO Box Postal Code
COUNTRY(03),      "Country
REGION(03),       "Region
LANGU(02),        "Language Key
TEL_NUMBER(30),   "Telephone no
FAX_NUMBER(30),   "Fax no
SMTP_ADDR(241),   "E-Mail Address
BRSCH(04),        "Industry key
NAMEV(35),        "Contact person first
NAME5(35),        "Contact person last
AKONT(10),        "Reconciliation Account
ALTKN(10),        "Previous Master Record Number
BZIRK(06),        "Sales district
AWAHR(03),        "Order probability of the item
VKBUR(04),        "Sales Office
VKGRP(03),        "Sales Group
KDGRP(02),        "Customer group
WAERS(05),        "Currency
KALKS(01),        "Pricing procedure
LPRIO(02),        "Delivery Priority
KZAZU(01),        "Order Combination Indicator
VSBED(02),        "Shipping Conditions
VWERK(04),        "Delivering Plant
ANTLF(01),        "Maximum Number of Partial Deliveries Allowed Per Item
INCO1(03),        "Incoterms
INCO2(29),        "Incoterms Desc
ZTERM(04),        "Terms of Payment
KTGRD(02),        "Account Assignment Group
TAXKD1,            "Tax Classification TAXKD1
TAXKD2,            "Tax Classification TAXKD2
TAXKD3,            "Tax Classification TAXKD3


*
*  BUKRS(4),         "Company code
*  VKORG(4),         "Sales organization
*  VTWEG(2),         "Distribution channel
*  SPART(2),         "Division
*  KTOKD(4),         "Account group        .
*  ANRED(14),        "Title
*  NAME1(35),        "Name
*  SORTL(10),        "Search term
*  NAME2(35),        "Name
*  NAME3(35),        "Name
*  NAME4(35),        "Name
*  STRAS(35),        "Street
*  PFACH(10),        "PO Box
*  ORT01(35),        "City       .
*  PSTLZ(10),        "Postal Code
*  ORT02(35),        "District
*  PFORT(35),        "P.O.Box city
*  PSTL2(10),        "PO Box PCode
*  LAND1(3),         "Country
*  REGIO(3),         "Region
*  SPRAS(2),         "Language Key
*  TELF1(16),        "Telephone 1
*  TELFX(31),        "Fax Number
*  BRSCH(4),         "Industry key
*  NAMEV(35),        "First name
*  NAME(35),        "Name 1
*  AKONT(10),        "Recon. account
*  ALTKN(10),        "Prev.acct no.
*  BZIRK(6),         "Sales district
*  AWAHR(3),         "Order probab.
*  VKBUR(4),         "Sales Office
*  VKGRP(3),         "Sales Group
*  KDGRP(2),         "Customer group
*  WAERS(5),         "Currency
*  KALKS,            "Cust.pric.proc.
*  VERSG,            "Cust.Stats.Grp
*  LPRIO(2),         "Delivery Priority
*  KZAZU,            "Order Combination
*  VSBED(2),         "Shipping Conditions
*  VWERK(4),         "Delivering Plant
*  ANTLF,            "Max.Part.Deliveries
*  INCO1(3),         "Incoterms
*  INCO2(28),        "Incoterms description
*  ZTERM(4),         "Payt Terms
*  KTGRD(2),         "AcctAssgGr
*  TAXKD,            "Tax Classification     .
*  TAXKD1,            "Tax Classification     .
*  TAXKD2,            "Tax Classification     .
*  TAXKD3,            "Tax Classification     .
  END OF TY_DOMSTC,

  BEGIN OF TY_EXPORT,
    BUKRS(4),       "Company code
    VKORG(4),       "Sales organization
    VTWEG(2),       "Distribution channel
    SPART(2),       "Division
    KTOKD(4),       "Account group
    ANRED(14),      "Title
    NAME1(35),      "Name
    SORTL(10),      "Search term
    NAME2(35),      "Name
    NAME3(35),      "Name
    NAME4(35),      "Name
    STRAS(35),      "Street
    PFACH(10),      "PO Box
    ORT01(35),      "City
    PSTLZ(10),      "Postal Code
    ORT02(35),      "District
    PFORT(35),      "P.O.Box city
    PSTL2(10),      "PO Box PCode
    LAND1(3),       "Country
    REGIO(3),       "Region
    SPRAS(2),       "Language Key
    TELF1(16),      "Telephone 1
    TELFX(31),      "Fax Number
    AKONT(10),      "Recon. account
    ALTKN(10),      "Prev.acct no.
    AWAHR(3),       "Order probab.
    WAERS(5),       "Currency
    KALKS,          "Cust.pric.proc.
    VERSG,          "Cust.Stats.Grp
    LPRIO(2),       "Delivery Priority
    KZAZU,          "Order Combination
    VSBED(2),       "Shipping Conditions
    VWERK(4),       "Delivering Plant
    INCO1(3),       "Incoterms
    INCO2(28),      "Incoterms description
    ZTERM(4),       "Payt Terms
    KTGRD(2),       "AcctAssgGr
    TAXKD,          "Tax Classification       .
  END OF TY_EXPORT,

  BEGIN OF TY_B2P,
    KUNNR(18),      "Customer
    BUKRS(4),       "Company code
    VKORG(4),       "Sales organization
    VTWEG(2),       "Distribution channel
    SPART(2),       "Division
    KTOKD(4),       "Account group
    ANRED(14),      "Title
    NAME1(35),      "Name
    SORTL(10),      "Search term
    NAME2(35),      "Name
    NAME3(35),      "Name
    NAME4(35),      "Name
    STRAS(35),      "Street
    PFACH(10),      "PO Box
    ORT01(35),      "City
    PSTLZ(10),      "Postal Code
    ORT02(35),      "District
    PFORT(35),      "P.O.Box city
    PSTL2(10),      "PO Box PCode
    LAND1(3),       "Country
    REGIO(3),       "Region
    SPRAS(2),       "Language Key
    TELF1(16),      "Telephone 1
    TELFX(31),      "Fax Number
    AKONT(10),      "Recon. account
  END OF TY_B2P,

  BEGIN OF TY_OTC,
    BUKRS(4),       "Company code
    VKORG(4),       "Sales organization
    VTWEG(2),       "Distribution channel
    SPART(2),       "Division
    KTOKD(4),       "Account group
    NAME1(35),      "Name
    SORTL(10),      "Search term
    NAME2(35),      "Name
    LAND1(3),       "Country
    SPRAS(2),       "Language Key
    AKONT(10),      "Recon. account
    ZTERM(4),       "Payt Terms
    WAERS(5),       "Currency
    KALKS,          "Cust.pric.proc.
    VERSG,          "Cust.Stats.Grp
    LPRIO(2),       "Delivery Priority
    KZAZU,          "Order Combination
    VSBED(2),       "Shipping Conditions
    ANTLF,          "Max.Part.Deliveries
    INCO1(3),       "Incoterms
    INCO2(28),      "Incoterms description
    ZTERM1(4),      "Delivery Payt Terms
    KTGRD(2),       "AcctAssgGr
    TAXKD,          "Tax Classification
  END OF TY_OTC,

  BEGIN OF TY_SH2P,
    BUKRS(4),       "Company code
    VKORG(4),       "Sales organization
    VTWEG(2),       "Distribution channel
    SPART(2),       "Division
    KTOKD(4),       "Account group
    ANRED(14),      "Title
    NAME1(35),      "Name
    SORTL(10),      "Search term
    NAME2(35),      "Name
    NAME3(35),      "Name
    NAME4(35),      "Name
    STRAS(35),      "Street
    PFACH(10),      "PO Box
    ORT01(35),      "City
    PSTLZ(10),      "Postal Code
    ORT02(35),      "District
    PFORT(35),      "P.O.Box city
    PSTL2(10),      "PO Box PCode
    LAND1(3),       "Country
    REGIO(3),       "Region
    SPRAS(2),       "Language Key
    CIVVE,          "Usage civilian   "MILVE
    LPRIO(2),       "Delivery Priority
    KZAZU,          "Order Combination
    VSBED(2),       "Shipping Conditions
    VWERK(4),       "Delivering Plant
    ANTLF,          "Max.Part.Deliveries
    TAXKD,          "Tax Classification     .
  END OF TY_SH2P.

DATA: IT_DOMSTC TYPE TABLE OF TY_DOMSTC,
      WA_DOMSTC TYPE TY_DOMSTC,

      IT_EXPORT TYPE TABLE OF TY_EXPORT,
      WA_EXPORT TYPE TY_EXPORT,

      IT_B2P TYPE TABLE OF TY_B2P,
      WA_B2P TYPE TY_B2P,

      IT_OTC TYPE TABLE OF TY_OTC,
      WA_OTC TYPE TY_OTC,

      IT_SH2P TYPE TABLE OF TY_SH2P,
      WA_SH2P TYPE TY_SH2P.

FIELD-SYMBOLS <TAB_NAME>  TYPE STANDARD TABLE .

TYPES: BEGIN OF t_error,
  excel_no(6) TYPE n,
  msg_typ,
  eror_msg(100),
  END OF t_error.

DATA: BDCDATA TYPE TABLE OF BDCDATA WITH HEADER LINE,
      IT_BDCMSGCOLL LIKE TABLE OF BDCMSGCOLL,
      WA_BDCMSGCOLL LIKE LINE OF IT_BDCMSGCOLL,
      TXT(4096) TYPE C OCCURS 0,
      excel_cnt TYPE i,
      excel_cnt_s TYPE i,
      excel_cnt_u TYPE i,
      n_excel_cnt(6) TYPE N,
      it_error TYPE TABLE OF t_error,
      wa_error TYPE t_error.



SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-002.
PARAMETERS : MY_FILE TYPE RLGRAP-FILENAME,
             ct_mode LIKE ctu_params-dismode DEFAULT 'N'.
SELECTION-SCREEN : END OF BLOCK B1.


SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN PUSHBUTTON (25) W_BUTTON USER-COMMAND BUT1.
SELECTION-SCREEN END OF LINE.

INITIALIZATION.
* Add displayed text string to buttons
  W_BUTTON = 'Download Excel Template'.


AT SELECTION-SCREEN.
  IF SSCRFIELDS-UCOMM EQ 'BUT1' .
    SUBMIT  ZUS_SD_CUST_MASTER_EXCEL VIA SELECTION-SCREEN .
  ENDIF.




AT SELECTION-SCREEN ON VALUE-REQUEST FOR MY_FILE.

  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      PROGRAM_NAME  = SYST-CPROG
      DYNPRO_NUMBER = SYST-DYNNR
*     FIELD_NAME    = ' '
    IMPORTING
      FILE_NAME     = MY_FILE.

  START-OF-SELECTION.

    excel_cnt = 1.


      ASSIGN IT_DOMSTC TO <TAB_NAME>.
      PERFORM GET_FILE.
      DELETE IT_DOMSTC INDEX 1.
      PERFORM DOMASTIC.


FORM GET_FILE.
  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
      I_TAB_RAW_DATA       = TXT
      I_FILENAME           = MY_FILE
    TABLES
      I_TAB_CONVERTED_DATA = <TAB_NAME>
    EXCEPTIONS
      CONVERSION_FAILED    = 1
      OTHERS               = 2.
  IF SY-SUBRC <> 0.
    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
    WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.
ENDFORM.

FORM DOMASTIC.

LOOP AT IT_DOMSTC INTO WA_DOMSTC.

  excel_cnt = excel_cnt + 1.

  REFRESH: BDCDATA, IT_BDCMSGCOLL.

perform bdc_dynpro      using 'SAPMF02D' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'USE_ZAV'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'RF02D-BUKRS'
                              WA_DOMSTC-BUKRS.                  "'US00'.
perform bdc_field       using 'RF02D-VKORG'
                              WA_DOMSTC-VKORG.                    "'US00'.
perform bdc_field       using 'RF02D-VTWEG'
                              WA_DOMSTC-VTWEG.                    "'10'.
perform bdc_field       using 'RF02D-SPART'
                              WA_DOMSTC-SPART.                  "'10'.
perform bdc_field       using 'RF02D-KTOKD'
                              WA_DOMSTC-KTOKD.                  "'US10'.
perform bdc_field       using 'USE_ZAV'
                              'X'.
perform bdc_dynpro      using 'SAPMF02D' '0111'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BDC_CURSOR'
                              'SZA1_D0100-SMTP_ADDR'.
perform bdc_field       using 'SZA1_D0100-TITLE_MEDI'
                              WA_DOMSTC-TITLE_MEDI.                            "'Company'.
perform bdc_field       using 'ADDR1_DATA-NAME1'
                              WA_DOMSTC-NAME1.                        "'BLUE STAR & LOGISTICS'.
perform bdc_field       using 'ADDR1_DATA-NAME2'
                              WA_DOMSTC-NAME2.                      "'BLUE'.
perform bdc_field       using 'ADDR1_DATA-NAME3'
                              WA_DOMSTC-NAME3.                              "'BLUE'.
perform bdc_field       using 'ADDR1_DATA-NAME4'
                              WA_DOMSTC-NAME4.                            "'BLUE'.
perform bdc_field       using 'ADDR1_DATA-SORT1'
                              WA_DOMSTC-SORT1.                          "'BLUE'.
perform bdc_field       using 'ADDR1_DATA-STREET'
                              WA_DOMSTC-STREET.                        "'1234 HWY ROAD'.
perform bdc_field       using 'ADDR1_DATA-CITY2'
                              WA_DOMSTC-CITY2.                        "'parbhani'.
perform bdc_field       using 'ADDR1_DATA-POST_CODE1'
                              WA_DOMSTC-POST_CODE1.                          "'79707'.
perform bdc_field       using 'ADDR1_DATA-CITY1'
                              WA_DOMSTC-CITY1.                        "'Geismar'.
perform bdc_field       using 'ADDR1_DATA-COUNTRY'
                              WA_DOMSTC-COUNTRY.                          "'us'.
perform bdc_field       using 'ADDR1_DATA-REGION'
                              WA_DOMSTC-REGION.                          "'LA'.
perform bdc_field       using 'ADDR1_DATA-PO_BOX'
                              WA_DOMSTC-PO_BOX.                        "'22332'.
perform bdc_field       using 'ADDR1_DATA-POST_CODE2'
                              WA_DOMSTC-POST_CODE2.                          "'12345'.
perform bdc_field       using 'ADDR1_DATA-PO_BOX_LOC'
                              WA_DOMSTC-PO_BOX_LOC.                        "'BEED'.
perform bdc_field       using 'ADDR1_DATA-LANGU'
                              WA_DOMSTC-LANGU.                        "'EN'.
perform bdc_field       using 'SZA1_D0100-TEL_NUMBER'
                              WA_DOMSTC-TEL_NUMBER.                        "'225 744 4326'.
perform bdc_field       using 'SZA1_D0100-FAX_NUMBER'
                              WA_DOMSTC-FAX_NUMBER.                      "'225 744 4328'.
perform bdc_field       using 'SZA1_D0100-SMTP_ADDR'
                              WA_DOMSTC-SMTP_ADDR.                    "'SACHIN@GMAIL.COM'.
perform bdc_dynpro      using 'SAPMF02D' '0120'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNA1-BRSCH'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'KNA1-BRSCH'
                              WA_DOMSTC-BRSCH.            "'US03'.
perform bdc_dynpro      using 'SAPMF02D' '0125'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNA1-NIELS'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'KNA1-BRSCH'
                              WA_DOMSTC-BRSCH.                        "'US03'.
perform bdc_dynpro      using 'SAPMF02D' '0130'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNBK-BANKS(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_dynpro      using 'SAPMF02D' '0340'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVA-ABLAD(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_dynpro      using 'SAPMF02D' '0370'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNEX-LNDEX(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_field       using 'KNA1-CIVVE'
                              'X'.
perform bdc_dynpro      using 'SAPMF02D' '0360'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVK-NAME1(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_field       using 'KNVK-NAMEV(01)'
                              WA_DOMSTC-NAMEV.                    "'PRASHANT PATIL'.
perform bdc_field       using 'KNVK-NAME1(01)'
                              WA_DOMSTC-NAME5.                    "'patil'.
perform bdc_dynpro      using 'SAPMF02D' '0360'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVK-NAMEV(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_dynpro      using 'SAPMF02D' '0210'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNB1-ALTKN'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'KNB1-AKONT'
                              WA_DOMSTC-AKONT.                      "'11000'.
perform bdc_field       using 'KNB1-ALTKN'
                              WA_DOMSTC-ALTKN.                "'98765'.
perform bdc_dynpro      using 'SAPMF02D' '0215'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNB1-ZTERM'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'KNB1-ZTERM'
                              WA_DOMSTC-ZTERM.            " 'u001'.
perform bdc_dynpro      using 'SAPMF02D' '0220'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNB5-MAHNA'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_dynpro      using 'SAPMF02D' '0230'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNB1-VRSNR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_dynpro      using 'SAPMF02D' '0310'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVV-KALKS'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'KNVV-BZIRK'
                              WA_DOMSTC-BZIRK.                    "'US01'.
perform bdc_field       using 'KNVV-AWAHR'
                              WA_DOMSTC-AWAHR.                    "'100'.
perform bdc_field       using 'KNVV-VKBUR'
                              WA_DOMSTC-VKBUR.                      "'US01'.
perform bdc_field       using 'KNVV-VKGRP'
                              WA_DOMSTC-VKGRP.                        "'U01'.
perform bdc_field       using 'KNVV-KDGRP'
                              WA_DOMSTC-KDGRP.                        "'U1'.
perform bdc_field       using 'KNVV-WAERS'
                              WA_DOMSTC-WAERS.                    "'USD'.
perform bdc_field       using 'KNVV-KALKS'
                              WA_DOMSTC-KALKS.                      "'1'.
perform bdc_dynpro      using 'SAPMF02D' '0315'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVV-VWERK'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'KNVV-LPRIO'
                              WA_DOMSTC-LPRIO.                              "'01'.
perform bdc_field       using 'KNVV-KZAZU'
                              WA_DOMSTC-KZAZU.                                "'X'.
perform bdc_field       using 'KNVV-VSBED'
                              WA_DOMSTC-VSBED.                              "'01'.
perform bdc_field       using 'KNVV-VWERK'
                              WA_DOMSTC-VWERK.                              "'US01'.
perform bdc_field       using 'KNVV-ANTLF'
                              WA_DOMSTC-ANTLF.                                "'9'.
perform bdc_dynpro      using 'SAPMF02D' '0320'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVV-KTGRD'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTS'.
perform bdc_field       using 'KNVV-PERFK'
                              ''.
perform bdc_field       using 'KNVV-INCO1'
                              WA_DOMSTC-INCO1.              "'C&F'.
perform bdc_field       using 'KNVV-INCO2'
                              WA_DOMSTC-INCO2.          "'FRIGHT ALLOWED'.
perform bdc_field       using 'KNVV-ZTERM'
                              WA_DOMSTC-ZTERM.          "'U001'.
perform bdc_field       using 'KNVV-KTGRD'
                              WA_DOMSTC-KTGRD.            "'26'.
perform bdc_dynpro      using 'SAPMF02D' '1350'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVI-TAXKD(03)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_field       using 'KNVI-TAXKD(01)'
                              WA_DOMSTC-TAXKD1 .             "'0'.
perform bdc_field       using 'KNVI-TAXKD(02)'
                              WA_DOMSTC-TAXKD2  .              "'0'.
perform bdc_field       using 'KNVI-TAXKD(03)'
                              WA_DOMSTC-TAXKD3.                "'0'.
perform bdc_dynpro      using 'SAPMF02D' '1350'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVI-TAXKD(03)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_dynpro      using 'SAPMF02D' '0324'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVP-PARVW(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.


CALL TRANSACTION 'XD01' USING BDCDATA
                        MODE ct_mode      "'N'
                        UPDATE 'S'
                        MESSAGES INTO IT_BDCMSGCOLL.

IF SY-SUBRC = 0.
    excel_cnt_s = excel_cnt_s + 1.

ENDIF.
*  ELSE.
    excel_cnt_u = excel_cnt_u + 1.

    IF IT_BDCMSGCOLL IS INITIAL.
      wa_error-excel_no = excel_cnt.
      APPEND wa_error TO it_error.
      CLEAR wa_error.

      ELSE.

      LOOP AT IT_BDCMSGCOLL INTO WA_BDCMSGCOLL.

        CALL FUNCTION 'MESSAGE_TEXT_BUILD'
          EXPORTING
           MSGID     = WA_BDCMSGCOLL-MSGID
           MSGNR     = WA_BDCMSGCOLL-MSGNR
           MSGV1     = WA_BDCMSGCOLL-MSGV1
           MSGV2     = WA_BDCMSGCOLL-MSGV2
           MSGV3     = WA_BDCMSGCOLL-MSGV3
           MSGV4     = WA_BDCMSGCOLL-MSGV4
         IMPORTING
           MESSAGE_TEXT_OUTPUT       = wa_error-eror_msg.

        wa_error-excel_no = excel_cnt.
        wa_error-MSG_TYP = WA_BDCMSGCOLL-MSGTYP.
        APPEND wa_error TO it_error.
        CLEAR: wa_error, WA_BDCMSGCOLL.
      ENDLOOP.

    ENDIF.


***perform bdc_transaction using 'XD01'.
***
***perform close_group.

ENDLOOP.
PERFORM report.
ENDFORM.


*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM BDC_DYNPRO USING PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM BDC_FIELD USING FNAM FVAL.
*  IF FVAL <> NODATA.
    CLEAR BDCDATA.
    BDCDATA-FNAM = FNAM.
    BDCDATA-FVAL = FVAL.
    APPEND BDCDATA.
*  ENDIF.
ENDFORM.

FORM report.

  TYPE-POOLS: SLIS.

DATA : it_fieldcat TYPE slis_t_fieldcat_alv WITH HEADER LINE,
       fs_layout  TYPE slis_layout_alv.

  it_fieldcat-col_pos   = 1.
  it_fieldcat-fieldname = 'EXCEL_NO'.
  it_fieldcat-tabname   = 'IT_ERROR'.
  it_fieldcat-seltext_m = 'Row no in Excel'.
  APPEND it_fieldcat.
  CLEAR it_fieldcat.

  it_fieldcat-col_pos   = 2.
  it_fieldcat-fieldname = 'MSG_TYP'.
  it_fieldcat-tabname   = 'IT_ERROR'.
  it_fieldcat-seltext_m = 'Message Type'.
  APPEND it_fieldcat.
  CLEAR it_fieldcat.

  it_fieldcat-col_pos   = 3.
  it_fieldcat-fieldname = 'EROR_MSG'.
  it_fieldcat-tabname   = 'IT_ERROR'.
  it_fieldcat-seltext_m = 'Message'.
  APPEND it_fieldcat.
  CLEAR it_fieldcat.

  fs_layout-colwidth_optimize = 'X'.
  fs_layout-zebra             = 'X'. " zebra

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
   I_CALLBACK_PROGRAM                = sy-repid
   I_CALLBACK_TOP_OF_PAGE            = 'TOP_OF_PAGE'
   IS_LAYOUT                         = fs_layout
   IT_FIELDCAT                       = it_fieldcat[]
  TABLES
    T_OUTTAB                          = IT_ERROR
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.
ENDFORM.

FORM TOP_OF_PAGE.

    DATA: IT_HEADER TYPE slis_t_listheader,
          WA_HEADER TYPE slis_listheader,
          C_EXCEL_NO_T(6),
          C_EXCEL_NO_S(6),
          C_EXCEL_NO_U(6),
          Header_Text(90).

*     Title
  wa_header-typ  = 'H'.
  wa_header-info = 'Upload analysis Report for XD01 BDC'.
  APPEND wa_header TO it_header.
  CLEAR wa_header.

  CLEAR Header_Text.
  excel_cnt = excel_cnt - 1.
  C_EXCEL_NO_T = excel_cnt.
  CONCATENATE 'Total No of Excel Data: ' C_EXCEL_NO_T INTO Header_Text.
  wa_header-typ  = 'S'.
  wa_header-info = Header_Text.
  APPEND wa_header TO it_header.
  CLEAR wa_header.

  CLEAR Header_Text.
  C_EXCEL_NO_S = excel_cnt_s.
  CONCATENATE 'Successful Uploaded Data: ' C_EXCEL_NO_S INTO Header_Text.
  wa_header-typ  = 'S'.
  wa_header-info = Header_Text.
  APPEND wa_header TO it_header.
  CLEAR wa_header.

  CLEAR Header_Text.
  C_EXCEL_NO_U = excel_cnt_u.
  CONCATENATE 'Unsuccessful Uploaded Data: ' C_EXCEL_NO_U INTO Header_Text.
  wa_header-typ  = 'S'.
  wa_header-info = Header_Text.
  APPEND wa_header TO it_header.
  CLEAR wa_header.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = it_header.

ENDFORM.

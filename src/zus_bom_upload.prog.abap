*&---------------------------------------------------------------------*
*& Report ZUS_BOM_UPLOAD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUS_BOM_UPLOAD no standard page heading line-size 255.

TABLES: sscrfields.

TYPES: BEGIN OF ty_final,
        count(010),
        matnr(040),
        stlan(001),
        idnrk(040),
        postp(001),
        menge(013),
        lgort(004),
        DATUV(010),
        werks(004),
        meins(003),
        posnr(004),
        BMENG(016),
        END OF ty_final.

TYPES:BEGIN OF ty_item,
        count(010),
        matnr(040),
        idnrk(040),
        menge(013),
        meins(003),
        postp(001),
        posnr(004),
        lgort(004),
        END OF ty_item.


TYPES: trux_t_text_data(4096) TYPE c OCCURS 0.
DATA : it_raw TYPE trux_t_text_data,
       lt_final TYPE STANDARD TABLE OF ty_final,
       ls_final TYPE ty_final,
       lt_item TYPE STANDARD TABLE OF ty_item,
       ls_item TYPE ty_item.
DATA : bdcmsgcoll    TYPE STANDARD TABLE OF bdcmsgcoll WITH HEADER LINE,
       wa_bdcmsgcoll TYPE bdcmsgcoll,
       bdcdata       TYPE STANDARD TABLE OF bdcdata WITH HEADER LINE.
DATA : cnt(3)        TYPE n,
       v_message(50).

data :
       t1(25) TYPE C.

FIELD-SYMBOLS : <lfs_final> TYPE ty_final.
FIELD-SYMBOLS : <lfs_item> TYPE ty_item.
*-------------------------------------------------------------

SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS :  bdc_file TYPE rlgrap-filename.
PARAMETERS :  ctu_mode LIKE ctu_params-dismode DEFAULT 'N'.
SELECTION-SCREEN : END OF BLOCK  b1.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN PUSHBUTTON (25) w_button USER-COMMAND but1.
SELECTION-SCREEN END OF LINE.
* --------------------------------------------------------------

INITIALIZATION.
*Assign Text string To Button
  w_button = 'Download Excel Template'.
AT SELECTION-SCREEN.
  IF sscrfields-ucomm EQ 'BUT1'.
    SUBMIT ZPP_ZBOM_UPLOAD_EXCEL_CRE VIA SELECTION-SCREEN.
  ENDIF.
*include bdcrecx1.
*start-of-selection.
*perform open_group.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR bdc_file.

  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
      field_name    = ' '
    IMPORTING
      file_name     = bdc_file.

START-OF-SELECTION.

  CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
    EXPORTING
*     I_FIELD_SEPERATOR    =
      i_line_header        = 'X'
      i_tab_raw_data       = it_raw
      i_filename           = bdc_file
    TABLES
      i_tab_converted_data = lt_final[]
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
  cnt = 1.


LOOP AT lt_final INTO ls_final.
  MOVE-CORRESPONDING ls_final to ls_item.
  append ls_item to lt_item.
  CLEAR ls_item.
ENDLOOP.

delete ADJACENT DUPLICATES FROM lt_final COMPARING count.

LOOP AT lt_final ASSIGNING <lfs_final>.
  cnt = 1.
  CLEAR : bdcdata[].
  perform bdc_dynpro      using 'SAPLCSDI' '0100'.
  perform bdc_field       using 'BDC_CURSOR'
                                'RC29N-STLAN'.
  perform bdc_field       using 'BDC_OKCODE'
                                '/00'.
  perform bdc_field       using 'RC29N-MATNR'
                                 <lfs_final>-MATNR.                                             " 'FG00003'.
  perform bdc_field       using 'RC29N-WERKS'
                                 <lfs_final>-WERKS.                                              "'1001'.
  perform bdc_field       using 'RC29N-STLAN'
                                 <lfs_final>-STLAN.                                             " '1'.

***********************************************************************

    perform bdc_field       using 'RC29N-DATUV'     " RC29N-STLAN'   added by amar on date 08.08.2018
                                 <lfs_final>-DATUV.

***********************************************************************
  perform bdc_dynpro      using 'SAPLCSDI' '0110'.
  perform bdc_field       using 'BDC_OKCODE'
                                '/00'.
  perform bdc_field       using 'RC29K-BMENG'
                                 <lfs_final>-BMENG.                                                                  " '1'.
  perform bdc_field       using 'RC29K-STLST'
                                    '1'.
  perform bdc_field       using 'BDC_CURSOR'
                                'RC29K-EXSTL'.
  perform bdc_dynpro      using 'SAPLCSDI' '0111'.
  perform bdc_field       using 'BDC_CURSOR'
                                'RC29K-LABOR'.
  perform bdc_field       using 'BDC_OKCODE'
                                '/00'.

      LOOP AT lt_item ASSIGNING <lfs_item> WHERE count =  <lfs_final>-count and matnr =  <lfs_final>-matnr.

         IF cnt = 13.
             perform bdc_dynpro      using 'SAPLCSDI' '0140'.
              perform bdc_field       using 'BDC_CURSOR'
                                    'RC29P-POSTP(01)'.
                PERFORM bdc_field       USING 'BDC_OKCODE'
                                            '=FCNP'.

          cnt = 2.
         endif.

      perform bdc_dynpro      using 'SAPLCSDI' '0140'.
      perform bdc_field       using 'BDC_CURSOR'
                                    'RC29P-POSTP(01)'.
      perform bdc_field       using 'BDC_OKCODE'
                                    '/00'.
      CONCATENATE 'RC29P-IDNRK('CNT')' INTO T1.
      perform bdc_field       using T1
      <lfs_item>-IDNRK.                                                     "'rm001'.
      CLEAR T1.
      CONCATENATE 'RC29P-MENGE('CNT')' INTO T1.
      perform bdc_field       using T1
      <lfs_item>-MENGE.                                                     "'1'.
      CLEAR T1.
      CONCATENATE 'RC29P-MEINS('CNT')' INTO T1.
      perform bdc_field       using T1
      <lfs_item>-MEINS.                                                     "'1'.
      CLEAR T1.
      CONCATENATE 'RC29P-POSTP('CNT')' INTO T1.
      perform bdc_field       using T1
                      <lfs_item>-POSTP.                                                     "'1'.
      CLEAR T1.

perform bdc_dynpro      using 'SAPLCSDI' '0130'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BDC_CURSOR'
                              'RC29P-POSNR'.
perform bdc_dynpro      using 'SAPLCSDI' '0131'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'BDC_CURSOR'
                              'RC29P-POTX1'.
perform bdc_field       using 'RC29P-SANKA'
                               'X'.
IF <lfs_final>-stlan = '1'.
        PERFORM bdc_field       USING 'RC29P-LGORT'   <lfs_item>-lgort.
ENDIF.
CNT = CNT + 1.
CLEAR : <lfs_item>.
ENDLOOP.

perform bdc_dynpro      using 'SAPLCSDI' '0140'.
perform bdc_field       using 'BDC_CURSOR'
                              'RC29P-POSNR(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=FCBU'.
call TRANSACTION 'CS01' using  bdcdata

                              mode   ctu_mode
                              update 'S'
                              messages into bdcmsgcoll.

LOOP AT bdcmsgcoll INTO wa_bdcmsgcoll.

        CALL FUNCTION 'FORMAT_MESSAGE'                  "Formatting a T100 message
          EXPORTING
            id        = wa_bdcmsgcoll-msgid
            lang      = sy-langu
            no        = wa_bdcmsgcoll-msgnr
            v1        = wa_bdcmsgcoll-msgv1
            v2        = wa_bdcmsgcoll-msgv2
            v3        = wa_bdcmsgcoll-msgv3
            v4        = wa_bdcmsgcoll-msgv4
          IMPORTING
            msg       = v_message
          EXCEPTIONS
            not_found = 1
            OTHERS    = 2.

        IF wa_bdcmsgcoll-msgv1 IS NOT INITIAL AND wa_bdcmsgcoll-msgtyp = 'S'.
          WRITE:/ v_message.
        ENDIF.

        if  wa_bdcmsgcoll-msgtyp = 'E'.
          "WRITE:/ v_message ,' Error in Count',ls_final-count.
        endif.

      ENDLOOP.
CLEAR :<lfs_final>.
ENDLOOP.

FORM bdc_dynpro USING program dynpro.
  CLEAR bdcdata.
  bdcdata-program   = program.
  bdcdata-dynpro    = dynpro.
  bdcdata-dynbegin  = 'X'.
  APPEND bdcdata.
ENDFORM.

FORM bdc_field USING fnam fval.
  IF fval <> space.
    CLEAR bdcdata.
    bdcdata-fnam = fnam.
    bdcdata-fval = fval.
    APPEND bdcdata.
  ENDIF.
ENDFORM.
.

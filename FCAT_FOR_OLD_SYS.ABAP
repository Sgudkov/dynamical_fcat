*----------------------------------------------------------------------*
*       CLASS lcl_alv DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_alv DEFINITION.

  PUBLIC SECTION.

    METHODS:
              create_fcat
                IMPORTING
                          is_component   TYPE any
                RETURNING value(rt_fcat) TYPE lvc_t_fcat.
ENDCLASS.                    "lcl_alv DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_alv IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_alv IMPLEMENTATION.
  METHOD create_fcat.

    DATA:
      lo_descr      TYPE REF TO cl_abap_structdescr,
      lt_fieldlist  TYPE ddfields,
      lo_type_descr TYPE REF TO cl_abap_typedescr.

    FIELD-SYMBOLS:
      <ls_component> TYPE abap_compdescr,
      <ls_fcat>      TYPE lvc_s_fcat,
      <ls_flist>     TYPE dfies.

    lo_type_descr = cl_abap_typedescr=>describe_by_data( is_component ).

    lo_descr ?= lo_type_descr.

    lt_fieldlist = lo_descr->get_ddic_field_list( ).

    LOOP AT lo_descr->components ASSIGNING <ls_component>.
      APPEND INITIAL LINE TO rt_fcat ASSIGNING <ls_fcat>.
      READ TABLE lt_fieldlist ASSIGNING <ls_flist>
        WITH KEY fieldname = <ls_component>-name.
      CHECK sy-subrc = 0.
      MOVE-CORRESPONDING <ls_flist> TO <ls_fcat>.

      <ls_fcat>-ref_field = <ls_fcat>-fieldname.
      <ls_fcat>-ref_table = <ls_fcat>-tabname.
      "Clear for enable F1 using on field
      CLEAR <ls_fcat>-rollname.
      "Hide table type before set fcat
      IF <ls_fcat>-datatype = 'TTYP'.
        <ls_fcat>-tech = abap_true.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.                    "create_fcat
ENDCLASS.                    "lcl_alv IMPLEMENTATION

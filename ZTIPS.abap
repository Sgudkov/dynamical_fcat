"Defenition

	METHODS:
          create_fcat
            IMPORTING
                      is_component   TYPE any
            RETURNING VALUE(rt_fcat) TYPE lvc_t_fcat.


"Implementation

  METHOD create_fcat.

    DATA(lo_descr) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_data( is_component ) ).
    DATA(lt_fieldlist) = lo_descr->get_ddic_field_list( ).
    
    LOOP AT lo_descr->components ASSIGNING FIELD-SYMBOL(<ls_component>).
      APPEND INITIAL LINE TO rt_fcat ASSIGNING FIELD-SYMBOL(<ls_fcat>).
      <ls_fcat> = CORRESPONDING #( VALUE #( lt_fieldlist[ fieldname = <ls_component>-name ] OPTIONAL ) ).
      <ls_fcat>-ref_field = <ls_fcat>-fieldname.
      <ls_fcat>-ref_table = <ls_fcat>-tabname.
	  "Clear for enable F1 using on field
	  CLEAR <ls_fcat>-rollname.
	  "Hide table type before set fcat
      IF <ls_fcat>-datatype = 'TTYP'.
        <ls_fcat>-tech = abap_true.
      ENDIF.		
    ENDLOOP.
	
  ENDMETHOD.	
  
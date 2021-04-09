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
    ENDLOOP.
	
  ENDMETHOD.	
  
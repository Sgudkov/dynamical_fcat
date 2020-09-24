"Defenition
	
	CLASS-DATA:
		mt_fieldcat TYPE lvc_t_fcat.
	
	CLASS-METHODS:
	  create_fcat,	
      get_field_desc
        IMPORTING is_component     TYPE abap_compdescr
        RETURNING VALUE(rv_fdescr) TYPE as4text


"Implementation

  METHOD create_fcat.
    DATA:
      ls_componenet TYPE ZSTRUCT "<-- Type your global struct here

    "Get fileds names of global struct
    DATA(lo_descr) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_data( ls_componenet ) ).

    LOOP AT lo_descr->components ASSIGNING FIELD-SYMBOL(<ls_component>) .
      APPEND INITIAL LINE TO mt_fieldcat ASSIGNING FIELD-SYMBOL(<ls_fcat>).
      <ls_fcat>-fieldname = <ls_component>-name.
	  
      "Get field description
      <ls_fcat>-coltext =  get_field_desc( <ls_component> ).  

    ENDLOOP.
	
  ENDMETHOD.	


  METHOD get_field_desc.

    CONSTANTS lc_structname    TYPE ddobjname VALUE 'NAME OF YOUR GLOBAL STRUCT'.

    DATA lt_dfies TYPE TABLE OF dfies.

    "Get field description
    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING
        tabname   = lc_structname
        fieldname = is_component-name
        langu     = sy-langu
      TABLES
        dfies_tab = lt_dfies.

    rv_fdescr = VALUE #( lt_dfies[ 1 ]-fieldtext OPTIONAL ).

  ENDMETHOD.  
CLASS zpcs02_main DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpcs02_main IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TRY.
        DATA(re_unique_id) = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32(  ).
      CATCH cx_uuid_error INTO DATA(ex).
        "handle exception
        out->write( |{ ex->get_text(  ) }| ).
    ENDTRY.

    DATA(logging) = NEW zpcs02_logger( writer = out client = '100' re_unique_id = re_unique_id ).

    logging->log( |Hello World.| ).

    logging->log( |Done.| ).

  ENDMETHOD.
ENDCLASS.

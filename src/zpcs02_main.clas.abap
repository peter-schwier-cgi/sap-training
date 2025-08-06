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
        " DATA(re_unique_id) = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16(  ).
        DATA(re_unique_id) = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( version = 4 ).
      CATCH cx_uuid_error INTO DATA(ex).
        "handle exception
        out->write( |{ ex->get_text(  ) }| ).
    ENDTRY.

    TRY.

        DATA(logging) = NEW zpcs02_logger( writer = out client = '100' re_unique_id = re_unique_id ).

        logging->log( |Hello World.| ).

        logging->log( |Done.| ).

        FINAL(logs) = logging->get_logs(  ).

        out->write( logs ).

      CATCH cx_uuid_error INTO DATA(ex2).
        "handle exception
        out->write( |{ ex2->get_text(  ) }| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.

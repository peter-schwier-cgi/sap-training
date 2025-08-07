*"* use this source file for your ABAP unit test classes
CLASS ltcl_test DEFINITION FOR TESTING
RISK LEVEL HARMLESS
 DURATION SHORT.

  PRIVATE SECTION.
    METHODS test2 FOR TESTING
      RAISING
        cx_uuid_error.
ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD test2.
    DATA(logger) = NEW zpcs02_logger( client = |100| ).
    logger->log( |Hello World| ).
  ENDMETHOD.

ENDCLASS.

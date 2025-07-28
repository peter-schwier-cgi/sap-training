*"* use this source file for your ABAP unit test classes
CLASS ltcl_test DEFINITION FOR TESTING
RISK LEVEL HARMLESS
 DURATION SHORT.

  PRIVATE SECTION.
    METHODS test1 FOR TESTING.
ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD test1.
    TEST-INJECTION zpcs02_logger_unique_id.
      unique_id = 'b046851b09a04ecf8c155fe1b8d5319d'.
    END-TEST-INJECTION.
    TEST-INJECTION zpcs02_logger_timestamp.
    END-TEST-INJECTION.
    TEST-INJECTION zpcs02_logger_insert.
      DATA default_timestamp TYPE utclong.
      DATA default_unique_id TYPE c LENGTH 36.
      cl_abap_unit_assert=>assert_equals( exp = '100' act = record-client ).
      cl_abap_unit_assert=>assert_equals( exp = default_timestamp act = record-timestamp ).
      cl_abap_unit_assert=>assert_equals( exp = 'b046851b09a04ecf8c155fe1b8d5319d' act = record-unique_id ).
      cl_abap_unit_assert=>assert_equals( exp = default_unique_id act = record-re_unique_id ).
      cl_abap_unit_assert=>assert_equals( exp = |Hello World| act = record-note ).
    END-TEST-INJECTION.

    DATA logger TYPE REF TO zpcs02_logger.
    logger = NEW #( client = |100| ).
    logger->log( |Hello World| ).
  ENDMETHOD.

ENDCLASS.

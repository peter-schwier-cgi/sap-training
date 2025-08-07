*"* use this source file for your ABAP unit test classes
CLASS ltcl_test DEFINITION FOR TESTING
RISK LEVEL HARMLESS
 DURATION SHORT.

  PRIVATE SECTION.
    METHODS test1 FOR TESTING
              RAISING
                cx_uuid_error.
    METHODS test2 FOR TESTING
              RAISING
                cx_uuid_error.
ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD test1.
    TEST-INJECTION zpcs02_logger_unique_id.
      CALL METHOD cl_system_uuid=>if_system_uuid_static~convert_uuid_c32
        EXPORTING
          uuid     = '6B9EE2C84FFC4DA4867B55D63C9E0A86'
        IMPORTING
          uuid_x16 = unique_id.
    END-TEST-INJECTION.
    TEST-INJECTION zpcs02_logger_timestamp.
    END-TEST-INJECTION.
    TEST-INJECTION zpcs02_logger_insert.
      DATA default_timestamp TYPE utclong.
      DATA default_unique_id TYPE x LENGTH 16.
      cl_abap_unit_assert=>assert_equals( exp = default_timestamp act = record-timestamp ).
      cl_abap_unit_assert=>assert_equals( exp = unique_id act = record-UniqueId ).
      cl_abap_unit_assert=>assert_equals( exp = default_unique_id act = record-ReUniqueId ).
      cl_abap_unit_assert=>assert_equals( exp = |Hello World| act = record-note ).
    END-TEST-INJECTION.

    DATA logger TYPE REF TO zpcs02_logger.
    logger = NEW #( client = |100| ).
    logger->log( |Hello World| ).
  ENDMETHOD.

  METHOD test2.
    DATA(logger) = NEW zpcs02_logger( client = |100| ).
    logger->log( |Hello World| ).
  ENDMETHOD.

ENDCLASS.

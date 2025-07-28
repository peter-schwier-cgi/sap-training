CLASS zpcs02_logger DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: t_client TYPE c LENGTH 3.

    METHODS constructor
      IMPORTING
        client       TYPE t_client
        re_unique_id TYPE zpcs02_reuniqueid OPTIONAL
        generator    TYPE REF TO if_system_uuid OPTIONAL
        writer          TYPE REF TO if_oo_adt_classrun_out OPTIONAL
      .

    METHODS regarding
      IMPORTING
                re_unique_id TYPE zpcs02_reuniqueid
      RETURNING VALUE(this)  TYPE REF TO zpcs02_logger.

    METHODS log
      IMPORTING
                note        TYPE zpcs02_note
      RETURNING VALUE(this) TYPE REF TO zpcs02_logger.
    .

  PROTECTED SECTION.
    DATA client TYPE t_client.
    DATA re_unique_id TYPE zpcs02_reuniqueid.
    DATA generator TYPE REF TO if_system_uuid.
    DATA writer TYPE REF TO if_oo_adt_classrun_out.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpcs02_logger IMPLEMENTATION.
  METHOD constructor.
    me->client = client.
    me->re_unique_id = re_unique_id.
    me->writer = writer.
    IF generator IS INITIAL.
      me->generator = cl_uuid_factory=>create_system_uuid( ).
    ELSE.
      me->generator = generator.
    ENDIF.
  ENDMETHOD.

  METHOD log.
    TEST-SEAM zpcs02_logger_unique_id.
      TRY.
          DATA(unique_id) = me->generator->create_uuid_c32( ).
        CATCH cx_uuid_error.
          "handle exception
          " Doing nothing here because I can't figure out a valid recovery action.
      ENDTRY.
    END-TEST-SEAM.
    TEST-SEAM zpcs02_logger_timestamp.
      DATA(timestamp) = utclong_current( ).
    END-TEST-SEAM.
    DATA records TYPE TABLE OF zpcs02_log.
    DATA record TYPE zpcs02_log.
    record-client = me->client.
    record-timestamp = timestamp.
    record-unique_id = unique_id.
    record-re_unique_id = me->re_unique_id.
    record-note = note.

    TEST-SEAM zpcs02_logger_insert.
      INSERT INTO zpcs02_log VALUES @record.
    END-TEST-SEAM.

    IF NOT me->writer IS INITIAL.
      me->writer->write( |{ record-timestamp }: [{ record-re_unique_id }] { record-note }| ).
    ENDIF.

    this = me.
  ENDMETHOD.

  METHOD regarding.
    this = NEW zpcs02_logger( client = me->client re_unique_id = re_unique_id generator = me->generator ).
  ENDMETHOD.

ENDCLASS.

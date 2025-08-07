CLASS zpcs02_logger DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: t_client TYPE c LENGTH 3.
    TYPES: tt_ZR_PCS02_LOG TYPE STANDARD TABLE OF zr_pcs02_log WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        client       TYPE t_client
        re_unique_id TYPE zpcs02_reuniqueid OPTIONAL
        generator    TYPE REF TO if_system_uuid OPTIONAL
        writer       TYPE REF TO if_oo_adt_classrun_out OPTIONAL
      .

    METHODS regarding
      IMPORTING
                re_unique_id TYPE zpcs02_reuniqueid
      RETURNING VALUE(this)  TYPE REF TO zpcs02_logger.

    METHODS log
      IMPORTING
                note        TYPE zpcs02_note
      RETURNING VALUE(this) TYPE REF TO zpcs02_logger
      RAISING
                cx_uuid_error.

    METHODS get_logs
      IMPORTING
                count         TYPE i DEFAULT 5
      RETURNING VALUE(result) TYPE tt_ZR_PCS02_LOG.

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

    TEST-SEAM zpcs02_logger_entity_create.

      MODIFY ENTITY zr_pcs02_log
      CREATE FIELDS ( ReUniqueId Note ) WITH VALUE #(
        ( %cid = 'cid1' ReUniqueId = me->re_unique_id Note = note )
       )
      FAILED FINAL(failed)
      REPORTED FINAL(reported)
      MAPPED FINAL(records).

      COMMIT ENTITIES.

    END-TEST-SEAM.

    IF NOT me->writer IS INITIAL.
      me->writer->write( |{ records-zr_pcs02_log[ 1 ]-Timestamp }: [{ me->re_unique_id }] { note }.| ).
    ENDIF.

    this = me.
  ENDMETHOD.

  METHOD regarding.
    this = NEW zpcs02_logger( client = me->client re_unique_id = re_unique_id generator = me->generator ).
  ENDMETHOD.

  METHOD get_logs.
    " TODO: Need to update this to use EML.
    SELECT FROM zr_pcs02_log
    FIELDS *
    ORDER BY Timestamp DESCENDING
    INTO TABLE @FINAL(sql_result)
    UP TO @count ROWS
    .
    result = sql_result.
  ENDMETHOD.

ENDCLASS.

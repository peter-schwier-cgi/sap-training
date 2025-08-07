CLASS lhc_ZR_PCS02_LOG DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_pcs02_log RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_pcs02_log RESULT result.

*    METHODS ValidateHasNote FOR VALIDATE ON SAVE
*      IMPORTING keys FOR zr_pcs02_log~ValidateHasNote.
*    METHODS SetTimestamp FOR DETERMINE ON SAVE
*      IMPORTING keys FOR zr_pcs02_log~SetTimestamp.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE zr_pcs02_log.

ENDCLASS.

CLASS lhc_ZR_PCS02_LOG IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.
*
*  METHOD ValidateHasNote.
*
*    READ ENTITIES OF zr_pcs02_log IN LOCAL MODE
*    ENTITY zr_pcs02_log
*    FIELDS ( Note )
*    WITH CORRESPONDING #(  keys )
*    RESULT FINAL(lt_logs)
*    FAILED DATA(lt_failed).
*
*    failed = CORRESPONDING #( DEEP lt_failed ).
*
*    LOOP AT lt_logs INTO DATA(ls_log).
*      IF ls_log-Note IS INITIAL OR strlen( ls_log-Note ) < 1.
*        APPEND VALUE #(  %tky = ls_log-%tky ) TO failed-zr_pcs02_log.
*      ENDIF.
*    ENDLOOP.
*
*  ENDMETHOD.
*
*  METHOD SetTimestamp.
*
*    READ ENTITIES OF zr_pcs02_log IN LOCAL MODE
*    ENTITY zr_pcs02_log
*    FIELDS ( Note )
*    WITH CORRESPONDING #(  keys )
*    RESULT DATA(lt_logs).
*
*    LOOP AT lt_logs INTO DATA(ls_log).
*
*      ls_log-Timestamp = utclong_current( ).
*
*      MODIFY lt_logs FROM ls_log.
*
*    ENDLOOP.
*
*    DATA logs_upd TYPE TABLE FOR UPDATE zr_pcs02_log.
*
*    logs_upd = CORRESPONDING #( lt_logs ).
*
*    MODIFY ENTITIES OF zr_pcs02_log IN LOCAL MODE
*    ENTITY zr_pcs02_log
*    UPDATE
*    FIELDS ( Timestamp )
*    WITH logs_upd
*    REPORTED DATA(reported_records).
*
*    reported-zr_pcs02_log = CORRESPONDING #( reported_records-zr_pcs02_log ).
*
*  ENDMETHOD.

  METHOD earlynumbering_create.
    LOOP AT entities INTO FINAL(ls_entity).
      TRY.
          APPEND VALUE #(
              %cid = ls_entity-%cid
              Timestamp =  utclong_current( )
              uniqueid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( version = 4 )
           ) TO mapped-zr_pcs02_log.
        CATCH cx_uuid_error.
          "handle exception

          " No error handling implemented, because how do you recover from a failure to create a random UUID?
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_PCS02_LOG DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_pcs02_log RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_pcs02_log RESULT result.

    METHODS ValidateHasNote FOR VALIDATE ON SAVE
      IMPORTING keys FOR zr_pcs02_log~ValidateHasNote.

ENDCLASS.

CLASS lhc_ZR_PCS02_LOG IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ValidateHasNote.

    READ ENTITIES OF zr_pcs02_log IN LOCAL MODE
    ENTITY zr_pcs02_log
    FIELDS ( Note )
    WITH CORRESPONDING #(  keys )
    RESULT FINAL(lt_logs)
    FAILED DATA(lt_failed).

    failed = CORRESPONDING #( DEEP lt_failed ).

    LOOP AT lt_logs INTO DATA(ls_log).
      IF ls_log-Note IS INITIAL or STRLEN( ls_log-Note ) < 1.
        APPEND VALUE #(  %tky = ls_log-%tky ) TO failed-zr_pcs02_log.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

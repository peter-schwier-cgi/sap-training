CLASS LHC_ZR_PCS02_LOG DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrPcs02Log
        RESULT result,
      earlynumbering_create FOR NUMBERING
            IMPORTING entities FOR CREATE ZrPcs02Log.
ENDCLASS.

CLASS LHC_ZR_PCS02_LOG IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD earlynumbering_create.
    LOOP AT entities INTO FINAL(ls_entity).
      TRY.
          APPEND VALUE #(
              %cid = ls_entity-%cid
              Timestamp =  utclong_current( )
              uniqueid = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( version = 4 )
           ) TO mapped-zrpcs02log.
        CATCH cx_uuid_error.
          "handle exception

          " No error handling implemented, because how do you recover from a failure to create a random UUID?
          APPEND VALUE #(
           %cid = ls_entity-%cid
          ) TO failed-zrpcs02log.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

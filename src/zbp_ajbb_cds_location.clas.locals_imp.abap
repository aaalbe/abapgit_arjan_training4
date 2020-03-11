CLASS lhc_Location DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS DeterminationForNewRecord FOR DETERMINATION Location~DeterminationForNewRecord
      IMPORTING keys FOR Location.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Location RESULT result.

    METHODS validationonkeyfields FOR VALIDATION location~ValidationOnKeyfields
      IMPORTING keys FOR location.

    METHODS ValidationOnLocation FOR VALIDATION location~ValidationOnLocation
      IMPORTING keys FOR location.

    METHODS ValidationOnAddress FOR VALIDATION location~ValidationOnAddress
      IMPORTING keys FOR location.

    METHODS ValidationOnTicketPrice FOR VALIDATION location~ValidationOnTicketPrice
      IMPORTING keys FOR location.

    METHODS ValidationOthers FOR VALIDATION location~ValidationOthers
      IMPORTING keys FOR location.

    METHODS get_geolocation FOR MODIFY
      IMPORTING keys FOR ACTION location~get_geolocation RESULT result.

ENDCLASS.

CLASS lhc_Location IMPLEMENTATION.

  METHOD DeterminationForNewRecord.
    DATA lt_update TYPE  TABLE FOR UPDATE zajbb_cds_location.

    READ ENTITIES OF zajbb_cds_location
        ENTITY location
        FROM VALUE #( FOR <root_key> IN keys ( %key = <root_key> ) )
        RESULT DATA(lt_location).

    MOVE-CORRESPONDING  lt_location TO lt_update.
*    SELECT MAX( locationid ) FROM zaj_dt_location INTO @DATA(locationid).
    LOOP AT lt_update ASSIGNING FIELD-SYMBOL(<location>).
      IF <location>-description IS INITIAL.
        <location>-description = |No description available|.
        <location>-%control-description   = cl_abap_behv=>flag_changed.
      ENDIF.

      IF <location>-rating IS INITIAL.
        <location>-rating = 5.
        <location>-%control-rating   = cl_abap_behv=>flag_changed.
      ENDIF.

      IF <location>-seats_unit IS INITIAL.
        <location>-seats_unit = |ST|.
        <location>-%control-seats_unit   = cl_abap_behv=>flag_changed.
      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zajbb_cds_location  IN LOCAL MODE
                ENTITY location
                       UPDATE FROM lt_update .
  ENDMETHOD.

  METHOD get_features.
    result = VALUE #( FOR ls_variable IN keys
                    ( %key                        = ls_variable-%key
                      %features-%field-locationid = if_abap_behv=>fc-f-read_only
                    )
                  ).
  ENDMETHOD.

  METHOD validationonkeyfields.
    DATA: msg_text TYPE string.
    READ ENTITIES OF zajbb_cds_location IN LOCAL MODE
        ENTITY location
        FROM VALUE #( FOR <root_key>
                      IN keys ( locationid = <root_key>-locationid
                                %control = VALUE #(
                                  locationid = if_abap_behv=>mk-on
                                )
                      )
                    ) RESULT DATA(lt_location).

    LOOP AT lt_location ASSIGNING FIELD-SYMBOL(<location>).
      IF <location>-locationid IS INITIAL.
        msg_text = 'Location id cannot be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-locationid = if_abap_behv=>mk-on
                      ) TO reported.

      ELSEIF <location>-locationid < '9000'.
        msg_text = 'Location id should be between 9000 and 9999.'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-locationid = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validationonaddress.
    DATA: msg_text TYPE string.
    READ ENTITIES OF zajbb_cds_location IN LOCAL MODE
        ENTITY location
        FROM VALUE #( FOR <root_key> IN keys ( locationid = <root_key>-locationid
                                               %control = VALUE #(
                                                    locationid = if_abap_behv=>mk-on
                                                    street = if_abap_behv=>mk-on
                                                    houseno = if_abap_behv=>mk-on
                                                    postalcode = if_abap_behv=>mk-on
                                                    city = if_abap_behv=>mk-on
                                                    area = if_abap_behv=>mk-on
                                               )
                                             )
                    ) RESULT DATA(lt_location).

    LOOP AT lt_location ASSIGNING FIELD-SYMBOL(<location>).
      IF <location>-street IS INITIAL.
        msg_text = 'Street can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-street = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
      IF <location>-houseno IS INITIAL.
        msg_text = 'House number can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-houseno = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
      IF <location>-postalcode IS INITIAL.
        msg_text = 'Zipcode can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-postalcode = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
      IF <location>-city IS INITIAL.
        msg_text = 'City can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-city = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
      IF <location>-area IS INITIAL.
        msg_text = 'Area can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-area = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validationonlocation.
    DATA: msg_text TYPE string.
    READ ENTITIES OF zajbb_cds_location IN LOCAL MODE
        ENTITY location
        FROM VALUE #( FOR <root_key> IN keys ( locationid = <root_key>-locationid
                                               %control = VALUE #(
                                                    locationid = if_abap_behv=>mk-on
                                                    location = if_abap_behv=>mk-on
                                                    attraction = if_abap_behv=>mk-on
                                               )
                                             )
                    ) RESULT DATA(lt_location).

    LOOP AT lt_location ASSIGNING FIELD-SYMBOL(<location>).
      IF <location>-location IS INITIAL.
        msg_text = 'Location can not be empty'.
        APPEND VALUE #( locationid = <location>-location ) TO failed.
        APPEND VALUE #( locationid = <location>-location
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-location = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.

      IF <location>-attraction IS INITIAL.
        msg_text = 'Attraction can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-attraction = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validationonticketprice.
    DATA: msg_text TYPE string.
    READ ENTITIES OF zajbb_cds_location IN LOCAL MODE
        ENTITY location
        FROM VALUE #( FOR <root_key> IN keys ( locationid = <root_key>-locationid
                                               %control = VALUE #(
                                                    locationid = if_abap_behv=>mk-on
                                                    ticketprice = if_abap_behv=>mk-on
                                                    currency = if_abap_behv=>mk-on
                                               )
                                             )
                    ) RESULT DATA(lt_location).

    LOOP AT lt_location ASSIGNING FIELD-SYMBOL(<location>).
      IF <location>-Ticketprice IS INITIAL.
        msg_text = 'ticketprice can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-ticketprice = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
      IF <location>-currency IS INITIAL.
        msg_text = 'Currency can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-currency = if_abap_behv=>mk-on
                      ) TO reported.
      ELSE.
        CASE <location>-currency.
          WHEN 'EUR' OR 'USD'.
          WHEN OTHERS.
            msg_text = 'Only EUR and USD are supported'.
            APPEND VALUE #( locationid = <location>-locationid ) TO failed.
            APPEND VALUE #( locationid = <location>-locationid
                            %msg = new_message( id = 'SABP_BEHV'
                                                number = '100'
                                                v1 = msg_text
                                                severity = if_abap_behv_message=>severity-error )
                            %element-currency = if_abap_behv=>mk-on
                          ) TO reported.
        ENDCASE.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validationothers.
    DATA: msg_text TYPE string.
    READ ENTITIES OF zajbb_cds_location IN LOCAL MODE
        ENTITY location
        FROM VALUE #( FOR <root_key> IN keys ( locationid = <root_key>-locationid
                                               %control = VALUE #(
                                                    locationid = if_abap_behv=>mk-on
                                                    phone = if_abap_behv=>mk-on
                                                    website = if_abap_behv=>mk-on
                                                    seats_total = if_abap_behv=>mk-on
                                               )
                                             )
                    ) RESULT DATA(lt_location).

    LOOP AT lt_location ASSIGNING FIELD-SYMBOL(<location>).

      IF <location>-phone IS INITIAL.
        msg_text = 'Phone can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-phone = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
      IF <location>-website IS INITIAL.
        msg_text = 'Website can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-website = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.
      IF <location>-seats_total IS INITIAL.
        msg_text = 'Maximum seats can not be empty'.
        APPEND VALUE #( locationid = <location>-locationid ) TO failed.
        APPEND VALUE #( locationid = <location>-locationid
                        %msg = new_message( id = 'SABP_BEHV'
                                            number = '100'
                                            v1 = msg_text
                                            severity = if_abap_behv_message=>severity-error )
                        %element-seats_total = if_abap_behv=>mk-on
                      ) TO reported.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD get_geolocation.
    DATA lt_update TYPE  TABLE FOR UPDATE zajbb_cds_location.

    READ ENTITY zajbb_cds_location\\location
           FIELDS ( locationid
                    street
                    houseno
                    city
                    postalcode
                    area
                  )
             WITH VALUE #( FOR <root_key> IN keys (  %key = <root_key>-%key ) )
           RESULT    DATA(lt_location)
           FAILED    failed
           REPORTED  reported.

    MOVE-CORRESPONDING  lt_location TO lt_update.

    LOOP AT lt_update ASSIGNING FIELD-SYMBOL(<location>).
      CASE <location>-area.
        WHEN 'Amsterdam Beach'.
          <location>-latitude     = CONV f( |52.268308| ).
          <location>-longitude    = CONV f( |4.550096| ).
        WHEN 'Amsterdam City'.
          <location>-latitude     = CONV f( |52.358037| ).
          <location>-longitude    = CONV f( |4.879755| ).
        WHEN 'Amsterdam Castles & Gardens'.
          <location>-latitude     = CONV f( |52.334312| ).
          <location>-longitude    = CONV f( |5.071558| ).
        WHEN OTHERS.

          DATA(msg_text) = 'Cannot determine geolocation for ' && <location>-area.
          APPEND VALUE #( locationid = <location>-locationid ) TO failed-location.
          APPEND VALUE #( locationid = <location>-locationid
                          %msg = new_message( id = 'SABP_BEHV'
                                              number = '100'
                                              v1 = msg_text
                                              severity = if_abap_behv_message=>severity-error )
                          %element-seats_total = if_abap_behv=>mk-on
                        ) TO reported-location.
      ENDCASE.
    ENDLOOP.


    MODIFY ENTITIES OF zajbb_cds_location IN LOCAL MODE
           ENTITY      location
           UPDATE FIELDS (
           latitude
           longitude
           )
           WITH lt_update
           FAILED      failed
           REPORTED    reported.

    result = VALUE #( FOR update IN  lt_update INDEX INTO idx
                             ( %cid_ref = keys[ idx ]-%cid_ref
                               %key     = keys[ idx ]-locationid
                               %param   = CORRESPONDING #(  update ) ) ) .



  ENDMETHOD.


ENDCLASS.

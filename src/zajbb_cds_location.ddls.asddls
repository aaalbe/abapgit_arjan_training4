@AbapCatalog.sqlViewName: 'ZAJBBCL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Locations'
@Metadata.allowExtensions: true
@Search.searchable: true


define root view ZAJBB_CDS_LOCATION
  as select from zaj_dt_location
  association [0..*] to Zajbb_cds_bookings        as _bookings        on $projection.locationid = _bookings.locationid

  association [0..*] to zajbb_cds_bookings_cube   as _bookingscube    on $projection.locationid = _bookingscube.locationid
  association [0..1] to zajbb_cds_bookings_today  as _bookings_total  on $projection.locationid = _bookings_total.locationid
  association [0..1] to ZajBB_CDS_BOOKINGS_RATING as _bookings_rating on $projection.locationid = _bookings_rating.locationid
  association [0..1] to Z00bb_Cds_Current_Date    as _currentdate     on _currentdate.currentdate is not initial
{

  key locationid,
      location,
      street,
      houseno,
      postalcode,
      city,
      area,
      attraction,
      phone,
      latitude,
      longitude,
      _bookings_rating.reviewrate,
      _bookings_total.ticketsbooked   as seats_booked,
      cast (seats_total as abap.int1) as seats_total,
      'website'                       as gotowebsite,
      website,
      @Semantics.amount.currencyCode: 'currency'
      ticketprice,
      @Semantics.currencyCode: true
      currency,

      @Semantics.amount.currencyCode: 'currencyeuro'
      CURRENCY_CONVERSION(
      amount => ticketprice,
      source_currency => currency,
      target_currency => cast( 'EUR' as abap.cuky ),
      exchange_rate_date => _currentdate.currentdate,
      error_handling => 'SET_TO_NULL' ) as ticketpriceineuro,

      //      @Semantics.amount.currencyCode: 'currencyeuro'
      //      CURRENCY_CONVERSION(
      //      amount => ticketprice,
      //      source_currency => currency,
      //      target_currency => cast( 'EUR' as abap.cuky ),
      //      exchange_rate_date => cast( tstmp_to_dats(tstmp_current_utctimestamp(),abap_system_timezone($session.client, 'NULL'), $session.client, 'NULL') as abap.dats ),
      //      error_handling => 'SET_TO_NULL' )                                                                                  as ticketpriceineuro,

      @Semantics.currencyCode: true
      cast( 'EUR' as abap.cuky )      as currencyeuro,


      description,
      logo_url,
      @Semantics.systemDateTime.lastChangedAt: true
      changedat,
      @Semantics.user.lastChangedBy: true
      changedby,
      @Semantics.systemDateTime.createdAt: true
      createdat,
      @Semantics.user.createdBy: true
      createdby,

      _bookings,
      _bookingscube,

      @UI.hidden: true
      rating,
      @UI.hidden: true
      seats_unit
}

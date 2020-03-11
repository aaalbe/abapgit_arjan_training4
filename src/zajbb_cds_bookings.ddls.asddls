@AbapCatalog.sqlViewName: 'ZAJBBCB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bookings'
@Metadata.allowExtensions: true


define view Zajbb_cds_bookings
  as select from zaj_dt_bookings
{

      //zaj_dt_bookings
  key bookingid,
      firstname,
      lastname,
      street,
      houseno,
      postalcode,
      city,
      country,
      locationid,
      bookingdate,
      tstmp_to_dats(bookingdate,abap_system_timezone($session.client, 'NULL'), $session.client, 'NULL')                  as dateofbooking,
      visitdate,
      tstmp_to_dats(visitdate,abap_system_timezone($session.client, 'NULL'), $session.client, 'NULL')                    as dateofvisit,
      numberoftickets,
      reviewrate,
      reviewcomment,

      tstmp_to_dats(tstmp_current_utctimestamp(),abap_system_timezone($session.client, 'NULL'), $session.client, 'NULL') as currentdate


}

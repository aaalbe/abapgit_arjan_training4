@AbapCatalog.sqlViewName: 'ZAJBBCBTT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Today`s bookings'
define view zajbb_cds_bookings_today
  as select from Zajbb_cds_bookings
{
  key locationid,
      currentdate,
      sum( numberoftickets ) as ticketsbooked
}
where
  dateofvisit = currentdate
group by
  locationid,
  currentdate

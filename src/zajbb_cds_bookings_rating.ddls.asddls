@AbapCatalog.sqlViewName: 'ZAJBBCR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bookings ratings'


/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZajBB_CDS_BOOKINGS_RATING 
  as select distinct from Zajbb_cds_bookings
{
  locationid,
  avg(reviewrate) as reviewrate
}
group by
  locationid

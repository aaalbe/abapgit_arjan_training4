@AbapCatalog.sqlViewName: 'ZAJBBCCD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Current Date'
define view zajbb_cds_current_date
  as select from I_Country
{
  tstmp_to_dats( tstmp_current_utctimestamp(),
                           abap_system_timezone( $session.client,'NULL' ),
                           $session.client,
                           'NULL' ) as currentdate
}
where
  Country = 'NL'

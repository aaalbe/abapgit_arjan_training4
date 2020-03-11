@AbapCatalog.sqlViewName: 'ZAJBBCAVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Valuehelp for Area'

define view ZajBB_CDS_AREA_VH
  as select distinct from zaj_dt_location
{
  key area
}

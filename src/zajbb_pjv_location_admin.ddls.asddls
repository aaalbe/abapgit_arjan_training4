@EndUserText.label: 'Projection View for Administator'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define root view entity Zajbb_pjv_location_admin  as projection on ZAJBB_CDS_LOCATION
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
      seats_total,
      website,
      @Semantics.amount.currencyCode: 'currency'
      ticketprice,
      @Semantics.currencyCode: true
      currency,
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
      seats_unit


}

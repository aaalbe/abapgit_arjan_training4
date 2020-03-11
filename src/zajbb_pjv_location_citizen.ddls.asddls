@EndUserText.label: 'Projection View for Citizen'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZAJBB_PJV_LOCATION_CITIZEN
  as projection on ZAJBB_CDS_LOCATION
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
      seats_booked,
      seats_total,
      gotowebsite,
      website,
      description,
      logo_url,
      @Semantics.currencyCode: true
      currencyeuro,
      @Semantics.amount.currencyCode: 'currencyeuro'
      ticketpriceineuro,
      reviewrate,
      seats_unit,
      _bookings
}

@AbapCatalog.sqlViewName: 'ZAJBBCBC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Analytics bookings'

@UI.chart:[{
    qualifier:'FilterTicketsByBooking',
    chartType: #COLUMN,
    measures:[ 'ticketsbooked' ],
    dimensions: ['dateofvisit']
}]

define view zajbb_cds_bookings_cube
  as select from Zajbb_cds_bookings
  /*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
{
      /** KEY **/
  key concat(concat( locationid,bookingid ), cast(dateofvisit as abap.char(10) )) as keyId,
      /** DIMENSIONS **/
      bookingid,
      locationid,
      @EndUserText.label: 'First name'
      firstname,
      @EndUserText.label: 'Last name'
      lastname,
      @EndUserText.label: 'Street'
      street,
      @EndUserText.label: 'No'
      houseno,
      @EndUserText.label: 'Postalcode'
      postalcode,
      @EndUserText.label: 'City'
      city,
      @EndUserText.label: 'Country'
      country,

      @EndUserText.label: 'Date of visit'
      dateofvisit,
      @EndUserText.label: 'Date of booking'
      dateofbooking,

      /** MEASURES **/
      @EndUserText.label: 'Unique locations'
      @Aggregation.referenceElement: ['locationid']
      @Aggregation.default: #COUNT_DISTINCT
      cast( 1 as abap.int4 )                                                      as DistinctLocations,

      @EndUserText.label: 'Tickets booked'
      @Aggregation.referenceElement: ['ticketsbooked']
      @Aggregation.default: #SUM
      numberoftickets                                                             as ticketsbooked,

      @EndUserText.label: 'Review Rate'
      @Aggregation.referenceElement: ['reviewrate']
      @Aggregation.default: #AVG
      reviewrate
}

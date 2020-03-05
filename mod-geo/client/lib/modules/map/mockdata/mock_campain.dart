

class Campaign{
  final String campaignName;
  final String campaignAffiliation;
  final Location location;

  Campaign({this.campaignName,this.campaignAffiliation,  this.location});
}

class Location{
  final double latitude;
  final double longitude;

  Location({this.latitude, this.longitude});
}


List<Campaign> campaigns = [
  Campaign(
    campaignName: "London Tax Strike",
    campaignAffiliation: "Extiction Rebelion",
    location: Location(
      latitude: 51.5074,
      longitude: 0.1278
    ),
  ),

   Campaign(
    campaignName: "Stop LNG Gas Export Depot",
    campaignAffiliation: "Extiction Rebelion",
    location: Location(
      latitude: 51.5074,
      longitude: 0.1278
    ),
  ),

   Campaign(
    campaignName: "Shut Down Hambach Coal Mine",
    campaignAffiliation: "Extiction Rebelion",
    location: Location(
      latitude: 51.5074,
      longitude: 0.1278
    ),
  ),

   Campaign(
    campaignName: "NY State Shutdown Pipline",
    campaignAffiliation: "Extiction Rebelion",
    location: Location(
      latitude: 51.5074,
      longitude: 0.1278
    ),
  ),
];
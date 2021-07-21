class Place {
  String route;
  String locality;
  String administrativeAreaLevel1;
  String country;
  String formattedAddress;
  double lat;
  double lng;
  Place({
    this.route = '',
    this.locality = '',
    this.administrativeAreaLevel1 = '',
    this.country = '',
    this.formattedAddress = '',
    this.lat = 0.0,
    this.lng = 0.0,
  });

  @override
  String toString() {
    return 'Place(route: $route, locality: $locality, administrative_area_level_1: $administrativeAreaLevel1, country: $country, formatted_address: $formattedAddress, lat: $lat, lng: $lng)';
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

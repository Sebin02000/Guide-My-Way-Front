// LocationModel model with addres and coordinates in dart
enum LocationType {
  currentLocation,
  destination,
  intermediate,
  origin,
  service,
  notSet,
}


class LocationModel {
  final String address;
  final double latitude;
  final double longitude;
  final String locationId;
  LocationType locationType;
  final double rotaion;

  LocationModel(
      {required this.address,
      required this.latitude,
      required this.longitude,
      this.locationId = "",
      this.rotaion = 0.0,
      this.locationType = LocationType.notSet});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

LocationModel locationModelFromPlaceSearch(Map<String, dynamic> json) {
  return LocationModel(
    address: json['formatted_address'],
    latitude: json['geometry']['location']['lat'],
    longitude: json['geometry']['location']['lng'],
  );
}

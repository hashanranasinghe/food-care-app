class PlaceDetails {
  final String name;
  final double latitude;
  final double longitude;

  PlaceDetails({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    final location = json['result']['geometry']['location'];

    return PlaceDetails(
      name: json['result']['name'],
      latitude: location['lat'],
      longitude: location['lng'],
    );
  }
}

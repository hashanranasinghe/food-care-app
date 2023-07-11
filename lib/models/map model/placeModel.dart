class Place {
  final String placeId;
  final String name;
  final double latitude;
  final double longitude;

  Place({
    required this.placeId,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    final location = json['geometry']['location'];

    return Place(
        placeId: json['place_id'],
        name: json['name'],
        latitude: location['lat'],
        longitude: location['lng']);
  }
}

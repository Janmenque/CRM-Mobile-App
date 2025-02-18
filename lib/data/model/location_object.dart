class LocationObject {
  LocationObject({
    this.location,
    this.latitude,
    this.longitude,
  });

  String? location;
  double? latitude;
  double? longitude;

  factory LocationObject.fromJson(Map<String, dynamic> json) => LocationObject(
    location: json["location"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "location": location,
    "latitude": latitude,
    "longitude": longitude,
  };
}

import 'dart:convert';

ResponseLocation responseLocationFromJson(String str) => ResponseLocation.fromJson(json.decode(str));

String responseLocationToJson(ResponseLocation data) => json.encode(data.toJson());

class ResponseLocation {
  ResponseLocation({
    this.place,
    this.status,
  });

  Place? place;
  int? status;

  factory ResponseLocation.fromJson(Map<String, dynamic> json) => ResponseLocation(
    place: json["place"] != null ? Place.fromJson(json["place"]) : null,
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "place": place!.toJson(),
    "status": status,
  };
}

class Place {
  Place({
    this.id,
    this.distanceWithinMeters,
    this.address,
    this.area,
    this.city,
    this.postCode,
    this.locationType,
    this.district,
    this.country,
    this.subDistrict,
    this.union,
    this.pauroshova,
    this.division,
    this.addressComponents,
    this.areaComponents,
  });

  int? id;
  double? distanceWithinMeters;
  String? address;
  String? area;
  String? city;
  int? postCode;
  String? locationType;
  String? district;
  String? country;
  String? subDistrict;
  String? union;
  String? pauroshova;
  String? division;
  AddressComponents? addressComponents;
  AreaComponents? areaComponents;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    id: json["id"],
    distanceWithinMeters: json["distance_within_meters"].toDouble(),
    address: json["address"],
    area: json["area"],
    city: json["city"],
    postCode: json["postCode"],
    locationType: json["location_type"],
    district: json["district"],
    country: json["country"],
    subDistrict: json["sub_district"],
    union: json["union"],
    pauroshova: json["pauroshova"],
    division: json["division"],
    addressComponents: AddressComponents.fromJson(json["address_components"]),
    areaComponents: AreaComponents.fromJson(json["area_components"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "distance_within_meters": distanceWithinMeters,
    "address": address,
    "area": area,
    "city": city,
    "postCode": postCode,
    "location_type": locationType,
    "district": district,
    "country": country,
    "sub_district": subDistrict,
    "union": union,
    "pauroshova": pauroshova,
    "division": division,
    "address_components": addressComponents!.toJson(),
    "area_components": areaComponents!.toJson(),
  };
}

class AddressComponents {
  AddressComponents({
    this.placeName,
    this.house,
    this.road,
  });

  String? placeName;
  String? house;
  String? road;

  factory AddressComponents.fromJson(Map<String, dynamic> json) => AddressComponents(
    placeName: json["place_name"],
    house: json["house"],
    road: json["road"],
  );

  Map<String, dynamic> toJson() => {
    "place_name": placeName,
    "house": house,
    "road": road,
  };
}

class AreaComponents {
  AreaComponents({
    this.area,
    this.subArea,
  });

  String? area;
  String? subArea;

  factory AreaComponents.fromJson(Map<String, dynamic> json) => AreaComponents(
    area: json["area"],
    subArea: json["sub_area"],
  );

  Map<String, dynamic> toJson() => {
    "area": area,
    "sub_area": subArea,
  };
}

import 'dart:convert';

ClientProfileDetailsModel clientProfileDetailsModelFromJson(String str) => ClientProfileDetailsModel.fromJson(json.decode(str));


class ClientProfileDetailsModel {
  bool? result;
  String? message;
  Data? data;

  ClientProfileDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientProfileDetailsModel.fromJson(Map<String, dynamic> json) => ClientProfileDetailsModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Profile? profile;
  BillingAddress? billingAddress;
  BillingAddress? shippingAddress;
  Status? status;
  ProfileCountry? country;
  Group? group;

  Data({
    this.profile,
    this.billingAddress,
    this.shippingAddress,
    this.status,
    this.country,
    this.group,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
    billingAddress: json["billing_address"] == null ? null : BillingAddress.fromJson(json["billing_address"]),
    shippingAddress: json["shipping_address"] == null ? null : BillingAddress.fromJson(json["shipping_address"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    country: json["country"] == null ? null : ProfileCountry.fromJson(json["country"]),
    group: json["group"] == null ? null : Group.fromJson(json["group"]),
  );
}

class BillingAddress {
  int? id;
  int? clientId;
  String? street;
  String? city;
  String? state;
  String? zip;
  String? type;

  BillingAddress({
    this.id,
    this.clientId,
    this.street,
    this.city,
    this.state,
    this.zip,
    this.type,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    id: json["id"],
    clientId: json["client_id"],
    street: json["street"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    type: json["type"],
  );
}

class ProfileCountry {
  int? id;
  String? countryCode;
  String? name;

  ProfileCountry({
    this.id,
    this.countryCode,
    this.name,
  });

  factory ProfileCountry.fromJson(Map<String, dynamic> json) => ProfileCountry(
    id: json["id"],
    countryCode: json["country_code"],
    name: json["name"],
  );
}

class Group {
  int? id;
  String? name;

  Group({
    this.id,
    this.name,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    name: json["name"],
  );
}

class Profile {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? website;
  dynamic description;
  DateTime? date;
  String? avatar;

  Profile({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.zip,
    this.website,
    this.description,
    this.date,
    this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    website: json["website"],
    description: json["description"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    avatar: json["avatar"],
  );
}

class Status {
  int? id;
  String? name;
  String? statusClass;
  String? colorCode;
  String? translatedName;

  Status({
    this.id,
    this.name,
    this.statusClass,
    this.colorCode,
    this.translatedName,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    statusClass: json["class"],
    colorCode: json["color_code"],
    translatedName: json["translated_name"],
  );
}

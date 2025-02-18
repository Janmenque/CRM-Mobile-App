
import 'dart:convert';

CountryListModel countryListModelFromJson(String str) => CountryListModel.fromJson(json.decode(str));


class CountryListModel {
  bool? result;
  String? message;
  List<Country>?  data;

  CountryListModel({
    this.result,
    this.message,
    this.data,
  });

  factory CountryListModel.fromJson(Map<String, dynamic> json) => CountryListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Country>.from(json["data"]!.map((x) => Country.fromJson(x))),
  );

}

class Country {
  int? id;
  String? name;
  String? countryCode;

  Country({
    this.id,
    this.name,
    this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    countryCode: json["country_code"],
  );
}

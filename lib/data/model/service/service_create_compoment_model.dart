import 'dart:convert';

ServiceCreateComponentModel serviceCreateComponentModelFromJson(String str) => ServiceCreateComponentModel.fromJson(json.decode(str));


class ServiceCreateComponentModel {
  bool? result;
  String? message;
  Data? data;

  ServiceCreateComponentModel({
    this.result,
    this.message,
    this.data,
  });

  factory ServiceCreateComponentModel.fromJson(Map<String, dynamic> json) => ServiceCreateComponentModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<ServiceCategory>? categories;
  List<Zone>? zone;
  Map<String, String>? status;

  Data({
    this.categories,
    this.zone,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categories: json["categories"] == null ? [] : List<ServiceCategory>.from(json["categories"]!.map((x) => ServiceCategory.fromJson(x))),
    zone: json["zone"] == null ? [] : List<Zone>.from(json["zone"]!.map((x) => Zone.fromJson(x))),
    status: Map.from(json["status"]!).map((k, v) => MapEntry<String, String>(k, v)),
  );
}

class ServiceCategory {
  int? id;
  String? name;
  List<ServiceSubCategory>? subCategories;

  ServiceCategory({
    this.id,
    this.name,
    this.subCategories,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) => ServiceCategory(
    id: json["id"],
    name: json["name"],
    subCategories: json["sub_categories"] == null ? [] : List<ServiceSubCategory>.from(json["sub_categories"]!.map((x) => ServiceSubCategory.fromJson(x))),
  );

}

class ServiceSubCategory {
  int? id;
  int? categoryId;
  String? name;

  ServiceSubCategory({
    this.id,
    this.categoryId,
    this.name,
  });

  factory ServiceSubCategory.fromJson(Map<String, dynamic> json) => ServiceSubCategory(
    id: json["id"],
    categoryId: json["category_id"],
    name: json["name"],
  );
}

class Zone {
  int? id;
  String? name;

  Zone({
    this.id,
    this.name,
  });

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    id: json["id"],
    name: json["name"],
  );
}

import 'dart:convert';

DiscountCreateComponentListModel discountCreateComponentListModelFromJson(String str) => DiscountCreateComponentListModel.fromJson(json.decode(str));


class DiscountCreateComponentListModel {
  bool? result;
  String? message;
  Data? data;

  DiscountCreateComponentListModel({
    this.result,
    this.message,
    this.data,
  });

  factory DiscountCreateComponentListModel.fromJson(Map<String, dynamic> json) => DiscountCreateComponentListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<DiscountComponent>? serviceZones;
  List<DiscountComponent>? serviceCategories;
  List<DiscountComponent>? services;
  List<CouponType>? couponTypes;

  Data({
    this.serviceZones,
    this.serviceCategories,
    this.services,
    this.couponTypes
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    serviceZones: json["serviceZones"] == null ? [] : List<DiscountComponent>.from(json["serviceZones"]!.map((x) => DiscountComponent.fromJson(x))),
    serviceCategories: json["serviceCategories"] == null ? [] : List<DiscountComponent>.from(json["serviceCategories"]!.map((x) => DiscountComponent.fromJson(x))),
    services: json["services"] == null ? [] : List<DiscountComponent>.from(json["services"]!.map((x) => DiscountComponent.fromJson(x))),
    couponTypes: json["couponTypes"] == null ? [] : List<CouponType>.from(json["couponTypes"]!.map((x) => CouponType.fromJson(x))),
  );
}

class DiscountComponent {
  int? id;
  String? name;

  DiscountComponent({
    this.id,
    this.name,
  });

  factory DiscountComponent.fromJson(Map<String, dynamic> json) => DiscountComponent(
    id: json["id"],
    name: json["name"],
  );
}

class CouponType {
  String? name;

  CouponType({
    this.name,
  });

  factory CouponType.fromJson(Map<String, dynamic> json) => CouponType(
    name: json["name"],
  );

}
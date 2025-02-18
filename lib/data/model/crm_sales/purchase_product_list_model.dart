
import 'dart:convert';

PurchaseProductListModel purchaseProductListModelFromJson(String str) => PurchaseProductListModel.fromJson(json.decode(str));


class PurchaseProductListModel {
  bool? result;
  String? message;
  Data? data;

  PurchaseProductListModel({
    this.result,
    this.message,
    this.data,
  });

  factory PurchaseProductListModel.fromJson(Map<String, dynamic> json) => PurchaseProductListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Tax>? taxList;
  List<PurchaseProduct>? purchaseProductList;
  List<Tax>? purchaseStatusList;

  Data({
    this.taxList,
    this.purchaseProductList,
    this.purchaseStatusList
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    taxList: json["tax_list"] == null ? [] : List<Tax>.from(json["tax_list"]!.map((x) => Tax.fromJson(x))),
    purchaseProductList: json["purchase_product_list"] == null ? [] : List<PurchaseProduct>.from(json["purchase_product_list"]!.map((x) => PurchaseProduct.fromJson(x))),
    purchaseStatusList: json["purchase_status_list"] == null ? [] : List<Tax>.from(json["purchase_status_list"]!.map((x) => Tax.fromJson(x))),
  );
}

class PurchaseProduct {
  int? id;
  String? name;
  String? code;

  PurchaseProduct({
    this.id,
    this.name,
    this.code,
  });

  factory PurchaseProduct.fromJson(Map<String, dynamic> json) => PurchaseProduct(
    id: json["id"],
    name: json["name"],
    code: json["code"],
  );
}

class Tax {
  int? id;
  String? name;

  Tax({
    this.id,
    this.name,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
    id: json["id"],
    name: json["name"],
  );
}

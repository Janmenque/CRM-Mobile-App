
import 'dart:convert';

ProductListAccordingWarehouseModel productListAccordingWarehouseModelFromJson(String str) => ProductListAccordingWarehouseModel.fromJson(json.decode(str));

String productListAccordingWarehouseModelToJson(ProductListAccordingWarehouseModel data) => json.encode(data.toJson());

class ProductListAccordingWarehouseModel {
  bool? result;
  String? message;
  List<WareHouseProduct>? data;

  ProductListAccordingWarehouseModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProductListAccordingWarehouseModel.fromJson(Map<String, dynamic> json) => ProductListAccordingWarehouseModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<WareHouseProduct>.from(json["data"]!.map((x) => WareHouseProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WareHouseProduct {
  String? code;
  String? name;
  int? qty;

  WareHouseProduct({
    this.code,
    this.name,
    this.qty,
  });

  factory WareHouseProduct.fromJson(Map<String, dynamic> json) => WareHouseProduct(
    code: json["code"],
    name: json["name"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "qty": qty,
  };
}


import 'dart:convert';

SupplierListModel supplierListModelFromJson(String str) => SupplierListModel.fromJson(json.decode(str));


class SupplierListModel {
  bool? result;
  String? message;
  List<Supplier>? data;

  SupplierListModel({
    this.result,
    this.message,
    this.data,
  });

  factory SupplierListModel.fromJson(Map<String, dynamic> json) => SupplierListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Supplier>.from(json["data"]!.map((x) => Supplier.fromJson(x))),
  );
}

class Supplier {
  int? id;
  String? name;

  Supplier({
    this.id,
    this.name,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
    id: json["id"],
    name: json["name"],
  );

}

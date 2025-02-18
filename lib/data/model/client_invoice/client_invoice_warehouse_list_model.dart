
import 'dart:convert';

ClientInvoiceWarehouseListModel clientInvoiceWarehouseListModelFromJson(String str) => ClientInvoiceWarehouseListModel.fromJson(json.decode(str));

class ClientInvoiceWarehouseListModel {
  bool? result;
  String? message;
  List<ClientInvoiceWarehouse>? data;

  ClientInvoiceWarehouseListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientInvoiceWarehouseListModel.fromJson(Map<String, dynamic> json) => ClientInvoiceWarehouseListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ClientInvoiceWarehouse>.from(json["data"]!.map((x) => ClientInvoiceWarehouse.fromJson(x))),
  );
}

class ClientInvoiceWarehouse {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  DateTime? createdAt;

  ClientInvoiceWarehouse({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.createdAt,
  });

  factory ClientInvoiceWarehouse.fromJson(Map<String, dynamic> json) => ClientInvoiceWarehouse(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );
}

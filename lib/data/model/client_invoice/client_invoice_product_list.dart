import 'dart:convert';

ClientInvoiceProductListModel clientInvoiceProductListModelFromJson(String str) => ClientInvoiceProductListModel.fromJson(json.decode(str));


class ClientInvoiceProductListModel {
  bool? result;
  String? message;
  List<ClientInvoiceProduct>? data;

  ClientInvoiceProductListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientInvoiceProductListModel.fromJson(Map<String, dynamic> json) => ClientInvoiceProductListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ClientInvoiceProduct>.from(json["data"]!.map((x) => ClientInvoiceProduct.fromJson(x))),
  );
}

class ClientInvoiceProduct {
  int? id;
  String? name;
  String? slug;
  String? code;
  String? type;
  int? cost;
  int? price;
  int? isImei;
  int? isBatch;
  int? isEmbeded;
  dynamic alertQuantity;
  int? qty;
  dynamic expiredDate;
  dynamic promotionPrice;
  DateTime? createdAt;
  Warehouse? warehouse;

  ClientInvoiceProduct({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.type,
    this.cost,
    this.price,
    this.isImei,
    this.isBatch,
    this.isEmbeded,
    this.alertQuantity,
    this.qty,
    this.expiredDate,
    this.promotionPrice,
    this.createdAt,
    this.warehouse,
  });

  factory ClientInvoiceProduct.fromJson(Map<String, dynamic> json) => ClientInvoiceProduct(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    code: json["code"],
    type: json["type"],
    cost: json["cost"],
    price: json["price"],
    isImei: json["is_imei"],
    isBatch: json["is_batch"],
    isEmbeded: json["is_embeded"],
    alertQuantity: json["alert_quantity"],
    qty: json["qty"],
    expiredDate: json["expired_date"],
    promotionPrice: json["promotion_price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    warehouse: json["warehouse"] == null ? null : Warehouse.fromJson(json["warehouse"]),
  );


}

class Warehouse {
  int? id;
  String? name;

  Warehouse({
    this.id,
    this.name,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

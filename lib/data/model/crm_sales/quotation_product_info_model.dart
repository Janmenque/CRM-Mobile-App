import 'dart:convert';

QuotationProductInfoModel quotationProductInfoModelFromJson(String str) => QuotationProductInfoModel.fromJson(json.decode(str));

class QuotationProductInfoModel {
  bool? result;
  String? message;
  Data? data;

  QuotationProductInfoModel({
    this.result,
    this.message,
    this.data,
  });

  factory QuotationProductInfoModel.fromJson(Map<String, dynamic> json) => QuotationProductInfoModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  String? name;
  String? code;
  int? cost;
  int? taxRate;
  String? taxName;
  int? taxMethod;
  String? purchaseUnit;
  int? id;
  int? isImei;
  String? netUnitPrice;
  String? tax;
  String? subTotal;

  Data({
    this.name,
    this.code,
    this.cost,
    this.taxRate,
    this.taxName,
    this.taxMethod,
    this.purchaseUnit,
    this.id,
    this.isImei,
    this.netUnitPrice,
    this.tax,
    this.subTotal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    code: json["code"],
    cost: json["cost"],
    taxRate: json["tax_rate"],
    taxName: json["tax_name"],
    taxMethod: json["tax_method"],
    purchaseUnit: json["purchase_unit"],
    id: json["id"],
    isImei: json["is_imei"],
    netUnitPrice: json["net_unit_price"],
    tax: json["tax"],
    subTotal: json["sub_total"],
  );
}
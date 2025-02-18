import 'dart:convert';

PurchaseProductInfoModel purchaseProductInfoModelFromJson(String str) => PurchaseProductInfoModel.fromJson(json.decode(str));

class PurchaseProductInfoModel {
  bool? result;
  String? message;
  Data? data;

  PurchaseProductInfoModel({
    this.result,
    this.message,
    this.data,
  });

  factory PurchaseProductInfoModel.fromJson(Map<String, dynamic> json) => PurchaseProductInfoModel(
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
  String? unitOperator;
  String? unitOperationValue;
  int? id;
  int? isBatch;
  int? isImei;
  String? netUnitCost;
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
    this.unitOperator,
    this.unitOperationValue,
    this.id,
    this.isBatch,
    this.isImei,
    this.netUnitCost,
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
    unitOperator: json["unit_operator"],
    unitOperationValue: json["unit_operation_value"],
    id: json["id"],
    isBatch: json["is_batch"],
    isImei: json["is_imei"],
    netUnitCost: json["net_unit_cost"],
    tax: json["tax"],
    subTotal: json["sub_total"],
  );
}

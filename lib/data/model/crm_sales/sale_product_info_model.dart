
import 'dart:convert';

SaleProductInfoModel saleProductInfoModelFromJson(String str) => SaleProductInfoModel.fromJson(json.decode(str));


class SaleProductInfoModel {
  bool? result;
  String? message;
  Data? data;

  SaleProductInfoModel({
    this.result,
    this.message,
    this.data,
  });

  factory SaleProductInfoModel.fromJson(Map<String, dynamic> json) => SaleProductInfoModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  String? name;
  String? code;
  int? price;
  int? tax;
  String? taxName;
  int? taxMethod;
  String? saleUnit;
  int? productId;
  dynamic variantId;
  int? promotion;
  int? isBatch;
  int? isImei;
  dynamic isVariant;
  String? quantity;
  double? netUnitPrice;
  double? taxRate;
  int? subTotal;

  Data({
    this.name,
    this.code,
    this.price,
    this.tax,
    this.taxName,
    this.taxMethod,
    this.saleUnit,
    this.productId,
    this.variantId,
    this.promotion,
    this.isBatch,
    this.isImei,
    this.isVariant,
    this.quantity,
    this.netUnitPrice,
    this.taxRate,
    this.subTotal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    code: json["code"],
    price: json["price"],
    tax: json["tax"],
    taxName: json["tax_name"],
    taxMethod: json["tax_method"],
    saleUnit: json["sale_unit"],
    productId: json["product_id"],
    variantId: json["variant_id"],
    promotion: json["promotion"],
    isBatch: json["is_batch"],
    isImei: json["is_imei"],
    isVariant: json["is_variant"],
    quantity: json["quantity"],
    netUnitPrice: json["net_unit_price"]?.toDouble(),
    taxRate: json["tax_rate"]?.toDouble(),
    subTotal: json["sub_total"],
  );

}

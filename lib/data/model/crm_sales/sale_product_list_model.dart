
import 'dart:convert';

SaleProductListModel saleProductListModelFromJson(String str) => SaleProductListModel.fromJson(json.decode(str));

class SaleProductListModel {
  bool? result;
  String? message;
  List<SaleProduct>? data;

  SaleProductListModel({
    this.result,
    this.message,
    this.data,
  });

  factory SaleProductListModel.fromJson(Map<String, dynamic> json) => SaleProductListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SaleProduct>.from(json["data"]!.map((x) => SaleProduct.fromJson(x))),
  );
}

class SaleProduct {
  String? productCode;
  String? productName;
  int? productQty;
  int? productPrice;
  String? productType;
  int? productId;
  dynamic productList;
  dynamic qtyList;
  dynamic batchNo;
  dynamic productBatchId;
  dynamic expiredDate;
  int? isEmbeded;

  SaleProduct({
    this.productCode,
    this.productName,
    this.productQty,
    this.productPrice,
    this.productType,
    this.productId,
    this.productList,
    this.qtyList,
    this.batchNo,
    this.productBatchId,
    this.expiredDate,
    this.isEmbeded,
  });

  factory SaleProduct.fromJson(Map<String, dynamic> json) => SaleProduct(
    productCode: json["product_code"],
    productName: json["product_name"],
    productQty: json["product_qty"],
    productPrice: json["product_price"],
    productType: json["product_type"],
    productId: json["product_id"],
    productList: json["product_list"],
    qtyList: json["qty_list"],
    batchNo: json["batch_no"],
    productBatchId: json["product_batch_id"],
    expiredDate: json["expired_date"],
    isEmbeded: json["is_embeded"],
  );

}

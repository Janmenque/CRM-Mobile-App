import 'dart:convert';

QuotationProductListModel quotationProductListModelFromJson(String str) => QuotationProductListModel.fromJson(json.decode(str));


class QuotationProductListModel {
  bool? result;
  String? message;
  List<QuotationProduct>? data;

  QuotationProductListModel({
    this.result,
    this.message,
    this.data,
  });

  factory QuotationProductListModel.fromJson(Map<String, dynamic> json) => QuotationProductListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<QuotationProduct>.from(json["data"]!.map((x) => QuotationProduct.fromJson(x))),
  );
}

class QuotationProduct {
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

  QuotationProduct({
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
  });

  factory QuotationProduct.fromJson(Map<String, dynamic> json) => QuotationProduct(
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
  );
}

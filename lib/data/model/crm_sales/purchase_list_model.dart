
import 'dart:convert';

PurchaseListModel purchaseListModelFromJson(String str) => PurchaseListModel.fromJson(json.decode(str));

class PurchaseListModel {
  bool? result;
  String? message;
  Data? data;

  PurchaseListModel({
    this.result,
    this.message,
    this.data,
  });

  factory PurchaseListModel.fromJson(Map<String, dynamic> json) => PurchaseListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Purchase>? purchases;
  Pagination? pagination;

  Data({
    this.purchases,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    purchases: json["purchases"] == null ? [] : List<Purchase>.from(json["purchases"]!.map((x) => Purchase.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
  );
}

class Purchase {
  int? id;
  String? date;
  String? referenceNo;
  String? supplier;
  String? purchaseStatus;
  String? grandTotal;
  String? returnedAmount;
  String? paid;
  String? due;
  String? paymentStatus;

  Purchase({
    this.id,
    this.date,
    this.referenceNo,
    this.supplier,
    this.purchaseStatus,
    this.grandTotal,
    this.returnedAmount,
    this.paid,
    this.due,
    this.paymentStatus,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    id: json["id"],
    date: json["date"],
    referenceNo: json["reference_no"],
    supplier: json["supplier"],
    purchaseStatus: json["purchase_status"],
    grandTotal: json["grand_total"],
    returnedAmount: json["returned_amount"],
    paid: json["paid"],
    due: json["due"],
    paymentStatus: json["payment_status"],
  );

}

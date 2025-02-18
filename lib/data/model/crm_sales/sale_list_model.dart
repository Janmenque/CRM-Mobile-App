
import 'dart:convert';

SaleListModel saleListModelFromJson(String str) => SaleListModel.fromJson(json.decode(str));


class SaleListModel {
  bool? result;
  String? message;
  Data? data;

  SaleListModel({
    this.result,
    this.message,
    this.data,
  });

  factory SaleListModel.fromJson(Map<String, dynamic> json) => SaleListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Product>? products;
  Pagination? pagination;

  Data({
    this.products,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
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

class Product {
  int? id;
  DateTime? date;
  String? referenceNo;
  String? biller;
  String? customer;
  String? saleStatus;
  String? paymentStatus;
  String? deliveryStatus;
  String? grandTotal;
  String? returnedAmount;
  String? paid;
  String? due;

  Product({
    this.id,
    this.date,
    this.referenceNo,
    this.biller,
    this.customer,
    this.saleStatus,
    this.paymentStatus,
    this.deliveryStatus,
    this.grandTotal,
    this.returnedAmount,
    this.paid,
    this.due,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    referenceNo: json["reference_no"],
    biller: json["biller"],
    customer: json["customer"],
    saleStatus: json["sale_status"],
    paymentStatus: json["payment_status"],
    deliveryStatus: json["delivery_status"],
    grandTotal: json["grand_total"],
    returnedAmount: json["returned_amount"],
    paid: json["paid"],
    due: json["due"],
  );
}

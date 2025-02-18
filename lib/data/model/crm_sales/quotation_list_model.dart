import 'dart:convert';

QuotationListModel quotationListModelFromJson(String str) => QuotationListModel.fromJson(json.decode(str));


class QuotationListModel {
  bool? result;
  String? message;
  Data? data;

  QuotationListModel({
    this.result,
    this.message,
    this.data,
  });

  factory QuotationListModel.fromJson(Map<String, dynamic> json) => QuotationListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Quotation>? quotationList;
  Pagination? pagination;

  Data({
    this.quotationList,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    quotationList: json["quotationList"] == null ? [] : List<Quotation>.from(json["quotationList"]!.map((x) => Quotation.fromJson(x))),
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

class Quotation {
  int? id;
  String? date;
  String? referenceNo;
  String? warehouse;
  String? biller;
  String? customer;
  String? supplier;
  String? quotationStatus;
  String? grandTotal;

  Quotation({
    this.id,
    this.date,
    this.referenceNo,
    this.warehouse,
    this.biller,
    this.customer,
    this.supplier,
    this.quotationStatus,
    this.grandTotal,
  });

  factory Quotation.fromJson(Map<String, dynamic> json) => Quotation(
    id: json["id"],
    date: json["date"],
    referenceNo: json["reference_no"],
    warehouse: json["warehouse"],
    biller: json["biller"],
    customer: json["customer"],
    supplier: json["supplier"],
    quotationStatus: json["quotation_status"],
    grandTotal: json["grand_total"],
  );

}

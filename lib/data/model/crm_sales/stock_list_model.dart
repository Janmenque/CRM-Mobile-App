

import 'dart:convert';

StockManagementListModel stockManagementListModelFromJson(String str) => StockManagementListModel.fromJson(json.decode(str));


class StockManagementListModel {
  bool? result;
  String? message;
  Data? data;

  StockManagementListModel({
    this.result,
    this.message,
    this.data,
  });

  factory StockManagementListModel.fromJson(Map<String, dynamic> json) => StockManagementListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<StockList>? stockList;
  Pagination? pagination;

  Data({
    this.stockList,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    stockList: json["stockList"] == null ? [] : List<StockList>.from(json["stockList"]!.map((x) => StockList.fromJson(x))),
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

class StockList {
  int? id;
  String? date;
  String? referenceNo;
  String? warehouse;
  String? type;
  String? initialFile;
  String? finalFile;

  StockList({
    this.id,
    this.date,
    this.referenceNo,
    this.warehouse,
    this.type,
    this.initialFile,
    this.finalFile,
  });

  factory StockList.fromJson(Map<String, dynamic> json) => StockList(
    id: json["id"],
    date: json["date"],
    referenceNo: json["reference_no"],
    warehouse: json["warehouse"],
    type: json["type"],
    initialFile: json["initial_file"],
    finalFile: json["final_file"],
  );

}

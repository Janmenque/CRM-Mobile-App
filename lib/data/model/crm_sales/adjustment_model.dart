
import 'dart:convert';

AdjustmentModel adjustmentModelFromJson(String str) => AdjustmentModel.fromJson(json.decode(str));

String adjustmentModelToJson(AdjustmentModel data) => json.encode(data.toJson());

class AdjustmentModel {
  bool? result;
  String? message;
  Data? data;

  AdjustmentModel({
    this.result,
    this.message,
    this.data,
  });

  factory AdjustmentModel.fromJson(Map<String, dynamic> json) => AdjustmentModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<Adjustment>? adjustments;
  Pagination? pagination;

  Data({
    this.adjustments,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    adjustments: json["adjustments"] == null ? [] : List<Adjustment>.from(json["adjustments"]!.map((x) => Adjustment.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "adjustments": adjustments == null ? [] : List<dynamic>.from(adjustments!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Adjustment {
  int? id;
  List<Product>? products;
  String? referenceNo;
  String? date;
  String? warehouse;
  String? note;

  Adjustment({
    this.id,
    this.products,
    this.referenceNo,
    this.date,
    this.warehouse,
    this.note,
  });

  factory Adjustment.fromJson(Map<String, dynamic> json) => Adjustment(
    id: json["id"],
    products: json["products"] == null ? null : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    referenceNo: json["reference_no"],
    date: json["date"],
    warehouse: json["warehouse"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "reference_no": referenceNo,
    "date": date,
    "warehouse": warehouse,
    "note": note,
  };
}

class Product {
  String? name;

  Product({
    this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
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

  Map<String, dynamic> toJson() => {
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
  };
}

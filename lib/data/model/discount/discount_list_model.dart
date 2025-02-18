import 'dart:convert';

DiscountListModel discountListModelFromJson(String str) => DiscountListModel.fromJson(json.decode(str));

class DiscountListModel {
  bool? result;
  String? message;
  Data? data;

  DiscountListModel({
    this.result,
    this.message,
    this.data,
  });

  factory DiscountListModel.fromJson(Map<String, dynamic> json) => DiscountListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Discount>? discounts;
  Pagination? pagination;

  Data({
    this.discounts,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    discounts: json["discounts"] == null ? [] : List<Discount>.from(json["discounts"]!.map((x) => Discount.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "discounts": discounts == null ? [] : List<dynamic>.from(discounts!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Discount {
  int? id;
  String? title;
  String? discountType;
  String? zone;
  String? status;

  Discount({
    this.id,
    this.title,
    this.discountType,
    this.zone,
    this.status,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    id: json["id"],
    title: json["title"],
    discountType: json["discount_type"],
    zone: json["zone"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "discount_type": discountType,
    "zone": zone,
    "status": status,
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
import 'dart:convert';

CouponListModel couponListModelFromJson(String str) => CouponListModel.fromJson(json.decode(str));

class CouponListModel {
  bool? result;
  String? message;
  Data? data;

  CouponListModel({
    this.result,
    this.message,
    this.data,
  });

  factory CouponListModel.fromJson(Map<String, dynamic> json) => CouponListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Coupon>? coupons;
  Pagination? pagination;

  Data({
    this.coupons,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class Coupon {
  int? id;
  String? code;
  String? couponType;
  String? discountTitle;
  String? discountType;
  String? zone;
  String? status;

  Coupon({
    this.id,
    this.code,
    this.couponType,
    this.discountTitle,
    this.discountType,
    this.zone,
    this.status,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"],
    code: json["code"],
    couponType: json["coupon_type"],
    discountTitle: json["discount_title"],
    discountType: json["discount_type"],
    zone: json["zone"],
    status: json["status"],
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

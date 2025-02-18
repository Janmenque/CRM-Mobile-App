
import 'dart:convert';

BillerListModel billerListModelFromJson(String str) => BillerListModel.fromJson(json.decode(str));

class BillerListModel {
  bool? result;
  String? message;
  Data? data;

  BillerListModel({
    this.result,
    this.message,
    this.data,
  });

  factory BillerListModel.fromJson(Map<String, dynamic> json) => BillerListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Biller>? billers;
  Pagination? pagination;

  Data({
    this.billers,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    billers: json["billers"] == null ? [] : List<Biller>.from(json["billers"]!.map((x) => Biller.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class Biller {
  int? id;
  String? image;
  String? name;
  String? companyName;
  String? vatNumber;
  String? email;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? status;

  Biller({
    this.id,
    this.image,
    this.name,
    this.companyName,
    this.vatNumber,
    this.email,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.status,
  });

  factory Biller.fromJson(Map<String, dynamic> json) => Biller(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    companyName: json["company_name"],
    vatNumber: json["vat_number"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    country: json["country"],
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

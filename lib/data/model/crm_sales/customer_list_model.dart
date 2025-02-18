
import 'dart:convert';

CustomerListModel customerListModelFromJson(String str) => CustomerListModel.fromJson(json.decode(str));


class CustomerListModel {
  bool? result;
  String? message;
  Data? data;

  CustomerListModel({
    this.result,
    this.message,
    this.data,
  });

  factory CustomerListModel.fromJson(Map<String, dynamic> json) => CustomerListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Customer>? customers;
  Pagination? pagination;

  Data({
    this.customers,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customers: json["customers"] == null ? [] : List<Customer>.from(json["customers"]!.map((x) => Customer.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class Customer {
  int? id;
  dynamic customerGroup;
  String? name;
  String? companyName;
  String? email;
  String? phoneNumber;
  String? plan;
  int? points;
  String? balance;
  String? due;

  Customer({
    this.id,
    this.customerGroup,
    this.name,
    this.companyName,
    this.email,
    this.phoneNumber,
    this.plan,
    this.points,
    this.balance,
    this.due,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    customerGroup: json["customer_group"],
    name: json["name"],
    companyName: json["company_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    plan: json["plan"],
    points: json["points"],
    balance: json["balance"],
    due: json["due"],
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

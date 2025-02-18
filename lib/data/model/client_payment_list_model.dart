import 'dart:convert';


ClientInvoicePaymentListModel clientInvoicePaymentListModelFromJson(String str) => ClientInvoicePaymentListModel.fromJson(json.decode(str));

class ClientInvoicePaymentListModel {
  bool? result;
  String? message;
  Data? data;

  ClientInvoicePaymentListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientInvoicePaymentListModel.fromJson(Map<String, dynamic> json) => ClientInvoicePaymentListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<ClientPayment>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ClientPayment>.from(json["data"]!.map((x) => ClientPayment.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ClientPayment {
  int? id;
  int? change;
  String? paymentReference;
  int? amount;
  String? payingMethod;
  String? paymentNote;
  DateTime? createdAt;
  User? user;

  ClientPayment({
    this.id,
    this.change,
    this.paymentReference,
    this.amount,
    this.payingMethod,
    this.paymentNote,
    this.createdAt,
    this.user,
  });

  factory ClientPayment.fromJson(Map<String, dynamic> json) => ClientPayment(
    id: json["id"],
    change: json["change"],
    paymentReference: json["payment_reference"],
    amount: json["amount"],
    payingMethod: json["paying_method"],
    paymentNote: json["payment_note"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );
}

class User {
  int? id;
  String? name;

  User({
    this.id,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
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

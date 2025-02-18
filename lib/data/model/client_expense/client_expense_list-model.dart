import 'dart:convert';

ClientExpenseListModel clientExpenseListModelFromJson(String str) => ClientExpenseListModel.fromJson(json.decode(str));

class ClientExpenseListModel {
  bool? result;
  String? message;
  Data? data;

  ClientExpenseListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientExpenseListModel.fromJson(Map<String, dynamic> json) => ClientExpenseListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  String? totalAmount;
  ExpenseList? expenseList;

  Data({
    this.totalAmount,
    this.expenseList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalAmount: json["total_amount"],
    expenseList: json["expense_list"] == null ? null : ExpenseList.fromJson(json["expense_list"]),
  );
}

class ExpenseList {
  List<ClientExpenseList>? data;
  Links? links;
  Pagination? pagination;

  ExpenseList({
    this.data,
    this.links,
    this.pagination,
  });

  factory ExpenseList.fromJson(Map<String, dynamic> json) => ExpenseList(
    data: json["data"] == null ? [] : List<ClientExpenseList>.from(json["data"]!.map((x) => ClientExpenseList.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ClientExpenseList {
  int? id;
  String? category;
  String? date;
  String? amount;
  String? requestAmount;
  String? ref;
  String? remarks;
  Client? employee;
  Status? status;
  Status? paymentStatus;
  Client? client;

  ClientExpenseList({
    this.id,
    this.category,
    this.date,
    this.amount,
    this.requestAmount,
    this.ref,
    this.remarks,
    this.employee,
    this.status,
    this.paymentStatus,
    this.client,
  });

  factory ClientExpenseList.fromJson(Map<String, dynamic> json) => ClientExpenseList(
    id: json["id"],
    category: json["category"],
    date: json["date"],
    amount: json["amount"],
    requestAmount: json["request_amount"],
    ref: json["ref"],
    remarks: json["remarks"],
    employee: json["employee"] == null ? null : Client.fromJson(json["employee"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    paymentStatus: json["payment_status"] == null ? null : Status.fromJson(json["payment_status"]),
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
  );
}

class Client {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;

  Client({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
  );
}

class Status {
  int? id;
  String? name;
  String? statusClass;
  String? colorCode;
  String? translatedName;

  Status({
    this.id,
    this.name,
    this.statusClass,
    this.colorCode,
    this.translatedName,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    statusClass: json["class"],
    colorCode: json["color_code"],
    translatedName: json["translated_name"],
  );
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
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

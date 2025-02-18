import 'dart:convert';

ClientContactListModel clientContactListModelFromJson(String str) => ClientContactListModel.fromJson(json.decode(str));


class ClientContactListModel {
  bool? result;
  String? message;
  Data? data;

  ClientContactListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientContactListModel.fromJson(Map<String, dynamic> json) => ClientContactListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<ContactData>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ContactData>.from(json["data"]!.map((x) => ContactData.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ContactData {
  int? id;
  int? isInvoice;
  int? isEstimate;
  int? isProject;
  int? isTask;
  int? isTicket;
  int? isContract;
  int? isContact;
  int? isProposal;
  int? isNote;
  int? isFile;
  int? isReminder;
  int? isEmailInvoice;
  int? isEmailEstimate;
  int? isEmailProject;
  int? isEmailTask;
  int? isEmailTicket;
  int? isEmailContract;
  int? isEmailProposal;
  DateTime? createdAt;
  Client? client;
  User? user;

  ContactData({
    this.id,
    this.isInvoice,
    this.isEstimate,
    this.isProject,
    this.isTask,
    this.isTicket,
    this.isContract,
    this.isContact,
    this.isProposal,
    this.isNote,
    this.isFile,
    this.isReminder,
    this.isEmailInvoice,
    this.isEmailEstimate,
    this.isEmailProject,
    this.isEmailTask,
    this.isEmailTicket,
    this.isEmailContract,
    this.isEmailProposal,
    this.createdAt,
    this.client,
    this.user,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) => ContactData(
    id: json["id"],
    isInvoice: json["is_invoice"],
    isEstimate: json["is_estimate"],
    isProject: json["is_project"],
    isTask: json["is_task"],
    isTicket: json["is_ticket"],
    isContract: json["is_contract"],
    isContact: json["is_contact"],
    isProposal: json["is_proposal"],
    isNote: json["is_note"],
    isFile: json["is_file"],
    isReminder: json["is_reminder"],
    isEmailInvoice: json["is_email_invoice"],
    isEmailEstimate: json["is_email_estimate"],
    isEmailProject: json["is_email_project"],
    isEmailTask: json["is_email_task"],
    isEmailTicket: json["is_email_ticket"],
    isEmailContract: json["is_email_contract"],
    isEmailProposal: json["is_email_proposal"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );
}

class Client {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;

  Client({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic position;
  String? avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.position,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    position: json["position"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "position": position,
    "avatar": avatar,
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

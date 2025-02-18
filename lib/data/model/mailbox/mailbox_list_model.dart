
import 'dart:convert';

MailInboxListModel mailInboxListModelFromJson(String str) => MailInboxListModel.fromJson(json.decode(str));


class MailInboxListModel {
  bool? result;
  String? message;
  Data? data;

  MailInboxListModel({
    this.result,
    this.message,
    this.data,
  });

  factory MailInboxListModel.fromJson(Map<String, dynamic> json) => MailInboxListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<Mailbox>? mailbox;
  Pagination? pagination;

  Data({
    this.mailbox,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mailbox: json["mailbox"] == null ? [] : List<Mailbox>.from(json["mailbox"]!.map((x) => Mailbox.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class Mailbox {
  int? id;
  String? sender;
  String? subject;
  String? status;
  int? childrenCount;
  int? isRead;
  int? isStarred;
  int? isImportant;
  String? createdAt;
  dynamic deletedAt;
  List<Recipient>? recipients;
  dynamic parent;
  List<dynamic>? childrens;

  Mailbox({
    this.id,
    this.sender,
    this.subject,
    this.status,
    this.childrenCount,
    this.isRead,
    this.isStarred,
    this.isImportant,
    this.createdAt,
    this.deletedAt,
    this.recipients,
    this.parent,
    this.childrens,
  });

  factory Mailbox.fromJson(Map<String, dynamic> json) => Mailbox(
    id: json["id"],
    sender: json["sender"],
    subject: json["subject"],
    status: json["status"],
    childrenCount: json["children_count"],
    isRead: json["is_read"],
    isStarred: json["is_starred"],
    isImportant: json["is_important"],
    createdAt: json["created_at"],
    deletedAt: json["deleted_at"],
    recipients: json["recipients"] == null ? [] : List<Recipient>.from(json["recipients"]!.map((x) => Recipient.fromJson(x))),
    parent: json["parent"],
    childrens: json["childrens"] == null ? [] : List<dynamic>.from(json["childrens"]!.map((x) => x)),
  );
}

class Recipient {
  int? id;
  int? mailboxId;
  dynamic userId;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;

  Recipient({
    this.id,
    this.mailboxId,
    this.userId,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
    id: json["id"],
    mailboxId: json["mailbox_id"],
    userId: json["user_id"],
    email: json["email"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

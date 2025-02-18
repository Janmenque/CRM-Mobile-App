
import 'dart:convert';

MailDetailsModel mailDetailsModelFromJson(String str) => MailDetailsModel.fromJson(json.decode(str));


class MailDetailsModel {
  bool? result;
  String? message;
  Data? data;

  MailDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  factory MailDetailsModel.fromJson(Map<String, dynamic> json) => MailDetailsModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  int? id;
  String? sender;
  String? subject;
  String? status;
  dynamic childrenCount;
  int? isRead;
  int? isStarred;
  int? isImportant;
  String? createdAt;
  dynamic deletedAt;
  List<MailboxCc>? recipients;
  dynamic parent;
  List<MailboxCc>? mailboxCc;
  List<Attachment>? attachments;
  List<Data>? childrens;

  Data({
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
    this.mailboxCc,
    this.attachments,
    this.childrens,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    recipients: json["recipients"] == null ? [] : List<MailboxCc>.from(json["recipients"]!.map((x) => MailboxCc.fromJson(x))),
    parent: json["parent"],
    mailboxCc: json["mailboxCC"] == null ? [] : List<MailboxCc>.from(json["mailboxCC"]!.map((x) => MailboxCc.fromJson(x))),
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
    childrens: json["childrens"] == null ? [] : List<Data>.from(json["childrens"]!.map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender": sender,
    "subject": subject,
    "status": status,
    "children_count": childrenCount,
    "is_read": isRead,
    "is_starred": isStarred,
    "is_important": isImportant,
    "created_at": createdAt,
    "deleted_at": deletedAt,
    "recipients": recipients == null ? [] : List<dynamic>.from(recipients!.map((x) => x.toJson())),
    "parent": parent,
    "mailboxCC": mailboxCc == null ? [] : List<dynamic>.from(mailboxCc!.map((x) => x.toJson())),
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
    "childrens": childrens == null ? [] : List<dynamic>.from(childrens!.map((x) => x.toJson())),
  };
}

class Attachment {
  int? id;
  int? mailboxId;
  String? path;

  Attachment({
    this.id,
    this.mailboxId,
    this.path,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    mailboxId: json["mailbox_id"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mailbox_id": mailboxId,
    "path": path,
  };
}

class MailboxCc {
  int? id;
  int? mailboxId;
  String? email;

  MailboxCc({
    this.id,
    this.mailboxId,
    this.email,
  });

  factory MailboxCc.fromJson(Map<String, dynamic> json) => MailboxCc(
    id: json["id"],
    mailboxId: json["mailbox_id"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mailbox_id": mailboxId,
    "email": email,
  };
}

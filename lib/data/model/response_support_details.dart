
import 'dart:convert';

ResponseSupportDetails responseSupportDetailsFromJson(String str) => ResponseSupportDetails.fromJson(json.decode(str));

String responseSupportDetailsToJson(ResponseSupportDetails data) => json.encode(data.toJson());

class ResponseSupportDetails {
  bool? result;
  String? message;
  Data? data;

  ResponseSupportDetails({
    this.result,
    this.message,
    this.data,
  });

  factory ResponseSupportDetails.fromJson(Map<String, dynamic> json) => ResponseSupportDetails(
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
  String? code;
  String? subject;
  String? description;
  String? typeName;
  String? typeColor;
  String? priorityName;
  String? priorityColor;
  String? date;
  String? file;
  List<Attachment>? attachments;

  Data({
    this.code,
    this.subject,
    this.description,
    this.typeName,
    this.typeColor,
    this.priorityName,
    this.priorityColor,
    this.date,
    this.file,
    this.attachments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    code: json["code"],
    subject: json["subject"],
    description: json["description"],
    typeName: json["type_name"],
    typeColor: json["type_color"],
    priorityName: json["priority_name"],
    priorityColor: json["priority_color"],
    date: json["date"],
    file: json["file"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "subject": subject,
    "description": description,
    "type_name": typeName,
    "type_color": typeColor,
    "priority_name": priorityName,
    "priority_color": priorityColor,
    "date": date,
    "file": file,
    "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
  };
}

class Attachment {
  int? id;
  String? attachmentId;

  Attachment({
    this.id,
    this.attachmentId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"],
    attachmentId: json["attachment_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attachment_id": attachmentId,
  };
}

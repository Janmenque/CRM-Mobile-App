
import 'dart:convert';

ResponseNoticeDetails responseNoticeDetailsFromJson(String str) => ResponseNoticeDetails.fromJson(json.decode(str));

class ResponseNoticeDetails {
  bool? result;
  String? message;
  Data? data;

  ResponseNoticeDetails({
    this.result,
    this.message,
    this.data,
  });

  factory ResponseNoticeDetails.fromJson(Map<String, dynamic> json) => ResponseNoticeDetails(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  int? id;
  String? subject;
  String? description;
  String? date;
  dynamic file;
  List<Attachment>? attachments;

  Data({
    this.id,
    this.subject,
    this.description,
    this.date,
    this.file,
    this.attachments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    subject: json["subject"],
    description: json["description"],
    date: json["date"],
    file: json["file"],
    attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
  );
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
}

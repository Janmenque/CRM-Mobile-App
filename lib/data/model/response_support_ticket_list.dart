
import 'dart:convert';

ResponseSupportTicketList responseSupportTicketListFromJson(String str) =>
    ResponseSupportTicketList.fromJson(json.decode(str));

String responseSupportTicketListToJson(ResponseSupportTicketList data) =>
    json.encode(data.toJson());

class ResponseSupportTicketList {
  ResponseSupportTicketList({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseSupportTicketList.fromJson(Map<String, dynamic> json) =>
      ResponseSupportTicketList(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.data,
  });

  List<SupportList>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<SupportList>.from(
            json["data"].map((x) => SupportList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SupportList {
  SupportList({
    this.id,
    this.subject,
    this.file,
    this.typeName,
    this.typeColor,
    this.priorityName,
    this.priorityColor,
    this.date,
  });

  int? id;
  String? subject;
  String? file;
  String? typeName;
  String? typeColor;
  String? priorityName;
  String? priorityColor;
  String? date;

  factory SupportList.fromJson(Map<String, dynamic> json) => SupportList(
        id: json["id"],
        subject: json["subject"],
        file: json["file"],
        typeName: json["type_name"],
        typeColor: json["type_color"],
        priorityName: json["priority_name"],
        priorityColor: json["priority_color"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "file": file,
        "type_name": typeName,
        "type_color": typeColor,
        "priority_name": priorityName,
        "priority_color": priorityColor,
        "date": date,
      };
}

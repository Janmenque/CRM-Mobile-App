import 'dart:convert';

ComposeMailTicketList composeMailTicketListFromJson(String str) => ComposeMailTicketList.fromJson(json.decode(str));


class ComposeMailTicketList {
  bool? result;
  String? message;
  List<ComposeTicket>? data;

  ComposeMailTicketList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailTicketList.fromJson(Map<String, dynamic> json) => ComposeMailTicketList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeTicket>.from(json["data"]!.map((x) => ComposeTicket.fromJson(x))),
  );
}

class ComposeTicket {
  int? id;
  String? code;
  String? subject;

  ComposeTicket({
    this.id,
    this.code,
    this.subject,
  });

  factory ComposeTicket.fromJson(Map<String, dynamic> json) => ComposeTicket(
    id: json["id"],
    code: json["code"],
    subject: json["subject"],
  );
}

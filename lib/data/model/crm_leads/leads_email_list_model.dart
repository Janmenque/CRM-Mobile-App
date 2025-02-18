
import 'dart:convert';

LeadEmailListModel leadEmailListModelFromJson(String str) => LeadEmailListModel.fromJson(json.decode(str));

class LeadEmailListModel {
  bool? result;
  String? message;
  List<LeadEmail>? data;

  LeadEmailListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadEmailListModel.fromJson(Map<String, dynamic> json) => LeadEmailListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadEmail>.from(json["data"]!.map((x) => LeadEmail.fromJson(x))),
  );
}

class LeadEmail {
  String? date;
  String? author;
  String? message;
  String? subject;
  String? toEmail;
  String? ccEmail;

  LeadEmail({
    this.date,
    this.author,
    this.message,
    this.subject,
    this.toEmail,
    this.ccEmail,
  });

  factory LeadEmail.fromJson(Map<String, dynamic> json) => LeadEmail(
    date: json["date"],
    author: json["author"],
    message: json["message"],
    subject: json["subject"],
    toEmail: json["to_email"],
    ccEmail: json["cc_email"],
  );
}

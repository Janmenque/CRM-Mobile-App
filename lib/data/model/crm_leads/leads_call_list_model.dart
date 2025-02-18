import 'dart:convert';

LeadCallListModel leadCallListModelFromJson(String str) => LeadCallListModel.fromJson(json.decode(str));


class LeadCallListModel {
  bool? result;
  String? message;
  List<LeadCall>? data;

  LeadCallListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadCallListModel.fromJson(Map<String, dynamic> json) => LeadCallListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadCall>.from(json["data"]!.map((x) => LeadCall.fromJson(x))),
  );
}

class LeadCall {
  String? date;
  String? callDate;
  String? callType;
  String? author;
  String? duration;
  String? subject;
  String? message;
  String? number;

  LeadCall({
    this.date,
    this.callDate,
    this.callType,
    this.author,
    this.duration,
    this.subject,
    this.message,
    this.number,
  });

  factory LeadCall.fromJson(Map<String, dynamic> json) => LeadCall(
    date: json["date"],
    callDate: json["call_date"],
    callType: json["call_type"],
    author: json["author"],
    duration: json["duration"],
    subject: json["subject"],
    message: json["message"],
    number: json["number"],
  );
}

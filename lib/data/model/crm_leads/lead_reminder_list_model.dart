import 'dart:convert';

LeadReminderListModel leadReminderListModelFromJson(String str) => LeadReminderListModel.fromJson(json.decode(str));

class LeadReminderListModel {
  bool? result;
  String? message;
  List<LeadReminder>? data;

  LeadReminderListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadReminderListModel.fromJson(Map<String, dynamic> json) => LeadReminderListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadReminder>.from(json["data"]!.map((x) => LeadReminder.fromJson(x))),
  );

}

class LeadReminder {
  String? date;
  String? author;
  String? status;
  String? subject;
  String? message;

  LeadReminder({
    this.date,
    this.author,
    this.status,
    this.subject,
    this.message,
  });

  factory LeadReminder.fromJson(Map<String, dynamic> json) => LeadReminder(
    date: json["date"],
    author: json["author"],
    status: json["status"],
    subject: json["subject"],
    message: json["message"],
  );

}


import 'dart:convert';

LeadTaskListModel leadTaskListModelFromJson(String str) => LeadTaskListModel.fromJson(json.decode(str));

class LeadTaskListModel {
  bool? result;
  String? message;
  List<LeadTask>? data;

  LeadTaskListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadTaskListModel.fromJson(Map<String, dynamic> json) => LeadTaskListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadTask>.from(json["data"]!.map((x) => LeadTask.fromJson(x))),
  );
}

class LeadTask {
  String? date;
  String? author;
  String? status;
  String? subject;
  String? message;

  LeadTask({
    this.date,
    this.author,
    this.status,
    this.subject,
    this.message,
  });

  factory LeadTask.fromJson(Map<String, dynamic> json) => LeadTask(
    date: json["date"],
    author: json["author"],
    status: json["status"],
    subject: json["subject"],
    message: json["message"],
  );
}

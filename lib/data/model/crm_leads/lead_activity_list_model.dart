import 'dart:convert';

LeadActivityListModel leadActivityListModelFromJson(String str) => LeadActivityListModel.fromJson(json.decode(str));

class LeadActivityListModel {
  bool? result;
  String? message;
  List<LeadActivity>? data;

  LeadActivityListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadActivityListModel.fromJson(Map<String, dynamic> json) => LeadActivityListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadActivity>.from(json["data"]!.map((x) => LeadActivity.fromJson(x))),
  );
}

class LeadActivity {
  String? date;
  String? author;
  String? status;
  String? message;

  LeadActivity({
    this.date,
    this.author,
    this.status,
    this.message,
  });

  factory LeadActivity.fromJson(Map<String, dynamic> json) => LeadActivity(
    date: json["date"],
    author: json["author"],
    status: json["status"],
    message: json["message"],
  );

}

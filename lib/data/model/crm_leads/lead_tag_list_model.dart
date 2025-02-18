
import 'dart:convert';

LeadTagListModel leadTagListModelFromJson(String str) => LeadTagListModel.fromJson(json.decode(str));


class LeadTagListModel {
  bool? result;
  String? message;
  List<LeadTag>? data;

  LeadTagListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadTagListModel.fromJson(Map<String, dynamic> json) => LeadTagListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadTag>.from(json["data"]!.map((x) => LeadTag.fromJson(x))),
  );
}

class LeadTag {
  String? date;
  String? author;
  String? name;

  LeadTag({
    this.date,
    this.author,
    this.name,
  });

  factory LeadTag.fromJson(Map<String, dynamic> json) => LeadTag(
    date: json["date"],
    author: json["author"],
    name: json["name"],
  );
}

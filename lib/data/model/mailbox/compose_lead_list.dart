
import 'dart:convert';

ComposeMailLeadList composeMailLeadListFromJson(String str) => ComposeMailLeadList.fromJson(json.decode(str));


class ComposeMailLeadList {
  bool? result;
  String? message;
  List<ComposeLead>? data;

  ComposeMailLeadList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailLeadList.fromJson(Map<String, dynamic> json) => ComposeMailLeadList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeLead>.from(json["data"]!.map((x) => ComposeLead.fromJson(x))),
  );
}

class ComposeLead {
  int? id;
  String? name;
  String? title;

  ComposeLead({
    this.id,
    this.name,
    this.title,
  });

  factory ComposeLead.fromJson(Map<String, dynamic> json) => ComposeLead(
    id: json["id"],
    name: json["name"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
  };
}

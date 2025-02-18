import 'dart:convert';

ComposeMailProjectPaymentList composeMailProjectPaymentListFromJson(String str) => ComposeMailProjectPaymentList.fromJson(json.decode(str));

class ComposeMailProjectPaymentList {
  bool? result;
  String? message;
  List<ComposeProjectPayment>? data;

  ComposeMailProjectPaymentList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailProjectPaymentList.fromJson(Map<String, dynamic> json) => ComposeMailProjectPaymentList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeProjectPayment>.from(json["data"]!.map((x) => ComposeProjectPayment.fromJson(x))),
  );
}

class ComposeProjectPayment {
  int? id;
  int? projectId;
  Project? project;

  ComposeProjectPayment({
    this.id,
    this.projectId,
    this.project,
  });

  factory ComposeProjectPayment.fromJson(Map<String, dynamic> json) => ComposeProjectPayment(
    id: json["id"],
    projectId: json["project_id"],
    project: json["project"] == null ? null : Project.fromJson(json["project"]),
  );
}

class Project {
  int? id;
  String? name;

  Project({
    this.id,
    this.name,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    name: json["name"],
  );
}

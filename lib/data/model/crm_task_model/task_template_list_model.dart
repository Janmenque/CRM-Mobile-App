

import 'dart:convert';

TaskTemplateListModel taskTemplateListModelFromJson(String str) => TaskTemplateListModel.fromJson(json.decode(str));

class TaskTemplateListModel {
  bool? result;
  String? message;
  List<TaskTemplate>? data;

  TaskTemplateListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskTemplateListModel.fromJson(Map<String, dynamic> json) => TaskTemplateListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TaskTemplate>.from(json["data"]!.map((x) => TaskTemplate.fromJson(x))),
  );
}

class TaskTemplate {
  int? id;
  String? description;
  String? createdAt;

  TaskTemplate({
    this.id,
    this.description,
    this.createdAt,
  });

  factory TaskTemplate.fromJson(Map<String, dynamic> json) => TaskTemplate(
    id: json["id"],
    description: json["description"],
    createdAt: json["created_at"],
  );

}

import 'dart:convert';

ContractTemplateListModel contractTemplateListModelFromJson(String str) => ContractTemplateListModel.fromJson(json.decode(str));


class ContractTemplateListModel {
  bool? result;
  String? message;
  List<ContractTemplate>? data;

  ContractTemplateListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ContractTemplateListModel.fromJson(Map<String, dynamic> json) => ContractTemplateListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ContractTemplate>.from(json["data"]!.map((x) => ContractTemplate.fromJson(x))),
  );
}

class ContractTemplate {
  String? title;
  String? content;
  String? status;
  String? created;

  ContractTemplate({
    this.title,
    this.content,
    this.status,
    this.created,
  });

  factory ContractTemplate.fromJson(Map<String, dynamic> json) => ContractTemplate(
    title: json["title"],
    content: json["content"],
    status: json["status"],
    created: json["created"],
  );
}

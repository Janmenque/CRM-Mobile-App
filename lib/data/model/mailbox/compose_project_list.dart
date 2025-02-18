
import 'dart:convert';

ComposeMailProjectList composeMailProjectListFromJson(String str) => ComposeMailProjectList.fromJson(json.decode(str));


class ComposeMailProjectList {
  bool? result;
  String? message;
  List<ComposeProject>? data;

  ComposeMailProjectList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailProjectList.fromJson(Map<String, dynamic> json) => ComposeMailProjectList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeProject>.from(json["data"]!.map((x) => ComposeProject.fromJson(x))),
  );
}

class ComposeProject {
  int? id;
  int? clientId;
  String? name;
  Client? client;

  ComposeProject({
    this.id,
    this.clientId,
    this.name,
    this.client,
  });

  factory ComposeProject.fromJson(Map<String, dynamic> json) => ComposeProject(
    id: json["id"],
    clientId: json["client_id"],
    name: json["name"],
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
  );
}

class Client {
  int? id;
  String? name;

  Client({
    this.id,
    this.name,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
  );
}

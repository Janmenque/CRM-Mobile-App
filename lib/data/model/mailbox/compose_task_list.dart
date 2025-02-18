import 'dart:convert';

ComposeMailTaskList composeMailTaskListFromJson(String str) => ComposeMailTaskList.fromJson(json.decode(str));


class ComposeMailTaskList {
  bool? result;
  String? message;
  List<ComposeTask>? data;

  ComposeMailTaskList({
    this.result,
    this.message,
    this.data,
  });

  factory ComposeMailTaskList.fromJson(Map<String, dynamic> json) => ComposeMailTaskList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ComposeTask>.from(json["data"]!.map((x) => ComposeTask.fromJson(x))),
  );

}

class ComposeTask {
  int? id;
  int? clientId;
  String? name;
  Client? client;

  ComposeTask({
    this.id,
    this.clientId,
    this.name,
    this.client,
  });

  factory ComposeTask.fromJson(Map<String, dynamic> json) => ComposeTask(
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

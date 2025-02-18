

import 'dart:convert';

TaskStatusModel taskStatusModelFromJson(String str) =>
    TaskStatusModel.fromJson(json.decode(str));


class TaskStatusModel {
  bool? result;
  String? message;
  Data? data;

  TaskStatusModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskStatusModel.fromJson(Map<String, dynamic> json) =>
      TaskStatusModel(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}

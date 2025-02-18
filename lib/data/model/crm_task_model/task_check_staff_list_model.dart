
import 'dart:convert';

TaskCheckStaffListModel taskCheckStaffListModelFromJson(String str) => TaskCheckStaffListModel.fromJson(json.decode(str));


class TaskCheckStaffListModel {
  bool? result;
  String? message;
  List<TaskCheckStaff>? data;

  TaskCheckStaffListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskCheckStaffListModel.fromJson(Map<String, dynamic> json) => TaskCheckStaffListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TaskCheckStaff>.from(json["data"]!.map((x) => TaskCheckStaff.fromJson(x))),
  );
}

class TaskCheckStaff {
  int? id;
  String? name;

  TaskCheckStaff({
    this.id,
    this.name,
  });

  factory TaskCheckStaff.fromJson(Map<String, dynamic> json) => TaskCheckStaff(
    id: json["id"],
    name: json["name"],
  );

}


import 'dart:convert';

TimesheetTaskListModel timesheetTaskListModelFromJson(String str) => TimesheetTaskListModel.fromJson(json.decode(str));


class TimesheetTaskListModel {
  bool? result;
  String? message;
  List<TimesheetTask>? data;

  TimesheetTaskListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TimesheetTaskListModel.fromJson(Map<String, dynamic> json) => TimesheetTaskListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TimesheetTask>.from(json["data"]!.map((x) => TimesheetTask.fromJson(x))),
  );
}

class TimesheetTask {
  int? id;
  String? name;

  TimesheetTask({
    this.id,
    this.name,
  });

  factory TimesheetTask.fromJson(Map<String, dynamic> json) => TimesheetTask(
    id: json["id"],
    name: json["name"],
  );

}

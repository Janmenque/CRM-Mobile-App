
import 'dart:convert';

TimesheetListModel timesheetListModelFromJson(String str) => TimesheetListModel.fromJson(json.decode(str));


class TimesheetListModel {
  bool? result;
  String? message;
  Data? data;

  TimesheetListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TimesheetListModel.fromJson(Map<String, dynamic> json) => TimesheetListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<TimeSheet>? timeSheets;
  String? totalHours;

  Data({
    this.timeSheets,
    this.totalHours,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    timeSheets: json["time_sheets"] == null ? [] : List<TimeSheet>.from(json["time_sheets"]!.map((x) => TimeSheet.fromJson(x))),
    totalHours: json["total_hours"],
  );
}

class TimeSheet {
  int? id;
  String? date;
  String? employee;
  String? project;
  String? task;
  String? hours;
  String? comment;

  TimeSheet({
    this.id,
    this.date,
    this.employee,
    this.project,
    this.task,
    this.hours,
    this.comment,
  });

  factory TimeSheet.fromJson(Map<String, dynamic> json) => TimeSheet(
    id: json["id"],
    date: json["date"] ,
    employee: json["employee"],
    project: json["project"],
    task: json["task"],
    hours: json["hours"],
    comment: json["comment"],
  );

}

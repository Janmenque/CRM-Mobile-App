import 'dart:convert';

ApproveHourListModel approveHourListModelFromJson(String str) => ApproveHourListModel.fromJson(json.decode(str));


class ApproveHourListModel {
  bool? result;
  String? message;
  List<ApproveHour>? data;

  ApproveHourListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ApproveHourListModel.fromJson(Map<String, dynamic> json) => ApproveHourListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ApproveHour>.from(json["data"]!.map((x) => ApproveHour.fromJson(x))),
  );


}

class ApproveHour {
  String? projectName;
  List<Timesheet>? timesheets;

  ApproveHour({
    this.projectName,
    this.timesheets,
  });

  factory ApproveHour.fromJson(Map<String, dynamic> json) => ApproveHour(
    projectName: json["project_name"],
    timesheets: json["timesheets"] == null ? [] : List<Timesheet>.from(json["timesheets"]!.map((x) => Timesheet.fromJson(x))),
  );
}

class Timesheet {
  String? employeeName;
  List<Task>? tasks;

  Timesheet({
    this.employeeName,
    this.tasks,
  });

  factory Timesheet.fromJson(Map<String, dynamic> json) => Timesheet(
    employeeName: json["employee_name"],
    tasks: json["tasks"] == null ? [] : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
  );
}

class Task {
  int? timesheetId;
  String? isApproveHours;
  DateTime? date;
  String? taskName;
  String? workingHours;
  String? actualHours;
  String? hourlyRate;
  String? approvedAmount;
  String? note;

  Task({
    this.timesheetId,
    this.isApproveHours,
    this.date,
    this.taskName,
    this.workingHours,
    this.actualHours,
    this.hourlyRate,
    this.approvedAmount,
    this.note,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    timesheetId: json["timesheet_id"],
    isApproveHours: json["is_approve_hours"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    taskName: json["task_name"],
    workingHours: json["working_hours"],
    actualHours: json["actual_hours"],
    hourlyRate: json["hourly_rate"],
    approvedAmount: json["approved_amount"],
    note: json["note"],
  );

}


import 'dart:convert';

ScheduleOverviewModel scheduleOverviewModelFromJson(String str) => ScheduleOverviewModel.fromJson(json.decode(str));


class ScheduleOverviewModel {
  bool? result;
  String? message;
  Data? data;

  ScheduleOverviewModel({
    this.result,
    this.message,
    this.data,
  });

  factory ScheduleOverviewModel.fromJson(Map<String, dynamic> json) => ScheduleOverviewModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Timesheet>? timesheets;
  Totals? totals;

  Data({
    this.timesheets,
    this.totals,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    timesheets: json["timesheets"] == null ? [] : List<Timesheet>.from(json["timesheets"]!.map((x) => Timesheet.fromJson(x))),
    totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
  );
}

class Timesheet {
  String? projectName;
  String? employeeName;
  ActivitySummary? activitySummary;
  List<Task>? tasks;
  String? projectTotalWorkingHours;
  String? projectTotalApprovedHours;
  String? projectTotalAmount;

  Timesheet({
    this.projectName,
    this.employeeName,
    this.activitySummary,
    this.tasks,
    this.projectTotalWorkingHours,
    this.projectTotalApprovedHours,
    this.projectTotalAmount,
  });

  factory Timesheet.fromJson(Map<String, dynamic> json) => Timesheet(
    projectName: json["project_name"],
    employeeName: json["employee_name"],
    activitySummary: json["activity_summary"] == null ? null : ActivitySummary.fromJson(json["activity_summary"]),
    tasks: json["tasks"] == null ? [] : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
    projectTotalWorkingHours: json["project_total_working_hours"],
    projectTotalApprovedHours: json["project_total_approved_hours"],
    projectTotalAmount: json["project_total_amount"],
  );
}

class ActivitySummary {
  String? task;
  String? totalWorkingHours;
  String? totalApprovedHours;
  String? hourlyRate;
  String? totalAmount;

  ActivitySummary({
    this.task,
    this.totalWorkingHours,
    this.totalApprovedHours,
    this.hourlyRate,
    this.totalAmount,
  });

  factory ActivitySummary.fromJson(Map<String, dynamic> json) => ActivitySummary(
    task: json["task"],
    totalWorkingHours: json["total_working_hours"],
    totalApprovedHours: json["total_approved_hours"],
    hourlyRate: json["hourly_rate"],
    totalAmount: json["total_amount"],
  );
}

class Task {
  DateTime? date;
  String? taskName;
  String? workingHours;
  String? approvedHours;
  String? hourlyRate;
  String? amount;
  dynamic note;

  Task({
    this.date,
    this.taskName,
    this.workingHours,
    this.approvedHours,
    this.hourlyRate,
    this.amount,
    this.note,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    taskName: json["task_name"],
    workingHours: json["working_hours"],
    approvedHours: json["approved_hours"],
    hourlyRate: json["hourly_rate"],
    amount: json["amount"],
    note: json["note"],
  );
}

class Totals {
  String? totalWorkingHours;
  String? totalApprovedHours;
  String? totalInvoiceAmount;

  Totals({
    this.totalWorkingHours,
    this.totalApprovedHours,
    this.totalInvoiceAmount,
  });

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
    totalWorkingHours: json["total_working_hours"],
    totalApprovedHours: json["total_approved_hours"],
    totalInvoiceAmount: json["total_invoice_amount"],
  );

}

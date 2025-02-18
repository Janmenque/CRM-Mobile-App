
import 'dart:convert';

TimesheetReportListModel timesheetReportListModelFromJson(String str) => TimesheetReportListModel.fromJson(json.decode(str));

class TimesheetReportListModel {
  bool? result;
  String? message;
  List<TimeSheetReport>? data;

  TimesheetReportListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TimesheetReportListModel.fromJson(Map<String, dynamic> json) => TimesheetReportListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TimeSheetReport>.from(json["data"]!.map((x) => TimeSheetReport.fromJson(x))),
  );
}

class TimeSheetReport {
  String? employeeName;
  String? date;
  String? startTime;
  String? endTime;
  String? attendance;
  String? workingHours;
  String? approvedHours;
  String? status;

  TimeSheetReport({
    this.employeeName,
    this.date,
    this.startTime,
    this.endTime,
    this.attendance,
    this.workingHours,
    this.approvedHours,
    this.status,
  });

  factory TimeSheetReport.fromJson(Map<String, dynamic> json) => TimeSheetReport(
    employeeName: json["employee_name"],
    date: json["date"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    attendance: json["attendance"],
    workingHours: json["working_hours"],
    approvedHours: json["approved_hours"],
    status: json["status"],
  );
}

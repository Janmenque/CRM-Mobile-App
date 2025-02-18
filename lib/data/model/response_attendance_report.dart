
import 'dart:convert';

AttendanceReport attendanceReportFromJson(String str) =>
    AttendanceReport.fromJson(json.decode(str));

String attendanceReportToJson(AttendanceReport data) =>
    json.encode(data.toJson());

class AttendanceReport {
  AttendanceReport({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory AttendanceReport.fromJson(Map<String, dynamic> json) =>
      AttendanceReport(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.attendanceSummary,
    this.dailyReport,
  });

  AttendanceSummary? attendanceSummary;
  List<DailyReport>? dailyReport;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attendanceSummary:
            AttendanceSummary.fromJson(json["attendance_summary"]),
        dailyReport: List<DailyReport>.from(
            json["daily_report"].map((x) => DailyReport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attendance_summary": attendanceSummary!.toJson(),
        "daily_report": List<dynamic>.from(dailyReport!.map((x) => x.toJson())),
      };
}

class AttendanceSummary {
  AttendanceSummary({
    this.workingDays,
    this.present,
    this.workTime,
    this.absent,
    this.totalOnTimeIn,
    this.totalLeave,
    this.totalEarlyIn,
    this.totalLateIn,
    this.totalLeftTimely,
    this.totalLeftEarly,
    this.totalLeftLater,
  });

  String? workingDays;
  String? present;
  String? workTime;
  String? absent;
  String? totalOnTimeIn;
  String? totalLeave;
  String? totalEarlyIn;
  String? totalLateIn;
  String? totalLeftTimely;
  String? totalLeftEarly;
  String? totalLeftLater;

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) =>
      AttendanceSummary(
        workingDays: json["working_days"],
        present: json["present"],
        workTime: json["work_time"],
        absent: json["absent"],
        totalOnTimeIn: json["total_on_time_in"],
        totalLeave: json["total_leave"],
        totalEarlyIn: json["total_early_in"],
        totalLateIn: json["total_late_in"],
        totalLeftTimely: json["total_left_timely"],
        totalLeftEarly: json["total_left_early"],
        totalLeftLater: json["total_left_later"],
      );

  Map<String, dynamic> toJson() => {
        "working_days": workingDays,
        "present": present,
        "work_time": workTime,
        "absent": absent,
        "total_on_time_in": totalOnTimeIn,
        "total_leave": totalLeave,
        "total_early_in": totalEarlyIn,
        "total_late_in": totalLateIn,
        "total_left_timely": totalLeftTimely,
        "total_left_early": totalLeftEarly,
        "total_left_later": totalLeftLater,
      };
}

class DailyReport {
  DailyReport({
    this.fullDate,
    this.weekDay,
    this.date,
    this.status,
    this.remoteModeIn,
    this.remoteModeOut,
    this.checkIn,
    this.checkInStatus,
    this.checkOutStatus,
    this.checkInLocation,
    this.checkInReason,
    this.checkOut,
    this.checkOutLocation,
    this.checkOutReason,
  });

  String? fullDate;
  String? weekDay;
  String? date;
  String? status;
  String? remoteModeIn;
  String? remoteModeOut;
  String? checkIn;
  String? checkInStatus;
  String? checkOutStatus;
  String? checkInLocation;
  String? checkInReason;
  String? checkOut;
  String? checkOutLocation;
  String? checkOutReason;

  factory DailyReport.fromJson(Map<String, dynamic> json) => DailyReport(
        fullDate: json["full_date"],
        weekDay: json["week_day"],
        date: json["date"],
        status: json["status"],
        remoteModeIn: json["remote_mode_in"],
        remoteModeOut: json["remote_mode_out"],
        checkIn: json["check_in"],
        checkInStatus: json["check_in_status"],
        checkOutStatus: json["check_out_status"],
        checkInLocation: json["check_in_location"],
        checkInReason: json["check_in_reason"],
        checkOut: json["check_out"],
        checkOutLocation: json["check_out_location"],
        checkOutReason: json["check_out_reason"],
      );

  Map<String, dynamic> toJson() => {
        "full_date": fullDate,
        "week_day": weekDay,
        "date": date,
        "status": status,
        "remote_mode_in": remoteModeIn,
        "remote_mode_out": remoteModeOut,
        "check_in": checkIn,
        "check_in_status": checkInStatus,
        "check_out_status": checkOutStatus,
        "check_in_location": checkInLocation,
        "check_in_reason": checkInReason,
        "check_out": checkOut,
        "check_out_location": checkOutLocation,
        "check_out_reason": checkOutReason,
      };
}

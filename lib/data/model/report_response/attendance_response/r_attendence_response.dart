import 'dart:convert';

ReportAttendanceResponse reportAttendanceRepositoryFromJson(String str) => ReportAttendanceResponse.fromJson(json.decode(str));

String reportAttendanceRepositoryToJson(ReportAttendanceResponse data) => json.encode(data.toJson());

class ReportAttendanceResponse {
  ReportAttendanceResponse({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ReportAttendanceResponse.fromJson(Map<String, dynamic> json) => ReportAttendanceResponse(
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
    this.date,
    this.attendanceSummary,
  });

  String? date;
  AttendanceSummary? attendanceSummary;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    date: json["date"],
    attendanceSummary: AttendanceSummary.fromJson(json["attendance_summary"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "attendance_summary": attendanceSummary!.toJson(),
  };
}

class AttendanceSummary {
  AttendanceSummary({
    this.present,
    this.absent,
    this.onTimeIn,
    this.leave,
    this.earlyIn,
    this.lateIn,
    this.leftTimely,
    this.leftEarly,
    this.leftLater,
  });

  String? present;
  String? absent;
  String? onTimeIn;
  String? leave;
  String? earlyIn;
  String? lateIn;
  String? leftTimely;
  String? leftEarly;
  String? leftLater;

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) => AttendanceSummary(
    present: json["present"],
    absent: json["absent"],
    onTimeIn: json["on_time_in"],
    leave: json["leave"],
    earlyIn: json["early_in"],
    lateIn: json["late_in"],
    leftTimely: json["left_timely"],
    leftEarly: json["left_early"],
    leftLater: json["left_later"],
  );

  Map<String, dynamic> toJson() => {
    "present": present,
    "absent": absent,
    "on_time_in": onTimeIn,
    "leave": leave,
    "early_in": earlyIn,
    "late_in": lateIn,
    "left_timely": leftTimely,
    "left_early": leftEarly,
    "left_later": leftLater,
  };
}

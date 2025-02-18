import 'dart:convert';

AttendanceDailyReport attendanceDailyReportFromJson(String str) => AttendanceDailyReport.fromJson(json.decode(str));

String attendanceDailyReportToJson(AttendanceDailyReport data) => json.encode(data.toJson());

class AttendanceDailyReport {
  AttendanceDailyReport({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory AttendanceDailyReport.fromJson(Map<String, dynamic> json) => AttendanceDailyReport(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.date,
    this.dateWiseReport,
  });

  String? date;
  List<DateWiseReport>? dateWiseReport;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    date: json["date"],
    dateWiseReport: List<DateWiseReport>.from(json["date_wise_report"].map((x) => DateWiseReport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "date_wise_report": List<dynamic>.from(dateWiseReport!.map((x) => x.toJson())),
  };
}

class DateWiseReport {
  DateWiseReport({
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

  factory DateWiseReport.fromJson(Map<String, dynamic> json) => DateWiseReport(
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

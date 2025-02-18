
import 'dart:convert';

MonthlyOverviewModel monthlyOverviewModelFromJson(String str) => MonthlyOverviewModel.fromJson(json.decode(str));


class MonthlyOverviewModel {
  bool? result;
  String? message;
  Data? data;

  MonthlyOverviewModel({
    this.result,
    this.message,
    this.data,
  });

  factory MonthlyOverviewModel.fromJson(Map<String, dynamic> json) => MonthlyOverviewModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<String>? monthDates;
  List<DateTime>? monthDatesLf;
  List<TimesheetDatum>? timesheetData;
  List<String>? sum;
  List<String>? billable;
  List<String>? nonBillable;
  String? totalSum;
  String? totalBillable;
  String? totalNonBillable;

  Data({
    this.monthDates,
    this.monthDatesLf,
    this.timesheetData,
    this.sum,
    this.billable,
    this.nonBillable,
    this.totalSum,
    this.totalBillable,
    this.totalNonBillable,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    monthDates: json["monthDates"] == null ? [] : List<String>.from(json["monthDates"]!.map((x) => x)),
    monthDatesLf: json["monthDatesLF"] == null ? [] : List<DateTime>.from(json["monthDatesLF"]!.map((x) => DateTime.parse(x))),
    timesheetData: json["timesheetData"] == null ? [] : List<TimesheetDatum>.from(json["timesheetData"]!.map((x) => TimesheetDatum.fromJson(x))),
    sum: json["sum"] == null ? [] : List<String>.from(json["sum"]!.map((x) => x)),
    billable: json["billable"] == null ? [] : List<String>.from(json["billable"]!.map((x) => x)),
    nonBillable: json["nonBillable"] == null ? [] : List<String>.from(json["nonBillable"]!.map((x) => x)),
    totalSum: json["totalSum"],
    totalBillable: json["totalBillable"],
    totalNonBillable: json["totalNonBillable"],
  );
}

class TimesheetDatum {
  String? employee;
  String? projectName;
  String? taskName;
  DailyHours? dailyHours;
  String? totalRowHours;
  String? totalRowApproved;
  String? totalRowNonBillable;

  TimesheetDatum({
    this.employee,
    this.projectName,
    this.taskName,
    this.dailyHours,
    this.totalRowHours,
    this.totalRowApproved,
    this.totalRowNonBillable,
  });

  factory TimesheetDatum.fromJson(Map<String, dynamic> json) => TimesheetDatum(
    employee: json["employee"],
    projectName: json["project_name"],
    taskName: json["task_name"],
    dailyHours: json["daily_hours"] == null ? null : DailyHours.fromJson(json["daily_hours"]),
    totalRowHours: json["total_row_hours"],
    totalRowApproved: json["total_row_approved"],
    totalRowNonBillable: json["total_row_non_billable"],
  );
}

class DailyHours {
  String? the20250101;
  String? the20250102;
  String? the20250103;
  String? the20250104;
  String? the20250105;
  String? the20250106;
  String? the20250107;
  String? the20250108;
  String? the20250109;
  String? the20250110;
  String? the20250111;
  String? the20250112;
  String? the20250113;
  String? the20250114;
  String? the20250115;
  String? the20250116;
  String? the20250117;
  String? the20250118;
  String? the20250119;
  String? the20250120;
  String? the20250121;
  String? the20250122;
  String? the20250123;
  String? the20250124;
  String? the20250125;
  String? the20250126;
  String? the20250127;
  String? the20250128;
  String? the20250129;
  String? the20250130;
  String? the20250131;

  DailyHours({
    this.the20250101,
    this.the20250102,
    this.the20250103,
    this.the20250104,
    this.the20250105,
    this.the20250106,
    this.the20250107,
    this.the20250108,
    this.the20250109,
    this.the20250110,
    this.the20250111,
    this.the20250112,
    this.the20250113,
    this.the20250114,
    this.the20250115,
    this.the20250116,
    this.the20250117,
    this.the20250118,
    this.the20250119,
    this.the20250120,
    this.the20250121,
    this.the20250122,
    this.the20250123,
    this.the20250124,
    this.the20250125,
    this.the20250126,
    this.the20250127,
    this.the20250128,
    this.the20250129,
    this.the20250130,
    this.the20250131,
  });

  factory DailyHours.fromJson(Map<String, dynamic> json) => DailyHours(
    the20250101: json["2025-01-01"],
    the20250102: json["2025-01-02"],
    the20250103: json["2025-01-03"],
    the20250104: json["2025-01-04"],
    the20250105: json["2025-01-05"],
    the20250106: json["2025-01-06"],
    the20250107: json["2025-01-07"],
    the20250108: json["2025-01-08"],
    the20250109: json["2025-01-09"],
    the20250110: json["2025-01-10"],
    the20250111: json["2025-01-11"],
    the20250112: json["2025-01-12"],
    the20250113: json["2025-01-13"],
    the20250114: json["2025-01-14"],
    the20250115: json["2025-01-15"],
    the20250116: json["2025-01-16"],
    the20250117: json["2025-01-17"],
    the20250118: json["2025-01-18"],
    the20250119: json["2025-01-19"],
    the20250120: json["2025-01-20"],
    the20250121: json["2025-01-21"],
    the20250122: json["2025-01-22"],
    the20250123: json["2025-01-23"],
    the20250124: json["2025-01-24"],
    the20250125: json["2025-01-25"],
    the20250126: json["2025-01-26"],
    the20250127: json["2025-01-27"],
    the20250128: json["2025-01-28"],
    the20250129: json["2025-01-29"],
    the20250130: json["2025-01-30"],
    the20250131: json["2025-01-31"],
  );

  Map<String, dynamic> toJson() => {
    "2025-01-01": the20250101,
    "2025-01-02": the20250102,
    "2025-01-03": the20250103,
    "2025-01-04": the20250104,
    "2025-01-05": the20250105,
    "2025-01-06": the20250106,
    "2025-01-07": the20250107,
    "2025-01-08": the20250108,
    "2025-01-09": the20250109,
    "2025-01-10": the20250110,
    "2025-01-11": the20250111,
    "2025-01-12": the20250112,
    "2025-01-13": the20250113,
    "2025-01-14": the20250114,
    "2025-01-15": the20250115,
    "2025-01-16": the20250116,
    "2025-01-17": the20250117,
    "2025-01-18": the20250118,
    "2025-01-19": the20250119,
    "2025-01-20": the20250120,
    "2025-01-21": the20250121,
    "2025-01-22": the20250122,
    "2025-01-23": the20250123,
    "2025-01-24": the20250124,
    "2025-01-25": the20250125,
    "2025-01-26": the20250126,
    "2025-01-27": the20250127,
    "2025-01-28": the20250128,
    "2025-01-29": the20250129,
    "2025-01-30": the20250130,
    "2025-01-31": the20250131,
  };
}

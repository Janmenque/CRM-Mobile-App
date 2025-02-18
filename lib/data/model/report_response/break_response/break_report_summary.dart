import 'dart:convert';

BreakReportSummeryResponse breakReportSummeryResponseFromJson(String str) =>
    BreakReportSummeryResponse.fromJson(json.decode(str));

String breakReportSummeryResponseToJson(BreakReportSummeryResponse data) =>
    json.encode(data.toJson());

class BreakReportSummeryResponse {
  BreakReportSummeryResponse({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory BreakReportSummeryResponse.fromJson(Map<String, dynamic> json) =>
      BreakReportSummeryResponse(
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
    this.employeeList,
  });

  String? date;
  List<EmployeeList>? employeeList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        date: json["date"],
        employeeList: List<EmployeeList>.from(
            json["employee_list"].map((x) => EmployeeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "employee_list":
            List<dynamic>.from(employeeList!.map((x) => x.toJson())),
      };
}

class EmployeeList {
  EmployeeList({
    this.userId,
    this.name,
    this.designation,
    this.avatarId,
    this.totalBreakTime,
  });

  int? userId;
  String? name;
  String? designation;
  String? avatarId;
  String? totalBreakTime;

  factory EmployeeList.fromJson(Map<String, dynamic> json) => EmployeeList(
        userId: json["user_id"],
        name: json["name"],
        designation: json["designation"],
        avatarId: json["avatar_id"],
        totalBreakTime: json["total_break_time"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "designation": designation,
        "avatar_id": avatarId,
        "total_break_time": totalBreakTime,
      };
}

import 'dart:convert';

ReportLeaveSummeryResponse reportLeaveSummeryResponseFromJson(String str) => ReportLeaveSummeryResponse.fromJson(json.decode(str));

String reportLeaveSummeryResponseToJson(ReportLeaveSummeryResponse data) => json.encode(data.toJson());

class ReportLeaveSummeryResponse {
  ReportLeaveSummeryResponse({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ReportLeaveSummeryResponse.fromJson(Map<String, dynamic> json) => ReportLeaveSummeryResponse(
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
    this.leaveTypes,
  });

  String? date;
  List<LeaveType>? leaveTypes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    date: json["date"],
    leaveTypes: List<LeaveType>.from(json["leave_types"].map((x) => LeaveType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "leave_types": List<dynamic>.from(leaveTypes!.map((x) => x.toJson())),
  };
}

class LeaveType {
  LeaveType({
    this.id,
    this.name,
    this.count,
  });

  dynamic id;
  String? name;
  int? count;

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
    id: json["id"],
    name: json["name"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "count": count,
  };
}

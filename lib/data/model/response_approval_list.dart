
import 'dart:convert';

ResponseApprovalList responseApprovalListFromJson(String str) => ResponseApprovalList.fromJson(json.decode(str));

String responseApprovalListToJson(ResponseApprovalList data) => json.encode(data.toJson());

class ResponseApprovalList {
  ResponseApprovalList({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseApprovalList.fromJson(Map<String, dynamic> json) => ResponseApprovalList(
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
    this.leaveRequests,
  });

  List<LeaveRequest>? leaveRequests;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaveRequests: List<LeaveRequest>.from(json["leaveRequests"].map((x) => LeaveRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "leaveRequests": List<dynamic>.from(leaveRequests!.map((x) => x.toJson())),
  };
}

class LeaveRequest {
  LeaveRequest({
    this.id,
    this.userId,
    this.name,
    this.message,
    this.type,
    this.days,
    this.applyDate,
    this.dateDuration,
    this.status,
    this.colorCode,
  });

  int? id;
  int? userId;
  String? name;
  String? message;
  String? type;
  int? days;
  String? applyDate;
  String? dateDuration;
  String? status;
  String? colorCode;

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    message: json["message"],
    type: json["type"],
    days: json["days"],
    applyDate: json["apply_date"],
    dateDuration: json["date_duration"],
    status: json["status"],
    colorCode: json["color_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "message": message,
    "type": type,
    "days": days,
    "apply_date": applyDate,
    "date_duration": dateDuration,
    "status": status,
    "color_code": colorCode,
  };
}

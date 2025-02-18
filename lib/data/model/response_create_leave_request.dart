
import 'dart:convert';

ResponseCreateLeaveRequest responseCreateLeaveRequestFromJson(String str) =>
    ResponseCreateLeaveRequest.fromJson(json.decode(str));

String responseCreateLeaveRequestToJson(ResponseCreateLeaveRequest data) =>
    json.encode(data.toJson());

class ResponseCreateLeaveRequest {
  ResponseCreateLeaveRequest({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseCreateLeaveRequest.fromJson(Map<String, dynamic> json) =>
      ResponseCreateLeaveRequest(
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
    this.userId,
    this.assignLeaveId,
    this.substituteId,
    this.days,
    this.reason,
    this.statusId,
    this.id,
  });

  int? userId;
  int? assignLeaveId;
  String? substituteId;
  int? days;
  String? reason;
  int? statusId;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        assignLeaveId: json["assign_leave_id"],
        substituteId: json["substitute_id"],
        days: json["days"],
        reason: json["reason"],
        statusId: json["status_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "assign_leave_id": assignLeaveId,
        "team_leader_id": substituteId,
        "days": days,
        "reason": reason,
        "status_id": statusId,
        "id": id,
      };
}

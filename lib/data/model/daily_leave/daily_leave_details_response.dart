import 'dart:convert';

DailyLeaveDetailsResponse dailyLeaveDetailsResponseFromJson(String str) => DailyLeaveDetailsResponse.fromJson(json.decode(str));

String dailyLeaveDetailsResponseToJson(DailyLeaveDetailsResponse data) => json.encode(data.toJson());

class DailyLeaveDetailsResponse {
  DailyLeaveDetailsResponse({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory DailyLeaveDetailsResponse.fromJson(Map<String, dynamic> json) => DailyLeaveDetailsResponse(
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
    this.data,
  });

  List<Datum>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.date,
    this.staff,
    this.avater,
    this.designation,
    this.leaveType,
    this.time,
    this.reason,
    this.approvalDetails,
    this.tlApprovalMsg,
    this.status,
  });

  int? id;
  String? date;
  String? staff;
  String? avater;
  String? designation;
  String? leaveType;
  String? time;
  String? reason;
  ApprovalDetails? approvalDetails;
  String? tlApprovalMsg;
  String? status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    date: json["date"],
    staff: json["staff"],
    avater: json["avater"],
    designation: json["designation"],
    leaveType: json["leave_type"],
    time: json["time"],
    reason: json["reason"],
    approvalDetails: ApprovalDetails.fromJson(json["approval_details"]),
    tlApprovalMsg: json["tl_approval_msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "staff": staff,
    "avater": avater,
    "designation": designation,
    "leave_type": leaveType,
    "time": time,
    "reason": reason,
    "approval_details": approvalDetails!.toJson(),
    "tl_approval_msg": tlApprovalMsg,
    "status": status,
  };
}

class ApprovalDetails {
  ApprovalDetails({
    this.managerApproval,
    this.hrApproval,
  });

  String? managerApproval;
  String? hrApproval;

  factory ApprovalDetails.fromJson(Map<String, dynamic> json) => ApprovalDetails(
    managerApproval: json["manager_approval"],
    hrApproval: json["hr_approval"],
  );

  Map<String, dynamic> toJson() => {
    "manager_approval": managerApproval,
    "hr_approval": hrApproval,
  };
}

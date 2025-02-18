import 'dart:convert';

DailyLeaveSingleViewResponse dailyLeaveSingleViewResponseFromJson(String str) => DailyLeaveSingleViewResponse.fromJson(json.decode(str));

String dailyLeaveSingleViewResponseToJson(DailyLeaveSingleViewResponse data) => json.encode(data.toJson());

class DailyLeaveSingleViewResponse {
  DailyLeaveSingleViewResponse({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory DailyLeaveSingleViewResponse.fromJson(Map<String, dynamic> json) => DailyLeaveSingleViewResponse(
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
    this.id,
    this.date,
    this.staff,
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
  String? leaveType;
  String? time;
  String? reason;
  ApprovalDetails? approvalDetails;
  String? tlApprovalMsg;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    date: json["date"],
    staff: json["staff"],
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

  dynamic managerApproval;
  dynamic hrApproval;

  factory ApprovalDetails.fromJson(Map<String, dynamic> json) => ApprovalDetails(
    managerApproval: json["manager_approval"],
    hrApproval: json["hr_approval"],
  );

  Map<String, dynamic> toJson() => {
    "manager_approval": managerApproval,
    "hr_approval": hrApproval,
  };
}

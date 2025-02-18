
import 'dart:convert';

ResponseApprovalDetails responseApprovalDetailsFromJson(String str) =>
    ResponseApprovalDetails.fromJson(json.decode(str));

String responseApprovalDetailsToJson(ResponseApprovalDetails data) =>
    json.encode(data.toJson());

class ResponseApprovalDetails {
  ResponseApprovalDetails({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseApprovalDetails.fromJson(Map<String, dynamic> json) =>
      ResponseApprovalDetails(
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
    this.userId,
    this.requestedOn,
    this.name,
    this.designation,
    this.department,
    this.type,
    this.period,
    this.totalDays,
    this.note,
    this.availableLeave,
    this.totalUsed,
    this.approvedBy,
    this.referredBy,
    this.status,
    this.colorCode,
    this.substitute,
    this.apporover,
    this.attachment,
  });

  int? id;
  int? userId;
  String? requestedOn;
  String? name;
  String? designation;
  String? department;
  String? type;
  String? period;
  int? totalDays;
  String? note;
  int? availableLeave;
  int? totalUsed;
  String? approvedBy;
  String? referredBy;
  String? status;
  String? colorCode;
  Substitute? substitute;
  String? apporover;
  String? attachment;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        requestedOn: json["requested_on"],
        name: json["name"],
        designation: json["designation"],
        department: json["department"],
        type: json["type"],
        period: json["period"],
        totalDays: json["total_days"],
        note: json["note"],
        availableLeave: json["available_leave"],
        totalUsed: json["total_used"],
        approvedBy: json["approved_by"],
        referredBy: json["referred_by"],
        status: json["status"],
        colorCode: json["color_code"],
        substitute: json["substitute"] != null
            ? Substitute.fromJson(json["substitute"])
            : null,
        apporover: json["apporover"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "requested_on": requestedOn,
        "type": type,
        "period": period,
        "total_days": totalDays,
        "note": note,
        "available_leave": availableLeave,
        "total_used": totalUsed,
        "approved_by": approvedBy,
        "referred_by": referredBy,
        "status": status,
        "color_code": colorCode,
        "substitute": substitute!.toJson(),
        "apporover": apporover,
        "attachment": attachment,
      };
}

class Substitute {
  Substitute({
    this.id,
    this.name,
    this.employeeId,
    this.designation,
    this.avatar,
  });

  int? id;
  String? name;
  String? employeeId;
  String? designation;
  String? avatar;

  factory Substitute.fromJson(Map<String, dynamic> json) => Substitute(
        id: json["id"],
        name: json["name"],
        employeeId: json["employee_id"],
        designation: json["designation"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "employee_id": employeeId,
        "designation": designation,
        "avatar": avatar,
      };
}


import 'dart:convert';

ResponseLeaveSummary responseLeaveSummaryFromJson(String str) => ResponseLeaveSummary.fromJson(json.decode(str));

String responseLeaveSummaryToJson(ResponseLeaveSummary data) => json.encode(data.toJson());

class ResponseLeaveSummary {
  ResponseLeaveSummary({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseLeaveSummary.fromJson(Map<String, dynamic> json) => ResponseLeaveSummary(
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
    this.totalLeave,
    this.totalUsed,
    this.leaveBalance,
    this.availableLeave,
  });

  int? totalLeave;
  int? totalUsed;
  int? leaveBalance;
  List<AvailableLeave>? availableLeave;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalLeave: json["total_leave"],
    totalUsed: json["total_used"],
    leaveBalance: json["leave_balance"],
    availableLeave: List<AvailableLeave>.from(json["available_leave"].map((x) => AvailableLeave.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_leave": totalLeave,
    "total_used": totalUsed,
    "leave_balance": leaveBalance,
    "available_leave": List<dynamic>.from(availableLeave!.map((x) => x.toJson())),
  };
}

class AvailableLeave {
  AvailableLeave({
    this.id,
    this.type,
    this.totalLeave,
    this.leftDays,
  });

  int? id;
  String? type;
  int? totalLeave;
  int? leftDays;

  factory AvailableLeave.fromJson(Map<String, dynamic> json) => AvailableLeave(
    id: json["id"],
    type: json["type"],
    totalLeave: int.parse(json["total_leave"].toString()) ,
    leftDays: json["left_days"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "total_leave": totalLeave,
    "left_days": leftDays,
  };
}

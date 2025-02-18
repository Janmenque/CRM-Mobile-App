
import 'dart:convert';

ResponseLeaveType responseLeaveTypeFromJson(String str) => ResponseLeaveType.fromJson(json.decode(str));

String responseLeaveTypeToJson(ResponseLeaveType data) => json.encode(data.toJson());

class ResponseLeaveType {
  ResponseLeaveType({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseLeaveType.fromJson(Map<String, dynamic> json) => ResponseLeaveType(
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
    this.availableLeave,
  });

  List<AvailableLeave>? availableLeave;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    availableLeave: List<AvailableLeave>.from(json["available_leave"].map((x) => AvailableLeave.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
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
    totalLeave: int.parse(json["total_leave"].toString()),
    leftDays: json["left_days"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "total_leave": totalLeave,
    "left_days": leftDays,
  };
}

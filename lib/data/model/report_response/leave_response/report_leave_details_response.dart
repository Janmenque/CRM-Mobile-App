import 'dart:convert';

LeaveReportDetailsResponse leaveReportDetailsResponseFromJson(String str) => LeaveReportDetailsResponse.fromJson(json.decode(str));

String leaveReportDetailsResponseToJson(LeaveReportDetailsResponse data) => json.encode(data.toJson());

class LeaveReportDetailsResponse {
  LeaveReportDetailsResponse({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory LeaveReportDetailsResponse.fromJson(Map<String, dynamic> json) => LeaveReportDetailsResponse(
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
    this.leaves,
  });

  List<Leaf>? leaves;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leaves: List<Leaf>.from(json["leaves"].map((x) => Leaf.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "leaves": List<dynamic>.from(leaves!.map((x) => x.toJson())),
  };
}

class Leaf {
  Leaf({
    this.id,
    this.userId,
    this.userName,
    this.avatar,
    this.userDesignation,
    this.days,
    this.reason,
  });

  int? id;
  int? userId;
  String? userName;
  String? avatar;
  String? userDesignation;
  int? days;
  String? reason;

  factory Leaf.fromJson(Map<String, dynamic> json) => Leaf(
    id: json["id"],
    userId: json["user_id"],
    userName: json["user_name"],
    avatar: json["avatar"],
    userDesignation: json["user_designation"],
    days: json["days"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "user_name": userName,
    "avatar": avatar,
    "user_designation": userDesignation,
    "days": days,
    "reason": reason,
  };
}

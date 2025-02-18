import 'dart:convert';

ReportAttendanceListResponse reportAttendanceListResponseFromJson(String str) => ReportAttendanceListResponse.fromJson(json.decode(str));

String reportAttendanceListResponseToJson(ReportAttendanceListResponse data) => json.encode(data.toJson());

class ReportAttendanceListResponse {
  ReportAttendanceListResponse({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ReportAttendanceListResponse.fromJson(Map<String, dynamic> json) => ReportAttendanceListResponse(
    result: json["result"],
    message: json["message"],
    data: json['data'] != null ?  Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.title,
    this.users,
  });

  String? title;
  List<User>? users;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.userId,
    this.name,
    this.designation,
    this.checkIn,
    this.checkOut,
    this.avatar,
  });

  int? userId;
  String? name;
  String? designation;
  String? checkIn;
  String? checkOut;
  String? avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    name: json["name"],
    designation: json["designation"],
    checkIn: json["check_in"],
    checkOut: json["check_out"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "designation": designation,
    "check_in": checkIn,
    "check_out": checkOut,
    "avatar": avatar,
  };
}

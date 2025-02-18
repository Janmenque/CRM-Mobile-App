import 'dart:convert';

ResponseBreak responseBreakFromJson(String str) =>
    ResponseBreak.fromJson(json.decode(str));

String responseBreakToJson(ResponseBreak data) => json.encode(data.toJson());

class ResponseBreak {
  ResponseBreak({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseBreak.fromJson(Map<String, dynamic> json) => ResponseBreak(
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
    this.companyId,
    this.userId,
    this.date,
    this.breakTime,
    this.backTime,
    this.reason,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.status,
  });

  int? companyId;
  int? userId;
  DateTime? date;
  String? breakTime;
  String? backTime;
  String? reason;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        companyId: int.parse(json["company_id"].toString()),
        userId: int.parse(json["user_id"].toString()),
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        breakTime: json["break_time"],
        backTime: json["back_time"],
        reason: json["reason"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "user_id": userId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "break_time": breakTime,
        "back_time": backTime,
        "reason": reason,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "status": status,
      };
}

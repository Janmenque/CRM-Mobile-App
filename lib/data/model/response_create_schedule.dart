
import 'dart:convert';

ResponseCreateSchedule responseCreateScheduleFromJson(String str) =>
    ResponseCreateSchedule.fromJson(json.decode(str));

String responseCreateScheduleToJson(ResponseCreateSchedule data) =>
    json.encode(data.toJson());

class ResponseCreateSchedule {
  ResponseCreateSchedule({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseCreateSchedule.fromJson(Map<String, dynamic> json) =>
      ResponseCreateSchedule(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}

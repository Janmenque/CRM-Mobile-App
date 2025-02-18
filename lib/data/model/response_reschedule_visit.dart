
import 'dart:convert';

ResponseReschedule responseRescheduleFromJson(String str) => ResponseReschedule.fromJson(json.decode(str));

String responseRescheduleToJson(ResponseReschedule data) => json.encode(data.toJson());

class ResponseReschedule {
  ResponseReschedule({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseReschedule.fromJson(Map<String, dynamic> json) => ResponseReschedule(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}

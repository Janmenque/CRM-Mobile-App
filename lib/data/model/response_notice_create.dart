
import 'dart:convert';

ResponseNoticeCreate responseNoticeCreateFromJson(String str) => ResponseNoticeCreate.fromJson(json.decode(str));

String responseNoticeCreateToJson(ResponseNoticeCreate data) => json.encode(data.toJson());

class ResponseNoticeCreate {
  ResponseNoticeCreate({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  int? data;

  factory ResponseNoticeCreate.fromJson(Map<String, dynamic> json) => ResponseNoticeCreate(
    result: json["result"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data,
  };
}

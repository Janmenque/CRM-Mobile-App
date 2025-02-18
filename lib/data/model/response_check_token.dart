
import 'dart:convert';

ResponseToken responseTokenFromJson(String str) => ResponseToken.fromJson(json.decode(str));

String responseTokenToJson(ResponseToken data) => json.encode(data.toJson());

class ResponseToken {
  ResponseToken({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  String? data;

  factory ResponseToken.fromJson(Map<String, dynamic> json) => ResponseToken(
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

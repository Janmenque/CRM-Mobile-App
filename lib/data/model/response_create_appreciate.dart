
import 'dart:convert';

ResponseCreateAppreciate responseCreateAppreciateFromJson(String str) => ResponseCreateAppreciate.fromJson(json.decode(str));

String responseCreateAppreciateToJson(ResponseCreateAppreciate data) => json.encode(data.toJson());

class ResponseCreateAppreciate {
  ResponseCreateAppreciate({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseCreateAppreciate.fromJson(Map<String, dynamic> json) => ResponseCreateAppreciate(
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


import 'dart:convert';

ResponseCreateVisit responseCreateVisitFromJson(String str) =>
    ResponseCreateVisit.fromJson(json.decode(str));

String responseCreateVisitToJson(ResponseCreateVisit data) =>
    json.encode(data.toJson());

class ResponseCreateVisit {
  ResponseCreateVisit(
      {this.result, this.message, this.data, this.laravelValidationError});

  bool? result;
  String? message;
  Data? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseCreateVisit.fromJson(Map<String, dynamic> json) =>
      ResponseCreateVisit(
          result: json["result"],
          message: json["message"],
          data: json["data"] != null ? Data.fromJson(json["data"]) : null,
          laravelValidationError: json["error"] != null
              ? LaravelValidationError.formjson(json["error"])
              : null);

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

class LaravelValidationError {
  final String? title;

  LaravelValidationError({this.title});

  factory LaravelValidationError.formjson(Map<String, dynamic> json) {
    return LaravelValidationError(
        title: json["title"] != null ? json["title"][0] : null);
  }
}

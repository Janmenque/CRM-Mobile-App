
import 'dart:convert';

ResponseImageVisit responseImageVisitFromJson(String str) => ResponseImageVisit.fromJson(json.decode(str));

String responseImageVisitToJson(ResponseImageVisit data) => json.encode(data.toJson());

class ResponseImageVisit {
  ResponseImageVisit({
    this.result,
    this.message,
    this.data,
    this.laravelValidationError
  });

  bool? result;
  String? message;
  String? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseImageVisit.fromJson(Map<String, dynamic> json) => ResponseImageVisit(
    result: json["result"],
    message: json["message"],
    data: json["data"],
      laravelValidationError: json["error"] != null
          ? LaravelValidationError.formjson(json["error"])
          : null
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data,
  };
}

class LaravelValidationError {
  final String? title;

  LaravelValidationError({this.title});

  factory LaravelValidationError.formjson(Map<String, dynamic> json) {
    return LaravelValidationError(
        title: json["title"] != null ? json["title"][0] : null);
  }
}

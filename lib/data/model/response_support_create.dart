
import 'dart:convert';

ResponseSupportCreate responseSupportCreateFromJson(String str) =>
    ResponseSupportCreate.fromJson(json.decode(str));

String responseSupportCreateToJson(ResponseSupportCreate data) =>
    json.encode(data.toJson());

class ResponseSupportCreate {
  ResponseSupportCreate(
      {this.result, this.message, this.data, this.laravelValidationError});

  bool? result;
  String? message;
  Data? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseSupportCreate.fromJson(Map<String, dynamic> json) =>
      ResponseSupportCreate(
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
  final String? subject;
  final String? description;

  LaravelValidationError({this.subject, this.description});

  factory LaravelValidationError.formjson(Map<String, dynamic> json) {
    return LaravelValidationError(
        subject: json["subject"] != null ? json["subject"][0] : null,
        description: json["description"] != null ? json["description"][0] : null);
  }
}

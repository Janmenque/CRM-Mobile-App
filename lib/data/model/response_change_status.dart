
import 'dart:convert';

ResponseChangeStatus responseChangeStatusFromJson(String str) =>
    ResponseChangeStatus.fromJson(json.decode(str));

String responseChangeStatusToJson(ResponseChangeStatus data) =>
    json.encode(data.toJson());

class ResponseChangeStatus {
  ResponseChangeStatus({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseChangeStatus.fromJson(Map<String, dynamic> json) =>
      ResponseChangeStatus(
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

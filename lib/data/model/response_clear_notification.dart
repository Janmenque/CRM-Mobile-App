
import 'dart:convert';

ResponseClearNotification responseClearNotificationFromJson(String str) =>
    ResponseClearNotification.fromJson(json.decode(str));

String responseClearNotificationToJson(ResponseClearNotification data) =>
    json.encode(data.toJson());

class ResponseClearNotification {
  ResponseClearNotification({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseClearNotification.fromJson(Map<String, dynamic> json) =>
      ResponseClearNotification(
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

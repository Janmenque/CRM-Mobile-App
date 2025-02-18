
import 'dart:convert';

ReadNotification readNotificationFromJson(String str) =>
    ReadNotification.fromJson(json.decode(str));

String readNotificationToJson(ReadNotification data) =>
    json.encode(data.toJson());

class ReadNotification {
  ReadNotification({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ReadNotification.fromJson(Map<String, dynamic> json) =>
      ReadNotification(
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


import 'dart:convert';

ResponseProfileImage responseProfileImageFromJson(String str) =>
    ResponseProfileImage.fromJson(json.decode(str));

String responseProfileImageToJson(ResponseProfileImage data) =>
    json.encode(data.toJson());

class ResponseProfileImage {
  ResponseProfileImage({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseProfileImage.fromJson(Map<String, dynamic> json) =>
      ResponseProfileImage(
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
  Data({
    this.avatar,
  });

  String? avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
      };
}

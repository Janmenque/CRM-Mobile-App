
import 'dart:convert';

import 'home/crm_home_model.dart';

ResponseAllUser responseAllUserFromJson(String str) => ResponseAllUser.fromJson(json.decode(str));

String responseAllUserToJson(ResponseAllUser data) => json.encode(data.toJson());

class ResponseAllUser {
  ResponseAllUser({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseAllUser.fromJson(Map<String, dynamic> json) => ResponseAllUser(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data!.toJson(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseAllUser &&
          runtimeType == other.runtimeType &&
          result == other.result &&
          message == other.message &&
          data == other.data;

  @override
  int get hashCode => result.hashCode ^ message.hashCode ^ data.hashCode;
}

class Data {
  Data({
    this.members,
  });

  List<Members>? members;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    members: List<Members>.from(json["members"].map((x) => Members.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "members": List<dynamic>.from(members!.map((x) => x.toJson())),
  };
}


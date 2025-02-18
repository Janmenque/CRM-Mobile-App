
import 'dart:convert';

ResponseManagerList responseManagerListFromJson(String str) =>
    ResponseManagerList.fromJson(json.decode(str));

String responseManagerListToJson(ResponseManagerList data) =>
    json.encode(data.toJson());

class ResponseManagerList {
  ResponseManagerList({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseManagerList.fromJson(Map<String, dynamic> json) =>
      ResponseManagerList(
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
    this.managers,
  });

  List<Manager>? managers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        managers: List<Manager>.from(
            json["managers"].map((x) => Manager.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "managers": List<dynamic>.from(managers!.map((x) => x.toJson())),
      };
}

class Manager {
  Manager({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

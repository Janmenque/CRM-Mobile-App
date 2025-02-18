
import 'dart:convert';

ResponseAppreciateList responseAppreciateListFromJson(String str) =>
    ResponseAppreciateList.fromJson(json.decode(str));

String responseAppreciateListToJson(ResponseAppreciateList data) =>
    json.encode(data.toJson());

class ResponseAppreciateList {
  ResponseAppreciateList({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseAppreciateList.fromJson(Map<String, dynamic> json) =>
      ResponseAppreciateList(
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
    this.appreciates,
  });

  List<Appreciate>? appreciates;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        appreciates: List<Appreciate>.from(
            json["appreciates"].map((x) => Appreciate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "appreciates": List<dynamic>.from(appreciates!.map((x) => x.toJson())),
      };
}

class Appreciate {
  Appreciate({
    this.appreciateBy,
    this.message,
    this.date,
    this.day,
  });

  String? appreciateBy;
  String? message;
  String? date;
  String? day;

  factory Appreciate.fromJson(Map<String, dynamic> json) => Appreciate(
        appreciateBy: json["appreciate_by"],
        message: json["message"],
        date: json["date"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "appreciate_by": appreciateBy,
        "message": message,
        "date": date,
        "day": day,
      };
}


import 'dart:convert';

UpcomingModel upcomingModelFromJson(String str) =>
    UpcomingModel.fromJson(json.decode(str));

class UpcomingModel {
  UpcomingModel({
    this.data,
    this.env,
    this.result,
    this.message,
    this.status,
  });

  Data? data;
  String? env;
  bool? result;
  String? message;
  int? status;

  factory UpcomingModel.fromJson(Map<String, dynamic> json) => UpcomingModel(
        data: Data.fromJson(json["data"]),
        env: json["env"],
        result: json["result"],
        message: json["message"],
        status: json["status"],
      );
}

class Data {
  Data({
    this.items,
  });

  List<Item>? items;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item({
    this.id,
    this.title,
    this.date,
    this.day,
    this.time,
    this.location,
    this.participant,
  });

  int? id;
  String? title;
  String? date;
  String? day;
  String? time;
  String? location;
  List<dynamic>? participant;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        day: json["day"],
        time: json["time"],
        location: json["location"],
        participant: List<dynamic>.from(json["participant"].map((x) => x)),
      );
}

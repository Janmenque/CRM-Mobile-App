
import 'dart:convert';

StaticsModel staticsModelFromJson(String str) =>
    StaticsModel.fromJson(json.decode(str));

String staticsModelToJson(StaticsModel data) => json.encode(data.toJson());

class StaticsModel {
  StaticsModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory StaticsModel.fromJson(Map<String, dynamic> json) => StaticsModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.today,
    this.currentMonth,
  });

  List<Today>? today;
  List<CurrentMonth>? currentMonth;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        today: List<Today>.from(json["today"].map((x) => Today.fromJson(x))),
        currentMonth: List<CurrentMonth>.from(
            json["current_month"].map((x) => CurrentMonth.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "today": List<dynamic>.from(today!.map((x) => x.toJson())),
        "current_month":
            List<dynamic>.from(currentMonth!.map((x) => x.toJson())),
      };
}

class CurrentMonth {
  CurrentMonth({this.image, this.title, this.number, this.slug});

  String? image;
  String? title;
  dynamic number;
  String? slug;

  factory CurrentMonth.fromJson(Map<String, dynamic> json) => CurrentMonth(
      image: json["image"],
      title: json["title"],
      number: json["number"],
      slug: json["slug"]);

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "number": number,
      };
}

class Today {
  Today({this.image, this.title, this.number, this.slug});

  String? image;
  String? title;
  dynamic number;
  String? slug;

  factory Today.fromJson(Map<String, dynamic> json) => Today(
      image: json["image"],
      title: json["title"],
      number: json["number"],
      slug: json["slug"]);

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "number": number,
      };
}

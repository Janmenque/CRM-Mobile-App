
import 'dart:convert';

ResponseVisitList responseVisitListFromJson(String str) => ResponseVisitList.fromJson(json.decode(str));

String responseVisitListToJson(ResponseVisitList data) => json.encode(data.toJson());

class ResponseVisitList {
  ResponseVisitList({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseVisitList.fromJson(Map<String, dynamic> json) => ResponseVisitList(
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
    this.myVisits,
  });

  List<MyVisit>? myVisits;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    myVisits: List<MyVisit>.from(json["my_visits"].map((x) => MyVisit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "my_visits": List<dynamic>.from(myVisits!.map((x) => x.toJson())),
  };
}

class MyVisit {
  MyVisit({
    this.id,
    this.title,
    this.date,
    this.status,
    this.statusColor,
  });

  int? id;
  String? title;
  String? date;
  String? status;
  String? statusColor;

  factory MyVisit.fromJson(Map<String, dynamic> json) => MyVisit(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    status: json["status"],
    statusColor: json["status_color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "status": status,
    "status_color": statusColor,
  };
}

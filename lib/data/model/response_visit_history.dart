
import 'dart:convert';

ResponseVisitHistory responseVisitHistoryFromJson(String str) =>
    ResponseVisitHistory.fromJson(json.decode(str));

String responseVisitHistoryToJson(ResponseVisitHistory data) =>
    json.encode(data.toJson());

class ResponseVisitHistory {
  ResponseVisitHistory({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseVisitHistory.fromJson(Map<String, dynamic> json) =>
      ResponseVisitHistory(
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
    this.history,
  });

  List<History>? history;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        history:
            List<History>.from(json["history"]. map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history!.map((x) => x.toJson())),
      };
}

class History {
  History({
    this.id,
    this.title,
    this.year,
    this.month,
    this.day,
    this.started,
    this.reached,
    this.duration,
    this.status,
    this.statusColor,
  });

  int? id;
  String? title;
  String? year;
  String? month;
  String? day;
  String? started;
  String? reached;
  String? duration;
  String? status;
  String? statusColor;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        title: json["title"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        started: json["started"],
        reached: json["reached"],
        duration: json["duration"],
        status: json["status"],
        statusColor: json["status_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "year": year,
        "month": month,
        "day": day,
        "started": started,
        "reached": reached,
        "duration": duration,
        "status": status,
        "status_color": statusColor,
      };
}

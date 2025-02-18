
import 'dart:convert';

ResponseBreakHistory responseBreakHistoryFromJson(String str) => ResponseBreakHistory.fromJson(json.decode(str));

String responseBreakHistoryToJson(ResponseBreakHistory data) => json.encode(data.toJson());

class ResponseBreakHistory {
  ResponseBreakHistory({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseBreakHistory.fromJson(Map<String, dynamic> json) => ResponseBreakHistory(
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
    this.totalBreakTime,
    this.hasBreak,
    this.breakHistory,
  });

  String? totalBreakTime;
  bool? hasBreak;
  BreakHistory? breakHistory;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalBreakTime: json["total_break_time"],
    hasBreak: json["has_break"],
    breakHistory: BreakHistory.fromJson(json["break_history"]),
  );

  Map<String, dynamic> toJson() => {
    "total_break_time": totalBreakTime,
    "has_break": hasBreak,
    "break_history": breakHistory!.toJson(),
  };
}

class BreakHistory {
  BreakHistory({
    this.todayHistory,
  });

  List<TodayHistory>? todayHistory;

  factory BreakHistory.fromJson(Map<String, dynamic> json) => BreakHistory(
    todayHistory: List<TodayHistory>.from(json["today_history"].map((x) => TodayHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "today_history": List<dynamic>.from(todayHistory!.map((x) => x.toJson())),
  };
}

class TodayHistory {
  TodayHistory({
    this.reason,
    this.breakTimeDuration,
    this.breakBackTime,
  });

  String? reason;
  String? breakTimeDuration;
  String? breakBackTime;

  factory TodayHistory.fromJson(Map<String, dynamic> json) => TodayHistory(
    reason: json["reason"],
    breakTimeDuration: json["break_time_duration"],
    breakBackTime: json["break_back_time"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "break_time_duration": breakTimeDuration,
    "break_back_time": breakBackTime,
  };
}

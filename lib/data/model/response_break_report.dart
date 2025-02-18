
import 'dart:convert';

ResponseBreakReport responseBreakReportFromJson(String str) => ResponseBreakReport.fromJson(json.decode(str));

String responseBreakReportToJson(ResponseBreakReport data) => json.encode(data.toJson());

class ResponseBreakReport {
  ResponseBreakReport({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseBreakReport.fromJson(Map<String, dynamic> json) => ResponseBreakReport(
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
    this.links,
    this.pagination,
  });

  List<TodayHistory>? todayHistory;
  Links? links;
  Pagination? pagination;

  factory BreakHistory.fromJson(Map<String, dynamic> json) => BreakHistory(
    todayHistory: List<TodayHistory>.from(json["today_history"].map((x) => TodayHistory.fromJson(x))),
    links: Links.fromJson(json["links"]),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "today_history": List<dynamic>.from(todayHistory!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "pagination": pagination!.toJson(),
  };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  String? prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Pagination {
  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
  };
}

class TodayHistory {
  TodayHistory({
    this.name,
    this.reason,
    this.breakTimeDuration,
    this.breakBackTime,
  });

  String? name;
  String? reason;
  String? breakTimeDuration;
  String? breakBackTime;

  factory TodayHistory.fromJson(Map<String, dynamic> json) => TodayHistory(
    name: json["name"],
    reason: json["reason"],
    breakTimeDuration: json["break_time_duration"],
    breakBackTime: json["break_back_time"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "reason": reason,
    "break_time_duration": breakTimeDuration,
    "break_back_time": breakBackTime,
  };
}

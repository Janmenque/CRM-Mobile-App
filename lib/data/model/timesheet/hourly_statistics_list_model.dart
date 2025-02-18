
import 'dart:convert';

HourlyStaticsListModel hourlyStaticsListModelFromJson(String str) => HourlyStaticsListModel.fromJson(json.decode(str));


class HourlyStaticsListModel {
  bool? result;
  String? message;
  Data? data;

  HourlyStaticsListModel({
    this.result,
    this.message,
    this.data,
  });

  factory HourlyStaticsListModel.fromJson(Map<String, dynamic> json) => HourlyStaticsListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<User>? users;
  Summary? summary;

  Data({
    this.users,
    this.summary,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
  );
}

class Summary {
  String? dailyWorkingHours;
  String? sumWsalaryTotal;
  String? absWPayTotal;
  String? netTimeTotal;
  String? plusTimeTotal;
  String? factTotal;

  Summary({
    this.dailyWorkingHours,
    this.sumWsalaryTotal,
    this.absWPayTotal,
    this.netTimeTotal,
    this.plusTimeTotal,
    this.factTotal,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    dailyWorkingHours: json["daily_working_hours"],
    sumWsalaryTotal: json["sumWsalaryTotal"],
    absWPayTotal: json["absWPayTotal"],
    netTimeTotal: json["netTimeTotal"],
    plusTimeTotal: json["plusTimeTotal"],
    factTotal: json["factTotal"],
  );
}

class User {
  String? name;
  String? dailyWorkingHours;
  String? sumWsalary;
  String? abscWorkPay;
  String? netTime;
  String? plusTime;
  String? percentage;

  User({
    this.name,
    this.dailyWorkingHours,
    this.sumWsalary,
    this.abscWorkPay,
    this.netTime,
    this.plusTime,
    this.percentage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    dailyWorkingHours: json["daily_working_hours"],
    sumWsalary: json["sumWsalary"],
    abscWorkPay: json["abscWorkPay"],
    netTime: json["netTime"],
    plusTime: json["plusTime"],
    percentage: json["percentage"],
  );
}


import 'dart:convert';

ResourcePlanListModel resourcePlanListModelFromJson(String str) => ResourcePlanListModel.fromJson(json.decode(str));


class ResourcePlanListModel {
  bool? result;
  String? message;
  List<ResourcePlan>? data;

  ResourcePlanListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ResourcePlanListModel.fromJson(Map<String, dynamic> json) => ResourcePlanListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ResourcePlan>.from(json["data"]!.map((x) => ResourcePlan.fromJson(x))),
  );
}

class ResourcePlan {
  int? id;
  String? employee;
  String? project;
  String? task;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? totalTime;
  String? date;
  String? comments;

  ResourcePlan({
    this.id,
    this.employee,
    this.project,
    this.task,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.totalTime,
    this.date,
    this.comments,
  });

  factory ResourcePlan.fromJson(Map<String, dynamic> json) => ResourcePlan(
    id: json["id"],
    employee: json["employee"],
    project: json["project"],
    task: json["task"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    totalTime: json["total_time"],
    date: json["date"],
    comments: json["comments"],
  );
}

import 'dart:convert';
import '../../../../../data/model/home/crm_home_model.dart';

TaskDashboardModel taskDashboardModelFromJson(String str) =>
    TaskDashboardModel.fromJson(json.decode(str));


class TaskDashboardModel {
  TaskDashboardModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory TaskDashboardModel.fromJson(Map<String, dynamic> json) =>
      TaskDashboardModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

}

class Data {
  Data({
    this.staticstics,
    this.tasksInCollection,
    this.completeTasksCollection,
  });

  List<Staticstic>? staticstics;
  List<Collection>? tasksInCollection;
  List<Collection>? completeTasksCollection;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        staticstics: List<Staticstic>.from(
            json["staticstics"].map((x) => Staticstic.fromJson(x))),
        tasksInCollection: List<Collection>.from(
            json["tasks_in_collection"].map((x) => Collection.fromJson(x))),
        completeTasksCollection: List<Collection>.from(
            json["complete_tasks_collection"]
                .map((x) => Collection.fromJson(x))),
      );

}

class Collection {
  Collection({
    this.id,
    this.title,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.usersCount,
    this.members,
    this.color,
  });

  int? id;
  String? title;
  String? dateRange;
  DateTime? startDate;
  DateTime? endDate;
  int? usersCount;
  List<Members>? members;
  String? color;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
        title: json["title"],
        dateRange: json["date_range"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        usersCount: json["users_count"],
    members: List<Members>.from(json["members"].map((x) => Members.fromJson(x))),
        color: json["color"],
      );


}


class Staticstic {
  Staticstic({
    this.count,
    this.text,
    this.status,
    this.image,
  });

  int? count;
  String? text;
  String? status;
  String? image;

  factory Staticstic.fromJson(Map<String, dynamic> json) => Staticstic(
        count: json["count"],
        text: json["text"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "text": text,
        "status": status,
        "image": image,
      };
}

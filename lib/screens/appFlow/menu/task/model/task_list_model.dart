import 'dart:convert';
import '../../../../../data/model/home/crm_home_model.dart';

TaskListModel taskListModelFromJson(String str) =>
    TaskListModel.fromJson(json.decode(str));

class TaskListModel {
  TaskListModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.priorities,
    this.taskListCollection,
  });

  List<Priority>? priorities;
  TaskListCollection? taskListCollection;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        priorities: List<Priority>.from(
            json["priorities"].map((x) => Priority.fromJson(x))),
        taskListCollection:
            TaskListCollection.fromJson(json["task_list_collection"]),
      );
}

class Priority {
  Priority({
    this.title,
    this.id,
    this.count,
    this.color,
  });

  String? title;
  int? id;
  int? count;
  String? color;

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        title: json["title"],
        id: json["id"],
        count: json["count"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "count": count,
        "color": color,
      };
}

class TaskListCollection {
  TaskListCollection({
    this.tasks,
    this.pagination,
  });

  List<Task>? tasks;
  Pagination? pagination;

  factory TaskListCollection.fromJson(Map<String, dynamic> json) =>
      TaskListCollection(
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );
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

class Task {
  Task({
    this.id,
    this.title,
    this.dateRange,
    this.startDate,
    this.endDate,
    this.isCreator,
    this.usersCount,
    this.members,
    this.color,
  });

  int? id;
  String? title;
  String? dateRange;
  DateTime? startDate;
  DateTime? endDate;
  bool? isCreator;
  int? usersCount;
  List<Members>? members;
  String? color;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        dateRange: json["date_range"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        isCreator: json["is_creator"],
        usersCount: json["users_count"],
    members: List<Members>.from(json["members"].map((x) => Members.fromJson(x))),
        color: json["color"],
      );

}



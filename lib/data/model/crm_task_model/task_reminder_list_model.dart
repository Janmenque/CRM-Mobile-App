
import 'dart:convert';

TaskReminderListModel taskReminderListModelFromJson(String str) => TaskReminderListModel.fromJson(json.decode(str));


class TaskReminderListModel {
  bool? result;
  String? message;
  Data? data;

  TaskReminderListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskReminderListModel.fromJson(Map<String, dynamic> json) => TaskReminderListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<TaskReminder>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<TaskReminder>.from(json["data"]!.map((x) => TaskReminder.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class TaskReminder {
  int? id;
  String? notifyDateTime;
  int? mailableStatus;
  String? description;
  String? createdAt;
  Task? task;
  RemainderTo? remainderTo;

  TaskReminder({
    this.id,
    this.notifyDateTime,
    this.mailableStatus,
    this.description,
    this.createdAt,
    this.task,
    this.remainderTo,
  });

  factory TaskReminder.fromJson(Map<String, dynamic> json) => TaskReminder(
    id: json["id"],
    notifyDateTime: json["notify_date_time"],
    mailableStatus: json["mailable_status"],
    description: json["description"],
    createdAt: json["created_at"],
    task: json["task"] == null ? null : Task.fromJson(json["task"]),
    remainderTo: json["remainder_to"] == null ? null : RemainderTo.fromJson(json["remainder_to"]),
  );

}

class RemainderTo {
  int? id;
  String? name;
  String? avatar;

  RemainderTo({
    this.id,
    this.name,
    this.avatar,
  });

  factory RemainderTo.fromJson(Map<String, dynamic> json) => RemainderTo(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}

class Task {
  int? id;
  String? name;

  Task({
    this.id,
    this.name,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

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

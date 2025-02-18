import 'dart:convert';

TaskCheckListModel taskCheckListModelFromJson(String str) => TaskCheckListModel.fromJson(json.decode(str));

class TaskCheckListModel {
  bool? result;
  String? message;
  Data? data;

  TaskCheckListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskCheckListModel.fromJson(Map<String, dynamic> json) => TaskCheckListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<TaskCheckList>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<TaskCheckList>.from(json["data"]!.map((x) => TaskCheckList.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class TaskCheckList {
  int? id;
  String? description;
  String? createdAt;
  dynamic currentStatus;
  List<dynamic>? statusLogs;
  Task? task;
  AssignStaff? assignStaff;
  AssignStaff? createdBy;

  TaskCheckList({
    this.id,
    this.description,
    this.createdAt,
    this.currentStatus,
    this.statusLogs,
    this.task,
    this.assignStaff,
    this.createdBy,
  });

  factory TaskCheckList.fromJson(Map<String, dynamic> json) => TaskCheckList(
    id: json["id"],
    description: json["description"],
    createdAt: json["created_at"],
    currentStatus: json["current_status"],
    statusLogs: json["status_logs"] == null ? [] : List<dynamic>.from(json["status_logs"]!.map((x) => x)),
    task: json["task"] == null ? null : Task.fromJson(json["task"]),
    assignStaff: json["assign_staff"] == null ? null : AssignStaff.fromJson(json["assign_staff"]),
    createdBy: json["created_by"] == null ? null : AssignStaff.fromJson(json["created_by"]),
  );
}

class AssignStaff {
  int? id;
  String? name;
  String? avatar;

  AssignStaff({
    this.id,
    this.name,
    this.avatar,
  });

  factory AssignStaff.fromJson(Map<String, dynamic> json) => AssignStaff(
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

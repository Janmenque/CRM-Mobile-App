
import 'dart:convert';

TaskCommentListModel taskCommentListModelFromJson(String str) => TaskCommentListModel.fromJson(json.decode(str));

class TaskCommentListModel {
  bool? result;
  String? message;
  Data? data;

  TaskCommentListModel({
    this.result,
    this.message,
    this.data,
  });

  factory TaskCommentListModel.fromJson(Map<String, dynamic> json) => TaskCommentListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<TaskComment>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<TaskComment>.from(json["data"]!.map((x) => TaskComment.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class TaskComment {
  int? id;
  String? comment;
  String? attachmentId;
  String? createdAt;
  Task? task;
  CreatedBy? createdBy;

  TaskComment({
    this.id,
    this.comment,
    this.attachmentId,
    this.createdAt,
    this.task,
    this.createdBy,
  });

  factory TaskComment.fromJson(Map<String, dynamic> json) => TaskComment(
    id: json["id"],
    comment: json["comment"],
    attachmentId: json["attachment_id"],
    createdAt: json["created_at"],
    task: json["task"] == null ? null : Task.fromJson(json["task"]),
    createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
  );
}

class CreatedBy {
  int? id;
  String? name;
  String? avatar;

  CreatedBy({
    this.id,
    this.name,
    this.avatar,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
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

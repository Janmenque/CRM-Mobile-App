
import 'dart:convert';

ProjectFileListModel projectFileListModelFromJson(String str) => ProjectFileListModel.fromJson(json.decode(str));


class ProjectFileListModel {
  bool? result;
  String? message;
  Data? data;

  ProjectFileListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProjectFileListModel.fromJson(Map<String, dynamic> json) => ProjectFileListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<ProjectFile>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ProjectFile>.from(json["data"]!.map((x) => ProjectFile.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ProjectFile {
  int? id;
  String? subject;
  int? commentsCount;
  String? attachment;
  String? lastActivity;
  String? createdAt;
  Project? project;
  Status? status;
  CreatedBy? createdBy;

  ProjectFile({
    this.id,
    this.subject,
    this.commentsCount,
    this.attachment,
    this.lastActivity,
    this.createdAt,
    this.project,
    this.status,
    this.createdBy,
  });

  factory ProjectFile.fromJson(Map<String, dynamic> json) => ProjectFile(
    id: json["id"],
    subject: json["subject"],
    commentsCount: json["comments_count"],
    attachment: json["attachment"],
    lastActivity: json["last_activity"],
    createdAt: json["created_at"],
    project: json["project"] == null ? null : Project.fromJson(json["project"]),
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
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

class Project {
  int? id;
  String? name;

  Project({
    this.id,
    this.name,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    name: json["name"],
  );

}

class Status {
  int? id;
  String? name;
  String? statusClass;
  String? colorCode;
  String? translatedName;

  Status({
    this.id,
    this.name,
    this.statusClass,
    this.colorCode,
    this.translatedName,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    name: json["name"],
    statusClass: json["class"],
    colorCode: json["color_code"],
    translatedName: json["translated_name"],
  );
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
}

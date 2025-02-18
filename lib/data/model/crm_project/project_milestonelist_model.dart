
import 'dart:convert';

ProjectMilestoneListModel projectMilestoneListModelFromJson(String str) => ProjectMilestoneListModel.fromJson(json.decode(str));


class ProjectMilestoneListModel {
  bool? result;
  String? message;
  Data? data;

  ProjectMilestoneListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProjectMilestoneListModel.fromJson(Map<String, dynamic> json) => ProjectMilestoneListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<ProjectMilestone>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ProjectMilestone>.from(json["data"]!.map((x) => ProjectMilestone.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ProjectMilestone {
  int? id;
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? note;
  DateTime? createdAt;
  Project? project;
  Status? status;
  CreatedBy? createdBy;

  ProjectMilestone({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
    this.note,
    this.createdAt,
    this.project,
    this.status,
    this.createdBy,
  });

  factory ProjectMilestone.fromJson(Map<String, dynamic> json) => ProjectMilestone(
    id: json["id"],
    name: json["name"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    note: json["note"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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

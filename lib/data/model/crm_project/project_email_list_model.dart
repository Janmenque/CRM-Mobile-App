import 'dart:convert';

ProjectEmailListModel projectEmailListModelFromJson(String str) => ProjectEmailListModel.fromJson(json.decode(str));

class ProjectEmailListModel {
  bool? result;
  String? message;
  Data? data;

  ProjectEmailListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProjectEmailListModel.fromJson(Map<String, dynamic> json) => ProjectEmailListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<ProjectEmail>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ProjectEmail>.from(json["data"]!.map((x) => ProjectEmail.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ProjectEmail {
  int? id;
  String? to;
  String? cc;
  String? subject;
  String? message;
  DateTime? createdAt;
  Project? project;
  CreatedBy? createdBy;

  ProjectEmail({
    this.id,
    this.to,
    this.cc,
    this.subject,
    this.message,
    this.createdAt,
    this.project,
    this.createdBy,
  });

  factory ProjectEmail.fromJson(Map<String, dynamic> json) => ProjectEmail(
    id: json["id"],
    to: json["to"],
    cc: json["cc"],
    subject: json["subject"],
    message: json["message"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    project: json["project"] == null ? null : Project.fromJson(json["project"]),
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

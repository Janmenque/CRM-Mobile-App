import 'dart:convert';

ClientProjectListModel clientProjectListModelFromJson(String str) => ClientProjectListModel.fromJson(json.decode(str));


class ClientProjectListModel {
  bool? result;
  String? message;
  ClientProjectListModelData? data;

  ClientProjectListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientProjectListModel.fromJson(Map<String, dynamic> json) => ClientProjectListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : ClientProjectListModelData.fromJson(json["data"]),
  );
}

class ClientProjectListModelData {
  String? slug;
  String? label;
  List<Priority>? priorities;
  ProjectData? data;

  ClientProjectListModelData({
    this.slug,
    this.label,
    this.priorities,
    this.data,
  });

  factory ClientProjectListModelData.fromJson(Map<String, dynamic> json) => ClientProjectListModelData(
    slug: json["slug"],
    label: json["label"],
    priorities: json["priorities"] == null ? [] : List<Priority>.from(json["priorities"]!.map((x) => Priority.fromJson(x))),
    data: json["data"] == null ? null : ProjectData.fromJson(json["data"]),
  );
}

class ProjectData {
  List<ClientProject>? projects;
  Pagination? pagination;

  ProjectData({
    this.projects,
    this.pagination,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
    projects: json["projects"] == null ? [] : List<ClientProject>.from(json["projects"]!.map((x) => ClientProject.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
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

  Map<String, dynamic> toJson() => {
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
  };
}

class ClientProject {
  int? id;
  String? title;
  String? dateRange;
  int? usersCount;
  int? actualCount;
  List<Member>? members;
  int? progress;
  String? color;
  String? status;
  String? priority;
  String? priorityColor;
  bool? clickable;
  String? endPoint;

  ClientProject({
    this.id,
    this.title,
    this.dateRange,
    this.usersCount,
    this.actualCount,
    this.members,
    this.progress,
    this.color,
    this.status,
    this.priority,
    this.priorityColor,
    this.clickable,
    this.endPoint,
  });

  factory ClientProject.fromJson(Map<String, dynamic> json) => ClientProject(
    id: json["id"],
    title: json["title"],
    dateRange: json["date_range"],
    usersCount: json["users_count"],
    actualCount: json["actual_count"],
    members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    progress: json["progress"],
    color: json["color"],
    status: json["status"],
    priority: json["priority"],
    priorityColor: json["priority_color"],
    clickable: json["clickable"],
    endPoint: json["end_point"],
  );
}

class Member {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? avatar;

  Member({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.designation,
    this.department,
    this.avatar,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    designation: json["designation"],
    department: json["department"],
    avatar: json["avatar"],
  );

}

class Priority {
  String? title;
  int? id;

  Priority({
    this.title,
    this.id,
  });

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
    title: json["title"],
    id: json["id"],
  );

}

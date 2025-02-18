
import 'dart:convert';

ProjectActivityListModel projectActivityListModelFromJson(String str) => ProjectActivityListModel.fromJson(json.decode(str));


class ProjectActivityListModel {
  bool? result;
  String? message;
  Data? data;

  ProjectActivityListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProjectActivityListModel.fromJson(Map<String, dynamic> json) => ProjectActivityListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<ProjectActivity>? data;
  Pagination? pagination;

  Data({
    this.data,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<ProjectActivity>.from(json["data"]!.map((x) => ProjectActivity.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class ProjectActivity {
  int? id;
  String? description;
  DateTime? createdAt;
  User? user;

  ProjectActivity({
    this.id,
    this.description,
    this.createdAt,
    this.user,
  });

  factory ProjectActivity.fromJson(Map<String, dynamic> json) => ProjectActivity(
    id: json["id"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "avatar": avatar,
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

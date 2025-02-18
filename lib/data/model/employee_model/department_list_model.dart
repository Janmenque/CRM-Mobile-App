import 'dart:convert';

DepartmentListModel departmentListModelFromJson(String str) =>
    DepartmentListModel.fromJson(json.decode(str));

class DepartmentListModel {
  DepartmentListModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory DepartmentListModel.fromJson(Map<String, dynamic> json) =>
      DepartmentListModel(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.departments,
  });

  List<Department>? departments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        departments: List<Department>.from(
            json["departments"].map((x) => Department.fromJson(x))),
      );
}

class Department {
  Department({
    this.id,
    this.title,
    this.status,
    this.createdAt,
  });

  int? id;
  String? title;
  String? status;
  String? createdAt;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        title: json["title"],
        status: json["status"].toString(),
        createdAt: json["created_at"],
      );
}

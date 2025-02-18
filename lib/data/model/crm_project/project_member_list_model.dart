
import 'dart:convert';

ProjectMemberListModel projectMemberListModelFromJson(String str) => ProjectMemberListModel.fromJson(json.decode(str));

class ProjectMemberListModel {
  bool? result;
  String? message;
  List<ProjectMember>? data;

  ProjectMemberListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProjectMemberListModel.fromJson(Map<String, dynamic> json) => ProjectMemberListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ProjectMember>.from(json["data"]!.map((x) => ProjectMember.fromJson(x))),
  );

}

class ProjectMember {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;

  ProjectMember({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
  });

  factory ProjectMember.fromJson(Map<String, dynamic> json) => ProjectMember(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
  );
}

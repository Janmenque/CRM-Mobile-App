
import 'dart:convert';

EmployeeDetailsModel employeeDetailsModelFromJson(String str) => EmployeeDetailsModel.fromJson(json.decode(str));

String employeeDetailsModelToJson(EmployeeDetailsModel data) => json.encode(data.toJson());

class EmployeeDetailsModel {
  EmployeeDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) => EmployeeDetailsModel(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.designation,
    this.department,
    this.address,
    this.phone,
    this.email,
    this.aboutMe,
    this.avatar,
    this.skills,
  });

  int? id;
  String? name;
  String? designation;
  String? department;
  String? address;
  String? phone;
  String? email;
  String? aboutMe;
  String? avatar;
  List<Skill>? skills;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    designation: json["designation"],
    department: json["department"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
    aboutMe: json["about_me"],
    avatar: json["avatar"],
    skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "designation": designation,
    "department": department,
    "address": address,
    "phone": phone,
    "email": email,
    "about_me": aboutMe,
    "avatar": avatar,
    "skills": List<dynamic>.from(skills!.map((x) => x.toJson())),
  };
}

class Skill {
  Skill({
    this.id,
    this.name,
    this.percentage,
  });

  int? id;
  String? name;
  String? percentage;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json["id"],
    name: json["name"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "percentage": percentage,
  };
}

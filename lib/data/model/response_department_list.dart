
import 'dart:convert';

ResponseDepartment responseDepartmentFromJson(String str) => ResponseDepartment.fromJson(json.decode(str));

String responseDepartmentToJson(ResponseDepartment data) => json.encode(data.toJson());

class ResponseDepartment {
  ResponseDepartment({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  DepartmentData? data;

  factory ResponseDepartment.fromJson(Map<String, dynamic> json) => ResponseDepartment(
    result: json["result"],
    message: json["message"],
    data: DepartmentData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data!.toJson(),
  };
}

class DepartmentData {
  DepartmentData({
    this.departments,
  });

  List<Department>? departments;

  factory DepartmentData.fromJson(Map<String, dynamic> json) => DepartmentData(
    departments: List<Department>.from(json["departments"].map((x) => Department.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "departments": List<dynamic>.from(departments!.map((x) => x.toJson())),
  };
}

class Department {
  Department({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

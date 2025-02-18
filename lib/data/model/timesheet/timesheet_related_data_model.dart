
import 'dart:convert';

TimesheetRelatedDataModel timesheetRelatedDataModelFromJson(String str) => TimesheetRelatedDataModel.fromJson(json.decode(str));

class TimesheetRelatedDataModel {
  bool? result;
  String? message;
  Data? data;

  TimesheetRelatedDataModel({
    this.result,
    this.message,
    this.data,
  });

  factory TimesheetRelatedDataModel.fromJson(Map<String, dynamic> json) => TimesheetRelatedDataModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<TimesheetProject>? projects;
  List<TimesheetEmployee>? employees;
  List<Map<String, String>>? weeks;

  Data({
    this.projects,
    this.employees,
    this.weeks,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    projects: json["projects"] == null ? [] : List<TimesheetProject>.from(json["projects"]!.map((x) => TimesheetProject.fromJson(x))),
    employees: json["employees"] == null ? [] : List<TimesheetEmployee>.from(json["employees"]!.map((x) => TimesheetEmployee.fromJson(x))),
    weeks: json["weeks"] == null ? [] : List<Map<String, String>>.from(json["weeks"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
  );
}

class TimesheetEmployee {
  int? id;
  String? name;

  TimesheetEmployee({
    this.id,
    this.name,
  });

  factory TimesheetEmployee.fromJson(Map<String, dynamic> json) => TimesheetEmployee(
    id: json["id"],
    name: json["name"],
  );
}

class TimesheetProject {
  int? id;
  String? name;

  TimesheetProject({
    this.id,
    this.name,
  });

  factory TimesheetProject.fromJson(Map<String, dynamic> json) => TimesheetProject(
    id: json["id"],
    name: json["name"],
  );
}

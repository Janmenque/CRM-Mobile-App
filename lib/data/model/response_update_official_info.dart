
import 'dart:convert';

ResponseUpdateOfficalInfo responseUpdateOfficalInfoFromJson(String str) =>
    ResponseUpdateOfficalInfo.fromJson(json.decode(str));

String responseUpdateOfficalInfoToJson(ResponseUpdateOfficalInfo data) =>
    json.encode(data.toJson());

class ResponseUpdateOfficalInfo {
  ResponseUpdateOfficalInfo(
      {this.result, this.message, this.data, this.laravelValidationError});

  bool? result;
  String? message;
  Data? data;
  LaravelValidationError? laravelValidationError;

  factory ResponseUpdateOfficalInfo.fromJson(Map<String, dynamic> json) =>
      ResponseUpdateOfficalInfo(
          result: json["result"],
          message: json["message"],
          data: json["data"] != null ? Data.fromJson(json["data"]) : null,
          laravelValidationError: json["error"] != null
              ? LaravelValidationError.formjson(json["error"])
              : null);

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.name,
    this.email,
    this.departmentId,
    this.department,
    this.designationId,
    this.designation,
    this.joiningDateDb,
    this.employeeType,
    this.employeeId,
    this.managerId,
    this.manager,
    this.grade,
  });

  String? name;
  String? email;
  int? departmentId;
  String? department;
  int? designationId;
  String? designation;
  DateTime? joiningDateDb;
  String? employeeType;
  String? employeeId;
  int? managerId;
  String? manager;
  String? grade;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        departmentId: json["department_id"],
        department: json["department"],
        designationId: json["designation_id"],
        designation: json["designation"],
        joiningDateDb: json["joining_date_db"] != null
            ? DateTime.parse(json["joining_date_db"])
            : null,
        employeeType: json["employee_type"],
        employeeId: json["employee_id"],
        managerId: json["manager_id"],
        manager: json["manager"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "department_id": departmentId,
        "department": department,
        "designation_id": designationId,
        "designation": designation,
        "joining_date":
            "${joiningDateDb!.year.toString().padLeft(4, '0')}-${joiningDateDb!.month.toString().padLeft(2, '0')}-${joiningDateDb!.day.toString().padLeft(2, '0')}",
        "employee_type": employeeType,
        "employee_id": employeeId,
        "manager_id": managerId,
        "manager": manager,
        "grade": grade,
      };
}

class LaravelValidationError {
  final String? name;
  final String? email;
  final String? managerId;

  LaravelValidationError({this.name, this.email, this.managerId});

  factory LaravelValidationError.formjson(Map<String, dynamic> json) {
    return LaravelValidationError(
        name: json["name"] != null ? json["name"][0] : null,
        email: json["email"] != null ? json["email"][0] : null,
        managerId: json["manager_id"] != null ? json["manager_id"][0] : null);
  }
}

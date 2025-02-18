
import 'dart:convert';

ResponseOfficialInfo responseOfficialInfoFromJson(String str) =>
    ResponseOfficialInfo.fromJson(json.decode(str));

String responseOfficialInfoToJson(ResponseOfficialInfo data) =>
    json.encode(data.toJson());

class ResponseOfficialInfo {
  ResponseOfficialInfo({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ResponseOfficialInfo.fromJson(Map<String, dynamic> json) =>
      ResponseOfficialInfo(
        result: json["result"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data(
      {this.name,
      this.email,
      this.avatar,
      this.departmentId,
      this.department,
      this.designationId,
      this.designation,
      this.employeeType,
      this.employeeId,
      this.managerId,
      this.manager,
      this.grade,
      this.joiningDateDb,
      this.joiningDate,
      });

  String? name;
  String? email;
  String? avatar;
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
  String? joiningDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        avatar: json["avatar"],
        departmentId: json["department_id"],
        department: json["department"],
        designationId: json["designation_id"],
        designation: json["designation"],
        employeeType: json["employee_type"],
        employeeId: json["employee_id"],
        managerId: json["manager_id"],
        manager: json["manager"],
        grade: json["grade"],
        joiningDateDb: json["joining_date_db"] != null
            ? DateTime.parse(json["joining_date_db"])
            : null,
    joiningDate: json["joining_date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "avatar": avatar,
        "department_id": departmentId,
        "department": department,
        "designation_id": designationId,
        "designation": designation,
        "employee_type": employeeType,
        "employee_id": employeeId,
        "manager_id": managerId,
        "manager": manager,
        "grade": grade,
        "joining_date_db":
            "${joiningDateDb!.year.toString().padLeft(4, '0')}-${joiningDateDb!.month.toString().padLeft(2, '0')}-${joiningDateDb!.day.toString().padLeft(2, '0')}",
        "joining_date": joiningDate,
      };
}

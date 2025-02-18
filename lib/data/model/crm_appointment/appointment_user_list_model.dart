
import 'dart:convert';

AppointmentUserListModel appointmentUserListModelFromJson(String str) => AppointmentUserListModel.fromJson(json.decode(str));

class AppointmentUserListModel {
  bool? result;
  String? message;
  List<AppointmentUser>? data;

  AppointmentUserListModel({
    this.result,
    this.message,
    this.data,
  });

  factory AppointmentUserListModel.fromJson(Map<String, dynamic> json) => AppointmentUserListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AppointmentUser>.from(json["data"]!.map((x) => AppointmentUser.fromJson(x))),
  );
}

class AppointmentUser {
  int? id;
  String? name;
  String? phone;
  String? employeeId;

  AppointmentUser({
    this.id,
    this.name,
    this.phone,
    this.employeeId,
  });

  factory AppointmentUser.fromJson(Map<String, dynamic> json) => AppointmentUser(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    employeeId: json["employee_id"],
  );
}

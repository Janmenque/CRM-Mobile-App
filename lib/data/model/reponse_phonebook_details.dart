import 'dart:convert';

PhonebookDetailsModel phonebookDetailsModelFromJson(String str) => PhonebookDetailsModel.fromJson(json.decode(str));

class PhonebookDetailsModel {
  PhonebookDetailsModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory PhonebookDetailsModel.fromJson(Map<String, dynamic> json) => PhonebookDetailsModel(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.id,
    this.avatar,
    this.name,
    this.designation,
    this.email,
    this.phone,
    this.department,
    this.birthDate,
    this.bloodGroup,
    this.facebookLink,
    this.linkedinLink,
    this.instagramLink,
    this.appreciates,
  });

  int? id;
  String? avatar;
  String? name;
  String? designation;
  String? email;
  String? phone;
  String? department;
  dynamic birthDate;
  dynamic bloodGroup;
  dynamic facebookLink;
  dynamic linkedinLink;
  dynamic instagramLink;
  List<dynamic>? appreciates;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'],
    avatar: json["avatar"],
    name: json["name"],
    designation: json["designation"],
    email: json["email"],
    phone: json["phone"],
    department: json["department"],
    birthDate: json["birth_date"],
    bloodGroup: json["blood_group"],
    facebookLink: json["facebook_link"],
    linkedinLink: json["linkedin_link"],
    instagramLink: json["instagram_link"],
    appreciates: json["appreciates"] != null ? List<dynamic>.from(json["appreciates"].map((x) => x)): null,
  );
}

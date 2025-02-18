
import 'dart:convert';

LeadsProfileViewModel leadsProfileViewModelFromJson(String str) => LeadsProfileViewModel.fromJson(json.decode(str));

class LeadsProfileViewModel {
  bool? result;
  String? message;
  Data? data;

  LeadsProfileViewModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadsProfileViewModel.fromJson(Map<String, dynamic> json) => LeadsProfileViewModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  int? id;
  String? title;
  String? name;
  String? company;
  String? leadType;
  String? leadStatus;
  String? leadSource;
  String? createdDate;
  String? nextFollowUp;
  String? address;
  String? email;
  String? phone;
  String? author;
  dynamic website;

  Data({
    this.id,
    this.title,
    this.name,
    this.company,
    this.leadType,
    this.leadStatus,
    this.leadSource,
    this.createdDate,
    this.nextFollowUp,
    this.address,
    this.email,
    this.phone,
    this.author,
    this.website,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    name: json["name"],
    company: json["company"],
    leadType: json["lead_type"],
    leadStatus: json["lead_status"],
    leadSource: json["lead_source"],
    createdDate: json["created_date"],
    nextFollowUp: json["next_follow_up"],
    address: json["address"],
    email: json["email"],
    phone: json["phone"],
    author: json["author"],
    website: json["website"],
  );
}

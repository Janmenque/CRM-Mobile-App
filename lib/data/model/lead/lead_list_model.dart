

import 'dart:convert';

LeadListModel leadListModelFromJson(String str) => LeadListModel.fromJson(json.decode(str));

class LeadListModel {
  bool? result;
  String? message;
  List<Lead>? data;

  LeadListModel({
    this.result,
    this.message,
    this.data,
  });

  factory LeadListModel.fromJson(Map<String, dynamic> json) => LeadListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Lead>.from(json["data"]!.map((x) => Lead.fromJson(x))),
  );
}

class Lead {
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
  String? website;

  Lead({
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

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
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

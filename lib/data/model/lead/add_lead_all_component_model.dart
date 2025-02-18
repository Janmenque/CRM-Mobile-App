
import 'dart:convert';

AddLeadAllComponentModel addLeadAllComponentModelFromJson(String str) => AddLeadAllComponentModel.fromJson(json.decode(str));

class AddLeadAllComponentModel {
  bool? result;
  String? message;
  Data? data;

  AddLeadAllComponentModel({
    this.result,
    this.message,
    this.data,
  });

  factory AddLeadAllComponentModel.fromJson(Map<String, dynamic> json) => AddLeadAllComponentModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<LeadComponent>? leadTypes;
  List<LeadComponent>? leadZone;
  List<LeadComponent>? leadStatus;

  Data({
    this.leadTypes,
    this.leadZone,
    this.leadStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leadTypes: json["lead_types"] == null ? [] : List<LeadComponent>.from(json["lead_types"]!.map((x) => LeadComponent.fromJson(x))),
    leadZone: json["lead_zone"] == null ? [] : List<LeadComponent>.from(json["lead_zone"]!.map((x) => LeadComponent.fromJson(x))),
    leadStatus: json["lead_status"] == null ? [] : List<LeadComponent>.from(json["lead_status"]!.map((x) => LeadComponent.fromJson(x))),
  );
}

class LeadComponent {
  int? id;
  String? title;

  LeadComponent({
    this.id,
    this.title,
  });

  factory LeadComponent.fromJson(Map<String, dynamic> json) => LeadComponent(
    id: json["id"],
    title: json["title"],
  );

}

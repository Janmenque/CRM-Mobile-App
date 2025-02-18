import 'dart:convert';

DesignationListModel designationListModelFromJson(String str) =>
    DesignationListModel.fromJson(json.decode(str));

String designationListModelToJson(DesignationListModel data) =>
    json.encode(data.toJson());

class DesignationListModel {
  DesignationListModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory DesignationListModel.fromJson(Map<String, dynamic> json) =>
      DesignationListModel(
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
  Data({
    this.designations,
  });

  List<Designation>? designations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        designations: List<Designation>.from(
            json["designations"].map((x) => Designation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "designations": List<dynamic>.from(designations!.map((x) => x.toJson())),
      };
}

class Designation {
  Designation({
    this.id,
    this.title,
    this.status,
    this.createdAt,
  });

  int? id;
  String? title;
  String? status;
  String? createdAt;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "created_at":createdAt,
      };
}




import 'dart:convert';

OtherUnitModel otherUnitModelFromJson(String str) => OtherUnitModel.fromJson(json.decode(str));

String otherUnitModelToJson(OtherUnitModel data) => json.encode(data.toJson());

class OtherUnitModel {
  bool? result;
  String? message;
  List<OtherUnit>? otherUnit;

  OtherUnitModel({
    this.result,
    this.message,
    this.otherUnit,
  });

  factory OtherUnitModel.fromJson(Map<String, dynamic> json) => OtherUnitModel(
    result: json["result"],
    message: json["message"],
    otherUnit: json["data"] == null ? [] : List<OtherUnit>.from(json["data"]!.map((x) => OtherUnit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": otherUnit == null ? [] : List<dynamic>.from(otherUnit!.map((x) => x.toJson())),
  };
}

class OtherUnit {
  int? id;
  String? unitName;

  OtherUnit({
    this.id,
    this.unitName,
  });

  factory OtherUnit.fromJson(Map<String, dynamic> json) => OtherUnit(
    id: json["id"],
    unitName: json["unit_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_name": unitName,
  };
}

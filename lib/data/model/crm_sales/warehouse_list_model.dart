
import 'dart:convert';

WareHouseListModel wareHouseListModelFromJson(String str) => WareHouseListModel.fromJson(json.decode(str));


class WareHouseListModel {
  bool? result;
  String? message;
  Data? data;

  WareHouseListModel({
    this.result,
    this.message,
    this.data,
  });

  factory WareHouseListModel.fromJson(Map<String, dynamic> json) => WareHouseListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<Warehouse>? warehouse;

  Data({
    this.warehouse,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    warehouse: json["warehouse"] == null ? [] : List<Warehouse>.from(json["warehouse"]!.map((x) => Warehouse.fromJson(x))),
  );
}

class Warehouse {
  int? id;
  String? name;

  Warehouse({
    this.id,
    this.name,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    id: json["id"],
    name: json["name"],
  );

}

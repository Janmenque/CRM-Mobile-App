
import 'dart:convert';

ExpenseCategoryModel expenseCategoryModelFromJson(String str) => ExpenseCategoryModel.fromJson(json.decode(str));

String expenseCategoryModelToJson(ExpenseCategoryModel data) => json.encode(data.toJson());

class ExpenseCategoryModel {
  ExpenseCategoryModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ExpenseCategoryModel.fromJson(Map<String, dynamic> json) => ExpenseCategoryModel(
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
    this.categories,
  });

  List<Category>? categories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

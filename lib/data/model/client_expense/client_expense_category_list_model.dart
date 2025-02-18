import 'dart:convert';

ClientExpenseCategoryList clientExpenseCategoryListFromJson(String str) => ClientExpenseCategoryList.fromJson(json.decode(str));


class ClientExpenseCategoryList {
  bool? result;
  String? message;
  List<ClientExpenseCategory>? data;

  ClientExpenseCategoryList({
    this.result,
    this.message,
    this.data,
  });

  factory ClientExpenseCategoryList.fromJson(Map<String, dynamic> json) => ClientExpenseCategoryList(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ClientExpenseCategory>.from(json["data"]!.map((x) => ClientExpenseCategory.fromJson(x))),
  );
}

class ClientExpenseCategory {
  int? id;
  String? name;

  ClientExpenseCategory({
    this.id,
    this.name,
  });

  factory ClientExpenseCategory.fromJson(Map<String, dynamic> json) => ClientExpenseCategory(
    id: json["id"],
    name: json["name"],
  );
}


import 'dart:convert';

StockProductListModel stockProductListModelFromJson(String str) => StockProductListModel.fromJson(json.decode(str));

String stockProductListModelToJson(StockProductListModel data) => json.encode(data.toJson());

class StockProductListModel {
  StockProductListModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory StockProductListModel.fromJson(Map<String, dynamic> json) => StockProductListModel(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.items,
    this.pagination,
  });

  List<Item>? items;
  Pagination? pagination;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Item {
  Item({
    this.id,
    this.name,
    this.brand,
    this.category,
    this.stock,
    this.price,
    this.avatar,
  });

  int? id;
  String? name;
  String? brand;
  String? category;
  String? stock;
  String? price;
  String? avatar;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    brand: json["brand"],
    category: json["category"],
    stock: json["stock"],
    price: json["price"].toString(),
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "brand": brand,
    "category": category,
    "stock": stock,
    "price": price,
    "avatar": avatar,
  };
}

class Pagination {
  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    totalPages: json["total_pages"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "count": count,
    "per_page": perPage,
    "current_page": currentPage,
    "total_pages": totalPages,
  };
}

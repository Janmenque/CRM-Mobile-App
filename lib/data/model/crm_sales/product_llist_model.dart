
import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));


class ProductListModel {
  bool? result;
  String? message;
  Data? data;

  ProductListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<Product>? products;
  Pagination? pagination;

  Data({
    this.products,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

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

class Product {
  int? id;
  String? name;
  dynamic image;
  String? code;
  String? brand;
  String? category;
  int? qty;
  String? unit;
  int? cost;
  int? price;
  String? stock;
  String? status;

  Product({
    this.id,
    this.name,
    this.image,
    this.code,
    this.brand,
    this.category,
    this.qty,
    this.unit,
    this.cost,
    this.price,
    this.stock,
    this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    image: json["image"] != null ? json["image"] : "",
    code: json["code"],
    brand: json["brand"],
    category: json["category"],
    qty: json["qty"],
    unit: json["unit"],
    cost: json["cost"],
    price: json["price"],
    stock: json["stock"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "code": code,
    "brand": brand,
    "category": category,
    "qty": qty,
    "unit": unit,
    "cost": cost,
    "price": price,
    "stock": stock,
    "status": status,
  };
}

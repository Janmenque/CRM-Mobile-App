import 'dart:convert';

StockModel stockModelFromJson(String str) => StockModel.fromJson(json.decode(str));

String stockModelToJson(StockModel data) => json.encode(data.toJson());

class StockModel {
  StockModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
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
    this.staticstics,
    this.categories,
    this.products,
    this.stores,
  });

  List<Staticstic>? staticstics;
  List<Category>? categories;
  List<Product>? products;
  List<Category>? stores;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    staticstics: List<Staticstic>.from(json["staticstics"].map((x) => Staticstic.fromJson(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    stores: List<Category>.from(json["stores"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "staticstics": List<dynamic>.from(staticstics!.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "stores": List<dynamic>.from(stores!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.title,
    this.image,
    this.count,
  });

  int? id;
  String? title;
  String? image;
  String? count;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["name"],
    image: json["avatar"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": title,
    "avatar": image,
    "count": count,
  };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

class Staticstic {
  Staticstic({
    this.count,
    this.text,
    this.image,
  });

  String? count;
  String? text;
  String? image;

  factory Staticstic.fromJson(Map<String, dynamic> json) => Staticstic(
    count: json["count"].toString(),
    text: json["text"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "text": text,
    "image": image,
  };
}

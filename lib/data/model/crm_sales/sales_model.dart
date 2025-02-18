
import 'dart:convert';

SalesModel salesModelFromJson(String str) => SalesModel.fromJson(json.decode(str));

String salesModelToJson(SalesModel data) => json.encode(data.toJson());

class SalesModel {
  SalesModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
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
    this.charts,
    this.latestSales,
  });

  Staticstics? staticstics;
  Charts? charts;
  List<LatestSale>? latestSales;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    staticstics: Staticstics.fromJson(json["staticstics"]),
    charts: Charts.fromJson(json["charts"]),
    latestSales: List<LatestSale>.from(json["latest_sales"].map((x) => LatestSale.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "staticstics": staticstics?.toJson(),
    "charts": charts?.toJson(),
    "latest_sales": List<dynamic>.from(latestSales!.map((x) => x.toJson())),
  };
}

class Charts {
  Charts({
    this.totalOrder,
    this.newOrder,
    this.delivered,
  });

  int? totalOrder;
  int? newOrder;
  int? delivered;

  factory Charts.fromJson(Map<String, dynamic> json) => Charts(
    totalOrder: json["total_order"],
    newOrder: json["new_order"],
    delivered: json["delivered"],
  );

  Map<String, dynamic> toJson() => {
    "total_order": totalOrder,
    "new_order": newOrder,
    "delivered": delivered,
  };
}

class LatestSale {
  LatestSale({
    this.id,
    this.image,
    this.titile,
    this.user,
    this.payment,
    this.invoiceNumber,
    this.price,
  });

  int? id;
  String? image;
  String? titile;
  String? user;
  String? payment;
  String? invoiceNumber;
  double? price;

  factory LatestSale.fromJson(Map<String, dynamic> json) => LatestSale(
    id: json["id"],
    image: json["image"],
    titile: json["titile"],
    user: json["user"],
    payment: json["payment"],
    invoiceNumber: json["invoice_number"],
    price: json["price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "titile": titile,
    "user": user,
    "payment": payment,
    "invoice_number": invoiceNumber,
    "price": price,
  };
}

class Staticstics {
  Staticstics({
    this.orders,
    this.gross,
    this.pending,
  });

  Gross? orders;
  Gross? gross;
  Gross? pending;

  factory Staticstics.fromJson(Map<String, dynamic> json) => Staticstics(
    orders: Gross.fromJson(json["Orders"]),
    gross: Gross.fromJson(json["Gross"]),
    pending: Gross.fromJson(json["Pending"]),
  );

  Map<String, dynamic> toJson() => {
    "Orders": orders?.toJson(),
    "Gross": gross?.toJson(),
    "Pending": pending?.toJson(),
  };
}

class Gross {
  Gross({
    this.number,
    this.title,
  });

  int? number;
  String? title;

  factory Gross.fromJson(Map<String, dynamic> json) => Gross(
    number: json["number"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "title": title,
  };
}

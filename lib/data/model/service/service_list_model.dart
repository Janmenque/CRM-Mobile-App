
import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) => ServiceListModel.fromJson(json.decode(str));


class ServiceListModel {
  bool? result;
  String? message;
  Data? data;

  ServiceListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );
}

class Datum {
  int? id;
  String? name;
  String? category;
  String? subCategory;
  String? zone;
  String? status;
  List<dynamic>? zones;
  List<dynamic>? priceVarriations;
  String? minBiddingPrice;

  Datum({
    this.id,
    this.name,
    this.category,
    this.subCategory,
    this.zone,
    this.status,
    this.zones,
    this.priceVarriations,
    this.minBiddingPrice,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    subCategory: json["sub_category"],
    zone: json["zone"],
    status: json["status"],
    zones: json["zones"] == null ? [] : List<dynamic>.from(json["zones"]!.map((x) => x)),
    priceVarriations: json["price_varriations"] == null ? [] : List<dynamic>.from(json["price_varriations"]!.map((x) => x)),
    minBiddingPrice: json["min_bidding_price"],
  );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

}

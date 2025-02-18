
import 'dart:convert';

CampaignListModel campaignListModelFromJson(String str) => CampaignListModel.fromJson(json.decode(str));


class CampaignListModel {
  bool? result;
  String? message;
  Data? data;

  CampaignListModel({
    this.result,
    this.message,
    this.data,
  });

  factory CampaignListModel.fromJson(Map<String, dynamic> json) => CampaignListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  List<Campaign>? campaigns;
  Pagination? pagination;

  Data({
    this.campaigns,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    campaigns: json["campaigns"] == null ? [] : List<Campaign>.from(json["campaigns"]!.map((x) => Campaign.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

class Campaign {
  int? id;
  String? name;
  String? discountTitle;
  String? discountType;
  String? zone;
  String? status;

  Campaign({
    this.id,
    this.name,
    this.discountTitle,
    this.discountType,
    this.zone,
    this.status,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
    id: json["id"],
    name: json["name"],
    discountTitle: json["discount_title"],
    discountType: json["discount_type"],
    zone: json["zone"],
    status: json["status"],
  );
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

}

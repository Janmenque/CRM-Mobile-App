
import 'dart:convert';

ClientContractListModel clientContractListModelFromJson(String str) => ClientContractListModel.fromJson(json.decode(str));

class ClientContractListModel {
  bool? result;
  String? message;
  Data? data;

  ClientContractListModel({
    this.result,
    this.message,
    this.data,
  });

  factory ClientContractListModel.fromJson(Map<String, dynamic> json) => ClientContractListModel(
    result: json["result"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  int? currentPage;
  List<ClientContract>? data;
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
    data: json["data"] == null ? [] : List<ClientContract>.from(json["data"]!.map((x) => ClientContract.fromJson(x))),
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

class ClientContract {
  int? id;
  String? clientName;
  String? subject;
  String? contractType;
  String? amount;
  String? startDate;
  String? endDate;

  ClientContract({
    this.id,
    this.clientName,
    this.subject,
    this.contractType,
    this.amount,
    this.startDate,
    this.endDate,
  });

  factory ClientContract.fromJson(Map<String, dynamic> json) => ClientContract(
    id: json["id"],
    clientName: json["client_name"],
    subject: json["subject"],
    contractType: json["contract_type"],
    amount: json["amount"],
    startDate: json["start_date"],
    endDate: json["end_date"],
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

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

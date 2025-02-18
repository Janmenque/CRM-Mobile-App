class ExpenseClaimModel {
  ExpenseClaimModel({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  Data? data;

  factory ExpenseClaimModel.fromJson(Map<String, dynamic> json) => ExpenseClaimModel(
    result: json["result"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.data,
    this.links,
    this.pagination,
  });

  List<Datum>? data;
  Links? links;
  Pagination? pagination;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    pagination: Pagination.fromJson(json["pagination"]),
  );
}

class Datum {
  Datum({
    this.id,
    this.invoiceNumber,
    this.claimDate,
    this.remarks,
    this.payableAmount,
    this.dueAmount,
    this.attachmentFileId,
    this.statusId,
  });

  int? id;
  String? invoiceNumber;
  String? claimDate;
  String? remarks;
  dynamic payableAmount;
  dynamic dueAmount;
  String? attachmentFileId;
  String? statusId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    invoiceNumber: json["invoice_number"],
    claimDate: json["claim_date"],
    remarks: json["remarks"],
    payableAmount: json["payable_amount"],
    dueAmount: json["due_amount"],
    attachmentFileId: json["attachment_file_id"],
    statusId: json["status_id"],
  );
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );
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
}

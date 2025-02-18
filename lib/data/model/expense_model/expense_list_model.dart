class ExpenseListModel {
  bool? result;
  String? message;
  ExpenseListDataModel? data;

  ExpenseListModel({this.result, this.message, this.data});

  factory ExpenseListModel.fromJson(Map<String, dynamic> json) =>
      ExpenseListModel(
        result: json['result'],
        message: json['message'],
        data: ExpenseListDataModel.fromJson(json['data']),
      );
}

class ExpenseListDataModel {
  String? totalAmount;
  ExpenseList? expenseList;

  ExpenseListDataModel({this.totalAmount, this.expenseList});

  factory ExpenseListDataModel.fromJson(Map<String, dynamic> json) =>
      ExpenseListDataModel(
          totalAmount: json['total_amount'],
          expenseList: ExpenseList.fromJson(json['expense_list']));
}

class ExpenseList {
  List<DataM>? dataM;
  Pagination? pagination;

  ExpenseList({this.dataM, this.pagination});

  factory ExpenseList.fromJson(Map<String, dynamic> json) => ExpenseList(
      dataM: json['data'] != null
          ? List<DataM>.from(json['data'].map((x) => DataM.fromJson(x)))
          : null,
      pagination: Pagination.fromJson(json['pagination']));
}

class DataM {
  int? id;
  String? category;
  String? remarks;
  String? amount;

  DataM({this.id, this.category, this.remarks, this.amount});

  factory DataM.fromJson(Map<String, dynamic> json) => DataM(
        id: json['id'],
        category: json['category'],
        remarks: json['remarks'],
        amount: json['amount'],
      );
}

class Pagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Pagination(
      {this.total,
      this.count,
      this.perPage,
      this.currentPage,
      this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
      total: json['total'],
      count: json['count'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      totalPages: json['total_page']);
}

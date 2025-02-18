class ExpenseListDetailsModel {
  bool? result;
  String? message;
  ExpenseListDetailsData? data;

  ExpenseListDetailsModel({this.result, this.message, this.data});

  factory ExpenseListDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExpenseListDetailsModel(
          result: json['result'],
          message: json['message'],
          data: ExpenseListDetailsData.fromJson(json['data']));
}

class ExpenseListDetailsData {
  String? month;
  String? date;
  String? category;
  dynamic amount;
  String? remarks;
  String? attachmentFile;

  ExpenseListDetailsData(
      {this.month,
      this.date,
      this.category,
      this.amount,
      this.remarks,
      this.attachmentFile});

  factory ExpenseListDetailsData.fromJson(Map<String, dynamic> json) =>
      ExpenseListDetailsData(
          month: json['month'],
          date: json['date'],
          category: json['category'],
          amount: json['amount'],
          remarks: json['remarks'],
          attachmentFile: json['attachment_file']);
}

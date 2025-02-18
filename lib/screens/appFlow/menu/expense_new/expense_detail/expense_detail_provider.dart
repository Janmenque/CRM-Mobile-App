import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/expense_model/response_expense_detail.dart';
import 'package:hrm_app/data/server/respository/expense_repository.dart';

class ExpenseDetailProvider extends ChangeNotifier {
  ResponseExpenseDetail? responseExpenseDetail;

  ExpenseDetailProvider(int? expenseId) {
    expenseDetail(expenseId);
  }

  /// Create expense:-----------------
  Future expenseDetail(int? expenseId) async {
    final response = await ExpenseRepository.expenseDetailApi(expenseId);
    if (response.result == true) {
      responseExpenseDetail = response.data;
      notifyListeners();
    }
  }
}

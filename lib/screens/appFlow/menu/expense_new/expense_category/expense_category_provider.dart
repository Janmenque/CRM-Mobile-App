import 'package:flutter/cupertino.dart';
import '../../../../../data/model/expense_model/expense_category_model.dart';
import '../../../../../data/server/respository/expense_repository.dart';

class ExpenseCategoryProvider extends ChangeNotifier {

  ExpenseCategoryModel? expenseCategory;
  Category? selectCategoryData;
  bool isLoading = false;

  ExpenseCategoryProvider(){
    getExpenseCategory();
  }


  Future getExpenseCategory() async {
    selectCategoryData?.id = null;
    isLoading = true;
    final response = await ExpenseRepository.getExpenseCategory();
    expenseCategory = response;
    isLoading = false;
    notifyListeners();
  }


  selectCategory(Category val) {
    selectCategoryData = val;
    notifyListeners();
  }
}
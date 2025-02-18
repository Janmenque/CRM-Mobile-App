import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_stocks/stock_category_model.dart';
import 'package:hrm_app/data/server/respository/crm_stocks_repository/stock_repository.dart';

class StockCategoryProvider extends ChangeNotifier{
  StockCategoryModel? categoryData;
   Timer? timeHandle;
String search = "";

  StockCategoryProvider(){
    getCategoryData(search);
  }


   void getSearchValue(String? searchCode){
   search = searchCode ?? "";
    if(timeHandle != null){
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), (){
      getCategoryData(search);
      notifyListeners();
    }
    );
  }


  ///get crm home screen data
  getCategoryData(String? search) async {
    final response = await CRMStockRepository.getStockCategoryData(repoSearch: search);
    if (response.httpCode == 200) {
      categoryData = response.data;
    }
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/stock_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class StockListProvider extends ChangeNotifier{

  StockManagementListModel? stockManagementListResponse;

  bool isLoading = false;

  StockListProvider(){
    getStockList();
  }


  getStockList() async {
    isLoading = true;
    final response = await CRMSalesRepository.getSalesStockListData();
    if(response.result == true){
      stockManagementListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

}
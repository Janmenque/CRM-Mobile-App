
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/sale_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class SaleListProvider extends ChangeNotifier{

  SaleListModel? saleListResponse;

  bool isLoading = false;

  SaleListProvider(){
    getSaleList();
  }


  getSaleList() async {
    isLoading = true;
    final response = await CRMSalesRepository.getSaleListData();
    if(response.result == true){
      saleListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

}
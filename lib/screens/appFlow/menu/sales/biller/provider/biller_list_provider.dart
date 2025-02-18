
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/biller_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class BillerListProvider extends ChangeNotifier{

  BillerListModel? billerListResponse;

  bool isLoading = false;

  BillerListProvider(){
    getBillerList();
  }


  getBillerList() async {
    isLoading = true;
    final response = await CRMSalesRepository.getBillerListData();
    if(response.result == true){
      billerListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

}
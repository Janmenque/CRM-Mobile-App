
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/customer_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class CustomerListProvider extends ChangeNotifier{

  CustomerListModel? customerListResponse;
  bool isLoading  = false;

  CustomerListProvider(){
    getCustomerList();
  }


  getCustomerList() async {
    isLoading = true;
    final response = await CRMSalesRepository.getCustomerListData();
    if(response.result == true){
      customerListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

}
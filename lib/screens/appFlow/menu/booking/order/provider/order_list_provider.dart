
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/customer_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class OrderListProvider extends ChangeNotifier{

  CustomerListModel? orderListResponse;


  OrderListProvider(){
    getCustomerList();
  }



  getCustomerList() async {
    final response = await CRMSalesRepository.getCustomerListData();
    if(response.result == true){
      orderListResponse = response.data;
    }
    notifyListeners();
  }

}
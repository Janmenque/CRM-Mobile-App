
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/purchase_list_model.dart';
import 'package:hrm_app/data/model/crm_sales/quotation_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class QuotationListProvider extends ChangeNotifier{

  QuotationListModel? quotationListResponse;

  bool isLoading = false;

  QuotationListProvider(){
    getPurchaseList();
  }


  getPurchaseList() async {
    isLoading = true;
    final response = await CRMSalesRepository.getQuotationListData();
    if(response.result == true){
      isLoading = false;
      quotationListResponse = response.data;
    }
    notifyListeners();
  }

}
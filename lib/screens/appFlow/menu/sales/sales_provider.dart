import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/sales_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class SalesProvider extends ChangeNotifier {
  SalesModel? salesModel;

  SalesProvider(){
    getSalesData();
  }

  getSalesData() async {
    final response = await CRMSalesRepository.getCrmSalesData();
    if (response.httpCode == 200) {
      salesModel = response.data;
      notifyListeners();
    }
    notifyListeners();
  }

}
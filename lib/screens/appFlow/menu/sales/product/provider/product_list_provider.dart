import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/product_llist_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';


class ProductListProvider extends ChangeNotifier {

  ProductListModel? productListResponse;
  bool isLoading = false;



  ProductListProvider(){
  getProductList();
}


///sales product list method
  getProductList() async {
    isLoading = true;
    final response = await CRMSalesRepository.getSalesProductListData();
    if(response.result == true){
      productListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
  }


}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_sales/add_product_all_dropdown_model.dart';
import 'package:hrm_app/data/model/crm_sales/warehouse_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/stock_management/provider/stock_list_provider.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:provider/provider.dart';

class AddStockProvider extends ChangeNotifier {

  AddProductAllDropdownModel? addProductAllDropdownResponse;

  WareHouseListModel? wareHouseListResponse;
  Warehouse? warehouse;

  List<String> typeList = ["Full", "Partial"];
  String? type;

  List<ProductCategory> selectedCategories = [];

  List<Brand> selectedBrands = [];



  AddStockProvider(){
    getAllDropDownData();
    getWarehouseList();
  }


  ///add product all dropdown
  getAllDropDownData() async {
    final response = await CRMSalesRepository.getAddProductAllDropdownData();
    if(response.result == true){
      addProductAllDropdownResponse = response.data;
    }
    notifyListeners();
  }

  ///warehouse list
  getWarehouseList() async {
    final response = await CRMSalesRepository.getWarehouseListData();
    if(response.result == true){
      wareHouseListResponse = response.data;
    }
    notifyListeners();
  }

  selectWarehouse(Warehouse warehouseValue){
    warehouse = warehouseValue;
    notifyListeners();
  }


  selectType(String selectTypeValue){
    type = selectTypeValue;
    notifyListeners();
  }


  void toggleCategory(ProductCategory category) {
    if (selectedCategories.any((element) => element.id == category.id)) {
      selectedCategories.removeWhere((element) => element.id == category.id);
    } else {
      selectedCategories.add(category);
    }
    notifyListeners();
  }


  void toggleBrand(Brand brand) {
    if (selectedBrands.any((element) => element.id == brand.id)) {
      selectedBrands.removeWhere((element) => element.id == brand.id);
    } else {
      selectedBrands.add(brand);
    }
    notifyListeners();
  }


  void clearSelection() {
    selectedCategories.clear();
    selectedBrands.clear();
    notifyListeners();
  }


  Future addStock(context) async {
    final data = FormData.fromMap({
      "warehouse_id": warehouse?.id,
      "type": type,
      "category_id": selectedCategories.isNotEmpty ? selectedCategories.map((category) => category.id).toList() : null,
      "brand_id": selectedBrands.isNotEmpty ? selectedBrands.map((brand) => brand.id).toList() : null
    });
    final response = await CRMSalesRepository.postAddStock(data);

    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Provider.of<StockListProvider>(context, listen: false).getStockList();
      Navigator.pop(context);
      notifyListeners();
    } else if(response.httpCode == 422){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    } else if(response.httpCode == 400){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    }
    else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
    }



    if (response['result'] == true) {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
      NavUtil.replaceScreen(context, const ButtomNavigationBar());
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
    }
  }


}
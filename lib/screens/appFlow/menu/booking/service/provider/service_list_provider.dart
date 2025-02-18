import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/service/service_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class ServiceListProvider extends ChangeNotifier{

  ServiceListModel? serviceListResponse;

  final variantNameController = TextEditingController();
  final variantPriceController = TextEditingController();

  ServiceListProvider(){
    getServiceList();
  }


  getServiceList() async {
    final response = await CRMSalesRepository.getServiceListData();
    if(response.result == true){
      serviceListResponse = response.data;
    }
    notifyListeners();
  }


  ///Add variant method
  Future createVariant(context, int serviceId) async {
    final data = FormData.fromMap({
      "service_id" : serviceId,
      "varriant_name": variantNameController.text,
      "varriant_price": variantPriceController.text,
    });

    final response = await CRMSalesRepository.postCreateVariant(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response.message}');
      Navigator.pop(context);
      Navigator.pop(context);
      variantNameController.clear();
      variantPriceController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}');
    }
  }

}
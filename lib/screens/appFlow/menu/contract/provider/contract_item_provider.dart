import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_contract/contract_item_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/crm_create_contract_component.dart';
import 'package:hrm_app/data/server/respository/crm_contract_repository/crm_contract_repository.dart';

class ContractItemProvider extends ChangeNotifier{

  ContractItemListModel? contractItemListResponse;

  CrmCreateContractComponent? crmCreateContractComponentResponse;

  List<ContractComponent> selectedServices = [];

  ContractItemProvider(int contractId){
    getContractItemList(contractId);
    getCrmCreateAllComponent();
  }


  void toggleService(ContractComponent service) {
    if (selectedServices.any((element) => element.id == service.id)) {
      selectedServices.removeWhere((element) => element.id == service.id);
    } else {
      selectedServices.add(service);
    }
    notifyListeners();
  }




  getContractItemList(int contractId)async{
    final response = await CrmContractRepository.getContractItemListData(contractId);
    if(response.result == true){
      contractItemListResponse = response.data;
      notifyListeners();
    } else{
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }


  ////getCrmCreateAllComponent
  getCrmCreateAllComponent() async {
    final response = await CrmContractRepository.getContractAllComponentListData();
    if(response.result == true){
      crmCreateContractComponentResponse = response.data;
      notifyListeners();

    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
      notifyListeners();
    }
  }


  ///add item
  Future addItem(context, int contractId) async {
    final data = FormData.fromMap({
      "contract_id" : contractId,
      "service_ids[]": selectedServices.isNotEmpty ? selectedServices.map((service) => service.id).toList() : null,
    });
    final response = await CrmContractRepository.postAddItem(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      getContractItemList(contractId);
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
  }

}
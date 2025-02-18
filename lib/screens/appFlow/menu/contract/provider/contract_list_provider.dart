import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_contract/all_contract_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/crm_create_contract_component.dart';
import 'package:hrm_app/data/server/respository/crm_contract_repository/crm_contract_repository.dart';

class ContractListProvider extends ChangeNotifier{

  AllContractListModel? contractListResponse;
  CrmCreateContractComponent? crmCreateContractComponentResponse;

  final contractTypeNameController = TextEditingController();

  ContractListProvider(){
    getAllContractList();
    getContractTypeList();
  }

  /// get all contract list
  getAllContractList() async {
    final response = await CrmContractRepository.getAllContractListData();
    if(response.result == true){
      contractListResponse = response.data;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
      notifyListeners();
    }
  }


  ///get contract type list
  getContractTypeList() async {
    final response = await CrmContractRepository.getContractAllComponentListData();
    if(response.result == true){
      crmCreateContractComponentResponse = response.data;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
      notifyListeners();
    }
  }


  ///add contract type
  Future addContractType(context) async {
    final data  = FormData.fromMap({
      "name" : contractTypeNameController.text
    });
    final response = await CrmContractRepository.postAddContractType(data);

    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      contractTypeNameController.clear();
      Navigator.of(context).pop();
      getContractTypeList();
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
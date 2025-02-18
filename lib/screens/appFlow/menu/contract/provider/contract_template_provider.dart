import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_contract/contract_template_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/crm_create_contract_component.dart';
import 'package:hrm_app/data/server/respository/crm_contract_repository/crm_contract_repository.dart';


class ContractTemplateProvider extends ChangeNotifier{

  ContractTemplateListModel? contractTemplateListResponse;

  CrmCreateContractComponent? crmCreateContractComponentResponse;
  ContractComponent? client;

  List<String> statusList = ['Active', 'Inactive'];
  String? status;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  ContractTemplateProvider(int contractId){
    getContractTemplateList(contractId);
    getCrmCreateAllComponent();
  }



  selectStatus(String statusValue){
    status = statusValue;
    notifyListeners();
  }



  selectClient(ContractComponent clientValue){
    client = clientValue;
    notifyListeners();
  }



  getContractTemplateList(int contractId)async{
    final response = await CrmContractRepository.getContractTemplateListData(contractId);
    if(response.result == true){
      contractTemplateListResponse = response.data;
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


  ///add contract template
  Future addContractTemplate(context, int contractId) async {
    final data = FormData.fromMap({
      "contract_id": contractId,
      "title": titleController.text,
      "content": contentController.text,
      "client_id": client?.id,
      "status": status == "Active" ? 1 : 4
    });
    final response = await CrmContractRepository.postAddTemplate(data);

    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Navigator.of(context).pop();
      getContractTemplateList(contractId);
      titleController.clear();
      contentController.clear();
      client = null;
      status = null;
      notifyListeners();
    } else if(response.httpCode == 422){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    } else if(response.httpCode == 400){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    }
    else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
    }
    notifyListeners();
  }

}
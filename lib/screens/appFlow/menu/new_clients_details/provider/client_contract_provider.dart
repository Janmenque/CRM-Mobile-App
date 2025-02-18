import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_client_model/client_contract_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';

class ClientContractProvider extends ChangeNotifier{

  ClientContractListModel? clientContractListResponse;
  bool isLoading = false;


  ClientContractProvider(int clientId){
    getClientContractList(clientId);
  }


  ///get client contract list
  getClientContractList(int clientId) async {
    isLoading = true;
    final response = await CrmClientRepository.getClientContractListData(clientId);
    if(response.result == true) {
      clientContractListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

}
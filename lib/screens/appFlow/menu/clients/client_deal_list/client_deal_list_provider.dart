import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/deal_list_model.dart';

class ClientDealListProvider extends ChangeNotifier{

  DealListModel? dealListResponse;
  String? search = "";
  Timer? timeHandle;
  int? clientId;

 ClientDealListProvider(int? id){
  clientId = id;
  getClientDealListData(id, search);
 }
 
  

 void getSearchValue(String searchCode){
  search = searchCode;
 
  if(timeHandle != null){
    timeHandle!.cancel();
  }
  timeHandle = Timer(const Duration(seconds: 1), (){
    getClientDealListData( clientId , search);
  });
 }


getClientDealListData(int? id, String? search)async{

  final response = await CrmClientRepository.getClientDealList(id: id, search : search);
  if(response.httpCode == 200){
    dealListResponse = response.data;
    notifyListeners();
  }

}


}
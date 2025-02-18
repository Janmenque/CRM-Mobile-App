import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_client_model/client_profile_details_model.dart';
import 'package:hrm_app/data/model/crm_sales/add_biller_country_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/utils/res.dart';

class ClientProfileProvider extends ChangeNotifier{

  ClientProfileDetailsModel? clientProfileDetailsResponse;

  CountryListModel? countryListResponse;
  Country? clientCountry;

  bool isLoading = false;

  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();


  ClientProfileProvider(int clientId){
    getClientProfileDetails(clientId);
    getClientCountryList();
  }



  getClientProfileDetails(int clientId) async {
    isLoading = true;
    final response = await CrmClientRepository.getClientProfileDetailsData(clientId);
    if(response.result == true){
      isLoading = false;
      clientProfileDetailsResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }


  selectClientCountry(Country? clientCountryValue){
    clientCountry = clientCountryValue;
    notifyListeners();
  }



  getClientCountryList() async {
    final response = await CRMSalesRepository.getCountryListData();
    if(response.result == true){
      countryListResponse = response.data;
      notifyListeners();
    }
  }



  Future createAddressType(context, int clientId, String addressType) async {
    final data = FormData.fromMap({
      "client_id" : clientId,
      "type"      : addressType == "Billing" ? "billing_address" : "shipping_address",
      "street"    : streetController.text,
      "city"      : cityController.text,
      "state"     : stateController.text,
      "zip"       : zipController.text,
      "country_id": clientCountry?.id ?? 0,
    });
    final response = await CrmClientRepository.createClientAddressType(data);
    if(response["result"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getClientProfileDetails(clientId);
      clearTextField();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }


  clearTextField(){
    streetController.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();
  }


}
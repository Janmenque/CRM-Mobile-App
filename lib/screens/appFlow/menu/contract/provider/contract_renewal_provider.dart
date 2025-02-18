import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_contract/contract_renewal_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_contract_repository/crm_contract_repository.dart';


class ContractRenewalProvider extends ChangeNotifier{

  ContractRenewalsListModel? contractRenewalsListResponse;

  final valueController = TextEditingController();

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  ContractRenewalProvider(int contractId){
    getContractRenewalList(contractId);
  }


  getContractRenewalList(int contractId)async{
    final response = await CrmContractRepository.getContractRenewalListData(contractId);
    if(response.result == true){
      contractRenewalsListResponse = response.data;
      notifyListeners();
    } else{
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }


  ////Select Start date
  Future selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    );
    if (pickedDate != null) {
      selectedStartDate = pickedDate;
      startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate!);
      notifyListeners();
    }
  }


  ///select end date
  Future selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: selectedStartDate!,
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedStartDate!,
      locale: const Locale("en"),
    );
    if (pickedDate != null) {
      selectedEndDate = pickedDate;
      endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate!);
      notifyListeners();
    }
  }



  ///add contract comment
  Future addContractRenewal(context, int contractId) async {
    final data = FormData.fromMap({
      "start_date": startDate,
      "end_date": endDate,
      "contract_value": valueController.text,
      "contract_id": contractId,
    });
    final response = await CrmContractRepository.postAddRenewal(data);

    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Navigator.of(context).pop();
      getContractRenewalList(contractId);
      valueController.clear();
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
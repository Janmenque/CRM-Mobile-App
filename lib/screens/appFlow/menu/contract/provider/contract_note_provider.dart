import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_contract/contract_note_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_contract_repository/crm_contract_repository.dart';


class ContractNoteProvider extends ChangeNotifier{

  ContractNoteListModel? contractNoteListResponse;

  final noteController = TextEditingController();

  ContractNoteProvider(int contractId){
    getContractNoteList(contractId);
  }


  getContractNoteList(int contractId)async{
    final response = await CrmContractRepository.getContractNoteListData(contractId);
    if(response.result == true){
      contractNoteListResponse = response.data;
      notifyListeners();
    } else{
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }



  ///add contract note
  Future addContractNote(context, int contractId) async {
    final data = FormData.fromMap({
      "contract_id": contractId,
      "note": noteController.text,
    });
    final response = await CrmContractRepository.postAddNote(data);

    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Navigator.of(context).pop();
      getContractNoteList(contractId);
      noteController.clear();
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
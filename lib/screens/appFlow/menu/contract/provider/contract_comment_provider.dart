import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_contract/contract_comment_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_contract_repository/crm_contract_repository.dart';


class ContractCommentProvider extends ChangeNotifier{

  ContractCommentListModel? contractCommentListResponse;

  final messageController = TextEditingController();

  ContractCommentProvider(int contractId){
    getContractCommentList(contractId);
  }


  getContractCommentList(int contractId)async{
    final response = await CrmContractRepository.getContractCommentListData(contractId);
    if(response.result == true){
      contractCommentListResponse = response.data;
      notifyListeners();
    } else{
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }


  ///add contract comment
  Future addContractComment(context, int contractId) async {
    final data = FormData.fromMap({
      "message": messageController.text,
      "contract_id": contractId,
    });
    final response = await CrmContractRepository.postAddComment(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      Navigator.of(context).pop();
      getContractCommentList(contractId);
      messageController.clear();
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
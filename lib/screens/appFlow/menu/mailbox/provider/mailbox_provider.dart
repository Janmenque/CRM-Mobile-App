
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/mailbox/mailbox_list_model.dart';
import 'package:hrm_app/data/server/respository/crm_mailbox_repository/crm_mailbox_repository.dart';

class MailBoxProvider extends ChangeNotifier{

  MailInboxListModel? mailInboxListResponse;

  MailBoxProvider(String status){
    getMailBoxList(status);
  }

  getMailBoxList(String status) async {
    final response = await CrmMailboxRepository.getMailboxListData(status);
    if(response.result == true){
      mailInboxListResponse = response.data;
    }
    notifyListeners();
  }



  Future updateStatus(context, String status, List<int> mailboxId, String actionType, int actionValue) async {

    final Map<String, dynamic> data = {
      "mailbox_ids": mailboxId,
      "action_type": actionType,
      "action_value": actionValue,
    };

    final response = await CrmMailboxRepository.updateStatus(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      getMailBoxList(status);
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



  Future moveToTrash(context, String status, List<int> mailboxId,) async {

    final Map<String, dynamic> data = {
      "mailbox_ids": mailboxId,
    };

    final response = await CrmMailboxRepository.moveToTrash(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
      getMailBoxList(status);
      notifyListeners();
    } else if(response.httpCode == 422){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message);
    }
    else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: 'Something went wrong');
    }
    notifyListeners();

  }

}
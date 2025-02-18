import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_client_model/client_note_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/utils/res.dart';

class ClientNoteProvider extends ChangeNotifier{

  ClientNoteListModel? clientNoteListResponse;
  List<ClientNote> clientNoteList = [];
  final noteController = TextEditingController();
  bool isLoading = false;

  ClientNoteProvider(int clientId){
    getClientNoteList(clientId);
  }




  // Method to reorder the notes
  void reorderNotes(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1; // Adjust index if moved down
    final item = clientNoteList.removeAt(oldIndex);
    clientNoteList.insert(newIndex, item);
    notifyListeners();
  }


  ///get note list
  getClientNoteList(int clientId) async {
    isLoading = true;
    final response = await CrmClientRepository.getClientNoteListData(clientId);
    if(response.result == true){
      isLoading = false;
      clientNoteListResponse = response.data;
      clientNoteList = clientNoteListResponse?.data?.data ?? [];
      isLoading = false;
      notifyListeners();
    } else {
      clientNoteList = [];
    }
    notifyListeners();
  }



  ///create note
  Future createClientNote(context, int clientId) async {
    final data = FormData.fromMap({
      "client_id" : clientId,
      "description" : noteController.text
    });
    final response = await CrmClientRepository.createClientNote(data);
    if(response["result"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getClientNoteList(clientId);
      noteController.clear();
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



  ///delete note
  Future removeClientNote(context, int clientId, int noteId) async {
    final response = await CrmClientRepository.removeClientNote(noteId);
    if(response["result"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      getClientNoteList(clientId);
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }
}
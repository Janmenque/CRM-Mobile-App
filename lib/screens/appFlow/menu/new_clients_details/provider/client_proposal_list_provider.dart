import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/client_proposal/client_proposal_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/event/proposal_events.dart';
import 'package:hrm_app/utils/event_bus.dart';

class ClientProposalListProvider extends ChangeNotifier{

  ClientProposalListModel? clientProposalListResponse;

  bool isLoading = false;


  ClientProposalListProvider(int clientId){
    getClientProposalList(clientId);
    eventBus.on<ProposalCreatedEvent>().listen((event) {
      if (event.clientId == clientId) {
        getClientProposalList(event.clientId);
      }
    });
  }


  getClientProposalList(int clientId)async{
    isLoading = true;
    final response = await CrmClientRepository.getClientProposalListData(clientId);
    if(response.result == true){
      clientProposalListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }




  // Split the date and time
  DateTime parseCustomDate(String date) {
    try {
      List<String> parts = date.split(' ');
      String datePart = parts[0];
      String timePart = parts[1];
      List<String> dateComponents = datePart.split('-');
      String formattedDate = "${dateComponents[2]}-${dateComponents[1]}-${dateComponents[0]}T$timePart";
      return DateTime.parse(formattedDate);
    } catch (e) {
      if (kDebugMode) {
        print("Error parsing date: $e");
      }
      return DateTime.now();
    }
  }


  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatTime(DateTime date) {
    return DateFormat('hh:mma').format(date);
  }



  // Utility function to convert hex string to Color
  Color hexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse("0x$hexColor"));
  }

}
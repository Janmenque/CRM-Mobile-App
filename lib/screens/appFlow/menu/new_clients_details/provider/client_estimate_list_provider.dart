import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/client_estimate/client_estimate_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/event/estimate_events.dart';
import 'package:hrm_app/utils/event_bus.dart';

class ClientEstimateListProvider extends ChangeNotifier{

  ClientEstimateListModel? clientEstimateListResponse;

  bool isLoading = false;

  ClientEstimateListProvider(int clientId){
    getClientEstimateList(clientId);
    eventBus.on<EstimateCreatedEvent>().listen((event) {
      if (event.clientId == clientId) {
        getClientEstimateList(event.clientId);
      }
    });
  }


  getClientEstimateList(int clientId)async{
    isLoading = true;
    final response = await CrmClientRepository.getClientEstimateListData(clientId);
    if(response.result == true){
      clientEstimateListResponse = response.data;
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

  ///date format
  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  ///time format
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
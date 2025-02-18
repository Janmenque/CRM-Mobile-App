
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/crm_sales/adjustment_model.dart';
import 'package:hrm_app/data/server/respository/crm_sales_repository/crm_sales_repository.dart';

class AdjustmentListProvider extends ChangeNotifier{

  AdjustmentModel? adjustmentResponse;

  bool isLoading = false;

  AdjustmentListProvider(){
    getAdjustmentList();
  }


  getAdjustmentList() async {
    isLoading = true;
    final response = await CRMSalesRepository.getSalesAdjustmentData();
    if(response.result == true){
      adjustmentResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
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
      print("Error parsing date: $e");
      return DateTime.now();
    }
  }


  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatTime(DateTime date) {
    return DateFormat('hh:mma').format(date);
  }




}
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/client_project_list_model.dart';
import 'package:hrm_app/data/model/home/crm_home_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/muti_select_employee.dart';
import 'package:hrm_app/utils/res.dart';

class ClientProjectProvider extends ChangeNotifier{

  ClientProjectListModel? clientProjectListResponse;

  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();

  bool isLoading = false;

  Members? allUserData;

  List<int> userIds = [];
  List<String> userNames = [];
  HashSet<Members> selectedItem = HashSet();

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  ClientProjectProvider(int clientId){
    getClientProjectList(clientId);
  }


  getClientProjectList(int clientId) async {
    isLoading = true;
    final response = await CrmClientRepository.getClientProjectListData(clientId);
    if(response.result == true){
      clientProjectListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }



  ///create client project
  Future createClientProject(context, int clientId) async {
    final data = FormData.fromMap({
      "name": projectNameController.text,
      "description": projectDescriptionController.text,
      "start_date": startDate,
      "end_date": endDate,
      "client": clientId,
      "membars": userIds.join(',')
    });

    final response = await CrmClientRepository.createClientProject(data);
    if(response["result"] == true){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getClientProjectList(clientId);
      projectNameController.clear();
      projectDescriptionController.clear();
      userIds = [];
      startDate = "Start Date";
      endDate = "End Date";
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: '${response['message']}', backgroundColor: AppColors.primaryColor);
    }
    notifyListeners();
  }



  ///Start date selection method
  Future selectStartDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedStartDate = date;
        startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate!);
        notifyListeners();
      }
    });
  }

  ///End date selection method
  Future selectEndDate(BuildContext context) async {
    showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
    ).then((date) {
      if (date != null) {
        selectedEndDate = date;
        endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate!);
        notifyListeners();
      }
    });
  }


  void clearList(){
    selectedItem.clear();
    userIds.clear();
    userNames.clear();
  }





  ///user
  void getAllUserData(BuildContext context,{clearCache = true}) async {

    if(clearCache){
      clearList();
    }
    selectedItem = await Navigator.push(context, MaterialPageRoute(builder: (context) => const MultiSelectEmployee()));
    for (var element in selectedItem) {
      if(!userIds.contains(element.id)){
        userIds.add(element.id!);
        userNames.add(element.name!);
      }
    }
    notifyListeners();
  }

}
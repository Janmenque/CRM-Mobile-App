
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/timesheet/resource_plan_list_model.dart';
import 'package:hrm_app/data/server/respository/timesheet_repository/timesheet_repository.dart';

class ResourcePlanProvider extends ChangeNotifier {

  ResourcePlanListModel? resourcePlanListResponse;

  bool isLoading = false;


  ResourcePlanProvider(){
    getTimesheetResourcePlan();
  }



  ///get timesheet Resource Plan data
    getTimesheetResourcePlan() async {
    isLoading = true;
    final response = await CrmTimesheetRepository.getTimesheetResourcePlan();
    isLoading = false;
    if (response.httpCode == 200) {
      resourcePlanListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }

}
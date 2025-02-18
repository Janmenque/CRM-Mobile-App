import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_project/project_milestonelist_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/utils/res.dart';

class ProjectMilestoneProvider extends ChangeNotifier{

  ProjectMilestoneListModel? projectMilestoneListResponse;

  final milestoneNameController = TextEditingController();
  final milestoneNoteController = TextEditingController();

  bool isLoading = false;

  String? startDate;
  DateTime? selectedStartDate;

  String? endDate;
  DateTime? selectedEndDate;

  List<String> statusList = ["Active", "Inactive"];
  String? status;

  ProjectMilestoneProvider(int projectId){
    getProjectMilestoneList(projectId);
  }


  selectStatus(String statusValue) {
    status = statusValue;
    notifyListeners();
  }


  ///project milestone list
  getProjectMilestoneList(int projectId) async {
    isLoading = true;
    final response = await CrmProjectRepository.getProjectMilestoneList(projectId);
    if(response.result == true){
      projectMilestoneListResponse = response.data;
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }



  ///create project milestone
  Future createProjectMilestone(context, int projectId) async {
    final data = FormData.fromMap({
      "project_id"  : projectId ?? 0,
      "name"        : milestoneNameController.text,
      "start_date"  : startDate,
      "end_date"    : endDate,
      "status_id"   : status == "Active" ? 1 : 0,
      "note"        : milestoneNoteController.text
    });

    final response = await CrmProjectRepository.createProjectMilestone(data);
    if(response.httpCode == 200){
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message , backgroundColor: AppColors.primaryColor);
      Navigator.of(context).pop();
      getProjectMilestoneList(projectId);
      milestoneNameController.clear();
      milestoneNoteController.clear();
      startDate = "Start Date";
      endDate = "End Date";
      notifyListeners();
    } else {
      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, msg: response.message, backgroundColor: AppColors.primaryColor);
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


  /// Split start date and time
  DateTime parseCustomStartDate(String date) {
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


  String formatStartDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatStartTime(DateTime date) {
    return DateFormat('hh:mma').format(date);
  }



  DateTime parseCustomEndDate(String date) {
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


  String formatEndDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatEndTime(DateTime date) {
    return DateFormat('hh:mma').format(date);
  }

}
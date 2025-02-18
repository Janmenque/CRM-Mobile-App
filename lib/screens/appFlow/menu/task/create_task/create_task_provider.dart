import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/muti_select_employee.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/create_task_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../data/model/home/crm_home_model.dart';
import '../../../../../utils/nav_utail.dart';

class CrmCreateTaskProvider extends ChangeNotifier {
  final clinetController = TextEditingController();
  final projectController = TextEditingController();
  final tiitleController = TextEditingController();
  final projectDescriptiionController = TextEditingController();
  final memberController = TextEditingController();
  final priorityController = TextEditingController();

  DateTimeRange dateRange =
  DateTimeRange(start: DateTime(2022, 10, 10), end: DateTime(2022, 11, 10));
 
  CreateTaskModel? crmCreateTaskdataResponse;
  List<Project>? projectList;
  List<Client>? clientList; 
  List<Members>? memberList;
  List<Priority>? priorityList;
  List<MultiSelectItem>? userSelectedList;
  Project? project;
  Members? allMemberData;
  Client? client;
  String? selectedUsers;
  Priority? priority;

    List<int> userIds = [];
  List<String> userNames = [];
   HashSet<Members> selectedItem = HashSet();

  List selectedMembers = [];
  List selectedMembersId = [];

  CrmCreateTaskProvider() {
    getCrmCreateTaskData();
  }


    void clearList(){
    selectedItem.clear();
    userIds.clear();
    userNames.clear();
  }

  ///date time picker
  Future pickDateRange(context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(2021),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  dialogBackgroundColor:
                  Theme.of(context).scaffoldBackgroundColor,
                  appBarTheme: Theme.of(context).appBarTheme.copyWith(
                      iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark)),
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                      onPrimary: Colors.black,
                      primary: AppColors.colorPrimary)),
            child: child!,);
        });

    if (newDateRange == null) return;

    dateRange = newDateRange;
    notifyListeners();
  }

  ///get client dashboard data
  getCrmCreateTaskData() async {
    final response = await CrmTaskRepository.getCrmCreateTaskData();
    if (response.httpCode == 200) {
      crmCreateTaskdataResponse = response.data;
      projectList = response.data?.data?.projects;
      clientList = response.data?.data?.clients;
      priorityList = response.data?.data?.priorities;
      notifyListeners();
    }
    notifyListeners();
  }

  /// dropdownMenu for priority .....
  selectPriority(Priority priorityValue) {
    priority = priorityValue;
    notifyListeners();
  }

  /// dropdownMenu for client type .....
  selectclien(Client clientValue) {
    client = clientValue;
    notifyListeners();
  }

  /// dropdownMenu for project type .....
  selectProject(Project projectValue) {
    project = projectValue;
    notifyListeners();
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

  ///creat task button
  Future createTask(context) async {
    final data = FormData.fromMap({
      "client": client?.id,
      "project": project?.id,
      "name": tiitleController.text,
      "priority": priority?.id,
      "start_date": dateRange.start,
      "end_date": dateRange.end,
      "description": projectDescriptiionController.text,
      "members": userIds.join(',')
    });

    final response = await CrmTaskRepository.addTask(data);

    if (response['result'] == true) {
      Fluttertoast.showToast(msg: "Task created Successfully");
      NavUtil.replaceScreen(context, const ButtomNavigationBar());
      notifyListeners();
    }
  }
}

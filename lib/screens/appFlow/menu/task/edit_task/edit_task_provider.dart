import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/create_task_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_details_model.dart' ;
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import 'package:hrm_app/utils/res.dart';
import '../../../../../data/model/home/crm_home_model.dart';
import '../../../../../utils/nav_utail.dart';
import '../../meeting/muti_select_employee.dart';
import '../task_details/task_details_screen.dart';

class EditTaskProvider extends ChangeNotifier {
  CreateTaskModel? createTaskModel;

  TaskDetailsMembers? allUserData;

  final taskTitleController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  final clientController = TextEditingController();
  List<int> userIds = [];
  List<String> userNames = [];
  HashSet<Members> selectedItem = HashSet();
  String? startDate;
  String? endDate;
  List<Project> projectList = [];
  List<Client> clientList = [];
  List<Priority> priorityList = [];
  ClientDetails? clientDetails;
  ProjectDetails? projectDetails;
  Client? client;
  Priority? priority;
  Project? project;
  DateFormat? dateFormat = DateFormat("yyyy-MM-dd");
  DateTimeRange? dateRange;
  TaskDetailsModel? taskDetailsData;
  

  EditTaskProvider(TaskDetailsModel? taskDetails) {
    if (taskDetails != null) {
      taskDetailsData = taskDetails;
      setControllerData(taskDetails);
      getCrmCreateTaskData();
    }
  }

  /// dropdownMenu for client type .....
  selectClient(Client? clientValue) {
    client = clientValue;
    notifyListeners();
  }

  /// dropdownMenu for project type .....
  selectProject(Project? projectValue) {
    project = projectValue;
    notifyListeners();
  }

  /// dropdownMenu for Priority type .....
  selectPriority(Priority? priorityValue) {
    priority = priorityValue;
    notifyListeners();
  }

  updateTaskData({required BuildContext context,required int taskId, required CrmTaskListProvider taskListProvider }) async {

    final data = FormData.fromMap({
      "id": taskId,
      "client": client?.id,
      "project": project?.id,
      "name": taskTitleController.text,
      "priority": priority?.id,
      "start_date": dateRange?.start,
      "end_date": dateRange?.end,
      "description": projectDescriptionController.text,
      "members": userIds.join(',')
    });


    if (kDebugMode) {
      print({
        "id": taskId,
        "client": client?.id,
        "project": project?.id,
        "name": taskTitleController.text,
        "priority": priority?.id,
        "start_date": dateRange?.start ?? "",
        "end_date": dateRange?.end ?? "",
        "description": projectDescriptionController.text,
        "members": userIds.join(',')
      });
    }

    await CrmTaskRepository.updateTaskData(data).then((data) {
      Fluttertoast.showToast(msg: "Task updated Successfully");
      ///Provider.of<CrmTaskProvider>(context, listen: false).getCrmTaskDashboardData();
      NavUtil.replaceScreen(context,TaskDetailsScreen(taskId: taskId, taskListProvider: taskListProvider));
      notifyListeners();
    });
  }

  getCrmCreateTaskData() async {
    final response = await CrmTaskRepository.getCrmCreateTaskData();
    if (response.httpCode == 200) {
      projectList = response.data?.data?.projects ?? [];
      clientList = response.data?.data?.clients ?? [];
      priorityList = response.data?.data?.priorities ?? [];
      client = taskDetailsData!.data!.clients.isNotEmpty
          ? clientList.firstWhere(
              ((element) => element.id == taskDetailsData?.data?.clients[0].id))
          : clientList.first;
      project = taskDetailsData!.data!.projects.isNotEmpty
          ? projectList.firstWhere(((element) =>
              element.id == taskDetailsData?.data?.projects[0].id))
          : projectList.first;
      priority = taskDetailsData!.data!.priorities.isNotEmpty ? priorityList.firstWhere(((element) => element.id == taskDetailsData?.data?.priorities[0].id)) : priorityList.first;
      notifyListeners();
    }
    notifyListeners();
  }

  void clearList(){
    selectedItem.clear();
    userIds.clear();
    userNames.clear();
  }


  ///date time picker
  Future pickDateRange(context, taskDetails) async {
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
                    iconTheme: IconThemeData(
                        color: Theme.of(context).primaryColorDark)),
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    onPrimary: Colors.black, primary: AppColors.colorPrimary)),
            child: child!,
          );
        });

    if (newDateRange == null) return;
    dateRange = newDateRange;

    notifyListeners();
  }

    setControllerData(TaskDetailsModel taskDetailsData) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    clientController.text = taskDetailsData.data!.clients.isNotEmpty ? taskDetailsData.data?.clients[0].name ?? '' : '';
    taskTitleController.text = taskDetailsData.data?.taskDetails?.title ?? "";
    projectDescriptionController.text = taskDetailsData.data?.taskDetails?.description ?? "";
    startDate = taskDetailsData.data?.taskDetails?.dbStartDate ?? "";
    endDate = (taskDetailsData.data?.taskDetails?.dbEndDate ?? "");
    dateRange = DateTimeRange(start: formatter.parse(startDate??''), end: formatter.parse(endDate??''));
    userNames = taskDetailsData.data?.taskDetailsMembers != null ? taskDetailsData.data!.taskDetailsMembers.map((e) => e.name ?? "").toList() : [];
    userIds = taskDetailsData.data?.taskDetailsMembers != null ? taskDetailsData.data!.taskDetailsMembers.map((e) => e.id ?? 0).toList() : [];
    notifyListeners();
  }


  void getAllUserData(BuildContext context,{clearCache = true}) async {

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

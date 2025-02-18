import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/employee_model/employee_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/crm_clinet_repository/client_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/project_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/muti_select_employee.dart';
import 'package:hrm_app/screens/appFlow/menu/menu.dart';
import 'dart:collection';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/buttom_navigation_bar.dart';
import 'package:hrm_app/utils/res.dart';
import '../../../../../data/model/home/crm_home_model.dart';
import '../../../../../utils/nav_utail.dart';
import '../../clients/model/client_list_model.dart';

class CrmCreateProjectProvider extends ChangeNotifier {
  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();

  Members? allUserData;
  String search = "";

  List<int> userIds = [];
  List<String> userNames = [];
  HashSet<Members> selectedItem = HashSet();
  String? startDate;
  String? endDate;
  DateTimeRange? dateRange ;
  EmployeeListModel? employeeListResponseData;
  List<Employee>? employeeList;
  List<Client>? clientList;
  Client? client;

  CrmCreateProjectProvider({ProjectDetails? details}) {
    getCrmClientListData(search,details: details);
  }

  void initializeController({ProjectDetails? details}){
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    projectNameController.text = details?.name ?? '';
    projectDescriptionController.text = details?.description ?? '';
    client = clientList != null ? clientList!.firstWhere((element) => element.id == details?.client?.id) : null;
    startDate = details?.dbStartDate ?? "";
    endDate = details?.dbEndDate ?? "";
    dateRange = DateTimeRange(start: formatter.parse(startDate??''), end: formatter.parse(endDate??''));
    userNames = details?.projectDetailsMembers != null ? details!.projectDetailsMembers!.map((e) => e.name ?? '').toList() : [];
    userIds = details?.projectDetailsMembers != null ? details!.projectDetailsMembers!.map((e) => e.id ?? 0).toList() : [];
  }

  void initializeClient({required ProjectDetails details}){
    client = clientList != null ? clientList!.firstWhere((element) => element.id == details.projectOwner?.id) : null;
  }

  void disposeController(){
    projectNameController.clear();
    projectDescriptionController.clear();
    client = null;
    clearList();
    notifyListeners();
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

  ///clientList
  getCrmClientListData(String? search,{ ProjectDetails? details}) async {
    final response = await CrmClientRepository.getCrmClientList(reposearch: search);
    if (response.httpCode == 200) {
      clientList = response.data?.data?.clients;
      notifyListeners();
      initializeController(details: details);

    }
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




  ///selected client
  selectClient(Client clientValue) {
    client = clientValue;
    notifyListeners();
  }

  ///createProject
  Future createProject(context) async {
    final data = FormData.fromMap({
      "name": projectNameController.text,
      "description": projectDescriptionController.text,
      "start_date": dateRange?.start,
      "end_date": dateRange?.end,
      "client": client?.id,
      "membars": userIds.join(',')
    });

    final response = await CrmProjectRepository.addProject(data);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: "Project Created Successfully");
      NavUtil.replaceScreen(context, const ButtomNavigationBar());
      notifyListeners();
    }
  }


  ///updateProject
  Future updateProject(context, id) async {
    final data = FormData.fromMap({
      "id": id,
      "name": projectNameController.text,
      "description": projectDescriptionController.text,
      "start_date": dateRange?.start,
      "end_date": dateRange?.end,
      "client": client?.id,
      "membars": userIds.join(',')
    });

    final response = await CrmProjectRepository.updateProject(data);
    if (response['result'] == true) {
      NavUtil.replaceScreen(context, const ButtomNavigationBar());
      Fluttertoast.showToast(msg: "Project updated Successfully");
      notifyListeners();
    }
  }


 ///project delete
   projectDelete(id, context) async {
    final response = await CrmProjectRepository.projectDelete(projectId: id);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: "Project Deleted Successfully");
      NavUtil.replaceScreen(context,  MenuScreen());
      notifyListeners();
    }
  }


}

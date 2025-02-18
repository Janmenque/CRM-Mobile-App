import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/model/project_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CrmProjectListProvider extends ChangeNotifier {
  ProjectListModel? crmProjectListResponse;
  Timer? timeHnadle;
  String search = "";
  int page = 1;
  bool isError = false;
  late RefreshController refreshController ;
  final searchController = TextEditingController();

  List<Project> listOfProjects = <Project>[];

  CrmProjectListProvider() {
    refreshController = RefreshController(initialRefresh: true);
  }

  loadItems() {
    refreshController.requestRefresh();
    searchController.clear();
    search = '';
    page = 1;
    getCrmProjectListData();
    notifyListeners();
  }

  loadMoreItems() {
    page = page + 1;
    getCrmProjectListData();
    notifyListeners();
  }

  void setItems(List<Project> item) {
    listOfProjects.clear();
    listOfProjects = item;
    refreshController.refreshCompleted();
    isError = false;
    notifyListeners();
  }

  void setMoreItems(List<Project> item) {
    listOfProjects.addAll(item);
    refreshController.loadComplete();
    notifyListeners();
  }

  void getSearchValue(String searchCode) {
    search = searchCode;
    if (timeHnadle != null) {
      timeHnadle!.cancel();
    }
    timeHnadle = Timer(const Duration(seconds: 1), () {
      getCrmProjectListData();
    });
  }

  ///get projectList Data
  getCrmProjectListData() async {
    final response = await CrmProjectRepository.getCrmProjectListData(search, page);

    if (response.httpCode == 200) {
      if (response.data?.data?.data?.projects?.isNotEmpty == true) {
        if (page == 1) {
          setItems(response.data!.data!.data!.projects!);
          refreshController.loadComplete();
          notifyListeners();
        } else {
          setMoreItems(response.data!.data!.data!.projects!);
          notifyListeners();
        }
      }else{
        refreshController.loadNoData();
        notifyListeners();
      }
    }else{
      setFetchError();
    }
    notifyListeners();
  }

  setFetchError() {
    if (page == 0) {
      isError = true;
      refreshController.refreshFailed();
      notifyListeners();
    } else {
      refreshController.loadFailed();
      notifyListeners();
    }
  }
}

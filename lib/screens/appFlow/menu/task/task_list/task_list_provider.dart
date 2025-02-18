import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class CrmTaskListProvider extends ChangeNotifier {
  TaskListModel? crmTaskListResponse;
  Timer? timeHandle;
  String search = "";
  String? status;
  String? priority;
  late RefreshController refreshController;
  final searchController = TextEditingController();

  List<Task> listOfTask = <Task>[];
  int page = 1;
  bool isError = false;

  CrmTaskListProvider({String? statusId}) {
    status = statusId;
    refreshController = RefreshController(initialRefresh: true);
  }

  changeTaskStatus(id) {
    priority = id;
    page = 1;
    listOfTask.clear();
    getCrmTaskListData(status ?? '0', priorityId: priority);
    notifyListeners();
  }

  void getSearchValue(String searchCode) {
    page = 1;
    search = searchCode;
    if (timeHandle != null) {
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), () {
      getCrmTaskListData(status ?? '0', priorityId: priority,);
      notifyListeners();
    });
  }

  void updateTaskData({required int index, required Task task}) {
    crmTaskListResponse?.data?.taskListCollection?.tasks!.removeAt(index);
    crmTaskListResponse?.data?.taskListCollection?.tasks!.insert(index, task);
    notifyListeners();
  }

  getCrmTaskListData(String status, {String? priorityId}) async {
    final response = await CrmTaskRepository.getCrmTaskListData(status, search,page, taskStatusId: priorityId ?? '');
    if (response.httpCode == 200) {
      final data = response.data!.data!.taskListCollection!.tasks;
      if(data!.isNotEmpty){
        if (page == 1) {
          setItems(data);
          refreshController.loadComplete();
          notifyListeners();
        } else {
          setMoreItems(data);
          notifyListeners();
        }
      }else{
        refreshController.refreshCompleted();
        refreshController.loadNoData();
        notifyListeners();
      }
    }
    notifyListeners();
  }

  loadItems() {
    refreshController.requestRefresh();
    searchController.clear();
    search = '';
    page = 1;
    getCrmTaskListData(status ?? '0', priorityId: priority);
    notifyListeners();
  }

  loadMoreItems() {
    page = page + 1;
    getCrmTaskListData(status ?? '0', priorityId: priority);
    notifyListeners();
  }

  void setItems(List<Task> item) {
    listOfTask.clear();
    listOfTask = item;
    refreshController.refreshCompleted();
    isError = false;
    notifyListeners();
  }

  void setMoreItems(List<Task> item) {
    listOfTask.addAll(item);
    refreshController.loadComplete();
    notifyListeners();
  }
}

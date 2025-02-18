import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';

class CompleteTaskListProvider extends ChangeNotifier {
  TaskListModel? completeTaskListResponse;
  Timer? timeHandle;
  String search = "";
  String? status;
  String? priority;

  CompleteTaskListProvider({String? statusId}) {
    status = statusId;
    getCompleteTaskListData(status ?? '0', priorityId: priority);
  }

  changeTaskStatus(id) {
    priority = id;
    getCompleteTaskListData(status ?? '0', priorityId: priority);
    notifyListeners();
  }

  void getSearchValue(String searchCode) {
    search = searchCode;
    if (timeHandle != null) {
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), () {
      getCompleteTaskListData(status ?? '0', priorityId: priority);
      notifyListeners();
    });
  }

  getCompleteTaskListData(String status, {String? priorityId}) async {
    final response = await CrmTaskRepository.getCompleteTaskListData(status, search,
        taskStatusId: priorityId ?? '');
    if (response.httpCode == 200) {
      completeTaskListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }
}

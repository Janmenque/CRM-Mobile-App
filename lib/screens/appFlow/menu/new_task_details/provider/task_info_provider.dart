

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';



class TaskInfoProvider extends ChangeNotifier {
  TaskDetailsModel? crmTaskDetailsResponse;
  final commentController = TextEditingController();
  int? taskId;
  bool? isAdmin;

  /// when comment need to update
  int? commentId;
  var updateData;
  String? changedText;

  TaskInfoProvider(int id) {
    taskId = id;
    getCrmTaskDetails(id);
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      isAdmin = apiResponse.data?.data?.isAdmin;

      notifyListeners();
    }
  }

  getCrmTaskDetails(int? id) async {
    final response = await CrmTaskRepository.getCrmTaskDetailstdata(id);
    if (response.httpCode == 200) {
      crmTaskDetailsResponse = response.data;
      notifyListeners();
    }
  }


  taskDetailsInfo({required int index,required TaskDetails taskDetailsData,required CrmTaskListProvider taskListProvider}){
    Task taskListData = Task(
        id: taskDetailsData.id,
        title : taskDetailsData.title,
        members: taskDetailsData.members,
        dateRange: taskDetailsData.dateRange
    );
    taskListProvider.updateTaskData(index: index,task: taskListData, );
  }

  getTaskStatus(int? id, context) async {
    final response = await CrmTaskRepository.getTaskStatusCHangeData(id);
    if (response.httpCode == 200) {
      Fluttertoast.showToast(
          msg: "Task Status Updated successfully done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      await getCrmTaskDetails(id);
      Navigator.pop(context);
    }
    notifyListeners();
  }

  // Future feedbackComment(context) async {
  //   if (kDebugMode) {
  //     print('companyId $commentId');
  //   }
  //   if (commentId == null) {
  //     final data = FormData.fromMap(
  //         {"task_id": taskId, "comment": commentController.text});
  //     final response = await CrmTaskRepository.feedbackComment(data);
  //     if (response['result'] = true) {
  //       if (kDebugMode) {
  //         getCrmTaskDetails(taskId);
  //         commentController.clear();
  //         print("Successfully comment done");
  //       }
  //     }
  //     commentId = null;
  //     notifyListeners();
  //   } else {
  //     final response =
  //     await CrmTaskRepository.feedbackCommentUpdate(updataData);
  //     if (response['result'] = true) {
  //       if (kDebugMode) {
  //         getCrmTaskDetails(taskId);
  //         commentController.clear();
  //         print("Successfully comment done");
  //       }
  //     }
  //     commentId = null;
  //     notifyListeners();
  //   }
  // }
  //
  // editButton(Discussion? discussion) {
  //   commentController.text = discussion?.description ?? '';
  //   commentId = discussion?.id;
  //   updataData = FormData.fromMap({
  //     "comment_id": discussion!.id,
  //     "subject": discussion.subject,
  //     "comment": commentController.text
  //   });
  //   notifyListeners();
  // }
  //
  // Future taskDelete(id, context) async {
  //   final response = await CrmTaskRepository.taskDelete(taskId: id);
  //   if (response['result'] == true) {
  //     Fluttertoast.showToast(msg: "Task Deleted Successfully");
  //     NavUtil.replaceScreen(context, const TaskDashboardScreen());
  //     notifyListeners();
  //   }
  // }
  //
  // Future commentDelete(id) async {
  //   final response =
  //   await CrmTaskRepository.feedbackCommentDelete(commentId: id);
  //   if (response['result'] == true) {
  //     Fluttertoast.showToast(msg: response['message']);
  //     getCrmTaskDetails(taskId);
  //   }
  //   notifyListeners();
  // }
}

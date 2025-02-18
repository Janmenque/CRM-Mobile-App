import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_task_model/task_check_staff_list_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_checklist_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_comment_list_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_file_list_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_reminder_list_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_template_list_model.dart';
import 'package:hrm_app/data/model/crm_task_model/task_timer_list_model.dart';
import 'package:hrm_app/data/model/employee_model/employee_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/create_task_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_dashboard_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_status_model.dart';
import '../../../../../api_service/api_response.dart';
import '../../../../../api_service/api_service.dart';

class CrmTaskRepository {

  static Future<ApiResponse<TaskDashboardModel>> getCrmTaskHomeData() async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks");
      if (response.statusCode == 200) {
        var obj = taskDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = taskDashboardModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }

  ///getCrmTaskDetailsData
  static Future<ApiResponse<TaskDetailsModel>> getCrmTaskDetailstdata(int? id) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/tasks/details/$id");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm task details from repo......${response.data}");
        }
        var obj = taskDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = taskDetailsModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }


  ///task status change
  static Future<ApiResponse<TaskStatusModel>> getTaskStatusCHangeData(int? id) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .get("/app/tasks/change-status?task_id=$id&type=1&change_to=27");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(" task status change update from repo......${response.data}");
        }
        var obj = taskStatusModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskStatusModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = taskStatusModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }


  ///Complete Task list
  static Future<ApiResponse<TaskListModel>> getCompleteTaskListData(String status, String search, {String? taskStatusId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get(
          "/app/tasks/list?keyword=$search&status=27&priority=$taskStatusId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = taskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = taskListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }


  ///getCrmTaskCreateData
  static Future<ApiResponse<CreateTaskModel>> getCrmCreateTaskData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/tasks/create");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm create task  from repo......${response.data}");
        }
        var obj = createTaskModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = createTaskModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = createTaskModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }


  ///getCrmTaskUpdateData
  static Future<bool> updateTaskData(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response =
          await ApiService.getDio()!.post("/app/tasks/update", data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return true;

      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return false;
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return false;
      }
    }
  }



  ///create task post method
  static Future addTask(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/tasks/store', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }



////crmTaskList
  static Future<ApiResponse<TaskListModel>> getCrmTaskListData(String status, String search, int page, {String? taskStatusId}) async {
    try {
      var response = await ApiService.getDio()!.get(
          "/app/tasks/list?keyword=$search&status=26&priority=$taskStatusId&page=$page");
      if (response.statusCode == 200) {
        var obj = taskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = taskListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  /// feedBack comment method
  static Future feedbackComment(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!
          .post('/app/tasks/store-comment', data: data);
      EasyLoading.dismiss();
      var obj = response.data;
      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }



  /// feedBack comment method
  static Future feedbackCommentUpdate(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!
          .post('/app/tasks/update-comment', data: data);
      EasyLoading.dismiss();
      var obj = response.data;
      return obj;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }



  ///Task Delete method
  static Future taskDelete({int? taskId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response =
          await ApiService.getDio()!.get("/app/tasks/delete?task_id=$taskId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = response.data;

        return obj;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
      }
      return e.response;
    }
  }



  /// feedBack comment delete method
  static Future feedbackCommentDelete({int? commentId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .get("/app/tasks/delete-comment/$commentId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = response.data;
        return obj;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
      }
      return e.response;
    }
  }



  ///create task comment
  static Future createTaskComment(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/tasks/comments", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///TaskCommentList
  static Future<ApiResponse<TaskCommentListModel>> getTaskCommentListData(int taskId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks/comments?task_id=$taskId");
      if (response.statusCode == 200) {
        var obj = taskCommentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskCommentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = taskCommentListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///create task reminder
  static Future createTaskReminder(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/tasks/reminders", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }




  ///TaskReminderList
  static Future<ApiResponse<TaskReminderListModel>> getTaskReminderListData(int taskId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks/reminders?task_id=$taskId");
      if (response.statusCode == 200) {
        var obj = taskReminderListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskReminderListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = taskReminderListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///clientList
  static Future<ApiResponse<ClientListModel>> getCrmClientList() async {
    try {
      var response = await ApiService.getDio()!.get("/app/clients/list");
      if (response.statusCode == 200) {
        var obj = clientListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = clientListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = clientListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///TaskCheckList
  static Future<ApiResponse<TaskCheckListModel>> getTaskCheckListData(int taskId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks/checklists?task_id=$taskId");
      if (response.statusCode == 200) {
        var obj = taskCheckListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskCheckListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = taskCheckListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///taskCheck staff list
  static Future<ApiResponse<TaskCheckStaffListModel>> getTaskCheckStaffList(int taskId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks/checklist-staff?task_id=$taskId");
      if (response.statusCode == 200) {
        var obj = taskCheckStaffListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskCheckStaffListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = taskCheckStaffListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///taskCheck template list
  static Future<ApiResponse<TaskTemplateListModel>> getTaskTemplateList() async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks/templates");
      if (response.statusCode == 200) {
        var obj = taskTemplateListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskTemplateListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = taskTemplateListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }




  ///create task checklist
  static Future createTaskCheckList(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/tasks/checklists", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }




  ///TaskTimerList
  static Future<ApiResponse<TaskTimerListModel>> getTaskTimerListData(int taskId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks/timers?task_id=$taskId");
      if (response.statusCode == 200) {
        var obj = taskTimerListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskTimerListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = taskTimerListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///employee list
  static Future<ApiResponse<EmployeeListModel>> getEmployeeList() async {
    try {
      var response = await ApiService.getDio()!.get("/app/employees/list");
      if (response.statusCode == 200) {
        var obj = employeeListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = employeeListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = employeeListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///create task timer
  static Future createTaskTimer(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/tasks/timers", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///TaskFileList
  static Future<ApiResponse<TaskFileListModel>> getTaskFileListData(int taskId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/tasks/files?task_id=$taskId");
      if (response.statusCode == 200) {
        var obj = taskFileListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskFileListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = taskFileListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }



  ///create task file
  static Future createTaskFile(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/tasks/files", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return ApiResponse(
            httpCode: response.statusCode,
            result: response.data["result"],
            message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"]);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }

}


import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/crm_project/new_project_task_list_model.dart';
import 'package:hrm_app/data/model/crm_project/project_activity_list_model.dart';
import 'package:hrm_app/data/model/crm_project/project_details_overview_model.dart';
import 'package:hrm_app/data/model/crm_project/project_discussion_list_model.dart';
import 'package:hrm_app/data/model/crm_project/project_email_list_model.dart';
import 'package:hrm_app/data/model/crm_project/project_file_list_model.dart';
import 'package:hrm_app/data/model/crm_project/project_member_list_model.dart';
import 'package:hrm_app/data/model/crm_project/project_milestonelist_model.dart';
import 'package:hrm_app/data/model/crm_project/project_nole_list_model.dart';
import 'package:hrm_app/data/model/crm_project/project_task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/model/project_dashboard_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/model/project_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_status_model.dart';

import '../../../../../api_service/api_response.dart';
import '../../../../../api_service/api_service.dart';

class CrmProjectRepository{

  ///projectDashboardResponse
  static Future<ApiResponse<ProjectDashboardModel>> getCrmProjectHomeData() async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects");
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm project data......${response.data}");
        }
        var obj = projectDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectDashboardModelFromJson(e.response.toString());
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

 
///projectListResponse
 static Future<ApiResponse<ProjectListModel>> getCrmProjectListData(String? search,int? page) async {

  try{
    var response = await ApiService.getDio()!.get("/app/projects/list?keyword=$search&page=${page ?? 1}");
    if(response.statusCode == 200){
     if (kDebugMode) {
       print("crm project list data........${response.data}");
     }
     var obj = projectListModelFromJson(response.toString());
     return ApiResponse(
      httpCode: response.statusCode,
      result: obj.result,
      message: obj.message,
      data:obj
     ); 
    } else {
        var obj = projectListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
    }

  }
 on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectListModelFromJson(e.response.toString());
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


///createProject
///create project post method
 static  Future addProject(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post('/app/projects/store', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }


  ///update project
  static  Future updateProject(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post('/app/projects/update', data: data);
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
      Fluttertoast.showToast(msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }







  ///update task method

  ///getCrmTaskUpdateData
  static Future<bool> updateProjectData(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.post("/app/projects/update",data: data);
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



  ///project delete
  ///Task Delete method
  static Future projectDelete({int? projectId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response =
      await ApiService.getDio()!.get("/app/projects/delete/$projectId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
          return response.data;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
      }
      return e.response;
    }
  }



  ///projectDashboardResponse
  static Future<ApiResponse<ProjectOverviewDetailsModel>> getCrmProjectOverviewData(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/details/$projectId");
      if (response.statusCode == 200) {
        var obj = projectOverviewDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectOverviewDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectOverviewDetailsModelFromJson(e.response.toString());
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



  ///project status change
  static Future<ApiResponse<TaskStatusModel>> getProjectStatusCHandelData(int? id) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .get("/app/projects/complete?project_id=$id");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
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




  ///projectTaskList
  static Future<ApiResponse<NewProjectTaskListModel>> getCrmProjectTaskList(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/tasks/$projectId");
      if (response.statusCode == 200) {
        var obj = newProjectTaskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            data: obj);
      } else {
        var obj = newProjectTaskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = newProjectTaskListModelFromJson(e.response.toString());
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



  ///create  project Task
  static Future createProjectTask(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/tasks/store", data: formData);
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




  ///projectMilestoneList
  static Future<ApiResponse<ProjectMilestoneListModel>> getProjectMilestoneList(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/milestones?project_id=$projectId");
      if (response.statusCode == 200) {
        var obj = projectMilestoneListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectMilestoneListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectMilestoneListModelFromJson(e.response.toString());
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



  ///create project milestone
  static Future createProjectMilestone(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/projects/milestones", data: formData);
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



  ///projectEmailList
  static Future<ApiResponse<ProjectEmailListModel>> getProjectEmailList(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/send-email?project_id=$projectId");
      if (response.statusCode == 200) {
        var obj = projectEmailListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectEmailListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectEmailListModelFromJson(e.response.toString());
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



  ///create project email
  static Future createProjectEmail(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/projects/send-email", data: formData);
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



  ///projectFileList
  static Future<ApiResponse<ProjectFileListModel>> getCrmProjectFileList(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/files?project_id=$projectId");
      if (response.statusCode == 200) {
        var obj = projectFileListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectFileListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectFileListModelFromJson(e.response.toString());
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




  ///create project file
  static Future createProjectFile(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/projects/files", data: formData);
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



  ///projectFileList
  static Future<ApiResponse<ProjectDiscussionListModel>> projectDiscussionListModel(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/discussions?project_id=$projectId");
      if (response.statusCode == 200) {
        var obj = projectDiscussionListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectDiscussionListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectDiscussionListModelFromJson(e.response.toString());
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



  ///create project discussion
  static Future createProjectDiscussion(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/projects/discussions", data: formData);
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




  ///project note list
  static Future<ApiResponse<ProjectNoteListModel>> getProjectNoteListData(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/notes?project_id=$projectId");
      if (response.statusCode == 200) {
        var obj = projectNoteListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectNoteListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        //EasyLoading.dismiss();
        var obj = projectNoteListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        //EasyLoading.dismiss();
        if (kDebugMode) {
          debugPrint(e.message);
        }
        return ApiResponse(httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }




  ///create project note
  static Future createProjectNote(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/app/projects/notes", data: formData);
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



  ///remove project note
  static Future removeProjectNote(int noteId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.delete(
          "/app/projects/notes/delete/$noteId");
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




  ///project Activity List
  static Future<ApiResponse<ProjectActivityListModel>> getProjectActivityList(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/activities/$projectId");
      if (response.statusCode == 200) {
        var obj = projectActivityListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectActivityListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectActivityListModelFromJson(e.response.toString());
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




  ///projectMemberList
  static Future<ApiResponse<ProjectMemberListModel>> getProjectMemberList(int projectId) async {
    try {
      var response = await ApiService.getDio()!.get("/app/projects/members/$projectId");
      if (response.statusCode == 200) {
        var obj = projectMemberListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectMemberListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = projectMemberListModelFromJson(e.response.toString());
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




}
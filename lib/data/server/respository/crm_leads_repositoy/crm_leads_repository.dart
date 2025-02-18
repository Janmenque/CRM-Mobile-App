import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/crm_leads/lead_activity_list_model.dart';
import 'package:hrm_app/data/model/crm_leads/lead_note_list_model.dart';
import 'package:hrm_app/data/model/crm_leads/lead_reminder_list_model.dart';
import 'package:hrm_app/data/model/crm_leads/lead_tag_list_model.dart';
import 'package:hrm_app/data/model/crm_leads/lead_task_list_model.dart';
import 'package:hrm_app/data/model/crm_leads/leads_attachment_list_model.dart';
import 'package:hrm_app/data/model/crm_leads/leads_call_list_model.dart';
import 'package:hrm_app/data/model/crm_leads/leads_email_list_model.dart';
import 'package:hrm_app/data/model/crm_leads/leads_profile_view_model.dart';
import '../../../../api_service/api_response.dart';

class CrmLeadsRepository {

  /// get leads profile view
  static Future<ApiResponse<LeadsProfileViewModel>> getLeadsProfileView(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/profile");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadsProfileViewModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadsProfileViewModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadsProfileViewModelFromJson(e.response.toString());
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


  /// get leads attachment list
  static Future<ApiResponse<LeadsAttachmentListModel>> getLeadsAttachmentList(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/attachments");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadsAttachmentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadsAttachmentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadsAttachmentListModelFromJson(e.response.toString());
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


  ///add leads attachment
  static Future postLeadAttachment(formData, int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/lead/attachments/store/$leadId", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }


  ///get leads email list
  static Future<ApiResponse<LeadEmailListModel>> getLeadsEmailList(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/emails");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadEmailListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadEmailListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadEmailListModelFromJson(e.response.toString());
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


  ///send lead email
  static Future sendLeadEmail(formData, int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/lead/emails/store/$leadId", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }


  /// get leads call list
  static Future<ApiResponse<LeadCallListModel>> getLeadsCallList(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/calls");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadCallListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadCallListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadCallListModelFromJson(e.response.toString());
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


  ///create lead call
  static Future createLeadCall(formData, int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/lead/calls/store/$leadId", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }


  ///get leads activity list
  static Future<ApiResponse<LeadActivityListModel>> getLeadsActivityList(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/activities");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadActivityListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadActivityListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadActivityListModelFromJson(e.response.toString());
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


  ///get leads note list
  static Future<ApiResponse<LeadNoteListModel>> getLeadsNoteList(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/notes");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadNoteListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadNoteListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadNoteListModelFromJson(e.response.toString());
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


  ///create lead note
  static Future createLeadNote(formData, int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/lead/notes/store/$leadId", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }


  ///get leads task list
  static Future<ApiResponse<LeadTaskListModel>> getLeadTaskList(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/tasks");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadTaskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadTaskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadTaskListModelFromJson(e.response.toString());
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


  ///create lead task
  static Future createLeadTask(formData, int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/lead/tasks/store/$leadId", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }



  ///get leads reminder list
  static Future<ApiResponse<LeadReminderListModel>> getLeadsReminderList(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/reminders");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadReminderListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadReminderListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadReminderListModelFromJson(e.response.toString());
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


  ///create lead reminder
  static Future createLeadReminder(formData, int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/lead/reminders/store/$leadId", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }


  ///get leads tag list
  static Future<ApiResponse<LeadTagListModel>> getLeadsTagList(int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/lead/view/$leadId/tags");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = leadTagListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = leadTagListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = leadTagListModelFromJson(e.response.toString());
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


  ///create lead tag
  static Future createLeadTag(formData, int leadId) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/lead/tags/store/$leadId", data: formData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        return response.data;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

}
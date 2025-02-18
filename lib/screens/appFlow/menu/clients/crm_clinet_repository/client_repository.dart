import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/client_estimate/client_estimate_list_model.dart';
import 'package:hrm_app/data/model/client_expense/client_expense_category_list_model.dart';
import 'package:hrm_app/data/model/client_expense/client_expense_list-model.dart';
import 'package:hrm_app/data/model/client_invoice/client_invoice_list_model.dart';
import 'package:hrm_app/data/model/client_invoice/client_invoice_product_list.dart';
import 'package:hrm_app/data/model/client_invoice/client_invoice_warehouse_list_model.dart';
import 'package:hrm_app/data/model/client_payment_list_model.dart';
import 'package:hrm_app/data/model/client_project_list_model.dart';
import 'package:hrm_app/data/model/client_proposal/client_proposal_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/client_contact_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/client_contract_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/client_file_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/client_note_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/client_profile_details_model.dart';
import 'package:hrm_app/data/model/crm_client_model/client_reminder_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/client_task_list_model.dart';
import 'package:hrm_app/data/model/crm_client_model/new_client_tasklist_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_dashboard_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/deal_list_model.dart';
import '../../../../../api_service/api_response.dart';
import '../../../../../api_service/api_service.dart';
import '../model/project_details_model.dart';

class CrmClientRepository{

   static Future<ApiResponse<ClientDashboardModel>> getCrmClientHomeData() async {
    try {
      var response = await ApiService.getDio()!.get("/app/clients");
      if (response.statusCode == 200) {
        var obj = clientDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = clientDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
       //EasyLoading.dismiss();
        var obj = clientDashboardModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        if (kDebugMode) {
          debugPrint(e.message);
        }
        return ApiResponse(httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }


///addClient
  static Future addClient(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/clients/store', data: data);
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
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }

  ///clientList
   static Future<ApiResponse<ClientListModel>> getCrmClientList({String? reposearch}) async {
    try {
      var response = await ApiService.getDio()!.get("/app/clients/list?keyword=$reposearch");
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


///updateClient
  static Future updateClient(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/clients/update', data: data);
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


///client delete
///Task Delete method
  static Future clientDelete(
      int? clientId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/clients/delete/$clientId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = response.data;
        return obj;
      }
    } on DioError catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
      }
      return e.response;
    }
  }



   ///clentDealList
   static Future<ApiResponse<DealListModel>> getClientDealList({int? id, String? search}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/clients/projects-list/$id?keyword=$search");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = dealListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = dealListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        var obj = dealListModelFromJson(e.response.toString());
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



  ///clientDetails
   static Future<ApiResponse<ClientDetailsModel>> getCrmClientDetailLstData(int? id) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/clients/details?id=$id");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = clientDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = clientDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = clientDetailsModelFromJson(e.response.toString());
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



   ///projectDetails
   static Future<ApiResponse<ProjectDetailsModel>> getProjectDetailsData({required int? id}) async {
     try {
       EasyLoading.show(status: 'loading...');
       var response = await ApiService.getDio()!.get("/app/projects/details/$id");
       EasyLoading.dismiss();
       if (response.statusCode == 200) {
         final obj = projectDetailsModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = projectDetailsModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         EasyLoading.dismiss();
         var obj = projectDetailsModelFromJson(e.response.toString());
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




   ///client contract list
   static Future<ApiResponse<ClientContactListModel>> getClientContactListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/contacts?client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientContactListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientContactListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         var obj = clientContactListModelFromJson(e.response.toString());
         return ApiResponse(
             httpCode: e.response!.statusCode,
             result: e.response!.data["result"],
             message: e.response!.data["message"],
             error: obj);
       } else {
         if (kDebugMode) {
           debugPrint(e.message);
         }
         return ApiResponse(httpCode: -1, message: "Connection error ${e.message}");
       }
     }
   }




   ///client profile details
   static Future<ApiResponse<ClientProfileDetailsModel>> getClientProfileDetailsData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/profile/$clientId");
       if (response.statusCode == 200) {
         var obj = clientProfileDetailsModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientProfileDetailsModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         var obj = clientProfileDetailsModelFromJson(e.response.toString());
         return ApiResponse(
             httpCode: e.response!.statusCode,
             result: e.response!.data["result"],
             message: e.response!.data["message"],
             error: obj);
       } else {
         if (kDebugMode) {
           debugPrint(e.message);
         }
         return ApiResponse(httpCode: -1, message: "Connection error ${e.message}");
       }
     }
   }



   ///create client address type
   static Future createClientAddressType(formData,) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/clients/address", data: formData);
       EasyLoading.dismiss();
       if (response.statusCode == 200) {
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



   ///add contract client
   static Future postContractClient(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response = await ApiService.getDio()!.post("/app/clients/contacts", data: formData);
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



   ///client note list
   static Future<ApiResponse<ClientNoteListModel>> getClientNoteListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/notes?client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientNoteListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientNoteListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientNoteListModelFromJson(e.response.toString());
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



   ///create client note
   static Future createClientNote(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/clients/notes", data: formData);
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



   ///remove client note
   static Future removeClientNote(int noteId) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.delete("/app/clients/notes/$noteId");
       EasyLoading.dismiss();
       if (response.statusCode == 200) {
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



   ///client contract list
   static Future<ApiResponse<ClientContractListModel>> getClientContractListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/contract/get-list?client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientContractListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientContractListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         var obj = clientContractListModelFromJson(e.response.toString());
         return ApiResponse(
             httpCode: e.response!.statusCode,
             result: e.response!.data["result"],
             message: e.response!.data["message"],
             error: obj);
       } else {
         if (kDebugMode) {
           debugPrint(e.message);
         }
         return ApiResponse(httpCode: -1, message: "Connection error ${e.message}");
       }
     }
   }



   ///client file list
   static Future<ApiResponse<ClientFileListModel>> getClientFileListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/files?client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientFileListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientFileListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         var obj = clientFileListModelFromJson(e.response.toString());
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



   ///create client file
   static Future createClientFile(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/clients/files", data: formData);
       EasyLoading.dismiss();
       if (response.statusCode == 200) {
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



   ///client reminder list
   static Future<ApiResponse<ClientReminderListModel>> getClientReminderListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/reminders?client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientReminderListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientReminderListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientReminderListModelFromJson(e.response.toString());
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



   ///create client reminder
   static Future createClientReminder(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/clients/reminders", data: formData);
       EasyLoading.dismiss();
       if (response.statusCode == 200) {
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



   ///client project list
   static Future<ApiResponse<ClientProjectListModel>> getClientProjectListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/projects/list?client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientProjectListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientProjectListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientProjectListModelFromJson(e.response.toString());
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



   ///create client project
   static Future createClientProject(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/projects/store", data: formData);
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



   ///client task list
   static Future<ApiResponse<NewClientTaskListModel>> getClientTaskListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/task-list/$clientId");
       if (response.statusCode == 200) {
         var obj = newClientTaskListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,

             data: obj);
       } else {
         var obj = newClientTaskListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         var obj = newClientTaskListModelFromJson(e.response.toString());
         return ApiResponse(
             httpCode: e.response!.statusCode,
             result: e.response!.data["result"],
             message: e.response!.data["message"],
            );
       } else {
         if (kDebugMode) {
           debugPrint(e.message);
         }
         return ApiResponse(httpCode: -1, message: "Connection error ${e.message}");
       }
     }
   }



   ///create client project
   static Future createClientTask(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/tasks/store", data: formData);
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



   ///client invoice list
   static Future<ApiResponse<ClientInvoiceListModel>> getClientInvoiceListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/invoice?type=invoice&client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientInvoiceListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientInvoiceListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientInvoiceListModelFromJson(e.response.toString());
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



   ///client invoice warehouse list
   static Future<ApiResponse<ClientInvoiceWarehouseListModel>> getClientInvoiceWarehouseListData() async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/invoice/warehouses");
       if (response.statusCode == 200) {
         var obj = clientInvoiceWarehouseListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientInvoiceWarehouseListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientInvoiceWarehouseListModelFromJson(e.response.toString());
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



   ///client invoice product list
   static Future<ApiResponse<ClientInvoiceProductListModel>> getClientInvoiceProductListData(int warehouseId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/invoice/products?warehouse_id=$warehouseId");
       if (response.statusCode == 200) {
         var obj = clientInvoiceProductListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientInvoiceProductListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientInvoiceProductListModelFromJson(e.response.toString());
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



   ///create client invoice
   static Future createClientInvoice(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/clients/invoice", data: formData);
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



   ///client payment list
   static Future<ApiResponse<ClientInvoicePaymentListModel>> getClientPaymentListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/invoice/payments?client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientInvoicePaymentListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientInvoicePaymentListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         var obj = clientInvoicePaymentListModelFromJson(e.response.toString());
         return ApiResponse(
             httpCode: e.response!.statusCode,
             result: e.response!.data["result"],
             message: e.response!.data["message"],
             error: obj);
       } else {
         if (kDebugMode) {
           debugPrint(e.message);
         }
         return ApiResponse(httpCode: -1, message: "Connection error ${e.message}");
       }
     }
   }




   ///create client proposal
   static Future createClientProposal(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/clients/invoice", data: formData);
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



   ///client proposal list
   static Future<ApiResponse<ClientProposalListModel>> getClientProposalListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/invoice?type=proposal&client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientProposalListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientProposalListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientProposalListModelFromJson(e.response.toString());
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




   ///create client estimate
   static Future createClientEstimate(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/app/clients/invoice", data: formData);
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



   ///client estimate list
   static Future<ApiResponse<ClientEstimateListModel>> getClientEstimateListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.get("/app/clients/invoice?type=estimate&client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientEstimateListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientEstimateListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientEstimateListModelFromJson(e.response.toString());
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



   ///client expense list
   static Future<ApiResponse<ClientExpenseListModel>> getClientExpenseListData(int clientId) async {
     try {
       var response = await ApiService.getDio()!.post("/expense/list?client_id=$clientId");
       if (response.statusCode == 200) {
         var obj = clientExpenseListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientExpenseListModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientExpenseListModelFromJson(e.response.toString());
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




   ///client expense category list
   static Future<ApiResponse<ClientExpenseCategoryList>> getClientExpenseCategoryListData() async {
     try {
       var response = await ApiService.getDio()!.get("/expense/category");
       if (response.statusCode == 200) {
         var obj = clientExpenseCategoryListFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = clientExpenseCategoryListFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioException catch (e) {
       if (e.type == DioExceptionType.badResponse) {
         //EasyLoading.dismiss();
         var obj = clientExpenseCategoryListFromJson(e.response.toString());
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



   ///create client expense
   static Future createClientExpense(formData) async {
     try {
       EasyLoading.show(status: 'loading...');
       final response =
       await ApiService.getDio()!.post("/expense/add", data: formData);
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
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/crm_contract/all_contract_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/contract_attachment_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/contract_comment_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/contract_item_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/contract_note_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/contract_renewal_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/contract_template_list_model.dart';
import 'package:hrm_app/data/model/crm_contract/crm_create_contract_component.dart';

class CrmContractRepository {

  ///crm all contract list
  static Future<ApiResponse<AllContractListModel>> getAllContractListData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/contract/get-list");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = allContractListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = allContractListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = allContractListModelFromJson(e.response.toString());
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



  ///add Contract
  static Future postAddContract(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/contract/store", data: formData);
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



  ///crm contract type list
  static Future<ApiResponse<CrmCreateContractComponent>> getContractAllComponentListData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/contract/components");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = crmCreateContractComponentFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = crmCreateContractComponentFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = crmCreateContractComponentFromJson(e.response.toString());
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



  ///add Contract type
  static Future postAddContractType(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/contract/type", data: formData);
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



  ///contract attachment list
  static Future<ApiResponse<ContractAttachmentListModel>> getContractAttachmentListData(int contractId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/contract/detail/$contractId?attachments");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = contractAttachmentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = contractAttachmentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = contractAttachmentListModelFromJson(e.response.toString());
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



  ///add contract attachment
  static Future postAddAttachment(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/contract/attachement", data: formData);
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



  ///contract comment list
  static Future<ApiResponse<ContractCommentListModel>> getContractCommentListData(int contractId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/contract/detail/$contractId?comments");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = contractCommentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = contractCommentListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = contractCommentListModelFromJson(e.response.toString());
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



  ///add contract comment
  static Future postAddComment(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/contract/comment", data: formData);
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



  ///contract renewal list
  static Future<ApiResponse<ContractRenewalsListModel>> getContractRenewalListData(int contractId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/contract/detail/$contractId?renewals");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = contractRenewalsListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = contractRenewalsListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = contractRenewalsListModelFromJson(e.response.toString());
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



  ///add contract Renewal
  static Future postAddRenewal(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/contract/renew", data: formData);
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



  ///contract note list
  static Future<ApiResponse<ContractNoteListModel>> getContractNoteListData(int contractId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/contract/detail/$contractId?notes");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = contractNoteListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = contractNoteListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = contractNoteListModelFromJson(e.response.toString());
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



  ///add contract note
  static Future postAddNote(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/contract/note", data: formData);
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



  ///contract template list
  static Future<ApiResponse<ContractTemplateListModel>> getContractTemplateListData(int contractId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/contract/detail/$contractId?templates");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = contractTemplateListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = contractTemplateListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = contractTemplateListModelFromJson(e.response.toString());
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



  ///add contract template
  static Future postAddTemplate(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!.post("/contract/template", data: formData);
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



  ///contract item list
  static Future<ApiResponse<ContractItemListModel>> getContractItemListData(int contractId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/contract/detail/$contractId?items");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var obj = contractItemListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = contractItemListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = contractItemListModelFromJson(e.response.toString());
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


  ///add item
  static Future postAddItem(formData) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post("/contract/item", data: formData);
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
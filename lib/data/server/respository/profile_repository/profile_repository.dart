import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrm_app/api_service/api_body.dart';
import 'package:hrm_app/api_service/api_response.dart';
import 'package:hrm_app/api_service/api_service.dart';
import 'package:hrm_app/data/model/response_blood_group.dart';
import 'package:hrm_app/data/model/response_department_list.dart';
import 'package:hrm_app/data/model/response_designation_list.dart';
import 'package:hrm_app/data/model/response_edit_emergency.dart';
import 'package:hrm_app/data/model/response_edit_financial.dart';
import 'package:hrm_app/data/model/response_edit_personal_info.dart';
import 'package:hrm_app/data/model/response_emergency.dart';
import 'package:hrm_app/data/model/response_employment_type.dart';
import 'package:hrm_app/data/model/response_financial.dart';
import 'package:hrm_app/data/model/response_manager_list.dart';
import 'package:hrm_app/data/model/response_offical_info.dart';
import 'package:hrm_app/data/model/response_personal.dart';
import 'package:hrm_app/data/model/response_profile_image.dart';
import 'package:hrm_app/data/model/response_update_official_info.dart';

class ProfileRepository {

  /// getOfficialInfo API -----------------
  static Future<ApiResponse<ResponseOfficialInfo>> getOfficialInfo(
      BodyUserId bodyUserId, String slugName) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/profile/$slugName", data: bodyUserId);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseOfficialInfoFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseOfficialInfoFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseOfficialInfoFromJson(e.response.toString());
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

  /// getPersonalInfo API -----------------
  static Future<ApiResponse<ResponsePersonal>> getPersonalInfo(
      BodyUserId bodyUserId, String slugName) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/profile/$slugName", data: bodyUserId);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responsePersonalFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responsePersonalFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responsePersonalFromJson(e.response.toString());
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

  /// getFinancialInfo API -----------------
  static Future<ApiResponse<ResponseFinancial>> getFinancialInfo(
      BodyUserId bodyUserId, String slugName) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/profile/$slugName", data: bodyUserId);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseFinancialFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseFinancialFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseFinancialFromJson(e.response.toString());
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

  /// getEmergencyInfo API -----------------
  static Future<ApiResponse<ResponseEmergency>> getEmergencyInfo(
      BodyUserId bodyUserId, String slugName) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/profile/$slugName", data: bodyUserId);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseEmergencyFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseEmergencyFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseEmergencyFromJson(e.response.toString());
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

  /// getManagerList API -----------------
  static Future<ApiResponse<ResponseManagerList>> getManagerList() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/get-manager");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseManagerListFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseManagerListFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseManagerListFromJson(e.response.toString());
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

  /// getBloodGroupList API -----------------
  static Future<ApiResponse<ResponseBloodGroup>> getBloodGroup() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/get-blood-group");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseBloodGroupFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseBloodGroupFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseBloodGroupFromJson(e.response.toString());
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

  /// getDepartmentList API -----------------
  static Future<ApiResponse<ResponseDepartment>> getDepartmentList() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/get-department");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseDepartmentFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseDepartmentFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseDepartmentFromJson(e.response.toString());
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

  /// getDesignationList API -----------------
  static Future<ApiResponse<ResponseDesignation>> getDesignationList() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/get-designation");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseDesignationFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseDesignationFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseDesignationFromJson(e.response.toString());
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

  /// getEmploymentTypeList API -----------------
  static Future<ApiResponse<ResponseEmploymentType>>
  getEmploymentTypeList() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/get-employment-type");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseEmploymentTypeFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseEmploymentTypeFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseEmploymentTypeFromJson(e.response.toString());
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

  /// updateOfficialInfo API -----------------
  static Future<ApiResponse<ResponseUpdateOfficalInfo>> updateOfficialInfo(
      BodyEditOfficialInfo bodyEditOfficialInfo) async {
    if (kDebugMode) {
      print(bodyEditOfficialInfo);
    }
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/profile/update/official", data: bodyEditOfficialInfo);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseUpdateOfficalInfoFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseUpdateOfficalInfoFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseUpdateOfficalInfoFromJson(e.response.toString());
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

  /// updatePersonalInfo API -----------------
  static Future<ApiResponse<ResponseEditPersonalInfo>> updateEditPersonalInfo(
      int? userId,
      String? gender,
      String? phone,
      String? birthDate,
      String? address,
      String? nationality,
      String? nidCardNumber,
      File? nidFile,
      String? passportNumber,
      File? passportFile,
      String? bloodGroup,
      String? linkedinLink,
      String? facebookLink,
      String? instagramLink) async {
    var fileNameNid = nidFile?.path.split('/').last;
    var fileNamePassport = passportFile?.path.split('/').last;

    var fromData = FormData.fromMap({
      "user_id": userId,
      "gender": gender,
      "phone": phone,
      "birth_date": birthDate,
      "address": address,
      "nationality": nationality,
      "nid_card_number": nidCardNumber,
      "nid_file": nidFile?.path != null
          ? await MultipartFile.fromFile(nidFile!.path, filename: fileNameNid)
          : null,
      "passport_number": passportNumber,
      "passport_file": passportFile?.path != null
          ? await MultipartFile.fromFile(passportFile!.path,
          filename: fileNamePassport)
          : null,
      "blood_group": bloodGroup,
      "linkedin_link": linkedinLink,
      "facebook_link": facebookLink,
      "instagram_link": instagramLink,
    });

    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/profile/update/personal", data: fromData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseEditPersonalInfoFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseEditPersonalInfoFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseEditPersonalInfoFromJson(e.response.toString());
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

  /// updateProfileImage API -----------------
  static Future<ApiResponse<ResponseProfileImage>> updateProfileImage(
      int? userId, File? file) async {
    var fileName = file!.path.split('/').last;
    var fromData = FormData.fromMap({
      "user_id": userId,
      "avatar": await MultipartFile.fromFile(file.path, filename: fileName)
    });
    if (kDebugMode) {
      print(fromData);
    }
    try {
      EasyLoading.show(status: 'Uploading...');
      var response = await ApiService.getDio()!
          .post("/user/avatar-update?avatar", data: fromData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseProfileImageFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseProfileImageFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseProfileImageFromJson(e.response.toString());
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

  /// updateEditEmergencyInfo API -----------------
  static Future<ApiResponse<ResponseEditEmergency>> updateEditEmergencyInfo(
      BodyEditEmergencyInfo bodyEditEmergencyInfo) async {
    if (kDebugMode) {
      print(bodyEditEmergencyInfo);
    }
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/profile/update/emergency", data: bodyEditEmergencyInfo);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseEditEmergencyFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseEditEmergencyFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseEditEmergencyFromJson(e.response.toString());
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

  /// updateEditFinancialInfo API -----------------
  static Future<ApiResponse<ResponseEditFinancial>> updateEditFinancialInfo(
      BodyEditFinancialInfo bodyEditFinancialInfo) async {
    if (kDebugMode) {
      print(bodyEditFinancialInfo);
    }
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .post("/user/profile/update/financial", data: bodyEditFinancialInfo);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        var obj = responseEditFinancialFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = responseEditFinancialFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        EasyLoading.dismiss();
        var obj = responseEditFinancialFromJson(e.response.toString());
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

}